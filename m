Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CB85F700B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 23:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiJFVPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 17:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiJFVPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:15:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC6CB2750;
        Thu,  6 Oct 2022 14:15:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBb2e6P+uaU5XP1SYH5hNx2HU41AbOWRbxP8OQNe9mi1iTzzyhuBOTMH5XlNBbWIqvpckn+N07J5HN0W1Ibgj3PRSToV2O9b/g6xg9GJL7mOHsjBYB3CGZSe2CkJLewzLSaMg+EsYBsU57eWERlBYs4zL26Fom1lU8MOcqv1FABP9ZcDOYA+kELrnrgRCn2aQhL3wAGSBE4SyqDkfLTgAMezVaz5p1YL6sFyUffrNpGSSC1YG8Z90arpsV7HHa8J3ZJUT7UdWouj3YTNmJiRWoIjleag1+DH0lSZQM6vq22LWEAfZih4eYUvPRDGe/+0MoBqWZ1kLx2l8ICiCDro9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maX4mYvehbuo12wjegHuL2ktqbIYoLngxo5lvp1Y9sM=;
 b=NUdQda8ZJVYGPM7BFmUBY6rLb8DMMV8Pt83CixQv78n4X7czeb3RreMpMpJIvDChiRhIJI6tGmGhta3PVZHAcKu1uoIvfE7kEXs0iIe2hnbz67GnRoTLEP2MGp+52VJlB/7qjH6ALqDPu7mUh29XibVKo5E1hiUfLn6WudRWvqmS+XJt0YFiAY4K09du1GV8zdCWgVGVrgVds6eKUh3Z8OaY4TFeKUNaOPJY3HFdGhnZnnZmu28Fmxf2dCmDkiJRfH8GsQfSErCQu7m9a32TqqNxsdzCugU4J7dOnI7N+T6Y7wOLvzrp1aA1ViDbrU/8bFgQI0dnD0L3KBkQ3r2O6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maX4mYvehbuo12wjegHuL2ktqbIYoLngxo5lvp1Y9sM=;
 b=dZws2jvWhQ52kPbBmND9tIEu1swd/Vmofqx2pGgcOn/r60i1PFR5ZFtk4PcnPDYhT5sBDlhmZyBYbSO8TWWPu5clFC5Khexglg7kAEHkWTHF91kgY4YgciSI4B6bxS3ost3m6dg3FIE9VJ/X5dSrJAq5/rUHdLaQWI4xr4myQtg=
Received: from DS7PR03CA0156.namprd03.prod.outlook.com (2603:10b6:5:3b2::11)
 by DM6PR12MB4911.namprd12.prod.outlook.com (2603:10b6:5:20e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 21:15:40 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::5c) by DS7PR03CA0156.outlook.office365.com
 (2603:10b6:5:3b2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Thu, 6 Oct 2022 21:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:15:40 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:15:38 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        <mika.westerberg@linux.intel.com>, <linux-usb@vger.kernel.org>
CC:     Mehta Sanju <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Enable runtime PM more broadly
Date:   Thu, 6 Oct 2022 16:15:27 -0500
Message-ID: <20221006211529.1858-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|DM6PR12MB4911:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ae2010-bbf4-4926-83f1-08daa7dfebd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8mXVDrbmlF6m+Mj5RhuZfpqLZB0NDULQwoG7S3aNhzpgX4NhtcuG67jPYhia6HhoC+stdI1aCJbolLR0O8sjaMLotJbDUY/99XNamRc6UhndS4xyTcmGdwY/Kx58Nhw6daJcT1nNU2ruNTzMacSqtXtFc1EhBFf6PJG/8NPjmh2RS1mPPV2UK5RFjah1FhhTmalbDmZVaXi6KFcd8si/KoxPzAFd+x/o5gNBKvpApmVDh/hUtBqWJzE7cSt98Gis1D6iQNlToPlXvZ6unumyYs9iZbgOW7sc7v7WYvTZf1GzcX00jqZKpVBnuc6n/3Ku6pZnhOiBt7zKzYPwilR0msiZ1C9+gWYtCG6Q6GXiktqSarWOAXwFwxhzX8n1y2xDuiORP3GnGo+dSnoZF7xcH4gb99cv6x1akEtUamLpqQvGXxIAAlQBlpvLlyNYUDlRJ2CHgfGnln8k7WIHzoJKTp+yj6zcL3MZ6S9kHprGH7IJ0nIn8v7Ca2jRrKSbqV/QX17waQ7jfWJsBPAqkb/cBwN46IzF+W29nPoPspBmmJ6alEk1YcRZYMUHZkgJQaUI1iaOrIlBpTCAGd73OxLkdmqJpeWQYQFY4Ovrja/0Fj/cSbFQ7/SQhaoQ9Ffcbd98NQCeTi12TCCzzFkpGTUcpH6lw8lLtcCxfV5YvPmE9+LEGQdqyvq42KWh8uOrQTR6UGSX4J1TpBOVUTHVUjV20cfvGvaVx9D8F7HOLf5NTHNDVrU8sCAIx0+NhiTXt6I5YWooM6in2pN8N/2pjrt2cyH/gDE2PBkNfnBv00Gc0t1k/nDiwg60OkRLKwUVrmtUEVR69sH7hoEd0kEnTBs1Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(36756003)(70586007)(2906002)(44832011)(26005)(41300700001)(8676002)(4326008)(356005)(40460700003)(336012)(81166007)(16526019)(8936002)(5660300002)(86362001)(4744005)(82740400003)(82310400005)(47076005)(36860700001)(54906003)(110136005)(70206006)(83380400001)(2616005)(478600001)(6666004)(1076003)(186003)(316002)(426003)(7696005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:15:40.1240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ae2010-bbf4-4926-83f1-08daa7dfebd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4911
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently every time a vendor introduces a new USB4 controller changes
need to be made in xhci-pci to add the PCI IDs representing the XHCI
controller used for tunneling.

Due to low power management needs every single integrated Intel and
AMD controller have needed to be added.  Recent discussions have come
at using the xHC interface version to decide that runtime PM should
be enabled.

v1->v2:
 * Drop existing patches
 * New patches to use xHC interface version instead

Mario Limonciello (2):
  xhci-pci: Set runtime PM as default policy on all xHC 1.2 or later
    devices
  xhci-pci: Lower the requirement for runtime PM version to 1.0

 drivers/usb/host/xhci-pci.c | 53 +------------------------------------
 1 file changed, 1 insertion(+), 52 deletions(-)

-- 
2.34.1

