Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DA566847D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbjALUyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbjALUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:52:55 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0F2EB0;
        Thu, 12 Jan 2023 12:26:41 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id g14so20524793ljh.10;
        Thu, 12 Jan 2023 12:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hse8SdC9wuKWXSULFTdDSwReuUUWy3z5aWnQyprXv2E=;
        b=JYUMzT2iPyVhsc8BWOKwH4+dBDiUodT6g+A/W+T9RK/rghfpMX/AQHP1eHWCGc2Xsn
         gym5/vPyoP8lAGiU2IpVHhie8eKhEyNo9RoP5Q7rrHyLiy7Ltb0nwj+E1aPClD8uxHrA
         SgKTEzOOgMyqjNFQZxa1bfALhyNVy1Jt6EsY/iUM+m7YfNwWSlDnbMbLCKhjVJuuG+uo
         oFI7nCRPeySlZMnrtMNhFZqx9VkcOmTlWODuJ8f8ZPZ1EslmwMCEWnWQ/W+2xgRZkjDM
         +nRuiF5Z4wT+Kz4AQKjciW/M/ft3IlEvgRJTx/y+24POL7vX7ERWVBMJ5om3vS1A2TFU
         QC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hse8SdC9wuKWXSULFTdDSwReuUUWy3z5aWnQyprXv2E=;
        b=4sU0Rm0d29kJrheVgQedbVvS2djBCcY1GlLm3QhB/GxO0o0cZ/UBaVQhwPIrA3Eu+x
         7/xsFsNYEcY7wlW954tvlvS3or88k+9FWM8GyqSexEosG1sUhAduTtBqOLP3FkFEUhKe
         gBsvOvGNe56gA7sncukcoAmZ1MrOj3bjS7HJ02jub5EaY8UUUNit0QuhvFdUDELIHnYT
         FULKpfSZNhhNjwvChoozzrXFGtE9chnRlfURePm4Pwa7gX3/GdeNb+QoH3NWj7cD/oyP
         Gaif00Qtu04nRbMjR3bH70GvaPLIbh8LVsKjJJZ1r09t/mOaDIOE3RcaTGdlapDZ+UHq
         8A0Q==
X-Gm-Message-State: AFqh2kqtaM7Pzx3Hzom+29Ta7dAzKOaldzsx9/8e8gClqvjp5tqkW1Ud
        i1ftYAzJzqAgGG9Vqh1XtYo4m/zmOtZAmA==
X-Google-Smtp-Source: AMrXdXuqjQLonk10w8PTyyaCobjwK8WUb186aRl+tT6NwwIWuPjyPp8G5diu1hkxLmPEesyFNR60NA==
X-Received: by 2002:a2e:9206:0:b0:27f:e50b:9e35 with SMTP id k6-20020a2e9206000000b0027fe50b9e35mr11875030ljg.52.1673555199515;
        Thu, 12 Jan 2023 12:26:39 -0800 (PST)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id k6-20020a2eb746000000b00281350bb5fbsm2346731ljo.2.2023.01.12.12.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 12:26:38 -0800 (PST)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8226
Date:   Thu, 12 Jan 2023 22:26:07 +0200
Message-Id: <20230112202612.791455-5-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
References: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Document the qcom,msm8226-tcsr compatible.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index adcae6c007d9..d463fb47278f 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -31,6 +31,7 @@ properties:
           - qcom,tcsr-ipq6018
           - qcom,tcsr-ipq8064
           - qcom,tcsr-mdm9615
+          - qcom,tcsr-msm8226
           - qcom,tcsr-msm8660
           - qcom,tcsr-msm8916
           - qcom,tcsr-msm8953
-- 
2.34.1

