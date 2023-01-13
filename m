Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053DA669E04
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjAMQ23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjAMQ2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:28:05 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F047D276
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:22:20 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u19so53419685ejm.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9oKZpLB3KLxNjht49zMQ5zevFbZ/bcUUbDkM3FfyYA=;
        b=yz/VebqfEp1bmhZjr9FNC1ihtfQnR9SeGG3hAJziFTTvriFYLQCyTY3TTjL93C5MKA
         hla/sInL4jnIB1nKZJAyFRBaHSvNdGSCqqZ1I7hDPhrRKfuTr+RoZB1E0MKx7oZVY64h
         iKU+DDNYQwUUUhZ92UbsIUHk8by803W17KKNdpFFLyZgiCP0zpkV0zdfePV1+aUnlNHc
         6vaJvgT3KNT60pZ6cszElSPhqfX9BBB4po46IhOvJkB6fmZ8MogstCBzywuA0vKjrhle
         hSB+ykAAJ6lFL+C/Tnf1soGmRB9OLBE4I3n0/uFJOonGnzDcY/PYQW1z6MZUl6Se2Ndm
         garQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9oKZpLB3KLxNjht49zMQ5zevFbZ/bcUUbDkM3FfyYA=;
        b=JTU6OmVjwPDsxZ0by3DHsIsw6AfVylgtAOw9rueu3sj6GeEFB5MADLfP325MWQp1r3
         Nqs+KMpYkcB1i813jgZ2uwlszVha/hrt+3JD0yX0Sdk1881qhNSTxfAixKfPN5mQ8a6N
         jrftsaJ63NmUZ+/ZjPl+gq04Pa1E7Gz9qoSHHVmYu9tvUC8GbA7uhHblyWVc0inxoB7T
         Vavau7qgdhnMSZZVHAvG96X4cs9uNDKqLxmnM6Vbmx9Om80k1tyr2VT2gu61WIjGKIag
         xphoT2Gr9orrZVFNL14LxGbydD/224BgGRpxsCMjZwA/57uQUWs8LOMmyHQ8sgi5VRLt
         LreQ==
X-Gm-Message-State: AFqh2kppRWV+xtb2FxMzq4G3OMTZgN7XRi0m2h/GMDxESLhW1bMWx+sL
        YjBHEmWk+6e4PNgyuqlORp4InA==
X-Google-Smtp-Source: AMrXdXvd45K78hFtMbn/TLgUzGtyghVKPnuwBJk4k2UCCXd5I59g2iRZLy7eqsLZ58B/VpDHcrS18Q==
X-Received: by 2002:a17:906:7fc3:b0:7c1:10b8:e6a4 with SMTP id r3-20020a1709067fc300b007c110b8e6a4mr65343071ejs.19.1673626938650;
        Fri, 13 Jan 2023 08:22:18 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906768b00b0084d242d07ffsm8376737ejm.8.2023.01.13.08.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:22:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] ASoC: dt-bindings: qcom,wsa881x: Allow sound-name-prefix
Date:   Fri, 13 Jan 2023 17:22:12 +0100
Message-Id: <20230113162214.117261-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference common DAI properties to fix:

  sdm845-db845c.dtb: speaker@0,1: 'sound-name-prefix' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
index d702b489320f..ac03672ebf6d 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
@@ -15,6 +15,9 @@ description: |
   Their primary operating mode uses a SoundWire digital audio
   interface. This binding is for SoundWire interface.
 
+allOf:
+  - $ref: dai-common.yaml#
+
 properties:
   compatible:
     const: sdw10217201000
@@ -39,7 +42,7 @@ required:
   - "#thermal-sensor-cells"
   - "#sound-dai-cells"
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

