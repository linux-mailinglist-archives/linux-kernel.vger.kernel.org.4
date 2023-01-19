Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEE467361D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjASKyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjASKyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:54:41 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB14A1D7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:54:39 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t5so1468351wrq.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6mWRy/X+5d44L2jjuHtGqoVOAooJ3c8AYBgnBRZI4M=;
        b=RXdUdWWPGi08Rhuqzg5AnZ1ist8LNWjuhRnYGrJogI7hmAbmtdrOB7oVsnDuP2Uneg
         1Lm0xwlP7lfPErRx0+jnBff5WNFBY2MpewpHBRGNNqyDF1T6vWrXUuqmKLmLYL1AwBWg
         OYA68TeiN5IUhRt5vWQVe10+EdEbgHhhx2Y6TEax8gzZ1xZPmikxGAEVg2r8pSORtcMh
         2FQCGRwqCptCBkRmhnapNk+g2ImvX+wzgyBT4JALLBaki9E+7FpwFP1IYbWKNaX3U312
         S8PCp2rxgDesnOMg97nzxxZo5Wb8HLHe0MuKOA8i3dkolVEtA1j8w0ptzRkdDtPKP/Hs
         lgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6mWRy/X+5d44L2jjuHtGqoVOAooJ3c8AYBgnBRZI4M=;
        b=VzK0BqtPkhkJUTn8KD465MascyjFJ7C+9d0ZJb76BLEWuVHubNBMDBl3SYFuShHZ5z
         sruMyV+QdMob47rK9lDTQIhImlg1ukRvDOMUP7V6a4crhm91J3vB5m3Pf8uzU0Sos6Kf
         K7nOPwJz6as/5TROd9JwE5imtDYnqN9mgeU4O1Sst7sz3vBZKevrW8eom0t/diHOUJyO
         ZI6ILcctJghs0LCaFf59WZ/3U9IbtauQEKNrBTvkyOB8E6sTUFMX8APIdqeje4XPrbDE
         ZBXpfTAfEXsWudFCRjFZbrmgEFJ27bwjcUlpk2cXrCcmMliS5iyF1Pf2PzszUUU+N+DG
         U7xA==
X-Gm-Message-State: AFqh2koJryz/AaAEDqJ4vROx+3n2Xxknv/kgqP3juJMtSUrGXlBBs2uH
        W32R4G67nvza1XNKh2NMHBlJhQ==
X-Google-Smtp-Source: AMrXdXs5GPtEDagqd4KcUlDhKvGfdd5HxZBY9alt0a3icRYZOcsAmD4tVEqBQ26ypLKhlxuKUgXfwA==
X-Received: by 2002:a5d:6a0d:0:b0:2bd:f7ec:bd3a with SMTP id m13-20020a5d6a0d000000b002bdf7ecbd3amr7718650wru.7.1674125677793;
        Thu, 19 Jan 2023 02:54:37 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b10-20020adfe64a000000b00287da7ee033sm33910525wrn.46.2023.01.19.02.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 02:54:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sm8350: fixup SDHCI interconnect arguments
Date:   Thu, 19 Jan 2023 11:54:34 +0100
Message-Id: <20230119105434.51635-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After switching interconnects to 2 cells, the SDHCI interconnects need
to get one more argument.

Fixes: 4f287e31ff5f ("arm64: dts: qcom: sm8350: Use 2 interconnect cells")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index e466dd839065..4efe79985186 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2549,8 +2549,8 @@ sdhc_2: mmc@8804000 {
 				 <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "iface", "core", "xo";
 			resets = <&gcc GCC_SDCC2_BCR>;
-			interconnects = <&aggre2_noc MASTER_SDCC_2 &mc_virt SLAVE_EBI1>,
-					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_SDCC_2>;
+			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
 			interconnect-names = "sdhc-ddr","cpu-sdhc";
 			iommus = <&apps_smmu 0x4a0 0x0>;
 			power-domains = <&rpmhpd SM8350_CX>;
-- 
2.34.1

