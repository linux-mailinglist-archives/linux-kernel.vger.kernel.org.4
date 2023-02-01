Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CCF686A11
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjBAPVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjBAPV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:21:26 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872FB14EB2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:21:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso1676308wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+CP334d41+KJ886QppDHZsX2R2ejiT+wDvQG9M3qlo=;
        b=JX1G4TvgQVTYHlK5D+v8ldoToRv5MxB1yAZWxycVGtIGOw8joPqaBU6Y0zUPy9GV6Q
         bD1HiOpJd0uRrOKRx0GoPGjdf2KcV49R2o2oblOwRnfQkWqtUCDWl2ir/4OMaB0rzZvM
         ruQMwERkDoYLsAqCWb/to98Xq+6ZHR23za1cnY/k+IUU6qW9kULbtpMuN7gT38xZHETh
         FjYhQ9TeVYuSvJpA160LVe1OaPwQtHJ+0C/uUlthsXDuHdN22/Ti+MeQHM2Xd7vIfTws
         IgMZced7JKzgBwBV9OF9iQ3WR5/UBbQiaONngUd5xcIODHa5kz1sAd287ufkpNmJalY2
         P7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+CP334d41+KJ886QppDHZsX2R2ejiT+wDvQG9M3qlo=;
        b=eIU03ee1o7RyoCcqFZkJe/MP7yqo3JL5kLD3rClpRqscel/yqXthnG5R0XWR4+kN05
         Nb8YYFuNzE/qbpflMfS3dZwuSQPgMjY+ZR3DbrIL5tENxtG7PUimVDiYEX61Ws0bDpLe
         wSdiLqRbDCxYaFznaMMx26+Jr7IoomCwhtE+4XgdcLFwp/R083cOu6HVJdfUdFOQMLo8
         tgBJiYLuUSe4ROQN9mperKRvWSRK0twQ//KDiW/gVkNyRQFjoIXl0PRZa9+6+T/KLYUN
         X2hJuqbwN7cie7O/NFIXibJcNicgluaptTnW49H/Ee10/8Egiji/54fAkq8eUmBiMhsq
         ESAQ==
X-Gm-Message-State: AO0yUKVjDJBdbJ04iXpnwOY34vy9cXLrqD5RkJd0x7sMm6rnk6snD/pK
        D51Jim63GfKShQoZEEFalliRuQ==
X-Google-Smtp-Source: AK7set8r0f7fnOSxGtiJqbb/zo9O49k3QsOP/wxpCSVNDdJ+xtzYmg2yczjIZhzw3UpNkuKF1gkxHQ==
X-Received: by 2002:a05:600c:4f41:b0:3dc:53da:329b with SMTP id m1-20020a05600c4f4100b003dc53da329bmr2402098wmq.17.1675264878050;
        Wed, 01 Feb 2023 07:21:18 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d64:a4e6:40a8:8e69])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c42d300b003dc53217e07sm1893120wme.16.2023.02.01.07.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:21:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 2/5] dt-bindings: mailbox: qcom-ipcc: document the sa8775p platform
Date:   Wed,  1 Feb 2023 16:20:35 +0100
Message-Id: <20230201152038.203387-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230201152038.203387-1-brgl@bgdev.pl>
References: <20230201152038.203387-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a compatible for the ipcc on sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index f5c73437fef4..de56640cecca 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,sa8775p-ipcc
           - qcom,sc7280-ipcc
           - qcom,sc8280xp-ipcc
           - qcom,sm6350-ipcc
-- 
2.37.2

