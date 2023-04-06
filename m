Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB086D9ABD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbjDFOmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbjDFOmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:42:09 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DCC9019
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:40:35 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bi31so29189305oib.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680792034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VAaI37UUMqujz98kbcVgbWBFxRUSTxumyIYUkuTwcc=;
        b=uJVnn/Jfr+TJwzOL9C4qjEv/Uo0+lzKmZ2RFC2vCBh+UeCVjgKNJpI3Mjs9o4xtWtC
         Kk5X4jO3NKGFNLq2fLzyVmA8etXFiLM/IX+RZ654JQ2GujskNzmlWXUyYKat5OIU+gGy
         +7xpaWVI0Y6X2O3kG/St+h0N8ofi/2Ml1jSm7fKbIxAoy1hzfsabAFTxoLjUV49pvUiE
         GW6R3Oc2rv/gtIM5fDbrA1yFeATw5BXz95Lat99blrO2FI4HHMLUcVRXlGhYKnJkoIuD
         GxJIWxIKuMToCHFe7ngjNaNigsoaHapTzN6pCUfS3IPwNFzTKAGhAfS9/3+Z5yWXgMqk
         67mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VAaI37UUMqujz98kbcVgbWBFxRUSTxumyIYUkuTwcc=;
        b=f/MoPXWAvK6rswk0OJufWhUeE1TDwmDn+9xmvRuCks/yLsdtkR3yoausnpviwwOyPy
         euXRBBb5r5HbdfQFNCifFQRKVDdf7jsCktChPjc01IE5p0jBVdyNFWzO/RncOPpI65ep
         GH3ctcjqn2RJcUbvuOvSmEsk1Hu8O2ASqoAAlnbW+Kr8KqEHtcyeQ8mQpHZNCaX9ebLg
         OVv70bnXGCz84ydfxSuM9YCzookuH4bTMnnWxEu7Lgf9pYLhSIMk39Q3PvcmOYsI36jK
         uAV7nrazKLRgzz7ngQ7ofVOapOypcTa4KbgzWpiZAUzeCGQjc4yQihyqRglwoS/Am0CD
         ZbsA==
X-Gm-Message-State: AAQBX9fCZde2oVRoWj/8TyABVOEZiB/ph/251guhXao08BVQrtkJrx/E
        afwoQPpzOzc0//jfC67BV+OA0kySVEI+JrWIG5en7Q==
X-Google-Smtp-Source: AKy350b7bQVcppxgdKHQbyzF/mFoW8VEbJHgqp0obT7UjSjkp9f1/A810fJ2G0K0IFYxXUW5yw+PJw==
X-Received: by 2002:a05:6808:1912:b0:387:1e85:d1ae with SMTP id bf18-20020a056808191200b003871e85d1aemr5819223oib.18.1680792034597;
        Thu, 06 Apr 2023 07:40:34 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q7-20020acaf207000000b0037d7f4eb7e8sm726209oih.31.2023.04.06.07.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:40:34 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 2/6] iio: addac: stx104: Fix race condition when converting analog-to-digital
Date:   Thu,  6 Apr 2023 10:40:11 -0400
Message-Id: <2ae5e40eed5006ca735e4c12181a9ff5ced65547.1680790580.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680790580.git.william.gray@linaro.org>
References: <cover.1680790580.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADC conversion procedure requires several device I/O operations
performed in a particular sequence. If stx104_read_raw() is called
concurrently, the ADC conversion procedure could be clobbered. Prevent
such a race condition by utilizing a mutex.

Fixes: 4075a283ae83 ("iio: stx104: Add IIO support for the ADC channels")
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v5: none

 drivers/iio/addac/stx104.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
index 4239aafe42fc..8730b79e921c 100644
--- a/drivers/iio/addac/stx104.c
+++ b/drivers/iio/addac/stx104.c
@@ -117,6 +117,8 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT;
 		}
 
+		mutex_lock(&priv->lock);
+
 		/* select ADC channel */
 		iowrite8(chan->channel | (chan->channel << 4), &reg->achan);
 
@@ -127,6 +129,8 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 		while (ioread8(&reg->cir_asr) & BIT(7));
 
 		*val = ioread16(&reg->ssr_ad);
+
+		mutex_unlock(&priv->lock);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		/* get ADC bipolar/unipolar configuration */
-- 
2.39.2

