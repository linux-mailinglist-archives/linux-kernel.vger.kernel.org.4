Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFE963A9A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiK1Nei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiK1Ned (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:34:33 -0500
X-Greylist: delayed 385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Nov 2022 05:34:31 PST
Received: from njjs-sys-mailin04.njjs.baidu.com (mx316.baidu.com [180.101.52.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3A6225C9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:34:31 -0800 (PST)
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by njjs-sys-mailin04.njjs.baidu.com (Postfix) with ESMTP id 9268C11800045;
        Mon, 28 Nov 2022 21:28:03 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id 7FCEED9932;
        Mon, 28 Nov 2022 21:28:03 +0800 (CST)
From:   Yuan ZhaoXiong <yuanzhx326@gmail.com>
To:     tglx@linutronix.de, steven.price@arm.com, Jason@zx2c4.com,
        juri.lelli@redhat.com, tony.luck@intel.com, frederic@kernel.org,
        yuanzhx326@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] cpu: printk error information when call cpu_up() failed.
Date:   Mon, 28 Nov 2022 21:28:03 +0800
Message-Id: <20221128132803.17599-1-yuanzhx326@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL,
        SPOOFED_FREEMAIL,SPOOF_GMAIL_MID autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to printk error information out when calling cpu_up() failed.
Users will observe cpu up error conveniently via the kernel log.

Signed-off-by: Yuan ZhaoXiong <yuanzhx326@gmail.com>
---
 kernel/cpu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index bbad5e375d3b..28b0202e7744 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1481,12 +1481,16 @@ int bringup_hibernate_cpu(unsigned int sleep_cpu)
 void bringup_nonboot_cpus(unsigned int setup_max_cpus)
 {
 	unsigned int cpu;
+	int error;
 
 	for_each_present_cpu(cpu) {
 		if (num_online_cpus() >= setup_max_cpus)
 			break;
-		if (!cpu_online(cpu))
-			cpu_up(cpu, CPUHP_ONLINE);
+		if (!cpu_online(cpu)) {
+			error = cpu_up(cpu, CPUHP_ONLINE);
+			if (error)
+				pr_err("Error taking CPU%d up: %d\n", cpu, error);
+		}
 	}
 }
 
-- 
2.27.0

