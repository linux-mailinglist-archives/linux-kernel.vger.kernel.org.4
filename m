Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FFC6B078C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjCHM7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjCHM7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:59:14 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340D57F037
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:59:12 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ay14so61643172edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678280350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5NHdvLWmtsnAp6YHPeUC3RHs+hqWKSLLO/eeAOjwU8=;
        b=efEfdj66xdiyYhtPC8GWSbws6ZSbkFirWYQcnF0sBauAj0JRhbx52AZ5E4KTztdezB
         ExhBGpkY1ZvCyOOKWnUBleaA5s7eCyhwUqt6pVFsOrASKMjUfZGh/6Ejkd7cYk4SzcYj
         Ta6ZjVaRnMhebrWfjySJuM/cvgLxKpROPPdaOHvoBjFTGW/vIfV3s6rKgscjx3jV/lNa
         3R6HGJ19cuOkgrhC8HxIgKpLCerJ47QpUV94i+xx4w6cfHHj/BVFAwkxew8uYytBiiUQ
         UW5nuPS9xfoC5qAiRJ7VmCh2+Y1Q++WUK9JIKloK4GVdAZ0btzS7KqyDFq6JbuDJ9QQq
         kIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678280350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5NHdvLWmtsnAp6YHPeUC3RHs+hqWKSLLO/eeAOjwU8=;
        b=xfuBrBEYOxQSjvTWG1jLuJn0GbZx2VQj/fg/7HvxJ36bbVas6IkuiT2/kUf/k3TT4i
         DLArHNMFCpNa1zUUi+IlAjrSjn8JxTqcRHCIeVZLMbsHY/oeqUfH7b4kMbMBBOwPUNkx
         FZw7su6cMqPeAY/vnfHh5lpY9w6YtJAGg0Dit1Su8Y5dNiGPwtFf04kRgVCi5MVp9Bez
         vMluPXk8vb3UB5wYBRkxMysdHZZ2+YJs0bV4slqP7veuXm08Ll9kmjcSben19qxWuDhm
         VZMoyNcGnCVTJwlX8nR8SdbwdfZtlNn/HdtIsOFJxQeWVsnBME8axQ7aDEuEukP/HkoV
         rCtA==
X-Gm-Message-State: AO0yUKUA3bcZf56PwM4HATdcKSDK2rDEEOi0Bdo4Nzsa4A73n7H5Q60o
        n1B55lT5dtX7wclQho/2QyZWaQ==
X-Google-Smtp-Source: AK7set/tSRGVnYt3ZkO6n/8IuwCAvu5nii001ScNgPCEM9yOnRs3rIPjnD9RXXPfY/b3FE7TSLp6zw==
X-Received: by 2002:a17:906:4783:b0:8af:2107:6ce5 with SMTP id cw3-20020a170906478300b008af21076ce5mr24698476ejc.35.1678280350695;
        Wed, 08 Mar 2023 04:59:10 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063b5900b008d0dbf15b8bsm7464141ejf.212.2023.03.08.04.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 04:59:10 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 02/11] arm64: dts: qcom: sm8250: drop incorrect Coresight funnel properties
Date:   Wed,  8 Mar 2023 13:58:57 +0100
Message-Id: <20230308125906.236885-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308125906.236885-1-krzysztof.kozlowski@linaro.org>
References: <20230308125906.236885-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one output port, thus out-ports should not have
'address/size-cells' and unit addresses.  'reg-names' are also not
allowed by bindings.

  qrb5165-rb5.dtb: funnel@6042000: out-ports: '#address-cells', '#size-cells', 'port@0' do not match any of the regexes: 'pinctrl-[0-9]+'
  qrb5165-rb5.dtb: funnel@6b04000: Unevaluated properties are not allowed ('reg-names' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. Correct lang typo in commit msg.
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 2e672913e3d8..79d67b466856 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2796,11 +2796,7 @@ funnel@6042000 {
 			clock-names = "apb_pclk";
 
 			out-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
+				port {
 					funnel_in1_out_funnel_merg: endpoint {
 						remote-endpoint = <&funnel_merg_in_funnel_in1>;
 					};
@@ -2901,7 +2897,6 @@ funnel@6b04000 {
 			arm,primecell-periphid = <0x000bb908>;
 
 			reg = <0 0x06b04000 0 0x1000>;
-			reg-names = "funnel-base";
 
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
@@ -3216,9 +3211,6 @@ funnel@7810000 {
 			clock-names = "apb_pclk";
 
 			out-ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				port {
 					funnel_apss_merg_out_funnel_in1: endpoint {
 					remote-endpoint = <&funnel_in1_in_funnel_apss_merg>;
-- 
2.34.1

