Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943F96E9034
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjDTK3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjDTK2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:28:23 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC2665B2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:26:44 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b67a26069so1171766b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechatrax-com.20221208.gappssmtp.com; s=20221208; t=1681986403; x=1684578403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWVXBwnoqvgJfEhpNh6vgqWzsf/b29d9lPg1AMtFby4=;
        b=0Ldix0ZDVzYJrbeCAjwJZzEkhXWtEH7GpGFVHQfUKuNhO83d8Xa+bM5ZBw9e3VP4dw
         l6IUXXpwR8ntNlDisrKqIJRL7BjZUFTjcD5hCieKSy5bVY+BWcqt7QDlxq/2Ov5EmUXa
         Oy14SgOjQ6/nBITaz4mKGkfj1eVroZbdJWitIW+kqt5s3aUnH4Kff0mCR389fadYRDmx
         ErrBdTNjylFMIkwiSeGOU2pmlc+7F+1IFRjyWQvHddK49FVPdD9XuXTI7YkKNuYFiUQM
         32Im2wiLxQvFysNMyx45PWEGOfOidyVe+MO91zcK0yY7BTEpnZOqwYSD4sRBU4AK/0au
         uEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681986403; x=1684578403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWVXBwnoqvgJfEhpNh6vgqWzsf/b29d9lPg1AMtFby4=;
        b=Pq5p6EWSvMweHKVA+/MrBTvrC7r3BIBh+tioGRrYtd6vYnuxKfhG2ycduAQBfkfwse
         jhT2ea6u7X06DL2fc+BpJ+2CrUvqQ/7CSXLZbl+zFEWqsuIer4RpATs301N3USryfsSO
         kxe/c0QPLxpH9r+x6p/9x+PbBODxFzzlM8pwB3MtBbNUIc/orNj8P6E48qqUDifR+3p6
         Ud5yLV7SlVRz1UP6qqlWCFWa0fxYGnKMKS8z87nhcS7AHryrUXn3Wx9ghnY3HgUReFet
         t9J06ES6sFLO6RhxrakNxc/hYgEa63K/meg9CU/INTpJiyQ+Ask+CY2g1rADY46oPZwG
         N09A==
X-Gm-Message-State: AAQBX9fmg2R3MjjHpFjeOZgJ/sa3+0xYJ8mP5Vi8eYldy4mpTSrj9dlS
        T5ZqhddGr2xfKvnZsRBte82TodMyn/oKbWiWcxxt1Q==
X-Google-Smtp-Source: AKy350YlQ8URYw5pfPw41j2TebmTXO1VDvHzF/Bl7v6qnnqgyk3Ds35wW+w+P5P7iuM9LmY2dGeZfQ==
X-Received: by 2002:a05:6a00:2ea6:b0:639:435:1373 with SMTP id fd38-20020a056a002ea600b0063904351373mr1061703pfb.10.1681986402831;
        Thu, 20 Apr 2023 03:26:42 -0700 (PDT)
Received: from localhost ([2400:4152:be0:9900:c85:722a:b341:5e3])
        by smtp.gmail.com with UTF8SMTPSA id m11-20020a63580b000000b0051322a5aa64sm866818pgb.3.2023.04.20.03.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:26:42 -0700 (PDT)
From:   Masahiro Honda <honda@mechatrax.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Honda <honda@mechatrax.com>
Subject: [PATCH v3] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
Date:   Thu, 20 Apr 2023 19:23:16 +0900
Message-Id: <20230420102316.757-1-honda@mechatrax.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sigma-Delta ADCs supported by this driver can use SDO as an interrupt
line to indicate the completion of a conversion. However, some devices
cannot properly detect the completion of a conversion by an interrupt.
This is for the reason mentioned in the following commit.

commit e9849777d0e2 ("genirq: Add flag to force mask in
                      disable_irq[_nosync]()")

A read operation is performed by an extra interrupt before the completion
of a conversion. This patch fixes the issue by setting IRQ_DISABLE_UNLAZY
flag.

Signed-off-by: Masahiro Honda <honda@mechatrax.com>
---
v3:
 - Remove the Kconfig option.
v2: https://lore.kernel.org/linux-iio/20230414102744.150-1-honda@mechatrax.com/
 - Rework commit message.
 - Add a new entry in the Kconfig.
 - Call irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freeing the IRQ.
v1: https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechatrax.com/

 drivers/iio/adc/ad_sigma_delta.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d8570f620..215ecbedb 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -565,6 +565,14 @@ int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig)
 }
 EXPORT_SYMBOL_NS_GPL(ad_sd_validate_trigger, IIO_AD_SIGMA_DELTA);
 
+static void ad_sd_free_irq(void *sd)
+{
+	struct ad_sigma_delta *sigma_delta = sd;
+
+	irq_clear_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
+	free_irq(sigma_delta->spi->irq, sigma_delta);
+}
+
 static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
@@ -584,11 +592,18 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 	init_completion(&sigma_delta->completion);
 
 	sigma_delta->irq_dis = true;
-	ret = devm_request_irq(dev, sigma_delta->spi->irq,
-			       ad_sd_data_rdy_trig_poll,
-			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
-			       indio_dev->name,
-			       sigma_delta);
+	irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
+	ret = request_irq(sigma_delta->spi->irq,
+			  ad_sd_data_rdy_trig_poll,
+			  sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
+			  indio_dev->name,
+			  sigma_delta);
+	if (ret) {
+		irq_clear_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, ad_sd_free_irq, sigma_delta);
 	if (ret)
 		return ret;
 
-- 
2.34.1

