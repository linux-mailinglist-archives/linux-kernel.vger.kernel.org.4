Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB2A6AE6C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCGQgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCGQfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:35:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129F394779
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:34:18 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso7571961wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678206855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XF0M7uZbzNZ9RU+izdrVf7tIYf1cA6nVKbtuxlKJIFk=;
        b=tBJUgEd0FQrErE0j90np5BC+5nKfFqaf6M1h39mR9FhEY2+OUfKStaMPp0dkWS4hnD
         2usQf3sbT+rD+D/uAYU4Ejk4be3qW92gEY8Q0Yqi5njTgIGNgSUmXK3oT1qjUzJpu5sd
         Zf86n8X2RUCnj0QD8Dz5syvNlWWJcVbE4yVoPS16SIWQtojhTZuhG2pES2/jnUHw3XwU
         YKmNAZjenFD+TCG3au3df5WDj+l78i1EpKK4FNjoc2Q8rdowmrtk9pAxKzxtAN8yhTXf
         MzBNS7fjAT7yMzo3WIxx+IYULEY9og1CWQQV9dA0gJHRLuxTFExESf0usHTz4OV+X1x9
         8wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678206855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XF0M7uZbzNZ9RU+izdrVf7tIYf1cA6nVKbtuxlKJIFk=;
        b=7XuTG1EqRpXz2lnN6N8uPoukBwC+c5O1XwiBwyU8+NfnjlFtlyhTEH9P1l8v73sBL7
         zL733ZgW6rdrGii3iYvwb//MNGmUDil7ooyyOr+zC66uBWDSOYGZBwCjQm84wbBBbvGG
         8tdtsQHpJ/Q4gutUbBrNXBd85GZKle21Sy4DHOQsYqDq3qLXFzI0omvm8ReArgOn3GTA
         8wLylb73yhZVwogm09bKuuMY15+t7pH/ZvPQ7BMrf95nsDBxbIoJapc2T1CarDM+J65U
         Wbb16mbEvrDWlueJkHQIDhLCxcwUXYnzJsQyazuf1Bt4mdYJBbG9V0U1JxhtcCbdjElm
         y8gw==
X-Gm-Message-State: AO0yUKWxy6tsYuPhTHbVb3VjEs9sU6KkHeR/63RqlWyHd9k04lOE/Tub
        POHVfIasDmKY/oqd7cGFllWFFQ==
X-Google-Smtp-Source: AK7set+wqd8TopV09QEWHXr4GZcjeN3JQUoHUM4XtO6ka5qQm4lRRIvlStjXSZL4Vw270Jc1Bw6ZBw==
X-Received: by 2002:a05:600c:444c:b0:3dc:16d2:ae5e with SMTP id v12-20020a05600c444c00b003dc16d2ae5emr13080448wmn.32.1678206855177;
        Tue, 07 Mar 2023 08:34:15 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d49c1000000b002c563b124basm12778117wrs.103.2023.03.07.08.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 08:34:14 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH 0/4] Add LVTS support for mt8192
Date:   Tue,  7 Mar 2023 17:34:09 +0100
Message-Id: <20230307163413.143334-1-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add full LVTS support (MCU thermal domain + AP thermal domain) to MediaTek MT8192 SoC.

This series is a continuation of the previous series "Add LVTS Thermal Architecture" v14 :
    https://patchwork.kernel.org/project/linux-pm/cover/20230209105628.50294-1-bchihi@baylibre.com/
and "Add LVTS's AP thermal domain support for mt8195" :
    https://patchwork.kernel.org/project/linux-pm/cover/20230307154524.118541-1-bchihi@baylibre.com/

Based on top of thermal/linux-next :
    base-commit: 6828e402d06f7c574430b61c05db784cd847b19f

Depends on these patches as they are not yet applyied to thermal/linux-next branch :
    [1/4] dt-bindings: thermal: mediatek: Add AP domain to LVTS thermal controllers for mt8195
    https://patchwork.kernel.org/project/linux-pm/patch/20230307154524.118541-2-bchihi@baylibre.com/
    [2/4] thermal/drivers/mediatek/lvts_thermal: Add AP domain for mt8195
    https://patchwork.kernel.org/project/linux-pm/patch/20230307154524.118541-3-bchihi@baylibre.com/

Balsam CHIHI (4):
  dt-bindings: thermal: mediatek: Add LVTS thermal controller definition
    for mt8192
  thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
  arm64: dts: mediatek: mt8192: Add thermal zones and thermal nodes
  arm64: dts: mediatek: mt8192: Add temperature mitigation threshold

 arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 454 ++++++++++++++++++
 drivers/thermal/mediatek/lvts_thermal.c       | 106 +++-
 .../thermal/mediatek,lvts-thermal.h           |  19 +
 3 files changed, 577 insertions(+), 2 deletions(-)


base-commit: 6828e402d06f7c574430b61c05db784cd847b19f
prerequisite-patch-id: 73be949bd16979769e5b94905b244dcee4a8f687
prerequisite-patch-id: 9076e9b3bd3cc411b7b80344211364db5f0cca17
prerequisite-patch-id: e220d6ae26786f524c249588433f02e5f5f906ad
prerequisite-patch-id: 58e295ae36ad4784f3eb3830412f35dad31bb8b6
prerequisite-patch-id: d23d83a946e5b876ef01a717fd51b07df1fa08dd
prerequisite-patch-id: d67f2455eef1c4a9ecc460dbf3c2e3ad47d213ec
prerequisite-patch-id: b407d2998e57678952128b3a4bac92a379132b09
prerequisite-patch-id: fbb9212ce8c3530da17d213f56fa334ce4fa1b2b
prerequisite-patch-id: 5db9eed2659028cf4419f2de3d093af7df6c2dad
prerequisite-patch-id: a83c00c628605d1c8fbe1d97074f9f28efb1bcfc
-- 
2.34.1

