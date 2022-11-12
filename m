Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922A9626A1B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiKLPTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiKLPTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:19:41 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4258AFAFD
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:39 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so7429201wmb.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCwNwFi1NVNoGWWQ49+Xrvxf1vh+Xjt7SdulWDQIb4A=;
        b=B/HvwmPsGkSnjtfwlckHWXZvgWjeyWeZzNVsSyNzHw4lprRmfExC84HS7HK1TEs1XQ
         3IcOEI59Pk28qpVLH8AqgK1YXT2fOncHblPMHn0Vr3ddcHu0ArHZn2mRejG8d7Dpf70h
         nsJ3JvsIACNTljJoOVCRapXToeppckE51LXQVqYQHX5w1GuNHwX51P49n7f2tCPmicT4
         6gQ/qOFYPyr0HUp411gwLCXZehfHvOMBuyzjdj0ZaHg4leBbUmZhp+TPyWNNQi+NwR6Y
         l1vqJtbLqm3s73sKVBZggXUh3TwgnGvxRwkzgxbOkA9zwcx79sqotewnVKab4xsNXpNP
         fpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCwNwFi1NVNoGWWQ49+Xrvxf1vh+Xjt7SdulWDQIb4A=;
        b=z/KvHXChMQRz+0VEkyyGmQZvYB8osMH7tu0M5giZn3hKBWx7DpUN9RV6UVIoFgZACH
         5sqSAvTefogWqvDtFMZEeKmL234EPRodYN37ELPxyNoWqnj0jmnWEOJcMPNUfbiBqCb+
         q8k4wq2dXXaYTEwylwJloUw7g0Xjwe6n6gZQ7x3rOqlz8mGUwsTlI8Ca4w1NnbF9fL2k
         11it7vD4Mvgp0Q9EKxWdwBNt2YoXKAhyQFAXiv6mi0vGd8lBPnfp0TKC0IKYFAsD4vwO
         1zRFwqh21BWFC98/ZCw/JsXy2A+olrWhdrhHvP8V7yBQqwtX2XveYltyr2IBVNvFYL8S
         r6uw==
X-Gm-Message-State: ANoB5pmKL7605TECrEprimnrnhZRka1oo+rWg/PQbzUvWXLh4S3weZOQ
        4GjkS+8HDE+UaAtLV5DPIFk=
X-Google-Smtp-Source: AA0mqf5ZXkKC+OyB9EvDIptXxPDLWKjljn0+kI0bJieJ8EwpcylfK8gT3QVXJAnn7NAQhRT8fsTOZw==
X-Received: by 2002:a1c:7713:0:b0:3cf:670e:63cc with SMTP id t19-20020a1c7713000000b003cf670e63ccmr4265878wmi.150.1668266378287;
        Sat, 12 Nov 2022 07:19:38 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b003c70191f267sm13377329wmn.39.2022.11.12.07.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:19:38 -0800 (PST)
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
Subject: [PATCH 02/18] mfd: atc260x: Replace irqchip mask_invert with unmask_base
Date:   Sat, 12 Nov 2022 15:18:19 +0000
Message-Id: <20221112151835.39059-3-aidanmacdonald.0x0@gmail.com>
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

Remove use of the deprecated mask_invert flag. Inverted mask
registers (where a '1' bit enables an IRQ) can be described more
directly as an unmask register.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/atc260x-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/atc260x-core.c b/drivers/mfd/atc260x-core.c
index 7148ff5b05b1..7c5de3ae776e 100644
--- a/drivers/mfd/atc260x-core.c
+++ b/drivers/mfd/atc260x-core.c
@@ -100,8 +100,7 @@ static const struct regmap_irq_chip atc2603c_regmap_irq_chip = {
 	.num_irqs = ARRAY_SIZE(atc2603c_regmap_irqs),
 	.num_regs = 1,
 	.status_base = ATC2603C_INTS_PD,
-	.mask_base = ATC2603C_INTS_MSK,
-	.mask_invert = true,
+	.unmask_base = ATC2603C_INTS_MSK,
 };
 
 static const struct regmap_irq_chip atc2609a_regmap_irq_chip = {
@@ -110,8 +109,7 @@ static const struct regmap_irq_chip atc2609a_regmap_irq_chip = {
 	.num_irqs = ARRAY_SIZE(atc2609a_regmap_irqs),
 	.num_regs = 1,
 	.status_base = ATC2609A_INTS_PD,
-	.mask_base = ATC2609A_INTS_MSK,
-	.mask_invert = true,
+	.unmask_base = ATC2609A_INTS_MSK,
 };
 
 static const struct resource atc2603c_onkey_resources[] = {
-- 
2.38.1

