Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE85469C17C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 18:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjBSRA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 12:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjBSRAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 12:00:54 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A84F126F4;
        Sun, 19 Feb 2023 09:00:40 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s17so628562wrt.8;
        Sun, 19 Feb 2023 09:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jMw2kTtplEGyBtKDhcA5Kzq78Ybi6Nx/sQrMjtKIlU=;
        b=XmVWcgvYAfDGPjve2bb4IYdsfYdOY7mDhgmyT/eIF4RAHmCVIGiZPKlLk9BBmM7Fy5
         nimy6G3AaTXskYuYSrJP3wrYybzgVfLvEvgHwXTpggYSs9bkEG5ACSIsLVnJK0nYik6N
         v+uk7f68DqJehKfhXsjWqS3n28wwWOx+FNW6t9UVvGgm4WpRbw1EIaWLW7S8WkNxyOIM
         JH8DIfbEL250YDMN1SFzA/007CzCRVWBxFK998Or4pOxBcMnaWZLmI9L0agltSGl7xa3
         aUvGxwb7cPZZ7GlwxK68blLlGkw7LWm2xdskdQUVPDkNmjoKDiIxttP9/2djv/Zypips
         Rwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jMw2kTtplEGyBtKDhcA5Kzq78Ybi6Nx/sQrMjtKIlU=;
        b=T1xPf05qWuDspAVHKccv6TeGrcRoGTL3JOpitC2cL61Vg4iDjaEebf9H0D7cYWk0AR
         0RTTa9PR1F1uDJL/igPaM4X1B67F4XRblZgiONljy/djNhQ3uZ6xfuQ7Z3UweA6Ntm3H
         HvnHkdg21DgAlGPLsNz0P2kJJ+lcEorqmaOSEjNk97TtoMCrCpruFHnQTnZaD6hj4Syz
         sffFal02E7TL5el3QedA6INpdBGy/cGj+h2zvhP/um9J6d6PW6Uf31+IFtBwJPjX2r0c
         lfwgXyzqlTLQNmp5CsUjCngn72oSHEMoRiWOvfklQs126x/3g0LWQ/jUSZeawJzmiZd4
         tKkw==
X-Gm-Message-State: AO0yUKVfORy0xk4NoC4kGwznACxZ+0Rn9BHYAZwCL7X3aZIlzjeAX7I/
        D545z6ehjuOZEW+6wW9Gyi2LdnX78GY=
X-Google-Smtp-Source: AK7set/pAPC8AYYNHec3XrtWiSuPUi94Yhz6Bh1O/kPrD+2GZW1xzi2XqiX2fRiSrZgnR7gIpr6KdQ==
X-Received: by 2002:a05:6000:8a:b0:2c5:5886:8505 with SMTP id m10-20020a056000008a00b002c558868505mr2657884wrx.53.1676826038843;
        Sun, 19 Feb 2023 09:00:38 -0800 (PST)
Received: from localhost.localdomain (6.red-83-37-22.dynamicip.rima-tde.net. [83.37.22.6])
        by smtp.gmail.com with ESMTPSA id v20-20020a5d5914000000b002c552c6c8c2sm366427wrd.87.2023.02.19.09.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 09:00:38 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandru Lazar <alazar@startmail.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/7] iio: pressure: bmp280: Make read calibration callback optional
Date:   Sun, 19 Feb 2023 17:58:01 +0100
Message-Id: <bb1b95ab3f4e71d3c76543370325c5c9aaa07add.1676823250.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1676823250.git.ang.iglesiasg@gmail.com>
References: <cover.1676823250.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer models do not require read the calibration parameters and apply the
compensation algorithms in the sensor.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6467034b1d3e..22addaaa5393 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1631,10 +1631,12 @@ int bmp280_common_probe(struct device *dev,
 	 * time once. They will not change.
 	 */
 
-	ret = data->chip_info->read_calib(data);
-	if (ret < 0)
-		return dev_err_probe(data->dev, ret,
-				     "failed to read calibration coefficients\n");
+	if (data->chip_info->read_calib) {
+		ret = data->chip_info->read_calib(data);
+		if (ret < 0)
+			return dev_err_probe(data->dev, ret,
+					     "failed to read calibration coefficients\n");
+	}
 
 	/*
 	 * Attempt to grab an optional EOC IRQ - only the BMP085 has this
-- 
2.39.2

