Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8A95EE661
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiI1UCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbiI1UCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:02:21 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3AB84E7A;
        Wed, 28 Sep 2022 13:01:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b2so6482676eja.6;
        Wed, 28 Sep 2022 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=FQdphxTZ66QYAOnofKNGBcQ+Caq9QNc6A+A5EnAfs9Y=;
        b=SM+pQmHMUu1Vdwr3vzMUhNyVQ9jB8MnLgDbQ/hRsO7FdT4yxGbemcSVjmdYT2u/ZGE
         lNbO88owrJ2OnaThIlKlUxYJfAU9fA64pGyCEKoM288TgzJeWwHqEMedl2T6EncQ2S/m
         7v/kFCOJrN6Guw4DRF3G26IaXbA5dae8ufGFE01fGWOZqnxDgmfQ3Xkt/CKpcyokB5WK
         zjRoMku6hV9fYptQD318/1iiKewLG4MK8yDAmwNIU2Pxu/Q4k5GwHCUpOGv9eVc6cJXZ
         k5koN4qVNzWhiYUI4vAHYxpyAUFNdYqxOly19A7ygtdhUeeAKLnXVM4qr+Dg0C5Wtg9W
         1XXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=FQdphxTZ66QYAOnofKNGBcQ+Caq9QNc6A+A5EnAfs9Y=;
        b=s8AEcA1Ob5QhXTFU2xpfAD+we4V4++pNhYJ6vv4/hxHdpiIDBdALI4TFAfoys9Jain
         8PH1THpqd7RuEKBxqZlWDUXad1ulpcc0HuPs9J1il0byUh/5IMZE0j+CMfN8/xTW9X84
         BGZgndHmIFP2pw6LhBFwQ8UCKmE/r6KR0JQSIHrrSwZzA/KNHPIBkLyUpRUgiSp/f2fO
         ZPXwYRpGy+fBW/v+ieCbineUZquF6grxdkfwsj5TUHV50KuZkGOV1hnHR4UIetCkx6Rs
         BoaNHhONxLGhueywVhL1E98T+U1e/XBPYQkfnbdR6J4HZV3XrDwO0ku3dyoYC4IMomu+
         qAAQ==
X-Gm-Message-State: ACrzQf3ARyLNsV1MhunfsKBVUZAiEQzaAf1R2QfhqC3uQdqsdILylRjq
        wrDV7Kqif72fmp9kruhpyM8=
X-Google-Smtp-Source: AMsMyM7/ltV50qoXxcf2RzeCPuJDZ5lLR05PmqL0JITzHOT79EBbmXSaWJFFFNsWKyP31DkaBFZ7Eg==
X-Received: by 2002:a17:907:74e:b0:74f:83d4:cf58 with SMTP id xc14-20020a170907074e00b0074f83d4cf58mr29389544ejb.178.1664395297439;
        Wed, 28 Sep 2022 13:01:37 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id n25-20020a05640204d900b00457cdb5cf76sm3015769edw.50.2022.09.28.13.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 13:01:36 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     wens@csie.org, samuel@sholland.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, r.stratiienko@gmail.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] clk: sunxi-ng: h6: Fix default PLL GPU rate
Date:   Wed, 28 Sep 2022 22:01:22 +0200
Message-Id: <20220928200122.3963509-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.37.3
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

In commit 4167ac8a657e ("clk: sunxi-ng: sun50i: h6: Modify GPU clock
configuration to support DFS") divider M0 was forced to be 1 in order to
support DFS. However, that left N as it is, at high value of 36. On
boards without devfreq enabled (all of them in kernel 6.0), this
effectively sets GPU frequency to 864 MHz. This is about 100 MHz above
maximum supported frequency.

In order to fix this, let's set N to 18 (register value 17). That way
default frequency of 432 MHz is preserved.

Fixes: 4167ac8a657e ("clk: sunxi-ng: sun50i: h6: Modify GPU clock configuration to support DFS")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index 30056da3e0af..42568c616181 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -1191,9 +1191,13 @@ static int sun50i_h6_ccu_probe(struct platform_device *pdev)
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
-	/* Force PLL_GPU output divider bits to 0 */
+	/*
+	 * Force PLL_GPU output divider bits to 0 and adjust
+	 * multiplier to sensible default value of 432 MHz.
+	 */
 	val = readl(reg + SUN50I_H6_PLL_GPU_REG);
-	val &= ~BIT(0);
+	val &= ~(GENMASK(15, 8) | BIT(0));
+	val |= 17 << 8;
 	writel(val, reg + SUN50I_H6_PLL_GPU_REG);
 
 	/* Force GPU_CLK divider bits to 0 */
-- 
2.37.3

