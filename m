Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E961626A27
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbiKLPUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbiKLPUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:20:03 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD991A829
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:50 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j15so10073019wrq.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74Exg7KddVXNG5OACBQCL3D7rKH5H5jEWAAQZrjSUes=;
        b=MEr0VMdo6LgqF2/UDeLPFeAhgBlaXGqOPj834RwpMRcd4AsPgXmzqVuVXdR0ccUDPl
         FEyfsOVcNhLCQ94HNdDVIzgPzDR72MpKXekWEDea1c0vAE18hqsjV7Df+U/O5ksph6/q
         aRVnA8FBfLy/Fb6RMKO0PbNVSINKQjS8lVK9z0nfKGA6T04oQO3XsKS+wu92U0IBMHSh
         inBINSnDaMEXhk6Zv9qmFq/D5M1hqjavWXbApmGAUH4eIw1HaVONH0venv5/3mSvlwox
         UTbCtTDgH3uIxUPK29RAsUmColKnkj6TXrSAJbAGZx3tM0riILitMyTNpNruXR2opl+7
         iBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74Exg7KddVXNG5OACBQCL3D7rKH5H5jEWAAQZrjSUes=;
        b=czROQByPbTB10Ma3JfoyoCSzKznKbw+q+9VPoFavzemFHccL64AHZ+eCzLLre+XcQu
         NC2A7UwVkGYSE+Ry/7xnweDmpAgIEHfVJBZMvBczns7KCyM2cfGHUZ+0wNwIjaydI22p
         xgX5tXTCcWz1Bgt7IQozBNwo6sijN3RieY/x9HrZuGsALB0rVGtACi3IRh8agMTjs60F
         qfQq7646QtehGmnVZUKwXXIhGWMLVYzMToK3kh/doGVu8Q6Wdbji/023tM0kk85FYo8e
         dZsW+7DRSQoyxJp7WFsB6dgcltWSwcCqkdJ4o/pBLI2pW0M/Tn2tLiH6wNjjrhp3DzCM
         GKag==
X-Gm-Message-State: ANoB5plATGvrb27odY5qqElzt8znR6gIuM5GpJdCYDZO8xM+LSdHpXNw
        o4ycvyixPW5/0D4umGeHSzw=
X-Google-Smtp-Source: AA0mqf6+aF9rVvdrd8IQXlI2/qRsDWBeoBpq/BCXn5rEnK5jjDA7wKSd8BWWm1ea08LNgFoMDVM1Iw==
X-Received: by 2002:adf:f14a:0:b0:22e:3c66:bda1 with SMTP id y10-20020adff14a000000b0022e3c66bda1mr3740739wro.139.1668266389050;
        Sat, 12 Nov 2022 07:19:49 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c314b00b003b4fe03c881sm13404048wmo.48.2022.11.12.07.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:19:48 -0800 (PST)
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
Subject: [PATCH 13/18] mfd: rt5120: Replace irqchip mask_invert with unmask_base
Date:   Sat, 12 Nov 2022 15:18:30 +0000
Message-Id: <20221112151835.39059-14-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/rt5120.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/rt5120.c b/drivers/mfd/rt5120.c
index 8046e383bc92..829b7a0a0781 100644
--- a/drivers/mfd/rt5120.c
+++ b/drivers/mfd/rt5120.c
@@ -59,9 +59,8 @@ static const struct regmap_irq rt5120_irqs[] = {
 static const struct regmap_irq_chip rt5120_irq_chip = {
 	.name = "rt5120-pmic",
 	.status_base = RT5120_REG_INTSTAT,
-	.mask_base = RT5120_REG_INTENABLE,
+	.unmask_base = RT5120_REG_INTENABLE,
 	.ack_base = RT5120_REG_INTSTAT,
-	.mask_invert = true,
 	.use_ack = true,
 	.num_regs = 1,
 	.irqs = rt5120_irqs,
-- 
2.38.1

