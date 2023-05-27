Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127057133CD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 11:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjE0JkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 05:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjE0JkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 05:40:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B09F135;
        Sat, 27 May 2023 02:40:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-969f90d71d4so223263066b.3;
        Sat, 27 May 2023 02:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685180417; x=1687772417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfu8MrzbDydbuvkp4SRT/b0XpIQRCecIzUFORTCytPI=;
        b=WXqZ+B1kX654EDm7kTkh1ni1yQ78LZIHRbfNlEXnzchqCCYdXvkBBYRxvC16No56DH
         iYlcO7P+EvMrf+2ZuJvF6dbhgkVno7kOvK9IBil/YrseQNXRkY2XV4P2brAprSPg03xW
         Hnq9pg9dljoQCiT7i6bOVnBTQD9UjuG4hshvFWbyo01LZiZRME/wQg7zIRv3dJuPhPXY
         8nkIJvfV++i08RGVg/Lufvhlt5mEYWDbQP+9jsBnnq82jJnkopa6T569QQycXSXiLNdo
         FixD1nEL38jhZ4gan3SEsmpB3Q0faL1GSYpR2dxG+Sz44wMdjBNRA7F5VZ7AdllAby+Q
         b6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685180417; x=1687772417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfu8MrzbDydbuvkp4SRT/b0XpIQRCecIzUFORTCytPI=;
        b=No7kYGkQM66SQwyPWrmSZw5lLYoxVXlV4bxH7Yj4raKTikKFiybmV5/qYBVuZWgebf
         p/Wm19aEwkcq3vvIBbptLvl9y2AHYjndkzbHg8izEBgvJuBpMU2RJFWzwKuhidaUnCIO
         c1vyVeukJ9DMEJaP7Bo2oz/Y7f/avJH21FXb6tT1cOaiQ8iW1WR7WrKsuk2zOZIFYvZY
         xmvo7+M2h3O9wi+SVejpFvTqqcxLet/KnKqDmFFNHK3YIMPssFshGlK1ev4Fsp9Smnx8
         O4fMDoNzm2AT1a+YETVPkDMqbvlIeFWm2FQFN2bWAGy1+uuF6Vz0NQLXNPtNFmZNn3dC
         40pg==
X-Gm-Message-State: AC+VfDywt+8+XNk5JoaaEYftOp2QHV49LT674TUpu3Ex0NGVLSuHo5A9
        PEsvMlL6W0sJBcAt9187R4c=
X-Google-Smtp-Source: ACHHUZ7+DgiyxKDfvRe0x697wO82hu3TN6bROMLnapvrn5GVIW6dpNfty6Y/KXxNB2/65cE5D/ctCA==
X-Received: by 2002:a17:907:7b87:b0:92b:3c78:91fa with SMTP id ne7-20020a1709077b8700b0092b3c7891famr4355640ejc.28.1685180417527;
        Sat, 27 May 2023 02:40:17 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id kq12-20020a170906abcc00b009596e7e0dbasm3163623ejb.162.2023.05.27.02.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 02:40:17 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: qcom: msm8996pro: Add CBF scaling support
Date:   Sat, 27 May 2023 12:39:33 +0300
Message-Id: <20230527093934.101335-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230527093934.101335-1-y.oudjana@protonmail.com>
References: <20230527093934.101335-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add opp-peak-kBps to CPU OPPs to allow for CBF scaling, and change the
CBF compatible to reflect the difference between it and the one on
MSM8996.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996pro.dtsi | 51 ++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996pro.dtsi b/arch/arm64/boot/dts/qcom/msm8996pro.dtsi
index a679a9c0cf99..b74cff06f300 100644
--- a/arch/arm64/boot/dts/qcom/msm8996pro.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996pro.dtsi
@@ -24,101 +24,121 @@ opp-307200000 {
 			opp-hz = /bits/ 64 <307200000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <192000>;
 		};
 		opp-384000000 {
 			opp-hz = /bits/ 64 <384000000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <192000>;
 		};
 		opp-460800000 {
 			opp-hz = /bits/ 64 <460800000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <192000>;
 		};
 		opp-537600000 {
 			opp-hz = /bits/ 64 <537600000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <192000>;
 		};
 		opp-614400000 {
 			opp-hz = /bits/ 64 <614400000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <192000>;
 		};
 		opp-691200000 {
 			opp-hz = /bits/ 64 <691200000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
 		};
 		opp-768000000 {
 			opp-hz = /bits/ 64 <768000000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
 		};
 		opp-844800000 {
 			opp-hz = /bits/ 64 <844800000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <384000>;
 		};
 		opp-902400000 {
 			opp-hz = /bits/ 64 <902400000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <441600>;
 		};
 		opp-979200000 {
 			opp-hz = /bits/ 64 <979200000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <537600>;
 		};
 		opp-1056000000 {
 			opp-hz = /bits/ 64 <1056000000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <614400>;
 		};
 		opp-1132800000 {
 			opp-hz = /bits/ 64 <1132800000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <691200>;
 		};
 		opp-1209600000 {
 			opp-hz = /bits/ 64 <1209600000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <768000>;
 		};
 		opp-1286400000 {
 			opp-hz = /bits/ 64 <1286400000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <844800>;
 		};
 		opp-1363200000 {
 			opp-hz = /bits/ 64 <1363200000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <902400>;
 		};
 		opp-1440000000 {
 			opp-hz = /bits/ 64 <1440000000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <979200>;
 		};
 		opp-1516800000 {
 			opp-hz = /bits/ 64 <1516800000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1132800>;
 		};
 		opp-1593600000 {
 			opp-hz = /bits/ 64 <1593600000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1190400>;
 		};
 		opp-1996800000 {
 			opp-hz = /bits/ 64 <1996800000>;
 			opp-supported-hw = <0x20>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1516800>;
 		};
 		opp-2188800000 {
 			opp-hz = /bits/ 64 <2188800000>;
 			opp-supported-hw = <0x10>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1593600>;
 		};
 	};
 
