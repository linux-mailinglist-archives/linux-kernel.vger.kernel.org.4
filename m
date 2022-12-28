Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFF56576EE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 14:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiL1NbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 08:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiL1NbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 08:31:08 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE546FAF1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 05:31:04 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id gh17so38422224ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 05:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4l0Q/3bvrZLuwLcDsg+ciiSIq3Yw/FSttenbxVCcl3Q=;
        b=jgKEe+VI9OytSoaMrW6vCm6AHLQPPebWe115IlWkEiSJxkaw9neDEcu65OzdXPD+Yi
         nkb835AzU8xBG/mSzWK5iLXMUvzs1FPzILlAUBOS0zb50NG8ksAjGWooLUxEgh9B1Dtg
         JAL97qEnlKfx+BkyIyZKzi3a/pSWD+bl1SyykS08be9Wy7UJydy3KAnd7EqVXRNQzEmB
         hFAQXGPaHVCGokBNseUtFI8MjEsxgJZ/LEyas/mw9fz71ce1WZlwLKm0kbAsiBh6Tkr4
         3q/1UXhkV3dnE7uu6naMSNuIWgSz2c0lM504Wz+x4CL/tUC4yZsKHp/YCdYqx4LKH8h2
         fFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4l0Q/3bvrZLuwLcDsg+ciiSIq3Yw/FSttenbxVCcl3Q=;
        b=lCKMRxwXtDLkSK6Z0wYI3RCQ9GBkPrr2h8gXCsyTPBmsWU6IAKnnzpVDkMpCbzJeLa
         cqcP/xYR63L+sBDIqEkeXeyDY5wTZDjn77DA2Hf63GGTrgP3wm8/hue5uBSTJp26r/AY
         xa+GQbVOHQKscXus1EvSbK0ERDb0Dh0WK9gzlpKes15gHuS/lcK5ZtdyKrXPNeuhm7Il
         i7yVp9LbTuhm4EpKbsBJ0jqu0FHMafO5niU4juHmPAaeI/JQPzPlQcrllLcY4bwQR2l4
         DbI1lLQ6pBACDOnaNuGjhttCzMTtQzSVnSdCa0E5WLFWMwh0XQTKG6i4D6RYOZyAWDbC
         8huA==
X-Gm-Message-State: AFqh2kr/UwYrl8OzkVkzll2KPAVxVhlUMph0c4mvDGqHglK27gQz1L7m
        2k/VdwhZUc7FxOaZs0pE2bKPZw==
X-Google-Smtp-Source: AMrXdXv23xO3Dxmu7ePjJ0MUeWxqCyObS/9kR+f2X2vSFd7s2X7i5ps51GTa9GXvK2i7pxDJ2sv9wQ==
X-Received: by 2002:a17:906:6d8a:b0:7c0:f907:89a2 with SMTP id h10-20020a1709066d8a00b007c0f90789a2mr18602141ejt.61.1672234263423;
        Wed, 28 Dec 2022 05:31:03 -0800 (PST)
Received: from planet9.chello.ie (2001-1c06-2302-5600-85f6-04b5-1651-3b6c.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:85f6:4b5:1651:3b6c])
        by smtp.gmail.com with ESMTPSA id j15-20020a170906094f00b007add28659b0sm7541393ejd.140.2022.12.28.05.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 05:31:03 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        agross@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bryan.odonoghue@linaro.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH v4 2/2 RESEND] extcon: qcom-spmi: Switch to platform_get_irq_byname_optional
Date:   Wed, 28 Dec 2022 13:30:58 +0000
Message-Id: <20221228133058.213886-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221228133058.213886-1-bryan.odonoghue@linaro.org>
References: <20221228133058.213886-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valid configurations for the extcon interrupt declarations are

- usb_id
- usb_vbus
- (usb_id | usb_vbus)

In the case of a standalone usb_id or usb_vbus failure to find one of the
interrupts shouldn't generate a warning message. A warning is already in
place if both IRQs are missing.

Switch to using platform_get_irq_byname_optional() in order to facilitate
this behaviour.

Suggested-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/extcon/extcon-qcom-spmi-misc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-qcom-spmi-misc.c b/drivers/extcon/extcon-qcom-spmi-misc.c
index eb02cb962b5e1..f72e90ceca53d 100644
--- a/drivers/extcon/extcon-qcom-spmi-misc.c
+++ b/drivers/extcon/extcon-qcom-spmi-misc.c
@@ -123,7 +123,7 @@ static int qcom_usb_extcon_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	info->id_irq = platform_get_irq_byname(pdev, "usb_id");
+	info->id_irq = platform_get_irq_byname_optional(pdev, "usb_id");
 	if (info->id_irq > 0) {
 		ret = devm_request_threaded_irq(dev, info->id_irq, NULL,
 					qcom_usb_irq_handler,
@@ -136,7 +136,7 @@ static int qcom_usb_extcon_probe(struct platform_device *pdev)
 		}
 	}
 
-	info->vbus_irq = platform_get_irq_byname(pdev, "usb_vbus");
+	info->vbus_irq = platform_get_irq_byname_optional(pdev, "usb_vbus");
 	if (info->vbus_irq > 0) {
 		ret = devm_request_threaded_irq(dev, info->vbus_irq, NULL,
 					qcom_usb_irq_handler,
-- 
2.34.1

