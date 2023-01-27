Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06AF67E0F5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjA0KCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjA0KCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:02:43 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E69F27995;
        Fri, 27 Jan 2023 02:02:42 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so5054263wmb.0;
        Fri, 27 Jan 2023 02:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O89v8PjiSY2Ob+iAxk3/FFiEUgZPIgQc0tCql9t2tfI=;
        b=UyXrR+bg1ydL2ojBSqXNvun6Bz+gvr4PWK5WMoIRph5L8gHMc+orGDxqwW47IoOuGc
         ixUV0AOv6PWCjwb5nh4xdfsIgdRyQ/OzndemjD1Vc+kLRK8hMYb+GNjX7v6SmVAhfNiU
         FcnMbja2IboZGMAs2HUiWHM0HYxn7LGHyy4NnUEKpoqsIPVxWDm19FvPonZ2/Ebzl2Mu
         tdCSoc6ZKcAme74+oDq/CiprG9KVW2e4vOe3ZfsmFqsD3WZam1KWzvlSaaFDWyNMdMIB
         e3gYCeNsn0VwqgXqh+3V+qX4TQqe2Rs0DVav52PpFPLtfFZX/2awn1RDh8ciP9NamkW7
         yE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O89v8PjiSY2Ob+iAxk3/FFiEUgZPIgQc0tCql9t2tfI=;
        b=1hzM5dVy8KDpC3e9qJmC30NoHurmMkfRWH0TC3eTIaTL5TUuINa0Qs0tizghOdAgeU
         0W4l3Fm8utr3E3FVfH5j3t/INxz+nqS6+KOLKKb7Kn6ir+dM/Pl2SdDK+6HtfmAZJ795
         mv/RU0MGaa/jGbudf56K1XRkCER356Y8rYCc42osejpDZrVyfk+jkolbUTAbdYsUTggj
         jzdbtZr/xGCPZMjcm75y6fBii97C426hH30vXlT32EInBxxbLXt2wUz6aCXtUb9myW2P
         awbQl8vxY/kSaU5PS+VhHbxoT2Z5RomyWuYPmG8N8/I2NKJH07q5auTdliUo2ZhiSlmu
         SFAA==
X-Gm-Message-State: AFqh2ko0iPJQXVAoXYvBqS6hHgSfFbzwDDZpGMInjs8eJcSHf8xHc1pF
        HCJ54h9boQufvAlPt/Gp48EhNmMJ926fkg==
X-Google-Smtp-Source: AMrXdXtkWYRA8cMy4G2V+sVUZLnfg2D23SMqOBSXdHG8ruxBWXGvFGzVXu2CIHdbSOkOgSzUvke+yQ==
X-Received: by 2002:a05:600c:4fd3:b0:3cf:7197:e68a with SMTP id o19-20020a05600c4fd300b003cf7197e68amr36864687wmq.18.1674813760868;
        Fri, 27 Jan 2023 02:02:40 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id l7-20020adffe87000000b002bfbe30e8f8sm3493858wrr.98.2023.01.27.02.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:02:40 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/4] arm64: dts: meson: fix BPI-M5 and add BPI-M2-PRO
Date:   Fri, 27 Jan 2023 10:02:32 +0000
Message-Id: <20230127100236.3385154-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch in this series fixes an SD card (re)boot issue on the
BPI-M5. Susequent patches convert the (fixed) dts into a common dtsi
to support the addition of BPI-M2-PRO which is based upon the BPI-M5
board design.

Christian Hewitt (4):
  arm64: dts: meson: bananapi-m5: switch VDDIO_C pin to OPEN_DRAIN
  arm64: dts: meson: meson-sm1-bananapi-m5: convert to dtsi
  dt-bindings: arm: amlogic: add support for BananaPi M2-Pro
  arm64: dts: meson: add support for BananaPi M2-Pro

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/meson-sm1-bananapi-m2-pro.dts |  98 ++++
 .../dts/amlogic/meson-sm1-bananapi-m5.dts     | 427 +----------------
 .../boot/dts/amlogic/meson-sm1-bananapi.dtsi  | 435 ++++++++++++++++++
 5 files changed, 536 insertions(+), 426 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi

-- 
2.34.1

