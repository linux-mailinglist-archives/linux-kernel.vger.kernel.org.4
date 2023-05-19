Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34AC709E23
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjESRao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjESR3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:29:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D7810FF;
        Fri, 19 May 2023 10:29:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bl1BtrsvjIPdr9Rx7IKXR3S1hHrJ6sHam/vmrd4jXDUdfSF0cMRpwoMBbvMrAjf6iiRhwiK3MBeNjIB0Eomvu97zIYlH1qKdRUgw7IY5Ymiuqg7qeO0fBU8fye8rffBtReTrzsdqJKGKz+T3FH8ZndyjjW1KGXrNHravidAftdsi5bkDaUJvUa97wlAZHe9+0NGE2FitjOiIu/xFEEsvgO5OdJG2AV+ZMF/EAEsqbcaHW6FjGHWDrHrZETyiBkxhgV83aM5qChISUrTXGc1i7K1ceFrWAvYzPGqj8bRQjjJE93oB4+FrH1DYlD3kfIUmYrPTjJ8BStfIckKJBdK+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5UoFraxHPBUsLmDGAbHt7a9vEfgZB82Dtkjge2Jds4=;
 b=D8Ab2dx0HOdBmy2hPaIyUrxbYrNLwcFDPb74VH2qfDdtAc5nWAJKiFdIVeyCwZmVTQgZQmt6jVek8qrNnGkeGL86a3SybcZ7cYeRGvPgQV6q6VWgSWR7hmr2coGjFfb0bSxY7TW5bASVBZvlzfM8bsVfws+8K6XqhpS/6rkPjRDFA8eZ5tfTMQ0rwpTPW2DPZvx4JIfg2PoDB+evObsd7d4dssG1jWMQRr/Dy2xwj8AWgd1NAIfdhmpQhilRqN0MkBJEgwZjAdWzpaa8G1fNKenww3lP4GpC2eE31pyR+n8+f8uwEEifgkyMkQsU3kl0t29ATfBTqfZ0lNbkKjcT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5UoFraxHPBUsLmDGAbHt7a9vEfgZB82Dtkjge2Jds4=;
 b=g9Vm6EcMOZafNW/K2EnN/3vvtwSH69sSf6z1zeg0Q8dbJ0LgeyjiAOJYDVm+49Vykp00x4PFg8MxgKZo+pIVJRKST839gYZgHJGZYKcKHy+0ygF9H4MKcGfZcmDhFUnYdij5EY4/nO8E88HX6+/h18Y1Q2whdWfq0ySXdHCZePE=
Received: from DM6PR08CA0027.namprd08.prod.outlook.com (2603:10b6:5:80::40) by
 MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 17:29:10 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::fd) by DM6PR08CA0027.outlook.office365.com
 (2603:10b6:5:80::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 17:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 17:29:09 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 12:29:08 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     John Allen <john.allen@amd.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 10/10] crypto: ccp: Add Mario to MAINTAINERS
Date:   Thu, 18 May 2023 22:24:48 -0500
Message-ID: <20230519032448.94279-11-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519032448.94279-1-mario.limonciello@amd.com>
References: <20230519032448.94279-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3f264c-db08-42d6-ab5a-08db588e8e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTYXWZR7JIoCJWj8alrCIy/zMiV5QN1B9x9Xm1ExWKxZ8kNlGXnpmfdSTs7UcR4o7QLCxtVeCYjiNkrZtWb01gYmd2sOfclx3HSPGwwdjgL6s8eHuJckvknBR7b8DImgCp6ODoIHO4AzU85CFlX2BaLU+mhCmjY+LZYGcMB2wOzZJq9RVFbmZP98VwoQuGn9DziLDWXpJ4B4Gn6lJtDecPw25Fe0D3oVlawdbtTXt9tU567C3iQTIsSFGbZytDrZd5VRJK9rPz0jYtVFuVhHuLEc4fsrG2GItfCGTbNeVP3iquUEaEp5YiadByFhj1jG/Esb00Gq6E4G2gVmUo59zeUuVaOHrfRluDBBPydBPhTUfly9+U4cvlvloyRjFjVtTCWZ5uXyNyO7Cfd/YJipFSjQmjk3w/c10Okl86iIwUJWNth6C26ahHgVTTdwBm/FPqjP9f+wPtyAAyvX2ocvY95jeVGlbR8DXCeO70U5A1DaP4SqF9zJadp7diDsWhK/ekRrlrVyU1asZ1igdfmpozUum1EomZYwhJLc6Y6YKKceLI6YbqprvmYbD1O2FIl+3vPlDiJ/zL9y17cV96T7G3qm36JFojn+p+VP4hEMddxlh3DYiY/X1Y8PVsg6nuzSF+FrsFJR+U1Fwk1jRzRjICh+pb8fVMPQRdOb8Z58h699F75Swe78p52eZDHUhMPuZNgvAB7WBXokwVgZWDZwFsmaaycLNP2Axt5foQJA2gG8fWOKiioaauhXQfLHmeVywTgUCqPdAss5wtNHJzH6PQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(36756003)(86362001)(6666004)(316002)(110136005)(54906003)(4326008)(70586007)(70206006)(82310400005)(44832011)(5660300002)(4744005)(2906002)(40480700001)(8676002)(41300700001)(82740400003)(81166007)(8936002)(356005)(16526019)(36860700001)(7696005)(2616005)(83380400001)(186003)(1076003)(26005)(426003)(336012)(47076005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:29:09.6692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3f264c-db08-42d6-ab5a-08db588e8e34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will maintain the platform access interface and dynamic boost
control support.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f2e19f576fec..fdc923bff7f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -988,6 +988,17 @@ S:	Supported
 F:	drivers/crypto/ccp/sev*
 F:	include/uapi/linux/psp-sev.h
 
+AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - DBC SUPPORT
+M:	Mario Limonciello <mario.limonciello@amd.com>
+L:	linux-crypto@vger.kernel.org
+S:	Supported
+F:	drivers/crypto/ccp/dbc.c
+F:	drivers/crypto/ccp/dbc.h
+F:	drivers/crypto/ccp/platform-access.c
+F:	drivers/crypto/ccp/platform-access.h
+F:	include/uapi/linux/psp-dbc.h
+F:	tools/crypto/ccp/*.py
+
 AMD DISPLAY CORE
 M:	Harry Wentland <harry.wentland@amd.com>
 M:	Leo Li <sunpeng.li@amd.com>
-- 
2.34.1

