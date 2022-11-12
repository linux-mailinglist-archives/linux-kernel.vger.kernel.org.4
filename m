Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD77626A1D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbiKLPUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiKLPTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:19:44 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E0212091
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:42 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso4867214wms.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxohJD/xpDsC676BB7jqU0uKaQr0B+lL6dxaSbBb+MU=;
        b=WRL+QiFXRtmPO6z+zFrWu8XBr75MkufUpD/wJpxak0VoL2tzDKNSIr3LUanvVUjMEr
         kkO8RBOvGi7aKF/HrZmRJuxy+7tsjI9tIiSiwLjKoTN4BhQMR//wV2kyK8M9F7yTDPNq
         w4IaqNgweaCIgOcu2WSLdw7QSXEDrEhmwuRVF7BG9vYE6LfMQX1xdhifWsEcF71zNkmP
         q19Xnih69enBZPTfftVZmQ+C7EfB92JTC+RCFpVqmVijARTEI3es250UFPboRd6Wzq8V
         HmzMNeQTDqhuQH5LJ+pmFuOYSd6Wn+YfulWuSIoE8zYeSBN+MzZ3yIp/4B1JTAHqoWsY
         QtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxohJD/xpDsC676BB7jqU0uKaQr0B+lL6dxaSbBb+MU=;
        b=m5YMrvPgkudiOKUF1shiBb1Wi6GPNLO9e4a0jFI7do+Qvdom5lVJcWuprfHm46zYYu
         lR2toeRRTsKoNwcjE85pRf6d5w8KDfWep3np9vUSUR7oGrbhEC15HWpSxr05OA+ANlqt
         EvoiWLOgzo3N3aWc5gcreNCsUJMkcdZPhtZ+YzTEW4n+KdGqm47Yj2csOJkFQsp77xOv
         BupQqGQBbmV59CidW7jkChTlY0bPSBftnsLbT0iDpVBzxP7WxntAgQafTjXlYdItBYoY
         IK8Jw7hiukn5xBNCHqH7wYogFjv6QhAYCJvQMHRDQ0CS/BS1UydiA0a5LwLfAvlDT6jL
         MKtg==
X-Gm-Message-State: ANoB5pliySPtJtbL/YzhaRF72PzOYxHSCzHfCO9IlQgzLwQS2Lv0BCBO
        TVzeK6QeCnf/Wk7SABPp4iE=
X-Google-Smtp-Source: AA0mqf7KOHx0WDLMua8j1wqyTc3BMEW4zzEb3sgSrlwXdC1jqqEtddRoKIIz+fscbIosi+QS7+JLgg==
X-Received: by 2002:a05:600c:3d0e:b0:3cf:88cf:1f8e with SMTP id bh14-20020a05600c3d0e00b003cf88cf1f8emr4169880wmb.9.1668266381259;
        Sat, 12 Nov 2022 07:19:41 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b003c70191f267sm13377450wmn.39.2022.11.12.07.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:19:41 -0800 (PST)
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
Subject: [PATCH 05/18] mfd: max14577: Replace irqchip mask_invert with unmask_base
Date:   Sat, 12 Nov 2022 15:18:22 +0000
Message-Id: <20221112151835.39059-6-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/max14577.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index d44ad6f33742..9c2d98d75a8e 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -209,8 +209,7 @@ static const struct regmap_irq max14577_irqs[] = {
 static const struct regmap_irq_chip max14577_irq_chip = {
 	.name			= "max14577",
 	.status_base		= MAX14577_REG_INT1,
-	.mask_base		= MAX14577_REG_INTMASK1,
-	.mask_invert		= true,
+	.unmask_base		= MAX14577_REG_INTMASK1,
 	.num_regs		= 3,
 	.irqs			= max14577_irqs,
 	.num_irqs		= ARRAY_SIZE(max14577_irqs),
@@ -239,8 +238,7 @@ static const struct regmap_irq max77836_muic_irqs[] = {
 static const struct regmap_irq_chip max77836_muic_irq_chip = {
 	.name			= "max77836-muic",
 	.status_base		= MAX14577_REG_INT1,
-	.mask_base		= MAX14577_REG_INTMASK1,
-	.mask_invert		= true,
+	.unmask_base		= MAX14577_REG_INTMASK1,
 	.num_regs		= 3,
 	.irqs			= max77836_muic_irqs,
 	.num_irqs		= ARRAY_SIZE(max77836_muic_irqs),
@@ -255,7 +253,6 @@ static const struct regmap_irq_chip max77836_pmic_irq_chip = {
 	.name			= "max77836-pmic",
 	.status_base		= MAX77836_PMIC_REG_TOPSYS_INT,
 	.mask_base		= MAX77836_PMIC_REG_TOPSYS_INT_MASK,
-	.mask_invert		= false,
 	.num_regs		= 1,
 	.irqs			= max77836_pmic_irqs,
 	.num_irqs		= ARRAY_SIZE(max77836_pmic_irqs),
-- 
2.38.1

