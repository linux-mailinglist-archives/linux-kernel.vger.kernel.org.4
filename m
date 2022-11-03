Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D82618A7B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKCVWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiKCVVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:21:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DB921818;
        Thu,  3 Nov 2022 14:21:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o30so1941775wms.2;
        Thu, 03 Nov 2022 14:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBi1xTEb0SF667Jza54gm5V6cR58OHc1YhW84qRd8ZY=;
        b=pEpBEi9mvFUmu+V8wv+E4uWSllh8HKI11O/WhiLwohawSDkKp3f4WiHG8k6eFuQupN
         1Fo8hWGbqymC4ZYnuLbxp1OwsD92umaBOaVFejXTmpHluITjQjDFKqsW/ODtfSY+jbUi
         fSYENdAOuVrOVUr5wX+IvPtt+B3ny1puRwGTi3dTukpwSm71z9rJZWiOMKpV9RZCMBZK
         tXi7iDW1ggE+JLPczofCGcUJ5IIB7EcmU+Yo7njOlXjg6kPRHxjurd7NIYTpsQDvSJNi
         aZn1cpJKIKi2sOoDYny5eCU6lu49qXlEOLMEw9dczZB17MHKx+M2NAZFyP0ejK4tGqiy
         J6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBi1xTEb0SF667Jza54gm5V6cR58OHc1YhW84qRd8ZY=;
        b=4b/tgToTjvL1mv3k8S83NI+jtDWDPFHm6myMTYSvqxi9cG2U6ow4wkaEhA2K5pFOOW
         W9da95S2nt1hbMCi14RcK4b/YZ/v/6ZLtgv4Zr0MxgSkuQ4xKm1PEdKRhCbazioa77Ap
         1nHynZQ8fWKeAEz9yLQ330Go8mpAybNQuJ+6eX2SX738556/k+SMcvOd5TevJ5ZOLQOM
         e3bwP5r4ZJLGafsnwNc8sVxnNkDGrV2cWUpcbnU6N76dKDBhunlaHoxRyQwmXabaIhMF
         nrcGKnVeaeYDi+z0e16LYrG3aQONV3RbgSZdUaiNLUm5b+FsibtSwA+eFLShKpAj9THX
         7IvA==
X-Gm-Message-State: ACrzQf2gOMYy4wX/7JDJWK2FKwxFz+HSKWDvN8k3MlHMwmfqWhMIJnLv
        wFjxHjlwtyqhLUbv4/4bYI3CIKr/MXM=
X-Google-Smtp-Source: AMsMyM5z2kO3XboxYINuKbpi6PqUYVuHI6ShBZBQbgTxcJLiIelbbB1yygyhNZLsHD0YytDk2cIUww==
X-Received: by 2002:a05:600c:4486:b0:3cf:6e1d:f4a5 with SMTP id e6-20020a05600c448600b003cf6e1df4a5mr18119129wmo.85.1667510502516;
        Thu, 03 Nov 2022 14:21:42 -0700 (PDT)
Received: from localhost.localdomain (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.googlemail.com with ESMTPSA id m29-20020a05600c3b1d00b003b47b913901sm6968320wms.1.2022.11.03.14.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 14:21:42 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq6018: improve pcie phy pcs reg table
Date:   Thu,  3 Nov 2022 22:21:25 +0100
Message-Id: <20221103212125.17156-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221103212125.17156-1-ansuelsmth@gmail.com>
References: <20221103212125.17156-1-ansuelsmth@gmail.com>
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

This is not a fix on its own but more a cleanup. Phy qmp pcie driver
currently have a workaround to handle pcs_misc not declared and add
0x400 offset to the pcs reg if pcs_misc is not declared.

Correctly declare pcs_misc reg and reduce PCS size to the common value
of 0x1f0 as done for every other qmp based pcie phy device.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 9ebb9e2371b1..95d7f49bc61a 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -406,7 +406,8 @@ pcie_phy: phy@84000 {
 			pcie_phy0: phy@84200 {
 				reg = <0x0 0x84200 0x0 0x16c>, /* Serdes Tx */
 				      <0x0 0x84400 0x0 0x200>, /* Serdes Rx */
-				      <0x0 0x84800 0x0 0x4f4>; /* PCS: Lane0, COM, PCIE */
+				      <0x0 0x84800 0x0 0x1f0>; /* PCS: Lane0, COM, PCIE */
+				      <0x0 0x84c00 0x0 0xf4>; /* pcs_misc */
 				#phy-cells = <0>;
 
 				clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
-- 
2.37.2

