Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E150C73A2D1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjFVOOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjFVOOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:14:14 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718CC1BF9;
        Thu, 22 Jun 2023 07:13:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666edfc50deso526579b3a.0;
        Thu, 22 Jun 2023 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687443234; x=1690035234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozzSuaR+vnDFbS3Ue8g2TvzzMcrPMRjUdhLQZS2AMB4=;
        b=rhN8Dy22F+u6C76NBeAxC1X09kWA1VwYKW3uQ8ro3k+XPwoNfej8PEFZ9gyydgIm4x
         spG1AKCMn6kyixBlojnUoWTsnm1a77kQmERndtSTmqrbPagrGOvqc7lH35KtxfXx01Ze
         c/LnotwTMUY9q7bQRy9lebu9PL2B16nyDCBOUBHn54Fk7ly9V/JRt0yj4KVqk0OkNhdI
         pxFng66Ca8xjUvE9xup8bdExG2WRbHwwWOEJoO2SuphCeH22BiVKkj++pZlzGQlGyTbB
         0rBe0bgwKxJ5BOv7GFL2Nr/ioNo6ajYCpUrYaryAB7brwiqv3SdpPy8jI/8ICL9b5R4J
         QiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687443234; x=1690035234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozzSuaR+vnDFbS3Ue8g2TvzzMcrPMRjUdhLQZS2AMB4=;
        b=LztPi7g3JclbadWHwEwgJgTxD65X6NbVM15b6wERYQK6fFxaHTXrXSTvvDtbk3NKiq
         ni564bfie0TPt4LZkkESiqvqUauA+fqo7EovsicVl5+t9TBVVfgur5cTIqHFZcIJvaY8
         HnO/WYfmNkpR0ojRcqxXYoiI+ciiglv0ayRugP2xZPs1AD453fsWlVeaM1Ygp3m9oqX8
         BfBGjAUVo4jVZVk2gPtY5GeYWirkgNCdRwC+0YGJb2q7+kPQesrnKbRyqcvaU5IMGRYv
         9KHpoFf6Wz1UzpdQC92NlA/LQ6DQp1LAhd31LBY6I8QZV9dPiXqUETR9SFTp8IW3v8MB
         i9iA==
X-Gm-Message-State: AC+VfDxGpbR2O9aZYkvu/40F6KYQ1/OPmpVUw+ZLrGt4kn62yT0CL+Wj
        A0eudSYmi5cpQLGue4CaCSewYOxdrXg=
X-Google-Smtp-Source: ACHHUZ5nIppr9PmHZppYnC33Ca/5syJcrZYmeBPFwafZhESNWIE9e1Dss0ANtRQckmArPUsuwdSeKw==
X-Received: by 2002:a05:6a00:2449:b0:657:1fe5:eb63 with SMTP id d9-20020a056a00244900b006571fe5eb63mr34321717pfj.7.1687443233684;
        Thu, 22 Jun 2023 07:13:53 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id i20-20020aa79094000000b0065a1b05193asm4604268pfa.185.2023.06.22.07.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:13:53 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v3 2/3] clk: nuvoton: Update all constant hex values to lowercase
Date:   Thu, 22 Jun 2023 14:13:42 +0000
Message-Id: <20230622141343.13595-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622141343.13595-1-ychuang570808@gmail.com>
References: <20230622141343.13595-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

The constant hex values used to define register offsets were written
in uppercase. This patch update all these constant hex values to
be lowercase.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 drivers/clk/nuvoton/clk-ma35d1.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index 8dfa762494fe..733750dda0f4 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -22,19 +22,19 @@ static DEFINE_SPINLOCK(ma35d1_lock);
 #define REG_CLK_PWRCTL		0x00
 #define REG_CLK_SYSCLK0		0x04
 #define REG_CLK_SYSCLK1		0x08
-#define REG_CLK_APBCLK0		0x0C
+#define REG_CLK_APBCLK0		0x0c
 #define REG_CLK_APBCLK1		0x10
 #define REG_CLK_APBCLK2		0x14
 #define REG_CLK_CLKSEL0		0x18
-#define REG_CLK_CLKSEL1		0x1C
+#define REG_CLK_CLKSEL1		0x1c
 #define REG_CLK_CLKSEL2		0x20
 #define REG_CLK_CLKSEL3		0x24
 #define REG_CLK_CLKSEL4		0x28
-#define REG_CLK_CLKDIV0		0x2C
+#define REG_CLK_CLKDIV0		0x2c
 #define REG_CLK_CLKDIV1		0x30
 #define REG_CLK_CLKDIV2		0x34
 #define REG_CLK_CLKDIV3		0x38
-#define REG_CLK_CLKDIV4		0x3C
+#define REG_CLK_CLKDIV4		0x3c
 #define REG_CLK_CLKOCTL		0x40
 #define REG_CLK_STATUS		0x50
 #define REG_CLK_PLL0CTL0	0x60
@@ -44,18 +44,18 @@ static DEFINE_SPINLOCK(ma35d1_lock);
 #define REG_CLK_PLL3CTL0	0x90
 #define REG_CLK_PLL3CTL1	0x94
 #define REG_CLK_PLL3CTL2	0x98
-#define REG_CLK_PLL4CTL0	0xA0
-#define REG_CLK_PLL4CTL1	0xA4
-#define REG_CLK_PLL4CTL2	0xA8
-#define REG_CLK_PLL5CTL0	0xB0
-#define REG_CLK_PLL5CTL1	0xB4
-#define REG_CLK_PLL5CTL2	0xB8
-#define REG_CLK_CLKDCTL		0xC0
-#define REG_CLK_CLKDSTS		0xC4
-#define REG_CLK_CDUPB		0xC8
-#define REG_CLK_CDLOWB		0xCC
-#define REG_CLK_CKFLTRCTL	0xD0
-#define REG_CLK_TESTCLK		0xF0
+#define REG_CLK_PLL4CTL0	0xa0
+#define REG_CLK_PLL4CTL1	0xa4
+#define REG_CLK_PLL4CTL2	0xa8
+#define REG_CLK_PLL5CTL0	0xb0
+#define REG_CLK_PLL5CTL1	0xb4
+#define REG_CLK_PLL5CTL2	0xb8
+#define REG_CLK_CLKDCTL		0xc0
+#define REG_CLK_CLKDSTS		0xc4
+#define REG_CLK_CDUPB		0xc8
+#define REG_CLK_CDLOWB		0xcc
+#define REG_CLK_CKFLTRCTL	0xd0
+#define REG_CLK_TESTCLK		0xf0
 #define REG_CLK_PLLCTL		0x40
 
 #define PLL_MODE_INT            0
-- 
2.34.1

