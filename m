Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2594A65A46F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiLaNA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiLaM7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:59:40 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24114DF7D
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:39 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j17so25676242lfr.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIrTa1b43Q6dtRU+uKonEGSzz0E3BESzEm7pLgayEdU=;
        b=CaKSYInxGG1wSOJ8/gnmwdVzIIWpuBnd2s1g3Hg/fy/s4f+c5LKk99PIPTz1Zt36SM
         ahZNLWtK+EUjNuVgmjGfHCjqpY4zRR5Qixm46n4t1ZCLBP5U3gBPS2pELvz7maYt96ja
         iprqhi3GY44ld5LgU12PNK9i2I0mV7utdUIgs0eYhYfaV0EAVMMfsthElKLdWkOI/C1T
         kPzrJhrEgZcTEku8dMJMkJD+6ca6ZTCtA4xPv5akIQnMiC1N2VVntB2KTSnp8hWuu0jx
         lP5gYOGiJYnvETxYpM8rj++5bSHV+C3e+5O+CE19IP6cv2XkNLtjFRq/eAZIE/lKJY4v
         fidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIrTa1b43Q6dtRU+uKonEGSzz0E3BESzEm7pLgayEdU=;
        b=atzlo5ZIWzKrtr5sDOsvcEn/OB+WJWb9NN0H2JtEngkwBJuzMXprl83uIsC8CW+NPx
         R33GU3bppBP2MR9srhEPwxmrYlCT74tATP7eMP+qV110ESeHQa9Jj1nOscLf3R/+GUQQ
         WqXF74Z0Klb3Sz674KjxW9qnjcOLKiL7P75nIETj72JB6J/4P9sdDAAgigxnGHCi3EVs
         EMOz//infDbgirFPSBIwlINAcWyCQhZyTZJdoJAfOykCEBYqaz8hpJFDVauprJxMkRP1
         tZXpC4U1Adeiji9K/fZ1TkEwzJd5+uZ9mgBVQfBi0Z+v3qOl9L4ap9L+8csbBwrAAGvl
         NbQw==
X-Gm-Message-State: AFqh2kqZPKkbN2SiJmQ5wxKluEq3zfRwnNYOVKPe/enpDx8Dh2NjxSev
        Z1Bev7WCZFIjUe9dSOZzlvkBEg==
X-Google-Smtp-Source: AMrXdXt3oqFVGZeiuI7ERTFZ+KAnBFLiQdoAj+A5c+Yo7/EkgIunoENX/hVz5zjF/RERxZq4AK/WEw==
X-Received: by 2002:a05:6512:3c97:b0:4a5:42ba:d827 with SMTP id h23-20020a0565123c9700b004a542bad827mr11163449lfv.14.1672491578706;
        Sat, 31 Dec 2022 04:59:38 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id d10-20020a0565123d0a00b004cb344a8c77sm22266lfv.54.2022.12.31.04.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 04:59:38 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/18] arm64: dts: qcom: msm8994-octagon: Pad addresses to 8 hex digits
Date:   Sat, 31 Dec 2022 13:59:08 +0100
Message-Id: <20221231125911.437599-16-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231125911.437599-1-konrad.dybcio@linaro.org>
References: <20221231125911.437599-1-konrad.dybcio@linaro.org>
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

