Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22AD6E8A84
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 08:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbjDTGgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 02:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjDTGgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:36:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3519D49C6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 23:36:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5066ce4f725so541434a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 23:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681972578; x=1684564578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSQAIWvdCVohIV0GOWaX7A128s/QvmbJgXiSsuBadpo=;
        b=WnAiY1KZMCu4JsltZJNV4wNjM6YiuAGD7WHTF9kQRC3wkPHZfma3X70Cthy422jfpB
         xz+JknS+kkOMwXzaKojQ8GE3v3MUixQNNlO8e3SnsvP/YvHzO3gpwILvY/7k+tFSxi1N
         LC/+g5/a4sNLNslsrhiyT53I05GbfwQc6B+9a7QpEtWxOd3PhZq98h3I5BT3s4bIrVOG
         mbz+8IL+3wqZ+Fj7wd3Dv4qWzYxCdnYvId7kQDoaLtrsraDZ7jdOVsGrghe+ElZe4RxY
         4n66UgRG8Ms5VfBNqHfv2x9RZqFTyKfOHLqEZXTQktno4SN4gTYsrMb+ZpAmnQ8X+pgW
         prUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681972578; x=1684564578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSQAIWvdCVohIV0GOWaX7A128s/QvmbJgXiSsuBadpo=;
        b=UVZFwepx2T0xk47QqNpHHycoD2xD/UUSnWCysP7Ppd/LzFBtOAdAtiwPoh7ST5rcJ0
         4qGfX+By+qc45Kh9DMzGzAeUIFKexgxQV/mX4nLGAc5TtEw4fDMgd5DDRRmED98Fdtv/
         rDkMi5YcEuIKEX+CmE5pe6KqmK9Sga+sFhxSvtDQ33KeGqtutOhfGuR5P6QUn+pDruaR
         ZzgeJu/Bu/NrHUZ6sKdBAyr/fps4lN9aLp4kr+TkEzOMBn5d6xjFMXajTt7frJExnBQc
         Iq0v7BoOSaJCz3i8Znk+pjYNus9UHCi7kzrW13CtI0GBBpjb6Tn9ba7e+Rg2xu5ppsG9
         85FQ==
X-Gm-Message-State: AAQBX9fCw5nb2hANzNGExU8Ax02o9rrTWHAj9Zk7adGskH+qBR32e69I
        cnkuj525xU1eLILFCMWogUdZUg==
X-Google-Smtp-Source: AKy350bsrbXqm4eL0swCm/f9TxBhexgF/zazKiU/v5Ld3FBjXvvcsjGzGogLC9qfLSvRgVxNxLpDUw==
X-Received: by 2002:aa7:c6d6:0:b0:504:894b:1bc9 with SMTP id b22-20020aa7c6d6000000b00504894b1bc9mr674926eds.26.1681972578732;
        Wed, 19 Apr 2023 23:36:18 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id f7-20020a05640214c700b004fa380a14e7sm395342edx.77.2023.04.19.23.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 23:36:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/7] arm64: dts: qcom: msm8998: add unit address to soc node
Date:   Thu, 20 Apr 2023 08:36:08 +0200
Message-Id: <20230420063610.11068-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420063610.11068-1-krzysztof.kozlowski@linaro.org>
References: <20230420063610.11068-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"soc" node is supposed to have unit address:

  Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index b150437a8355..803a1f1f2597 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -800,7 +800,7 @@ timer {
 			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	soc: soc {
+	soc: soc@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
-- 
2.34.1

