Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40486C0B97
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 08:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjCTHrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 03:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCTHrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:47:47 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA5A012594;
        Mon, 20 Mar 2023 00:47:44 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id F184B20FAACE;
        Mon, 20 Mar 2023 00:47:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F184B20FAACE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679298464;
        bh=9hqMgwt+9rfgzKvMywqn/H23HiHnKG9S9L6A/+1pzh0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UQ7XWCsoz4aLvEyssGIFuVqFwdiiGt+efQ0p6tQOvIL/9k8jKDly/VSaoLZhnwWNp
         L73ZiX5d4HKIBjvL3dC3TM0HPuXtjNkBoH8AikaPPbl9RiTp7A6PhoT1xL1XiX97VZ
         YMqo7II67x8opgdoV5l2WSFvAcqC4PRuWOdP1Hek=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com
Subject: [PATCH v9 1/5] drivers/clocksource/hyper-v: non ACPI support in hyperv clock
Date:   Mon, 20 Mar 2023 00:47:36 -0700
Message-Id: <1679298460-11855-2-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679298460-11855-1-git-send-email-ssengar@linux.microsoft.com>
References: <1679298460-11855-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a placeholder function for the hv_setup_stimer0_irq API to accommodate
systems without ACPI support. Since this function is not utilized on
x86/x64 systems and non-ACPI support is only intended for x86/x64 systems,
a placeholder function is sufficient for now and can be improved upon if
necessary in the future.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index c0cef92b12b8..f32948c8a96f 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -49,7 +49,7 @@ static bool direct_mode_enabled;
 
 static int stimer0_irq = -1;
 static int stimer0_message_sint;
-static DEFINE_PER_CPU(long, stimer0_evt);
+static __maybe_unused DEFINE_PER_CPU(long, stimer0_evt);
 
 /*
  * Common code for stimer0 interrupts coming via Direct Mode or
@@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(hv_stimer0_isr);
  * stimer0 interrupt handler for architectures that support
  * per-cpu interrupts, which also implies Direct Mode.
  */
-static irqreturn_t hv_stimer0_percpu_isr(int irq, void *dev_id)
+static irqreturn_t __maybe_unused hv_stimer0_percpu_isr(int irq, void *dev_id)
 {
 	hv_stimer0_isr();
 	return IRQ_HANDLED;
@@ -196,6 +196,7 @@ void __weak hv_remove_stimer0_handler(void)
 {
 };
 
+#ifdef CONFIG_ACPI
 /* Called only on architectures with per-cpu IRQs (i.e., not x86/x64) */
 static int hv_setup_stimer0_irq(void)
 {
@@ -230,6 +231,16 @@ static void hv_remove_stimer0_irq(void)
 		stimer0_irq = -1;
 	}
 }
+#else
+static int hv_setup_stimer0_irq(void)
+{
+	return 0;
+}
+
+static void hv_remove_stimer0_irq(void)
+{
+}
+#endif
 
 /* hv_stimer_alloc - Global initialization of the clockevent and stimer0 */
 int hv_stimer_alloc(bool have_percpu_irqs)
-- 
2.34.1

