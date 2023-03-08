Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E576B07A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjCHNAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjCHM70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:59:26 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0AE9661A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:59:18 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id da10so65430643edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678280358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5Z8VM/PgDy8sR8t02jIqFbA0GbVVP/qE1Wd11uRrTc=;
        b=Hv2LVQMy9VVPx32VqmXAMO411OvKi6T4n896GFjnn8b+2EppFOC54pd5dswu7d7LtO
         BFwnI/i+vUXw86D9czmpAdMXwm1ICx6XlIeWldrVP8EGjk70VqJdutZfPTPWqUlNTTY9
         SeoTPlX+FrJoTU03WkxG3GJaSul1H1VyOgNoCqb6z56RmbZVZ0AnsVlnD1lSdtopsuh1
         Qby0jN26QGNcWQS6aAM0GAk8muPe1YXVXo8LZMWqJFbIQe4iaDnQnENJCxFrC5kdC5eX
         UJJKvlJv1i1zgg9RPBc+78wzekalVMkvOr24Nq8KG+1z880qIYyyXCKO4QEk+ZSWSmw/
         vVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678280358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5Z8VM/PgDy8sR8t02jIqFbA0GbVVP/qE1Wd11uRrTc=;
        b=RZ050MlivT4dKpkhMrX8erNoENA5UvYUQYFyGOSnmPaoE8eEe9+Jj+U3OdCQ9gw074
         hTwHezVOnRHmF468ESHGfFYF9WOw2gkwcfisLf/kHn8kRE5MZV0hSHg/rK3TEI4z+0pm
         i1OYWsWiovbDqzRWj0mhNgWyH9CbXGjhIfNP3pcDr5uCJK9KN2MIOli1obFymPCyrLE7
         yNy3BaKsuk+C8nK0suKAeXqWb2q8pNph0bEv5HwYCt47s3MTDTY7UC8CFoKNr3Wvd39R
         UoxWeoRI01f6A1x0Rf2ykbkkSxLOgoeDUNYKWlRGxjvrGCammTbYH6ZbCSvO+7DHA+R6
         jyXw==
X-Gm-Message-State: AO0yUKXArNoiZm3uoxYfIrr0yt3dnNYK7YIQ9n56vw1yB1LqRU1T7cRV
        iG1kaUYyuDoxE+Mw2tGtyxFFRQ==
X-Google-Smtp-Source: AK7set+RAkRwwXb3QKSgPWhvTr6FPEAffW1JZ5FPIE6o+Vsyww7Y9eVaEo6vCKpEsCJeQfEXF9uXUg==
X-Received: by 2002:a17:907:7e82:b0:8f4:6efd:833f with SMTP id qb2-20020a1709077e8200b008f46efd833fmr22688776ejc.3.1678280358157;
        Wed, 08 Mar 2023 04:59:18 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063b5900b008d0dbf15b8bsm7464141ejf.212.2023.03.08.04.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 04:59:17 -0800 (PST)
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
Subject: [PATCH v2 10/11] arm64: dts: qcom: sc7280: fix EUD port properties
Date:   Wed,  8 Mar 2023 13:59:05 +0100
Message-Id: <20230308125906.236885-10-krzysztof.kozlowski@linaro.org>
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

Nodes with unit addresses must have also 'reg' property:

  sc7280-herobrine-crd.dtb: eud@88e0000: ports:port@0: 'reg' is a required property

Fixes: 0b059979090d ("arm64: dts: qcom: sc7280: Add EUD dt node and dwc3 connector")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>

---

Changes since v1:
1. Correct lang typo in commit msg.
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index cb33cb2a81bb..90ed277dc821 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3591,12 +3591,17 @@ eud: eud@88e0000 {
 			      <0 0x088e2000 0 0x1000>;
 			interrupts-extended = <&pdc 11 IRQ_TYPE_LEVEL_HIGH>;
 			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
 				port@0 {
+					reg = <0>;
 					eud_ep: endpoint {
 						remote-endpoint = <&usb2_role_switch>;
 					};
 				};
 				port@1 {
+					reg = <1>;
 					eud_con: endpoint {
 						remote-endpoint = <&con_eud>;
 					};
@@ -3607,7 +3612,11 @@ eud_con: endpoint {
 		eud_typec: connector {
 			compatible = "usb-c-connector";
 			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
 				port@0 {
+					reg = <0>;
 					con_eud: endpoint {
 						remote-endpoint = <&eud_con>;
 					};
-- 
2.34.1

