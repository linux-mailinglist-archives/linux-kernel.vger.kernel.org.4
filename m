Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235CF608003
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJUUmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJUUmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:42:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED52140E43;
        Fri, 21 Oct 2022 13:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ADFBB82D23;
        Fri, 21 Oct 2022 20:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0017C433D6;
        Fri, 21 Oct 2022 20:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666384870;
        bh=tehsC4Nds0UIzYea1wZIFRCjPzJjx5qNx8jGpeoAIiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WR4HBn2uLAMK7iJnrKPhpVEnsfLCJJllc74DrBjEEEi+RSzERCAb8G9TZoB57X4BX
         BdhZAvgCX2PCD6Ek5iHcozKkz+dJL3EXuxNPK/Xe65IRHHb8PfLL1pyK+4VTK8wrSa
         6ZZvW62Y5X7w1gQYJ+V9s854nUlnB1XrmWE4Iflk2Nb97BbF8M8hY8puonuqLNE4xJ
         IGG04GlSLx/LUVIZJ4Z2VHj3ym+WhGGX5cpGGwbp3/vkzicdgrIH1SDGBSKdc+CWWF
         pgndYGl/e+ujgbprZUF7rnWeRJ+gHEAaytfiTF5x2AuQ3Q3r1Szpxmz4pSo/boaozf
         pmA+VLYedJgkw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 06/21] ARM: s3c: remove s3c6400 support
Date:   Fri, 21 Oct 2022 22:27:39 +0200
Message-Id: <20221021203329.4143397-6-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021202254.4142411-1-arnd@kernel.org>
References: <20221021202254.4142411-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

No board file and no dts file references the s3c6400 now, it's only
s3c6410, so remove the final bits as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c/Makefile.s3c64xx |  1 -
 arch/arm/mach-s3c/s3c6400.c        | 84 ------------------------------
 arch/arm/mach-s3c/s3c64xx.c        |  8 ---
 3 files changed, 93 deletions(-)
 delete mode 100644 arch/arm/mach-s3c/s3c6400.c

diff --git a/arch/arm/mach-s3c/Makefile.s3c64xx b/arch/arm/mach-s3c/Makefile.s3c64xx
index 13cda2fe7b6c..61287ad2ea42 100644
--- a/arch/arm/mach-s3c/Makefile.s3c64xx
+++ b/arch/arm/mach-s3c/Makefile.s3c64xx
@@ -16,7 +16,6 @@ obj-$(CONFIG_PM_SLEEP)          += irq-pm-s3c64xx.o
 # Core
 
 obj-y				+= s3c64xx.o
-obj-$(CONFIG_CPU_S3C6400)	+= s3c6400.o
 obj-$(CONFIG_CPU_S3C6410)	+= s3c6410.o
 
 # DMA support
diff --git a/arch/arm/mach-s3c/s3c6400.c b/arch/arm/mach-s3c/s3c6400.c
deleted file mode 100644
index d47f1d6067b4..000000000000
diff --git a/arch/arm/mach-s3c/s3c64xx.c b/arch/arm/mach-s3c/s3c64xx.c
index 0a8116c108fe..ad13d7e13e5e 100644
--- a/arch/arm/mach-s3c/s3c64xx.c
+++ b/arch/arm/mach-s3c/s3c64xx.c
@@ -72,18 +72,10 @@ static void __init s3c64xx_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 
 /* table of supported CPUs */
 
-static const char name_s3c6400[] = "S3C6400";
 static const char name_s3c6410[] = "S3C6410";
 
 static struct cpu_table cpu_ids[] __initdata = {
 	{
-		.idcode		= S3C6400_CPU_ID,
-		.idmask		= S3C64XX_CPU_MASK,
-		.map_io		= s3c6400_map_io,
-		.init_uarts	= s3c64xx_init_uarts,
-		.init		= s3c6400_init,
-		.name		= name_s3c6400,
-	}, {
 		.idcode		= S3C6410_CPU_ID,
 		.idmask		= S3C64XX_CPU_MASK,
 		.map_io		= s3c6410_map_io,
-- 
2.29.2

