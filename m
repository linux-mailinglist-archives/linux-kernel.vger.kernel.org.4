Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1294B6EE304
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjDYNbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjDYNa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:30:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0F5CC0A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:30:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-3f193ca059bso29687375e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682429455; x=1685021455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQDZ0kl/qap4qMPXG3KZzTT6FQaXwjteHFJnaNZ/47Q=;
        b=hQgeKxRXJ0yHcM++OOFfZ0t1UtuWdAqbDsuB6SGX7Ucu4YkEFj7SyEU7cfe78wh+WQ
         G2J2731hdkoyvLD/hBXPyMWKJeZMVW5OlF8grQLS2Kmv1Vv2/eQvanMbmwwR7XBxTXcn
         y37uRQmbLsZgCFk00oAo9v9av5lAeyjjGKD/BoARvUNJtB1t4a+JPJUkrr4MusKUldXG
         Oapm1Ar155TbJ1iK3hhZWOR0eipY1t6iQk0zErCepOqEWsih5iZ/eLpTZJcKvXf0+17U
         grR9+PvnRUtvydxZ+a5PEqaAtuggkpOvYQcqkLzdrtkCjLBVZH6cyaekT46Td2jQldb4
         ealg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682429455; x=1685021455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQDZ0kl/qap4qMPXG3KZzTT6FQaXwjteHFJnaNZ/47Q=;
        b=i1qKtPAwJKNMr4NmuDj1WX9/ryiDv5Ztptx58UmwLigiuu2fyXP81atIR9sb78p6pk
         KRhCSrQ4ALp/rVfLysgdEoJNJd9U4oa2xQ0Xlvs/o9oJm9s9aR0jHW02t6sPWUmJauqT
         a2D8CY+xVmVi9fa/pY3Fgd4eINYBgGBLAZI/r/YLZs7rp9rRSUbKUMqdhtrriywfiIeA
         roH3MkABITROx2yMH7pYhJdZutd+K/lQ+pjFpad/8Zrh/VwPR9lZQg3VhSAuQMyNZHDX
         LkpKpeMQY95qM+im1rl2eQYMBH+hCItvXi0ic9vXGz1yIbk7DfpKmsK15x7BE/Khwmew
         kJJg==
X-Gm-Message-State: AAQBX9c7Z72BoffmbI765XCmdfwi1VPfkiqaRjxnxS/g5lf3Y/AcSjHk
        kptCmy2dGt7ucIojPoq2QC0h1g==
X-Google-Smtp-Source: AKy350YToaXY8KjK9MDJml/HHBSHgv1qFk3TZWeCRSWY630xTgykwAXRAj/XIk46jXGX2hvyI5BZSA==
X-Received: by 2002:a1c:7211:0:b0:3ef:8b0:dbb1 with SMTP id n17-20020a1c7211000000b003ef08b0dbb1mr10272347wmc.7.1682429455493;
        Tue, 25 Apr 2023 06:30:55 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b003f16932fe7dsm18575434wmq.38.2023.04.25.06.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:30:55 -0700 (PDT)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v2 0/5] Add LVTS support for mt8192
Date:   Tue, 25 Apr 2023 15:30:47 +0200
Message-Id: <20230425133052.199767-1-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add full LVTS support (MCU thermal domain + AP thermal domain) to MediaTek MT8192 SoC.
Also, add Suspend and Resume support to LVTS Driver (all SoCs),
and update the documentation that describes the Calibration Data Offsets.

Changelog:
    v2 :
        - Based on top of thermal/linux-next :
            base-commit: 7ac82227ee046f8234471de4c12a40b8c2d3ddcc
        - Squash "add thermal zones and thermal nodes" and
            "add temperature mitigation threshold" commits together to form
            "arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones" commit.
        - Add Suspend and Resume support to LVTS Driver.
        - Update Calibration Data documentation.
        - Fix calibration data offsets for mt8192
            (Thanks to "Chen-Yu Tsai" and "Nícolas F. R. A. Prado").

    v1 :
        - The initial series "Add LVTS support for mt8192" :
            "https://lore.kernel.org/all/20230307163413.143334-1-bchihi@baylibre.com/".

Balsam CHIHI (5):
  thermal/drivers/mediatek/lvts_thermal: Add suspend and resume
  dt-bindings: thermal: mediatek: Add LVTS thermal controller definition
    for mt8192
  thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
  arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones
  thermal/drivers/mediatek/lvts_thermal: Update calibration data
    documentation

 arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 454 ++++++++++++++++++
 drivers/thermal/mediatek/lvts_thermal.c       | 185 ++++++-
 .../thermal/mediatek,lvts-thermal.h           |  19 +
 3 files changed, 642 insertions(+), 16 deletions(-)


base-commit: 7ac82227ee046f8234471de4c12a40b8c2d3ddcc
-- 
2.34.1

