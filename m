Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A78B67CBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbjAZNPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbjAZNOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:14:49 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B632867781
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:14:24 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m15so1085345wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7V3laH3bCohYeyPJkEFuVpf3XlsAopRzeHI1Uj9B8U=;
        b=V63n/+VwNLZ6HZqTwu0QTJZt1Rpblj7GC6EbttSOIUrVRowAM/llOjimnq6m4NC1SS
         DBBTP5SyS8PU/+L5SxRQVIqN/71N9xNfxmd3RXIIVQp/W5ksqa7srafpJFMUgbIdmCti
         N7OGMj163p+LPOz1Sr+3+rFQvw7ceiDDEgmnrtN3Fe+qm3uVKB94g1hBu1FMFaF5FOxF
         S3rf+uGqsCTqFNWdLREmRy+W+X/C3WYXzf9HW7uDe42/WdVn7JKlVUetvU3Qxox8QFco
         iDAvpejQyYWVFR7isQzsSQ19y+m/FxDeHK5j+mM61rEcumqSCVQK0ySZRon8sE9B/U7I
         1C1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7V3laH3bCohYeyPJkEFuVpf3XlsAopRzeHI1Uj9B8U=;
        b=UDT1laRc0BxIEOV81RjZv5gLrU953ULsYt6iHhFhDJ9RmOzaKVxgPVlo6Y6GNADzEx
         lP/8aDMMld3RiyOPSNftOc9ecdtzsFBBy1i0sfYZmgnK1RvVt7N2QazLpJYNVOZSEY8t
         IR4xI3gMfgALzJzsZxjSEiThihi5X25jT2Am4hKEF8h47iqc/pzLRz9qtsboqu64s5GO
         aNRqMnbfspcUKog1Z8eMCBiyULfof9chajKifHg0UVU1MQcktbnVwzn6sKO7/5DkHl7v
         Ggvif4dSDfjvN1ovwx9AMNr674zCvyu4tS5xzXe5ohSI68uQ0ybSAH3j56Ifb7L/H7Qs
         dgoA==
X-Gm-Message-State: AFqh2kocxH23vyuAgskF+FPS1FLc1UBOv1pQwc3TofHxu6gYhAjUsSLD
        J95XqfiYBw13obK5m+XUxq0roA==
X-Google-Smtp-Source: AMrXdXs3ulda+XFv55nj2i5H17hvI3boVBI78iBB7I3UMm0dvkNXh8vDVeOztjyX4y9WU/I5L83+Mg==
X-Received: by 2002:a05:600c:2d84:b0:3d9:e8b3:57f9 with SMTP id i4-20020a05600c2d8400b003d9e8b357f9mr36200959wmg.8.1674738863160;
        Thu, 26 Jan 2023 05:14:23 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c26d200b003da28dfdedcsm1719804wmv.5.2023.01.26.05.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:14:22 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: [PATCH v3 3/8] dt-bindings: phy: qcom,qmp-usb: Document SM8550 compatible
Date:   Thu, 26 Jan 2023 15:14:10 +0200
Message-Id: <20230126131415.1453741-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126131415.1453741-1-abel.vesa@linaro.org>
References: <20230126131415.1453741-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SM8550 compatible to the list.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
The v2 version of this patch was here:
https://lore.kernel.org/all/20230126124651.1362533-4-abel.vesa@linaro.org/

Changes since v2:
 * none

Changes since v1:
 * moved to sc8280xp bindings

 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index 6f31693d9868..ec00fbc06abe 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,sc8280xp-qmp-usb43dp-phy
+      - qcom,sm8550-qmp-usb3-dp-phy
 
   reg:
     maxItems: 1
-- 
2.34.1

