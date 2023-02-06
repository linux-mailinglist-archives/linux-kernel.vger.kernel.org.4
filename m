Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D2568BFE1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjBFOSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjBFOSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:18:49 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252B1126C6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:18:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWbymp0LG2bZSdE6xurO3+HkcJC5Cy3yBBH93b+fcdq4gVMm4hVXV+HluwLh28O9m+u4+Sot682c1KiV16i/+dDbtmLhqbOsRKMg+J/xz0wuy/Rd9+m7Oc/luncEvjp2LfmJuuJ+Faq/fSfHahNXJsVcN+OzGAsAnwmpe9crrzZP93t6ggNsUUn9Hs6mYyuJKoqU2nPxiu59j9a7tStSdlbQvMW9TA0MJWyEkQTcE1FkKjaOXmJUlPzslWSRfacCZCVzbej8WDS49hL2qeQQSELoP+KrITM/IX9zUutt1b8KJ4ExeJQcHhMvxFeSDodSpILHL18/J7zO4Ftzyn9kSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asjsGgas5x2+mw2tMimZ7RVT2m0C1l/weQRRjf0Zh84=;
 b=aqw8H0uLkoU4fCHeSvxRWnt/osEmMS1YRngyHaPOI5pcNaxowy1FD6eKrU/NFhq4HnnJPUu6U36sVuXKLtB/kwooxBfCsOL34lVbXPbLNtvNVIXBq7qGqhnRU0CoYYgNkjRHADrJyzLlfIEGKW/PMaeiBe4YpWhVk9UuXwPx40Gqk2jXOT/zR/5tTc3N/dVllQaFvIHCHL68JQ1ybpA95FdYazElwYuo5WWS15CQcstTCQjRZJn5SreKjMuBKzrM2PAwxa/89yL2hRmGTkVUN4uJA92LDGGxjRdEwQhAOAphZHby0kqFtQfXvu9ZTv2htD1j6/V3V9iDbkX83KdHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asjsGgas5x2+mw2tMimZ7RVT2m0C1l/weQRRjf0Zh84=;
 b=jCJwXCvbeHovr8ULiJy4tXXRa8HVd0AnjiI203vPCG6sWNQnFHSqmrPDjN/rjYvJ5Er4RvCDmsiiotYUtnQmQn+45syuqQB/mbxrI0PHsy6PNPcGNoteEFxZBCc6K8T3/OT1yla3+ug2PozOFvwdXYSoJzKgOKbSBtZnK1VVB9M=
Received: from MW4PR04CA0278.namprd04.prod.outlook.com (2603:10b6:303:89::13)
 by BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 14:18:39 +0000
Received: from CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::2a) by MW4PR04CA0278.outlook.office365.com
 (2603:10b6:303:89::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Mon, 6 Feb 2023 14:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT096.mail.protection.outlook.com (10.13.175.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.32 via Frontend Transport; Mon, 6 Feb 2023 14:18:38 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 08:18:38 -0600
From:   Terry Bowman <terry.bowman@amd.com>
To:     <terry.bowman@amd.com>, <linux-kernel@vger.kernel.org>,
        <bp@suse.de>, <feng.tang@intel.com>, <x86@kernel.org>
Subject: [PATCH 0/3] Update kcpuid leaves and tool 
Date:   Mon, 6 Feb 2023 08:18:29 -0600
Message-ID: <20230206141832.4162264-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT096:EE_|BN9PR12MB5052:EE_
X-MS-Office365-Filtering-Correlation-Id: 327752ab-3830-4d62-7304-08db084d0ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6qvEKRoPgVhuIaxcPrdQ+1GdzZqaTa8zftf3ZWD5cBwMfkCOiOpz8r4MjMTncW6mJj8mWdqOdOsvzOfpYUFW84Sr1FHeGyDH4hMwUYv2E9GDLJYFbGX2hLaLmtld15I3rrdh2tYjN0OBIlRVGiW45c0d6SBusdCqMvB41w0RpeN3dNBc7Fq7gxMxJk6tNE0Q31bOQrG4bA4PKnW/ThVanzII0uVSobyWnvo0MZEnlqq2nQJBEqnMfZbPoFzpnoLyGV+M7BKO5doum/w4ILAww4REX9m1/YE4h1HK4LwEk8Pk/0H5GNYJt9HNfXigvU3ZyrbmyOrqDAtTGJfHY8d8frsuSRrrRKayM5pCJaF9NDTU9u6LtMoaP7g29d84K/7GC5W2zPxVFjF2wSeZgAyL6Rh1MMuuaMZYJWN0pPjsm/X5OeUR5CtAU77cegEdFIEmyPrPaHSI0gEvYj5myF/17NXnq0iDdfe6g3OB5Vz7cm9WI+zipGQbyDrWt26HF3O4nVXKGm+viBU8eZjP0gKfThM2Lhcm182xfeKTgT62UdvqjFlzZRtCO8K4DtbuZM0jVPBTnLU1AgZVXqIFevb0M/Wgtq6J6sIfkWk2A0Oh7MXJTD+82N/Qh02PCMz+9+MSGn0wNXMyOwnpZ8o9dcFV1jND01q4Vqn+ow4nYaYACREaCBX4HUJUqZWwF4SY9nj/K9q9loEra48IAFIqExyRi0OoS2wVggYUU1V7HaSahA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199018)(36840700001)(46966006)(40470700004)(336012)(70206006)(47076005)(83380400001)(40460700003)(426003)(82740400003)(40480700001)(356005)(36860700001)(81166007)(41300700001)(8936002)(70586007)(8676002)(15650500001)(2906002)(4744005)(1076003)(26005)(186003)(6666004)(4743002)(16526019)(2616005)(44832011)(110136005)(478600001)(316002)(7696005)(82310400005)(36756003)(86362001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 14:18:38.9505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 327752ab-3830-4d62-7304-08db084d0ade
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5052
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 1st patch fixes incorrect bit offsets for Fn00000007_EBX features
avx512bw and avx512lvl.

The 2nd patch adds missing features to leaf Fn80000001.

The 3rd patch updates details displayed by kcpuid tool.

Base is 63fce5464aa5.

Borislav Petkov (AMD) (1):
  tools/x86/kcpuid: Dump the CPUID function in detailed view

Terry Bowman (2):
  tools/x86/kcpuid: Fix avx512bw and avx512lvl fields in Fn00000007
  tools/x86/kcpuid: Update AMD leaf Fn80000001

 tools/arch/x86/kcpuid/cpuid.csv | 61 ++++++++++++++++++++++++++++++---
 tools/arch/x86/kcpuid/kcpuid.c  | 10 +++++-
 2 files changed, 65 insertions(+), 6 deletions(-)

-- 
2.34.1

