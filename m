Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B730274DD80
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGJSj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjGJSj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:39:57 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56684C3;
        Mon, 10 Jul 2023 11:39:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+/+U7zdjS55GZpFF9aS/Wrqy7wxWeV8N8EBI6PE/uSOUd6PO4bGpPZACagqhHuCR95Sj6J4svBLDsTmtNTveDGOZ8PVGlCyOud8ujgiaGLl3MDzc2Ketn4Ei3ip5ku3J1VbsXz091cvLpPaik6UTqSVFMKoV2T8oVNEDCAkpb83QcccJzj051af8t/tB6YeZZYvqol85r1XsiU0x8FNsFBwpUQQB5F8yi0yL3lfctbW/GMdUy7VwAOqe0AJhaLezc1DcNIW84hm48RMY6WBJQ1Ji5IDIDTXjw0hjXNQ6/CMJEJi0jSm2YuGwQ3FBMhxblNwX1NrtrrKssJX8zSUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ULjpCDQ0pBERaFXFLVCOuSmApafDhJZrCo+tHReoKM=;
 b=oJnXO9L+UZtXOmfLVW3q4LWEoG71XzmDQ28SbRckciZqaCsXa0yeE8ug/vvPzZ/9ImOn6J//nbn4Y7tyWHH+1s/kOaD5U2X4GqtptL8JJ7Jpj7bfRCKlPPkck2zgOsHqM2utIRLX84OiBNVU+XXt/S4R4KrdORfM+kWOUO3W01bIZe7jrgBvxM10fCdkvJERHV406qIdsfSeFjWtkHiYZagGQhgMMZFx1Wtpbn1IqZw+96HcpVbZrwIeRzUWYSnJeYWtvYE9h8cFf9B+XIf8owvdkkPsRAaNmYL4wZzRO1eYKRJWZmln9XoLkTbNz3u30VpHK10BOATcThgIzu6aAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ULjpCDQ0pBERaFXFLVCOuSmApafDhJZrCo+tHReoKM=;
 b=jGrLbwB+Vo40cxjD7cjFYDN5bwLSH90/PMABmqmrNNR28RFJoPxM19pFP5MvUh98Sg85t123Q7RldIsMqsQYwqklevCEXM6RFtTqB4sSTlVm3FVZBy4xpGjEzup0jnZceKSTpDXQFpwlVfl2dnAXC4ZGIb1yzop5/0mUYvWQfGw=
Received: from BY5PR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:1d0::24)
 by BN9PR12MB5180.namprd12.prod.outlook.com (2603:10b6:408:11d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 18:39:53 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1d0:cafe::1a) by BY5PR04CA0014.outlook.office365.com
 (2603:10b6:a03:1d0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 18:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 18:39:53 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 13:39:51 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Mark Gross <mgross@linux.intel.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 0/2] Fix s2idle resume on HP 15s-eq2xxx
Date:   Mon, 10 Jul 2023 13:39:32 -0500
Message-ID: <20230710183934.17315-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|BN9PR12MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bbecae-3427-474f-31ce-08db81750d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vivbQHqSAklk9e4yrMvElcUpzFMLDob8uhAGotC8JrI6EzRiYEH/Ig2Fvagw8BWPUmM8XBpWeE+4aDqzb0iknMd2+bI9bIBraOAB7+ZiKOW46XiRRS5mO5k22vqpu4vGEaQVRkv4SsjQqWGFoAO1LfooN6bhx1pHOycA81LMGaqllbGFLCQdpE6JI85eHxUNUqyTCzEkc6GkewItXmV99s/JItl3n/SyCeh2wz+ghYcga0GEtfhr0jVLoNldDRK9DtpzT+0YXVTZk7R4S9pNhf4gsr/njPhu5n6v7+bA132mt+hqA0R9r6R8eHciy22rxsJJJTINDofRNLj5VZu1Cu6h8RqGp2kE4A2ci2j4thYjNd0Qn+h6j3NqA/l2fB9GHvD/GLN/GoDqzVAjz2EsUjFn48Uf4MCvCQwgexFKsM398fFd0iYIJZb3I4DcKPgJh0RcFs45k1K3DuAU5NoSy+HX9teHBx+ZTxgzUJJazJIHIrMbMNIGiFu4MrkOUNsZHb+8/wsXQt80fy1oknZAcktpjaxGQLtIUuVBJTBTdcQ0f8HkNIIrP9kpWJlSvnmBscNK9m9EK/uKmQkInQSSbb1BEQbDpcGg9uMt/jxjn75HHdGx7p8CQm0cd9F7zkE2BW1D1bGlOALLsssNAEyY2sl2Z0H5aiGTF/n6Z6VtjuYTpNvtl1A5KOpaVjy90xvFZndGICrnDhObQOg2UbKctMgm5FBGTYq7/XOXWvDWspdWMm3JFEcv59RAq+fTF8DsAWeD3j4nZSnEW+pe5B72Nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(7696005)(478600001)(83380400001)(47076005)(1076003)(26005)(2616005)(186003)(16526019)(36756003)(40480700001)(336012)(426003)(40460700003)(36860700001)(316002)(82310400005)(2906002)(41300700001)(4744005)(356005)(81166007)(82740400003)(70586007)(70206006)(6916009)(4326008)(44832011)(86362001)(8676002)(8936002)(5660300002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 18:39:53.2663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bbecae-3427-474f-31ce-08db81750d11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5180
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP 15s-eq2xxx has problems resuming from s2idle when IOMMU is enabled.
This is the same root cause as some Lenovo laptops had where IOMMU enabled
caused issues with NVME during s2idle resume from a problematic SMI.

To series fixes the issue by re-using the same quirk developed from the
older Lenovo laptops.

Mario Limonciello (2):
  platform/x86: Move s2idle quirk from thinkpad-acpi to amd-pmc
  platform/x86/amd: pmc: Apply nvme quirk to HP 15s-eq2xxx

 drivers/platform/x86/amd/Makefile     |   2 +-
 drivers/platform/x86/amd/pmc-quirks.c | 172 ++++++++++++++++++++++++++
 drivers/platform/x86/amd/pmc.c        |  30 +----
 drivers/platform/x86/amd/pmc.h        |  43 +++++++
 drivers/platform/x86/thinkpad_acpi.c  | 143 ---------------------
 5 files changed, 222 insertions(+), 168 deletions(-)
 create mode 100644 drivers/platform/x86/amd/pmc-quirks.c
 create mode 100644 drivers/platform/x86/amd/pmc.h

-- 
2.34.1

