Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F467017B6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 16:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbjEMORm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 10:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbjEMORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 10:17:32 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D369226A1;
        Sat, 13 May 2023 07:17:30 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34DEHOgR005773;
        Sat, 13 May 2023 09:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683987445;
        bh=rv9RQvTi9dj3agO6UaLgCL/rdf1mSZb2RQ9few6o2Y4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=E116e1ouLQemb1/B01i9hKAVmqFoecnVGVsLQTg8UpkU0nQnuX5CqHAKRw4tph7ub
         uF/dy7FcO7nNXyHYbdwraCqa0MaW5s/dTBYA8I0X06MWn7lY7QsrjrLoDoyM/oZdi0
         6HgDT6DKBYUw2ZRLucQM9CL5sZa0m8WTBjczCZfw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34DEHOh5020429
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 May 2023 09:17:24 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 13
 May 2023 09:17:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 13 May 2023 09:17:24 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34DEHNXG047479;
        Sat, 13 May 2023 09:17:24 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <conor+dt@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <vaishnav.a@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH v2 6/6] arm64: dts: ti: k3-am64-phycore-som: Describe OSPI flash partition info
Date:   Sat, 13 May 2023 19:47:12 +0530
Message-ID: <20230513141712.27346-7-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230513141712.27346-1-vaishnav.a@ti.com>
References: <20230513141712.27346-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe OSPI flash partition information through device tree, this
helps to remove passing partition information through the mtdparts
commandline parameter which requires maintaining the partition
information in a string format. AM64 Phycore SoM has a S28 64 MiB OSPI
flash with sector size of 256 KiB thus the size of the smallest partition
is chosen as 256 KiB, the partition names and offsets are chosen according
to the corresponding name and offsets in bootloader

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 8dfb6301b17d..0d3d785530cf 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -219,6 +219,47 @@
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x0 0x100000>;
+			};
+
+			partition@100000 {
+				label = "ospi.tispl";
+				reg = <0x100000 0x200000>;
+			};
+
+			partition@300000 {
+				label = "ospi.u-boot";
+				reg = <0x300000 0x400000>;
+			};
+
+			partition@700000 {
+				label = "ospi.env";
+				reg = <0x700000 0x40000>;
+			};
+
+			partition@740000 {
+				label = "ospi.env.backup";
+				reg = <0x740000 0x40000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fc0000 {
+				label = "ospi.phypattern";
+				reg = <0x3fc0000 0x40000>;
+			};
+		};
 	};
 };
 
-- 
2.17.1

