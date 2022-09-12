Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72165B541E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiILGT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiILGSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:18:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40402AC42
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f9so12422482lfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zwTA5qS1hc7D78vIogufG1A3n3m88CDEiwTkMCUDUSY=;
        b=NDZd5eNQd/ivs/nVIC9+jVJ08nKEpAoyAwhRw1juzvmkT0Hwzf3F5/luL6s/GjkvyQ
         jKw5zrEGPEvwojwtP+s8ozkk2r7U98apViw+oVHKxu432P/r+Ti9dJpOodQwjxca1vMT
         +0NMs80i1YSJcBZ0hFOIdhFO+4nGMIP6dFt7jO6KUUXCWvrftuxXFDU39GvyBE0kI8ON
         dTDO5k72cnTWQqzq2z7Rx0sQfveRhH4g6JADB0BowhRHbo1OBPdN7emxV0rLTm8cxeim
         G3oJEkRj0HD3yGPLyh5teVSRyNBnpVXVElYHl0dZSIiqODL4f+G3d2Zf2/sEOkSe7ro4
         T/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zwTA5qS1hc7D78vIogufG1A3n3m88CDEiwTkMCUDUSY=;
        b=NW9+8Ir3ThAxnN8g8eddlBGxEXx/L/N65vhEa39F5vamF4IcQZR380b2ilfoYdSjfK
         F+Fd46uqCC3xfxgmE2JXNHlzHx74f85b2YiXxOFSLTeBwKfWHEodlnmY6z1Um0W7xfs6
         X7Pdf6zJP/xOZq1QGnzeIoaCFvICgaJxCiJdwPHva62+HJMHNdHLL7TaE4AJbirVafZS
         YlaVp12Fe2atiSbmXPav5oQ5fo/KpTcP3x4b56OrjtMV3MSobzG+YlwKRe0AhaRIPofm
         ++0wZjpOptAdxI6RsuO9yGKdSUyEOpp+cA2EON8Q+VyE5kaDlhsqJFzuBSioT6xwiNAq
         FwtA==
X-Gm-Message-State: ACgBeo2JOGsyVucF/H6EtcumO1ksKanuoU3x+v1k4/dEWl4KheKG2uk0
        5h1LmKEj9LxpMpV+ap1Ie/q62g==
X-Google-Smtp-Source: AA6agR6ed2DHXO6r4Y3xKZSWqZRAbcp2otrsHX/5b3717I2u2EJGrPHBG6Qqasap9hgOmK6nKgPu+w==
X-Received: by 2002:a05:6512:15a5:b0:49a:84f4:9284 with SMTP id bp37-20020a05651215a500b0049a84f49284mr1758805lfb.477.1662963503474;
        Sun, 11 Sep 2022 23:18:23 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:18:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 23/40] dt-bindings: pinctrl: qcom,sc7280-pinctrl: correct number of GPIOs
Date:   Mon, 12 Sep 2022 08:17:29 +0200
Message-Id: <20220912061746.6311-24-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 182 GPIOs on SC7280.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
index 2bd60c49a442..76de3b1eb8c7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
@@ -60,7 +60,7 @@ patternProperties:
           subnode.
         items:
           oneOf:
-            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-4])$"
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9]|18[0-2])$"
             - enum: [ sdc1_rclk, sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk,
                       sdc2_cmd, sdc2_data, ufs_reset ]
         minItems: 1
-- 
2.34.1

