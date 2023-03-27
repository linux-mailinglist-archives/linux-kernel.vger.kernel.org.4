Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944AE6CA4D5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjC0MyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjC0Mx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:53:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD35197
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:53:26 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id s13so4984874wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1679921605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdWVdTE/8Dyw4hqegkINdb1CQZwRDCkTAUWJC3MHmmA=;
        b=HvYgD4KGYU/NxUu1HsxoxwPql4ri+9vu7aNFmN/pL48Rqhg8qSXg6EJk94NuMbJu54
         sVCkXD6JWcW1vJ2QCfwh65LyWiJNdXGN4aLIH1McTfvsBjhMr95Y0PcqOXgwIbQT+J7M
         U+xH04cfB+GTeUfoROWlcZg8iwEHQy+uPrgMAVChBrGlHeRUEkXrQ0/p0h51zw0dkoDd
         loC77Ifuc/ho6A1MMEnEfuBaSHyvBmHLRjTT/UUzG29Y7Rll+tVZ5P5QQAzbZN10oQYa
         mM48wLP2IeZg/ZI28lXy4J6y2MkDW4rmHJntSRGRwz5I0FPlKL2Kz6R9hOSwYTxwdtmr
         oIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679921605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdWVdTE/8Dyw4hqegkINdb1CQZwRDCkTAUWJC3MHmmA=;
        b=bB8vNMEni/tGzwJ2V1ASNoTwj2BVcNL/EH49HhLN680EpS+fpiFit8pvj4mHgO6Mt6
         kstaZDcWOIIFTcBH8KkUYJp4ZaKEXFIJxCG4Q1jSsMb18hF+dAXtANUzMr66IFQ8uRlQ
         qW8cJXOK9MNJA6I7WefLNuJRJJ0z8LK0SdtEVyoU3vnbOGgNnq60mgIY7F+rrW5U+VHt
         f3XOTYOOk7S4nf4R+WDlrmJXnmCam9Fm4CZ3Zg5DgtpdcIdUYzs2dU69dXxgjf0LcjEF
         63TAYT94i88rTKzyREeCHvMabdyPXOvhR6RHcyvSyLLSXknnkOYAQy1/44zfxj29IehQ
         8l3w==
X-Gm-Message-State: AO0yUKWGF5xibgmlctklRvkppVoP8TFi6jTzGa9LLGx8T3NuiAKHgUIB
        jKLMIMBl6bP1EVf0b7VPpDIuXw==
X-Google-Smtp-Source: AK7set94sTqbHq2k11xMJPQMd1/OwxqKj4ebw0WPvxg1kpr6t6SgH7ZqF+5WDOJLKhR/GtJn+EEE7g==
X-Received: by 2002:a1c:7318:0:b0:3ed:3cec:d2ec with SMTP id d24-20020a1c7318000000b003ed3cecd2ecmr9836530wmb.15.1679921605220;
        Mon, 27 Mar 2023 05:53:25 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:313d:a304:2790:a949])
        by smtp.gmail.com with ESMTPSA id q25-20020a1ce919000000b003ee58e8c971sm13572220wmc.14.2023.03.27.05.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:53:24 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 06/18] dt-bindings: mfd: qcom,spmi-pmic: add compatible for pmm8654au
Date:   Mon, 27 Mar 2023 14:53:04 +0200
Message-Id: <20230327125316.210812-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230327125316.210812-1-brgl@bgdev.pl>
References: <20230327125316.210812-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

PMM8654au is the SPMI PMIC variant used on sa8775p-ride. Add a compatible
for it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Lee Jones <lee@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 975c30aad23c..0f7dd7ac9630 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -79,6 +79,7 @@ properties:
           - qcom,pmk8350
           - qcom,pmk8550
           - qcom,pmm8155au
+          - qcom,pmm8654au
           - qcom,pmp8074
           - qcom,pmr735a
           - qcom,pmr735b
-- 
2.37.2

