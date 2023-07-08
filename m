Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6B674BB77
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 04:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjGHCsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 22:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGHCsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 22:48:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7532FC9;
        Fri,  7 Jul 2023 19:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 131D661AD8;
        Sat,  8 Jul 2023 02:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D688C433C7;
        Sat,  8 Jul 2023 02:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688784508;
        bh=OFgQvHFx6RMj137byhZyTysi7H9gyOX5KQzGa5wUhmA=;
        h=From:To:Cc:Subject:Date:From;
        b=IApqL/I/c5fj1mqdS+fq65yAAz1/XBpssqSKngvwfebXxoVP02lvjVUdXGZtk7znR
         Dx3rjjve6iUEA4HkS6Yo7jsJ56dT3RWO8dDZxQt9N9ucZU17avJSxjdCJGi1eitsYE
         C9R6pR2RV9+A/zA/fdIERhHQm1mbFQgAZNT3fNu6M2QuizC0GUJn/4cGeSxb6cighQ
         xgrZ0eFOEyNextrBRk1QqU9amivmTOqussHirUQW1uyVefaddXgMEagFluQmerlvXX
         jh4TPxKYLeD16GzY23cFdIYS3RLE+wbyxLdBpbu6B5KzzEPtE5PEZqo32/k08WKYlt
         0FbdzSm99PIdg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 0/4] tracing/probes: Fix bugs in process_fetch_insn
Date:   Sat,  8 Jul 2023 11:48:23 +0900
Message-ID:  <168878450334.2721251.3030778817503575503.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
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

Here are the 3rd version of fix bugs in process_fetch_insn_*().
The previous version is here;

https://lore.kernel.org/all/168873724526.2687993.15242662075324919195.stgit@mhiramat.roam.corp.google.com/

[3/4] is updated to move FAULT_STRING macro to trace_probe.h
and use it in trace_probe.c instead of "(fault)".

Thank you,

---

Masami Hiramatsu (Google) (4):
      tracing/probes: Fix to avoid double count of the string length on the array
      tracing/probes: Fix not to count error code to total length
      Revert "tracing: Add "(fault)" name injection to kernel probes"
      tracing/probes: Fix to record 0-length data_loc in fetch_store_string*() if fails


 kernel/trace/trace.h              |    2 ++
 kernel/trace/trace_probe.c        |    2 +-
 kernel/trace/trace_probe_kernel.h |   29 ++++-------------------------
 kernel/trace/trace_probe_tmpl.h   |   10 +++++-----
 kernel/trace/trace_uprobe.c       |    3 ++-
 5 files changed, 14 insertions(+), 32 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
