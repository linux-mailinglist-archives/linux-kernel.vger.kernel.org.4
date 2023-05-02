Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03FF6F44D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjEBNNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjEBNNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:13:17 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCA75FF3;
        Tue,  2 May 2023 06:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kri0D3JsOsaqgOliibZmmq5JnrXNELhpCA4Cy3pCxbkaV6C6+Vbq1Ts6ybDs8uzyM3+t4iT+q7hzcMyKZ9pB38CGmSgS15YKolC6lmjPvJ89Z8FlYbHkic9GR6gOM+WO05heVpFkJoP+d2+fs0mEcmcWJR+nMSAmB/BXfYGyESg3BTAi/JXaaFr3Tb6bKHLZHzrpTtJfplTabo1sWm80YEiG3uDfd4X3J3kvOm5UO5utVyiHpezQ1INUpBkZmL5pFEOfbw7hPq8xcf04huSXjrJU3toy2f6tllmowBX5VlJz3SfaA8Nn1km/Ua2inRC3MihgBfw3ZHQhj5Ue5dTAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nC2mSNtjUNF2d6em1g/4GwLQR3kUoJ9/j+YGA80nF+w=;
 b=GHgn94B2C/a6/YPFgShr1ptD5n99PyEQ0L/Q8dHS41Hlrs5mvRCYTY+NLM8NhTWP5aJP0LxN57XBC4HNwMQbQV8UPAHiuxhBtKil0xUhjDGXj7+BSRVM3jau08XbEQg8Yvd0BL/AC/juyIqdSZxWA8lyS4EE6Way+CJGNz2abSEclm8aP/d6X4AWyRHgQJLc5ABjyO3Tc0zyhhQ6uAOb/kVX+PTyv8tyi5ItMO+05JW2yJvoyM0xpyR50kFUsYGHfu9uadTVlK9T3W8Eq62xmhpIJ0xlxhJQleKdNaavsutGz7rZtSyEN4LixhqzhpGJXaNvXHZn1q2ePQRFZH0guQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC2mSNtjUNF2d6em1g/4GwLQR3kUoJ9/j+YGA80nF+w=;
 b=iCU8dZWtUNNvHz43rtEz/k8E0KBAUlRF9CJtPjwE0vsQUjUVrWJ5uPvae8clQfPK4heXF1+58HmBZ9MGuN6B8cob2+6U7Tn3aFX7vEnt/suP5DBqTGZSJjtA4B+PH/dVEuMwje3/uOSsBqJwgFVRa9RJApl2qLru6cMlDNX9omY=
Received: from MW4PR03CA0189.namprd03.prod.outlook.com (2603:10b6:303:b8::14)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 13:13:13 +0000
Received: from CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::da) by MW4PR03CA0189.outlook.office365.com
 (2603:10b6:303:b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT115.mail.protection.outlook.com (10.13.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 13:13:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:13:06 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: xilinx: Use zynqmp prefix for SOM dt overlays
Date:   Tue, 2 May 2023 15:12:49 +0200
Message-ID: <49c1b8c992929610ba17b9c6edf5d40d4b28d2ed.1683033163.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT115:EE_|PH7PR12MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a37f80-469b-4275-dee5-08db4b0efbed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Dx4a+kNqBfd8ghbH0tGdQykwrHUw0Ku6SD+b2MWTg20j+k539xr6nbnf5nBqeq4AGA0LUO/a7JsqEKPysChENhDY3nmmvAxBGGn0m7ade0seC6CchPwtPdALXLGedX9X8Ri41JdAP0CN534g4119eFMjoOaVgEYlLnXmLyxkBB+B3KlkNhRXjptfsZTniupLt0f6KmB848Mhks34xubsvW5ZGZi6kRLOyLZjMFtI2Ap3ywcyE4deAqaCJ+QhaE8/oLUPF9sKf5Z+T4D0+UlhT9ZJU2WoXhhWrnjP+5UV7NhPsqXP5fvbvTr+AVDvT5J58DtNYMUPoIRVO4qD2Z4docIPgsvMScxNbaXCztYHV3qBQ8sNucCF+rg2cbA1zWU4QlxeYwJKXaxfnWXYJ7ZyhBbO/l1dgi65TEl6u01pEqlIFFPkUl8bFwtgIaWSqyMGhIu8tyL5JdWBJJLfh6WDqN9SQS3POH8Zv3tv8JqmLvOAS10uE+6eplmhVutVcwim3EeMBn6+jY9WZ4Qugl2FTmuzIiSvrVcKnbbhBLM4zMOxjsiyTexVFXxRx4dzCw/SIc0HsoqrX9wzZPhzbW2uWLfl7lkbB+1a1Ao3PWT1W1dhAdRN3ZmUAZyYYzyLHUum0C2FhtgAxoCAsZL8kilFpSJToqVaoB8IyBd7fwyjeVtQat0FSscm5aufE5E0LhmSSKx35lntJPDW1p7Hgallr/3sQHaq3Kaektv5CiZEnppJWzT8K6myt5uoBH4TOg2
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(26005)(478600001)(36860700001)(47076005)(2616005)(426003)(336012)(186003)(83380400001)(16526019)(86362001)(40460700003)(6666004)(40480700001)(82310400005)(8936002)(316002)(44832011)(110136005)(19627235002)(54906003)(2906002)(70586007)(8676002)(36756003)(356005)(70206006)(82740400003)(81166007)(41300700001)(5660300002)(4326008)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:13:12.9790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a37f80-469b-4275-dee5-08db4b0efbed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U-Boot is using zynqmp- prefix to compose DT name for board detection
that's why also generate DT in this format in the kernel.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index 4e159540d031..686d50752b00 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -21,12 +21,12 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu111-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA.dtb
 
-sm-k26-revA-sck-kv-g-revA-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
-sm-k26-revA-sck-kv-g-revB-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
-smk-k26-revA-sm-k26-revA-sck-kv-g-revA-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
-smk-k26-revA-sm-k26-revA-sck-kv-g-revB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
+zynqmp-sm-k26-revA-sck-kv-g-revA-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
+zynqmp-sm-k26-revA-sck-kv-g-revB-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
+zynqmp-smk-k26-revA-sck-kv-g-revA-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
+zynqmp-smk-k26-revA-sck-kv-g-revB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
 
-dtb-$(CONFIG_ARCH_ZYNQMP) += sm-k26-revA-sck-kv-g-revA.dtb
-dtb-$(CONFIG_ARCH_ZYNQMP) += sm-k26-revA-sck-kv-g-revB.dtb
-dtb-$(CONFIG_ARCH_ZYNQMP) += smk-k26-revA-sm-k26-revA-sck-kv-g-revA.dtb
-dtb-$(CONFIG_ARCH_ZYNQMP) += smk-k26-revA-sm-k26-revA-sck-kv-g-revB.dtb
+zynqmp-sm-k26-revA-sck-kr-g-revA-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kr-g-revA.dtbo
+zynqmp-sm-k26-revA-sck-kr-g-revB-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kr-g-revB.dtbo
+zynqmp-smk-k26-revA-sck-kr-g-revA-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kr-g-revA.dtbo
+zynqmp-smk-k26-revA-sck-kr-g-revB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kr-g-revB.dtbo
-- 
2.36.1

