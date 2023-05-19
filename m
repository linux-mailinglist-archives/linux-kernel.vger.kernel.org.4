Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E1F709E09
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjESR2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjESR2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:28:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2F3B3;
        Fri, 19 May 2023 10:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5U397kR4p0UlxhDEbAfuDx8uC6kVHCh0TsWoiric8oW1JClYSxXChnUAlBm0VItktPS5Nx9cgRAbvZ+kpiaOdWMYNae8JpWi892VnRyuHfDj15Xh6RxcB016MNzBlUNg95am6PcraemXEWBYWw2ZYQId0Vw3dbs/cTG4sAsAHmLsCtFDdqoDBJ4wM0VZQMQpoYkc5scwrQyzME5wxz8uXqgimq1loSBG5I4LSzkVtM+CpUReCCQydQW8ufK9Ta/NN6Ic5oddRy8Duk9jYATUvxNvcR01eA/QPFvoX2GH/qGonTJzCuFVwFJf/rV8j8kbfQ/ajHLOvsrpoyQnzvPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWBxiWxuo2BmIiftIHSQZ2YW1Vf9/Vr/W0tyVaBRFmc=;
 b=PjTW/kNFgXXVYjDch/242OpgXe1Vkixvanek56L5zI6Wfs23H3JgQn5Lob4/OqmVYrU+z+Ve5jT4omab1CDfpuOnOlkzzXVkhAfz6S6WwAiw0kuVuTvpKJDHC6du+lGbXHSeHJk18pHl4oc02MQAwN+g2Zq3oct9hew8dT6NrjvA2zLdGGZ32j6N+xvFFUpBT2PdGEGtTRQk9G6fvLb8cXwlSP8bt27heTVapTcbEyDabIp+hp70i4xwdGQVNOAEp79DkMvDoRqRCZHidqtYf+XhXsqjttkUMYuFCVu4pgFOYPO20H/NOUrfrzyrzCeMt/vNdDZvClOAyZOSObUxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWBxiWxuo2BmIiftIHSQZ2YW1Vf9/Vr/W0tyVaBRFmc=;
 b=2OJIB2gIYo/e0MOJMXslDlBC6CuQeiTFUqesedTgMkBy9nu0N2hK8tdvrTz4qXxR6SWVqiRpXfVe3/V9NQT/Q5MnoFbOUonKdVTsXRq6rfp3zvtC3L/p9EOt6HYaiOR9StOzo0TO+mWhH8cwEQTAcYHZMMnKM2cr3fWTdcPWwqI=
Received: from DM6PR02CA0143.namprd02.prod.outlook.com (2603:10b6:5:332::10)
 by SJ2PR12MB7867.namprd12.prod.outlook.com (2603:10b6:a03:4cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 17:28:29 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::22) by DM6PR02CA0143.outlook.office365.com
 (2603:10b6:5:332::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 17:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 17:28:28 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 12:28:26 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     John Allen <john.allen@amd.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/3] New hardware support
Date:   Thu, 18 May 2023 22:24:11 -0500
Message-ID: <20230519032414.94247-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|SJ2PR12MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 884bc1d7-a16a-4c46-f158-08db588e758b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9z0z4x1zHSDcW9Ung8Zb5Zq+KZ4kNtLppFGYoH9UudZG2/IXV3y4rPlcTlpt2D5W479uU/Gc/hoDkWJY1TRVGmOGDY3BEF9BiwmhgVZXlt70VYRevjQoPRHyeRdW+NfFtZhXPTU1yW36bHQRaXZhg2MNh30uvL5CLa6fD7bUgJY6RsJZuU2IhHDcSO9yiWnIW9OOfOeCAiHA5IMCpSWlmNO4ztmgvuf0eZvs8hXybkqHhzw25oWS6vKLsRaUC9mVKmP5mWwFgSJp8pPwIWQ6/nyhV/NuVkKhuVk8q24RYiqUR1/vuQrALZxHYw9TWyM87kaKjYcj6ScPFYBPVrAKmRngHBVkAeaphYUdT0lrfMErIhjHOOGGQtoBp69ssLtsv9iTKxlRZJjEYdu0/boGuq+giKSCPp9mZibxbKCJ61dgunt6neFgonoLrSF43z9K5COVihEXxFCH+b+Y4ImOKs9XM7T4+zMMkdxPdBgXCwgdvOUa6OIH2AYkzvc2cnuWX9e5rLG/UulmaBEwN0YVHUxitDr35WsedIe6aH2b9f8MZjE0hLiywNyIq5vqujDkGgVuTWBIefLz5qhhFG+XSdN2qdR9TRXuu8D0HbF3fzdBuA9c1XohrwlryPp0hEicN8iq6NzEJdj+8UDy0bxs7mtY2zSvwubaj7sqaAVK118Igm2Lg7ajfBAaB4CDqezhbVOrCJCbGMxIIWsk4/HxOrWG4WAYW4PatKxp4BUT7Ckam6oSFdZahzOV8UuLKyt4nhALfmeE90sEhBrOTo3hWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(2906002)(4744005)(40460700003)(47076005)(426003)(2616005)(336012)(82310400005)(36756003)(86362001)(83380400001)(40480700001)(82740400003)(356005)(81166007)(36860700001)(41300700001)(70586007)(4326008)(70206006)(316002)(1076003)(186003)(26005)(44832011)(54906003)(5660300002)(110136005)(478600001)(7696005)(6666004)(16526019)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:28:28.2981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 884bc1d7-a16a-4c46-f158-08db588e758b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7867
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for some new CCP hardware.

Patch 1 also adds protections to prevent problems with
psp_send_platform_access_msg() when utilized with this hardware
as it only supports platform doorbell interface.

John Allen (1):
  crypto: ccp - Add support for PCI device 0x156E

Mario Limonciello (2):
  crypto: ccp - Validate that platform access mailbox registers are
    declared
  crypto: ccp - Add support for PCI device 0x17E0

 drivers/crypto/ccp/platform-access.c |  5 ++++
 drivers/crypto/ccp/sp-pci.c          | 43 ++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)


base-commit: f573db7aa528f11820dcc811bc7791b231d22b1c
-- 
2.34.1

