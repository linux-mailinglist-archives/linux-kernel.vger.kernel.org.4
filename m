Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F70688E9E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 05:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjBCEhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 23:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBCEhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 23:37:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473D860CB9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 20:37:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D669C61D7D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 04:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A9CC433D2;
        Fri,  3 Feb 2023 04:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675399019;
        bh=vSXG2FNpbLvUQNLylcNUj1Px15+hEgLUz7VrP/XsoDQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HsK1ZAGq++mEDNF+UNZz+3dH1nzLFgjDRsrh8UrC8+IpzA8LZuOCKcJ4b7tzcT9Wk
         JinU9YJPTRy9BZlDz+2QLRVYiNIDdldbf62jo7eSdaMnraafzvQAZo4/vWbO0LxrVx
         6PsyZZRpVwn72JKjBPfh3sr7+2f42XR9bthXi70Ex9KaVmxigATVA+SGE5lqAHmTFA
         NYCtJ+eTIbYc9TnlMNGPtnGb9r/PhYUBqPFwApZfU6EdMJH6I2lNW4bJsWa0npDruu
         7rntRxb2AAx49L0qR3brnZ84G/0yDwY34TwsujnM/JfkuLAxgvSMAwOwbweJPfgyJP
         5luMMEvw/cL9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CAFA35C0DE7; Thu,  2 Feb 2023 20:36:58 -0800 (PST)
Date:   Thu, 2 Feb 2023 20:36:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        longman@redhat.com
Subject: PATCH v2 clocksource 8/7] clocksource: Enable TSC watchdog checking
 of HPET and PMTMR only when requested
Message-ID: <20230203043658.GA1513624@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unconditionally enabling TSC watchdog checking of the HPET and PMTMR
clocksources can degrade latency and performance.  Therefore, provide
a new "watchdog" option to the tsc= boot parameter that opts into such
checking.  Note that tsc=watchdog is overridden by a tsc=nowatchdog
regardless of their relative positions in the list of boot parameters.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Waiman Long <longman@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 95f0d104c2322..7b4df6d89d3c3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6373,6 +6373,12 @@
 			(HPET or PM timer) on systems whose TSC frequency was
 			obtained from HW or FW using either an MSR or CPUID(0x15).
 			Warn if the difference is more than 500 ppm.
+			[x86] watchdog: Use TSC as the watchdog clocksource with
+			which to check other HW timers (HPET or PM timer), but
+			only on systems where TSC has been deemed trustworthy.
+			This will be suppressed by an earlier tsc=nowatchdog and
+			can be overridden by a later tsc=nowatchdog.  A console
+			message will flag any such suppression or overriding.
 
 	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
 			value instead. Useful when the early TSC frequency discovery
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a5371c6d4b64b..306c233c98d84 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -294,6 +294,7 @@ __setup("notsc", notsc_setup);
 
 static int no_sched_irq_time;
 static int no_tsc_watchdog;
+static int tsc_as_watchdog;
 
 static int __init tsc_setup(char *str)
 {
@@ -303,10 +304,22 @@ static int __init tsc_setup(char *str)
 		no_sched_irq_time = 1;
 	if (!strcmp(str, "unstable"))
 		mark_tsc_unstable("boot parameter");
-	if (!strcmp(str, "nowatchdog"))
+	if (!strcmp(str, "nowatchdog")) {
 		no_tsc_watchdog = 1;
+		if (tsc_as_watchdog)
+			pr_alert("%s: Overriding earlier tsc=watchdog with tsc=nowatchdog\n",
+				 __func__);
+		tsc_as_watchdog = 0;
+	}
 	if (!strcmp(str, "recalibrate"))
 		tsc_force_recalibrate = 1;
+	if (!strcmp(str, "watchdog")) {
+		if (no_tsc_watchdog)
+			pr_alert("%s: tsc=watchdog overridden by earlier tsc=nowatchdog\n",
+				 __func__);
+		else
+			tsc_as_watchdog = 1;
+	}
 	return 1;
 }
 
@@ -1192,7 +1205,8 @@ static void __init tsc_disable_clocksource_watchdog(void)
 
 bool tsc_clocksource_watchdog_disabled(void)
 {
-	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY);
+	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY) &&
+	       tsc_as_watchdog && !no_tsc_watchdog;
 }
 
 static void __init check_system_tsc_reliable(void)
