Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA6767235B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjARQcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjARQbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:31:33 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 08:29:29 PST
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FFA59576
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:29:26 -0800 (PST)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230118162822ed4ab1b3dbf4111be0
        for <linux-kernel@vger.kernel.org>;
        Wed, 18 Jan 2023 17:28:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=o0QGfu5aYlJSGJDDc5cQ+AgSfA70JLHN2RUhvaqAiZU=;
 b=ZqKa4I5FUI0djHbRQViIsHGuDemx55vTFh0KDuf+UG+M9n+pap646IKTek2dgm/nkGF78D
 kH6Q2eA+oUmE6JuOxqO0SzFgRdXs+VDl8EqZvdjdmE/I/BAIChZyvPSNKuVLApZIooltvSJU
 +uexhUzfiUIL7QbaCR9t1h7jzod9Q=;
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH 1/3] arm64: dts: ti: iot2050: Add layout of OSPI flash
Date:   Wed, 18 Jan 2023 17:28:18 +0100
Message-Id: <d135b246bd302060175276d3653f2891077eb109.1674059300.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1674059300.git.jan.kiszka@siemens.com>
References: <cover.1674059300.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Describe the layout of the OSPI flash as the latest firmware uses it.
Specifically the location of the U-Boot envs is important for userspace
in order to access it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 3cced26b520a..96ac2b476b11 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -609,6 +609,52 @@ flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <2>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			seboot@0 {
+				label = "seboot";
+				reg = <0x0 0x180000>; /* 1.5M */
+			};
+
+			tispl@180000 {
+				label = "tispl";
+				reg = <0x180000 0x200000>; /* 2M */
+			};
+
+			u-boot@380000 {
+				label = "u-boot";
+				reg = <0x380000 0x300000>; /* 3M */
+			};
+
+			env@680000 {
+				label = "env";
+				reg = <0x680000 0x20000>; /* 128K */
+			};
+
+			env-backup@6a0000 {
+				label = "env.backup";
+				reg = <0x6a0000 0x20000>; /* 128K */
+			};
+
+			otpcmd@6c0000 {
+				label = "otpcmd";
+				reg = <0x6c0000 0x10000>; /* 64K */
+			};
+
+			unused@6d0000 {
+				label = "unused";
+				reg = <0x6d0000 0x7b0000>; /* 7872K */
+			};
+
+			seboot-backup@e80000 {
+				label = "seboot.backup";
+				reg = <0xe80000 0x180000>; /* 1.5M */
+			};
+		};
 	};
 };
 
-- 
2.35.3

