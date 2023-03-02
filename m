Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2686A8234
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCBMbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCBMbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:31:08 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FACB445;
        Thu,  2 Mar 2023 04:31:07 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id t14so17419048ljd.5;
        Thu, 02 Mar 2023 04:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k0hcF70BkwgsPk9m1FQebcF+huDsTc/3OaRG/0ig1uA=;
        b=N8+byvn3YuT37/ShTzoaovbGonhvfj2O+HO/KhwXEJeyUHre0FUZD8BVCN+NS3wm15
         6VIA6pYBfhew4Que1cd760a/cIlFatKxHIxhoXlSZ7rpyjFLO6LM7+i8FMB+snld7SDP
         l6H+lpbj6HEWYzxaTWcvg5BmxDmRkub+z56zLyKXfmh5AXQvjo2psLOi3Q2b7J7ENPk9
         E+VRUKSp2zTiJUa9BqyI7qmUsoyCMpaLl3uxCR7Pf5+w6USeKiDIKIC2CMA9+REvze4y
         zEH1Z0Z+au0whRePMh5Pbk97EVu3vJvFc7Gvfku/kyqdR1lyyTcJsG95QAkh12Eok7mb
         VkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0hcF70BkwgsPk9m1FQebcF+huDsTc/3OaRG/0ig1uA=;
        b=K86jQxsF6K4cm8x5dqZLkZk4hYa7icAR7XElvQunzN4JlKBQ3p9hB7Rv3HeKtTohmG
         SOacSd2gGnb3n/uADWATzry/vruK68nub8iYtz1eBz9buz8tZfImgp6SU9+mCek/DPzN
         wF7QSynIJap34DTeqs+HyFg6NOxHheuuQ1DzBSau75vEaikCb0XjFa6OoZBO7K/1Uw05
         TkqNejwLTR+hR6nqca8u/oZOqc7PGjx5V79YhA/8PLCGzX5OayGDnfk1fS+jeMU3UOYJ
         LnzwRFbS/nG/FKrJD8ZEdidPhprsSz/uFSEtNQC59sTRbfp0uOQ3+dIGHB0d2qc4INI5
         VDMg==
X-Gm-Message-State: AO0yUKUjBhdQ0dGpabU+peFjUoIjMli1lkB26T+ag4AEAXB3V6FxWiR6
        r+895lDNNbldnOyN/21jVRSZzjpxxaTrOA==
X-Google-Smtp-Source: AK7set+jrPI7ZYVwl4l33sRXM5qhFb0/FE3kotzGx7b6AZJoYzXCYg9ezLPD5oc0NBPtygFFMIm0cA==
X-Received: by 2002:a05:651c:210b:b0:295:9517:b98f with SMTP id a11-20020a05651c210b00b002959517b98fmr713313ljq.15.1677760265865;
        Thu, 02 Mar 2023 04:31:05 -0800 (PST)
Received: from localhost.localdomain (ccv22.neoplus.adsl.tpnet.pl. [83.30.145.22])
        by smtp.gmail.com with ESMTPSA id o15-20020a2eb44f000000b002934fe524d2sm2068942ljm.83.2023.03.02.04.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:31:05 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: msm8976: Add and provide xo clk to rpmcc
Date:   Thu,  2 Mar 2023 13:30:49 +0100
Message-Id: <20230302123051.12440-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for consumers of RPMCC XO clock to probe successfully
their parent needs to be feed with reference clock to obtain proper rate,
add fixed xo-board clock and supply it to rpmcc to make consumers happy.
Frequency setting is left per board basis just like on other recent trees.

Fixes: 0484d3ce0902 ("arm64: dts: qcom: Add DTS for MSM8976 and MSM8956 SoCs")
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 2d360d05aa5e..e55baafd9efd 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -20,6 +20,13 @@ / {
 
 	chosen { };
 
+	clocks {
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -351,6 +358,8 @@ rpm_requests: rpm-requests {
 
 				rpmcc: clock-controller {
 					compatible = "qcom,rpmcc-msm8976", "qcom,rpmcc";
+					clocks = <&xo_board>;
+					clock-names = "xo";
 					#clock-cells = <1>;
 				};
 
-- 
2.25.1

