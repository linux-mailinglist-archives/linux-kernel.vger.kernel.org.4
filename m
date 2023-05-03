Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FF76F5883
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjECNCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjECNCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:02:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559C01A5;
        Wed,  3 May 2023 06:02:03 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bd875398dso2394850a12.1;
        Wed, 03 May 2023 06:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683118922; x=1685710922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1V3rgI/5A2MTfAJo/8hueKDPxSOGXJm1mCHXT4uBpmY=;
        b=PNvCtK6WJsAPCggpeyY2cAVR6Tw4iRNJDt+Wq2Xeu3nq2io/Y1JUbNeXlZEE4wesab
         z3J1oYx42qC39l1cBaiWN64oPhEHpu70NsFwri2nc3O4bNZ47kmSBXUaybcue1LjVPBk
         0qFMy06cY5sCuOqEnwQQIZJ7bLOmBuIqdah8SlcA2whIoBZNXlz9hSBwx+HQxlzwX0Wi
         fQQqZy/A6Ap8w1uzDPQ0UhYtyLE1ImWQtkZj8ICrDaUQllA39ApBfRJoIcjrgWyAF/Nv
         KfjBChTB3vsdT7/3MoF53TUFcpFcZtXZVZr5PmDGnb3Vj6X4ZBg6CStbHrxoJhIqJP/M
         b+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683118922; x=1685710922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1V3rgI/5A2MTfAJo/8hueKDPxSOGXJm1mCHXT4uBpmY=;
        b=IlQ+gawut03x9BjMbDSj8n2OsjnZMEC/D7IpZfBLLI5HxTVwTRGMbHYDjzUrDD0rTN
         /RyBYZa1hPlnMQCcwMIPV84PYNwLxxrKIGPUlcENtbD0xxJ3UNAOfzAh7cu7NxpKcUXx
         Ao77my8wSJLCih8cW1iqtRsPeeM3H1Y5xBMf/PuaOYh3A7gpKAcu43ZcZw1N/R759ffu
         WPNgbuyK3+LjWyNVpQduU8v7tYpcaoP9giAitSr81U/OM90EtZSkpnxADomJRHcPMOdf
         tAH2r1kBkovx4LZ3pqe1mRMtAKRO0dozCLRzpKBAqWfy8f84h9bMB/Z+Z0XNaPZ6XK0+
         v9lA==
X-Gm-Message-State: AC+VfDxw5bLQipJbGcK2HBh+jtFOlysm6Y5QCTT5xmIqnQNYnLlPQtVS
        XhPwtEwv3t6BgPUGqdSOXpk=
X-Google-Smtp-Source: ACHHUZ53NeMl5qShVSaUR8CZtdJjEBycHu9DNGpIdzfyfh2sdXRAla7ZglQhrS7q9beetAPw0gXyQA==
X-Received: by 2002:a17:906:794c:b0:94f:1c90:cb71 with SMTP id l12-20020a170906794c00b0094f1c90cb71mr4116095ejo.65.1683118921466;
        Wed, 03 May 2023 06:02:01 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id my17-20020a1709065a5100b0095728081944sm16105578ejc.146.2023.05.03.06.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 06:02:01 -0700 (PDT)
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
Subject: [PATCH RESEND 2/3] arm64: dts: qcom: msm8996pro: Add CBF scaling support
Date:   Wed,  3 May 2023 16:00:51 +0300
Message-Id: <20230503130051.144708-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503130051.144708-1-y.oudjana@protonmail.com>
References: <20230503130051.144708-1-y.oudjana@protonmail.com>
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
CBF compatible to reflect the difference between it and the one on MSM8996.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
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
2.40.0

