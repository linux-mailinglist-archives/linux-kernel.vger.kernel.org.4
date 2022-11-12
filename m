Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2953626A23
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiKLPUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbiKLPT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:19:57 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15E213F94
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:45 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i82-20020a1c3b55000000b003cfd36eff5fso743246wma.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok7HpRM+XtzDAgo3jwhMBdJyhpha2jg6F6Os6h21MVc=;
        b=gJ3Se3YJBcHCIsogJkRdhV9D/9OrVb/ee9dNAk80ZErZAgxIhhGkKsyEqbYPkiDw6D
         im3ckufSkCIrYHONHqeFAg8XvnQihlv6EQoPoDFCaHzjBEcsi8hWCpYRG7jvG1cW/l2J
         vngvQUhyY/Ay8hhc4RiXRT0utvvzlcwlcVjVbOGu74ht5cbnQq/6UBFKnPZb/bJacQ3Q
         GkZimPSbVGqigELup8lmT+Zo+3iQNuWQBTgkJm5hKwuTZZF5DAgRKXqpnOV6/2urK/Wc
         DMGVB6IlRxHNHChs7xR2eM/uxI7uvQmmqQq73ePH/+esLBbyPPxRWzVhppZwKZznxVA+
         71zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok7HpRM+XtzDAgo3jwhMBdJyhpha2jg6F6Os6h21MVc=;
        b=ayC3OZvZ8tsGEhdGWFeraxjuS3sTc3P8q9sJyLyEJ+Q9WXKXAJum6YUmOORNQdo2oV
         UOcjbrMJKugjMcuv+46b8O3Lu5zOhMO5A+1vF+evCxrTV0FW4HHfpF+YWPHIgSKF4MSG
         5GcOQtz49y6d++FR8NhmSu0FK5XW+4ch/RwadpBdD/e8iv0rEI1J9T+YK9gBJztUQ90q
         g59PfjX6ypbdtwcbpZ3S/3hD72FkjFNMarHELJmgdwnTqsHne8ubD2R1a2Ch+tWNuOfe
         cit+712xjsg3iaKyCufjjCyDjw/1KzLP1OTCjqVTPYdcDBfw1d6sbZ1bvndkA3De+/mk
         bWdQ==
X-Gm-Message-State: ANoB5pnWi+bYyJ8ZkFetwpkjwQMVGDHHTWolvJ6bE4o9fMOgUnCpDVWT
        UgN6yQ+Pd6oKkDDqj6g9n3I=
X-Google-Smtp-Source: AA0mqf7TWJmeBw/gK7xmmf6T7hKI7a8pcXblvBR5D7H29oAqBEY40zxyQHONWj4jNdNQirVSsJRTdw==
X-Received: by 2002:a05:600c:1e10:b0:3cf:8ebf:69b with SMTP id ay16-20020a05600c1e1000b003cf8ebf069bmr4226300wmb.86.1668266384285;
        Sat, 12 Nov 2022 07:19:44 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c2f0800b003c701c12a17sm12005218wmn.12.2022.11.12.07.19.43
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
Subject: [PATCH 08/18] mfd: max77843: Drop useless mask_invert flag on irqchip
Date:   Sat, 12 Nov 2022 15:18:25 +0000
Message-Id: <20221112151835.39059-9-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/max77843.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/max77843.c b/drivers/mfd/max77843.c
index 209ee24d9ce1..4da58eab1603 100644
--- a/drivers/mfd/max77843.c
+++ b/drivers/mfd/max77843.c
@@ -59,7 +59,6 @@ static const struct regmap_irq_chip max77843_irq_chip = {
 	.name		= "max77843",
 	.status_base	= MAX77843_SYS_REG_SYSINTSRC,
 	.mask_base	= MAX77843_SYS_REG_SYSINTMASK,
-	.mask_invert	= false,
 	.num_regs	= 1,
 	.irqs		= max77843_irqs,
 	.num_irqs	= ARRAY_SIZE(max77843_irqs),
-- 
2.38.1

