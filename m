Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92ACA6C986D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 00:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjCZWGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 18:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCZWGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 18:06:14 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B4E5B80
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:06:12 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id b19so5016386oib.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679868372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loaO9MazuAp1DVUhZlIb/7ufss9jMMJFvpyppI0EIFk=;
        b=f4waIGO0wk+ia2QrIQraB9qm+2AMXzQn15+LMdi4WaETsVklfHfBJKr0w/A6huXYu+
         meGFA6u5jsGk4911vY3Nq/Oq6l1Q9MbPJQ87RzZZueYRZ07ESlQ8T9xD1V5NC0rOVRF3
         WhIuG7AWOedOLIEX0jFC0jbq1VlryyPtLnihoqn8aE5nS/6vxzv4aDqQv/gHX3+catZ8
         5+2oQvJLoBfYEjCasiUlklNYbu6+uh1xAteNckzgidZ5iwB3E03LciE05evW2ICBDvbU
         cKD2LPoqseFgjP8WqBDdhEG6Shxrlg0OrQK+CBh8n+1y0k1K9pmiUeNfqcTko8wqRuRQ
         ivtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679868372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loaO9MazuAp1DVUhZlIb/7ufss9jMMJFvpyppI0EIFk=;
        b=WUxTJqJ8Ylsmt5Mhh7HtkrQ3LZDZV578rDHs1CxpKCMwcqQDSmWAA3as6oqMQJccGr
         kxiUlQZ8pBilIKHQflAJZsQxnI/JzTRmEkdHTDzSyKTgZwQYPvUnzUiHiB9CqgqtmfMF
         GHTKYJcKa8xmkIe9hg5z0gfS+mjfuisYeIiDi53KymxYkB0AszsLkSF99Zm6Wg5Q2F/E
         tS1OP4hN1YGgSdeT0GVnH14QW/ZrqKzS6b8uEQWf5RjJu6bwEV3o356s2lWwBW/Sr+P5
         ccRxVvBQqp+iRVc6vzT6vFZbPPFQs23JwE55kBlysC/RodY/yXx+KQdPPE9z7nXfaHO4
         qn/g==
X-Gm-Message-State: AO0yUKX1J53g/9OE51dZJlrqs8zCqXYC+uE+EItW32XVNhrfyJI2CTay
        MhrQfTrTm2JsjlpjP+YSRlExSQ==
X-Google-Smtp-Source: AK7set+j0+fobnBpo2fELSasAymK5YqiEcr1K1e/9GOxHGs9IwRvVOEP/qwZcxgemcz1qeUv4cDzqA==
X-Received: by 2002:aca:2419:0:b0:388:1867:cd2e with SMTP id n25-20020aca2419000000b003881867cd2emr3863907oic.43.1679868372295;
        Sun, 26 Mar 2023 15:06:12 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id o187-20020acaf0c4000000b0038476262f65sm10593744oih.33.2023.03.26.15.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 15:06:12 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 2/2] iio: addac: stx104: Use regmap_read_poll_timeout() for conversion poll
Date:   Sun, 26 Mar 2023 18:05:58 -0400
Message-Id: <028dcd8d0de87699294cd2c741d5a0ebb7595bf9.1679867815.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679867815.git.william.gray@linaro.org>
References: <cover.1679867815.git.william.gray@linaro.org>
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

ADC sample captures take a certain amount of time to complete after
initiated; this conversion time range can be anywhere from 5 uSec to
53.68 Seconds depending on the configuration of the Analog Input Frame
Timer register. When the conversion is in progress, the ADC Status
register CNV bit is high. Utilize regmap_read_poll_timeout() to poll
until the ADC conversion is completed (or timeout if more than 53.68
Seconds passes).

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/addac/stx104.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
index 17d8b8e22dc3..a804f23b5619 100644
--- a/drivers/iio/addac/stx104.c
+++ b/drivers/iio/addac/stx104.c
@@ -202,15 +202,18 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 
 		/* trigger ADC sample capture by writing to the 8-bit
 		 * Software Strobe Register and wait for completion
+		 * Range is 5 uSec to 53.68 Seconds in steps of 25 nanoseconds.
+		 * The actual Analog Input Frame Timer time interval is calculated as:
+		 * ai_time_frame_ns = ( AIFT + 1 ) * ( 25 nSec ).
+		 * Where 0 <= AIFT <= 2147483648.
 		 */
 		err = regmap_write(priv->aio_ctl_map, STX104_SOFTWARE_STROBE, 0);
 		if (err)
 			return err;
-		do {
-			err = regmap_read(priv->aio_ctl_map, STX104_ADC_STATUS, &adc_status);
-			if (err)
-				return err;
-		} while (u8_get_bits(adc_status, STX104_CNV));
+		err = regmap_read_poll_timeout(priv->aio_ctl_map, STX104_ADC_STATUS, adc_status,
+					       !u8_get_bits(adc_status, STX104_CNV), 0, 53687092);
+		if (err)
+			return err;
 
 		err = regmap_read(priv->aio_data_map, STX104_ADC_DATA, &value);
 		if (err)
-- 
2.39.2

