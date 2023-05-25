Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B00710322
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbjEYC55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjEYC5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:57:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B1C139
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:57:44 -0700 (PDT)
X-QQ-mid: bizesmtp63t1684983425tx9azvf6
Received: from localhost.localdomain ( [221.226.144.218])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 10:57:03 +0800 (CST)
X-QQ-SSF: 01200000000000303000000A0000000
X-QQ-FEAT: jXjag1m6xl7WyIELRssET5EuttbKJzokSNielpVbJR2OiTpJeAJqTrFwO96YQ
        tokwilre7FqbTP0hnGE/ppzEy4bGUXKgRio2t+VIoMM2VWauzbUnGHa+Sipa1RrbyDuNOKx
        tqcxBrmnAFQ73StoonTBlSrKXKjl2PLQBKsga30zCSInjh0TED/zIWvq4tMsNQNAnCpkJ2b
        +LvFTNStGcpt/ubUt0VFOLUKlIk15QK9A6SIzGrTD+Bb5fa5C0POkIA6UXLqL4PbE4H4BGq
        tOb3wYkj0Rdial2N4ncNiCkaWFc0j00Ympqcu8Vo4UNBJiJsNZUxhCfOk3pEyLldJqjsgn2
        wZqYEqOCnSmEcXUyeWpuM2qnQwOAUhUxLO5sjkUPYvR0+BKt1ZNLxG/7LKvYg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6696857243706674612
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
Subject: [PATCH 1/4] ARM: hibernate: remove WARN_ON in save_processor_state
Date:   Thu, 25 May 2023 10:55:52 +0800
Message-Id: <20230525025555.24104-2-songshuaishuai@tinylab.org>
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
 arch/arm/kernel/hibernate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
index 2373020af965..84abccf3221a 100644
--- a/arch/arm/kernel/hibernate.c
+++ b/arch/arm/kernel/hibernate.c
@@ -33,7 +33,6 @@ int pfn_is_nosave(unsigned long pfn)
 
 void notrace save_processor_state(void)
 {
-	WARN_ON(num_online_cpus() != 1);
 	local_fiq_disable();
 }
 
-- 
2.20.1

