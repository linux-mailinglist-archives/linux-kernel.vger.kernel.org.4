Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7773D002
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 12:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjFYKDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 06:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjFYKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 06:03:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A0C1B3;
        Sun, 25 Jun 2023 03:03:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyVwJTmGOGx3DVBa4hE40mupXkRdIvIAxQqsRfcFKK5IkjZMfF21gIQoVOlORFSaZyaQZE3tab+kzAerqIQUDWtRb5IYNHXB/b+gOoLYnqe6atbwRlusnuip2Nwa4KQA+ljLOmAuf8HL6DOAdp1hDA773H+IIMpTf9/+Fd8IyW6W7tc3ad2zOLLHqKChE0yPcZhEq8XaGCDxobP0Yw7ddOgykKnOgmGR/0ObX+5H3nvfx/APTeHiWR6gZGCzco51QTmGTwZV1zhQaWHpLeZbaGl2ooa/5KaKHYt1G1JhltpZhFFsF1pJ5fWi2syXIemUwnRagK2GpCLghvXtn6iSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35Xr5q8L4pV/kgzKYMv9F1EeEttsGC5RN+nKn8VMngY=;
 b=SetBg0vDbZvCY1WL0RqzyDIQxzqPDlWLjl5+aqnX8FnhXs+O8cvcSVRHSxBIBytE0jPpx9llFmWHnY8lBX17upLussZkbCgPGnJWx8EPLKeOoFrb5ReuXqPoguQlt3onfp1OkY1dwNvpj/a+O/r3DcRNydnl0KIyWCBPlJ//KrOfidMpRMJ/DhBp6P1J/Xs+rcxS2xELkzTVmctXHBSiWCyEMoD1h7yUmriWeUFD8mD/O2BJMO4vS0GIwnnVonVzYwaRuMGoC0tr2v1O7ZCWcg5F1F0T68ACowUXMNqDRUHyrZel32/V1b9EWOMygR4tTqWOQsGAMbTA/SNOic59fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35Xr5q8L4pV/kgzKYMv9F1EeEttsGC5RN+nKn8VMngY=;
 b=li3phwuHAMVef2PXu0SucdneKfYfwEvESSWlUC2UpY8yTG5E4oE4nM81TSFbJUvm1KdLWIUnpID2oxn+SEPANxTNB/TYAujCzlaoAqLamM9k+55rhIJjKLRB0US0cb5QVVezifzGKX82NmBnAmbXucTadd8siL2RxvqIaLnk1Gc=
Received: from DS7PR03CA0241.namprd03.prod.outlook.com (2603:10b6:5:3b3::6) by
 LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 10:03:02 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::b3) by DS7PR03CA0241.outlook.office365.com
 (2603:10b6:5:3b3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Sun, 25 Jun 2023 10:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Sun, 25 Jun 2023 10:03:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 25 Jun
 2023 05:03:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 25 Jun
 2023 05:03:01 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Sun, 25 Jun 2023 05:02:57 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <git@amd.com>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v3 1/2] dt-bindings: mtd: jedec, spi-nor: Add DT property to avoid setting SRWD bit in status register
Date:   Sun, 25 Jun 2023 15:32:50 +0530
Message-ID: <20230625100251.31589-2-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230625100251.31589-1-amit.kumar-mahapatra@amd.com>
References: <20230625100251.31589-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: b96d30a0-bc29-419c-96a7-08db75635cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uzn0KYrFFIoCb13cRQ21mDK49v3IR5t8zYbSpOM5E9LmfjJfYwMUOK6IOE3kNDXz7Cz9J/XOyehn3a5lnJyli8ptY7KtgElySvwROyznNv57I2Iy0RzCkhlquxuMzdsq0ZgNoiMn6SqDJbUCr3PUexgOgcXIryN8zeSQt/gydJaHVPCCo8ZBpAdIuHaJxnsYREB0CTts4n+fiiDo0uXcaU3ewfrPpbBPsIc8cVgi87D8/ewefiaUeEkCGuJ/26WklDraifsiYGba02wcc166VK1SugHeqEZNV6iCdiTrxdKyzdrWT74g9yJ04Dq05S9MnIa93lhq9G5vwMuEsozE69rjJ/bIX+t3/7g89gXNE3kSm3Yjg3JCcVKrmRvVtYCaXBz3ND/0zxcJWfM1yb+1SmZKcyx/G+fMrdtqWfNDkS+RJGDwMy5PhrLrXn8IZxH9JvUOa2gMamXhHFZ8V3T8zU6rgHYd31SJmWKp4QMl7djUHITGM9L+VLt1isUKSjO91deUSBmfyJ+8xh3uAiot8TRKuH9bMhbBvKMEjCZjx8U1haz1VoGVR42ygUzTChWqQdUViwfivRMxd6qIRi62XTSXeMt/fjkEQHTuzwiahA7TIJWI8fH8g4kyjzawkjfMGqMo00vk5QqYaRQ7C48MC4SC+QfONJawZrHYaD5ftPJuT2Nlo1Ky+m2bMWi+GmZ1Z2d0pZrPR/1yHmC6/1YYnBZM4YSbeIhRuRcg1uHtfiIWLwrOE5ELwvI8AliWcZuiq4TQ5PRoMHZJh8ZKrT2C8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(2906002)(26005)(186003)(1076003)(426003)(47076005)(2616005)(81166007)(336012)(356005)(40480700001)(36860700001)(5660300002)(83380400001)(41300700001)(40460700003)(70206006)(70586007)(8936002)(7416002)(36756003)(8676002)(82740400003)(6666004)(54906003)(110136005)(86362001)(4326008)(316002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 10:03:02.3996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b96d30a0-bc29-419c-96a7-08db75635cf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the WP# signal of the flash device is either not connected or is wrongly
tied to GND (that includes internal pull-downs), and the software sets the
status register write disable (SRWD) bit in the status register then the
status register permanently becomes read-only. To avoid this added a new
boolean DT property "no-wp". If this property is set in the DT then the
software avoids setting the SRWD during status register write operation.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
As the DT property name has changed so, removed Reviewed-by tag.
@Cornor if possible, could you please review this updated patch.
---
 .../devicetree/bindings/mtd/jedec,spi-nor.yaml    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 89959e5c47ba..97344969b02d 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -70,6 +70,21 @@ properties:
       be used on such systems, to denote the absence of a reliable reset
       mechanism.
 
+  no-wp:
+    type: boolean
+    description:
+      The status register write disable (SRWD) bit in status register, combined
+      with the WP# signal, provides hardware data protection for the device. When
+      the SRWD bit is set to 1, and the WP# signal is either driven LOW or hard
+      strapped to LOW, the status register nonvolatile bits become read-only and
+      the WRITE STATUS REGISTER operation will not execute. The only way to exit
+      this hardware-protected mode is to drive WP# HIGH. If the WP# signal of the
+      flash device is not connected or is wrongly tied to GND (that includes internal
+      pull-downs) then status register permanently becomes read-only as the SRWD bit
+      cannot be reset. This boolean flag can be used on such systems to avoid setting
+      the SRWD bit while writing the status register. WP# signal hard strapped to GND
+      can be a valid use case.
+
   reset-gpios:
     description:
       A GPIO line connected to the RESET (active low) signal of the device.
-- 
2.17.1

