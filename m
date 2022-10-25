Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B826260C636
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiJYITB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiJYIS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:18:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D90C2C96;
        Tue, 25 Oct 2022 01:18:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k2so10617361ejr.2;
        Tue, 25 Oct 2022 01:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq+6K44iGtvwt7RZnqV6tCJGlCcDC94XFaEhvgeSpes=;
        b=ETxSDcIZrrSrZGIQdBGYPcZq6/mykFB26hAVtUCorr9T+q04n6MOVfv4vdEq1i7DYZ
         wKC1EudemHm4VQdgNAeM/40POVtlz48h5VO6jiL7IYdcOYyUZySxFLQjpSrZ+zrEH4aA
         DH7Jz7dctc9eTYnt/kAY8sauTBABkZpBACSGuVPwJ97K4ymEag5acp7FV71Scj8qEyY2
         8j+5D+/ebr6ZR/SZi6+bisIZzm9JqJ7wQFNyw//YwFARWGf1+XRlYa3W5VUz36ubPgha
         3Z13MWZrGtfwMp+lA76dJE5FarrC05oJ/fhgY3SvBjNPGP3sNFSjGBYJDWyALghEWQNG
         0+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nq+6K44iGtvwt7RZnqV6tCJGlCcDC94XFaEhvgeSpes=;
        b=PiDzLY/iojkPn3T8aGH6vp6TTwXtIh6IOjav6xg0vkuIsMzDUFytzexQ7Hh+SZNEDs
         SFRviSmDr+ZFLHtsdqBo4eU3iUWzPRkauxuA9Ryl4WoAFzX33O29/5sKJSOXorSL9VOi
         fZvJLXeQsZtiem0nIBCVMpiA0T7hyNduZtKqApn0CIaG6syEZEhTCIT0QL9i4I4v+hZS
         Y0LM5/YIC76E4mVXCljrPhP0Lgn0V9clN6jaL7ul9W8AChFRRd6OEKUwPnZ0YzFMIoOb
         8tUZCmT8SyV1LMEdZQ/X10QYpaHHCOk/vzD5gqPUjpZ7jOBR+LBf+Lnv4Z8dJhZleFaU
         wt3g==
X-Gm-Message-State: ACrzQf1EvyO4M+ucY3vXVQNWZGCGJtwTsgm54gfS3eWqWjSWjjHjPQdg
        bNvsm1Xi1GaloPmQBCxdpsU=
X-Google-Smtp-Source: AMsMyM4YrvVpyZpY2KRA9fIGHYRJVv2wPNdJaKJZgwsk8uR/zgZl6fvzbveluH1eOaHiag6VsD0ngQ==
X-Received: by 2002:a17:906:fd84:b0:730:acee:d067 with SMTP id xa4-20020a170906fd8400b00730aceed067mr31520230ejb.206.1666685935948;
        Tue, 25 Oct 2022 01:18:55 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709060cc100b007822196378asm992898ejh.176.2022.10.25.01.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 01:18:55 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v3 1/4] iio: temperature: ltc2983: make bulk write buffer DMA-safe
Date:   Tue, 25 Oct 2022 11:18:39 +0300
Message-Id: <20221025081842.1896748-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025081842.1896748-1-demonsingur@gmail.com>
References: <20221025081842.1896748-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

regmap_bulk_write() does not guarantee implicit DMA-safety,
even though the current implementation duplicates the given
buffer. Do not rely on it.

Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index b652d2b39bcf..ca1bb5f48988 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -209,6 +209,7 @@ struct ltc2983_data {
 	 * Holds the converted temperature
 	 */
 	__be32 temp __aligned(IIO_DMA_MINALIGN);
+	__be32 chan_val;
 };
 
 struct ltc2983_sensor {
@@ -313,19 +314,18 @@ static int __ltc2983_fault_handler(const struct ltc2983_data *st,
 	return 0;
 }
 
-static int __ltc2983_chan_assign_common(const struct ltc2983_data *st,
+static int __ltc2983_chan_assign_common(struct ltc2983_data *st,
 					const struct ltc2983_sensor *sensor,
 					u32 chan_val)
 {
 	u32 reg = LTC2983_CHAN_START_ADDR(sensor->chan);
-	__be32 __chan_val;
 
 	chan_val |= LTC2983_CHAN_TYPE(sensor->type);
 	dev_dbg(&st->spi->dev, "Assign reg:0x%04X, val:0x%08X\n", reg,
 		chan_val);
-	__chan_val = cpu_to_be32(chan_val);
-	return regmap_bulk_write(st->regmap, reg, &__chan_val,
-				 sizeof(__chan_val));
+	st->chan_val = cpu_to_be32(chan_val);
+	return regmap_bulk_write(st->regmap, reg, &st->chan_val,
+				 sizeof(st->chan_val));
 }
 
 static int __ltc2983_chan_custom_sensor_assign(struct ltc2983_data *st,
-- 
2.38.1

