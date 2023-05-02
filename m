Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6AD6F41A9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjEBKcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjEBKbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:31:23 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B7365A7
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 03:29:40 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aad55244b7so25205795ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 03:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechatrax-com.20221208.gappssmtp.com; s=20221208; t=1683023379; x=1685615379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WQB5oRkYadZqw07UZT9E1a/W/xo9BhfqDq7cXz9cu1k=;
        b=UFcRr1LR0o8PCSu5cONGfVTuZ7GywAIGReWn+Tx+L6qggndbPZE6r3aUvxRpBhTaVB
         z5Imc+Fl53zCOFo26+7/0w524KF+hE4pcLcprQIQ/flNPBus1JXs/ogYVy6NzyShO9pn
         LJhryF86ZMM9kC3pI051SBWIP4GpS/0iqbkI63XaSr4jbZAYkNWtbuCH0KL/oWeM8WkX
         gwjQK5IYb4Zzpbu2z5RfKU/jFJdzbVJpAcLu0cN1SrJiL3u1O9AaVX/rdDiqbnX0UVKK
         WK4K7yNUMnKYGZxKkQAiWFun/Z0pGsxHEYQklCiWDtkYHmx6oGScklRUY+Y7FculW5HN
         z41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683023379; x=1685615379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQB5oRkYadZqw07UZT9E1a/W/xo9BhfqDq7cXz9cu1k=;
        b=WvOAuKuQvc/4raP0GrryOhxyLpZPBZ2O7REmojJajP4uLOl5A3l+g+AxZH7o9JZFfW
         duShLtjKlcLgt8Ir3rF1E4Y74+vAW/7L/5C4wQt53LocedGe9DsxbL284ZRkObYl2PG+
         mJpZJlJTliFsw2HTLuFcmYDOuiDG01FnM62aXPezzVDYIDQuzjZ7rhYdfUsMyo5cxbK6
         a4Jz9Elb1eDKkDvaV0b9G3H4dCcViJDmzxCAa+UASPGA0U7GQZQOSfGcjV/TXIvcGQAN
         yDB7uXm9H7ITGDnKzL6YUqFbz6E9gkvf4qeU2sJk07CQM4XdU7nr/ub16AcFtIxExSRm
         cFAA==
X-Gm-Message-State: AC+VfDzcVwo8JPiD7+Y0I0scgxBcNdU7ysI55eNvQ9M2jEccF6leL+ko
        xEUORBOpuTu1FiL80aR77Nkubw==
X-Google-Smtp-Source: ACHHUZ7Za8FQOKGSjjMCJidPJ+F9rBSuBXdvykDVtKYwNOEJ6UQJQ7lmj1Q44SQNxNyYOu1eMyqeVg==
X-Received: by 2002:a17:902:c613:b0:1ab:893:ba28 with SMTP id r19-20020a170902c61300b001ab0893ba28mr1935714plr.45.1683023379330;
        Tue, 02 May 2023 03:29:39 -0700 (PDT)
Received: from localhost ([2400:4152:be0:9900:18fd:cb44:8f7b:de51])
        by smtp.gmail.com with UTF8SMTPSA id y23-20020a1709029b9700b001a69c1c78e7sm19456477plp.71.2023.05.02.03.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 03:29:38 -0700 (PDT)
From:   Masahiro Honda <honda@mechatrax.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Honda <honda@mechatrax.com>
Subject: [PATCH v4] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
Date:   Tue,  2 May 2023 19:29:30 +0900
Message-Id: <20230502102930.773-1-honda@mechatrax.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
v4:
 - Remove the callback.
v3: https://lore.kernel.org/linux-iio/20230420102316.757-1-honda@mechatrax.com/
 - Remove the Kconfig option.
v2: https://lore.kernel.org/linux-iio/20230414102744.150-1-honda@mechatrax.com/
 - Rework commit message.
 - Add a new entry in the Kconfig.
 - Call irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freeing the IRQ.
v1: https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechatrax.com/

 drivers/iio/adc/ad_sigma_delta.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d8570f6207..7e21928707 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -584,6 +584,10 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 	init_completion(&sigma_delta->completion);
 
 	sigma_delta->irq_dis = true;
+
+	/* the IRQ core clears IRQ_DISABLE_UNLAZY flag when freeing an IRQ */
+	irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
+
 	ret = devm_request_irq(dev, sigma_delta->spi->irq,
 			       ad_sd_data_rdy_trig_poll,
 			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
-- 
2.34.1

