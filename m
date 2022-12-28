Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B9865765F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiL1MXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiL1MXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:23:05 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AA5BCA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:23:03 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id d10so10452481pgm.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0LQcrjzcqyHGx/EG+ZxulY1MidQR+dP6F+oRvG3vQs=;
        b=x/ZSlQ8pHG3xkV8dK6KyzVm22eyZhu3j80eOGMvGPMwCebW/JYa9bvXGKtSFn8vbV5
         5aC30qO+FGeVDqa6hM3f99d42d8Y+EUt0EWm8TFlq/4TkyPTXHubCPe6BK6txdD2JPJ/
         cYErJ2c2Ye/cFe9UA9HJlFki7EhknDZ7YBu+183MID3AA4U4OWc421E+CU5jvpKL53Wq
         SkMh7FCqoS9IAMN7cCNgH84NXgJcgvj083upOmOktH6ErMszWA+rp4ftCOeuQOWRWfUg
         VRaZLGm0Ka0jC0o/RtTXruMlZ0UTjdD0si5vTQceCk80DTEva2K3MqCzm6l5oU4u0gWG
         SGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0LQcrjzcqyHGx/EG+ZxulY1MidQR+dP6F+oRvG3vQs=;
        b=5r4YiJFDIFb1ATnL/G5Xz4S5bXiDlFxDD5yUPWD+z8I9m1wh+z3xHsGI2Xatdd9dcI
         1zwE8s6s+TOBT7WvCu80qVcwENj99Ovri1+F6m9qV48HARuOnxSfGIkx4FkOVBwynpFL
         qC+BASsV3I8fO9+I/9IemCTdF6Isa8bejZIOym6u0An6WVZaMUVs/Lkm6ZWYEL4Upbhi
         akNO+LSYEIlTb74qnaNpqJuaavnyCFURcv6opMSSWMjpfJG5Csjvx7fm9qDIMB13bDol
         eSOxA1vNcz4MaEr83L69i+qlT06umy1GN2O4crc2L+TElt6wQTbXsDkpOF2xCGkn8rHi
         xp5g==
X-Gm-Message-State: AFqh2kqx58WymkWMCs38b1UGj2yNavSjpWL9EUmUGW+sGEuef3kGMITA
        tlh7pez5oElW6HTgNBzoub9nxQ==
X-Google-Smtp-Source: AMrXdXudRa1wP9H6e6vGFfQm6qY0zfkdkBMEcZaDW22e10mqSIjt3bIqPJ0YRH0r2IRG0HPaz0kP6g==
X-Received: by 2002:a62:16d5:0:b0:580:f58f:efb3 with SMTP id 204-20020a6216d5000000b00580f58fefb3mr14897592pfw.15.1672230182928;
        Wed, 28 Dec 2022 04:23:02 -0800 (PST)
Received: from localhost.localdomain (202.60.225.077.static.cyberec.com. [202.60.225.77])
        by smtp.gmail.com with ESMTPSA id h1-20020a056a00000100b0058124f92399sm5236074pfk.219.2022.12.28.04.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 04:23:02 -0800 (PST)
From:   tongjian <tongjian@huaqin.corp-partner.google.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        perex@perex.cz, tiwai@suse.com,
        angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
        jiaxin.yu@mediatek.com, chunxu.li@mediatek.com,
        ajye_huang@compal.corp-partner.google.com,
        tongjian@huaqin.corp-partner.google.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: dt-bindings: mt8186-mt6366: add new compatible for max98360a
Date:   Wed, 28 Dec 2022 20:22:30 +0800
Message-Id: <20221228122230.3818533-3-tongjian@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228122230.3818533-1-tongjian@huaqin.corp-partner.google.com>
References: <20221228122230.3818533-1-tongjian@huaqin.corp-partner.google.com>
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

Adds new compatible string "mt8186-mt6366-rt5682s-max98360-sound" for machines
with max98360a and rt5682s.

Signed-off-by: tongjian <tongjian@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml b/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
index 9d3139990237..aa23b0024c46 100644
--- a/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt8186-mt6366-rt1019-rt5682s-sound
+      - mediatek,mt8186-mt6366-rt5682s-max98360-sound
 
   mediatek,platform:
     $ref: "/schemas/types.yaml#/definitions/phandle"
-- 
2.25.1

