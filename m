Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D15673D40
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjASPOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjASPOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:14:16 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A314D66EE4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:14:14 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so3776022wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NPQPBsKrvaOn9sdw34Chj6FAIMw9mMDoh9PXJ52yo8=;
        b=eL1onUrTJJhsavn7jRGxAHwMhcLe30RuHlCuuluA4LWR8R2UYsIt1D4NHeiCLCJXvL
         0FCveMkFJfp82qWAIJLa76KgYHeo5Ti+3A6kQfN/iCwhJgIEy9ylLmgg9j6QQ8fmUM0w
         dwDiWF4eUZ9KgpzJ16iKB4dGghPPSlusLrHtqs3IVVkZVxEr9QlbDIoCV7MWvhOSxj0P
         NFwfdRcZYhIlyfVxYd5QunVKmN65BTMUGM0om7LeoTLze1qT5QhYXnnvszDKq2KPTgT9
         x+rTgRiU7Npnj56e1rid4L/fIGFhk0hB2CgSxEJpnvtIHGdpQxQke5hjn5ALRcGIP6eT
         ytpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NPQPBsKrvaOn9sdw34Chj6FAIMw9mMDoh9PXJ52yo8=;
        b=JJ6yiQ0JyCOYiQGg24Dy/AFpBqivxOc2NDiIG2GyM/Vlu66AAdBeZ/ZZvqoCoZ9SMs
         MlprmaNw/oSwcg4EeekGXM1roBo4QB4kxINMSnJy0QV69hgNAnGxTPhL5El97JrbTLSG
         vpr2FCk+yrSbLKKsDxSnS4520aitZD2RSNUZMAag//75uxXOVRDs6goKL+oYOCtb5d4Z
         Jtc4QAmnHAlKldMivx6ERI/an6o2LTCmM1/7Km17oaHGH6g5NJN0t0jAz4tLD/uDdZ0U
         lOhpLwJoX/UZlRKhlw0Vbqtnao+EiSRl1BMm3eYiEuDlLv3HxK8dagG7pAju0vdyhKRx
         WdZQ==
X-Gm-Message-State: AFqh2kpKsx+4fn0QOweoy1DZOHNWumpwhZhPRkXIFWys/QgpNQeUCrEc
        zqpvwI1TNn4AP0M1MfsKmt+2ug==
X-Google-Smtp-Source: AMrXdXtFaR78IHfb+vhWQY7bzEJpoiv5Zq927fsyxfpUe2pZcQnkoR91Z4gva/A/2hsMmOor335XbQ==
X-Received: by 2002:a05:600c:c0c:b0:3db:1caf:1044 with SMTP id fm12-20020a05600c0c0c00b003db1caf1044mr3969515wmb.13.1674141253216;
        Thu, 19 Jan 2023 07:14:13 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c379000b003db15b1fb3csm4566605wmr.13.2023.01.19.07.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 07:14:12 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] dt-bindings: ufs: qcom: Add SM8550 compatible string
Date:   Thu, 19 Jan 2023 17:14:06 +0200
Message-Id: <20230119151406.4168685-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119151406.4168685-1-abel.vesa@linaro.org>
References: <20230119151406.4168685-1-abel.vesa@linaro.org>
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

Document the compatible for the UFS found on SM8550.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 54f5f8dc5c87..108c281e9d09 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -33,6 +33,7 @@ properties:
           - qcom,sm8250-ufshc
           - qcom,sm8350-ufshc
           - qcom,sm8450-ufshc
+          - qcom,sm8550-ufshc
       - const: qcom,ufshc
       - const: jedec,ufs-2.0
 
@@ -106,6 +107,7 @@ allOf:
               - qcom,sm8250-ufshc
               - qcom,sm8350-ufshc
               - qcom,sm8450-ufshc
+              - qcom,sm8550-ufshc
     then:
       properties:
         clocks:
-- 
2.34.1

