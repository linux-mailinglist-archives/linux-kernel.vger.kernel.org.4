Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12D9639BDE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 18:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiK0RJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 12:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiK0RJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 12:09:20 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91D8DFDA;
        Sun, 27 Nov 2022 09:09:18 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r66-20020a1c4445000000b003d05a3775d4so442264wma.3;
        Sun, 27 Nov 2022 09:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpkxZ5cltPLYU9mAjuP/FsJ8XLT5RTiCRGescyBtpOw=;
        b=B5dDfdV91VED5P1pDZ665aPGBGjNhFi0Ss96gkPHCCzzkd1nhm9d6beey+Lq1eFX1N
         4qTYqJsx681BhpW9bwOwZ82G9oRYkhhYLxvDQLx5dLfzXgklJyD0u3o1U7qzKtRMoKmH
         BZaHoA/14R0u+wMg70LwDILeC3OwYYI6I6z1C3MJ7B77A84f0yKFWlhSu8hgVrLvq7jC
         DD8QFUPP5rF6MScySpUoGZZVRS6fHsnba5t9gPOOWCywoFqvwGAQksQf7W/i/8OAmnZh
         IBygzhFkLVqsnvz2XJ+lmJhqA99fGwYgswXNLuhp1XlArvelHeiWfz8jygsMHfLd90YS
         eJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpkxZ5cltPLYU9mAjuP/FsJ8XLT5RTiCRGescyBtpOw=;
        b=SkkcBf57pTg270pLxP4BSKP0QT9sH8oXUmtUEzD2DQJgCa0vMwNewC0yYIOxPxR5Od
         FQzHn0I8KioebUVXfQ+jxvAFgqc+vSy3ggzMyDy4DBW2jWYetunYIubl1fIJIeJsGXXz
         VhVQK26uBccZZO56NO/cEKABMS1aP2ppoWqy2I3fIyZRG7g7QY6AnMaHd14LTNBNjeBC
         c45GU8VDixRn9nyu/2slu1i//9Mdg0GbnNR56xma4k624b23NOtOXsMOk6E79u0ZTRby
         3wwtm8duZHZ/V8DYGApIGPa5v1wBFRVRlQrP6ix19M1j+AwAUV33u/VFwb/4x66m76QM
         bGPg==
X-Gm-Message-State: ANoB5pmdlWdqlX+5M7ZNpi9R0mQOaq1tU49+YdsiWChAGd+yc9M0Hc3u
        Skev5jSE2HxHo2TzBIcECx9J0YoRnDVBmIVd9ZQ=
X-Google-Smtp-Source: AA0mqf45n5K24cLu0CZz7VR9g1qsINXM6LaSbftjTh2q8+/gCwoeintCFdU+jOnwNhbZ88eLfTHGAQ==
X-Received: by 2002:a05:600c:46cd:b0:3cf:88c3:d010 with SMTP id q13-20020a05600c46cd00b003cf88c3d010mr38367362wmo.180.1669568957417;
        Sun, 27 Nov 2022 09:09:17 -0800 (PST)
Received: from david-ryuzu.fritz.box (ipbcc3aba7.dynamic.kabel-deutschland.de. [188.195.171.167])
        by smtp.googlemail.com with ESMTPSA id h17-20020a05600c315100b003cf483ee8e0sm17759967wmo.24.2022.11.27.09.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 09:09:17 -0800 (PST)
From:   David Wronek <davidwronek@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH 1/3] dt-bindings: arm: qcom: Document Lenovo Xiaoxin Pad Pro 2021
Date:   Sun, 27 Nov 2022 18:08:56 +0100
Message-Id: <20221127170858.440040-2-davidwronek@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221127170858.440040-1-davidwronek@gmail.com>
References: <20221127170858.440040-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for the Lenovo Xiaoxin Pad Pro 2021 Android
tablet.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 463509f0f23a..588ac7f12a81 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -796,6 +796,7 @@ properties:
 
       - items:
           - enum:
+              - lenovo,j716f
               - qcom,qrb5165-rb5
               - qcom,sm8250-hdk
               - qcom,sm8250-mtp
-- 
2.38.1

