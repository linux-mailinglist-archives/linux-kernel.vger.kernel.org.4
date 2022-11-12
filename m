Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93928626A21
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiKLPUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbiKLPT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:19:57 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AF017886
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:46 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5so4531722wmo.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUz+SizcgZSFJ75dUNQdXVQMx+0/9PCMdNqr8UxmHwU=;
        b=PdUigLlaopBa7TLq4xZ6IjRqvdU6RJ04DQIEmZAuJWErRJFEI436ovC/fpZyn7on3j
         P4Yw0uYEgThh6Kg04Xo/eRvIA+6Y1N5X/tf2mz2K12XQInc6WoOveYQae7TFbicRADm7
         0N0XWgg75I4ZRxZqGlHGFhPTU/kk+GJEO1zBeGnEmDGMfyWmxW+SKembCAu9nb3QG5Uo
         maW+Ou0n8RomHH1MZTmIwZBnq+e/iMv75WWrFDLyr436V2qAp13enst4BAQtK3RCW6S9
         lt/L84huLhe70Vbi/4B8G+13RgnCNavMJ/MHuvITwEbxccp9Vc1DeFmtCHEiFKWCIO3n
         16XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUz+SizcgZSFJ75dUNQdXVQMx+0/9PCMdNqr8UxmHwU=;
        b=CmFrq5Zonu1LT5jT0IbHjHnLRJ1ScFqQv2fJAezlemnxIKtOJoqhN4eGNTpID4Pzom
         ahJ7Kz6k0m09gH8c6391kFJITXk2GKAEuOVUvVebR/oeWA/no736mqTAISoLf1mEXSJc
         4m/Ra3rLNHjnAUwd566+HcWkbF3xSPJ7Z5t4Z4o2tCqwwhq0+NKoVKr8QnUAFw3fej+t
         3SSSQBkw+oGPLpbFG2izrLZruzoTF5YBBVz7/ABYTh4VcYGxRYV7QC5uj1uX/0qO+wNX
         XkTPrjqBNaoWkSiKXsGz04FdOQkOepQFyVIbBQNmKFEZNwl8Ep+XL6WP5cibiCu1DtBd
         AXow==
X-Gm-Message-State: ANoB5pmrINV0JSLXetGbk5QK9/t5oBDHczocNK+FaIRifN+KlPpuhETv
        s9nAofWBPSaagtkJmn7S+Wg=
X-Google-Smtp-Source: AA0mqf7ZjnquLgnGnL3FmNwJh4HYfkrXS2M3yBUZQx2GFtzieRr8ne/NhZPZZZhMi5nHCAvoAftLeA==
X-Received: by 2002:a05:600c:6003:b0:3cf:9c1a:2fd0 with SMTP id az3-20020a05600c600300b003cf9c1a2fd0mr4066694wmb.3.1668266385210;
        Sat, 12 Nov 2022 07:19:45 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id r2-20020a5d6942000000b0022e47b57735sm4638008wrw.97.2022.11.12.07.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:19:44 -0800 (PST)
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
Subject: [PATCH 09/18] mfd: rn5t618: Replace irqchip mask_invert with unmask_base
Date:   Sat, 12 Nov 2022 15:18:26 +0000
Message-Id: <20221112151835.39059-10-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/rn5t618.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index eb8005b4e58d..2f59230749cd 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -80,8 +80,7 @@ static const struct regmap_irq_chip rc5t619_irq_chip = {
 	.num_irqs = ARRAY_SIZE(rc5t619_irqs),
 	.num_regs = 1,
 	.status_base = RN5T618_INTMON,
-	.mask_base = RN5T618_INTEN,
-	.mask_invert = true,
+	.unmask_base = RN5T618_INTEN,
 };
 
 static struct i2c_client *rn5t618_pm_power_off;
-- 
2.38.1

