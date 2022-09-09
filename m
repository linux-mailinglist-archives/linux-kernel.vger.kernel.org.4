Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F065B384D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiIIMyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiIIMyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:54:18 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A348910BA52
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:54:15 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f14so1545543lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9yt0jEq+pc8s2OJEJHVFLa3aiH3pkCOI+VxSLX+sCE8=;
        b=SkxCE6R/deryI7nWW/c6D64WutFNZy3A6sOqad+2MqeXJkbqmO2rTKJEmtDOnJBdi6
         Nb5a2ifXvg8fekXjeG0OoLsdUrysU8VywDjeviaLsl4NO+ufy0yFp8LVpKGPf9w90Vgq
         0dl8uIbtmKmzDYzQsNaJJLeZc/RvN5ikBfo8ff69MfHmd7shjQGEHRj6Lu71nIqkPHQp
         WJ//gWZcDiDIcj7TQT/7bmAN0t+eu3BV8jWESVWCMfaPggUHDyv1xxIrAe6OVf0sRfh3
         sgV9j58kfFwFr8Rjhah/a4vsIQkC0doBRdP4CHF/sjxx7GVa9rgsLnyZ4lCKI5Wu3zJl
         uytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9yt0jEq+pc8s2OJEJHVFLa3aiH3pkCOI+VxSLX+sCE8=;
        b=78b9Ummrl9BezsR7ox42fhB5O6T7QCis+06v61obotJUHL1qYEFCw40PdBUI8Cu9SI
         JExyRmcrSxhbJ5rS+cc7GKNK8uy6LFTPI2R0Ho7fWcXUKtAZb9kMc2oWynGB64oR0FIG
         3+ETarGoB+J/NHUw9NSMN5jDQkhP3krty8RkAdenNJpyFj9PmcZg5b58jwlNKXjvVgCe
         QaC9n+i4D+8svfc1mBBiYEiDp8YxKJvcTLQwQLb7bVW1E60w0qIXn3doXBHNt2YaQtWs
         3C87X0ukrbSXRmlIWN3N6OlCd9yYGz7vHOopzv6RbYBIhj0S9wVAp7Dvbz83ttPCFoc7
         B+Xw==
X-Gm-Message-State: ACgBeo0Ti9kB0kHATKIza0QP/kelKp8KMzeLVbyuCXuTYsV/CNmSwXIe
        NUt7mbDlXL9g+RmGbBwVws2/2R6FAP8ShQ==
X-Google-Smtp-Source: AA6agR5+2Qty0DSA8nwCBoIUTICc1XG28SSb65tGJl3BU+MeDv/C4NLiBhCW0htFG+nM/Q4g/auEcw==
X-Received: by 2002:a05:6512:3d07:b0:498:f201:5679 with SMTP id d7-20020a0565123d0700b00498f2015679mr2444850lfv.161.1662728055229;
        Fri, 09 Sep 2022 05:54:15 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g10-20020a2eb0ca000000b00263630ab29dsm64750ljl.118.2022.09.09.05.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:54:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/7] dt-bindings: remoteproc: qcom,glink-edge: require channels in children
Date:   Fri,  9 Sep 2022 14:54:01 +0200
Message-Id: <20220909125403.803158-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909125403.803158-1-krzysztof.kozlowski@linaro.org>
References: <20220909125403.803158-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GLINK edge contains subnodes representing devices related to the remote
processor.  Each of such device (e.g. APR or FastRPC) must have
a "qcom,glink-channels" property.  However the APR or FastRPC device can
be also part of other communication - SMD - thus their schema does not
require "qcom,glink-channels".

To make the GLINK edge bindings strict, require "qcom,glink-channels"
for its children.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/remoteproc/qcom,glink-edge.yaml       | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
index 8953678da83e..25c27464ef25 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
@@ -19,11 +19,15 @@ properties:
 
   apr:
     $ref: /schemas/soc/qcom/qcom,apr.yaml#
+    required:
+      - qcom,glink-channels
     description:
       Qualcomm APR/GPR (Asynchronous/Generic Packet Router)
 
   fastrpc:
     $ref: /schemas/misc/qcom,fastrpc.yaml#
+    required:
+      - qcom,glink-channels
     description:
       Qualcomm FastRPC
 
-- 
2.34.1

