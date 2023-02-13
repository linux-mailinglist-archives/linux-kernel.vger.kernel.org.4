Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CECB6952E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBMVTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjBMVS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:18:59 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761FC1F496;
        Mon, 13 Feb 2023 13:18:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoxP6OM+y5zuIFPn8RSDlyer9FO6v0TasJUq2Ed3sRBWrpKO+sP013SRWvyVWtD7FYkCeMmlR3DTxmGFNNZcyVKmS3s8MMOQ4XTmv2UDYOydp584OZllRPMiFFzpfcwx3R6kodDbI2yo/p+LsZW3DJLaadYqCKbxPhpsFJyCw8/vL6wakLF2QKfApA4TKqtEsiFu+Zn+6U9Vj53Y9wICcXERzQGpqKC98xe+dKS78misAKpVxA+tA392TUEFug8J6QQwNmVy81MErHzaiVdlh4aZgpMFCzgd5QngmMBn2xwUIENeAZOxrMuriyBWDcmxbYMkJsdbzsrdHn7zJMmPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3gZziNvmjFigbtUsTsGN3fjpYAQMVQkHxRZRECJsdw=;
 b=HkbHq6PgLA/hjpGl+X4r2cT82iaZF6uYaTDfW+71ygCPKhWFi+kEXsFy1Kuo9rmpgttkz7KiuEZmw28Ye29o+AFNZ3eR2CAEubwqAye5QBAv33LhWHwJ6jrHK6BuBrfM0UOgugnSHS+v/kBB9BaoJxyO57khFamViZN3ha/SsAURO9LEPz84VKcsqmBHY++e425SESftJxC80NIc8MjPCQ55WNg82+yF3ykjdo+hkCEfTaD8Tra86H4jJNH/K3ZTbkZ3YUv3EHOcMIa/Ej3OIqcyDPCCbs6NB/ujGJmVUJS6z2yvi0sJnnxWZFWGVTJmUz/7l2tkiNBLj5k6bfz5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3gZziNvmjFigbtUsTsGN3fjpYAQMVQkHxRZRECJsdw=;
 b=42FBd/gPy8M0AnwvxgIetBVF5yM5gfJuIbDyDNbWtraet0oV+MxJAWGiz1ZePUEC4HdyrPELNZhgvfg1lqf8Jk8hJUyRfgMf/6lMuqv1X6asjZkwR7sStXxKW5fXERlpT1WzY94QjuFac7ZU15jgkIHGiDcEb16L7kDOfJ5SO/A=
Received: from BN9PR03CA0844.namprd03.prod.outlook.com (2603:10b6:408:13d::9)
 by PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 21:18:54 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::1) by BN9PR03CA0844.outlook.office365.com
 (2603:10b6:408:13d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 21:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Mon, 13 Feb 2023 21:18:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 15:18:51 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 15:18:50 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 13 Feb 2023 15:18:50 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <michal.simek@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v3 0/3] drivers: remoteproc: xilinx: add mailbox support
Date:   Mon, 13 Feb 2023 13:18:23 -0800
Message-ID: <20230213211825.3507034-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT012:EE_|PH7PR12MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: a88cc658-27d9-4d3c-4591-08db0e07e8c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkhtighMAcq4u+iioqJXFKSQeXrIeXiU2pFKDaO6Z4qJy/nH53q1IX8ukgvuiViIGbmHHCaxhWHDDpSR8hCFfqQ2hQLrpjkdRIQBAbdAw+2BjdvRwB33zbBlVJ2+YOpHNU06rUUFpYYpea6TEAb/aVgqFqcW/5LL1hY1YiC+/uuSMdllGSRHUn1gNptGRpDAIOTOf0Z1O/f+yGAB8oclNgD+NA5Dbbl1erM1vg6jxujaNtNUw+ASj1OxLjh4jvOU0ozDY1wDeZ4+CUMsuvsZp+qYx9vEgwAqU9LNDS+nkZK0Ndtec5hzyQoD5Iw6BDIuuS7vha3bVxsqMYA/59SqZgtz7cjcw+4U6RSMoVVTuHJtuK1qwuPZyioqyxwQygl7kmnn2Ucx9oSSscpxqSL5mbPKH8mcODsc/5khkO0fSfgzEFXvWSLpe7KHXN/FdGQ1TlCoDKS7LdRyGuUZg+49aaulqeHGn/W6s4v9oPZFKIElHeTq2q6QC9Bbm+Yg5QAMkEqsHsFuZYEsMoTnEUmZoErB9GUEFu3kj2gA+/5rlrmfTM9BBK5HBVNNw092sdGCUrSeFaZjacHVHa6GS8nekXKOj2cDubnpR1BahDFtlflRpUkIEObHezgzs/6qdyvCNTQg1fvvOzozyMOgIxJ26oPTIOT7Rc8b8rpS9B2EcGtXpKhAYBepcVl10H+e5JreNRcc31/rA423ED+zhZk/XqUZYMpnBippDdLUdy8ZSCLcqXgPe+zsGJ1CyJvMBfYdL4aUZKWakh4gZDxamv8qhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199018)(46966006)(40470700004)(36840700001)(36860700001)(82310400005)(81166007)(316002)(54906003)(86362001)(40480700001)(110136005)(426003)(47076005)(336012)(2616005)(186003)(26005)(6666004)(478600001)(1076003)(83380400001)(6636002)(40460700003)(966005)(356005)(2906002)(8936002)(44832011)(82740400003)(15650500001)(36756003)(41300700001)(5660300002)(70206006)(70586007)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 21:18:53.5587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a88cc658-27d9-4d3c-4591-08db0e07e8c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds mailbox support required for rpmsg communication
in Xilinx remoteproc driver. It also fixes few bugs in Xilinx
zynqmp-ipi driver that handles corner cases.

Changes in v3:
  - split single patch into multiple patches
  - add appropriate fixes tag for patches fixing previous bug in the driver
  - make enhancements in zynqmp-ipi driver that handles corener cases
  - fix memory-region carveout names
  - fix multi-line comment format
  - do not mixup mailbox information with memory-regions
  - fix redundant dev_warn for split mode
  - Setting up mailboxes should return an error code
  - Move mailbox setup during driver probe
  - Add .kick function only if mailbox setup is success

v2: https://lore.kernel.org/all/20230126213154.1707300-1-tanmay.shah@amd.com/

Tanmay Shah (3):
  drivers: mailbox: zynqmp: handle multiple child nodes
  drivers: remoteproc: xilinx: fix carveout names
  remoteproc: xilinx: add mailbox channels for rpmsg

 drivers/mailbox/zynqmp-ipi-mailbox.c       |   8 +-
 drivers/remoteproc/xlnx_r5_remoteproc.c    | 315 ++++++++++++++++-----
 include/linux/mailbox/zynqmp-ipi-message.h |   2 +-
 3 files changed, 251 insertions(+), 74 deletions(-)


base-commit: 10de8156ed71d3dbd7e9099aa76e67ea2c37d4ff
-- 
2.25.1

