Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CA1620899
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiKHE5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiKHE5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:57:32 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4FF2E691;
        Mon,  7 Nov 2022 20:53:56 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s12so11121949edd.5;
        Mon, 07 Nov 2022 20:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJ4Kp4qtRSrvjN0VOHg/NMsbcM2L3wi4GzWp4+H7lqY=;
        b=VRlK8dyzw8ngJPEBSuKzwQwMbZE+SmKnbjXkreWs+SKjkaHFsrmGvYExBUU74ZTOty
         qVrfpmkis7/qm8rR2q+eZ+Fl9rx6YSEDB+UUpdz1ZJWXNsP/Vf8/2hhjHpKEKaX6PgAi
         jRquLzFBP5/9DPUKDXp2s66eOXIm9u9v8VZRZVDmsQ7ZN8688j7Lrvvstsx77lXQzEep
         rT2GF97Nw/xTStzEkAEsB/DJ+hSj2tyqvgSPh1Aehz9z9B8AefxIIa9NhQf2B6ggOC12
         9/zRmw5I8BMIRap64rWDVS+baDYSuDP/WMU1kd7mLt3Jfa/asDEe4JsWRkK6P+cf9m23
         OqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJ4Kp4qtRSrvjN0VOHg/NMsbcM2L3wi4GzWp4+H7lqY=;
        b=pxjelmSwrXntr3bRusOPt7CchC12iIZ+MItO5ZuYw1snisb2wYBxpxtsIerxZCetGB
         CL56ptXL1FH/86trGphlOytMgjy+/mW6LFSAS2GNuJHFA0962b4fFvmbbGwVuQvk+G4z
         ql4EkDkIEjmiyrnwOvCwO1holxOuuwRjV7S2qHWlh0mdGx1zSr+qv8Irx6cuk1n+RuIH
         +7lxpQLbpMNbKRHJSdYyUV1gEh66bdqwwXPekzia06B3OQi5XeuB80B0OB1Sq+rpNzQE
         Ko02AdWyO5GeJrFvkuD5eW0oFo6cZYZzRMXdGd990IhB+QMnKdkZ/Zkfc5v5Q4fnVsZg
         YENA==
X-Gm-Message-State: ACrzQf3dPaiL9Qn7RhMCKHrOwrWrdNpwJ0hoQad6sOtGsbTuzmx5YlRf
        KDt1mbwkwXDJ9OrDzaL7LWI=
X-Google-Smtp-Source: AMsMyM6Y+DyjZBtOznaMI4tIK8z78fqaoKbfHqSKqbAP5Gl6FkxrqnfWfLUHq23bAwnToTvJmIT6FA==
X-Received: by 2002:a05:6402:14ca:b0:462:e375:a1f4 with SMTP id f10-20020a05640214ca00b00462e375a1f4mr54812108edx.344.1667883235303;
        Mon, 07 Nov 2022 20:53:55 -0800 (PST)
Received: from hp-power-15.localdomain (mm-58-12-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.12.58])
        by smtp.gmail.com with ESMTPSA id p11-20020a05640210cb00b004637489cf08sm4994444edu.88.2022.11.07.20.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 20:53:54 -0800 (PST)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH 1/2] mmc: jz4740: Don't change parent clock rate for some SoCs
Date:   Tue,  8 Nov 2022 07:52:59 +0300
Message-Id: <20221108045300.2084671-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221108045300.2084671-1-lis8215@gmail.com>
References: <20221108045300.2084671-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs have one clock divider for all MMC units, thus changing one
affects others as well. This leads to random hangs and memory
corruptions, observed on the JZ4755 based device with two MMC slots
used at the same time.

List of SoCs affected includes: JZ4725b, JZ4755, JZ4760 and JZ4760b.
However, the MMC driver doesn't distinguish JZ4760 and JZ4770
which shall remain its behavior. For the JZ4755 is sufficient to
use JZ4725b's binding. JZ4750 is outside of the patch.

The MMC core has its own clock divisor, rather coarse but suitable well,
and it shall keep the role of tuning clock for the MMC host in that
case.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 drivers/mmc/host/jz4740_mmc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index dc2db9c18..d390ff31d 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -114,6 +114,7 @@ enum jz4740_mmc_version {
 	JZ_MMC_JZ4740,
 	JZ_MMC_JZ4725B,
 	JZ_MMC_JZ4760,
+	JZ_MMC_JZ4770,
 	JZ_MMC_JZ4780,
 	JZ_MMC_X1000,
 };
@@ -887,7 +888,13 @@ static int jz4740_mmc_set_clock_rate(struct jz4740_mmc_host *host, int rate)
 	int real_rate;
 
 	jz4740_mmc_clock_disable(host);
-	clk_set_rate(host->clk, host->mmc->f_max);
+
+	/*
+	 * Changing rate on these SoCs affects other MMC units too.
+	 * Make sure the rate is configured properly by the CGU driver.
+	 */
+	if (host->version != JZ_MMC_JZ4725B && host->version != JZ_MMC_JZ4760)
+		clk_set_rate(host->clk, host->mmc->f_max);
 
 	real_rate = clk_get_rate(host->clk);
 
@@ -992,6 +999,7 @@ static const struct of_device_id jz4740_mmc_of_match[] = {
 	{ .compatible = "ingenic,jz4740-mmc", .data = (void *) JZ_MMC_JZ4740 },
 	{ .compatible = "ingenic,jz4725b-mmc", .data = (void *)JZ_MMC_JZ4725B },
 	{ .compatible = "ingenic,jz4760-mmc", .data = (void *) JZ_MMC_JZ4760 },
+	{ .compatible = "ingenic,jz4770-mmc", .data = (void *) JZ_MMC_JZ4770 },
 	{ .compatible = "ingenic,jz4775-mmc", .data = (void *) JZ_MMC_JZ4780 },
 	{ .compatible = "ingenic,jz4780-mmc", .data = (void *) JZ_MMC_JZ4780 },
 	{ .compatible = "ingenic,x1000-mmc", .data = (void *) JZ_MMC_X1000 },
-- 
2.36.1

