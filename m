Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A745E89AF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiIXIGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiIXIF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:05:26 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABE011F120
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a8so3475115lff.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Kn8snOEqMnKZZ7rQ8tp5scK4VBgltPb1inLsc+Q/YzY=;
        b=jekkDd7tcu4nwlREc73k2xLdwzgw4KjbatOf2RG8qwswgFg8YhXly87z/qewXIeOfI
         PJg1d8Iu28acbKjBgEtpbHhrKM7k53Nm/9ikpbQlK6W5YzM0nDBZuyM0aWQMYLWcxDOe
         aRlGKDtkMA//jiKZZufO/3sJ3If2SweWhCit/0nxtO2qDglpoxwvIQ5PMg8AlWhZtCx+
         TnHoA0cU/to5QSrUdI7IfP7L6nFcGV8CMfk09kjWHZRRQB9c5CLLO72JsKu/x1V8LO9V
         DE9Dsr7Rp/yTQ0H5W6sY81dZ7yHt4G6Cu0tocNGw5YaHOmE1mKTA3Ve6LNnJBboR5+Xr
         hVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Kn8snOEqMnKZZ7rQ8tp5scK4VBgltPb1inLsc+Q/YzY=;
        b=OfcstuMQIYScM/m7hTyvNfnooo8bfkqgaP7u6GCnl3afbyGaIcTNxzSJy1izh7F2qS
         kb9RvXU4TdqXit9tVD3J6l5L9GCv8+FL16FqGQip/SvdoabkYF+fObMUHkx3yR9CZKrs
         c8KvtF31j691u6LYUBYqVxTSN5FWbgp8lQGcYg4k7rauqve13CMUc5mhD25QP0ubsj90
         rLouB7AF7OL43VUSqiqqfTZBDqIODgf2NIE8xPTXo5hwMIwWg1fNaUmJJ1QAQYDRUqWv
         EdksT3x+P3DVOhX3qLwnWbJB0FaCQC3mh5BZPMFgpW0W1NvHZDcvTY3krXzusFJA+q37
         Gk1w==
X-Gm-Message-State: ACrzQf2CyMMkRwyB251qDpFOPu8xb6bM812401u3CH32Y1b1VNDQY76H
        HSNnoL1vPpPJTB4TMG/cs+/VOA==
X-Google-Smtp-Source: AMsMyM4QQWPwcGXvOUQEn9SQ5Mdb7FELrh7/7El1mOtX4lu2UwXVzYoaTV9A2rRrpYNPsreDBEYgbA==
X-Received: by 2002:a19:5044:0:b0:49f:b08e:d1c8 with SMTP id z4-20020a195044000000b0049fb08ed1c8mr4676869lfj.180.1664006716384;
        Sat, 24 Sep 2022 01:05:16 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y2-20020a2e5442000000b0026c41574790sm1696668ljd.30.2022.09.24.01.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 01:05:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 07/32] dt-bindings: pinctrl: qcom,ipq6018: add qpic_pad function
Date:   Sat, 24 Sep 2022 10:04:34 +0200
Message-Id: <20220924080459.13084-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
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

The IPQ6018 pinctrl driver supports qpic_pad and DTS already uses it:

  'qpic_pad' is not one of ['adsp_ext', 'alsp_int', 'atest_bbrx0', ...

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
index 931e5c190ead..1f7a5f285404 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
@@ -92,9 +92,9 @@ patternProperties:
                 qdss_ctitrig_in_b0, qdss_ctitrig_in_b1, qdss_ctitrig_out_a0,
                 qdss_ctitrig_out_a1, qdss_ctitrig_out_b0, qdss_ctitrig_out_b1,
                 qdss_traceclk_a, qdss_traceclk_b, qdss_tracectl_a, qdss_tracectl_b,
-                qdss_tracedata_a, qdss_tracedata_b, reset_n, sd_card, sd_write,
-                sec_mi2s, smb_int, ssbi_wtr0, ssbi_wtr1, uim1, uim2, uim3,
-                uim_batt, wcss_bt, wcss_fm, wcss_wlan, webcam1_rst ]
+                qdss_tracedata_a, qdss_tracedata_b, qpic_pad, reset_n, sd_card,
+                sd_write, sec_mi2s, smb_int, ssbi_wtr0, ssbi_wtr1, uim1, uim2,
+                uim3, uim_batt, wcss_bt, wcss_fm, wcss_wlan, webcam1_rst ]
 
       drive-strength:
         enum: [2, 4, 6, 8, 10, 12, 14, 16]
-- 
2.34.1

