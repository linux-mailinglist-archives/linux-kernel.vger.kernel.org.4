Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6889615657
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiKAX5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiKAX5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:57:42 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A1F1F2F2;
        Tue,  1 Nov 2022 16:57:41 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d123so9015015iof.7;
        Tue, 01 Nov 2022 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrAi2TDHBDb0dBVR946q2FkMj41FigVp8lJRhbn7aM4=;
        b=qWfcEcEh4vzMCC9Df7jHPVRY3mI7LGwbF8P1RR8H/SeaeGu8M22TmKFLCO8LwZdVyw
         akf9jWGDNTKli6B6P+ZgJWK5dlPhvqcurT9jwODv2kp7wTsq/OIMpjaqyeDrIPL7ZB1m
         hMCrPY128e8Y6eE7EUQWmvW/E2U55xuAuwiUHmDkyNwWw1ZayT2mC+xyKRz+mabOZ5S5
         G0tFF7FjLK+O3XbMkkNJHeIVaHkv3IyC15Wx7JmscYoe444HUSOiEhm1rUSpOeub0v0e
         mvUdy80NceUpJtG51umMxVwnAIvPIejxK/Qwjmc2qMWdkSMaEGXYo3uKxkvyEabuKmvi
         H4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrAi2TDHBDb0dBVR946q2FkMj41FigVp8lJRhbn7aM4=;
        b=xF1fdS8GrePd+r8Wpv91CiMA0+d4nI3k8YFSx2HF3OBaL+PI8ieBV4YBawVgFVir7Y
         HZvwTD0hCc5xb/6q08DxYonIWnu7qeZEaVVQ6+nuXhW5NAd9TKLkAwmOxbuIw5LNIHh/
         bAmOjErZUoEZxP2SBD/Ib+Kyb3x45FgFlE5TdFrU3YDPqEfgKILaOqKgHEVmkRQT86K+
         6ApKtEwgt/fSWRL2H0yiKfzf+evHT2J7mQN9JWzgY+FnsSUm5kMgIjDaNUPi10shBwLH
         0U9/P+IGHHFdZT5ytpWGSkysnmTdW+oEyhLkywJ5j2e/DyhtkwEb8pdqNIF3orjaa4uo
         iU1g==
X-Gm-Message-State: ACrzQf24NN2HQlXdXNPQJUpqg6hUTWlc4zTu2v7GcKS/8/IJXPrXgMp6
        Kb1TBY0N+ranTIDbJTW/MdY6ze8rjB0=
X-Google-Smtp-Source: AMsMyM69Sam7byHcD5nSqjlw/6vRReVj1KsmH7rUTOSyTC/xhaUPTRxVMkRiirJJb8rFQro+UNz9Ww==
X-Received: by 2002:a05:6638:2107:b0:375:ddb:54c0 with SMTP id n7-20020a056638210700b003750ddb54c0mr12853460jaj.244.1667347061385;
        Tue, 01 Nov 2022 16:57:41 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00:f1f0:c4d7:e39e:e2f])
        by smtp.gmail.com with ESMTPSA id r19-20020a02c6d3000000b00359ae384ffbsm4426929jan.19.2022.11.01.16.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:57:41 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: arm: qcom: add sdm670 and pixel 3a compatible
Date:   Tue,  1 Nov 2022 19:57:20 -0400
Message-Id: <20221101235722.53955-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101235722.53955-1-mailingradian@gmail.com>
References: <20221101235722.53955-1-mailingradian@gmail.com>
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

The Snapdragon 670 and Pixel 3a initial device trees are about to be
added. Add the compatible strings for the board.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 207e28260206..f9eddc22d4a4 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -51,6 +51,7 @@ description: |
         sdm632
         sdm636
         sdm660
+        sdm670
         sdm845
         sdx55
         sdx65
@@ -654,6 +655,11 @@ properties:
               - xiaomi,lavender
           - const: qcom,sdm660
 
+      - items:
+          - enum:
+              - google,sargo
+          - const: qcom,sdm670
+
       - items:
           - enum:
               - qcom,sdx55-mtp
-- 
2.38.1

