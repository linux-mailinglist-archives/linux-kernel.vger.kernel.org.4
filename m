Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4C365A45E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbiLaNAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiLaM7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:59:48 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B28E0A8
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:44 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 1so35161592lfz.4
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irSxaIcjW3n1PCvBEUpCzHQASe7UMs9Blgt3PcMzjTI=;
        b=VgaVL9fw/qliJ4/NI+fc3fd7xyitgX6Y35L2vtGZBZItbkzTbac7VKdBTRpZJP+bZf
         9zTU/nsHMsj5dy9dWMwMcf5nSH6+rmlkuJSFzm/DDe4s7mt78smBq+T/6xhbLFsIv7xg
         H/uOizGGPH/W0atLrqY594yzj9Iuofy9YDcA1VyQENCdAX2PPtjMMZd8kraOS/CHS6KT
         pGN+5Pt9o+p2oB1xT7csaVgOPFhjNL+qMe9PHj8HDGHRtoLPuh2VKqxji0Qv3xZHDqDK
         JNZD7ljwddNc0cyUrBY2RNb3kM6UCb25xqBsloyfNX1Yjw63eC6UtDHxjeu2PUdCRNYn
         ORSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irSxaIcjW3n1PCvBEUpCzHQASe7UMs9Blgt3PcMzjTI=;
        b=v5yEzvYQqsweNNvvnJqTEeSPugHetlc7gSGqW42bf55whR2iFjz4bVERTUL94yI2zg
         MDOAKx8MdKQeUAGVVI8N8jRvV2DSvy2aQZg2wKuWwRRnmho4y2+XriRmNlStNoMO4rLg
         15MsEthO5xR7V8tiMP4rFzrxPDA2dYKG3Bi2Z0+USYRON2brC7Eh984EmRBdQfhX4jBp
         fqPh525yzi82NRCiAt34Q7V8t08i6a2jS+Doa0Hi+bNSzw8p78ktv3CvdeHX05kNh2Sn
         1P34nKAtVj3IsYCFszk6CNsbJczPwBpsQ3o+h3lusCPMQfu18TJoLG+w+RwABvMeKpzz
         lv1w==
X-Gm-Message-State: AFqh2kqzSzcUQ+gYnA3Ce1wbEWnTTZoz4sMDd1o5stmQ+q8crWul2mKO
        d8h9BGZjA639eP3xV8HAyxqQ+Q==
X-Google-Smtp-Source: AMrXdXvALujMJGMrmv+KDLKv+DuGNj2hOF15E9ai+k2KXulrtY1gZWnm7caYvRmdK8SYnmTaSBM08A==
X-Received: by 2002:a05:6512:1054:b0:4bb:70b2:6f50 with SMTP id c20-20020a056512105400b004bb70b26f50mr10911154lfb.52.1672491583603;
        Sat, 31 Dec 2022 04:59:43 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id d10-20020a0565123d0a00b004cb344a8c77sm22266lfv.54.2022.12.31.04.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 04:59:43 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/18] arm64: dts: qcom: sm6115: Pad addresses to 8 hex digits
Date:   Sat, 31 Dec 2022 13:59:11 +0100
Message-Id: <20221231125911.437599-19-konrad.dybcio@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index b3ed6ec16205..76dab4c2e8ed 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -831,9 +831,9 @@ ufs_mem_phy: phy@4807000 {
 			status = "disabled";
 
 			ufs_mem_phy_lanes: phy@4807400 {
-				reg = <0 0x4807400 0 0x098>,
-				      <0 0x4807600 0 0x130>,
-				      <0 0x4807c00 0 0x16c>;
+				reg = <0 0x04807400 0 0x098>,
+				      <0 0x04807600 0 0x130>,
+				      <0 0x04807c00 0 0x16c>;
 				#phy-cells = <0>;
 			};
 		};
-- 
2.39.0

