Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B98631D10
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiKUJmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiKUJmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:42:45 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CC1BC22
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:42:42 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id n20so27297711ejh.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kplxU2lR5aG0mBiBv43tp2KK14DvgQ3747TCEeV3JMg=;
        b=cq8m6/mJPVrF19T4WTdu7gvq/nVLWRDjsh13J+Xr+Nn2iF4Hy9OD9nI54bY967FWG/
         3UOVhClJW4x4n2d97tfeDtKj/uthmhp699BqkgzMipcAj7tJSDny5vG9BdCLomnktnEj
         JLHLZjM0+76mx9DOq+ZPhDpQbUs1EjdA5A8QskH4ttK1DQdid4KKDe5WnlGyued2Rstr
         Jr5nh/9uT/4QkkPRzvI8bD+mOl9SVJHzqYG1WEKJvRVndpiMXm7cxc7b5miDOmV6Uxx4
         nj86LC1IOU+6NmDxVUZhIhYSv6YkCgpUu0klxQEKrS1S9MHECaNaSDIhEyK/W8FZe9Tk
         t+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kplxU2lR5aG0mBiBv43tp2KK14DvgQ3747TCEeV3JMg=;
        b=DRmbY5UwNw6Jg8hZfA8LcHPJtIEaq239aHvx+/9HRp5hGUyERmY6EeU9EQH96QyW5X
         c1lVGPrZWr8tZ6fjMuEqK4gR+RyjBpOuuOoNt9dbuuUeYzQf0HeeJ9H1RDBXorvXY/O8
         Oh1z3CzfLm/9SwGltiHXQ/8cKhWS3WL08V0ktmmfheGaOf4aA9NdX1GIb17DjYbgd/1O
         r3yr1EMqPWPnu162gN8plab+8Uwyww7z4d2fLYNLd8BePB/sNaj0F3p7ilWDNUNgmYMC
         3sjVclKu/oZ+AAt+cFZJp8pGTfsd2ru9IUFzPXanDO6KOvaG+auxzuPJUbx8R1Vdg9rb
         dLaw==
X-Gm-Message-State: ANoB5plR37FYx9/ehZwbK4itUedBa+iNDjqs3mi3l5LHR0fivRyuVeyq
        fH71t5XJCzcm5WzBUu5mbgNTBg==
X-Google-Smtp-Source: AA0mqf4iGDXMlAJ1h8pqCDx2Am2EQUjsXM5qy6Z6ikSWJyeR7/x1T5VoUQJXLLJdiXSkQzAYW6nAog==
X-Received: by 2002:a17:906:a259:b0:7ad:ccae:a30d with SMTP id bi25-20020a170906a25900b007adccaea30dmr15189830ejb.704.1669023760591;
        Mon, 21 Nov 2022 01:42:40 -0800 (PST)
Received: from [127.0.1.1] ([2a0e:41a:894f:0:c97f:bc5d:82d3:1a3b])
        by smtp.gmail.com with ESMTPSA id k11-20020a17090632cb00b0078d3f96d293sm4822240ejk.30.2022.11.21.01.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 01:42:39 -0800 (PST)
From:   Carlo Caione <ccaione@baylibre.com>
Date:   Mon, 21 Nov 2022 10:42:30 +0100
Subject: [PATCH v2 1/2] drm/tiny: rpi-lcd-35: Enable driver module autoloading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221116-s905x_spi_ili9486-v2-1-084c6e3cd930@baylibre.com>
References: <20221116-s905x_spi_ili9486-v2-0-084c6e3cd930@baylibre.com>
In-Reply-To: <20221116-s905x_spi_ili9486-v2-0-084c6e3cd930@baylibre.com>
To:     Mark Brown <broonie@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI devices use the spi_device_id for module autoloading even on
systems using device tree.

Add the spi_device_id entry to enable autoloading for the 3.5inch RPi
Display (rpi-lcd-35).

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/gpu/drm/tiny/ili9486.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
index 1bb847466b10..bd37dfe8dd05 100644
--- a/drivers/gpu/drm/tiny/ili9486.c
+++ b/drivers/gpu/drm/tiny/ili9486.c
@@ -183,6 +183,7 @@ MODULE_DEVICE_TABLE(of, ili9486_of_match);
 
 static const struct spi_device_id ili9486_id[] = {
 	{ "ili9486", 0 },
+	{ "rpi-lcd-35", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ili9486_id);

-- 
b4 0.10.1
