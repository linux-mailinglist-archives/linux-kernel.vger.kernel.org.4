Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195C76AB993
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjCFJUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCFJUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:20:20 -0500
Received: from njjs-sys-mailin01.njjs.baidu.com (mx315.baidu.com [180.101.52.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7BC7D507
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:20:18 -0800 (PST)
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id E52F07F0005C;
        Mon,  6 Mar 2023 17:20:16 +0800 (CST)
From:   lirongqing@baidu.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/apic: fix a printk precision vs width issue
Date:   Mon,  6 Mar 2023 17:20:16 +0800
Message-Id: <1678094416-28615-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

Before this patch when HZ is 1000, the host bus clock speed
is 99812KHz, but shows 99.0812 MHz

 [    0.136739] ..... calibration result: 99812
 [    0.136930] ..... host bus clock speed is 99.0812 MHz.
it should be:
 [    0.136930] ..... host bus clock speed is 99.812 MHz.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/kernel/apic/apic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 20d9a60..7e3b1bf 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -948,15 +948,15 @@ static int __init calibrate_APIC_clock(void)
 
 	if (boot_cpu_has(X86_FEATURE_TSC)) {
 		apic_printk(APIC_VERBOSE, "..... CPU clock speed is "
-			    "%ld.%04ld MHz.\n",
-			    (deltatsc / LAPIC_CAL_LOOPS) / (1000000 / HZ),
-			    (deltatsc / LAPIC_CAL_LOOPS) % (1000000 / HZ));
+			    "%ld.%03ld MHz.\n",
+			    ((deltatsc) / LAPIC_CAL_LOOPS) * HZ / 1000 / 1000,
+			    ((deltatsc) / LAPIC_CAL_LOOPS) * HZ / 1000 % 1000);
 	}
 
 	apic_printk(APIC_VERBOSE, "..... host bus clock speed is "
-		    "%u.%04u MHz.\n",
-		    lapic_timer_period / (1000000 / HZ),
-		    lapic_timer_period % (1000000 / HZ));
+		    "%u.%03u MHz.\n",
+		    (lapic_timer_period * HZ / 1000) / 1000,
+		    (lapic_timer_period * HZ / 1000) % 1000);
 
 	/*
 	 * Do a sanity check on the APIC calibration result
-- 
2.9.4