@@ -131,136 +151,163 @@ opp-307200000 {
 			opp-hz = /bits/ 64 <307200000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <192000>;
 		};
 		opp-384000000 {
 			opp-hz = /bits/ 64 <384000000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <192000>;
 		};
 		opp-460800000 {
 			opp-hz = /bits/ 64 <460800000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <192000>;
 		};
 		opp-537600000 {
 			opp-hz = /bits/ 64 <537600000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <192000>;
 		};
 		opp-614400000 {
 			opp-hz = /bits/ 64 <614400000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <192000>;
 		};
 		opp-691200000 {
 			opp-hz = /bits/ 64 <691200000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
 		};
 		opp-748800000 {
 			opp-hz = /bits/ 64 <748800000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
 		};
 		opp-825600000 {
 			opp-hz = /bits/ 64 <825600000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <384000>;
 		};
 		opp-902400000 {
 			opp-hz = /bits/ 64 <902400000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <441600>;
 		};
 		opp-979200000 {
 			opp-hz = /bits/ 64 <979200000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <441600>;
 		};
 		opp-1056000000 {
 			opp-hz = /bits/ 64 <1056000000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <537600>;
 		};
 		opp-1132800000 {
 			opp-hz = /bits/ 64 <1132800000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <614400>;
 		};
 		opp-1209600000 {
 			opp-hz = /bits/ 64 <1209600000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <691200>;
 		};
 		opp-1286400000 {
 			opp-hz = /bits/ 64 <1286400000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <768000>;
 		};
 		opp-1363200000 {
 			opp-hz = /bits/ 64 <1363200000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <844800>;
 		};
 		opp-1440000000 {
 			opp-hz = /bits/ 64 <1440000000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <902400>;
 		};
 		opp-1516800000 {
 			opp-hz = /bits/ 64 <1516800000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <979200>;
 		};
 		opp-1593600000 {
 			opp-hz = /bits/ 64 <1593600000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1056000>;
 		};
 		opp-1670400000 {
 			opp-hz = /bits/ 64 <1670400000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1132800>;
 		};
 		opp-1747200000 {
 			opp-hz = /bits/ 64 <1747200000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1190400>;
 		};
 		opp-1824000000 {
 			opp-hz = /bits/ 64 <1824000000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1286400>;
 		};
 		opp-1900800000 {
 			opp-hz = /bits/ 64 <1900800000>;
 			opp-supported-hw = <0x70>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1363200>;
 		};
 		opp-1977600000 {
 			opp-hz = /bits/ 64 <1977600000>;
 			opp-supported-hw = <0x30>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1440000>;
 		};
 		opp-2054400000 {
 			opp-hz = /bits/ 64 <2054400000>;
 			opp-supported-hw = <0x30>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1516800>;
 		};
 		opp-2150400000 {
 			opp-hz = /bits/ 64 <2150400000>;
 			opp-supported-hw = <0x30>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1593600>;
 		};
 		opp-2246400000 {
 			opp-hz = /bits/ 64 <2246400000>;
 			opp-supported-hw = <0x10>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1593600>;
 		};
 		opp-2342400000 {
 			opp-hz = /bits/ 64 <2342400000>;
 			opp-supported-hw = <0x10>;
 			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1593600>;
 		};
 	};
 };
@@ -289,3 +336,7 @@ opp-560000000 {
 	};
 	/* The rest is inherited from msm8996 */
 };
+
+&cbf {
+	compatible = "qcom,msm8996pro-cbf";
+};
-- 
2.40.1

