Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641815BD465
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiISSGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiISSGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:06:37 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F360459B4;
        Mon, 19 Sep 2022 11:06:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso5106012wmr.3;
        Mon, 19 Sep 2022 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WOVkCZb3O04AT16VeqinSioOSbzVPOypFCZUq6ayUVI=;
        b=QJAg6BFvWNC9EJTCk+LnIAN1SG3k4vqW/MqpECaGW1NvMFrsxm8dvQs+EeS9b6LKEB
         a6NHth/u7xEBTk/RKmygKljSZ9NRL5EqTnQPylXF0vY5oxBx9CQtnnDgmP77FdgdPFn6
         c8z+g5vCMKASQXpH39CxzSjoTRHAS86t9Wx0AG+R8CR9kQSjpC23RhuT3xMC6h/TyhmZ
         qFvfWJaHbPXwn50G2dvt1WyxdH/bm9Ivhu52hy85LVTypI0VnOuVS92L26bzJA24KJW8
         wVbvd6JaUebXDJV1p+afhdqsqZuvXNaPNBG0bgthBpDX4j4RYac7F13wKi0YrLZzjGLm
         EA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WOVkCZb3O04AT16VeqinSioOSbzVPOypFCZUq6ayUVI=;
        b=g/5GSzBcvyqVR3JeeGJkoMECEFtUSajJ1jRf8JxHooBUGwqWEXwjqqkUudphtdA7m7
         K9BwJQy2m+JQ159liWd7v+DfO9oYAnAPDKuXA5KWwbfyXxdoq+ISR9nJzFmJoId9gRM9
         qW8oQTfxfP4D+P+jTU4jo/Ncu3gYTGa5b7Lm/+Sxv0c/mq1rtf52lw6SIvv+mq26M3+Y
         uy33Zg7CuE6bkViwPWONaeHQ0RAYf8N8P9dYu7GuVT2+D5+LIO0YhIpEdRBnT3Ak5Q+K
         lINonyYjf2KUXvcgmJfltaZG6mlCWto38wQV0vpp+sMHu9+BUxzqdBaGH3+43P3I+BOZ
         7FDA==
X-Gm-Message-State: ACrzQf0s4N92bBW1GUfMTs0J1A3262cIIEp7C3S5Luge11t2rlVtClz2
        fcUR4opI6HyL03dtM2w3Nns=
X-Google-Smtp-Source: AMsMyM6yMKNCUIGLdFX0/ByuK0znJFoWx7frlSKYplM+O/8lNI4K7i0JKz1dg9VL6+IK4GkWzJwDxg==
X-Received: by 2002:a05:600c:4e44:b0:3b4:bed2:4f5e with SMTP id e4-20020a05600c4e4400b003b4bed24f5emr11737933wmq.193.1663610794295;
        Mon, 19 Sep 2022 11:06:34 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id 2-20020a1c1902000000b003b49aa8083esm14709624wmz.42.2022.09.19.11.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 11:06:33 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Thierry Reding <treding@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/8] dt-bindings: arm: cpus: Add kryo240 compatible
Date:   Mon, 19 Sep 2022 21:06:12 +0300
Message-Id: <20220919180618.1840194-3-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919180618.1840194-1-iskren.chernev@gmail.com>
References: <20220919180618.1840194-1-iskren.chernev@gmail.com>
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

Kryo240 is found in SM4250, the slower sibling of the SM6115.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index a07c5bac7c46..5c13b73e4d57 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -174,6 +174,7 @@ properties:
       - nvidia,tegra194-carmel
       - qcom,krait
       - qcom,kryo
+      - qcom,kryo240
       - qcom,kryo250
       - qcom,kryo260
       - qcom,kryo280
-- 
2.37.3