Some addresses were 7-hex-digits long, or less. Fix that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/msm8994-msft-lumia-octagon.dtsi  | 52 +++++++++----------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
index 9b67f0d3820c..4520a7e86d5b 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
@@ -127,98 +127,98 @@ reserved-memory {
 		 */
 
 		uefi_mem: memory@200000 {
-			reg = <0 0x200000 0 0x100000>;
+			reg = <0 0x00200000 0 0x100000>;
 			no-map;
 		};
 
 		mppark_mem: memory@300000 {
-			reg = <0 0x300000 0 0x80000>;
+			reg = <0 0x00300000 0 0x80000>;
 			no-map;
 		};
 
 		fbpt_mem: memory@380000 {
-			reg = <0 0x380000 0 0x1000>;
+			reg = <0 0x00380000 0 0x1000>;
 			no-map;
 		};
 
 		dbg2_mem: memory@381000 {
-			reg = <0 0x381000 0 0x4000>;
+			reg = <0 0x00381000 0 0x4000>;
 			no-map;
 		};
 
 		capsule_mem: memory@385000 {
-			reg = <0 0x385000 0 0x1000>;
+			reg = <0 0x00385000 0 0x1000>;
 			no-map;
 		};
 
 		tpmctrl_mem: memory@386000 {
-			reg = <0 0x386000 0 0x3000>;
+			reg = <0 0x00386000 0 0x3000>;
 			no-map;
 		};
 
 		uefiinfo_mem: memory@389000 {
-			reg = <0 0x389000 0 0x1000>;
+			reg = <0 0x00389000 0 0x1000>;
 			no-map;
 		};
 
 		reset_mem: memory@389000 {
-			reg = <0 0x389000 0 0x1000>;
+			reg = <0 0x00389000 0 0x1000>;
 			no-map;
 		};
 
 		resuncached_mem: memory@38e000 {
-			reg = <0 0x38e000 0 0x72000>;
+			reg = <0 0x0038e000 0 0x72000>;
 			no-map;
 		};
 
 		disp_mem: memory@400000 {
-			reg = <0 0x400000 0 0x800000>;
+			reg = <0 0x00400000 0 0x800000>;
 			no-map;
 		};
 
 		uefistack_mem: memory@c00000 {
-			reg = <0 0xc00000 0 0x40000>;
+			reg = <0 0x00c00000 0 0x40000>;
 			no-map;
 		};
 
 		cpuvect_mem: memory@c40000 {
-			reg = <0 0xc40000 0 0x10000>;
+			reg = <0 0x00c40000 0 0x10000>;
 			no-map;
 		};
 
 		rescached_mem: memory@400000 {
-			reg = <0 0xc50000 0 0xb0000>;
+			reg = <0 0x00c50000 0 0xb0000>;
 			no-map;
 		};
 
 		tzapps_mem: memory@6500000 {
-			reg = <0 0x6500000 0 0x500000>;
+			reg = <0 0x06500000 0 0x500000>;
 			no-map;
 		};
 
 		smem_mem: memory@6a00000 {
-			reg = <0 0x6a00000 0 0x200000>;
+			reg = <0 0x06a00000 0 0x200000>;
 			no-map;
 		};
 
 		hyp_mem: memory@6c00000 {
-			reg = <0 0x6c00000 0 0x100000>;
+			reg = <0 0x06c00000 0 0x100000>;
 			no-map;
 		};
 
 		tz_mem: memory@6d00000 {
-			reg = <0 0x6d00000 0 0x160000>;
+			reg = <0 0x06d00000 0 0x160000>;
 			no-map;
 		};
 
 		rfsa_adsp_mem: memory@6e60000 {
-			reg = <0 0x6e60000 0 0x10000>;
+			reg = <0 0x06e60000 0 0x10000>;
 			no-map;
 		};
 
 		rfsa_mpss_mem: memory@6e70000 {
 			compatible = "qcom,rmtfs-mem";
-			reg = <0 0x6e70000 0 0x10000>;
+			reg = <0 0x06e70000 0 0x10000>;
 			no-map;
 
 			qcom,client-id = <1>;
@@ -229,7 +229,7 @@ rfsa_mpss_mem: memory@6e70000 {
 		 * MPSS_EFS / SBL
 		 */
 		mba_mem: memory@6e80000 {
-			reg = <0 0x6e80000 0 0x180000>;
+			reg = <0 0x06e80000 0 0x180000>;
 			no-map;
 		};
 
@@ -239,33 +239,33 @@ mba_mem: memory@6e80000 {
 		 */
 
 		mpss_mem: memory@7000000 {
-			reg = <0 0x7000000 0 0x5a00000>;
+			reg = <0 0x07000000 0 0x5a00000>;
 			no-map;
 		};
 
 		adsp_mem: memory@ca00000 {
-			reg = <0 0xca00000 0 0x1800000>;
+			reg = <0 0x0ca00000 0 0x1800000>;
 			no-map;
 		};
 
 		venus_mem: memory@e200000 {
-			reg = <0 0xe200000 0 0x500000>;
+			reg = <0 0x0e200000 0 0x500000>;
 			no-map;
 		};
 
 		pil_metadata_mem: memory@e700000 {
-			reg = <0 0xe700000 0 0x4000>;
+			reg = <0 0x0e700000 0 0x4000>;
 			no-map;
 		};
 
 		memory@e704000 {
-			reg = <0 0xe704000 0 0x7fc000>;
+			reg = <0 0x0e704000 0 0x7fc000>;
 			no-map;
 		};
 		/* Peripheral Image loader region end */
 
 		cnss_mem: memory@ef00000 {
-			reg = <0 0xef00000 0 0x300000>;
+			reg = <0 0x0ef00000 0 0x300000>;
 			no-map;
 		};
 	};
-- 
2.39.0

