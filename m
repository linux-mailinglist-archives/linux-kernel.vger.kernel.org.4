Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F7665D546
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbjADONi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239589AbjADOM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:12:56 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B3317436;
        Wed,  4 Jan 2023 06:12:54 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id h26so5252848ila.11;
        Wed, 04 Jan 2023 06:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eN7znNKYTa9krobv4+Aewqusj4mCG05iDkS6u0BXH8=;
        b=ik02FyR7tS+1Zy/4J4YB9vqWUgilcA3aI9U833ci06Uc55/E6HX51KW0SAjm11TmMO
         VXo1dgAdQprfmkg2+I6tpPrhHH02EgroKgm3EQJb/QMDAO/X1xxToAFoOd/JSZoGMN49
         UfxEK6AIGGm3Ac8wK0iYSQPFkTLkL8jq2fy16Rp6zTXDxen2wU1BNdzUvNNWbZ+Sg/Ir
         Q2QHBDfbAW5CyrBAie6Ro6ZGVmkZf6rtfP6EBMq6wq/V58ksrsjvoHTLj3Uu0xRdM+NQ
         lBfvXCLjW2maqZkBAp+wF/t1teSU3No9Wd2Cjz9vVQAKUdXh7xgSfaEONMf3dSoHJzd3
         zPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eN7znNKYTa9krobv4+Aewqusj4mCG05iDkS6u0BXH8=;
        b=CRn/BgPTvkf1d+uEd9WDtxxl/i1r4Rm4xyDubAGR80IR6m+cwNlrZxq2rZw4yVivRF
         d6uBojLWjDo9tAkvd/2OZX634fdtWQxyJdpYISGo8SwpuXWslgLNKTod8gOM1+a9DCoj
         qz2u6QCYDj5lCg+fEkbe86xfwACY4ouyIWxsXcFmfiUU4XFgccaRfJkZ42KpJEeWgoq8
         vE43yG7WzYAXTmsqO5HcpP+6vpeo2Fbhw+T8Yo3emXv1VDkgAlhXPjV1ye0rr4yh390c
         Ml19fxFc+7Kb485Nrse0dddzRElx21esCVQmC6/aXC67jOHuoH8x5kZk2IDVHGhyVo/Z
         zsDQ==
X-Gm-Message-State: AFqh2kqykdXJ3LTfoE3wUNRlPpAst3Or0x4sg59+iU3/2mja4QzDp+0w
        cqF4Vlu/oILCsa0uud6MIJnzPCFTjQM=
X-Google-Smtp-Source: AMrXdXt/XiFtN0B6SiimEvJ4lTiEStP+6fCT3wWuFyKdHnj8cXvRc/Nnn0g20KK2at3ylkUvpntR8Q==
X-Received: by 2002:a92:7f0f:0:b0:30c:6105:75d4 with SMTP id a15-20020a927f0f000000b0030c610575d4mr3863095ild.21.1672841573622;
        Wed, 04 Jan 2023 06:12:53 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:9aea:58ca:a321:54c8:c288])
        by smtp.gmail.com with ESMTPSA id ay28-20020a056638411c00b0038a5af5e831sm11353451jab.100.2023.01.04.06.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 06:12:53 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: boot: dts: r8a774[a/b/e]1-beacon: Consolidate sound clocks
Date:   Wed,  4 Jan 2023 08:12:45 -0600
Message-Id: <20230104141245.8407-4-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230104141245.8407-1-aford173@gmail.com>
References: <20230104141245.8407-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each kit-level file represents a SOM + baseboard for a specific
SoC type and uses specific clocks unique to each SoC.  With the
exception of one clock, the rest of the clock info was duplicated.

There is a generic clock called CPG_AUDIO_CLK_I defined in each of
the SoC DTSI files which points to this unique clock. By using that,
the clock information for the rcar_sound can be consolidated into
the baseboard file and have it reference this generic clock thus
removing the duplication from the three variants.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi b/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
index b7741c10e778..b31634c13d21 100644
--- a/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
+++ b/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
@@ -639,6 +639,25 @@ &rcar_sound {
 	#clock-cells = <1>;
 	clock-frequency = <11289600>;
 
+	/* Reference versaclock instead of audio_clk_a */
+	clocks = <&cpg CPG_MOD 1005>,
+		 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
+		 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
+		 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
+		 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
+		 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
+		 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
+		 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
+		 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
+		 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
+		 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
+		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
+		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
+		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
+		 <&versaclock6_bb 4>, <&audio_clk_b>,
+		 <&audio_clk_c>,
+		 <&cpg CPG_CORE CPG_AUDIO_CLK_I>;
+
 	status = "okay";
 
 	ports {
diff --git a/arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dts b/arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dts
index 7c0e3252ce65..e077079099c4 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dts
@@ -58,24 +58,3 @@ &du {
 	clock-names = "du.0", "du.1", "du.2",
 		      "dclkin.0", "dclkin.1", "dclkin.2";
 };
-
-/* Reference versaclock instead of audio_clk_a */
-&rcar_sound {
-	clocks = <&cpg CPG_MOD 1005>,
-		 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
-		 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
-		 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
-		 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
-		 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
-		 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
-		 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
-		 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
-		 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
-		 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
-		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
-		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
-		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
-		 <&versaclock6_bb 4>, <&audio_clk_b>,
-		 <&audio_clk_c>,
-		 <&cpg CPG_CORE R8A774A1_CLK_S0D4>;
-};
diff --git a/arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dts b/arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dts
index f1fbd687d0f4..df51c4c46c9a 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dts
@@ -46,24 +46,3 @@ &du {
 	clock-names = "du.0", "du.1", "du.3",
 		"dclkin.0", "dclkin.1", "dclkin.3";
 };
-
-/* Reference versaclock instead of audio_clk_a */
-&rcar_sound {
-	clocks = <&cpg CPG_MOD 1005>,
-		 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
-		 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
-		 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
-		 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
-		 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
-		 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
-		 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
-		 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
-		 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
-		 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
-		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
-		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
-		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
-		 <&versaclock6_bb 4>, <&audio_clk_b>,
-		 <&audio_clk_c>,
-		 <&cpg CPG_CORE R8A774B1_CLK_S0D4>;
-};
diff --git a/arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dts b/arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dts
index 7ee1a1bed212..943671177991 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dts
@@ -51,24 +51,3 @@ &du {
 	clock-names = "du.0", "du.1", "du.3",
 		"dclkin.0", "dclkin.1", "dclkin.3";
 };
-
-/* Reference versaclock instead of audio_clk_a */
-&rcar_sound {
-	clocks = <&cpg CPG_MOD 1005>,
-		 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
-		 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
-		 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
-		 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
-		 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
-		 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
-		 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
-		 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
-		 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
-		 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
-		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
-		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
-		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
-		 <&versaclock6_bb 4>, <&audio_clk_b>,
-		 <&audio_clk_c>,
-		 <&cpg CPG_CORE R8A774E1_CLK_S0D4>;
-};
-- 
2.34.1

