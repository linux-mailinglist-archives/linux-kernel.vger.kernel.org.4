Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E831F631D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiKUJms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKUJmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:42:42 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE5B13D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:42:40 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f18so27188836ejz.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=vamem0qPPK/+qqHyZ7VitfMXhg5vodX1x04ClBWqxyY=;
        b=OUeHTSRpqIyD4R+SqDqs5uhVa9x+OQ2cMnKfV2ZkV4P/IkGNIwZYRZ2VFJBzKqUPbl
         uymtKtNXLwDKBD+QV6MeP4nAhtRwDcMxEkVsDLXgcckmBx2vm7UeLrAtz4aL/pppDhYQ
         a7LBijeewz1qULGcsRntcMNYNtsfxAreJRugrhzxKIOkjgDuaj7eoKwpk3X2u/pELVnA
         ebm4zcczKzNhluBk4StHyjIF3A8MALqdji0MmPPSfR8UVHDyY5idpHdodx1qprpkxTC6
         CNrJsiXqL/tSCWVLPw6GtSUiB4bscMPRbcsLzd2aU3pzsRxRC6OoZm+9OJIu2XJzdktQ
         SpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vamem0qPPK/+qqHyZ7VitfMXhg5vodX1x04ClBWqxyY=;
        b=qtWvVSe8T8pd4BRYfoI/CWipCHlkcJvHkv8m1N8gjadIy8lFd8tFJszdKujgZwjMps
         Y6gSSK384eTx6NQ9yKkHglHvAw7W9ZlC8ohWsbxFfnyeKCri5p8xKktXiIdEOyWWK0wP
         qvN4v6Me/ob4yEVA97Q8LmCX8UyMMs508k9AN7Hm3M3sMs1K/orKtCsCFWA4pDPLlNGu
         t1A4Lxdsd8i1OwvTY2tDchSX7GY7uWRt+8chj+McBuNtVJCUrcxeXUZzMA9gdqCTfhTb
         hxi3Ayakk0dVIF6akcU9fhuOcYwbFkZeDYYxz4GDbn09TUwAKkJ5FjN09BL4HCws0WGy
         DSGw==
X-Gm-Message-State: ANoB5plLeUtquxJXS5souaHJIySly4S1UI/itK7bXb2CCTT2HuxIONwK
        pFQ8y2a3kg0pstmw8ctOuPEc/A==
X-Google-Smtp-Source: AA0mqf4Y/qO5IHzq7wyR8BmivhktsDan+5uOus9RTtHptmY2liXFr5diD78YovU3f96o/KrsaB8d2Q==
X-Received: by 2002:a17:906:cedc:b0:7ad:e8dd:837c with SMTP id si28-20020a170906cedc00b007ade8dd837cmr15613331ejb.264.1669023758927;
        Mon, 21 Nov 2022 01:42:38 -0800 (PST)
Received: from [127.0.1.1] ([2a0e:41a:894f:0:c97f:bc5d:82d3:1a3b])
        by smtp.gmail.com with ESMTPSA id k11-20020a17090632cb00b0078d3f96d293sm4822240ejk.30.2022.11.21.01.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 01:42:38 -0800 (PST)
Subject: [PATCH v2 0/2] Make ILI9486 driver working with 16-bits SPI controllers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAAVIe2MC/32NUQrCMBBEr1L220g2bYP1y3uIlCTd2oWYSlaLpfTuBg/g1/AG3swGQplJ4FxtkG
 lh4TkVMIcKwuTSnRQPhcFoYxDRKul0++nlyT1H7pqTVY6GthnHOniDUDzvhJTPLoWpmOkdYyknltec
 19/PgiWu/yYXVFrZWjcag7dmaC/erZF9pmOYH3Db9/0LqPc1fboAAAA=
From:   Carlo Caione <ccaione@baylibre.com>
Date:   Mon, 21 Nov 2022 10:42:29 +0100
Message-Id: <20221116-s905x_spi_ili9486-v2-0-084c6e3cd930@baylibre.com>
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
Changes in v2:
- Removed SPICC patch
- Reworked commit message
- Link to v1: https://lore.kernel.org/r/20221116-s905x_spi_ili9486-v1-0-630401cb62d5@baylibre.com

---
Carlo Caione (2):
      drm/tiny: rpi-lcd-35: Enable driver module autoloading
      drm/tiny: ili9486: Do not assume 8-bit only SPI controllers

 drivers/gpu/drm/tiny/ili9486.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)
---
base-commit: 147307c69ba4441ee90c1f8ce8edf5df4ea60f67
change-id: 20221116-s905x_spi_ili9486-aed54ff3cb21

Best regards,
-- 
Carlo Caione

