Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BBE6D9AC5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbjDFOmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239197AbjDFOmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:42:20 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFCDBBA2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:40:39 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id r16so29137310oij.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680792039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFjEsgotUCqG/Q9AAJkwtGeznbu0uxLBMZfxP03HZSU=;
        b=dm0NPDE41iKMFj+9B6Oo+4IxfPmFQMlB4O7g0/RrSd1IqLw56L3OGQK9UGtqWUEXhV
         LijwBLp0kng8rZtcWFkk+h6X+d3ggUw2QxWyRpC9Yec/gaK+aWn5iHPs1tO8+nS8fR0a
         vOShwOPuhMjVgDXTP+wTXUMpjnBHURxJ6yUQ3zWPghXSdToNmz6c20oucq7vkWIO09nm
         LGRPiMoWxE2Eh96ywqsawuj/YEkxSRcVvsOqJs4ZmRU8jXhBrH+N8ZFYMXa8yD5hUJR2
         W2ITcc9n3/RnYPWycNhvyk5A38cVFKRIebGJbBHd5wDVnXISKd42PkJ/UQPrzm4sfdY4
         kl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFjEsgotUCqG/Q9AAJkwtGeznbu0uxLBMZfxP03HZSU=;
        b=mJ8llV1S4Sa74mSYLL3NmvVanviFNHQwpdGguVITO0LvWMpEevNgyG7ycmhe6TLIQf
         jXrGy1h0r0Lqjr8Pcn0v5J47MZU/DU6YZ7VvXnMc5gnJkNIfC2BGxXe+JIUcwBl1lzDm
         y14B4InwPXsPS3Kw9dTzMphbrYCRJZHRrg/r1RJWwUs2kN4Eh/pcD1icc8KtVenpUIaD
         n8gvl9r/G8O/qOFfJitTwdFe9Otf8o2WuZrxJu8iTx2Bvzqa1NeWunY1o/CLdbk8I2yU
         ksqnOE5BhwTSIINQmmSx1QxctAEn8ju1j1k9jbY2Pp+b0tA2eq/1pchKMX1yyNcGPY86
         9cog==
X-Gm-Message-State: AAQBX9cxs9/fYp6ZI3GywJptEgHBpQDC9RuuajgYv6ovj0d9UJRrL5uH
        AUf5ZRPt1JQgvl9/B+tXlLzBuA==
X-Google-Smtp-Source: AKy350Z59V90K5rlPYbC8tfLr2K8aOiRiJjKIgsM24opnyT30WreZ2c3+OmAZehvTXpbk9767pqgow==
X-Received: by 2002:a54:440e:0:b0:38b:7347:1f62 with SMTP id k14-20020a54440e000000b0038b73471f62mr1644786oiw.22.1680792039246;
        Thu, 06 Apr 2023 07:40:39 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q7-20020acaf207000000b0037d7f4eb7e8sm726209oih.31.2023.04.06.07.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:40:38 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 6/6] iio: addac: stx104: Use regmap_read_poll_timeout() for conversion poll
Date:   Thu,  6 Apr 2023 10:40:15 -0400
Message-Id: <9ef433f107afd1d4dcd2d97ef0e932d7045c2bbd.1680790580.git.william.gray@linaro.org>
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

ADC sample captures take a certain amount of time to complete after
initiated; this conversion time range can be anywhere from 5
microseconds to 53.68 seconds depending on the configuration of the
Analog Input Frame Timer register. When the conversion is in progress,
the ADC Status register CNV bit is high. Call regmap_read_poll_timeout()
to poll until the ADC conversion is completed (or timeout if more than
53.68 seconds passes).

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v5:
 - Improve ADC conversion comment format and use proper SI units format
Changes in v4: none

 drivers/iio/addac/stx104.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
index 798f98a8872e..d1f7ce033b46 100644
--- a/drivers/iio/addac/stx104.c
+++ b/drivers/iio/addac/stx104.c
@@ -205,21 +205,25 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 			return err;
 		}
 
-		/* trigger ADC sample capture by writing to the 8-bit
-		 * Software Strobe Register and wait for completion
+		/*
+		 * Trigger ADC sample capture by writing to the 8-bit Software Strobe Register and
+		 * wait for completion; the conversion time range is 5 microseconds to 53.68 seconds
+		 * in steps of 25 nanoseconds. The actual Analog Input Frame Timer time interval is
+		 * calculated as:
+		 * ai_time_frame_ns = ( AIFT + 1 ) * ( 25 nanoseconds ).
+		 * Where 0 <= AIFT <= 2147483648.
 		 */
 		err = regmap_write(priv->aio_ctl_map, STX104_SOFTWARE_STROBE, 0);
 		if (err) {
 			mutex_unlock(&priv->lock);
 			return err;
 		}
-		do {
-			err = regmap_read(priv->aio_ctl_map, STX104_ADC_STATUS, &adc_status);
-			if (err) {
-				mutex_unlock(&priv->lock);
-				return err;
-			}
-		} while (u8_get_bits(adc_status, STX104_CNV));
+		err = regmap_read_poll_timeout(priv->aio_ctl_map, STX104_ADC_STATUS, adc_status,
+					       !u8_get_bits(adc_status, STX104_CNV), 0, 53687092);
+		if (err) {
+			mutex_unlock(&priv->lock);
+			return err;
+		}
 
 		err = regmap_read(priv->aio_data_map, STX104_ADC_DATA, &value);
 		if (err) {
-- 
2.39.2

