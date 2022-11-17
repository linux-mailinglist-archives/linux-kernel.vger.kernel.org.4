Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DBB62D56B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbiKQIsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKQIry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:47:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296E1BCBC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:47:53 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a5so1501165edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=5sycVuNTi+/lWP5w5Y+7Py7HL44YtQg/RIL/+2UUkSY=;
        b=LerjEkGDet8twDf7kawTGEK6yjpahMcCxhAgmIj+Uhp5Y2ToZA2vL105irqZLSsKfU
         c+LQ37p+1ejyh2oDDCwlx+71iys9g+yYbxQOSVTdRIPpMZKMebD3L6vbY7xvoYTj2ysA
         dA+1tq50hVlm9jtGhn6ygV7yQvatY5f62oJr0EllmSAhG1qR9mcE7PHFmrOHZLF2HrTe
         NXS/KTJ2K6dBfbV5Zar4Nm8GSb5Ol6M2VVfam7vqizfUetbz5uvxzdbINt9a3yc7z/yl
         RJqyEWRb93Q8tblau3bK9Yl/7ROUCkYlh+IeZDpHfHy3HSWP8vcLEJ/nu4cLNNs3gNDH
         K6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sycVuNTi+/lWP5w5Y+7Py7HL44YtQg/RIL/+2UUkSY=;
        b=kr4cPolcRXdaBbLtoztwfdOvUGwyKchGPZ8x7dG1J9kpOR5nuPXchr4MP4OCjcMKzQ
         02uoZiMNf0/jBTUoljWg/wumhgxcrEWRQLXLCvwnZJwjPblzhUIgIdovWMRJYr6PBtzb
         0PhnfSdDemgh8pAyk+NQYXCYAHtvqqMLW+URWZWqBB5BSlMsvNYYuSqKwVQGyTLC8LEx
         S3gnZBHSLcyM5bFl/bZSnr1KcbvjSeaoiyk+Ch+Ba1YA4b+r+tsvi0R0kuCUgYg53+b4
         usEpVXJ9WcxKJc9OsQ3CuI2ntcaYcehSHQaJBAbsIq9OeU8qY0wcu5VOjiLedIJ/HKFO
         yp9g==
X-Gm-Message-State: ANoB5pk0KHBR3hbaQa+mRX35jCRFabtMIayAQN9ohR+pcunqlKwXCSIQ
        t8dVyqm7KueKcG11fMW9wY5EGvrmNEd0yZXM
X-Google-Smtp-Source: AA0mqf7JP9+5lVRU9EXpUjP4FKM/FMDReRATO9BwVt89A/oOf+IKkEbT+OEv6hzjSAn10BUJHykrPQ==
X-Received: by 2002:a05:6402:3895:b0:468:15f1:54b5 with SMTP id fd21-20020a056402389500b0046815f154b5mr1306318edb.8.1668674871621;
        Thu, 17 Nov 2022 00:47:51 -0800 (PST)
Received: from [127.0.1.1] ([2a0e:41a:894f:0:7a60:27eb:954c:5ab1])
        by smtp.gmail.com with ESMTPSA id s22-20020a1709067b9600b0077205dd15basm77332ejo.66.2022.11.17.00.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 00:47:51 -0800 (PST)
Subject: [PATCH 0/3] Fix SPICC and ILI9486 drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIACr1dWMC/w3LSQqAMAwAwK9IzhZMXVA/I11SDZQqDYpQ/Ls9zmEKCGUmgbUpkOlh4TNVYNuAO0
 zaSbGvBt1pjYiTkqUb300u3jjyMsyTMuTHIYTeWY1QnzVCymaT3FFnumP8vh/jeo0xaAAAAA==
From:   Carlo Caione <ccaione@baylibre.com>
Date:   Thu, 17 Nov 2022 09:47:38 +0100
Message-Id: <20221116-s905x_spi_ili9486-v1-0-630401cb62d5@baylibre.com>
To:     Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        David Airlie <airlied@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
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

This patchset is trying to fix problems seen on S905X boards when interfacing
with an ILI9486 equipped SPI panel.

The color corruption and the performance issues are actually due to two
different problems in the SPICC driver and in the ILI9486 tiny DRM driver.

We try to fix both in the same patcheset to be able to correctly use the SPI
panel again.

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
Cc: linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Carlo Caione <ccaione@baylibre.com>

---
Carlo Caione (3):
      drm/tiny: rpi-lcd-35: Enable driver module autoloading
      drm/tiny: ili9486: Do not assume 8-bit only SPI controllers
      spi: meson-spicc: Lower CS between bursts

 drivers/gpu/drm/tiny/ili9486.c | 14 ++++++++++----
 drivers/spi/spi-meson-spicc.c  |  6 ++++++
 2 files changed, 16 insertions(+), 4 deletions(-)
---
base-commit: 15f3bff12cf6a888ec2ad39652828c60e6836b3d
change-id: 20221116-s905x_spi_ili9486-aed54ff3cb21

Best regards,
-- 
Carlo Caione

