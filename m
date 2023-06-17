Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0348673425B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 18:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjFQQ5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 12:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjFQQ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 12:57:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6D219BB
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 09:57:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-519f6e1a16cso2255731a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 09:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687021050; x=1689613050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cYkWr+qB9Dy27do4YoJJyP/9/BdByG4wfyLCrCmqa7U=;
        b=WJ0col15f2yIYiNyzpQLZROUE/7n8tQ4HuBnCy0Oof0nS+49wdxMqi5HnVue2p/ByY
         QEkU9wGzQSiktECAdDCRneh+ahbBQX9t7T149pNjjR3DmZl4/C4gLMPTt2ksNGZAznTA
         DRpCfLZGtmpdG5xm1EKHBc1/MhokeYzvwLC5Iubt1BtAaMr2VCZdpBOkTeCa1w+ifC2/
         WMNrVhI+lLGfubEKZfzvHELoGSvJaEb1RLQhSmrVFdnzwb7GxnTUl109VQx2IfXZZkuB
         P8ZVmQqlhegyECdr/V9Dnm2Dv1PtVctlbEnVhczort56TlYZuM/xCsb8f/iduuld79rg
         yD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687021050; x=1689613050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYkWr+qB9Dy27do4YoJJyP/9/BdByG4wfyLCrCmqa7U=;
        b=coLnwbAVTEJ9BTceSeM2xk4pV0jv7ro2/Enecld34U6tFVNhaui0rlW+E2CugcBWEd
         4woSItxcSFM5JsMRKd2zlE8jT4QeJc/F7Y3m4UDdN0qDio+8HgQ1frdNz1iNlpUi4TcY
         iGVb/hpZzdyvDpwuzDNFR3sZc+Libt4cYjz66k7rsnxnJ0hY2dRjP5qD4zTAaRe0Xxwz
         zIRIvvut9Mn/tgOEuQ6xgMRzPUGXU/zAs3FV9SUa90tnMCJXhrU8m6zJTgznyiFh2Im9
         Jym0MulXv3wo/x3ALzWAupUzaaU6DXkZjpbG5nYbxETRQfBw1ocP22WputrzxEQYZbgV
         y+nw==
X-Gm-Message-State: AC+VfDwTC05ahQNL4NUKiBq5nDNOCnZUSkkMqY0QBTFe3uShPBgBV8Qp
        T8USs3V8OXnt6sWoaXI/CPJ4GQ==
X-Google-Smtp-Source: ACHHUZ6rsOF2b6T9zuvp0klPgNhhjJbj2nLVN09KwwbbKBsxKtDmXRwtSdGhblpiDCx3PeU81GFQqQ==
X-Received: by 2002:a17:907:94c1:b0:966:5c04:2c61 with SMTP id dn1-20020a17090794c100b009665c042c61mr5254779ejc.8.1687021050309;
        Sat, 17 Jun 2023 09:57:30 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id j15-20020a170906410f00b0098768661505sm1014598ejk.117.2023.06.17.09.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 09:57:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: display: sony,td4353-jdi: allow width-mm and height-mm
Date:   Sat, 17 Jun 2023 18:57:26 +0200
Message-Id: <20230617165726.279886-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow width and height properties from panel-common.yaml, already used
on some boards:

  sdm845-sony-xperia-tama-apollo.dtb: panel@0: 'height-mm', 'width-mm' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/panel/sony,td4353-jdi.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
index b6b885b4c22d..07bce556ad40 100644
--- a/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
@@ -23,6 +23,8 @@ properties:
   reg: true
 
   backlight: true
+  width-mm: true
+  height-mm: true
 
   vddio-supply:
     description: VDDIO 1.8V supply
-- 
2.34.1

