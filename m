Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2D071017D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 01:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbjEXXF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 19:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbjEXXFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 19:05:19 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7561CA4;
        Wed, 24 May 2023 16:05:18 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-75b14216386so21392985a.0;
        Wed, 24 May 2023 16:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684969517; x=1687561517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUSAAG9pfUB1ZTX71jFjFbloAT5u0vNKnYB6yXCHfu0=;
        b=bHV702UhCY4TRJGzeAncS7APMg1HomAan8iZ3h6+IvELJEmEmls9hYz/WISv4CknSM
         sFP2DUoyaNuIjbU1rB6fZkA8eufsKGbxunYltb/DCAiG/AabABhAZamRZ8AqS5597MRa
         Bh5ECtgPg4zpeelycObq6Qve50gBYNxmfH4GKLvzjzDQJzBWABmyMrChpoR/WMxVarMz
         u8YHS94y0mvvtO4t7hNUes/Px5R3/3pQXu7URsYMV8vI0JWiwD7t7qnDth9ZE8klpz6A
         Q8Gb2uWkC6cqbSP/h4lywg8zSmb+htd1qe6vjgOgQ3sCK4jUuKPal1VurqYKSczCANT2
         oTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684969517; x=1687561517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUSAAG9pfUB1ZTX71jFjFbloAT5u0vNKnYB6yXCHfu0=;
        b=YkMKqRFSpg13sCcBp+NiQAoSaOInxxp13OKQwNpkdCn951NqStKnUx+fVngklTiitT
         DzZfVLFKIJKUoGyA8y2hiJdeR1tWV+RtYa/mIq7N7YV+nnT1FyEPcL7ao7vItd2ZZ8/c
         hAVepFVjpzufxRgPDBxWvgtkvBgNdhQTxR0iUqVxPeZCEHEDCuiQ1uNLYmFAeGIEWtW7
         mJSRAxKEHcbez6c5Zic2TKSNETqU3H7j52eqi8NF8AQjAwpRr4647iVTKZBZj4jmisx1
         QhfrbfG6YpevQ0dbirOc9x9en9SF9ZI68DcMqGoaQVbQVa3ZowAkseAGFFewwttv5mHp
         /Ykw==
X-Gm-Message-State: AC+VfDyTdXpkKQbwvdTWbMv6TOlI5K06904FBzyQmFs1azTCcTXzBqVh
        dbYT4XAJBOfXrXtvZnzGOJI=
X-Google-Smtp-Source: ACHHUZ5Bs24l8Epn2wrNFBabv2Tzpalpn6WpE7byhruVeuHJkWcn1oO5NZhD/W5m/RzgutJcG1iS2g==
X-Received: by 2002:a05:6214:dad:b0:625:aa1a:b6dd with SMTP id h13-20020a0562140dad00b00625aa1ab6ddmr3625488qvh.63.1684969517456;
        Wed, 24 May 2023 16:05:17 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:650f:ad8b:38f6:d091])
        by smtp.gmail.com with ESMTPSA id ea15-20020ad458af000000b0062075f40f61sm3914019qvb.73.2023.05.24.16.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 16:05:17 -0700 (PDT)
From:   Rudraksha Gupta <guptarud@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     david@ixit.cz, Rudraksha Gupta <guptarud@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] ARM: Add label to sleep_clk in qcom-msm8960.dtsi
Date:   Wed, 24 May 2023 19:04:54 -0400
Message-Id: <20230524230459.120681-1-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Allows msm8960 DTS files to reference the sleep_clk node.

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8960.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 2a668cd535cc..a4d8dd2d24a6 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -71,7 +71,7 @@ pxo_board: pxo_board {
 			clock-output-names = "pxo_board";
 		};
 
-		sleep_clk {
+		sleep_clk: sleep_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
-- 
2.34.1

