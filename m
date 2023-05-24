Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492A770F0B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbjEXIat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjEXIas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:30:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2859E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:30:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30959c0dfd6so463266f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684917044; x=1687509044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kffM2qOd8UySQXRHCzIS0BeFu6Pjgruc1iNUigvygb8=;
        b=TrQn2EijrNey35nJ4xgpghuPuNSrvgrfBZjIxo8csQh6I1eaXFFYJISM7dXKj1+92/
         bTgTyOVd0m+OAduhxhN/IHEjxY9KQrHQFx0b8TfDbO1amxKvnwAmY0wr06vA99olLews
         tbxmwz3MeJ+bpNt/W4UcTZbAaGVPov+9EjNBO2fdXCitmVSSsRSwYX70okXZWAqtDU58
         Pvlw6frc5B8bW8yah2SWWEfYRqzrvLh00WLLEeHhvDAH8CCfGwj3bSbuM8YaEf1KR4yp
         MDTRv+/fDWL15PFeMb0jw6CnsaB5HN6og5AMXKNxw9torqW5G3CWMgEMndLpudAz7kxc
         vU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684917044; x=1687509044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kffM2qOd8UySQXRHCzIS0BeFu6Pjgruc1iNUigvygb8=;
        b=bYptU+xof9dJCYyVgcuiUjsa4fO6JoB2uvHEUWbBC2osCBUP9VctqxzaxgA5OWx1IH
         UIo3x5DkCLp2I61R7/XzlunXgIdEZ9Lr128ftQkm5sdVIXnr1ECFafuEtk2Q58yho2jE
         A7fwh0S/RG2/FFNZlsJe2DtZh+ePSB6uNsWiwdkHwhBG7ISex5bvdVBYmKxp4Ut7dbUV
         pXcL0zjkbjZbFkimR/OOLKVNbaMC271qUkqAF9fxVQXBu3hAVKTcj7q56rGG539T+/or
         Z4WFh/OuizYNX1krX/q5xdtC4rMzWJ20dFQHo8f9hC/Vh8BXyPp2RtTJPJEP90QA176r
         3Hgg==
X-Gm-Message-State: AC+VfDyvrOj2Nls2iN1GIJGaiNUGwd2dVOFSO8U/aRT2aD4HpHxztL/T
        R48wXc1Qceyaeijcwn39c/1O0A==
X-Google-Smtp-Source: ACHHUZ6RKUgi2r3+ULkAZkHhThnj59JBpVMuBR0BTeba5BRaxoHn2ulZhXc1hJPCT/6mYxsCf65d+Q==
X-Received: by 2002:adf:f103:0:b0:309:509f:a7ef with SMTP id r3-20020adff103000000b00309509fa7efmr12077478wro.67.1684917044126;
        Wed, 24 May 2023 01:30:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d484b000000b00307c0afc030sm13871832wrs.4.2023.05.24.01.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 01:30:43 -0700 (PDT)
From:   Julien Stephan <jstephan@baylibre.com>
Cc:     mkorpershoek@baylibre.com, khilman@baylibre.com,
        Julien Stephan <jstephan@baylibre.com>,
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
Subject: [PATCH v3 0/3] phy: mtk-mipi-csi: add driver for CSI phy
Date:   Wed, 24 May 2023 10:30:29 +0200
Message-Id: <20230524083033.486490-1-jstephan@baylibre.com>
X-Mailer: git-send-email 2.40.1
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

Changelog
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
  dt-bindings: phy: add PHY_TYPE_CDPHY definition

Phi-bang Nguyen (1):
  phy: mtk-mipi-csi: add driver for CSI phy

 .../bindings/phy/mediatek,mt8365-csi-rx.yaml  |  68 +++++
 MAINTAINERS                                   |   7 +
 drivers/phy/mediatek/Kconfig                  |   8 +
 drivers/phy/mediatek/Makefile                 |   2 +
 .../mediatek/phy-mtk-mipi-csi-0-5-rx-reg.h    |  58 ++++
 drivers/phy/mediatek/phy-mtk-mipi-csi-0-5.c   | 272 ++++++++++++++++++
 include/dt-bindings/phy/phy.h                 |   3 +-
 7 files changed, 417 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
 create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi-0-5-rx-reg.h
 create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi-0-5.c

--
2.40.1
