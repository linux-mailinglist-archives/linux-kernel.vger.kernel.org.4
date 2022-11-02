Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61B961726F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiKBXZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKBXYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:24:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157A5CE34;
        Wed,  2 Nov 2022 16:20:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so230300pji.0;
        Wed, 02 Nov 2022 16:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NnNf+3cP8WzFVUxvQcRTeKMHqTn6WlUgTme+xs4Lr1c=;
        b=esqjWm9yPT2RZZNGv5txzWInMtNIYEnIhT1tdYbIVI+irrFWDuOKPj7BJsCOzcwg27
         USsq8m/H/SN0gAg68pm6Wz15lsNVoqM6E620HsynmlPAuOq3DqwV2yOh4wc7ZK/AdWqT
         fpqty4yJPcOMSbwaNDf603ehNQPFwNc5AsqsbF+eTuettFS2mFZ1G+FT202JigFD5JJu
         rFDG8BBQ5PtoMxa11CFTgVwBQzUSy6dCf6oAQK5Ho8YvazmHQLVLkd8BtMVr4uA1XSqW
         n12qg6C2nhBlFwHXl65b3hY9M5ffp37sso4PRWRbXRLSUGsqhVcEukgPod79F6MWD+bv
         t+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnNf+3cP8WzFVUxvQcRTeKMHqTn6WlUgTme+xs4Lr1c=;
        b=S4231+ppn5R2ZQUi3cooIBfSv8yl6LKYLt/hfqXCpousbfZKDMtw2RWVT9STIjSyo3
         elc0Bnw89VLmVL5VpenWQLfs6CdXXevHzsuTQTsJFUMkA4nnY/n1VfAOIgWPAsbEmpw8
         TzXYsdi8SxRk0REPQfLz0fXtuEw9UcqdHWTrKxvyV2tgMn9BGfFrWMBt1uSlImHMJHNx
         y2ot2cReeibl/fhnpcEj8Nn9ExsQuYjHb2VB3eFB7miNWqX7261arNfTVRRPlg9gTwMt
         9AAiKMnYu8F2Jc0vNo8hfJr0N+VfRgQO/3/yFP3QCV66sqsdjHJVcgKKAiEbIkUtdLnQ
         J7AQ==
X-Gm-Message-State: ACrzQf04Q3oDIe6UVFKZANR9AjdWw7g1mifzHeVxsbXSX8x6FlFPkTuS
        0Uqvl2ifrgUGAwq2KKE+l1o=
X-Google-Smtp-Source: AMsMyM4XSJzXyuadocKQKCqAAKIjjEApMgvNo1Ym4x1uAHDQZiH5fDfVtB/u2KhakKBfhb7WZKMBRg==
X-Received: by 2002:a17:902:bb98:b0:186:988d:a0f0 with SMTP id m24-20020a170902bb9800b00186988da0f0mr26931407pls.10.1667431209114;
        Wed, 02 Nov 2022 16:20:09 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b00186e2123506sm8842073pll.300.2022.11.02.16.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 16:20:08 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm: omap2: n8x0: stop instantiating codec platform data
Date:   Wed,  2 Nov 2022 16:20:02 -0700
Message-Id: <20221102232004.1721864-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of 0426370b58b2 ("ARM: dts: omap2420-n810: Correct the audio codec
(tlv320aic33) node") the DTS properly specifies reset GPIO, and the
device name in auxdata lookup table does not even match the one in
device tree anymore, so stop instantiating it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-omap2/board-n8x0.c           | 5 -----
 arch/arm/mach-omap2/common-board-devices.h | 2 --
 arch/arm/mach-omap2/pdata-quirks.c         | 1 -
 3 files changed, 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 5e86145db0e2..8897364e550b 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -22,7 +22,6 @@
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/mmc-omap.h>
 #include <linux/mfd/menelaus.h>
-#include <sound/tlv320aic3x.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -567,10 +566,6 @@ struct menelaus_platform_data n8x0_menelaus_platform_data = {
 	.late_init = n8x0_menelaus_late_init,
 };
 
-struct aic3x_pdata n810_aic33_data = {
-	.gpio_reset = 118,
-};
-
 static int __init n8x0_late_initcall(void)
 {
 	if (!board_caps)
diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
index b23962c38fb2..69694af71475 100644
--- a/arch/arm/mach-omap2/common-board-devices.h
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -2,12 +2,10 @@
 #ifndef __OMAP_COMMON_BOARD_DEVICES__
 #define __OMAP_COMMON_BOARD_DEVICES__
 
-#include <sound/tlv320aic3x.h>
 #include <linux/mfd/menelaus.h>
 
 void *n8x0_legacy_init(void);
 
 extern struct menelaus_platform_data n8x0_menelaus_platform_data;
-extern struct aic3x_pdata n810_aic33_data;
 
 #endif /* __OMAP_COMMON_BOARD_DEVICES__ */
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 9409b9f5711c..baba73fd6f11 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -439,7 +439,6 @@ static struct of_dev_auxdata omap_auxdata_lookup[] = {
 #ifdef CONFIG_MACH_NOKIA_N8X0
 	OF_DEV_AUXDATA("ti,omap2420-mmc", 0x4809c000, "mmci-omap.0", NULL),
 	OF_DEV_AUXDATA("menelaus", 0x72, "1-0072", &n8x0_menelaus_platform_data),
-	OF_DEV_AUXDATA("tlv320aic3x", 0x18, "2-0018", &n810_aic33_data),
 #endif
 #ifdef CONFIG_ARCH_OMAP3
 	OF_DEV_AUXDATA("ti,omap2-iommu", 0x5d000000, "5d000000.mmu",
-- 
2.38.1.273.g43a17bfeac-goog

