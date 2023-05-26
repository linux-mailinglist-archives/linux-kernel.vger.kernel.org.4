Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AF9712D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242443AbjEZTZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjEZTYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:24:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46843E4E
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:23:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae3ed1b08eso11085765ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685129012; x=1687721012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzLxRqESfAzhWOHk9jWggF2sKez+2FAQRolSYn3FDhg=;
        b=UZvG6SPqirBlWwo5g3YildSNzcleAp3Rwlt3UKE8P2jPVYOL9fo4scwjEO9njeI4C4
         n0POx7PAKH8wF9/wdNF47kCoAkbIMNM4utf8vz0Vs9QNpcZMvYIQ5EcUjEZTWTA0r2Oc
         2zDFWnhpSbWn+NDDESS2dvuFQySHKuCaKxfL/nIyZEmy2to/CnRpa4OSqekUPS2QuNvb
         ZE1J2v2l3ooCfGe8A5pJlA5+x4Rg4q6+cQ2EUUweoyeH5FP023qPhtdWCY7y/AOoPJaP
         UWG4M0zYTvRpIADCs1hKKejlHxEiEOASIqknBhbF/j2VtMhDsGlLbUF2cQuGwm3NSAiF
         kvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685129012; x=1687721012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzLxRqESfAzhWOHk9jWggF2sKez+2FAQRolSYn3FDhg=;
        b=BSYFfZS3vlfyJzLfDaBF4wb+pWuYcldrV5aLV2jeHpK0sLjJfPkVvFnJ+xb70SwMBX
         UO8v9gDdWh7gM+4zUoT02XmhSqOXc12Yk2kMjXUld+oujBg66SlpBN9IRLPnn8xgfk13
         h2pp3J7mSizMIoXqvR/Ts8UzvYY7FFiXnGp7kB/WZPpeWUylslm0hT4Jok4h/lkpsGRg
         lxZuL+82nfiMERv8o4W8patW/nl/CRuAGFmdpvFzNNjW3ys292/AnLm4SkGhTWSRINeu
         +FCkNCvdcLEYhD/tf+zhj32n5uZ7phe2JjfdcqyKorzVYV5HxV/aGiyDP1Xl7irs04Ob
         rYrw==
X-Gm-Message-State: AC+VfDzyoafVekCraFuWM33T19h7MnmuNxAvdSUApd04GtNorhhnSzJj
        3LfVlZ3NIpwYjgYrK18/x6xlBA==
X-Google-Smtp-Source: ACHHUZ5Gv2aoxtmLLsPeGviJahVJN0Zpn7y4bJSqPAL5PO1NAht9Llw/S1mI72wY5+gz4F3n8p5x8w==
X-Received: by 2002:a17:902:ce90:b0:1ac:310d:872d with SMTP id f16-20020a170902ce9000b001ac310d872dmr3587422plg.52.1685129012380;
        Fri, 26 May 2023 12:23:32 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3a:6990:1a5c:b29f:f8cf:923c])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090311d200b001b008b3dee2sm1955079plh.287.2023.05.26.12.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:23:32 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org,
        stephan@gerhold.net, Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v8 10/11] arm64: dts: qcom: sm8350: Add Crypto Engine support
Date:   Sat, 27 May 2023 00:52:09 +0530
Message-Id: <20230526192210.3146896-11-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto engine (CE) and CE BAM related nodes and definitions to
'sm8350.dtsi'.

Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Co-developed-by and Signed-off-by: Robert Foss <rfoss@kernel.org>
[Bhupesh: Switch to '#interconnect-cells = <2>', available since commit 4f287e31ff5f]
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index d9aa591dccf8..52afdf26b2bf 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1735,6 +1735,28 @@ ufs_mem_phy_lanes: phy@1d87400 {
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
+			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "memory";
+		};
+
 		ipa: ipa@1e40000 {
 			compatible = "qcom,sm8350-ipa";
 
-- 
2.38.1

