Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EECD709E08
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjESR2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjESR2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:28:34 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADFFBC;
        Fri, 19 May 2023 10:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZrguVHrmYErYxtd29Huhph1aXDrTMzXiCjMq75ywSgEGOF9O05NSExFatA8P84gkte8f/dtdLEdsxKCpk6moBiSFzgUqBt9NxobH4Jh4enodl22AYZ5GI+Q3bDpgusXK/CQ/LZULMgpv354t/bzKL8KeK03ZcjDfox37xEvaBFiQ0OVbW9AH1ovg3g38KciIZPggUeigg/l/9GXrZ4r5WfbMWnhK8vrsDNajXPxTpD9dG5UydAldFsOo/HgtFREE9auHsI9iHWGKVDlmlXakLR4EhdIy5CWzt1Ppw1/Q2F/iEd/QYlcqqV7gbkcZwrsyTnrO5Z00VSLySonf8NYMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xISGo/DhlU67XWiPpElk8BO8w40MEfpTWkofp4Jk8Y0=;
 b=Rta91m8shJsC+69UWLTJcQ5nSqKb3l62IxTTf+AiW2zZiKA2IZdZ615SwQX6w6q1w62jCgBPWPT76mlPubJyAjklZP/aMwfA2T5iU7FgMIYYpFgGStnxSlGImVqLHJneSI3G0udddXgq/nMiURFosATR0iaeNGwkFwLuorLah7+EUp767HfgawZcn6nh+cJThfwBJ47ztfUcCDn7OKZnxCkDlLu01YXdiYtlQkvbV1/Asq6pFzKUWBViEpVShA2DrL5fZFBFX0BUek7JuJQMIoZUBLC0MLTPMY84KRHfdSpcdo1J5ir58qoZlbxlXpoJ3i2tC3QF7dvonIoFLCxAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xISGo/DhlU67XWiPpElk8BO8w40MEfpTWkofp4Jk8Y0=;
 b=uZz06JUWBiRyxhYs2ZlxKSFg6Nl6xT7mvrw7m3hdmCpoKXQGTuv84VAwA2M7cjOpbILaQFYhmA+L0Hl3RiwERGkhZO9Rt2MnZKTpzFQcpvIMSHvOE3N2/EplNuJQuwA9GQp6rZ1rI4G9+AWhf//tKj5sr5xderRY+qqHYhoWpK8=
Received: from DM6PR02CA0147.namprd02.prod.outlook.com (2603:10b6:5:332::14)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 17:28:30 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::bb) by DM6PR02CA0147.outlook.office365.com
 (2603:10b6:5:332::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.20 via Frontend
 Transport; Fri, 19 May 2023 17:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 17:28:29 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 12:28:27 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     John Allen <john.allen@amd.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/3] crypto: ccp - Validate that platform access mailbox registers are declared
Date:   Thu, 18 May 2023 22:24:12 -0500
Message-ID: <20230519032414.94247-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519032414.94247-1-mario.limonciello@amd.com>
References: <20230519032414.94247-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: c189b4d2-5a6c-4bda-59b7-08db588e765b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnvaPjmOWTgiDEcy/zVAp85VioPQg647+PcoH8ScE4S4MUmxKR1kENygGv6NyASS9mrxnExuTw8l0EqogRixSifqBJGy9uwid9jpGomVklLI1keoVP3IozndLM8jeO6uIsT9RtOEvA7qL21J/KJ2LWbmEEt17uca7DswabT9X/X1gYUetz2jD46nM+kaPoPX3wksZ8mmqOnBbWWLqc6bVPxavr/pOWophOcCLkmEZ9UfRZ/8dJ8oXdYojMnhbiCoIYj+lh+JfyA8WLu3kv+J1bChbtcQPX7Cb8PkqZuSA6HSrJupQJMVUhD+2rNdeyUdH8oAfyMw8cyHWccRB2V8wDe4yjSOycz7gms0pPllH94qLFWoIXIxn8Ckoc8QZTG5T3/Av57XMXdJaKzBKXwssPNryVye02tS4hzOS8D3StAjEA0WwBxoADleEeiz95UCj2+xSb5/GNXv2yrZxeF3oJzqaRuTwJHtfI3hhTBBra/v5s5Wv62q1X/TpNgKPsOPzr4HNuyPd0MWZ/neP1xdBvlpQuMfRJ02doSmL8kxV1AC1E4xNk+0dDwv6GiRWV4FV9kDwlsiuAiV51kv7ePp1FnJmNBHTmPciuSMUyx2umuQw+x3EruqXSSaVOV2aQY0lb0Ff+Splmh74cnjoAqR4KuYLT228vMTEt4sZFHiGC0rYNRov/PHvXQAfk9mp/1jpV+F0blmzpgdpk2T0lUKk58+y3uaw1mNuVIQcgRmgQdQPG5Zn2hiS1JGd7Xxg88yn5H7DrCJ7XjAE4CjcAR2eA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(70206006)(70586007)(4744005)(2906002)(8936002)(8676002)(5660300002)(44832011)(316002)(4326008)(15650500001)(41300700001)(86362001)(2616005)(426003)(54906003)(47076005)(110136005)(40460700003)(478600001)(36756003)(7696005)(6666004)(40480700001)(26005)(186003)(16526019)(336012)(1076003)(36860700001)(83380400001)(81166007)(82310400005)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:28:29.6574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c189b4d2-5a6c-4bda-59b7-08db588e765b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
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

Some platforms might support platform access doorbell but not mailbox.
Add an extra guard to ensure this doesn't cause accesses to wrong ranges
if a consumer calls psp_send_platform_access_msg().

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/platform-access.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
index 939c924fc383..94367bc49e35 100644
--- a/drivers/crypto/ccp/platform-access.c
+++ b/drivers/crypto/ccp/platform-access.c
@@ -67,6 +67,11 @@ int psp_send_platform_access_msg(enum psp_platform_access_msg msg,
 		return -ENODEV;
 
 	pa_dev = psp->platform_access_data;
+
+	if (!pa_dev->vdata->cmdresp_reg || !pa_dev->vdata->cmdbuff_addr_lo_reg ||
+	    !pa_dev->vdata->cmdbuff_addr_hi_reg)
+		return -ENODEV;
+
 	cmd = psp->io_regs + pa_dev->vdata->cmdresp_reg;
 	lo = psp->io_regs + pa_dev->vdata->cmdbuff_addr_lo_reg;
 	hi = psp->io_regs + pa_dev->vdata->cmdbuff_addr_hi_reg;
-- 
2.34.1

