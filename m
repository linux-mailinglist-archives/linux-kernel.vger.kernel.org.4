Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D0270E6D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjEWUuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbjEWUtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:49:52 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285D5CA;
        Tue, 23 May 2023 13:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2yqUPbauRTwTKesyyK8TEeEeO8hFgv6fijR4bRbsYiFxz6BHFClYBAK7+OHBAPASH1n9IqrTnt7M6t3VY3T4Ljz/0KqTrVtwHkd8yIqAb+3hvA9eJD2scctUFTGL5T0f4osHmqMnolpg/uJVcrRyGdA3e4PwjLPln9LZ7qUx88kQGXHQ2vw74lrXy7bMK+WZbsi6rkfVxe9aiCouCeYq5DxhmPprIEg8e3mBiCBAOjWqEZIw0R6QrDKdqp1/foy6PD+50xEnsy5VXlFng0yIyLHkeiPABLKHTR0bQfEV9fKi/xG4rc0bgfUYr8dR1+uzNsKryCMcCZt89IbK+kjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cV56kIPCdd2A0YAWO0u8ugHmNFXGvSulQgIBKsmt+P4=;
 b=nBs1ex3ezOdp456i48W/M3ad/2k3wYEq6ae0UA/MIsLp87u5xVMUCAQ3ry5ddvTiHzcOvetQSOq9PJ6pkSSIM9D8BwuY/ccrkWTdHMrXvro0MTsJak6N6p8kX29HbReRxRzsaTbLxs1bhdNfIsqboddpdYNVMKqkqyeYk023XBRgPRP6GHdL0Qt9EaipAKGxJEt1TqTFJjbxaNTVmFei7kRXnoWSWmzb2FB6snEvOuS7mTf9XvDZERz1qojv3vsmTlx84UmG6fbWyydekDEZedXIG5aADA0kJFVVA6krL9grFVSVFNtO+uE5kiTXc6jgwfYzRtBZnJOuezZHvoKZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cV56kIPCdd2A0YAWO0u8ugHmNFXGvSulQgIBKsmt+P4=;
 b=m/XBw7YWPhp5nnWlfop7DCz6FSuL9VcBMiqsYwtvkf1QSGAtVOzbOWZnWLz1HS25WqwWMRNWHm/ooyZjmENSJ/dTcT8bI4dxO7eGGYJjl6Vvydgxj6vYLyePk6MKvdL0DhdAJHmE4iEHOS1jD3SeYN2KaoYaZd8AfqJbagNrQDM=
Received: from DM5PR07CA0100.namprd07.prod.outlook.com (2603:10b6:4:ae::29) by
 DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Tue, 23 May 2023 20:49:49 +0000
Received: from DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::73) by DM5PR07CA0100.outlook.office365.com
 (2603:10b6:4:ae::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 20:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT087.mail.protection.outlook.com (10.13.172.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 20:49:48 +0000
Received: from amd-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 15:49:47 -0500
From:   Baskaran Kannan <Baski.Kannan@amd.com>
To:     <babu.moger@amd.com>, <baski.kannan@amd.com>, <clemens@ladisch.de>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwmon: (k10temp) Report negative temperatures
Date:   Tue, 23 May 2023 15:49:32 -0500
Message-ID: <20230523204932.2679-1-Baski.Kannan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT087:EE_|DM6PR12MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: 8575b808-95f6-4206-ee69-08db5bcf3fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QhOJGyBtLGWiqB+WMmtyAOL92INwEPO7Ae8KccFgpr4boKQ6cGoJVatdXUiwURbwXNei02CR5pmehLB4LbWGYzxEBaY6IrFKcY/NPoPf+K1GkhAzRXj3nk31npglP33KTM9kWl06os3CcLGCiSS1b1hVAk/E5I5Azcf1UDej7rfKt3LM8QsghxcrouMU7cuN1RChUpMR8iDEWVnFb99+6GufVvjxfm2sCjlbq6SGunki9heCIjbGTjJr7IwFoHgTBMGMmH3CBxM6jIvv6nGtouTQ9ueDh82UvI3jBcu6JemcxdUmQWuQF9xdonGsrKUqVvI5yeLKJ7gmU03nO+eARGnBa/0JQsCgMzth8SlaF64sK+pjjfHtOHVdfkXGDtlKLChjbEpOE1epBuX1ehvBWuCpWbihGkuy/9oDnyr+VeSyIynj52mhQQl2qz2ZlsgaX73cHfn9/kqJnNeJzFjGAMnSyGby2oxbPgVAZDTMwhh/kBCbcYoWp8VhJRXm6wGCbJfZqhMuWOWfYlbN9lsE4LdU2OIp0D95F8rWTSqgM1rBZHiHzommJlwHacfci99PN1kslK3xIkUUvxXkqWZiop4vmSMyNRKcJIgAm7EIsrB1kQnt92O/1A9+574PPI1eCX5PP7MoMdDYaDHElyifnduzcLSUzuhvaYPjgFP3MNEv+A09Lnbj9msgUxRHV3rhx/pVxvc7KeCpaHPYNE3DUHI7+44wP1215YayP1VcSsSphhHKsWruw6GJD4wE2fHBNMd849xX3r3a/3k4vebO1TbSu/Z70yI5MNWhO4mlpOU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(8936002)(82310400005)(5660300002)(47076005)(36860700001)(81166007)(16526019)(83380400001)(186003)(336012)(26005)(1076003)(86362001)(2616005)(82740400003)(356005)(426003)(8676002)(40460700003)(41300700001)(7696005)(40480700001)(6666004)(70206006)(316002)(70586007)(36756003)(478600001)(110136005)(4744005)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 20:49:48.7193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8575b808-95f6-4206-ee69-08db5bcf3fb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4926
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the tctl and die temperatures are rounded off to zero
if they are less than 0. There are industrial processors which work
below zero.

To display the correct temperature remove the rounding off.

Signed-off-by: Baskaran Kannan <Baski.Kannan@amd.com>
---
 drivers/hwmon/k10temp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 7b177b9fbb09..489ad0b1bc74 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -204,13 +204,9 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 		switch (channel) {
 		case 0:		/* Tctl */
 			*val = get_raw_temp(data);
-			if (*val < 0)
-				*val = 0;
 			break;
 		case 1:		/* Tdie */
 			*val = get_raw_temp(data) - data->temp_offset;
-			if (*val < 0)
-				*val = 0;
 			break;
 		case 2 ... 13:		/* Tccd{1-12} */
 			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
-- 
2.25.1

