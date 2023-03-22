Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D7D6C4996
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCVLrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjCVLq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:46:56 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1DE5F536
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:46:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q102so3744316pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679485577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ8VwymictzzawQ2njPv2aLJoWuJ1cUjyRKGWrHdB18=;
        b=vGEPJkBYf3Vzk15vG4ahRhn4t8IHl+EXIB581wbvhYLvLeNDQGBQ0jU1IEayMmlRN6
         rljhxAVz6PcR07PWd4Ia1pVUoiIkHQOquVubotU/dJqA/sgh1zmqS7BgA2UrSVcKfGtU
         85jOxF2Wuwz7Begyujoz7wy6g9tchOX8jXnkLWkZzgrmrNX258yOiwUEFUU8x2ALfrLW
         BizAZPyqznBszZAh5TYOy4SJxzG+xLzOae3kCE5gu7i9vvNWhhodpURsyeFhQ2qlwrYo
         3KDBPjGjGvPxtSny7hMwxfVATcYw6Ymcxfi2pWanTVFyUwzoAbO4Djsk3oy4N2Q0n+WM
         ktwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679485577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQ8VwymictzzawQ2njPv2aLJoWuJ1cUjyRKGWrHdB18=;
        b=tVYxDK/P++kL8KkkWZBctDaqqFRRB1nYrzAmDBORMNEUYtDmBielA7lwLZbOnypDBN
         Z/SYbDr3D+R3E23GX2/LewAQumMyaS1D0gzI16juNcmWOiDheLO3W8sf0rDEBzHBPl+2
         ojr0WM0DhrxIZ0ZUhoUA+/xjocU9OXiMcq48dH/uGx0UH2kE45vzwhdOOc3GJu0knttj
         pMDqRGeEak78vqTbArHU9qvlJTbABLHh75oiaWv8giQBTmJvP59zvxWlLeXVUVF0GWWY
         MMoTDjx7jXU1IEdTgQqqjYPSzlMlq2RcHHRr2Q3pUmZpbKa1TmM/PZ/fyINK55jIXPI9
         /oSg==
X-Gm-Message-State: AO0yUKXKmHiOC/8Ryo5hk8ejKxCVichFhN5Wf4lYY33+77ve/iKDPHKj
        G3JGHU9GSOexKH2KNO8Rl2Kt2Q==
X-Google-Smtp-Source: AK7set/RID1to7iaWjyRvkmvU5mf/O9ULxkw/TaLGuQHsn8qfZ/cqv0RzfvrMqjDyIJcMv8sI443yg==
X-Received: by 2002:a17:902:c94b:b0:19f:1e3e:a84d with SMTP id i11-20020a170902c94b00b0019f1e3ea84dmr2974008pla.64.1679485577446;
        Wed, 22 Mar 2023 04:46:17 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d4c3:8671:83c0:33ae:5a96])
        by smtp.gmail.com with ESMTPSA id jd1-20020a170903260100b0019b0afc24e8sm10386649plb.250.2023.03.22.04.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 04:46:17 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v2 09/10] arm64: dts: qcom: sm8350: Add Crypto Engine support
Date:   Wed, 22 Mar 2023 17:15:18 +0530
Message-Id: <20230322114519.3412469-10-bhupesh.sharma@linaro.org>
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
'sm8350.dtsi'.

Co-developed-by and Signed-off-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index b2f1ea4b671e..39ee7ab78387 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1730,6 +1730,28 @@ ufs_mem_phy_lanes: phy@1d87400 {
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
+			compatible = "qcom,sm8350-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0 0x01dfa000 0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x594 0x0011>,
+				 <&apps_smmu 0x596 0x0011>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO &mc_virt SLAVE_EBI1>;
+			interconnect-names = "memory";
+		};
+
 		ipa: ipa@1e40000 {
 			compatible = "qcom,sm8350-ipa";
 
-- 
2.38.1

