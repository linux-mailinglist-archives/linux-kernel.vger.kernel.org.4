Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280A7626A2B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiKLPU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiKLPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:20:10 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1111B1C3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:54 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j15so10073273wrq.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+keRvM59J/ih6ioqd6X30y/hoD2Rt/b5OT/Ve+w9Ocs=;
        b=hFKO8FAKU3bulnKjk44/RipPhrbZia1EvS3q77VHIMZXX94pRlhjD8m2VgQg8LnbD0
         PSmqqxKmRJxAWW6JjHo28GpcMUj0b6rmkCMqsOwrvhM3cXfPPMNcWBuQGdY3DR6K7zpY
         Qv1x5OqWtRmwbdUdCN0bxGxM/JqD2s6x7Zr36+Bp2YRuF8YZRJwztWne3QcDZF7Ln+ac
         MCSFr4XuRsjoQVVAcZhdPOlQ0ctjQm6VbsLWxnO/0etWK253c1BKHFr2kQoZsJTM55G6
         u4ZkL6dY4msSXtcjJHF9b2Ud8IjrtrseNPiJGF29la2C5WuWrlCUkdX9alqupBKWHE7N
         kVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+keRvM59J/ih6ioqd6X30y/hoD2Rt/b5OT/Ve+w9Ocs=;
        b=j3rIhdbTHG7flA3zrdRjP+zjwIWWyQZhCINnuWnIERswjG4a+Bc4TXr+JyZb+tUSgc
         Ra4/8yZQKTuuGZnG4rFeB3P6vvRAK15NL9Yh7qtyBV/2z+DSg1UxR+07UGkp/VOboi4D
         3/mdNCnOpcmCPOLM2lTw0mORi/A6kFhWUFjcSHB183F8GSvuRGHfdipOthP6kfGWTmkJ
         1LAJgHTBxNcsRxe+v+5wwGZCRBBV7e4rEUS/n5vMXrLxSWDhoiPY0jjVy7fjsHmj8u3X
         /dC3OvlSBwIqoxSEboODIptJiY+STkhai9VkZqePbpWJ939w1LkVcZTMRT80dCKVzVh9
         gmqA==
X-Gm-Message-State: ANoB5pkdBPaBYKqZlgJSQiYV1lJLNPL3kjIeH+jc0vZeLUv4KtjPLmyI
        BH/NX317scz+mcYMhP0FlFU=
X-Google-Smtp-Source: AA0mqf5Vc5vFeVIU8ItiQUnEaJ4N09MH6GVm7jb/0kJx/7bMJuzGgL5DgKse1vWwWXtvrNuwCv+fjw==
X-Received: by 2002:a5d:46c9:0:b0:236:62e3:6202 with SMTP id g9-20020a5d46c9000000b0023662e36202mr3692588wrs.47.1668266393972;
        Sat, 12 Nov 2022 07:19:53 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d63d1000000b002322bff5b3bsm5504758wrw.54.2022.11.12.07.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:19:53 -0800 (PST)
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
Subject: [PATCH 18/18] mfd: wcd934x: Convert irq chip to config regs
Date:   Sat, 12 Nov 2022 15:18:35 +0000
Message-Id: <20221112151835.39059-19-aidanmacdonald.0x0@gmail.com>
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

Type registers are deprecated and will eventually be removed from
regmap-irq. The same functionality can be replicated with config
registers.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/wcd934x.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index 68e2fa2fda99..07e884087f2c 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -55,17 +55,22 @@ static const struct regmap_irq wcd934x_irqs[] = {
 	WCD934X_REGMAP_IRQ_REG(WCD934X_IRQ_SOUNDWIRE, 2, BIT(4)),
 };
 
+static const unsigned int wcd934x_config_regs[] = {
+	WCD934X_INTR_LEVEL0,
+};
+
 static const struct regmap_irq_chip wcd934x_regmap_irq_chip = {
 	.name = "wcd934x_irq",
 	.status_base = WCD934X_INTR_PIN1_STATUS0,
 	.mask_base = WCD934X_INTR_PIN1_MASK0,
 	.ack_base = WCD934X_INTR_PIN1_CLEAR0,
-	.type_base = WCD934X_INTR_LEVEL0,
-	.num_type_reg = 4,
-	.type_in_mask = false,
 	.num_regs = 4,
 	.irqs = wcd934x_irqs,
 	.num_irqs = ARRAY_SIZE(wcd934x_irqs),
+	.config_base = wcd934x_config_regs,
+	.num_config_bases = ARRAY_SIZE(wcd934x_config_regs),
+	.num_config_regs = 4,
+	.set_type_config = regmap_irq_set_type_config_simple,
 };
 
 static bool wcd934x_is_volatile_register(struct device *dev, unsigned int reg)
-- 
2.38.1

