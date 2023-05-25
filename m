Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3A271031F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjEYC5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEYC5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:57:47 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43354135
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:57:43 -0700 (PDT)
X-QQ-mid: bizesmtp63t1684983430tny3hp8d
Received: from localhost.localdomain ( [221.226.144.218])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 10:57:08 +0800 (CST)
X-QQ-SSF: 01200000000000303000000A0000000
X-QQ-FEAT: Q40xx9djesRnvDjNn8FEKK30CJtqMZLJIor2xKhK5CaxBB9mt0DXuMlLPYqPB
        XwU+t+ZR2ppVV1gWFz/3tdYgXvOqNyx2sj1tDRvmvPJSxWf9mmIV9/kKzgpyLRFF6pAKMpv
        dB0eKB2SSKXJh3FTbdTch41OWKYEWPRex1/kKW7pZjOibMJK72PzfbAwoYu0dNrdZKe15AK
        dTMzuKSl3z/YxPs5jNKNOm7HuebEE7nCnLbDXy5qf6ij3OKz81p/au9NFgD8Zl6iWkiPEDq
        GcW6VwoPGDF1TVFO2o+HzRuvCW71F1mCYe/bYfS8TJHE/z7e4lhSzEBaQvPwUFBEwu87AX9
        fT3d27frdI1M3q8tgGm3Jw0nwmLKBJdf6njsyPLQRlj+Yw3Q4gHY9U0yQCyzavwq1c5rNIA
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4042248179779979880
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
Subject: [PATCH 2/4] arm64: hibernate: remove WARN_ON in save_processor_state
Date:   Thu, 25 May 2023 10:55:53 +0800
Message-Id: <20230525025555.24104-3-songshuaishuai@tinylab.org>
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
 arch/arm64/kernel/hibernate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 788597a6b6a2..02870beb271e 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -99,7 +99,6 @@ int pfn_is_nosave(unsigned long pfn)
 
 void notrace save_processor_state(void)
 {
-	WARN_ON(num_online_cpus() != 1);
 }
 
 void notrace restore_processor_state(void)
-- 
2.20.1

