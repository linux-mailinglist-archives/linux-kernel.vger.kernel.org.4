Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E316736BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjFTMUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjFTMUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:20:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04852128
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:20:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f9b1a117caso18250685e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687263598; x=1689855598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LNI4/zrSq1DwpCr0c5xzZg4jt4/sWJPcC+yHwTLkMI0=;
        b=qHMLiWbpxQ4AIyI31j3BhKs1O21Xf47Q4XnDaAbBPZ8XSEjGUcexY0VmW60iIrHmlR
         TNrHAnz+xuQ/zyVIlXKOIbQyUw5FzlYJhvgR4O3uSo/3BeDYBb3lpRC7qsIcvSXwkVXI
         dydNk/ckN3ZdMi09BN2OsCM8s9oOsH/P/UXhxOSmEHEJFG5zN/fCmptNhIwPRWLZmi5t
         Kh/7eTQ4bSfSAAMx4gMMSBBPz/wIt/BJOlVd87SVhQza1XUON1itUuD1eA0n/GO318hv
         vljI5xjxJPBs5fT9wt0QBTtRQv0I36I2ci9FSzW0W6lJgQB2riG0gL1zedN+9wVLiLIx
         m4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687263598; x=1689855598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNI4/zrSq1DwpCr0c5xzZg4jt4/sWJPcC+yHwTLkMI0=;
        b=ewks0SLczdI577c8Swgs8u+cTiWcRDWti/E6IVji7LRsnS7I3QcAGSJGuo9tMG0JRt
         onEqh1/nEi8T7zt9913GUimja6WBumWkWHno6c05b0Ps3qiPfW/N+2SYluom0bBRbW5D
         W6co/JtWoES4HxOsTmehCOvzjyei6q4VhMxUDwaQQwne0fmo1y8NAOzrJxqxkJhMmjXu
         DZn8C5RTx+N1dFcvd0WAPsyQ/xN889N67qZlbqVchkwdFsVW9mIlm+GlgjOgLsll2smZ
         LvAnarH+zLSWG6zUtTjB+lM+OxA0nKy6I3ZskjnCD6t5T3or8RBJ9fXMsQ8aAnZBcigO
         7Sqw==
X-Gm-Message-State: AC+VfDxOtfoEnPjvBHlh3v9BbB5QHdaE2FjokvxqM8FZJWIxxvck+oWg
        br04y+4gWC7UmSn+NRAIaS8T6g==
X-Google-Smtp-Source: ACHHUZ5hReFUwTrfMO/fdZG3kTWZDy/la39aHY/vTMsgvKliGArpBRddbyAPM/7vBvYOnq+dl8/NpA==
X-Received: by 2002:a05:600c:22c6:b0:3f9:b1e7:8a4b with SMTP id 6-20020a05600c22c600b003f9b1e78a4bmr3205210wmg.21.1687263598308;
        Tue, 20 Jun 2023 05:19:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c210f00b003f18b942338sm2242513wml.3.2023.06.20.05.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:19:57 -0700 (PDT)
From:   Julien Stephan <jstephan@baylibre.com>
Cc:     pnguyen@baylibre.com, louis.kuo@mediatek.com,
        fsylvestre@baylibre.com, Julien Stephan <jstephan@baylibre.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v4 0/3] phy: mtk-mipi-csi: add driver for CSI phy
Date:   Tue, 20 Jun 2023 14:18:45 +0200
Message-ID: <20230620121928.1231745-1-jstephan@baylibre.com>
X-Mailer: git-send-email 2.41.0
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

v2 can be found here: https://lore.kernel.org/all/20230515090551.1251389-1-jstephan@baylibre.com/

v3 can be found here: https://lore.kernel.org/all/20230524083033.486490-1-jstephan@baylibre.com/

Changelog
Changes in v4:
include/dt-bindings/phy/phy.h:
	- remove commit adding PHY_TYPE_CDPHY definition

Binding file:
	- use the standard phy-type property instead of a custom one so
	  rename mediatek,phy-type -> phy-type
	- phy-type property is made optional: when present, describes the
	  phy type and the operating mode
	- phy-cell is modified to accept a phy argument representing the
	  phy operating mode if phy-type is not specified
	- adding new property num-lanes

Driver:
	- add a custom xlate function to handle phy cells
	- update probe function to retrieve the new value phy-type
	  instead of the mediatek,phy-type
	- remove useless struct define `struct mtk_mipi_dphy;`
	- rename some functin/variable from `xx_dphy_xx` to `xx_cdphy_xx`
	- update probe function to read num-lanes property

Changes in v3:
Binding file:
	- rename compatible string
	  mediatek,phy-mipi-csi-0-5 -> mediatek,mt8365-csi-rx
	- rename binding file to be as compatible string
	- change property mediatek,is_cdphy -> mediatek,phy-type using an
	  enum value instead of boolean for scalability
	- remove status property from example nodes
	- rename example node name 'mipi_rx_csi0: mipi_rx_csi0@11c10000' ->
	  'csi0_rx: phy@11c10000'
	- put reg address in lower case

include/dt-bindings/phy/phy.h:
	- add PHY_TYPE_CDPHY definition

Driver:
	- rename compatible string
	- rename property mediatek,is_cdphy -> mediatek,phy-type
	- rename CSIx* macro to CSIX* (x -> X)
	- fix style issue on the driver data structure
	- update MODULE_DESCRIPTION as suggested by Angelo
	  and update the kconfig module description to match it
	- add dphy /cdphy eq tuning function to factor the code
	  and increase readability
	- fix typo __PHY_MTK__MIPI_CSI__C_0_5_RX_REG_H_ -->
	  __PHY_MTK_MIPI_CSI_V_0_5_RX_REG_H_
	- reword commit message to update my contributions
	- added missing copyright
	- added module name in Kconfig

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
  dt-bindings: phy: add mediatek MIPI CD-PHY module v0.5

Julien Stephan (1):
  phy use phy-type

Phi-bang Nguyen (1):
  phy: mtk-mipi-csi: add driver for CSI phy

 .../bindings/phy/mediatek,mt8365-csi-rx.yaml  |  73 ++++
 MAINTAINERS                                   |   7 +
 drivers/phy/mediatek/Kconfig                  |  12 +
 drivers/phy/mediatek/Makefile                 |   2 +
 .../mediatek/phy-mtk-mipi-csi-0-5-rx-reg.h    |  62 ++++
 drivers/phy/mediatek/phy-mtk-mipi-csi-0-5.c   | 331 ++++++++++++++++++
 6 files changed, 487 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
 create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi-0-5-rx-reg.h
 create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi-0-5.c

--




2.41.0
