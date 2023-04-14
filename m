Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B646E20B9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDNK2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDNK2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:28:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD93E57
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:28:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i8so8905102plt.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechatrax-com.20221208.gappssmtp.com; s=20221208; t=1681468108; x=1684060108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Hoqg9PT2dw5gAcaoud/8G0yli71lPUri/20PXRlKVs=;
        b=QWekuhVNVuPy18llgcFdz0XtXgFv3BcC99Cbp8mjeVlXIx5sYad7UNNe88KLDxzuoo
         zi/BLS5dZo3glevzOI0AkE2tFzU8hl3tiEii5GEwoJ1gtPCGXIaYTcsxse535MpfuaKs
         lT7DCMha3HURgsWztU6wwM9ZYHi4ap7qHtAxpL/4EnDJcWxfvqHT3bA8Jkoct0DdEOeQ
         e/al5lQevPVLEqKnRzqxklxKhd8J6EguN84yCHxINbKW5pFCTgsyu6aUKlT/xR3xAEXe
         0Kb8lspyF2YDtEwrhdgbttYEzhSoU8jK/0lzY5oz2T0HiniE1cghRVRU5ea8jA8KHPhu
         t67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681468108; x=1684060108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Hoqg9PT2dw5gAcaoud/8G0yli71lPUri/20PXRlKVs=;
        b=FKdy3mF1Nt4monl4zIZLd91uY18quLCMWftJ+pFZ2GZOMCvZRcG8UvMqaPCKH919Zi
         C6QfCoKOYMLNJIG+TY3F7JFb7UuEUrt7DNDfGxXamxRu1pUvMRaDzMVmSjuW6POk5oic
         5ylJ6FXZnkHyvCG/EqxAlbCmTPM/gz/CdpvdMaaXPtGKWiDIDWtcQe8p5ggv/eekrKkY
         yynaerREmQhdP5PlDLabaQBq61YU4lOGifDazP479z72XrhfD808vEYKq3jKpjyGqBK/
         xd2GPm9ssOReLkqltpnCOWtA72ifQzXf1GETveeyFfp3xAmUZ88xcALhp4z2N1fXggGb
         rxCg==
X-Gm-Message-State: AAQBX9eFc1Gmb5tSRgGUDB+YgmFBas6Ay3Z86AHBbYiyPXXV0y3b33P9
        4YVbxog/fWuf7vpU3kya+MbNsI32NVFkZ5ShfNA=
X-Google-Smtp-Source: AKy350YVOz4Nfh6+PimgQxz5h6bnLGiPwbxVtqq5GYBiuCieLnBJdbHpDiuz89skTI3UU/yl1sB/Gw==
X-Received: by 2002:a05:6a20:2896:b0:eb:bbd1:6d6c with SMTP id q22-20020a056a20289600b000ebbbd16d6cmr5142757pzf.21.1681468107966;
        Fri, 14 Apr 2023 03:28:27 -0700 (PDT)
Received: from localhost ([2400:4152:be0:9900:cc28:70ed:6925:f8a1])
        by smtp.gmail.com with UTF8SMTPSA id q11-20020a65684b000000b0051b1aef8032sm2662248pgt.38.2023.04.14.03.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 03:28:27 -0700 (PDT)
From:   Masahiro Honda <honda@mechatrax.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Honda <honda@mechatrax.com>
Subject: [PATCH v2] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
Date:   Fri, 14 Apr 2023 19:27:44 +0900
Message-Id: <20230414102744.150-1-honda@mechatrax.com>
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

A read operation is performed by an extra interrupt before the complete
conversion. This patch provides an option to fix the issue by setting
IRQ_DISABLE_UNLAZY flag.

Signed-off-by: Masahiro Honda <honda@mechatrax.com>
---
v2:
 - Rework commit message.
 - Add a new entry in the Kconfig.
 - Call irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freeing the IRQ.
v1: https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechatrax.com/

 drivers/iio/adc/Kconfig          | 14 ++++++++++++++
 drivers/iio/adc/ad_sigma_delta.c | 31 ++++++++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 45af2302b..78ab6e2d8 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -21,6 +21,20 @@ config AD_SIGMA_DELTA
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 
+if AD_SIGMA_DELTA
+
+config AD_SIGMA_DELTA_USE_LAZY_IRQ
+	bool "Use lazy IRQ for sigma-delta ADCs"
+	depends on AD_SIGMA_DELTA
+	default n
+	help
+	  Some interrupt controllers have data read problem with ADCs depends on
+	  AD_SIGMA_DELTA.
+	  Say yes here to avoid the problem at the cost of performance overhead.
+	  If unsure, say N (but it's safe to say "Y").
+
+endif # if AD_SIGMA_DELTA
+
 config AD4130
 	tristate "Analog Device AD4130 ADC Driver"
 	depends on SPI
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d8570f620..b9eae1e80 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -565,6 +565,16 @@ int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig)
 }
 EXPORT_SYMBOL_NS_GPL(ad_sd_validate_trigger, IIO_AD_SIGMA_DELTA);
 
+static void ad_sd_free_irq(void *sd)
+{
+	struct ad_sigma_delta *sigma_delta = sd;
+
+#ifdef CONFIG_AD_SIGMA_DELTA_USE_LAZY_IRQ
+	irq_clear_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
+#endif
+	free_irq(sigma_delta->spi->irq, sigma_delta);
+}
+
 static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
@@ -584,11 +594,22 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 	init_completion(&sigma_delta->completion);
 
 	sigma_delta->irq_dis = true;
-	ret = devm_request_irq(dev, sigma_delta->spi->irq,
-			       ad_sd_data_rdy_trig_poll,
-			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
-			       indio_dev->name,
-			       sigma_delta);
+#ifdef CONFIG_AD_SIGMA_DELTA_USE_LAZY_IRQ
+	irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
+#endif
+	ret = request_irq(sigma_delta->spi->irq,
+			  ad_sd_data_rdy_trig_poll,
+			  sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
+			  indio_dev->name,
+			  sigma_delta);
+	if (ret) {
+#ifdef CONFIG_AD_SIGMA_DELTA_USE_LAZY_IRQ
+		irq_clear_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
+#endif
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, ad_sd_free_irq, sigma_delta);
 	if (ret)
 		return ret;
 
-- 
2.34.1

