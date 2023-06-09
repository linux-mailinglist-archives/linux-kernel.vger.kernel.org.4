Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E49D729247
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbjFIIIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240104AbjFIIHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:07:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D55A3A84;
        Fri,  9 Jun 2023 01:07:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C9A261AA8;
        Fri,  9 Jun 2023 08:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC09C433EF;
        Fri,  9 Jun 2023 08:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298029;
        bh=WkpNk0rI0ZwQDVMOXz+3VugeUmJZxZ2Bg9yb6RLZeCw=;
        h=From:To:Cc:Subject:Date:From;
        b=EFCZKNfng2goc1Z1ZRGcWxcqx3eHb+gRDWB+6+PDgbydcb0N9/J+EsN5S5Wc4jNh0
         /v9qM0oPw5w9Ftg1LW5xcthwxjKf2mzBgTreU1X55aL/cdtwrmP8ZzBkvCewAAAShx
         olu0mQE9up7Di1cDzvGPEejzOtqwofCyugd2zRkD3HWrZ2l/ALvPN8I2EotAyxcLNt
         dXdKaawOXnO24E11/LYKSZGP3jNnq1/QrHONrb1sxdbTJl8K62KmCj5yJTl7tTImzB
         K1YVVbPfB1KJihO0sXACXUCT1JngMQjO6TAaLMaqnbzKciwpvxGFAIP4M9iCQDZxLJ
         6n7uGY4upLg7g==
From:   Naveen N Rao <naveen@kernel.org>
To:     <linux-trace-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] trace/kprobe: Display the actual notrace function when rejecting a probe
Date:   Fri,  9 Jun 2023 13:28:09 +0530
Message-Id: <20230609075809.434392-1-naveen@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

Trying to probe update_sd_lb_stats() using perf results in the below
message in the kernel log:
	trace_kprobe: Could not probe notrace function _text

This is because 'perf probe' specifies the kprobe location as an offset
from '_text':
	$ sudo perf probe -D update_sd_lb_stats
	p:probe/update_sd_lb_stats _text+1830728

However, the error message is misleading and doesn't help convey the
actual notrace function that is being probed. Fix this by looking up the
actual function name that is being probed. With this fix, we now get the
below message in the kernel log:
	trace_kprobe: Could not probe notrace function update_sd_lb_stats.constprop.0

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
v2: Update within_notrace_func() stub macro with the second parameter to 
fix the build error reported by the kernel test robot.

- Naveen

 kernel/trace/trace_kprobe.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 74adb82331dd81..2d695db5425e7c 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -449,9 +449,8 @@ static bool __within_notrace_func(unsigned long addr)
 	return !ftrace_location_range(addr, addr + size - 1);
 }
 
-static bool within_notrace_func(struct trace_kprobe *tk)
+static bool within_notrace_func(struct trace_kprobe *tk, unsigned long addr)
 {
-	unsigned long addr = trace_kprobe_address(tk);
 	char symname[KSYM_NAME_LEN], *p;
 
 	if (!__within_notrace_func(addr))
@@ -471,12 +470,14 @@ static bool within_notrace_func(struct trace_kprobe *tk)
 	return true;
 }
 #else
-#define within_notrace_func(tk)	(false)
+#define within_notrace_func(tk, addr)	(false)
 #endif
 
 /* Internal register function - just handle k*probes and flags */
 static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
+	unsigned long addr = trace_kprobe_address(tk);
+	char symname[KSYM_NAME_LEN];
 	int i, ret;
 
 	ret = security_locked_down(LOCKDOWN_KPROBES);
@@ -486,9 +487,9 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 	if (trace_kprobe_is_registered(tk))
 		return -EINVAL;
 
-	if (within_notrace_func(tk)) {
+	if (within_notrace_func(tk, addr)) {
 		pr_warn("Could not probe notrace function %s\n",
-			trace_kprobe_symbol(tk));
+			lookup_symbol_name(addr, symname) ? trace_kprobe_symbol(tk) : symname);
 		return -EINVAL;
 	}
 

base-commit: e46ad59233cf16daf4f3b9dd080003f01ac940fe
-- 
2.40.1

