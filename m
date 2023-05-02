Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0316F454A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjEBNks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjEBNkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:40:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7AB72A9;
        Tue,  2 May 2023 06:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnJ8Ojl2nc1zphi9RL6it0rswYGTZFRmZwvandz7cgDyd4fyH62cnkYLkZhQ9jeV94ztWgD1jKEYvAYPmIaJgXdhypsczsIG3WoHmIhAV9JgBGYI2pP3kywsnjLqFtmmw+VJ0O6IiPcjOtJHbAh6xGiDBZUdYhMkKrlU395jBj88ldKtUsn8yRlbzCuu+g0n0dBDcNtnvrSYUesUhkx4YZa0oVGE2PXggafTH3oeKvkvmJFXArRV7+Y2XidbFc4TucVcsObbXwVYqjXr32FNs1fvCkPCAlxS6iXf8F35zbPhrJHoR0qlKnaEBV+dkWf7PIQiNMgc5tnidNNGxRfnNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO5nCZf9Lf4i7CviExrPaTIb3MQ0zGbYn8U+OMpcmPo=;
 b=BrNwn9rp14N4wcEQgm4+EepFObyoJGZGGgZOI0WFo7pJ9WBDqPOHRXa+7i4Gsw1qRib7VMmm5su/30QSIGWXIF6eF4RtYHR8qOZmHDTwNsBqHLoHEyhpMRyaecIcmiar/fovDe9eoP6vFa+eChA9A5OvtUVrXxnEzPwEDtBSKAKE1EIxSpHwTzHQwkKA089uC1zM9U0hrOvLc6YWUQR2lkQlhJOGI07Ub4Xxu8F1LNo5+J5lCd29hx98NZTrIedNoTJ8RlwwzmGC/00olqWnIgYCPS4PyyAQSF+KwmoAqxNqMbxiEFovgfHN8d2zr9U+RUZgSTNpTi8avXRDFCFQIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO5nCZf9Lf4i7CviExrPaTIb3MQ0zGbYn8U+OMpcmPo=;
 b=35dL3rzbr3myJtPhP48sipuHFKBDu/NGp25e5eGQs1gqZyfvP+64ys2T5LPE1FP62sqGm7InhSJVpNE2t3IKCNxTi8W6OB6ftCaYdajErph+jyyO6qYs7vC0VvGer175HhiRGOAgo9QAfnGr5DxmCwScSKrm+NLgRtKdBmCRCBs=
Received: from DM6PR02CA0119.namprd02.prod.outlook.com (2603:10b6:5:1b4::21)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 13:38:31 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::6c) by DM6PR02CA0119.outlook.office365.com
 (2603:10b6:5:1b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:38:30 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:38:29 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 14/23] arm64: zynqmp: Add gpio labels for modepin gpio
Date:   Tue, 2 May 2023 15:35:42 +0200
Message-ID: <12b2fcd94e528c8ca7117f6741aae36b5942b430.1683034376.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1683034376.git.michal.simek@amd.com>
References: <cover.1683034376.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a39123-dfb5-4b0b-3e40-08db4b128478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FKyPRZhx4bQ0DjogRLszuQYhklyYft0cKRsjPQQCCZoT4WGtrXcM/4JlUorC/8mG38BV+ZBtKBXbORVPCPDzTb9CAlohNG9rxvV1ZPKNsXJnAYuz/K1ADyV8aqmPM3LxEMwttFKFEE5xHGpgUE2LSmb53EMWNb5XkdmHSP4uHd6uujXctPtzmcxTT9r8KQpzsorCbhGd18ecwpFSE/s64m7eI74d5kUNgPK63fhFMrKtrz/CNkVw2AC96WZHgKGSKQhn5zsaqb076Y7vFeVKVvHGmxvVKi1vKz6F2w+tSKBDBb/t9pBabQ9LW2aZyC2qZlTDwip44tkNqQIWfmUXM23zLuIw+PCQFVpTNTAwLvIoAu5h6IuiqdjfzuuHO0zDlJVs1XyCwtuOOjvjUSu7oM+JJ/+ogIcEtzftbWVbvDehoHfs82+6aSWdkeO9e/azmlzaeeRhuzWN18xH94ykrlZzQBiO39eBSu7RzkNNbF71xrB3TZRKo1NyECQYI6tJAduAgMYCSt2wvW4gh3MwEECpXlMg/g1FzsCJFxf04RODkqf3IpFmabaTHCy2Z00sEEyD8h9Efmpz4SIX2f69KATWvQiwkWlHsy/Kn0kcRZpqDRaVdK55tZ6Tz9MPX+irWsa4UkvkAb5z5SGz0jyBkoNDDXfzypJmb6MynHjB+jKkb7JDX85aUzrWwWqsdH/5ygA3WvL9XkLjv+uQA7/rEx0sTlmNdVUINLz5hERvdEPZpZU6oeitct/jhv485Kkh
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(356005)(82740400003)(86362001)(82310400005)(81166007)(40460700003)(16526019)(54906003)(110136005)(4744005)(44832011)(478600001)(2906002)(6666004)(36756003)(40480700001)(186003)(26005)(41300700001)(70206006)(70586007)(316002)(8936002)(8676002)(5660300002)(4326008)(47076005)(2616005)(426003)(336012)(36860700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:38:30.6087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a39123-dfb5-4b0b-3e40-08db4b128478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using label helps with better chip identification.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index cb3e5c06fdc5..c206021cccf7 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -77,6 +77,10 @@ ds36-led {
 	};
 };
 
+&modepin_gpio {
+	label = "modepin";
+};
+
 &uart1 { /* MIO36/MIO37 */
 	status = "okay";
 };
-- 
2.36.1

