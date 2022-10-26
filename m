Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0F060DE23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiJZJeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiJZJeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:34:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0951B7EFF;
        Wed, 26 Oct 2022 02:34:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B0A561DA6;
        Wed, 26 Oct 2022 09:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDC7C433D7;
        Wed, 26 Oct 2022 09:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666776843;
        bh=NPqoyo2EOn4aFcP88D3R4mf2259jJE0zw9hk+fICw9E=;
        h=From:To:Cc:Subject:Date:From;
        b=FHcMQU7pIFlCwU2b4+gB2ve/oe8vyzuXJa38tiAiy29WUvF03Pm0srnEXSbM0bKrk
         J/jb+18H9g1erUgvRMBNYNYfFU9/7NaG9OQErAkqU4xpa36Rcb6yZPQyMDJYA0TimS
         BKFZvYQCsmhu+8g51+SU95K1R/372Sia1mY2UQAri4D3V0jcpSJa+8qqoY/yQ9E+ra
         ZXlWWpaHR3u2pz2sEv6CYchNWaWt6nL8cAHjMLE6xGewdHuhLPFXqbuEHcNd6R9je8
         lWNoGUwl0Okev4lpeL7bxHRKPwjBKlLXNfHMtVy7+M+gA4NMbt+hmG1sY1tlzVpWrM
         ah+/RdR/qIg+w==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2] tracing/fprobe: Fix to check whether fprobe is registered correctly
Date:   Wed, 26 Oct 2022 18:33:59 +0900
Message-Id: <166677683946.1459107.15997653945538644683.stgit@devnote3>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since commit ab51e15d535e ("fprobe: Introduce FPROBE_FL_KPROBE_SHARED flag
for fprobe") introduced fprobe_kprobe_handler() for fprobe::ops::func,
unregister_fprobe() fails to unregister the registered if user specifies
FPROBE_FL_KPROBE_SHARED flag.
Moreover, __register_ftrace_function() is possible to change the
ftrace_ops::func, thus we have to check fprobe::ops::saved_func instead.

To check it correctly, it should confirm the fprobe::ops::saved_func is
either fprobe_handler() or fprobe_kprobe_handler().

Fixes: cad9931f64dc ("fprobe: Add ftrace based probe APIs")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 71614b2a67ff..e8143e368074 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -303,7 +303,8 @@ int unregister_fprobe(struct fprobe *fp)
 {
 	int ret;
 
-	if (!fp || fp->ops.func != fprobe_handler)
+	if (!fp || (fp->ops.saved_func != fprobe_handler &&
+		    fp->ops.saved_func != fprobe_kprobe_handler))
 		return -EINVAL;
 
 	/*

