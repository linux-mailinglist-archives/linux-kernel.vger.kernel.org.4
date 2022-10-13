Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EDC5FDDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJMP4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJMP4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:56:25 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D487BDAC52
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:56:23 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id f22so1633648qto.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3PRQnLRvfXqNUkcNjmJu/EoFGR8mRPqRK0FF4Uwz8U=;
        b=eYzcVw8ZgCzx5XLSQ6jYuII+9/Ff4AP8xavQYz/H5BEw7uFsY3Ohk5mTl8Ia2+GTz+
         2+Hisu5X0ta1CJfmFfKmXAIkjaNNKXfaZgimSa3b2phH2ny0KP1s+QMuf6Mpr6xkJ+Mv
         tzcd3llLvybWcO2Z9K42Btd/XB9q2WOMb8z16kpFYAmxdd8shqtUalqNvBvysuRQ2ZZv
         uVfjx/2PIv4s+eO6MQPSQUg2hsLoveT8a07+OppdWcqGjnqVXvZI+IGCWbPfOA/M+Fnj
         atf87vF/UAJosAxN3n35vJyU/WmTmyrQgYc77bG05EAVcOivwAKkiIZKlqDWKvFLOoxD
         8gNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3PRQnLRvfXqNUkcNjmJu/EoFGR8mRPqRK0FF4Uwz8U=;
        b=WtmJ1T8gSHnpCcEWdU11GF42iMa2edxeRc3MEkpV8nez8OFbRB9H6Wk3DzBQcnazp8
         kuwbE3oKZZ6cfkm4DmCrXLKR+aFno0tJDfUQqm6FtXra8jymPr1FraH0kgk6QAt0I4At
         fDI79D40TwxmdH8anu1PW5cWvIl4shGhWOU8DfzskEaEqztS/cyAduEeU+rvUgYaQECp
         UN/7oO5d/3MkBgK5bFCTxEUDcvM6jjaiZMQJWVU5KbpKp6HONaMqvfttdyBJfgi2vq+7
         FmjLon/xXFrGdElrfghjn0Y1K6eEStVjZqFYZ3rO8Zu/REZjKYVWKj2JqU3Mes2szO/u
         exVQ==
X-Gm-Message-State: ACrzQf0dRXcEjL6vxcv9m7hW7quFGtT1tnAdQBTO32tJArPmSv81TOe7
        kbNE5bl7H3h4R7hb+DTaav26hA==
X-Google-Smtp-Source: AMsMyM6fkg8M4mnN25X+2FtDvmjE+eEeFlBLVN1yds4O9/Ex2cNkwqzvP+2nU1KVC+RfhWxyOdik7Q==
X-Received: by 2002:ac8:7c43:0:b0:35c:cd8f:3da5 with SMTP id o3-20020ac87c43000000b0035ccd8f3da5mr395117qtv.61.1665676582952;
        Thu, 13 Oct 2022 08:56:22 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a0c4600b006cec8001bf4sm65280qki.26.2022.10.13.08.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:56:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] dt-bindings: arm: qcom: Document IPQ4018 boards
Date:   Thu, 13 Oct 2022 11:54:16 -0400
Message-Id: <20221013155418.47577-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013155418.47577-1-krzysztof.kozlowski@linaro.org>
References: <20221013155418.47577-1-krzysztof.kozlowski@linaro.org>
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

Add compatibles for existing boards with IPQ4018 SoC: ALFA Network
AP120C-AC and 8devices Jalapeno.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1b5ac6b02bc5..9ae0e7c675b3 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -29,6 +29,7 @@ description: |
         apq8074
         apq8084
         apq8096
+        ipq4018
         ipq6018
         ipq8074
         mdm9615
@@ -244,6 +245,12 @@ properties:
               - sony,xperia-poplar
           - const: qcom,msm8998
 
+      - items:
+          - enum:
+              - 8dev,jalapeno
+              - alfa-network,ap120c-ac
+          - const: qcom,ipq4018
+
       - items:
           - enum:
               - qcom,ipq4019-ap-dk01.1-c1
-- 
2.34.1

