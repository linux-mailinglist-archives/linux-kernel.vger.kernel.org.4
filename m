Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142736C498F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCVLrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCVLqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:46:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144C362871
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:46:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so23341727pjt.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679485572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBzdk5jveeS/JKT+9yyCQAyTFFXN6rxWCWlR5xuiXEk=;
        b=FQ4oEfEfKyutywrwUKaGClssESWA9XhPfdAqpLdcQ+aSTIQXXEB5QQo2CDKo5Ewsz+
         SUfqfgHA+Ah11eXEgJnZOtfl81edD7qHdIvq5PS8q9hGt3a3FPmDSqr46riXzNZ3rAeG
         4wpVWlHcwjo7VqMFiEWuVV9Uw2Rc8gJ8I/Y6EaMYXpmDnEHT7ASChXBnNyx2mlgxK5Kg
         QIq1K/kPfKSLJ9tn+WJZ17iIXw7h2SLdOx/U3P/KeouXvL2VEumyqPdnvbC0E5niTz53
         YrJuZcc7HWHDszcwD/uOaAjJbn53lWZI5qFs58oeCQCKYJtdoCWo7eLgw/SuBSVA5sz0
         zGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679485572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBzdk5jveeS/JKT+9yyCQAyTFFXN6rxWCWlR5xuiXEk=;
        b=6uL/ZXHzWv3hOIEkSWTBSaQz/ktKNezD4vnmczC83C9/TSrL8eOrG/Y/pLq0reKZBI
         psC5i0yQmS+m43+d37zslJnhlL4Z1KQJBE/xjxWmoU2byv2g/k9xHCbhKl/VyNod0Xwb
         ZJLJmKr2UH1y1qzLNMwi8B3eYTC3pzJemol8mstDj3qt2ep410+Sq1pBcdqngLdV28yf
         2rjLlw+B8SBnQ0u8z4vYxl4LdgoG2kJBoeDjvVj59pf9XWlPNoideetoJvCYvtSjGQi/
         dFbRiGhAdJXZ9aCCD+IHCNMEl8851v7Xp/HZtxyYiPvDY891dSGejS9qdoYaMLGOtVNW
         LkUQ==
X-Gm-Message-State: AO0yUKWOQGhi6E1l+5nI8RF9TdEn3/mgc5t97NfDhyEJuTlTH9La2Kx5
        6cAP5vgKootvBzhdLe1P4g+I4w==
X-Google-Smtp-Source: AK7set+CvrUqHkML+6AI9HfZ/fpLkUht5e6QoAHzaL9sYOhcFv2PW3L43Nv4rhqFQKyMWv7AtPBv7Q==
X-Received: by 2002:a17:902:d4c3:b0:1a1:dbaf:ae31 with SMTP id o3-20020a170902d4c300b001a1dbafae31mr3431138plg.1.1679485572317;
        Wed, 22 Mar 2023 04:46:12 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d4c3:8671:83c0:33ae:5a96])
        by smtp.gmail.com with ESMTPSA id jd1-20020a170903260100b0019b0afc24e8sm10386649plb.250.2023.03.22.04.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 04:46:12 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v2 08/10] arm64: dts: qcom: sm8250: Add Crypto Engine support
Date:   Wed, 22 Mar 2023 17:15:17 +0530
Message-Id: <20230322114519.3412469-9-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230322114519.3412469-1-bhupesh.sharma@linaro.org>
References: <20230322114519.3412469-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto engine (CE) and CE BAM related nodes and definitions to
'sm8250.dtsi'.

Co-developed-by and Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 7ccec48255f0..d0fe17d0790b 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2223,6 +2223,28 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0 0x01dc4000 0 0x24000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			iommus = <&apps_smmu 0x594 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+		};
+
+		crypto: crypto@1dfa000 {
+			compatible = "qcom,sm8250-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x594 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "memory";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x40000>;
-- 
2.38.1

