Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E306B8EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCNJq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCNJq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:46:56 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CC714EBE;
        Tue, 14 Mar 2023 02:46:54 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32E9klTR094097;
        Tue, 14 Mar 2023 04:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678787207;
        bh=tmISwl53EEmJ0UyWepF6LKD4kNk5gNEJdpfnLQ6BEAw=;
        h=From:To:CC:Subject:Date;
        b=QC5rl1+KEu6qFKnxte89oLx5dl+AgC+/+dp5bwcO8Y0WWQdsfvbntpS96wp6XZFDi
         7vfTAYSlob/06o3wZ6uhTxBbyIf6sJmj5hsTxMDY0gjrIsTGYsnKStMdSVybfK5tGe
         49+lRxdz4fWYkpoDE7l9c1drp57gj+huleZUi7Ig=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32E9kloN024093
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 04:46:47 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 04:46:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 04:46:47 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32E9kkAX090240;
        Tue, 14 Mar 2023 04:46:47 -0500
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <a-bhatia1@ti.com>,
        <j-luthra@ti.com>, <devarsht@ti.com>
Subject: [PATCH v3] arm64: dts: ti: k3-am62a7-sk: Fix DDR size to full 4GB
Date:   Tue, 14 Mar 2023 15:16:45 +0530
Message-ID: <20230314094645.3411599-1-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All revisions of AM62A7-SK board have 4GB LPDDR4 Micron
MT53E2G32D4DE-046 AUT:B memory. Commit 38c4a08c820c ("arm64: dts: ti:
Add support for AM62A7-SK") enabled just 2GB due to a schematics error
in early revision of the board. Fix it by enabling full 4GB available on
the platform.

Design docs: Link: https://www.ti.com/lit/zip/sprr459

Fixes: 38c4a08c820c ("arm64: dts: ti: Add support for AM62A7-SK")

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
---
Logs:
https://gist.github.com/devarsht/e85b6af89c01ddadb3a62f3e5f196af8

Changelog:
V2: Update commit message with mention of schematics error
V3: Add Reviewed-By and update design docs link
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 5c9012141ee2..f6a67f072dca 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -27,8 +27,9 @@ chosen {
 
 	memory@80000000 {
 		device_type = "memory";
-		/* 2G RAM */
-		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
+		/* 4G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000000 0x80000000>;
 	};
 
 	reserved-memory {
-- 
2.34.1

