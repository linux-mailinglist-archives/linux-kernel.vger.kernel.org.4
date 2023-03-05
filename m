Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFD26AAFD0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCENAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjCENAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:00:14 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFE2136F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 05:00:07 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o12so27920011edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 05:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678021205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vY7fzQFeFA/CmOp2FT5Q/hTHbyPytHCEcFPp8zGHCRw=;
        b=YoQEUxcUYeB5Njy/HweEPd4m3mysWARhBOFDs7xzJmj7ACrECj2Q8KFQ1VVtjkZxDz
         +x1IGTG1kFO9gus22w52mpPPbUVhwlveWHoSyfvUL6VKV0UjUlU1WGAZddlY42itwqck
         jVURALGl/b8kXaGf0cc3K9CnRT+mX6Za9wUE55zCMHUogJ2KEwEhw83FlUh+77gfnc9L
         GnHQIuJmG1zF+OXOQwRIZ8rrIWRGtbTLzN4DCPlLnmq7p4N2u+iwKBzpK2ijZzcspuuu
         1oy5BlF207xNMVhk+aJ5kkOYaIpm9wbuvcm5NgWQqq/cR9sWnoE2lpHJ6htuqn2h4sKa
         UIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678021205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vY7fzQFeFA/CmOp2FT5Q/hTHbyPytHCEcFPp8zGHCRw=;
        b=VEccQGovpL3U/DhPI63lRiNcWRmgY215VIVTQYJqEw5eRWeCvJuG9Bv2Ur2d1wS9uc
         E4Dxza36s4SYZTLco6SP5+OhMvTj3LXxzjeTwXI+ctpj22gLkctX6WNHcCxaJtNEq4tW
         c7FnulfDs+2q/SDJeoF3CE3dHoy0pvTQInPISxMInYa0qrVsU9WtaeNnsjD53HUUAS0z
         dGO7WFZk6aEifoh8NWv0LSWvND+qb531V18wmuqDPaIi4JDPhhLxZYnKM19ntZYV+zIy
         zShGg/U81TqK3JessXKGNi3zA/Kfph9z4LS82Fx9r9jziucSNpWp/j9+UP4sQwiRKPvI
         ssBQ==
X-Gm-Message-State: AO0yUKUwRP3H4SWE2T1PC3OJi/o57okq5P0YxcROOY5iVRlRFxWR2KLL
        DSU1Ia0bGGsBH1jE2Tmmr2K2ng==
X-Google-Smtp-Source: AK7set+uyU0W114/8bnzHFpu+s26onjylyPyJix1xSod8f2e21FkvyejrcmujxM54Mjo2k2nhZzffA==
X-Received: by 2002:a17:906:30d3:b0:8b1:3d04:c2da with SMTP id b19-20020a17090630d300b008b13d04c2damr7997580ejb.45.1678021205748;
        Sun, 05 Mar 2023 05:00:05 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:71e7:13d:1c29:505f])
        by smtp.gmail.com with ESMTPSA id l15-20020a170906078f00b008ea8effe947sm3193158ejc.225.2023.03.05.05.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 05:00:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/11] arm64: dts: qcom: sc7280: fix EUD port properties
Date:   Sun,  5 Mar 2023 13:59:53 +0100
Message-Id: <20230305125954.209559-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230305125954.209559-1-krzysztof.kozlowski@linaro.org>
References: <20230305125954.209559-1-krzysztof.kozlowski@linaro.org>
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

Nods with unit addresses must have also 'reg' property:

  sc7280-herobrine-crd.dtb: eud@88e0000: ports:port@0: 'reg' is a required property

Fixes: 0b059979090d ("arm64: dts: qcom: sc7280: Add EUD dt node and dwc3 connector")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index bdcb74925313..71179182c3b8 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3593,12 +3593,17 @@ eud: eud@88e0000 {
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
@@ -3609,7 +3614,11 @@ eud_con: endpoint {
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

