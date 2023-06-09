Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAD3729200
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbjFIH72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjFIH60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:58:26 -0400
X-Greylist: delayed 141 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Jun 2023 00:57:18 PDT
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153D73AB8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:57:17 -0700 (PDT)
X-QQ-mid: bizesmtp75t1686297197t84smj5p
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 09 Jun 2023 15:53:16 +0800 (CST)
X-QQ-SSF: 01200000000000908000000A0000000
X-QQ-FEAT: eSZ1CZgv+JDrzqJXUyJ/mcu057NGxL1xBlezD+yoPQqZOp/XEym+SAkiqR8mP
        y/mpdUlUsr3GccK7aytaQDnPMxaiHL0++ERM3P1l+Z/Ht3BibeLCrNg1poYm/nD5zSwsdMD
        x72PQm0lIBAV69smXv3fYf+3+HlF6GoJyEZQNabbUaICIzb/E+0kXyTuI+T+To9yodHmBDi
        lHBYo3hnlIeaXt+2+yLenDhJTnsQ2nxYthPnKi+X7qAPucOcklQ2F4jIZVhOcufgT5JU8AT
        Y+xJXmSZCBgWSYe/O0u0TIksw1pW0bqCG4b+661yftYmZawpM3HxK5RHa0LJQUgbugjwNuR
        WIICypWsMDvDee8ZyVamLyn6/2XgGOU6joVIrGjkqnxJHXfJbmwurL5VSNFuQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2352795355600838194
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
Subject: [PATCH V2 4/4] xtensa: hibernate: remove WARN_ON in save_processor_state
Date:   Fri,  9 Jun 2023 15:50:49 +0800
Message-Id: <20230609075049.2651723-5-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230609075049.2651723-1-songshuaishuai@tinylab.org>
References: <20230609075049.2651723-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

