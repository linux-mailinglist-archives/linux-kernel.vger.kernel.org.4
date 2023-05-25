Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D35B710325
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbjEYC57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjEYC5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:57:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D77183
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:57:47 -0700 (PDT)
X-QQ-mid: bizesmtp63t1684983441tzej1xdq
Received: from localhost.localdomain ( [221.226.144.218])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 10:57:19 +0800 (CST)
X-QQ-SSF: 01200000000000303000000A0000000
X-QQ-FEAT: X3kNTHUrKMRJlZyT+2O5RdJGnxa2VEocmY9T2Ec5y4fHeQHbTKNAZHig3qVRw
        ugOfN+JUwaPDLD5af5iOZUA1gZW0bTB+xogyUz+29+XMpMp/y4kkGtYkNMmSkqAankJ89tN
        7rgEUUJ0S9TNc6bW7ZlBlE9bhf0lPjRcvNwD9pygpsAGuM8Ad6FRxbZX584iCgA6tMj9jXF
        YlfaPcuPTXBBlSzNvxE5t7dWdzrB9dTSJ9QMQDuirSJ2rD6501e7T61GKiZI67m+vt2wS1n
        VjK12Xz12c87qvD9joA+8u4n3BOR84XIQPfGK6v+6Pe3CpKtgheeMeLjGb6A1/XtJfFe6iF
        uDRqZyUxoZQDgVORNOxbTtMN4GKhH08Y/8WJp9YyHLgm2ZEcMq6KJoi9GDRC/PWoD/vIVob
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11307094136493837363
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, chris@zankel.net,
        jcmvbkbc@gmail.com, songshuaishuai@tinylab.org,
        steven.price@arm.com, vincenzo.frascino@arm.com, pcc@google.com,
        wangxiang@cdjrlc.com, ajones@ventanamicro.com,
        conor.dooley@microchip.com, jeeheng.sia@starfivetech.com,
        leyfoon.tan@starfivetech.com
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 4/4] xtensa: hibernate: remove WARN_ON in save_processor_state
Date:   Thu, 25 May 2023 10:55:55 +0800
Message-Id: <20230525025555.24104-5-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230525025555.24104-1-songshuaishuai@tinylab.org>
References: <20230525025555.24104-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During hibernation or restoration, freeze_secondary_cpus
checks num_online_cpus via BUG_ON, and the subsequent
save_processor_state also does the checking with WARN_ON.

So remove the unnecessary checking in save_processor_state.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 arch/xtensa/kernel/hibernate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/xtensa/kernel/hibernate.c b/arch/xtensa/kernel/hibernate.c
index 06984327d6e2..314602bbf431 100644
--- a/arch/xtensa/kernel/hibernate.c
+++ b/arch/xtensa/kernel/hibernate.c
@@ -14,7 +14,6 @@ int pfn_is_nosave(unsigned long pfn)
 
 void notrace save_processor_state(void)
 {
-	WARN_ON(num_online_cpus() != 1);
 #if XTENSA_HAVE_COPROCESSORS
 	local_coprocessors_flush_release_all();
 #endif
-- 
2.20.1

