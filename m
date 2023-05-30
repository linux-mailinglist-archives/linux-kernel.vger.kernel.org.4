Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EC87157A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjE3Hxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjE3Hxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:53:35 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8085EEC;
        Tue, 30 May 2023 00:53:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6e72a1464so27541355e9.1;
        Tue, 30 May 2023 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685433209; x=1688025209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTV9XMaou7CNV6EOfKarXq32Ih9qfYOfAXq7949Wo3s=;
        b=i3pP6u5EQ1lX1blR3asUXta00++/WeAJzJYpjVbmSSnNnM9b0JsK9O6GJxJK/PnERk
         56eVs5Po9NTUHfW2hNAACiHF+mLRFee1xbwQ+xaakXR3hY3zSsjqctQxj1NeKlUedHyJ
         v1BTlRzG5hfyJyh1+k8+YeUErve3Bo3YKYy7toHOX/e+ktdMhGud6tmX2SWmSp6F7cpV
         yiGznVv7RIvdwo1swh6I+DgEuy18fKjE8FtSg8XQ49BPVrDgzkRQ6J0A56GCpFWPr/hh
         eZC6V8HS505ZzoT2UAGRtRiiJ9+t+p4on4MYJyeLURencqsibXnxwHaOp7bYSgWSYhk/
         p/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685433209; x=1688025209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTV9XMaou7CNV6EOfKarXq32Ih9qfYOfAXq7949Wo3s=;
        b=ABXH0hKcXQWMdMcPGx+bxkdru7D56oedUxpIm1zUnqKdwrZH7hbp/Shk5uMrZNas4E
         0oVWVKWhtegswXXFV4QD8EkfKYK2cShgJHpXBsN75zO4WsnUHAM/dFAaYfFzLJgLBQGR
         wSA5CGkDdfIxAZ08hEMtDqrGJg4Ft2DpFszvRllRznRnDVS8sWulLePq4SRohVZ3T3HB
         281aMW768WfcbfJBt3qDvN79QqooDQ7YqZkWkh6Bc6rn295fUwSF9h4FNwxq3DC4tcnB
         oy0aYEnl+lHg5pGMqWlrNfafHREOEbejJ8sz/6BAkBXxOZrWzWkviiA3mKKKSZdeRF2a
         SqHw==
X-Gm-Message-State: AC+VfDyIS+60A3oOFNUlD2zq/27A2n5UBZkDe1ZkzWizSzKjYR62h/Ls
        sT2VH6jBq7cZ3qyTsfxGH94=
X-Google-Smtp-Source: ACHHUZ4/Os/xLZi9cKZd+cacH8GtfF0POVlxwYmzZcphgLW5DEqstlcIruTXf+kmAjOZbVhQb4TQ8A==
X-Received: by 2002:a1c:7313:0:b0:3f4:2266:8cf0 with SMTP id d19-20020a1c7313000000b003f422668cf0mr872277wmb.10.1685433208715;
        Tue, 30 May 2023 00:53:28 -0700 (PDT)
Received: from PC-UT2.ad.ennebielettronica.com ([78.152.97.130])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c21d500b003f6041f5a6csm16561275wmj.12.2023.05.30.00.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:53:28 -0700 (PDT)
From:   fl.scratchpad@gmail.com
To:     jic23@kernel.org, Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 1/5] iio: adc: ad7192: Fix null ad7192_state pointer access
Date:   Tue, 30 May 2023 09:53:07 +0200
Message-Id: <20230530075311.400686-2-fl.scratchpad@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530075311.400686-1-fl.scratchpad@gmail.com>
References: <20230530075311.400686-1-fl.scratchpad@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrizio Lamarque <fl.scratchpad@gmail.com>

Pointer to indio_dev structure is obtained via spi_get_drvdata() at
the beginning of function ad7192_setup(), but the spi->dev->driver_data
member is not initialized, hence a NULL pointer is returned.

Fix by changing ad7192_setup() signature to take pointer to struct
iio_dev, and get ad7192_state pointer via st = iio_priv(indio_dev);

Fixes: bd5dcdeb3fd0 ("iio: adc: ad7192: convert to device-managed functions")
Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad7192.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 55a6ab591016..94a9cf34a255 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -380,9 +380,9 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
 	return clock_sel;
 }
 
-static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
+static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
 {
-	struct iio_dev *indio_dev = spi_get_drvdata(st->sd.spi);
+	struct ad7192_state *st = iio_priv(indio_dev);
 	bool rej60_en, refin2_en;
 	bool buf_en, bipolar, burnout_curr_en;
 	unsigned long long scale_uv;
@@ -1073,7 +1073,7 @@ static int ad7192_probe(struct spi_device *spi)
 		}
 	}
 
-	ret = ad7192_setup(st, spi->dev.of_node);
+	ret = ad7192_setup(indio_dev, spi->dev.of_node);
 	if (ret)
 		return ret;
 
-- 
2.34.1

