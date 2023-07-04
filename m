Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD09747145
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjGDMZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjGDMYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:24:34 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED3E10D9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:23:24 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6f9edac8dso6852071fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 05:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688473403; x=1691065403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfZetCTb7qe7Kln5fO24A0lyGB1o99Go22cdh/m51mI=;
        b=EWHnEA4c8uuC1fr46CXolQALOCRN68WA20PAqWLsKKtk9oe3/gW2wGv9E6otaU5dBD
         oOhpeQTAQ0/DuJUvyVhr+oO17vaRcmjVsmlC943z57EegfqS3jkGJypE9+YV+x+DGeQd
         tqM9u+vOpS1Lel5xY7YjDHHqlFjX8jC0CShO5bQjkC7uv6rDiVNVbEgLhDkmqbWgfBLp
         NZ9L7nRo7L+bB85kF/EBjWOmHG7MZhFSiBQrwBFGEF8rwo7kOCSXq2fw61CJbvF0DiSb
         UxBJalUbMhf26o9CcpJBRSO8h3dLS5HvnJMaxNXMUFl1sBrtCh01vs6/1AOyiq8f//Ei
         e0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688473403; x=1691065403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfZetCTb7qe7Kln5fO24A0lyGB1o99Go22cdh/m51mI=;
        b=JryztwWXXSuQu7nNL0fQVb4j9ymtwCxtgMqls/7Be+2B3dV00uxO9eriQ17l4kzitU
         0QewMwmLUCyDMuecZnsWpumkUEAgoZnuFr/JGUHlgQKedHqHh01WaBjj/gZrHg6s25gZ
         j82xCISezwWIfPPx1SDDCuJ4qx7fMpG9Jk6RzJrMZHMfkszWZFCkcDYsBT9Sq2v9FjYD
         x/jqQlPxYQRnNaaiS2pgYwdbq7csOjFiL1DrJMnMEj2G3ClTynUlD7w1/0l9YX78IPwh
         d5SR1Q3/KFD9Uhh1r1KFSbjOYlU0pQFzyUhoF1FXvIVuGlP0bQZ+UZYyuLGlLINkECjD
         vrLA==
X-Gm-Message-State: ABy/qLb7N7mwMOHl7qaqS5abVs2Bi74zf/IbgsqFF0SqLQZWydZNDIoY
        1ZSXI7m3zL7CpERmTM9t0/6TdA==
X-Google-Smtp-Source: APBJJlHQFoYtY1ofS4Y3l6PYo9Tv8feS5VF5rVSPfgGH1Wtqm6pEb8or7GWii4bcd9pG8QgxNYmk1g==
X-Received: by 2002:a2e:3611:0:b0:2b6:fa8d:ff91 with SMTP id d17-20020a2e3611000000b002b6fa8dff91mr762817lja.3.1688473403097;
        Tue, 04 Jul 2023 05:23:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id y16-20020a2e9790000000b002b6d465583csm2851817lji.126.2023.07.04.05.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 05:23:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 04 Jul 2023 14:23:17 +0200
Subject: [PATCH 1/2] arm64: dts: qcom: sm8250: Mark PCIe hosts as DMA
 coherent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230704-topic-8250_pcie_dmac-v1-1-799603a980b0@linaro.org>
References: <20230704-topic-8250_pcie_dmac-v1-0-799603a980b0@linaro.org>
In-Reply-To: <20230704-topic-8250_pcie_dmac-v1-0-799603a980b0@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688473400; l=1039;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/trrPqlOGVYGD4KobXwWL7iAusm8QIT3+NP76Mg5xnE=;
 b=bC54OwHZByqZwcz9qOumBMtmQW7JnNGGGIhkwtwVRQumSxGz3BtQgwkgw8FarJdJTPzBlyT+v
 1fN+x3Qh2l6DNhIhdRMg61U3+ODuEdrrhaqcZ2WZzJ14uixsHAecPTE
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe hosts on SM8250 are cache-coherent. Mark them as such.

Fixes: e53bdfc00977 ("arm64: dts: qcom: sm8250: Add PCIe support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 1efa07f2caff..1af0eed9eef5 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1905,6 +1905,7 @@ pcie0: pci@1c00000 {
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie0_default_state>;
+			dma-coherent;
 
 			status = "disabled";
 		};
@@ -2011,6 +2012,7 @@ pcie1: pci@1c08000 {
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie1_default_state>;
+			dma-coherent;
 
 			status = "disabled";
 		};
@@ -2119,6 +2121,7 @@ pcie2: pci@1c10000 {
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie2_default_state>;
+			dma-coherent;
 
 			status = "disabled";
 		};

-- 
2.41.0

