Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE615F2CE7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiJCJJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiJCJIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:08:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C550729CB4;
        Mon,  3 Oct 2022 02:05:35 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c24so9139074plo.3;
        Mon, 03 Oct 2022 02:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=yTjG2IBq4YiYp0Z+21USaQk03ELeEIZtyL0WiW5rA6o=;
        b=nZjOeUTkBtEqttsAo/AunR57RjNfBT0j/QhUvx3m6t9151Cm24iQ7+FjNFFysXZVsC
         hD/gXAiiTO7HO6fZxnEX1o60KY8fxF91PX1TIsNLGsfqXDYYtNHzwWVF7By6iP7lzREz
         Vrl6/dR+EeVp7S9/S/cWjoTCgBC2bqmlPau7fqEtagCbxP/FY1LxGiLLYF5Syzd94Nxn
         aiuab2MjP2LQLjVyv7lzWixIkZGVgGWstPrmO88cgTSCxhujHMJL7cJwQSHTbVRavKJc
         3dLKWfptri1YCKxnKfvcjurpKLRdqx43Q/Z9jl4fblTBNMOKyfLv58MP10pxDyRK1nq8
         tzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yTjG2IBq4YiYp0Z+21USaQk03ELeEIZtyL0WiW5rA6o=;
        b=jSe26Fyxj0m+If5QS44iCYqwllb6yfyVPYoiu8auDtF4qwfabNt4uWX8IS7Kgw4U3+
         u35v+bNPq7iIdxs7Q+gkVnAEXqaahAUzvlz+h3GGPM1Ugm8T/sql7gM/47bcJ7TPLRAD
         ffemTbvmkt5mUgbx4Lp9x0dPizY2OXrJvaB7RxLG2eJll2Z7JRg+QQFPqjOuw1yAc9Ly
         +/ulDPacJzBr2l+fSbGsaJ3Nv7ZzVuRVPKhaC3ZJCRWKzEbveZN3iOI2/vu4Kx0hn4cz
         Q/6xYMhyY2f85us9KlUwfosSRRteIiWd5xiB3a0UVbZX9X9dNhOsvwYjLW4QvhTAzGvw
         7cMg==
X-Gm-Message-State: ACrzQf0o1/4vgk/5cZuaX5u9BnGMdtgC1jvr4DQVB0E6uHek7uQKoW2P
        oDzO5gDpGUrcMcNOIrqCGAMW6T31smYONA==
X-Google-Smtp-Source: AMsMyM4ewwmWqikfbn6cyJfsan27i53/9bPAN4ryA0Mij/1Ql2UIn8IDGf3RwZDo791EHcsQsigIFg==
X-Received: by 2002:a17:90b:3b90:b0:202:8a60:c852 with SMTP id pc16-20020a17090b3b9000b002028a60c852mr11243637pjb.169.1664787935220;
        Mon, 03 Oct 2022 02:05:35 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-45-201.emome-ip.hinet.net. [42.72.45.201])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b00179c81f6693sm6678064plg.264.2022.10.03.02.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 02:05:34 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, matthias.bgg@gmail.com, sre@kernel.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: mfd: mt6370: fix the interrupt order of the charger in the example
Date:   Mon,  3 Oct 2022 17:04:23 +0800
Message-Id: <9dda705a8d67826306f6c6129722d3ad8edc96fc.1664816175.git.chiaen_wu@richtek.com>
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

Fixes: 76f52f815f1a ("dt-bindings: mfd: Add MediaTek MT6370")
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

v2
- Revise the commit syntax.

v1
- Due to this patch modifiacation
  (https://lore.kernel.org/all/20221001202918.me7z2qzm7cmrkzsg@mercury.elektranox.org/),
  there will get some warnings in linux-next when compiling the dts.

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

