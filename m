Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901B76E999C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbjDTQcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjDTQcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:32:21 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4361C2D62
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqwJ0ff9P/E4lhbI/RX5YtVb3/hynLYwNARWvX+N3Y6lMzLiQR0/d68zBxrQp+itiKYXeeMhx+RIt+dVzr4ow4rW2GqIhBtmfCRGp3tveg5WFx398hwcILV6TVX3ud41QCgfpyPv3hxXPwaUwGLOhxRroaBuxJbspor4HHGDHDQKApa+fpjZTiJxWS0tCYc479FPYm1s8qAPUiz3yeud/CSZDxChzlWmDnKSyqSnAVWRE4Z+upq9HjzDPM+ptK5W34ZQYmF5xQcUjgzJO31mr6H4TM4Kecf9kPefl3ScvGNYHK4sR8iO2+DEbzPohUUWgjDIl7xGiSo1nNBeM5TMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHybiOC7Pf0gITiZl7S51v7l9OkBzy7ZYhRpPscQGGk=;
 b=SEHRa+dYY2qefJuRjjZycDP5Mj/9A8mT3+nxoxwArsMRlA7St30YXRURbeReg8p3rnmbmIZDJB6HaPofVV3B24Agtpbr0u0tFdrxAjigHkY1I7ma+n2vmrEGhMe+bDKY79yHjImuiHEJssjHfUPswVPJwDRzAFQKghlsH0t9ExNuDG84SVSdIF6DSktnjUbmIjbzixXb7Sv7vkyjiqxu2RWUPZC67Z9nn2w4+cxP/Yjdw1PgcZWnwGeowR8P7u6dFrCnabBIJUWjZKh6uv/SggE5w/3nP0Oid4EMQx22eG6RblAZPOcNLVvI6tD9QCvbLqwMJ+zs6EhWPt9rYhR5CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHybiOC7Pf0gITiZl7S51v7l9OkBzy7ZYhRpPscQGGk=;
 b=aOdCI7TrxspmSEOcIPBJQYlDziFcaourBhppYaahXBXOSS2fBaUDJFiVkRN6e3K1KTluayYCfSe26rffT9FhVhVn4ZmJW5LQYxW0H/gnmC1mvaTpscJuvPaiauiP/1oKI3F9v2F5/Lbyirz384HZDTKR0zoMeDSxufqQ8rYWuQ4=
Received: from DS7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::15) by
 CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.45; Thu, 20 Apr 2023 16:32:12 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::bf) by DS7P222CA0012.outlook.office365.com
 (2603:10b6:8:2e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.24 via Frontend
 Transport; Thu, 20 Apr 2023 16:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.23 via Frontend Transport; Thu, 20 Apr 2023 16:32:12 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 11:32:11 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        <linux-kernel@vger.kernel.org>
CC:     Tom Lendacky <thomas.lendacky@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        John Allen <john.allen@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 10/10] crypto: ccp: Add Mario to MAINTAINERS
Date:   Thu, 20 Apr 2023 11:31:38 -0500
Message-ID: <20230420163140.14940-11-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230420163140.14940-1-mario.limonciello@amd.com>
References: <20230420163140.14940-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: d7539bf2-f8a2-4da7-9a52-08db41bccb3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rbpj9Qjvf3BJpXLYy4HVVVFKRGwAQAXB6YAK8GVLYqNShRhmrLdaZfrWUbFBo0Afp+Kf1a5X/GGXmOwEm//AFmUkn8f7GbWDBs1xu92fxmoXfDBp8vwigzgDfawkvZhMU38IefeDNMEZen3nUujkEVpqVEzzd5nBohUotIakCDybAzzYlKAL7AjvcwRnJ6pYHGpkALBW7kJkAgnS21uFSBuBUUXwpWq8snUX/dLC8T46Si41aHSOE9ecj0Hf04sfraPTDGxHmooJbF/WxbArZmGEY0dkEh6R0r/DWNMUkw6ttMPUB2PXsmziqqfTVCBQAn1DVs4C16F3SYfxxSkBw1Ev00lUgxjkbsLhOwrQgXX/TcEVoZOJMBsirN77bcfZ/7enZyNjXTcjI3frnpP4SjIJLDHaLxbt0U6Ix5QVQBOn0N0AN8zutKf9+Kji1tEY6cG9s2UhxXaHTjkUkZkrCLkTyWomNU0/WTQWMzRWfSupND21nXI1LyKzBz31/hbj9C5NjBQtfEtjgrYI7ogK3CXl9MBstUP8Jp3ZemNnmyacm7UB4NMbjOkd1nC+k98/iu67xLEihDLHaoujGJ+IXO9AoccRfjcm4UX3KidVIw3X6/FsNFP3PNT2IDWjB8ImXgS878kB6SiKO965GehzkNZDg86NbbwebrLkjtGu1OTRMVNOdeLB/wHl9FPz++YKxk3jYP/a4v5TdIhO9fdNVvd96jv3Exvwz8F7TT3Iar4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(36756003)(8936002)(8676002)(40460700003)(5660300002)(4744005)(44832011)(2906002)(82310400005)(86362001)(70206006)(40480700001)(478600001)(7696005)(6666004)(54906003)(110136005)(186003)(2616005)(36860700001)(1076003)(70586007)(16526019)(356005)(316002)(82740400003)(83380400001)(47076005)(4326008)(41300700001)(426003)(81166007)(26005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 16:32:12.1810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7539bf2-f8a2-4da7-9a52-08db41bccb3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 45ee4e6faf9c..9feefcca232d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -980,6 +980,17 @@ S:	Supported
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

