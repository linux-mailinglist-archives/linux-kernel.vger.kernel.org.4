Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7CB5F27B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 04:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJCCxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 22:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJCCxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 22:53:36 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB19A237F9;
        Sun,  2 Oct 2022 19:53:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i6so9084158pfb.2;
        Sun, 02 Oct 2022 19:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=yRoV6A325jxyR0HUM0rid5flyQf24IUrJ3Inww/M+Wk=;
        b=mC/tlH/od72vvEWCug16uB+p+mC/v9flmy8QouWf5WlJDCV4k/OSTOHVthCQTb2O4v
         P/e0kjUbKCaBcsps2Q0eagT6xASS+YrHHI1XguzRqarzXunDXUa9avKG7POG/wnFU4AE
         ub3F6E9dsanzvI4r3bs/kvOZk7bEsg0V4awqSuovrmQKJ8964UQfvHbP8j/nTt2SLNHI
         0e/R/xPZIYexOkEVcp3asEqcqswBCijrOjJKy6LUGysBWpPjYxBoy4r8rL7q3ch+WuNp
         Rczs0+1GYmAqdRNfZvb429g/KF7hpenaTIkty7b3Zdq7HoURF0kpQtLVHyGBH8sM+sSt
         r4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yRoV6A325jxyR0HUM0rid5flyQf24IUrJ3Inww/M+Wk=;
        b=q7xPhIk/eRC/W8DdvhzzElnGQJBrpxdRq40TuwXR0uN5UunEMPUwPD+wJgUMqNgLgC
         qPVw6dwbGMyD+s+MmfBAhDf15EBDb6IFyyjnw2MkssnnSoeNUq/I0V/K8xYTQoizYi7F
         HX+A4y/0TOv1Z4XT0FWyrR4pbfAlQvPZeV0a+AY2s0FDBXpr6eS/pmo8lagW+vWRm1KY
         1Rehq4mHrAKO1TqPcKlebEluPT1dQmvOH69FobfPJXEPIAtI+vn1Jc+HVti96o3MyygY
         ZZiyTR2fKMetAOCOazzeY6gzCW4TshanJtsSg1RVJxERrFlTWZ+X6Lbo09lh+mDKXQu1
         gjVQ==
X-Gm-Message-State: ACrzQf2DjVjsbMDnedzcjI9E+6pq+beu2hxk90m0N+RkOp0UEU4CJ1jS
        z81ZYK/z25RDaNthpeLkEw4=
X-Google-Smtp-Source: AMsMyM5cz6ZSFrhw9ZwKW64dwhaVwMVsudyg92p4ufDExrZg6uiHa6FJgtClHGDAyfVFCz0oL0QEnA==
X-Received: by 2002:a05:6a00:168e:b0:53b:3f2c:3213 with SMTP id k14-20020a056a00168e00b0053b3f2c3213mr20668942pfc.56.1664765614349;
        Sun, 02 Oct 2022 19:53:34 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-173-234.emome-ip.hinet.net. [42.73.173.234])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902f35100b0017a1145eec7sm5931427ple.157.2022.10.02.19.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 19:53:33 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, matthias.bgg@gmail.com, sre@kernel.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: mt6370: fix the interrupt order of the charger in the example
Date:   Mon,  3 Oct 2022 10:52:51 +0800
Message-Id: <cc89d749eba56c5f2489d1707f7711733561b757.1664792418.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
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

From: ChiaEn Wu <chiaen_wu@richtek.com>

Fix the interrupt order of the charger in the binding example.
Due to this patch modifiacation
(https://lore.kernel.org/all/20221001202918.me7z2qzm7cmrkzsg@mercury.elektranox.org/),
there will get some warnings in linux-next when compiling the dts.

Fixes: 76f52f815f1a ("dt-bindings: mfd: Add MediaTek MT6370")
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
index 410e2d4..1f67e06 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
@@ -139,8 +139,8 @@ examples:
 
         charger {
           compatible = "mediatek,mt6370-charger";
-          interrupts = <48>, <68>, <6>;
-          interrupt-names = "attach_i", "uvp_d_evt", "mivr";
+          interrupts = <68>, <48>, <6>;
+          interrupt-names = "uvp_d_evt", "attach_i", "mivr";
           io-channels = <&mt6370_adc MT6370_CHAN_IBUS>;
 
           mt6370_otg_vbus: usb-otg-vbus-regulator {
-- 
2.7.4

