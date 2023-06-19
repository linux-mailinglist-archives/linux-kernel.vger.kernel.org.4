Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961B8734EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjFSIzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjFSIy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:54:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3721AD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:54:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-988c30a540aso73715966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687164853; x=1689756853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vNfLZEQpEJM6SLdl/oNvPckqX8L420p+TQXEM5LPmq4=;
        b=PVmhu++S5wpRNZuSpOYT3rHVUnDHTWcGd9UA4VSR/m/hBUysbxr+DPe0Cz8siwxKyY
         +oEAiVsodJBKJrHz1HUAYr6EN+AiO1xyPzcE9CakFrP4pvy72WcPMKupb3VbJgMPtnB4
         kn0q55ZGdoZzh0MU166NhnV/pda0z65Qb31Zj+btQPrNBO9BmTrVdcpNV+V1B4Wqf6TV
         XXH96WnmcqlKMVbSQRUYMKmK3iRYzH1rsAuaKEIlKyMtYGXWkWstwKpK32kKwKzuD/si
         APbHTsT0L7UYxhc6Gsbj5t2Bg6QgLjDuqMxzo8wYu5jlRR6MIVZHu4KY1V6hYJ299f2F
         pH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687164853; x=1689756853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNfLZEQpEJM6SLdl/oNvPckqX8L420p+TQXEM5LPmq4=;
        b=U9wMch5lAYVnq70YU4Vo/dtWyAxjDL1dskWqPckqLbmm/bKx//vmBfdgj9tu5B4X6Q
         oIe5xCmtqZWp+88wth4YOoWp7rgJuj7fnJL8s/AiRowyvECoZGM9PmIKAEk1OZ3UyKO7
         2ws3g8wtXPHYS4c4pPZnVWRDttU/9g38Gx9TlHujjASYviLppnpZjiEl42dollnLZLdI
         3VGk9ixkTr/NZGEp/Ipss4/5gu9Gt/wZr8gDISeti4ER750E7jeNQaPiIDoRL7Gi71LK
         9E2D/zN6Xkf5o14yOMTwboaAqq/WKPRmgbp19eZXH0QpSA001twZGFzOBiRf8IcSlNzh
         KdAQ==
X-Gm-Message-State: AC+VfDwS6y55yQBaWcTeWpMUjg8dGjWWKmbRsqmYXcpx9dTrRHONgVxg
        NshWgwJ7wZSz4sie1dpjRP1jh523Jc6kPIbbGG4=
X-Google-Smtp-Source: ACHHUZ5oaIcF5DxxRNDyvSnDYqO/7XTf0vp9USKjQrqAMYxRJW6BG1m/HQ+hMmwXcB1tdobu3o28eg==
X-Received: by 2002:a17:907:3f17:b0:978:8f29:8c85 with SMTP id hq23-20020a1709073f1700b009788f298c85mr8139030ejc.32.1687164852389;
        Mon, 19 Jun 2023 01:54:12 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a245:802c:bc2b:8db8:9210:41eb])
        by smtp.gmail.com with ESMTPSA id h27-20020a17090619db00b00987a6e01e94sm2994339ejd.214.2023.06.19.01.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:54:11 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v5 0/8] soc: mediatek: MT8365 power support
Date:   Mon, 19 Jun 2023 10:53:36 +0200
Message-Id: <20230619085344.2885311-1-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the feedback of last round. As requested I replaced all hex
values with defines and redesigned the data format and regmap passing.

Thanks for any feedback!

Best,
Markus

Based on v6.4-rc1

Changes in v5:
- Create defines for all registers and bits in mt8365 power domain patch
- Redesign scpsys_bus_prot_data to use flags to store reg_update,
  clr_ack as well as the difference between SMI and INFRACFG. The code
  uses the appropriate regmap depending on the flags.
- The WAY_EN patch now uses two flags, one for inverted operations
  'BUS_PROT_INVERTED' and one to use infracfg-nao for the status flags
  'BUS_PROT_STA_COMPONENT_INFRA_NAO'.

Changes in v4:
- Redesigned WAY_EN patch and split it up in smaller patches.
- Added two documentation patches.
- Added mediatek,infracfg-nao field to the binding.

Changes in v3:
- Mainly redesigned WAY_EN patch to be easier to understand
- Rebased onto v6.0-rc1
- Several other stuff that is described in the individual patches

Changes in v2:
- Updated error handling path for scpsys_power_on()
- Minor updates described in each patch

Previous versions:
v1 - https://lore.kernel.org/linux-mediatek/20220530204214.913251-1-fparent@baylibre.com/
v2 - https://lore.kernel.org/linux-mediatek/20220725081853.1636444-1-msp@baylibre.com/
v3 - https://lore.kernel.org/linux-mediatek/20220822144303.3438467-1-msp@baylibre.com/
v4 - https://lore.kernel.org/linux-arm-kernel/20230105170735.1637416-1-msp@baylibre.com/

Alexandre Bailon (2):
  soc: mediatek: Add support for WAY_EN operations
  soc: mediatek: Add support for MTK_SCPD_STRICT_BUS_PROTECTION cap

Fabien Parent (2):
  dt-bindings: power: Add MT8365 power domains
  soc: mediatek: pm-domains: Add support for MT8365

Markus Schneider-Pargmann (4):
  soc: mediatek: pm-domains: Move bools to a flags field
  soc: mediatek: pm-domains: Split bus_prot_mask
  soc: mediatek: pm-domains: Create bus protection operation functions
  soc: mediatek: pm-domains: Unify configuration for infracfg and smi

 .../power/mediatek,power-controller.yaml      |   6 +
 drivers/soc/mediatek/mt6795-pm-domains.h      |  16 +-
 drivers/soc/mediatek/mt8167-pm-domains.h      |  20 +-
 drivers/soc/mediatek/mt8173-pm-domains.h      |  16 +-
 drivers/soc/mediatek/mt8183-pm-domains.h      | 198 +++----
 drivers/soc/mediatek/mt8186-pm-domains.h      | 212 +++----
 drivers/soc/mediatek/mt8188-pm-domains.h      | 518 +++++++++---------
 drivers/soc/mediatek/mt8192-pm-domains.h      | 262 ++++-----
 drivers/soc/mediatek/mt8195-pm-domains.h      | 464 ++++++++--------
 drivers/soc/mediatek/mt8365-pm-domains.h      | 197 +++++++
 drivers/soc/mediatek/mtk-pm-domains.c         | 157 ++++--
 drivers/soc/mediatek/mtk-pm-domains.h         |  60 +-
 .../dt-bindings/power/mediatek,mt8365-power.h |  19 +
 include/linux/soc/mediatek/infracfg.h         |  41 ++
 14 files changed, 1267 insertions(+), 919 deletions(-)
 create mode 100644 drivers/soc/mediatek/mt8365-pm-domains.h
 create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h

-- 
2.40.1

