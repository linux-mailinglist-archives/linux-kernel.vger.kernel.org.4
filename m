Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76E4605A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiJTJDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJTJDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:03:14 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EB41958DA;
        Thu, 20 Oct 2022 02:03:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t16so9662263edd.2;
        Thu, 20 Oct 2022 02:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rWGlafMlqwMwhfThN+R1n4/HH5vIykVnEuONb/Vfvk=;
        b=R6aBFYyUxc69y4wyygkhgEBYwbcwUcvtxKjhr8gKfQ8AA7m7u02wwLwXGdMO1YV31E
         l4Mxx4f95bNxd3X4xo1swAZzPVT+qBzSYuIaJ0MWf60a3aYmh9szneYPat6X6STUDeyl
         Q/2ELfV4LPBAvugtqWC+e6C3tzRawDHo0jX4AxC0pSSmWbyVrOz35GAS1vTPfYawptWi
         SQYCJmAKyt90Lery+QzwhMOzsx95qkxgSLesSd3AoaRjihn4dHCh34Fg9v68x98sBxgg
         bu/RbL2Tw5ZkD8wp1Bab7UiKyDS9L3MXyPLMLWM1jknKgeYrzlZViGABLzNFtyia+qB6
         qkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rWGlafMlqwMwhfThN+R1n4/HH5vIykVnEuONb/Vfvk=;
        b=VCYQCE8OYhhEkoRda0/1ZOIqC750IR0v1kfWk8hbB074fhQ0HPCzxT++S6T5kzhx4f
         xgltbbLwNjC5vscwF7PtxDNMK+87xNpvYFVmkrB1xLQ7CDHpujSQbGrV/fL1guoYkZDs
         nvpckggY5N7r8E0SrSly/eFSpT0Eyu2ScwdK6MhUlfeR/jFYemnDgK/nv5EnmgbRHCbw
         OUKKkLyBBdOtnWwP0NFP0h1+NvpW86NU51CUg25Q/+y843YUeBHKvjWilXcqDZUCGtGf
         KGLhYX4wI/TUOpSvfkgRuxGH9ZrbaBgtjrX+8zY0AQZvkWvLuCTKv7CUIOkPu6ujRrwL
         LkRg==
X-Gm-Message-State: ACrzQf1FxQ5Od1yB174y2AS2BGfuIOY9N3cIvzNecHdyQttSGyK0IKNf
        33agW2b50HiEpEgdCmaJ0Sxp/w3uiDw=
X-Google-Smtp-Source: AMsMyM41DfTFG7HhSGfOEGWjw+IIHt7WaisYCPMpWSGvZ3phYuDdGHMyA1xuSYKBWIJL3l6KcZ3JSA==
X-Received: by 2002:a05:6402:f96:b0:459:4180:6cf4 with SMTP id eh22-20020a0564020f9600b0045941806cf4mr11307056edb.64.1666256591948;
        Thu, 20 Oct 2022 02:03:11 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b007933047f923sm1668381ejf.118.2022.10.20.02.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 02:03:11 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v2 1/5] iio: temperature: ltc2983: allocate iio channels once
Date:   Thu, 20 Oct 2022 12:02:53 +0300
Message-Id: <20221020090257.1717053-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221020090257.1717053-1-demonsingur@gmail.com>
References: <20221020090257.1717053-1-demonsingur@gmail.com>
MIME-Version: 1.0
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

Currently, every time the device wakes up from sleep, the
iio_chan array is reallocated, leaking the previous one
until the device is removed (basically never).

Move the allocation to the probe function to avoid this.

Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index b652d2b39bcf..a60ccf183687 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -1385,13 +1385,6 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 		return ret;
 	}
 
-	st->iio_chan = devm_kzalloc(&st->spi->dev,
-				    st->iio_channels * sizeof(*st->iio_chan),
-				    GFP_KERNEL);
-
-	if (!st->iio_chan)
-		return -ENOMEM;
-
 	ret = regmap_update_bits(st->regmap, LTC2983_GLOBAL_CONFIG_REG,
 				 LTC2983_NOTCH_FREQ_MASK,
 				 LTC2983_NOTCH_FREQ(st->filter_notch_freq));
@@ -1514,6 +1507,12 @@ static int ltc2983_probe(struct spi_device *spi)
 		gpiod_set_value_cansleep(gpio, 0);
 	}
 
+	st->iio_chan = devm_kzalloc(&spi->dev,
+				    st->iio_channels * sizeof(*st->iio_chan),
+				    GFP_KERNEL);
+	if (!st->iio_chan)
+		return -ENOMEM;
+
 	ret = ltc2983_setup(st, true);
 	if (ret)
 		return ret;
-- 
2.38.1

