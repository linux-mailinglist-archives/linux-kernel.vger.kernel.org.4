Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD1C699D88
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 21:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBPUTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 15:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBPUTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 15:19:32 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1C44CCB0;
        Thu, 16 Feb 2023 12:19:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp2VQEBdh7sTOsNE3G62Vwo8Fb0gsmIN/WDLcyPY9TywHZsJ2nNwOXsgYo0Zwae8sTu5xyVcLqhoA63J+W1WZsm4ndVUkmVMS+5cu0uYkqPq9tBTCUTesImhEqVsc2Xv7CsHvLd2+hrmZgOZJhyj3j5niIkOkHVA0Dg/YTtgLmiDNd10aWyZbrQxfvm+VwOak/5+Xkun899btnuL3J78BEfUKz1F/2cTKwc2AIx7b4VRacZc4OYWtYaXhbfnkHzb1r5xfHd7fZSIduDdIkCopwrJ1MJpNkCeOR0P1bdaoNI8uDj5oxRATi28h8XQNj8lcb6Jp2bwJs/wnFpIYiZp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1M6LZ0FWArkMnFDs1Fpvra7JSqYpI+lLXgrlYMxnKKU=;
 b=b7CDIJOUhvr5fIccE3MzWtriSQoBHbFCSxych2XZTA4KuB6nyDK+Z1uN5I9lLvBnwPVza1AUZJjGpAFTijg7hERnKm17/9nhp+dY67s66HQe3j2O4HoQJnnrIIbzwF+Y8JB6Wbjsz+TlG0sfmIoX/3mT7nDxt5H1oz80lJhLe7oleotjlYtKUVhvUP1e80QqwCefZXvSRF4LsfFpiCmg9jdAdNRnXXT0V2w5ViRxSFqHnE0I3/U1FF9CBDwpmwXvHuJgvfFdIXmgETixshw9zIF2SITJjPErLCJGggR6Q1q6o4kpS7rA0TvNPyt3X3ulZMFK5tsxP64uwbLsyBIwUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1M6LZ0FWArkMnFDs1Fpvra7JSqYpI+lLXgrlYMxnKKU=;
 b=21lDff9vu/VQKoaNiUIvfJ/eHkJJZaRmlsg6jfJg/Tyx5mSLQ2PNlkdGnVuCRzLecXDMKbUGFhDzulOczfd3y2r4NurFV1EqKmyXa+OMVb+cXGiHZsfJ7Ozuut36HVZ2/uK5oyPbhfkJEEhqkdDoob6MtQgMv7tEN53CMdcCtms=
Received: from BN0PR04CA0098.namprd04.prod.outlook.com (2603:10b6:408:ec::13)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 20:19:29 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::90) by BN0PR04CA0098.outlook.office365.com
 (2603:10b6:408:ec::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Thu, 16 Feb 2023 20:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.13 via Frontend Transport; Thu, 16 Feb 2023 20:19:29 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Feb
 2023 14:19:28 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <linux-usb@vger.kernel.org>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] Fix problems fetching TBT3 DROM from AMD USB4 routers
Date:   Thu, 16 Feb 2023 14:19:07 -0600
Message-ID: <20230216201910.12370-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT079:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 39459e12-a5c1-41c4-eb2a-08db105b1b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nrn4piSV1JHODR2XxOV/Enp9/fjw5K1F2nZwSZ41IK8pjOWgqFtn04HcnSSexlS8WEsaFh5i4gEUO+KXopIPVmAB3m3NYCYvS1DRKxFJnQDCRam+d7CXbEyQ+FO1jMDhfF1yGxDM5en8La2/YMd4/PgsUiNeIgARZ7scuvDrQE01f3Fcg9b9kRRR7batayRnyTy99CB6AxN6dzbSRft/wpTxc3R2RmQRt5CBawjGMOEOUuHPe3bL+2R/LL98oXZaXSnHGj0lnvdWC0RdtonmnQRdD7VrEdrI9v4KpXD051jqzJiu9Sk7He1PKvIm9j/3hZSfT+S3aEa2uBs6IO9VPTfbADogxEFaoaCkpbbIL4TsQNtPX6L5gOb6Fx4ylWfxBWxy9Hunxg7bHuSBPguAY12GJAujarj2NPQvEoRA9UTov2UO/L9sphBiK0Oh8nF+EK571Xz4xZTanYT0ihVOwiNTiz1I9QOGAukxaGGrjv2x36D2VEGLcxYtxV6s2TeZX0QB4RXWa7VA2nJRuqGtJwGJ7laXGyYyL4cJiaCco9IVnm5Gn5dbxvtheG8QJagc4byV7R+xxlUyPEuBtQFuIpJ3pjqJiUhl/PWrdV0op9Yg8WawlUI39dSoHa4SFb72/+FyTO6PE0CuLf3SGaV00PaF4zy1olAJ76Q+71alX2gbeQ7tdO4Ci17FYQ+5xM6KpAaKjzCgbPpOCJJAPRylXRabPT4dfUCS3jO/Gb9SSw4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(36756003)(70586007)(6916009)(450100002)(2906002)(8676002)(8936002)(70206006)(4326008)(44832011)(5660300002)(82740400003)(36860700001)(86362001)(356005)(81166007)(7696005)(41300700001)(6666004)(478600001)(54906003)(316002)(40480700001)(1076003)(82310400005)(66574015)(47076005)(426003)(83380400001)(2616005)(336012)(26005)(16526019)(40460700003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 20:19:29.1107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39459e12-a5c1-41c4-eb2a-08db105b1b71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TBT3 devices when connected to an AMD USB4 router occasionally fail to
properly respond to requests for the DROM via bit banging.

Depending upon which part of the request failed will impact the severity.
A number of workarounds have been put in place to let the driver handle
the failed requests:

commit e87491a9fd4e3 ("thunderbolt: Retry DROM reads for more failure scenarios")
commit a283de3ec646f ("thunderbolt: Do not resume routers if UID is not set")
commit 6915812bbd109 ("thunderbolt: Do not make DROM read success compulsory")
commit f022ff7bf377 ("thunderbolt: Retry DROM read once if parsing fails")

Still even with these changes the failures do make it through. In comparing
other CM implementations utilized on AMD systems, they all access the
DROM directly from the NVM.

To avoid triggering this issue, try to get the DROM directly from the NVM
in Linux as well when devices have an LC.

Mario Limonciello (3):
  thunderbolt: Adjust how NVM reading works
  thunderbolt: use `tb_eeprom_get_drom_offset` to discover DROM offset
  thunderbolt: Refactor DROM reading

 drivers/thunderbolt/eeprom.c | 150 +++++++++++++++++++----------------
 1 file changed, 82 insertions(+), 68 deletions(-)

-- 
2.34.1

