Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D97A5E9B02
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiIZHri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbiIZHqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:46:52 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25BB33375
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:09 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z25so9523033lfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=aRzCLHXMgOaE9eO10q8ceG6/cKy5enBoZeNLkXTHGWM=;
        b=y5E7CU+viSgGYDuQVfmynM93lM4s/ok4RfsRLj96f6vxU2am62vtJDUOn0TcXGR34Z
         lWUmKk0BQDNuaQsd6EFd4GLEh8sZ3LiEbaBo2zn3D89fpBZ8tIwEdCF5vjOVuoMk/MlN
         A3Fcmnwh87lUr+RonIFQ25Lr2sMCBJqnqT1t7BYcdVlJP/P4q9pUjBTn6P8m80JNazeu
         cUHj5tJRZU6wHXIl2IhIFhtDOrTORx58xvZkDZ7DDM647K/8tTW7h4UZNg49hkf7BRhy
         D/aiTVmFUcDFuyIftMeWvSnQUVAU5Gjqm2Qdmh12AjmCHTk6NEos6m0QorHxDl0V7VqY
         FdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aRzCLHXMgOaE9eO10q8ceG6/cKy5enBoZeNLkXTHGWM=;
        b=AYrdPge0RHYFgmEcBX1E2EMPJZu4BK7eCbdXiKuUPduuij5fex+NOeOGKrpXY7I8ro
         0YXIWpghhBem1piS0wAWxNAfoI3Xh4D6cVmgG9aM0s+FzmTgPaTkWl4KUdUMXq8q00Ve
         VwM9+aNuGGV7SvNC5VLfHkwdtyoRD4RjcyfxeaZYvJnnc6mu2JWiDUQ2yQmH1BKUug6W
         u1ofes4Ah11GXVayzactTEy91pBLh1BUrV30JS48J6bdaqI63eBhuxaJKIJGuHrBn3Or
         mW8V0tOfUhliL5MtAt0bUOQ/5XheUo/O9aYmllToITA4nwVF+TEWHMVu7iLi1MC57je3
         oSPA==
X-Gm-Message-State: ACrzQf2aooWByl/ggree3oRW9mzF/K052lsrGA9ksruoT3RgbaZhAwla
        GDU9JHjeKXmst1lDINPCmmzhLg==
X-Google-Smtp-Source: AMsMyM4r869QKG+jb7ZDI/f4dc8N3pWhiTiKDBQa4G5FWbMOR0wCi2rOv08iw6+1hXUMvORg6tSQJg==
X-Received: by 2002:ac2:568a:0:b0:499:fc24:243e with SMTP id 10-20020ac2568a000000b00499fc24243emr7884031lfr.465.1664178309326;
        Mon, 26 Sep 2022 00:45:09 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2453298lfj.266.2022.09.26.00.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 00:45:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 23/33] dt-bindings: pinctrl: qcom,mdm9607: do not require function on non-GPIOs
Date:   Mon, 26 Sep 2022 09:44:05 +0200
Message-Id: <20220926074415.53100-24-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
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

Certain pins, like SDcard related, do not have functions and such should
not be required.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml        | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
index f7bd4be1739e..57a4fed55de7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
@@ -115,7 +115,6 @@ patternProperties:
 
     required:
       - pins
-      - function
 
     additionalProperties: false
 
-- 
2.34.1

