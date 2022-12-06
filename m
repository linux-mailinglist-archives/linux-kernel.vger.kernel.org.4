Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECFB643EB6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiLFIeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiLFIeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:34:11 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04ECF6E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:34:09 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id n20so4533635ejh.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=Ca42HDnAzaNif+afl629upfFjzp/uhKchk5gezZGNys=;
        b=WkyZ7rqxOey/vVPB1CJ2VdlljdAI5pGla1R9B/A3vystAGfhB74ZSGseennRhlzGHD
         CH7tTPGdr1KWnymVVEdJwxMxmSRZK+DY/mF8VdOwU2ddopQhlYRJmhf6YAWNFmYf7tmT
         Ii7Ct6hITejF3eOweUPoEUU4mef9Tn3DAnI5PXZt8fjSjBL/EJh85Uw/Y89AQvgwa3ON
         Cg7VrRTNRC/xHQpoGjRRODNVdjTMeR7ezTiv1kxEusc0RPkS0+H3IRnOAX1MmrxUr8Zs
         3NzeZGvNUwRUMLt4O3l+GokBFxSIAUWN1QLEk/NLLyAgfn6iuQu5Dx92xFYmcik6i4HO
         0sWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ca42HDnAzaNif+afl629upfFjzp/uhKchk5gezZGNys=;
        b=c1Yf7l66MSr3PUKjQdrDXKnzh1NaDHoXNsXGLMi7Y2p4Jm078660zV9jNnOve2ubSs
         l5ZSnlJx3Fh3Af4Tns0sKA3zK3C2T4X6lQXR9YX4ZxbemE4v51IZN3LEoacHlsQvu/Xm
         SGE2qkd9vui67E0HBIvtDaou3YR3cvAu0zPd8s3ZZXRSGrpDgIrjMmcIgsZs8d6himW4
         sGpk1uvUA1xtrQUllpMybsZ7lwU+o/SWePLATWAFPkKZ4RQ0NDgF6ASaonUMUpr0tcZ0
         iUt/oN5kEz8Q2SWliPx4Ym+Z6OvOu+Y9ihB9xo7WpZuN5Y5xYBLFfJncKp5vKYscppPi
         tO1A==
X-Gm-Message-State: ANoB5pnmS3ODdVd9p25R64ZOin/s5VQvuUW5h/2vTBMNNOQRplOMArJy
        nD53b2CtqVh0B3SSQ4fU6Vuu3A==
X-Google-Smtp-Source: AA0mqf5JJQz8h87aHVLqA619Gb7k/7pjbk6XcCV4nl5pWXDqNhBKQ6pGjnWf/cu/qaBdHS2ZZQi3eQ==
X-Received: by 2002:a17:906:f0da:b0:7c0:d609:4120 with SMTP id dk26-20020a170906f0da00b007c0d6094120mr11095894ejb.320.1670315648363;
        Tue, 06 Dec 2022 00:34:08 -0800 (PST)
Received: from [127.0.1.1] ([2a0e:41a:894f:0:2017:359e:18ef:1c49])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b0078d9b967962sm7019390eja.65.2022.12.06.00.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 00:34:07 -0800 (PST)
Subject: [PATCH v3 0/3] Make ILI9486 driver working with 16-bits SPI controllers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAHj+jmMC/4XNywrCMBAF0F+RrI3k1dC68j9ESh5TOxBbSTRYSv/dwaULXQ33wj2zsgIZobDjbm
 UZKhacJwp6v2NhdNMVOEbKTAmlpJSWl040r77csceEnWktdxAbMww6eCUZ7bwrwH12UxhpOT1TonLE
 8pjz8vlTJZ3zL7JKLrjVwggZvFWxOXm3JPQZDmG+sQuBVf1FFCGiNcGCDrHT4gvZtu0N6P88jP8AAA A=
From:   Carlo Caione <ccaione@baylibre.com>
Date:   Tue, 06 Dec 2022 09:34:00 +0100
Message-Id: <20221116-s905x_spi_ili9486-v3-0-59c6b58cbfe3@baylibre.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Jerome Brunet <jbrunet@baylibre.com>,
        David Airlie <airlied@gmail.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        Carlo Caione <ccaione@baylibre.com>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is trying to fix problems seen on S905X boards when interfacing
with an ILI9486 equipped SPI panel.

To: Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
To: Mark Brown <broonie@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Carlo Caione <ccaione@baylibre.com>

---
Changes in v3:
- Added trailers
- Added new patch to use drm_aperture_remove_framebuffers()
- Link to v2: https://lore.kernel.org/r/20221116-s905x_spi_ili9486-v2-0-084c6e3cd930@baylibre.com

Changes in v2:
- Removed SPICC patch
- Reworked commit message
- Link to v1: https://lore.kernel.org/r/20221116-s905x_spi_ili9486-v1-0-630401cb62d5@baylibre.com

---
Carlo Caione (3):
      drm/tiny: ili9486: Enable driver module autoloading
      drm/tiny: ili9486: Do not assume 8-bit only SPI controllers
      drm/tiny: ili9486: remove conflicting framebuffers

 drivers/gpu/drm/tiny/ili9486.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)
---
base-commit: bce9332220bd677d83b19d21502776ad555a0e73
change-id: 20221116-s905x_spi_ili9486-aed54ff3cb21

Best regards,
-- 
Carlo Caione

