Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE18626A2A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiKLPUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiKLPUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:20:09 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD16F1B1C6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:54 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l14so10067696wrw.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8JtmDVGUNZLueBXNVQdf6legj2BoWLl/9Iq8NNieS4=;
        b=KgVCH/IFzLTIzv2PmfoezQS90DP/PkehCN9B1h+H4iFdbdWIoTM/r7Cwa50poXtFWw
         NGobU9+5fCU93t7rWyMWBVeXP3BWGb4qVZXku5GvCOk8CbtvwNjcx7znBvqXHjZZCuYi
         mzyflMozHYpDKR+R2CMCtOyvlK/HLu6kYLbfm3MKtJOadtucpLfIdjb7pjU81gWgNLD9
         ao6sjM22ue0h5CXip8Fs/1x/U3Zceh0J0m598S55uOJ+iMIhlHXZxNngz1rfNFU3FoVa
         FG1E9X+nZE89AU1VFg2MIojBWjLFwLgXY1jfRpe0KGf4JWDbghj/yF7kWMFERb9a957p
         +JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8JtmDVGUNZLueBXNVQdf6legj2BoWLl/9Iq8NNieS4=;
        b=G3MlULvRL4jiwNuJ9mLt38f1lviDbCuzt3f/xxZ8+uSenlhqO+nmtBLYRYQ+WUvpX8
         vE9qQlYt7tN0bBCBsyp+NOb5XMe+ALYb9Gopdu1AujBapabVlngn+3YZbdhtimHDQEZH
         xsVZEHRSYTF3F67svioK1UDLu53qnDrMgTxvpbgB9ToweftcfI5OFNUEiQut5r9jFREm
         eYYwzybE3V4mAPi26ZZCZn7M+9GkTIJDpEwaN4BsQhsVpwXaeDfyeP2uUz3a3+GL/ea3
         Ln4H+y7RzAbyUsQxApED+desN1GVlemsxmrmtTOm3noVcQKyElLBfTdx2clXJ5tZf1Ex
         ExIg==
X-Gm-Message-State: ANoB5pn3to82MbqvRwKbSN4PwOS1+byRLZpxBpsubg8ONenym6A2+Xj1
        v0U3TNtjDsIN/KyHpqzxa2Y=
X-Google-Smtp-Source: AA0mqf65Zhyw4t2aHprnYTDPvoYRtVEFmQatzMZYXusOOb59557kwzoehqrtwp2Yr1oquLEdy9q4VA==
X-Received: by 2002:adf:f5c5:0:b0:22e:597:8541 with SMTP id k5-20020adff5c5000000b0022e05978541mr3792906wrp.612.1668266393046;
        Sat, 12 Nov 2022 07:19:53 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d54cb000000b002415dd45320sm4584152wrv.112.2022.11.12.07.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:19:52 -0800 (PST)
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
Subject: [PATCH 17/18] mfd: tps65090: Replace irqchip mask_invert with unmask_base
Date:   Sat, 12 Nov 2022 15:18:34 +0000
Message-Id: <20221112151835.39059-18-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/tps65090.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index bd6235308c6b..e474e1ca253a 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -127,8 +127,7 @@ static struct regmap_irq_chip tps65090_irq_chip = {
 	.num_irqs = ARRAY_SIZE(tps65090_irqs),
 	.num_regs = NUM_INT_REG,
 	.status_base = TPS65090_REG_INTR_STS,
-	.mask_base = TPS65090_REG_INTR_MASK,
-	.mask_invert = true,
+	.unmask_base = TPS65090_REG_INTR_MASK,
 };
 
 static bool is_volatile_reg(struct device *dev, unsigned int reg)
-- 
2.38.1

