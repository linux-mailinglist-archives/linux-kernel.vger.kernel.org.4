Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650866AB56A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCFEKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCFEJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:09:23 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24BE10A91;
        Sun,  5 Mar 2023 20:09:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh8XxqwhyiAcwDWnDItWdzbjqlLAfqWap/n2JMK3xUoIMDnPF2rM7NSIdiYT2oc1Vp7oXOnfyXIG9r+6v2vP1jq32NjOv6ELKRM62cg4Xjk4TKHSqRwoiJn498W7AjQD+C+6LZSp+rDyBzTB1FZe9oGIqD3kYp+r38Od2bqSm1DstV2HJDc27LWpU4CQaGF28PS5Rma/cVq3iA73yfP2BK782wELWcPbUmSDhnhhbV+iNK90AomfdTMCuqaU2CSq1ZEHRwSZIkiinF1JqZKDYtjfCTbP/TNCLEHSFsw7Tvi8nHoRFOmlU8FEyzIqtAl/W/9+v7nmqKYl+ELLZcnktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5d82bpmyF+6P+qy1C97qBN4cXmEmhjcPYdPiNzeQJ4E=;
 b=GGuvlkl4bojkqlGCOAGkneT2BjYAZetGMvgpHcaMAgkgccrp0cA8y8TnBeNagwqmUDDp2x3j17RYRo5910nsOQ3JHHIU9Q80R81lAXIeudOrFcMpuF92j0RmVUlGUBcTuSRcGw8o6hOVQQ0hkgwmnLWMhZk1KRp8UOa+w9htgVWG7D/0Y6B/YiF5bCj6YAqEQ2x90J4xdI8Ss8EuCZCeEDOnFjl2ip2uL5Ylnij3MQi1QnRIdTQbUPal3fECwSLRVgEfAcVnUV2Y9Pkf4T78W0pAqu3SNDuAycfISxrLFhDKEKMSgqnIml+LEP5HfHHABuUrmQN9UIZNtmAyVU/Zfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5d82bpmyF+6P+qy1C97qBN4cXmEmhjcPYdPiNzeQJ4E=;
 b=e+bz/YK+uZzmKER5oxBY6ebDzSaWFC3wNGzxt6Hg+dk80rgsTOIY7LrHmCeaFnWlzRCPepajo+OutCIlklg/SN3Ld/vpMo6FFZ0GT8HLbXtDex7Z4bJn0Elq6GThWQWwirDPU/zKif87pJ4GQX6Ecd/po5mmdLWu0zm7Mmkqm+k=
Received: from DM6PR02CA0055.namprd02.prod.outlook.com (2603:10b6:5:177::32)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.26; Mon, 6 Mar
 2023 04:09:07 +0000
Received: from DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::36) by DM6PR02CA0055.outlook.office365.com
 (2603:10b6:5:177::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27 via Frontend
 Transport; Mon, 6 Mar 2023 04:09:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT106.mail.protection.outlook.com (10.13.172.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.14 via Frontend Transport; Mon, 6 Mar 2023 04:09:06 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 22:09:01 -0600
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
Subject: [PATCH v10 06/15] MAINTAINERS: Add entry for AMD PENSANDO
Date:   Sun, 5 Mar 2023 20:07:30 -0800
Message-ID: <20230306040739.51488-7-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306040739.51488-1-blarson@amd.com>
References: <20230306040739.51488-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT106:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: abab5a99-5224-45d7-f1e4-08db1df88798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ul/uwsNwRJF9myvtAPHT3+E3ESF6Z4awjlRS3xwnt4w0pjzXuAvxtXpzqJKPb4Sz3RM9xdAF5b/gH6EIXbNLMspFmtMnk88bPRsxyBbzaP+kIl0JsUEqyd8/zMSFA43E0/Am36SbBd0dyLd+39HKQPt6yVLq9abqjUoPTZmdbvwO2LM0KPDuTOEQKr/GHWtQZDwvLE4PAVjZrmPCP4Wfbj1d6y/jwzvFHH1HIUa+RSMTdmwDr4zAePgCLQEHNZgr+HX5sQKtaS6QDUmShTEb2Rhl8MYDDZ7xYsu6KFaWzcnePOoeZbBmEUY+ueNHzsXqddxAxgKsMhFUI2woNJX9fHG1o2DICuL09rnM8u3B+gioNQ0TcgK5zHLUnQHxqQu+A0Fic1vvWIE7eBfqRl1KJzhpTqk6/8BeMX7dUiifD0IDf4mvGMAZlFJFrjm7Aui0l/BFaMfc0/Je0PVMLRIcLF8IMiVSEZOXb8JkgcDt5SNutGWqvcIkCXn2/3KUaAyDwMVPuZI449kGLNjjTgQMu5liTirz3AGCOoAdIUy0TizZ6EQabAmKQvXDvApK6v7Zxh9/9Rkk8uQNo+NHKJSDj2NZlTEeRAqUMJTO4Mt/VDE3/Lt4OYKOntpF2OdBtbepuSwRDPXplcRffuyVyemsqxPER9WdLvGfg7zK5kF//bmLIJRQOfKPCp9TtLHNe0/uK1oRV0RycNw74NUR2Py0JjbeX73VKuHd23lkuW6Iqck=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199018)(36840700001)(46966006)(40470700004)(26005)(1076003)(6666004)(36756003)(36860700001)(426003)(47076005)(40460700003)(82310400005)(82740400003)(356005)(81166007)(40480700001)(83380400001)(16526019)(2616005)(336012)(186003)(70586007)(70206006)(41300700001)(8676002)(4326008)(6916009)(2906002)(4744005)(8936002)(5660300002)(7406005)(7416002)(478600001)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 04:09:06.6318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abab5a99-5224-45d7-f1e4-08db1df88798
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

