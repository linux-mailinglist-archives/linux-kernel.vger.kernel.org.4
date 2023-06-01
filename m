Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8E6719F28
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjFAOHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjFAOHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:07:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8222C1AB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:07:09 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6dbe3c230so9242125e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685628428; x=1688220428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDXbkTppdjxAQ8h3R3G3hKWJWRPcHZlz999QVqKCfpQ=;
        b=ESrafRqymDIAEtGcBVrYIbqesxFh4y44UJCrFQZAgEeNDSs4PlFzn2dJGuwZJC4rGW
         KCRj5Yu9BCivOe5fo2ovHCgNyODWqfTas5VlmRgjhJjB5Kv677aOEBYneJiH1Yl5Omo8
         LpVkd3sUBbPTidlQs4T+5KUoyH4L7jU9Mka90+M0Re3OPcX28NAsFfJo7T5X/Z5tml9n
         AhZNBRQAS1VceOC/xLHYUDcFwdhIqdyCZHX1CRsV5QN0GQXGSn4Hpo3vKJJy/kvkhm+i
         P9zskhTmigx1BMGsM2H/yaCeCRcpjzc2bwpE+jTpmdDuCDjmUUsuO/zJ4la7NLHQP0mI
         RmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685628428; x=1688220428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDXbkTppdjxAQ8h3R3G3hKWJWRPcHZlz999QVqKCfpQ=;
        b=gzLmkFEvKkLn+irKpV8Ftqfg//oA4jOeP70MBRqPbDOQGNp756yXn++Emc2GV2OuWt
         31f1bAJ4OopXon26VLOTWcPPDkSVP9D1vrC+3kKXBB3QsiBKK/bPwUHGiwyHnrpOz00I
         TgFDHUJKnXmlYXGkkbEk09aXb2TbYgmW4OXZE4MsG8J5C4K5eIS0jr7HxNh5ckRVipwP
         gg/5RfGIMaXSCwiW93TAYyxTP44LtwCkc7KufhjljY4hRbruY3LpsCC8YX9mRJn3KK8d
         3l51kXLNK+XbE0J6ZxQENU7gTSC3tVVitZRlMuq1EbeFXHmBCIUd2J4uBOjJQxsC5v6F
         cMlA==
X-Gm-Message-State: AC+VfDy2TrceZlxqCZ02ZLpe4Mc6VzrF2DhpsGkxa0ETywwzfSPOYpPy
        o4CxwIFWv2mEbXMydgEryFC/Uw==
X-Google-Smtp-Source: ACHHUZ58I0XJymFL/i3IMgjigb//ajC4y2R0ISDG78hWNownQvH+1B1dy8mQKsegL9OlHc/B0X4pfQ==
X-Received: by 2002:a7b:c00f:0:b0:3f4:1cd8:3e99 with SMTP id c15-20020a7bc00f000000b003f41cd83e99mr2041970wmb.28.1685628428080;
        Thu, 01 Jun 2023 07:07:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k11-20020adfe3cb000000b003078a3f3a24sm10504166wrm.114.2023.06.01.07.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:07:07 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 01 Jun 2023 16:07:01 +0200
Subject: [PATCH RFC 1/7] dt-bindings: connector: usb-connector: add a gpio
 used to determine the Type-C port plug orientation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v1-1-d4d97b4d8bab@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=cvE1/snGhi9JqHiPX/H9x4U1AzFta3//P9TFUvBRJSE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeKYHIwKO89Hmu4fpuG5/L+zks0oTkmwh5IzqUuC/
 NghOYvyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHimBwAKCRB33NvayMhJ0fdjD/
 9cz5nH2w5E0PzN7Ncbka3ISElAsuejYJ8/1iadM9fKugu+gMIYBGfoyI9UwA58ybLNXBgFRDT/nv2n
 9AUuyKQEAZ5uc8S7R5yqlWIdP1pJS67tu+mfywu0/nco1/PZUOM3eV3b9rIGAFR7NdkSN4+8os34r4
 thFXMbAXw7G4h6l05K525TcH8KNsIowJ4C5LQ3PFDHmZ3XNp1IcUpQi8JpSXrIrMmYVr1ojRD+sGaI
 F31yOCS9uwIy4Tlyyrni3fzcyItDwMNLs1kAGXa1qBRaw3RRC2bm7vo30pPaeb3Pjan+KbvM+lhnRP
 qgf7NRdFppD5ClAnY5DjEbqDAygNI7Zq4K8Mi4gCEyKnW0mVppRVvNZycZiXPLAasLBb0S6kg5WHc2
 0iWP0+IBjwclrlezAGiFyFZAEik/+enLw4q95xG1MrofWx0BjNxKTLVqtM4NjsAWKdLBodTg3Ai3dV
 Pb8IPemBJu46Ec7ME1AJxSU3U+XZ+Ld3EDenoOX7Ep8jmFm+DcS8tubVUND/2OGlxMgRpxs7qTNlpl
 /ilWcX9FJXm2Cn/IW5NcXvmwFDJvqrl77ozc4Fw6qRt8MbUFuDl3oOFUsXTvH1XdrsaZZOluIpedcq
 gxmD85I6MMsy8ztVfXrMYiKQjhYrJCs42WuqpdCU1F3e4f8U3yV8/oXM70Aw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms, the Type-C plug orientation is given on a GPIO line.

Document this optional Type-C connector property, and take the
assumption an active level represents an inverted/flipped orientation.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/connector/usb-connector.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index ae515651fc6b..c3884eed6ba4 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -114,6 +114,11 @@ properties:
     description: Set this property if the Type-C connector has no power delivery support.
     type: boolean
 
+  orientation-gpios:
+    description: An input gpio for Type-C connector orientation, used to detect orientation
+      of the Type-C connector. GPIO active level means "CC2" or Reversed/Flipped orientation.
+    maxItems: 1
+
   # The following are optional properties for "usb-c-connector" with power
   # delivery support.
   source-pdos:

-- 
2.34.1

