Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35FC701D46
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjENMZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjENMZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:25:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15D8270A;
        Sun, 14 May 2023 05:25:45 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ab0c697c84so88975825ad.3;
        Sun, 14 May 2023 05:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684067145; x=1686659145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eJtkEQLwd7Qa7A4qK6Edti5i00jqeiQeXfJVryR8JcA=;
        b=SIY4C+T2I0C52S7gQJuVzeEMZFgj0o8Emz6v8xbTpDJD7iu9LvkHP/XKTHRILIbQcl
         bRIKVu7XcmifCL6o+jg6Wwyv8vd/Vf2dpbrcma4VTXbNePdxvF0CLz30CxNp1zDc75SY
         R1PGxoVs0LlbR1BjKnIJhJVRD6EM8vKm3NpBPxHUly/nmxNNmRjXt1Rv7rBRsakaC30S
         TLW+kaggoguy0dHyQs60HVVTpOgxeVe+TPtBqpu4r/I/rtBMotYGdbhRjDSckiSEiGgt
         M8i+Lwh23V1Nc/tAEleaz49YlTb2b5qZd3ig2mbjYgBSvvUT0qmxtJojxD5GSNOPXXN1
         f4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684067145; x=1686659145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJtkEQLwd7Qa7A4qK6Edti5i00jqeiQeXfJVryR8JcA=;
        b=HY0IEJU5arrP0akzuV72oI2gFW+xser4mYx5OVc34ve8B4BfYKsryDgHYWRtuBTXRv
         E0zlYK5IruJozhW0lAV4boB5LMH2OO2yvVgFEU4q+T3LBoUXBA0qhMuSGiwvtkMNeyH+
         HPuTGpNjCfb3Pij9qazbqrun6VoO/6uUFWGVcO9e0+JeRevN8mqqoyC6rQywGF77iNNN
         wv+atAcMCgXZlG3PQt+mvxbibjnlvm8rVr+tbVNaaQU2zl6B0m9z6SBrXXK0tMAAb3fs
         Pt+ol4TnzwYvXK5aNbicUa6s6m0TMNK9spsIh1JmhSPzFks1tc2Nzy1Dx/xSpfph8o2T
         Jf8A==
X-Gm-Message-State: AC+VfDwOyjHrkTLeGafElolRwd46q2hmS9KM4CBnGzCOf7xiLSOdoqzF
        k4N/bjEY2JZtLgaoTv3+Das=
X-Google-Smtp-Source: ACHHUZ6NRqpfucIOVjtK9NCyhezD5/4TH/aHpYpJlZjut2EW1BcrDDewEt7AZxY9omwFIslEdXwctA==
X-Received: by 2002:a17:902:cece:b0:1a8:626:6d9d with SMTP id d14-20020a170902cece00b001a806266d9dmr40923458plg.62.1684067145347;
        Sun, 14 May 2023 05:25:45 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170903054d00b001a641e4738asm11380077plb.1.2023.05.14.05.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 05:25:44 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     David Yang <mmyangfl@gmail.com>, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: hi3798cv200: Fix clocks order of sd0
Date:   Sun, 14 May 2023 20:25:33 +0800
Message-Id: <20230514122533.382910-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
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

"ciu" and "biu" were incorrectly swapped. Fix their order.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index a83b9d4f172e..ed1b5a7a6067 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -302,8 +302,8 @@ sd0: mmc@9820000 {
 			compatible = "snps,dw-mshc";
 			reg = <0x9820000 0x10000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&crg HISTB_SDIO0_CIU_CLK>,
-				 <&crg HISTB_SDIO0_BIU_CLK>;
+			clocks = <&crg HISTB_SDIO0_BIU_CLK>,
+				 <&crg HISTB_SDIO0_CIU_CLK>;
 			clock-names = "biu", "ciu";
 			resets = <&crg 0x9c 4>;
 			reset-names = "reset";
-- 
2.39.2

