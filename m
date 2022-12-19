Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3439650900
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiLSJDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiLSJCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:02:53 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05403CDC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 01:02:50 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id kw15so19791640ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 01:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=5Rp4mcTJSZ+/bNcPxaj4q2SCzytDdxI+ZDZbCvWyFwY=;
        b=09YmwOcYRbx0IIV+b93s54Yvmrx1RvOGfAmKImQ2A/9Y9uEMozIwEZ73kTiEL6gOsr
         R+5I9ZMMdtIE2EHTkvZ98ZKAXzAnmLhE5HLe2W6VOeTVJvzbB4g7THrCBetDAQxbwqA3
         VD+clHbGbFn/QUQH/BGEoqvx5KiWspJ10iW/0sEKFSl8Dggj8fA0CanPQwpvqG5Kv9bj
         UmCxq0JAjE9jSz4L2dgJmeJBHFvBpIjJQnmw4+PC24qDd4uDYVd/wkcNQ+tzbYQ+gmGd
         pjCduMu43mJoND3I8qx2KFffmtuHlZQx1RnjJThCAEpZxT1478sMVJGKf03ChT4d5USr
         ayaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Rp4mcTJSZ+/bNcPxaj4q2SCzytDdxI+ZDZbCvWyFwY=;
        b=dVMnYBklMF/gOXNtNuFQfZS0gx7EVCNU4tGzeY/Be1EVY+K6eT/TrK+hIdiIzVJRBN
         Zfrh1XWvyygMqXu+Lk4f0QceXqDcj44aYOBg4RTZ826lODyjaIzvwUIflyu4gqq8dx+F
         odWZKcoai0fspaVH0TTcEfv4qvowGdch1RLFnGUre1IIpZoTZNbmueKYK9OyX2Z5YXWf
         4EtQ5X0wevtNmRlZcAm2onjOZrfMvMS7JQJTuMW2DhI6jgHBTV70n55COn1iNFaKCIgb
         htTqaCBvCqVl1ilElgkXtoogbUJhYBJqwXQjpdqm8LqPetH/e9uv1Rl2zAVjyoPyxFq0
         DOvg==
X-Gm-Message-State: AFqh2kqvIKzmiOJTJRKU44NCfFwLXIjEUemAuepb1uwv53xsNoRBY0Qw
        2uTjDxn2cicAwPcnVP3KNKjkWw==
X-Google-Smtp-Source: AMrXdXv7I5y8yp20tcxCivFoH9Pn3z0juo2iGDbm9DR06XD8zFMsm1DX233OMYOQg7Tap8wcTTqw0g==
X-Received: by 2002:a17:906:cb9a:b0:7d3:8159:f35d with SMTP id mf26-20020a170906cb9a00b007d38159f35dmr14327985ejb.9.1671440568517;
        Mon, 19 Dec 2022 01:02:48 -0800 (PST)
Received: from [127.0.1.1] ([2001:b07:5d39:f336:a0ba:cfa5:2107:c2c4])
        by smtp.gmail.com with ESMTPSA id u11-20020a170906b10b00b00781dbdb292asm4082721ejy.155.2022.12.19.01.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 01:02:48 -0800 (PST)
Subject: [PATCH v4 0/2] Make ILI9486 driver working with 16-bits SPI controllers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAKwooGMC/4XNTQrCMBAF4KtI1kbyT+vKe4hIMp3agdpKokUpvbuDSxG7Gt6D980sCmbCIvabWW
 ScqNA4cHDbjYAuDheU1HAWRhmjtQ6y1Mo/z+VGZ+qpdlWQERvv2tZCMlrwLsWCMuU4QMfL4dH3XHZU
 7mN+ff5Mms/xHzlpqWSwyikNKZjGH1J89ZQy7mC8ihODk1lFDCOqchDQQlNb9QOxq4hlxNcQkq8gtW i/kGVZ3hwls9dEAQAA
From:   Carlo Caione <ccaione@baylibre.com>
Date:   Mon, 19 Dec 2022 10:02:36 +0100
Message-Id: <20221116-s905x_spi_ili9486-v4-0-f86b4463b9e4@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Carlo Caione <ccaione@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
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
Changes in v4:
- Removed NAK-ed patch from patchset
- Link to v3: https://lore.kernel.org/r/20221116-s905x_spi_ili9486-v3-0-59c6b58cbfe3@baylibre.com

Changes in v3:
- Added trailers
- Added new patch to use drm_aperture_remove_framebuffers()
- Link to v2: https://lore.kernel.org/r/20221116-s905x_spi_ili9486-v2-0-084c6e3cd930@baylibre.com

Changes in v2:
- Removed SPICC patch
- Reworked commit message
- Link to v1: https://lore.kernel.org/r/20221116-s905x_spi_ili9486-v1-0-630401cb62d5@baylibre.com

---
Carlo Caione (2):
      drm/tiny: ili9486: Enable driver module autoloading
      drm/tiny: ili9486: Do not assume 8-bit only SPI controllers

 drivers/gpu/drm/tiny/ili9486.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)
---
base-commit: 84e57d292203a45c96dbcb2e6be9dd80961d981a
change-id: 20221116-s905x_spi_ili9486-aed54ff3cb21

Best regards,
-- 
Carlo Caione

