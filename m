Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E15C74F173
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjGKOPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjGKOPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:15:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D4310CA;
        Tue, 11 Jul 2023 07:15:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F01F6150D;
        Tue, 11 Jul 2023 14:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752B0C433C7;
        Tue, 11 Jul 2023 14:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689084923;
        bh=cIy8UJKyW+i91CeK7GRZIRW1tqMWTPGd4NNt66u0izE=;
        h=From:To:Cc:Subject:Date:From;
        b=PRU6dnefVzucgY6XQifRJ7SLzKvi3Q8XmlkpW322Oye94VY48ZWlKHCIJ2E8Cn6+d
         vjJfX+8qrgmjgIJQ/V7KobLLToQcrWyyDKizHv3Im2pC8YhcOxOL1nNfwFhB29Nxu+
         SoQDul37BxGxIRfp19IC8+ySNUEf5qML4tHd5k6yib8baAxiHalgZAup+1nzyyPCZb
         oP8fqo4UgjmK/i9uVORMRtt0qCYPpXrsPLZJscwwiUd9SeyY5Vu3YAeWp5LWqX6Vym
         K+pso9n92AAuxQvAFWoLDuyZtkzBzEw5lAyRhkkXMpH1HW196HbA8snBYW/+3G6F8G
         /GQEQyKerLIDw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v5 0/5] tracing/probes: Fix bugs in process_fetch_insn
Date:   Tue, 11 Jul 2023 23:15:20 +0900
Message-Id: <168908491977.123124.16583481716284477889.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the 5th version of fix bugs in process_fetch_insn_*().
The previous version is here;

https://lore.kernel.org/all/168904147563.2908673.18054267804278861545.stgit@mhiramat.roam.corp.google.com/

In this version I added a bugfix to update dynamic data counter only
if the fetcharg uses it [3/5] and update [5/5] to move out the arg->dynamic
check out from unlikely() macro and use likely() macro correctly for
non-error case.

Thank you,

---

Masami Hiramatsu (Google) (5):
      tracing/probes: Fix to avoid double count of the string length on the array
      tracing/probes: Fix not to count error code to total length
      tracing/probes: Fix to update dynamic data counter if fetcharg uses it
      Revert "tracing: Add "(fault)" name injection to kernel probes"
      tracing/probes: Fix to record 0-length data_loc in fetch_store_string*() if fails


 kernel/trace/trace.h              |    2 ++
 kernel/trace/trace_probe.c        |    2 +-
 kernel/trace/trace_probe_kernel.h |   30 ++++++++----------------------
 kernel/trace/trace_probe_tmpl.h   |   10 +++++-----
 kernel/trace/trace_uprobe.c       |    3 ++-
 5 files changed, 18 insertions(+), 29 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
