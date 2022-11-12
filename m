Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF09626A29
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiKLPUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiKLPUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:20:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47061AD92
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:52 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id o4so10060938wrq.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vv/3HAucSDWmO8xwnh5HST4ssDGqCVQOTNcS90+6lU=;
        b=jpc9tN4KxBsfE2iBF/Kx5UM/PYB3RbWC0UUz8Pk77cr5NPWSGRNhLeCxpFdjsx6q0O
         o6n/eE8O5Whvr3WT+nUgB11/duZcUld4r/ERwLQLRKqmjHhEMP/znOH3x9ZRZ+3Sadyd
         DC09KWR7sCa7JNG+1duiRePnGOp4KbHUUVn4J+ttGNAODo2Cx3fOjbUSRBTBOGLu2Ym8
         6CWoYnn2kIsKd8U3/Yc60PH/zfe8I37piGYwWMbdm4FHS8y3D1z4gTKp9XShRQ211dEV
         QdEhxpfjBzjvu01ECYnHIZutt3SX38/KsAtylLD7FF2JiSlOOE1JEWLkiyMP1Z7JA/tC
         pL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vv/3HAucSDWmO8xwnh5HST4ssDGqCVQOTNcS90+6lU=;
        b=f7rSwKIz7jGttS93yI62beoUqNdFex6CUuSlnZ/NYg77Ns5389fIXBltD2XynIsrmQ
         SKRvFJnhOokqWFm5ExPKXfR1i8xQsr5wPbBy2Vr9K0hp7iO55uodzxVujMjM3BIrUzb0
         q2ntYgzA8mGTPw3BD2B1NsbKcHSY592VDWMjU81Fc38sumClz++QSsfFSJ4x9nifzpn+
         Zi0J6nNspki7Q7u5gcQBNWH+JrHOHPewCMHGXCmQjHjCCUwIYqdHb3Im0kfcsYReBaBX
         7qBf8k7YJRzjCPz/JZuupT2WsfajhMNl9MOHuxe1o1lf/BkpaP639yHDvMAmWxP4EG4c
         C9BA==
X-Gm-Message-State: ANoB5pnmlZDeaX3HvNRowxEKEs9rLnmWQjNeGi28EkrsDovpOBNqMx4R
        GtftFKUQlVD7Kod2XRadH3s=
X-Google-Smtp-Source: AA0mqf7yAFmkuF+GLTArtuzehjKb8KYcTqN5tQ+tXMTr65DKOBI2+7yP5rAXKMF4CkvvCod+EvEh5Q==
X-Received: by 2002:a05:6000:511:b0:236:64ce:2c0a with SMTP id a17-20020a056000051100b0023664ce2c0amr3671606wrf.230.1668266392072;
        Sat, 12 Nov 2022 07:19:52 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id h5-20020a1ccc05000000b003cf7292c553sm6509053wmb.13.2022.11.12.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:19:51 -0800 (PST)
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
Subject: [PATCH 16/18] mfd: sun4i-gpadc: Replace irqchip mask_invert with unmask_base
Date:   Sat, 12 Nov 2022 15:18:33 +0000
Message-Id: <20221112151835.39059-17-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/sun4i-gpadc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/sun4i-gpadc.c b/drivers/mfd/sun4i-gpadc.c
index cfe14d9bf6dc..edc180d83a4b 100644
--- a/drivers/mfd/sun4i-gpadc.c
+++ b/drivers/mfd/sun4i-gpadc.c
@@ -34,9 +34,8 @@ static const struct regmap_irq_chip sun4i_gpadc_regmap_irq_chip = {
 	.name = "sun4i_gpadc_irq_chip",
 	.status_base = SUN4I_GPADC_INT_FIFOS,
 	.ack_base = SUN4I_GPADC_INT_FIFOS,
-	.mask_base = SUN4I_GPADC_INT_FIFOC,
+	.unmask_base = SUN4I_GPADC_INT_FIFOC,
 	.init_ack_masked = true,
-	.mask_invert = true,
 	.irqs = sun4i_gpadc_regmap_irq,
 	.num_irqs = ARRAY_SIZE(sun4i_gpadc_regmap_irq),
 	.num_regs = 1,
-- 
2.38.1

