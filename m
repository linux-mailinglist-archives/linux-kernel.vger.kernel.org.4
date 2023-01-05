Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E27965F254
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbjAERO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjAEROW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:14:22 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1871B59FBE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:08:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l26so26905039wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 09:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6h6SlU5A0zuGX0GkcqVqSkxWmB5gVmPDaFv9upeKEJY=;
        b=qfgIV6+KNhNlHIai2EadAejv7OOkkRDR11V12OpGP2tFc9XeiyuMawbvzgJTN9tXrs
         cR0WnVCxS9IbqSz+/IAgAFRf8VAPr6vfizkuvRL+wq8B000hdQYJX02aM+1gGLLbyWxQ
         pt2j+9WBxSlmHwLXQq98VlnaRfBlMUXxAWh+gLdjEbK4miiZ5PP8/mZXiSK0k8Irtq1i
         l3/gbHxuDV5Ta1uJ5Q/pE+iQM/uA9Xda1ZoJSe0q8kINY349BDLAFTrAs6cLA2cTpHDb
         NdChNoIriRt72QjEG61Y6333Ql9vNB+Ot0gLLnn2qT0mWLwqs3kXtNMiL0jhkInvyhP+
         KuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6h6SlU5A0zuGX0GkcqVqSkxWmB5gVmPDaFv9upeKEJY=;
        b=H6E7i5Wgo2hUlWEOKuCeKghIJCcJc6PAgtSGmrDmSFmfmiWCqigAqECEUrC7ndJFBW
         GjnEUo4zbgB+sW/S1swq8RWY0D44dWFiL5Fy6/6boQfVI6Sa/e0HJy8/yZWKT39G63RE
         T8q9q+JxbPrO7rfNbed23jFRlwv1EFzs75Al3VkdPvLynjVAgi9vK/lq5+UQPUH1vh6S
         CqBg27w+Uti+K5xxEmWlDGBagF66CnMqWmvStnL+psNZnso9NuNcczBjFbCTzbhoeYfy
         283fhjbjg/1ZNVkCN+OoAo/R+81SkWke9AB3cl0x5CMAFRMerR/GIEEO9V7nWMMNioHw
         8zgg==
X-Gm-Message-State: AFqh2krZrj197dUaq/FLvBc1Ytu3QWOGizhSfiiqoKUA7l6+PdQaUAFt
        rryySRlk/JJNYFD25YofMTpByg==
X-Google-Smtp-Source: AMrXdXumBbhvBPsnLXFiWNaKp/0K4dGbueHABbMCGI06JOhA8oP8PTlc7vyC+M9+2rztudNJ19w5kA==
X-Received: by 2002:a7b:c7c8:0:b0:3d7:889:7496 with SMTP id z8-20020a7bc7c8000000b003d708897496mr36733344wmk.17.1672938466777;
        Thu, 05 Jan 2023 09:07:46 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:9cf4:fdb8:bb61:5f4e])
        by smtp.gmail.com with ESMTPSA id f14-20020adfe90e000000b002365730eae8sm37164853wrm.55.2023.01.05.09.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:07:46 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 0/8] soc: mediatek: MT8365 power support
Date:   Thu,  5 Jan 2023 18:07:27 +0100
Message-Id: <20230105170735.1637416-1-msp@baylibre.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry for the long delay, here is an update to the mt8365 power domain
series. Thanks for all your feedback, I hope I addressed everything. As
Matthias brought up some good points, I got back to try to make the
WAY_EN feature a bit more understandable with less code duplication. I
added a few patches to prepare the driver for the WAY_EN patch. I hope
it is better to understand now.

Thank you!

Best,
Markus

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

Alexandre Bailon (2):
  soc: mediatek: Add support for WAY_EN operations
  soc: mediatek: Add support for MTK_SCPD_STRICT_BUS_PROTECTION cap

Fabien Parent (2):
  dt-bindings: power: Add MT8365 power domains
  soc: mediatek: pm-domains: Add support for MT8365

Markus Schneider-Pargmann (4):
  soc: mediatek: pm-domains: Split bus_prot_mask
  soc: mediatek: pm-domains: Create bus protection operation functions
  soc: mediatek: pm-domains: Document scpsys_bus_prot_data
  soc: mediatek: pm-domains: Fix caps field documentation

 .../power/mediatek,power-controller.yaml      |   6 +
 drivers/soc/mediatek/mt8365-pm-domains.h      | 147 ++++++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.c         | 135 +++++++++++-----
 drivers/soc/mediatek/mtk-pm-domains.h         |  37 ++++-
 .../dt-bindings/power/mediatek,mt8365-power.h |  19 +++
 5 files changed, 302 insertions(+), 42 deletions(-)
 create mode 100644 drivers/soc/mediatek/mt8365-pm-domains.h
 create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h

-- 
2.39.0

