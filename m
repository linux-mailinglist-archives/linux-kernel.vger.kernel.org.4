Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5554B5B3848
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiIIMyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiIIMyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:54:33 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA7D1174BC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:54:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i26so2487548lfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=SK7F419KsULn20Qc23O2UdMj6Cm6vc/xEry45+k1nrI=;
        b=VAe9WzpSTg5gV/MBrdHd/oDjQx5rn3PmDUoCDgcBW9JwHkEnHoRdG5JalopfZ9Hcmv
         daQOg/tYbgSjhHg0xih7vFHVjbsjchcq4WXayTlkuiAiH81voDR8pAaed4qmqxwaBdQV
         3Eygs8BNIgpVJHrJPz3+E34zmi6MtYyumSoQkIDk3HYJKwjQNR2VVQVRjP3k7d9PHa9O
         /5CMk5rbc/qxI4GSO5knjd0I5rzS+AHYw0MK9r9vQjRehwB+sCwToZu3nPLTDJDLAddo
         Rk6mScvg/x80g1Qvlsz+RakqqA65gq1ehOZ0pmo7HuPP3YXV6zm7jOT7z+am6akDlABQ
         1C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SK7F419KsULn20Qc23O2UdMj6Cm6vc/xEry45+k1nrI=;
        b=aO44Q5N4cB0UUbnHzjcPEe09HElbYRFeSzDCWZPuKpZwqGFyko59tfmvHR1HG+stul
         z6Gjig8Iy3lR5feoYV4vbU4ILBth2b2Nzd/jXYMqTF/tI7Yzw951js8oHSqz/I3rx+ky
         iUnEC5Z58JIILYJzxDJ8veg+LkL0hS0bo8kcztibKwTnBsh0kxatw/kvW5rO/dCofBbx
         ex1yhQqcXweKTUt+bBBfnoMx/y+629162qgQXRHsn0QYvuafwJvopFBL4/YRm8gPrn3W
         XFMpvQYmeLZQrs7tpMnSr/f/HuWMdjoJzJQmqyP21ngNQQlxnouZgJP/sh0OzBhY7uD+
         iETA==
X-Gm-Message-State: ACgBeo1sbTxnEb6g+j+ZQJUbA+PNl7HK3Yoj2WyO6dWu0LTLmgTPhQ1I
        MXPNH8L5zYivL+KiuPLLOUxXJA==
X-Google-Smtp-Source: AA6agR7w2LDocmgp+aIUOuWEMqoBIZQta0dJGfd0R0ve/cQMRRRIkg1RFEIHCs8EzjBb6Gdws9Vb1w==
X-Received: by 2002:ac2:5462:0:b0:48b:2a7b:3c15 with SMTP id e2-20020ac25462000000b0048b2a7b3c15mr4525869lfn.489.1662728057198;
        Fri, 09 Sep 2022 05:54:17 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g10-20020a2eb0ca000000b00263630ab29dsm64750ljl.118.2022.09.09.05.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:54:16 -0700 (PDT)
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
Subject: [PATCH 6/7] dt-bindings: soc: qcom: smd: restrict child name to smd-edge
Date:   Fri,  9 Sep 2022 14:54:02 +0200
Message-Id: <20220909125403.803158-7-krzysztof.kozlowski@linaro.org>
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

Child node of SMD must be either smd-edge or rpm, so the pattern can be
narrowed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
index 9b3efe97f47c..0e548234611e 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
@@ -20,7 +20,7 @@ properties:
     const: qcom,smd
 
 patternProperties:
-  "^.*-edge|rpm$":
+  "^smd-edge|rpm$":
     $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
     description:
       Each subnode of the SMD node represents a remote subsystem or a remote
-- 
2.34.1

