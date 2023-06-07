Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17FE7256D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbjFGIFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbjFGIFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:05:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B1110FB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:05:08 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6da07feb2so69287405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686125107; x=1688717107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFkrWIS5bTgKzqSbTWsL+LQ4FdpiC/6RkXvEbzD8M9A=;
        b=txoDvQrQk60WWDZ/So4hJmmttkncWh8gwvo1vGDyHsRSKl3ozjyKMt0dMTjvBjbzP3
         eSm/NWp2vjM0ZfgIsHDJDPVEJx9y7AgcEqgEWvxNq6xwXK/Bo/95ZQo2NSwOuUXdko35
         He377+OiJ5GvHzcQdY2qcrH//WQhso8psiO3D8daOnvgvEEdwtEFhrGgssBPnGwJTBGw
         MzwFb4bfa7xaWKF4QadjVCgAfH9GJ67GemaKnbGWoM3wT8R3pRjoIikTuuUPy/baC5/B
         tcXdy9qRshjdQgpBgUgjC5iLVbkhIBZinrGYaOqfU2u9/zCPwWdb1ndwn1lDWE6Q6O25
         Hxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686125107; x=1688717107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFkrWIS5bTgKzqSbTWsL+LQ4FdpiC/6RkXvEbzD8M9A=;
        b=BjxeaGauxtdPjHmchSW/jLM5/qE6zjkTDBYOQL01GFXBWoqW/Y2wZW0Swp5A7H1L2h
         enAoC472Yto0LHqHm4FWmNpJ/SQUGH44uhsPx/PCuuk2eNkZJlWM2vYsjE2ayA1M3w5Z
         0Tj3y7dDU3i0/NKbn/+8CslDpns0dlZ8X9oTyq7T6rmn58zmDK3TF8DNzZ5wY/oFOmt4
         X+x3aFg7/aXE4VwOd6/evtrc+BiHmmXf2Brum1ZuGbHb052Ti5z7xjvJkCUoYhJiBbRw
         Gy2+243zWwd23N3Ib+FgNuJTl2OSj5/2JIFCfHNRmsvgveGNpAwbc+yWnH2taoCtFN4G
         gNZw==
X-Gm-Message-State: AC+VfDz9PaqjjDhNHmdubTREeJjqWYfYNuUqrlQE8/J1nsTIflfsaNd2
        c2iRTVWRnUUl6z+t+DJSTbpMkVMpQ+9nnhzvFPsqog==
X-Google-Smtp-Source: ACHHUZ4h9m4HjuaqWHyKHfeFAE3GH8rc/9UYyxOTzQ2nukqHYFkxFrlgNQNTkat0NmP/4LQ56n+N2A==
X-Received: by 2002:a05:600c:28d2:b0:3f7:e5a0:c5f1 with SMTP id h18-20020a05600c28d200b003f7e5a0c5f1mr3670504wmd.32.1686125107129;
        Wed, 07 Jun 2023 01:05:07 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h8-20020adfe988000000b0030ae5a0516csm14706269wrm.17.2023.06.07.01.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 01:05:06 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 10:05:00 +0200
Subject: [PATCH v2 1/8] dt-bindings: connector: usb-connector: add a gpio
 used to determine the Type-C port plug orientation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v2-1-3bbdf37575c3@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org>
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=2BYsv45cOvI4rMBwObrYr2vtUKgDMNXxdkhZSI9+W3I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgDotXhpav615rwfa8P5vA62KMEvrgA4SntRbTQQR
 iSGByJaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIA6LQAKCRB33NvayMhJ0cHND/
 9ugqVUtFHO8q/px+feNwoCjGiM/oRYzf8WzDcaDFR+opIFGh03+ikQE+S9yt8r+w9HGfUn66ES9BHN
 Qj5IzR8K3c0JpdzXgFTy/jtnJybqzTb0cCPaloVG0ZXYo+gHFUESHei+udoM71T9YGSrAe4jl3S4eh
 /HM6XPsRfSD3Q52N/pT6mbXONr3rduAQbksXdg1AlqJ+jY0zAhuymFKoXfONYOnNLlBdn6PinNcTWf
 TnOi2ISLemQjNAvNJTKYAm7snfPuhwhwPDbyqvCj35P1eW011rLVuLe2kutJPyKm/YtyZZZ5dZ4hAo
 13svtHsa/RC/t5YypFs/A4ZueWixMA6gJYm+SbnvnSiQ+xNfzZa1KFEqVh/U+1ZCdpBkVKSfQfoyvG
 Z7kknJyEnunTH+Jv/16+HrLmnhsGCiBmfazbwwO34kY4IqfzyGpgI2PvzjeyPrMoCEImUrF6w/X6/E
 H4M5vC1fTt4rBM7guBH+X9RvFLIsMPpjmcglnoo4RA3vGYaeVkoV9lxXxncyzxsg4to9B07bKD1Jku
 uydt43m9e6ul+OyGcLhGqOvfb1cucsHR6z340/eHfnsasdZ4n8dmiTYI+2cki0iLMzUGugeBaxTU53
 qcep4FvmjW0e+AGz9wNFWsGKkh9aLsNI5xIs9YhuvN4EumLDgLGDIJ3QmhFA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms, the Type-C plug orientation is given on a GPIO line.

Document this optional Type-C connector property, and take the
assumption an active level represents an inverted/flipped orientation.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

