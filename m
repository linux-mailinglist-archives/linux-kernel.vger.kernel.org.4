Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2646C9648
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjCZPyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjCZPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:54:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB584229
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:54:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w9so26264188edc.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679846070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVZux4uHBZzsldCyxcu4IzCwrMdWIWc1fs0M3nQN8os=;
        b=ReXjM5bs2NsnbUxngOH0a71w4JaN87+hXV8D5ZUs+LWCNy4WTySdX8t7bCmGq8aej9
         /t7pdOQPt1oSfdoPFaf/Helhz94vHkcLv+FK7plRYHO3UAWs6o0m415MAW5mVV8BamZc
         65fpQVkKkofD3OPJ+jTgb33py/ioBcwkFcZ3iQhAIb4BeGW+GsD6tog2unXij8eXCAVa
         2qiDZz3aIRw3zM769HTgMk743yYtF14Ej2utSs7IU2s5qmYC1Mr/cjiDRXlSL6uhmm8D
         tZI2VRg2HRAEM6NYccywDpPShJ2NpbOf4Q7nMqdZFIXBDEMCBghp1nt7x1I3sOcnrqii
         SJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679846070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVZux4uHBZzsldCyxcu4IzCwrMdWIWc1fs0M3nQN8os=;
        b=rwCgJnOxerkH67GR/3jTqEo8u8n811EOctt5nJkWJIJ+fjczXKV93O5AGGIvhWHVK7
         FAi02mxj3AcamlbpnOdQsOfCLJ2YqAgED3GzcQ2fXsi6vYFDm+PxfojcYwbTNY0k0/i8
         jqAgIg0oiOqi9FuHmHUuqqUK6XQMjLy0fWnMl7dgUvlfvCjaDtm4KvjAK1KNK9u7w0Cn
         zBppHRY+8pYuFGWG7ueL7o5KcxWHNaf3g6gxM4YrXqHmJpHqybuTSLq2HBknCibZe7wd
         fmPXbQPyEyXPlNHlvqcyQNNgIuqBI4pk9CvFuKyCW6/IPJFtKfZzbOW1d8vgNMR8An+c
         GIYQ==
X-Gm-Message-State: AO0yUKXkB+4Cbvd5ZO7sRJ4tBSnQGYbMSwf87DllKkYkt774cUBO6QqB
        CIbF0OnJOGaU7SRxub09kHkAEA==
X-Google-Smtp-Source: AK7set9DE6vPbbVIA0Rm5bVMGQJWRb3++BCkPyrB3vGliMxtG1Nvbu9P2n0OAfxhr8S+W5+V2o808Q==
X-Received: by 2002:a05:6402:5d87:b0:4af:740d:fde with SMTP id if7-20020a0564025d8700b004af740d0fdemr13852421edb.20.1679846070169;
        Sun, 26 Mar 2023 08:54:30 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:eca3:3b8f:823b:2669])
        by smtp.gmail.com with ESMTPSA id l6-20020a50d6c6000000b004af62273b66sm13506742edj.18.2023.03.26.08.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 08:54:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Harigovindan P <harigovi@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/6] dt-bindings: display: novatek,nt36672a: correct VDDIO supply
Date:   Sun, 26 Mar 2023 17:54:21 +0200
Message-Id: <20230326155425.91181-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230326155425.91181-1-krzysztof.kozlowski@linaro.org>
References: <20230326155425.91181-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nt36672a bindings were added with a mistake on VDDIO supply calling
it in one place vddio and in other vddi0.  Typical name is rather vddio
which is also now used by DTS (sdm845-xiaomi-beryllium-common.dtsi) and
Linux driver.

Fixes: c2abcf30efb8 ("dt-bindings: display: novatek,nt36672a: Fix unevaluated properties warning")
Fixes: 9528a02430df ("dt-bindings: display: panel: Add bindings for Novatek nt36672a")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/panel/novatek,nt36672a.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
index 41ee3157a1cd..ae821f465e1c 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
@@ -34,7 +34,7 @@ properties:
     description: phandle of gpio for reset line - This should be 8mA, gpio
       can be configured using mux, pinctrl, pinctrl-names (active high)
 
-  vddi0-supply:
+  vddio-supply:
     description: phandle of the regulator that provides the supply voltage
       Power IC supply
 
@@ -51,7 +51,7 @@ properties:
 required:
   - compatible
   - reg
-  - vddi0-supply
+  - vddio-supply
   - vddpos-supply
   - vddneg-supply
   - reset-gpios
@@ -70,7 +70,7 @@ examples:
         panel@0 {
             compatible = "tianma,fhd-video", "novatek,nt36672a";
             reg = <0>;
-            vddi0-supply = <&vreg_l14a_1p88>;
+            vddio-supply = <&vreg_l14a_1p88>;
             vddpos-supply = <&lab>;
             vddneg-supply = <&ibb>;
 
-- 
2.34.1

