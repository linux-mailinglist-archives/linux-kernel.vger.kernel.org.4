Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B90E688429
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjBBQUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjBBQTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:19:48 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841DA56EF2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:19:46 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso4105332wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6qXO567C4FZuG9ulSewZ/lPjHuEg4qhl6//+GYZr+g=;
        b=cmH3CmUhswBvenZwfhc/qFZShC7TgNT1VdUSNenYCEYe8be4ygVqnMJsYnEc36vBYQ
         EUcdBTNyOLTzwEQqMHImmdHlWPtER1Qk4DmVWMZ2cWzDLjVqte3h4iEp1UvPGMlIzQZA
         XTf+MvcD5lLBZoLKJAFtbsWXmOH2ZLRFS3nWs1ukrJiednctUZB1TQhhgjy6r8bqf+Wv
         GSdn10e7lUu39h0mqGgSdg1eA7gIjAZu/+vkCY28NA63kiIg/s/818uovut09Gin7/ru
         S9ctd/CT5GdSbX4pLetoB4fgllaDw0iYBmXZRxGC2HWXQVfATLEgyh+e9L11vh4ajdIG
         dS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6qXO567C4FZuG9ulSewZ/lPjHuEg4qhl6//+GYZr+g=;
        b=juOM0NS0tCP8hxXzJCj+SM78mAdlLvRQ5FLyrPHPgP7FN6DUUJEbcD+X2I7eRZYAAy
         YOYC5xanFSds1yWIz6C6CUdrXcHOyU+dreUWU54dy21h3X9EbdtlTDUkoy/4t920KmzX
         ogeAkS+3YiCr4iEL8Xd3s/OtWtEfrVoC3+s5aQwEld90u/FZrayC6oujMfvNLf1J/+fk
         YTEPAYoqmA3z4VBkPOp8RIcP+fE1RNBWJ+/bAqfjr2xu9EkFLgdavHjvaptILkJAGeHJ
         n8gzyNbAo26/BXmd+SVScNkBm+IamHFcvh0sp/g0AQBKWXgfMrjbhemxkosxkfD/EIER
         HYMA==
X-Gm-Message-State: AO0yUKWsDLikso27N1NYNnYevR0US8mlPw+u+SRA1IeBJ6G/XL5E+Y2L
        UqtbdKLgXRj7sndLI4/yJ7OblQ==
X-Google-Smtp-Source: AK7set9bklhbitjy14zLOWUYMQqEfIQBO24LYFVRsmGE8imCl0CAegTsM5/CHB/MF6KpfS4CAK6NKA==
X-Received: by 2002:a05:600c:1d11:b0:3de:3381:24f2 with SMTP id l17-20020a05600c1d1100b003de338124f2mr6657825wms.30.1675354786157;
        Thu, 02 Feb 2023 08:19:46 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b003dc521f336esm212416wmq.14.2023.02.02.08.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:19:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 08/13] arm64: dts: qcom: sdm630: add compatible fallback to mailbox
Date:   Thu,  2 Feb 2023 17:18:51 +0100
Message-Id: <20230202161856.385825-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202161856.385825-1-krzysztof.kozlowski@linaro.org>
References: <20230202161856.385825-1-krzysztof.kozlowski@linaro.org>
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

SDM630 mailbox is compatible with MSM8953.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 5827cda270a0..95469a45a1f2 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -2268,7 +2268,8 @@ gnoc: interconnect@17900000 {
 		};
 
 		apcs_glb: mailbox@17911000 {
-			compatible = "qcom,sdm660-apcs-hmss-global";
+			compatible = "qcom,sdm660-apcs-hmss-global",
+				     "qcom,msm8953-apcs-kpss-global";
 			reg = <0x17911000 0x1000>;
 
 			#mbox-cells = <1>;
-- 
2.34.1

