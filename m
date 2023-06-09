Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2091B7291FC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238797AbjFIH7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238935AbjFIH61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:58:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BF23ABC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:57:17 -0700 (PDT)
X-QQ-mid: bizesmtp75t1686297192tngrrsv3
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 09 Jun 2023 15:53:11 +0800 (CST)
X-QQ-SSF: 01200000000000908000000A0000000
X-QQ-FEAT: 3M0okmaRx3ggkGfYbCwXKFcJVxYo7gx8Sd8QId2cLz94QTT20Ue9kVFXfH7mk
        XRXlTwTPdy4vaDs5QViLJiCIfTnjIdM9r0mNkM/Lo3tRdqRvMoViq+uW6suj/6O70CZSodZ
        yBkndruclxcfHizm+Fcgr3DrJVwpcAoftfoXGn+7GgsyQkty+8LJ4UE1s3/3RBGpPMOHVeK
        ATBQplGoG5mPSJPc3SB14N13nmWOdlD/iBdWVzvi5FYQ2rgb/sK7huHvdmi2+iOBgjNj3p+
        efTBedwnRLQ+FO9VOscQFfyuQWNvAHv9gArJiuKQYS+RslHMEsQxfCrZNFCY3pvsv1MQX35
        Zk6sV93P4gpMhJFjQp1Zd3fFu6+4uY89VJEcQV3S3Cg0AvEvqQ8ahkzsyLvhQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10720794791275635707
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, chris@zankel.net,
        jcmvbkbc@gmail.com, songshuaishuai@tinylab.org,
        steven.price@arm.com, vincenzo.frascino@arm.com,
        leyfoon.tan@starfivetech.com, mason.huo@starfivetech.com,
        jeeheng.sia@starfivetech.com, conor.dooley@microchip.com,
        ajones@ventanamicro.com
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH V2 3/4] riscv: hibernate: remove WARN_ON in save_processor_state
Date:   Fri,  9 Jun 2023 15:50:48 +0800
Message-Id: <20230609075049.2651723-4-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230609075049.2651723-1-songshuaishuai@tinylab.org>
References: <20230609075049.2651723-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During hibernation or restoration, freeze_secondary_cpus
checks num_online_cpus via BUG_ON, and the subsequent
save_processor_state also does the checking with WARN_ON.

In the case of CONFIG_PM_SLEEP_SMP=n, freeze_secondary_cpus
is not defined, but the sole possible condition to disable
CONFIG_PM_SLEEP_SMP is !SMP where num_online_cpus is always 1.
We also don't have to check it in save_processor_state.

So remove the unnecessary checking in save_processor_state.

Fixes: c0317210012e ("RISC-V: Add arch functions to support hibernation/suspend-to-disk")
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 arch/riscv/kernel/hibernate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
index 395f835f067c..86f1c9ab6b0b 100644
--- a/arch/riscv/kernel/hibernate.c
+++ b/arch/riscv/kernel/hibernate.c
@@ -119,7 +119,6 @@ int pfn_is_nosave(unsigned long pfn)
 
 void notrace save_processor_state(void)
 {
-	WARN_ON(num_online_cpus() != 1);
 }
 
 void notrace restore_processor_state(void)
-- 
2.20.1

