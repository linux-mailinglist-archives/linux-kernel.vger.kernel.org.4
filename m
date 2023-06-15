Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D429F731C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344199AbjFOP1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343959AbjFOP0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:26:44 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639CE2126;
        Thu, 15 Jun 2023 08:26:42 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686842801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfYOy7L85MdtcQ88k+lfhIIjhcOaxuYtKNcPHMwEQsI=;
        b=DNkwSUbQpzHsmovXfUt9+3hYNv8lCpGKZkIGNMH72ReCCWpw+SwUaY107imywc9IFOPHqX
        FjrkCczX3FJv6E/kjcNSw6DXTCGE5i9+mRdg89jn1h53WOChKq8umRZqDRu3lkiqOOXuTi
        5btEtvVFHzdCNLyJPU6lQz3sWq1w7ZBWitlJ2Oi31jlHg5uhWGLntHxZuIv4LFwXyLGnOY
        tegR8uS9gANHOoUoYoLX8DG1fSD7Wnc52O3IzmB3f05ZsdKr7HjLEXHQtlNO4KU3K+xK1p
        WC53rkJUnFlGvs03zITB1ejOfp3lF58wei7nXm227iHlVPT4l8LE872S3r7RPQ==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 54A2CFF80B;
        Thu, 15 Jun 2023 15:26:39 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 03/13] iio: inkern: Check error explicitly in iio_channel_read_max()
Date:   Thu, 15 Jun 2023 17:26:21 +0200
Message-Id: <20230615152631.224529-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615152631.224529-1-herve.codina@bootlin.com>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation returns the error code as part of the
default switch case.
This can lead to returning an incorrect positive value in case of
iio_avail_type enum entries evolution.

In order to avoid this case, be more strict in error checking.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/inkern.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 872fd5c24147..f738db9a0c04 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -858,6 +858,9 @@ static int iio_channel_read_max(struct iio_channel *chan,
 		val2 = &unused;
 
 	ret = iio_channel_read_avail(chan, &vals, type, &length, info);
+	if (ret < 0)
+		return ret;
+
 	switch (ret) {
 	case IIO_AVAIL_RANGE:
 		switch (*type) {
@@ -888,7 +891,7 @@ static int iio_channel_read_max(struct iio_channel *chan,
 		return 0;
 
 	default:
-		return ret;
+		return -EINVAL;
 	}
 }
 
-- 
2.40.1

