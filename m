Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED25733FEE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 11:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344851AbjFQJrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 05:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjFQJrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 05:47:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BB110CF;
        Sat, 17 Jun 2023 02:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9EE760A2C;
        Sat, 17 Jun 2023 09:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24C7C433C0;
        Sat, 17 Jun 2023 09:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686995222;
        bh=d9JppF1OB3clmSKXHuYWpmtIhrX7ndE0udMJPpQlMlk=;
        h=From:To:Cc:Subject:Date:From;
        b=aeWrP8MlUoLe1DnJN6pO6cV0x6syd1Vrx+dpfkFANqLKPQESkm4+06wJ/FU9q2jeD
         y5AfAUpTLzeNVUYGzJdRdM0xZAnVR2F7fkHMfD0Fit2qQyPIiOsS1id/ylFOc9tjuX
         hMlt3Q0Os3bahFQ4KRnPqVWqbAM/bbfritHI6bHF5BOG9g5L1IYXx0FPL54DWZH8Mr
         niVfIwyzSz/UylzwuPFy0PLIwp0VbK8x7AkXCIrobwk9LvyhRC4KUTNjCkbAhoj58B
         MpKTnRtV958fyRVALytHECE0s+4nvGcJfCG+WUta9AnzjaunUZuuYOypxGyfTpZV5A
         dYq5ahJfXaSzw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        bpf@vger.kernel.org
Subject: [PATCH 0/5] tracing: Improbe BTF support on probe events
Date:   Sat, 17 Jun 2023 18:46:58 +0900
Message-ID:  <168699521817.528797.13179901018528120324.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a seires of patches to improve the BTF support on probe events.

In the previous series, I introduced BTF based function argument support.
This series focuses on accessing data structure fields and string type
checking. Here is the list of the patches.

- [1/5] Add data field access support from BTF args.
- [2/5] Add data field access support from retval.
- [3/5] "string" type checks the BTF type and add dereference
        automatically.
- [4/5] Update testcases
- [5/5] Update documents

With this series, you can trace information from function entry/exit and
tracepoints. For example, you can get information about data structures
that are not exposed to user space (via traceevent), or find out what
the data in the data structure pointed by the return value of a function
was.
This was previously possible with the `perf probe` command, but with BTF
you can do it with just tracefs. (Of course `perf probe` is still useful
for debugging kernel with tracing function body or where any tracepoint
is not provided.)

Example:

 # echo 'f getname_flags%return retval->name:string' > dynamic_events
 # echo 1 > events/fprobes/getname_flags__exit/enable
 # ls > /dev/null
 # head -n 40 trace | tail
              ls-87      [000] ...1.  8067.616101: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./function_profile_enabled"
              ls-87      [000] ...1.  8067.616108: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./trace_stat"
              ls-87      [000] ...1.  8067.616115: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_graph_notrace"
              ls-87      [000] ...1.  8067.616122: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_graph_function"
              ls-87      [000] ...1.  8067.616129: getname_flags__exit: (vfs_fstatat+0x3c/0x70 <- getname_flags) arg1="./set_ftrace_notrace"


This series can be applied on top of "probes/core" branch of the
linux-trace.git.

You can also get this series from:

git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext


Thank you,

---

Masami Hiramatsu (Google) (5):
      tracing/probes: Support BTF based data structure field access
      tracing/probes: Support BTF field access from retval
      tracing/probes: Add string type check with BTF
      selftests/ftrace: Add BTF fields access testcases
      Documentation: tracing: Update fprobe event example with BTF field


 Documentation/trace/fprobetrace.rst                |   50 ++-
 kernel/trace/trace_probe.c                         |  347 ++++++++++++++++++--
 kernel/trace/trace_probe.h                         |   19 +
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   11 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 
 5 files changed, 376 insertions(+), 55 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
