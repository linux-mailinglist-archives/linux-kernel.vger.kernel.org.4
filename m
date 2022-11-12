Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC63626A24
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbiKLPUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiKLPT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:19:57 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C333178B9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:48 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r186-20020a1c44c3000000b003cfa97c05cdso1514382wma.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acztsJdrOe0moyQxGDWG+rNoagLS7dO0IEh5xXE8Q3w=;
        b=B72ZIoy/C8w6XAkRuWh0adz9TJE3c/ksIlbW6Oj7U4AMK8NTxd+7Wn3vOEY/mzQOLG
         +ynv2pC0M3mwdkgN/rmckB2dKlKo7UCGqFYjOvQ4HoC4bFXxECE0IinFVmBQH0gluraN
         P7rvFxWyVijo83yXcpNAV0LBv5SbD/gajjihlbTUevyQEG/fG6KtTXVuDCJZ36zzLq5T
         i+Ada1YLdg0QdX2GtWxxS5iI4VCErbN1lcCUEo/KtH2sYUXo2rTRuzU0peN3w5VA7iu2
         oAfEO+RGrzlQFwuUZsZgOihfqwdomcUDimOBHHJlTRj+02yYq2tlWO+E8ectt9p9csrb
         gZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acztsJdrOe0moyQxGDWG+rNoagLS7dO0IEh5xXE8Q3w=;
        b=2QlOZ2RiU1re0Es/PXD0ygjfRqD+GceX9itC8Sw3P2Z+MWfFmMDb5OHhsGP+wqUEd3
         aQDQ4LlIHNJD/oocvEVYwDLbiOeIqvfn2XotOxiDMnX6gl+2AHC6kiBTGvbBdH+PLdTv
         s72/SB2Gn2bvPEUzM8jeIXiCtuaPynPgbPqxwqWtbaizV3R9nESVY+NVC85GYs7lx9Uq
         Hzn6DDk3r1baxRqh7u8WoWg9zcX5EhvaL3YLT7Eqb3eGLRajMDvR7xOXTDvBkdfhaqcL
         40V5f3th3O4gD9zQy+RUynKMXYniah5dKjSfCo520fBHH8uQKM6/aSckKySODlEK9bjk
         432Q==
X-Gm-Message-State: ANoB5plIy0HAbAF/hcxUZu9/X0QAF44PybPdP9mxkg5TCWjZC7My81iE
        ZHLpjFk+6HTPWnVXysFEzAg=
X-Google-Smtp-Source: AA0mqf4SCQTPDxDXf2d4gtvfw8P2wB6YurYyc2Qxe8rrrZfXu1RR1QMWl0T37ZD31YJ10EMRECUrAw==
X-Received: by 2002:a05:600c:354d:b0:3cf:7514:a806 with SMTP id i13-20020a05600c354d00b003cf7514a806mr4190170wmq.116.1668266387219;
        Sat, 12 Nov 2022 07:19:47 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id z15-20020a056000110f00b0022a3a887ceasm4578267wrw.49.2022.11.12.07.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:19:46 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lee@kernel.org
Cc:     mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, brgl@bgdev.pl,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 11/18] mfd: rohm-bd718x7: Drop useless mask_invert flag on irqchip
Date:   Sat, 12 Nov 2022 15:18:28 +0000
Message-Id: <20221112151835.39059-12-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting mask_invert to false is pointless because that's the
default. The flag is also deprecated, so drop it.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/rohm-bd718x7.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index bfd81f78beae..ad6c0971a997 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -70,7 +70,6 @@ static struct regmap_irq_chip bd718xx_irq_chip = {
 	.mask_base = BD718XX_REG_MIRQ,
 	.ack_base = BD718XX_REG_IRQ,
 	.init_ack_masked = true,
-	.mask_invert = false,
 };
 
 static const struct regmap_range pmic_status_range = {
-- 
2.38.1

