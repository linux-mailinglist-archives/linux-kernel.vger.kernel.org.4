Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BD86B6A2F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCLShy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCLShx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:37:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7310530EE
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:37:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x3so40193251edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678646186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIh/Hblag8cnzqz8rq/TySc8lZL2yglYjsKAKBrZYCw=;
        b=rsjpYqdzZ6IBDYT2s3aYsRySt4HxHk5KxgyqhRJjJEYxZg7fdHNfdyM+WVP/1bAuhr
         BgNKSXtOCVojJW68JH2QLvdDN2QWRbnBOKgytZkxKrfaW5RCqojhlZix4v1uhMfFVBwC
         vIB7jZXLMAgl9Hw0A2dacDym3L6B7vQBA5NMma6/8KMotzfxFVybbZtox98uYya37KO2
         RsHLT7uTxGK//fGTKFDthM7DtLJEP5HBtBOI8K3wH8MFIP8wh/TdwEp28A8eiSXFQRYc
         LhpvpFcaf5vZooy35+BnIYA3hv3dXWPyqXOhiuDy2zUcXOdIyjP4DxnZ6DhgKDkwaUwI
         S1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678646186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIh/Hblag8cnzqz8rq/TySc8lZL2yglYjsKAKBrZYCw=;
        b=NvQTtZXTD0WO1rdd3u+1noto5y+KN8HO+xzKGI3OBlrWEmTOspXLJ4+DFzxRZhuxKU
         YyT8rERdSqG46LpxqdFHENa5eMKyID+Wp6b7mQWrgdM2fGLyp5XmzGUQm0UYoF6kSMhk
         gGQ5L4l+KIVwD6oePYHWHeX+rceoBSvjNeVa2V+WGM7eQpaAVjF7zQZevupe3Du2vrQH
         OjstiFylSjqPycnW+tcUAbdLN0BxOvgvA9WVaoZ5saCtgtHpTHcrglmnzcsh7om6IcMp
         IEqxhE1gWAoO4ScWF7M9SD+VgxxQ/F7xTmg8mh9K7kZs+plXShL4VJgNw2N6NsBx0ers
         5TLQ==
X-Gm-Message-State: AO0yUKVq/rHV9IZQyxsrxaLb8qGHxdIr803Oh5wKT5PU5m9EZnehbxzy
        z2DOHEmOlNiatEmXxIIwBaK+fA==
X-Google-Smtp-Source: AK7set8omFrorpcgSHY0+CyGyUmvJOZ2jeVeFtxhxXDdGvcNqSrdfCDiZUDh8amSN9pHBCHVRnIzZA==
X-Received: by 2002:a17:907:3f90:b0:878:711d:9310 with SMTP id hr16-20020a1709073f9000b00878711d9310mr36618159ejc.1.1678646186724;
        Sun, 12 Mar 2023 11:36:26 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id p14-20020a1709060dce00b0092669fb4ba1sm893806eji.130.2023.03.12.11.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:36:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Gustave Monce <gustave.monce@outlook.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/8] arm64: dts: qcom: sda660-inforce: correct key node name
Date:   Sun, 12 Mar 2023 19:36:15 +0100
Message-Id: <20230312183622.460488-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio-key bindings expect children to be named with generic prefix:

  sda660-inforce-ifc6560.dtb: gpio-keys: 'volup' does not match any of the regexes: ...

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
index 7c81918eee66..7459525d9982 100644
--- a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
+++ b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
@@ -29,7 +29,7 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		volup {
+		key-volup {
 			label = "Volume Up";
 			gpios = <&pm660l_gpios 7 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
-- 
2.34.1

