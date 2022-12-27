Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD46566E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 03:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiL0CgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 21:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiL0CgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 21:36:14 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F3DC68
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:36:13 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id jr11so9624853qtb.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vtremblay.dev; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI0zO948M7Usl6Mh9jnJL/dQvMAibdS+Nj8w4BoMGME=;
        b=kDp212TWBINw212tyfVcBrg6aIGbE5iwcI+XNzxugxoeQ6FmSBcrU5H9km8lJmwRSP
         E5NA94s5LcCSTiBf6wn9xWJfPEXwsaTUnbigCwqJhlxfilq/2FZQiKb1lqvsnFq5/YKI
         JoAp6YMYstfGQ2YN54U6fcsaAqJzQo5QIbsJKTvCvB9ZkReC/p5f9xg5AJM3qJ0xR14o
         OD1rIomKmKa6FT1VwDKsUMobTU3arij5/gxAm10ZXVg/WaUhwlbE7omCmTu9LW2/sSyr
         slMpt82oDP0j75vPmVA1Wub7PFaRwg78dZxfHmQ3SQGuI/e6hRiH9OEp6YjJ6Oviy7S5
         VVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OI0zO948M7Usl6Mh9jnJL/dQvMAibdS+Nj8w4BoMGME=;
        b=h1suvbaD0H87JDCAqO/ZnNt2R9XGdCLWE6D312QsDNhmhbvDYTpwQiGMMNiEWYHe5j
         z0dOHOYUUvuf+wk1xmTmCTxo6oMWGAzcGNd+75mfk/lmf0+oaQe46uhi8tNp3Do1jKWU
         qONBMNzUHMVMy5gqihAZp/wUNocXfsWYMr90b7o5nCA0ftaUG0ETG0NFBKJKm2FOi5d+
         Yojh8E0KsjxH/eqteQozISBnJx5bvMfnFfA5ESTBb3EXI1CAe54BD5lNxozN3ZFZk6u6
         S1IeycfrmFTDRKZRXCNFV4QQuHWET+PhefSBfZ2DLC7a51TAJ8KeaiPIMu1VzjF0fZQ1
         i5/A==
X-Gm-Message-State: AFqh2kqVIGpYyPnOk8gpwJ6VNkJSlD01kdhy1z8Zvjf41bvkYQXNJbsZ
        Lii1vL4Hs5pGOP2x8ZSVsClZcw==
X-Google-Smtp-Source: AMrXdXvq0+yjcebqLKcA4+wy9C5HzvVhAnP5rXJNCVgr9M0cSlodEIE3Z4uTv9Du8jMG2JpnnBtZLw==
X-Received: by 2002:ac8:7583:0:b0:3a7:eb2c:efea with SMTP id s3-20020ac87583000000b003a7eb2cefeamr28495539qtq.19.1672108572568;
        Mon, 26 Dec 2022 18:36:12 -0800 (PST)
Received: from vtremblay.. (modemcable190.194-177-173.mc.videotron.ca. [173.177.194.190])
        by smtp.gmail.com with ESMTPSA id l8-20020a37f908000000b006fcab4da037sm8612322qkj.39.2022.12.26.18.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 18:36:12 -0800 (PST)
From:   Vincent Tremblay <vincent@vtremblay.dev>
Cc:     vincent@vtremblay.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Marek Vasut <marex@denx.de>,
        Samuel Holland <samuel@sholland.org>,
        "Greg.Schwendimann@infineon.com" <Greg.Schwendimann@infineon.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v2 2/2] spidev: Add Silicon Labs EM3581 device compatible
Date:   Mon, 26 Dec 2022 21:35:48 -0500
Message-Id: <20221227023550.569547-2-vincent@vtremblay.dev>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221227023550.569547-1-vincent@vtremblay.dev>
References: <20221224041825.171345-1-vincent@vtremblay.dev>
 <20221227023550.569547-1-vincent@vtremblay.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Silicon Labs EM3581 device.

Signed-off-by: Vincent Tremblay <vincent@vtremblay.dev>
---
Changes in v2:
 - Add missing documentation in trivial-devices

 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 6313e7d0cdf8..46f53ca03f8d 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -702,6 +702,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = "m53cpld" },
 	{ .name = "spi-petra" },
 	{ .name = "spi-authenta" },
+	{ .name = "em3581" },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
@@ -728,6 +729,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "micron,spi-authenta", .data = &spidev_of_check },
+	{ .compatible = "silabs,em3581", .data = &spidev_of_check },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.37.2

