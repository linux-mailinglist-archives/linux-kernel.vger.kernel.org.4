Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD546D3DFC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjDCHT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjDCHT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:19:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2838527B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:19:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n19so16465433wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 00:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680506394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Irg/7rQOFrCsVoB1iKX7cg5MWHzQ1y6ZxDuwYrAWoc=;
        b=33vMDoof/ZVt81quDw5pnXR13jpzPdm9umpWVlgwR2kX1snECZjf8SVg3318ZHkynS
         oZj5iitilotfk9jFK+Kk4IsQsAy6spce0tyzYBeypUr2WnGS2fH+yUzho1gv5Cg4qzNv
         xy/imFHPDQRbcSJaIP1vLSw4HnJO7hzc4c+0OFXzp6LdX/ZHh9PQvHznBzdKQrnM/pWJ
         ICMZLc7DNc9lN9DyeEeOqFL2JnL3U5a/CELckzzyNjAF9EhD9rKVG41hlVxmJ1S7vfCj
         mqlrCiBKi/1U2Itd5QCHzg+1CG9bjrOOBTAK3/eCbeISg2jnCYPytIleP1xTzFZPZmZ+
         ZVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680506394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Irg/7rQOFrCsVoB1iKX7cg5MWHzQ1y6ZxDuwYrAWoc=;
        b=BD3qQxLn5ZgmfJaWvw1wF2HZCaQInm/38jKqjiL3Pil+aslUHDvBf2PN39JSngQH2q
         6njQOujby+bfuIc6Ii3GwKb69n1Sf7adBzjVbsc5FPurHfJjzein2zOPQylSl4mBT0dJ
         vzM7YWjeDwqM5YNS1wyYUtIaeA0nfihp1z10mT04JAiUbxGNKVfmn+NQVo0lB7dOaQC5
         nqpNIYJ+mCWlnzC7XiH4W287CZsbAB0yVOGOkhxYsiRAhXGOBPXQ8l0/5A8TdGmODy6R
         U7fIEMSHMPMhx61KqU6Yftw1UnQ7rdTiWZuqRkqlHo189adnAwqbEdSGVq8fpU1fREpM
         +tlA==
X-Gm-Message-State: AO0yUKXJGYZsrpbrDCqQzHa08IxR064zq0C1m5jdavuGdL44WgD50uBC
        XxG1Fy2zYrt3XiCZJ6D2sFlIgw==
X-Google-Smtp-Source: AK7set9uKvwjGwiUFvXKdrCeAqnDtu//P693C2rybBYt42PMluDg39NjT9MnI3jWTkA0+bq3jSQ2fA==
X-Received: by 2002:a7b:c4cb:0:b0:3ed:253c:621b with SMTP id g11-20020a7bc4cb000000b003ed253c621bmr28390520wmk.21.1680506394326;
        Mon, 03 Apr 2023 00:19:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c0a0300b003ee6aa4e6a9sm19060418wmp.5.2023.04.03.00.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 00:19:53 -0700 (PDT)
From:   Julien Stephan <jstephan@baylibre.com>
Cc:     Julien Stephan <jstephan@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH 0/2] phy: mtk-mipi-csi: add driver for CSI phy
Date:   Mon,  3 Apr 2023 09:19:27 +0200
Message-Id: <20230403071929.360911-1-jstephan@baylibre.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a new driver for the MIPI CSI CD-PHY for mediatek mt8365 soc

This driver was adapted from https://patchwork.kernel.org/project/linux-mediatek/cover/20200708104023.3225-1-louis.kuo@mediatek.com/

Florian Sylvestre (1):
  dt-bindings: phy: add mtk-mipi-csi driver

Phi-bang Nguyen (1):
  phy: mtk-mipi-csi: add driver for CSI phy

 .../bindings/phy/mediatek,csi-phy.yaml        |  46 ++
 MAINTAINERS                                   |   7 +
 drivers/phy/mediatek/Kconfig                  |   8 +
 drivers/phy/mediatek/Makefile                 |   2 +
 .../phy/mediatek/phy-mtk-mipi-csi-rx-reg.h    | 435 ++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-mipi-csi.c       | 392 ++++++++++++++++
 6 files changed, 890 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml
 create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi-rx-reg.h
 create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi.c

-- 
2.40.0

