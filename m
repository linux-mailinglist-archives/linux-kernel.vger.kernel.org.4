Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832F46C5B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjCWAJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCWAJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:09:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E262CC78;
        Wed, 22 Mar 2023 17:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d86xJboPaSOpX1QH+NbF+1P+1jedxA9d+xKzhqDDdnZlt1ZJ33u8+Jrjtzd+KyxXg+0/ZLU45skYtIJI3myvOEpV0mHCZ7aldii5EY2zjd42B3EnbbEL5oKKIoBYolKkf0JhOUHZyYn4jnOVuwsjz23HTx4wwKFDCVaLVE8GmtHr2JoB67TtuVJOrdx2S1cM6RRVgc4EnVodqa5W/Qr7pLg+VhvEu5N8qijx4Ac9fOY/9fw5tNwA+HteqFXm+OS9shjKF0t0iZXy4LqSTliJDDnuwRU3sNaqZA2PZ3xqaHtn3XHJHONETK3G+vZm6LWXg7fAYpKes02HmfZ9GDPkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5d82bpmyF+6P+qy1C97qBN4cXmEmhjcPYdPiNzeQJ4E=;
 b=C2i7AA6W7FIMU5DDCnRCv92tlo9bdp64vqA7G5vxkSKBmevQD3siJZumXNFUQiQLO8UVrk6xcUaSRe3sta3quSid+vG6OEpeMAhfoNXGD7zdr66fx19qBGWvaGkQletYoqX6TZUImfV8mFGErRchz2Io/p/IDkV4JQvY2FjjRQAohL+YoIXROTIrftM6ERTX2XP2QksUHe7bqoyC0oFl7iylHw1mJd/kUt2vtyWtGUFOFKP0yxnyBvfdKHRXxwDhC4YLvHp/UAE6QzO/bC/JNxqZrS7gHuNQpYgSemNi8qgwbwLugEJ7YbGJ7OQRG2uCsQt6phVTE7Evai6vBKGdbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5d82bpmyF+6P+qy1C97qBN4cXmEmhjcPYdPiNzeQJ4E=;
 b=t54KGMDehVIWcErCAT97LOc5ftG9R7ex0FPSq9paNCNY8ACZJ+lqwtvtj0SHN6ZMgYEpjXxUnYmWcHfT8PLq8oWuOPnyyyso71CN7niMgP6GKWTjm99gc1o2zNEiVuAjhAxVSUgh+jHVbAL99qzaswfwsr7gevRXuwt/67kgbKY=
Received: from BN9PR03CA0749.namprd03.prod.outlook.com (2603:10b6:408:110::34)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 00:08:35 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::68) by BN9PR03CA0749.outlook.office365.com
 (2603:10b6:408:110::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 00:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 00:08:34 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 22 Mar 2023 19:08:31 -0500
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v12 06/15] MAINTAINERS: Add entry for AMD PENSANDO
Date:   Wed, 22 Mar 2023 17:06:48 -0700
Message-ID: <20230323000657.28664-7-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323000657.28664-1-blarson@amd.com>
References: <20230323000657.28664-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT062:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c77c51-040d-4bdc-498a-08db2b32be9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PifC26cE4//DvGomvTDDavURj1/vHiy3jq2Trd9TV9PUxFahMqHen0cwRT0KtzjGwoJ8IwzPLuB2ScscsF5sFz7P8bT1HDysxIV2TS597dVcCIP+8NrAzoPQRDpU1maDLvZh2v1quSzin5qPmWNj6I0AnNJuG8mGla5LsR5x0NVieSquBcIt/qMOd0NhtpXSNFCp/CeRKNUo5W1/dR/tQbY+b2GnnnM5NQQXJn3TU5Z8sOrFLsNAYthOLnB15kLOl/hCodjz6SCkf/qbXGu9uRN8699wy2RAl+espPmpJs9xMKpdCwr6V6LePg7umx654gYbPmpFwgkDb3i8oJRwejWaJfdMpbxUMR3kxCNYdguqaJ1g8QF0fcmv4mFaqbvXDdl+8jN4+vN0OA6Wovj84okovRYBbzs7D4uR3MLcLn9sY8+wsIJ+2YIDB4pDdsHXrye0Eh8kfDusRXMFICEOOQRMe/eKySkQSq5unfNfNPdnAC/wtj2WW9VdP0oN3/21lbUGiW9re2TbTbjVVWtnXhW8CKE52n0jd+catDhoYfAEYxNuJ19Y0+7siADBKDMEHIupsQV+OIL30+jjjbvMYCcbAFsV2CWPdQ+OF3XubjaNjgGIZQZ2E51Kbghk6r0xXo331C60SJQ/BeeosAG9IvDgLmFABSQeEk+F3jbPxAO+BNcz3vW/lzmHWy3PdmNvGPoZ3KFShG2GBNHr7TpbaHxe1IS2u5PU/JQ+YJ6cpS8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199018)(46966006)(36840700001)(40470700004)(4326008)(40460700003)(356005)(6916009)(7416002)(36756003)(26005)(41300700001)(47076005)(478600001)(8676002)(54906003)(5660300002)(8936002)(4744005)(7406005)(70206006)(83380400001)(6666004)(36860700001)(40480700001)(426003)(82740400003)(336012)(81166007)(316002)(82310400005)(2616005)(2906002)(186003)(70586007)(16526019)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 00:08:34.8992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c77c51-040d-4bdc-498a-08db2b32be9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for AMD PENSANDO maintainer and files

Signed-off-by: Brad Larson <blarson@amd.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..5e39def215c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1875,6 +1875,15 @@ N:	allwinner
 N:	sun[x456789]i
 N:	sun[25]0i
 
+ARM/AMD PENSANDO ARM64 ARCHITECTURE
+M:	Brad Larson <blarson@amd.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/*/amd,pensando*
+F:	Documentation/devicetree/bindings/soc/amd/amd,pensando*
+F:	arch/arm64/boot/dts/amd/elba*
+F:	drivers/soc/amd/
+
 ARM/Amlogic Meson SoC CLOCK FRAMEWORK
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Jerome Brunet <jbrunet@baylibre.com>
-- 
2.17.1

