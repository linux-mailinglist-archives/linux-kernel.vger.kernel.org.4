Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288CC7028EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbjEOJi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240577AbjEOJic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:38:32 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A774E53
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:35:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f423ac6e2dso60113865e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684143351; x=1686735351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWC2hVWzxMHKmiP7bFd1/GNl9QWA/6DrOTG6WDSUnGM=;
        b=hZK1cRCcwAWJjnEp08UbvM3yYnHbU6+YYpxypZ/VKSjb+Fm8fnIX1oXzoBWfWxL3L/
         RzDu8R5AgRibMuAQW6IvIFRbe+xPws7vaBdtMd4ELJ/1nfKw5Ujltx7Bh+nWTBbZBgky
         k0+F+pLAaVJaq94+6i+IcrRF30zI9opSGja9Dsh773EybaWv9hAakHA//0Fz7OQFth/B
         AELOd0CVGszxsikSE23TUoca9hX5VRhRpDrwdOsL1wfzxK7FgX7N7tfjmWRMGD3FUdIe
         Xdp9HfzdhX4c5EJm6XAQ5OuYE2rOIibgU6OV8UnUvi7V6Ai2DhMpi7UEvZj3qM3RnrjP
         y00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684143351; x=1686735351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWC2hVWzxMHKmiP7bFd1/GNl9QWA/6DrOTG6WDSUnGM=;
        b=HNyMbBvDg4efGc7RSI+1TpRXNP+cK6CTDJOtYGA+ZUa4p6fLtTnSBPmf5imidHcC7a
         Pg1Edt8L38LVGwQX/iJj6lyicSdqV2m9CxpHvahpijnhgS7l/Pzo9y8Bd31DrDbvos+H
         YNYvE7KK6qgJ3JQ3IhVSExK1i66A/3IgXXk4Z/OOqHVL5O2317ahhjWvWN6+krVFNi+7
         EGR0gfUxl9PfgUBrgGtTjJZHUIOJWDEHzMVFkJ0zFHPb+V4/NIgf/NHOkMUeSeupc5SE
         a+T3WhRNF9s618bTlkBeJsFSgYBFIQuKwxREBv2Px5B5ZfgMj3iUNdqwDA2qrA+EO1q8
         9XzQ==
X-Gm-Message-State: AC+VfDyF3C7TH4gfGnx+8LYZf41WlKhbevJz30avbntMTUhjFOIzNAWz
        8lSoIt5qUtNCt8H2DZJYxI/LE+5+jd0YiObUcvIxdA==
X-Google-Smtp-Source: ACHHUZ6BE/4NK3YHHcWl6EMaCJsUPOYAbAUFdxrDuJwCuPnwJVcVddpO9nt3uz2QQDMX9l56Iz2HyQ==
X-Received: by 2002:a7b:c4c3:0:b0:3f0:7ddf:d8d8 with SMTP id g3-20020a7bc4c3000000b003f07ddfd8d8mr23309590wmk.18.1684143351524;
        Mon, 15 May 2023 02:35:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:fd3b:9fed:e621:cc8f])
        by smtp.gmail.com with ESMTPSA id z22-20020a7bc7d6000000b003f42813b315sm21035451wmk.32.2023.05.15.02.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 02:35:51 -0700 (PDT)
From:   Julien Stephan <jstephan@baylibre.com>
Cc:     krzysztof.kozlowski@linaro.org, robh@kernel.org,
        chunkuang.hu@kernel.org, linux-mediatek@lists.infradead.org,
        Julien Stephan <jstephan@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v2 0/2] phy: mtk-mipi-csi: add driver for CSI phy
Date:   Mon, 15 May 2023 11:05:49 +0200
Message-Id: <20230515090551.1251389-1-jstephan@baylibre.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a new driver for the MIPI CSI CD-PHY module v 0.5 embedded in
some Mediatek soc, such as the MT8365

This driver was adapted from https://patchwork.kernel.org/project/linux-mediatek/cover/20200708104023.3225-1-louis.kuo@mediatek.com/

v1 can be found here: https://lore.kernel.org/all/20230403071929.360911-1-jstephan@baylibre.com/

Changelog
Changes in v2:
	- fix all comments on bindings
	- move the binding chunk from driver to binding commit
	- fix dt_binding_check error (reported by DT_CHECKER_FLAGS)
	- use a more generic compatible string
	- add a new dt properties to simplify the driver
	  "mediatek,is_cdphy"
	- rename the driver and the corresponding file to include
	  version
	- drop of_match_ptr()
	- use devm_platform_ioremap_resource
	- use phy-mtk-io.h api instead of regmap
	- rework the driver to use dt nodes to declare PHY instead of an
	  array in the driver
	- remove useless define for unused registers
	- remove support for CSI0A/B because it cannot be tested, and it
	  simplifies the driver for a first review
	- edit commit message and bindings to be more descriptive about the
	  hardware


Florian Sylvestre (1):
  dt-bindings: phy: add  mediatek mipi csi driver v 0.5

Phi-bang Nguyen (1):
  phy: mtk-mipi-csi: add driver for CSI phy

 .../phy/mediatek,phy-mipi-csi-0-5.yaml        |  62 +++++
 MAINTAINERS                                   |   7 +
 drivers/phy/mediatek/Kconfig                  |   8 +
 drivers/phy/mediatek/Makefile                 |   2 +
 .../mediatek/phy-mtk-mipi-csi-0-5-rx-reg.h    |  58 ++++
 drivers/phy/mediatek/phy-mtk-mipi-csi-0-5.c   | 257 ++++++++++++++++++
 .../phy/mediatek,phy-mipi-csi-0-5.h           |  15 +
 7 files changed, 409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml
 create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi-0-5-rx-reg.h
 create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi-0-5.c
 create mode 100644 include/dt-bindings/phy/mediatek,phy-mipi-csi-0-5.h

--
2.40.0
