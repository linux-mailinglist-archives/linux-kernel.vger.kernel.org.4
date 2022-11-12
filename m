Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB20626A1E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiKLPUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiKLPTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:19:43 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3832FAFD
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:41 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p16so4520778wmc.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyNGlKcyBDF0YXtdVE2Mo7IFCo+00jQ8YxUzSjoXa50=;
        b=bb8Q/XHUIDCawlWjNkou8fyhAYQXwgoCWxuU2nSEBkYbxc11DdPvSJfIH4H9OT7Yzq
         G7taxhDewqonLeJPieV4nxA/eAMT1VL5uPvNHgnvZoZRnrl07bDXYySWDnx3CJtKtfhc
         c7WRNGwipiESSbwsKdnVpm+WRl7PmXWkjeJ1n/bfIzn1/So0onOpJuis1E4lW8cXf0Wi
         0qEyQOe2qUhhHXi5y54DLwkW3Vwd1nyC491YlpyMxdWjUz9zNhVUjoDDPfXpRl4kpXY7
         bajqLkBRLFMYAy2E9LzJ1AtRNAqvMEeneMKONHu40T1kqvMtUxubUnp9lNBOpZy0QWOU
         rJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyNGlKcyBDF0YXtdVE2Mo7IFCo+00jQ8YxUzSjoXa50=;
        b=FvdrgPE5KChDecXE69SZ67R5OKjY5D+NZPTvpf2wVVx6aFp46Hz9Bd0iYU61etGj0M
         wJpJoyGaDcgn84gEfgM1HLkVE8FVo32fcEJhSXRxP4FEGkMiP4lu1jiEXBz2JOvNCtmG
         n6qTBWlbSI4LjZcAzOhKKIZVYD+cVCWdl/enVc7FwgBJO59FCHGnLL79hTOvMIbEar4u
         LigT/XhN1BOTaOE9Z5wCvUnvwezVXXrqUOCmC8dNUsgTIjAuUohkdxLTR+62Su3n6aYv
         85pzv+saRcrysV+71rRzOY93OWqeuE2EkDckYDd+vdMms/tiy2E6H6Q+bByJRbVnPI4d
         g67Q==
X-Gm-Message-State: ANoB5pl+M4e8vdF41eZwT1lU7qzQPHYuB2sXyLd+aJts3zfSDDpZYevy
        CajUo9DhCONFJf1vjdvUrnU=
X-Google-Smtp-Source: AA0mqf7cIbCOnxnpggHzR0NyGxhzVeR20CXRn0Ch5nLdVmRZXdJ/+/zFl2wtSttlOKmH0pW7GLYpNA==
X-Received: by 2002:a7b:cd0e:0:b0:3cf:ca45:3b19 with SMTP id f14-20020a7bcd0e000000b003cfca453b19mr3984095wmj.179.1668266380066;
        Sat, 12 Nov 2022 07:19:40 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id f7-20020adfe907000000b0023677081f3asm4543484wrm.42.2022.11.12.07.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:19:39 -0800 (PST)
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
Subject: [PATCH 04/18] mfd: gateworks-gsc: Replace irqchip mask_invert with unmask_base
Date:   Sat, 12 Nov 2022 15:18:21 +0000
Message-Id: <20221112151835.39059-5-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/gateworks-gsc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/gateworks-gsc.c b/drivers/mfd/gateworks-gsc.c
index 9d7d870c44a8..c954ed265de8 100644
--- a/drivers/mfd/gateworks-gsc.c
+++ b/drivers/mfd/gateworks-gsc.c
@@ -189,8 +189,7 @@ static const struct regmap_irq_chip gsc_irq_chip = {
 	.num_irqs = ARRAY_SIZE(gsc_irqs),
 	.num_regs = 1,
 	.status_base = GSC_IRQ_STATUS,
-	.mask_base = GSC_IRQ_ENABLE,
-	.mask_invert = true,
+	.unmask_base = GSC_IRQ_ENABLE,
 	.ack_base = GSC_IRQ_STATUS,
 	.ack_invert = true,
 };
-- 
2.38.1

