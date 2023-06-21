Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD18738554
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjFUNfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjFUNfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:35:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C98EE59;
        Wed, 21 Jun 2023 06:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKf8P3S1gVc/ZlCnlDeG72wdEKN7uvhtiX63EgF+O5hbfh7t382ajxQeaLqo4ofj2nfQ3fp9qmpxn944pXYq2VPuHp0h8sqLbcX7gJdmpjZCJkD6C7asFt3LeYHDsd9dCbxcx+Maiqoygwyj6P+7rnbWyDGglZj+d46h86CHx0BjuC/AQNX9miqYe2LvNDx/O42TEUGiwCHslGSb0gu+JTe5hNii9U6ZUBDg3rnOJACDg3dppufUE128yKdHamCMYtyRMdyxEv5bF/rhmZwso4tblgd8ezInrEInXptm6KJLadNZkvonxIAnkfe++KYQPu/jY9o21GiaVSPzXcA3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFwahwgyuzD6wb2hguaW43cuMHR5pwjsipJByOa+vBo=;
 b=j28RHngr6j0C9I2OEalN9vSUb6yFjU7iPqXeRVUcUFiekDwf9sTm2I7SzImT60EP2FWQFBtV/h8iJYIRkOHH9nKe7DVkOZNXa2ppUhxBtKWx40/TBbPRmSzV5DH9IJ2vjlIzBxOzu7K4ldR3g57yrJORGlgZQMTTKh961BkjLzg+3zPzFM7Kjqm5UsAx1W+hn6dn7H4hYEIXJfiVIE7UEMeHpOSyJXuzpvL9/NIeEtrjstGhClZpVsLXwMXvwmll5NnRg3u43J6xVxfP4/84W4FAtt+qUKvex7kImGc9C98QueXPQOTQM6ufzApgcwSv38xZLFzUj0vzlsFmoAEs/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFwahwgyuzD6wb2hguaW43cuMHR5pwjsipJByOa+vBo=;
 b=U+XCzJvIJMgFfFDReLoO3+sJTd+E0uyAsMWrV9jI5JthV3wg31ClZ5tqWIPnnWZN9BWkNzXhmH8a3kvoIA2JumrzaYT3ph8yoYD4TyZvAxl2UgispKcpXdIqBBzszjDGmfKguhxuXtFiBU3sNsK5Kf/Jy6K93K5uhzuaCdTlS/hjPhrRc3eB6njtY1KShOXr8HB61Bl1TLVTyPTLJsl9WHGjQ28RMBUooVQRQrRrhpjoPQnWiil6yqABcQPXJySSl+ENlVd40ugLFWgB4E887AZ+xP1hRQB59Rm0FJj6H5xp2rOuvcqA2BJLWMrnfAWNpMRxiK9LZRoLkx0voWWcRg==
Received: from MW4PR04CA0327.namprd04.prod.outlook.com (2603:10b6:303:82::32)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 13:35:48 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::1c) by MW4PR04CA0327.outlook.office365.com
 (2603:10b6:303:82::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 13:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 13:35:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 06:35:32 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 06:35:31 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 21 Jun 2023 06:35:29 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <talho@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch 0/4] Tegra234 Memory Interconnect followup changes
Date:   Wed, 21 Jun 2023 19:05:23 +0530
Message-ID: <20230621133526.22492-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: 7321921f-ca15-4468-48fb-08db725c6c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5iTnFUgfxrVAh0CxmH6Kv6BNGGCzmFw3efaFU9+gWcB4eZin3GXGRlfntt20cCLZ01w7IdtxRVeJ3f/0ClP1VJz3ogA05rJKMmuG/S2/aBoZ4WKshi3oduOX0/DoxIkwPzdPxmrLALShO6rkAevphLqJsOuSFtOV+KCiL4ywupmJ0FIGIGkXxpFWJ/kqI0uyuiC5sFgAHKR3BGJR/mUQR9A+hnNzmYAzzTGiNTPO+xqJhhAFoHfPC68Oly4T5evBGCkDNQ22NT/7NYoRSSGCs+XXfKqthhLbRHaPMD3ooPF1YgmOFITMqP8yml00lOsNsfnX1eWQwPWpzbhhZqAoJDmWb2rraaKAj74H9CVrcpJTJXmkIIkysd642oU8oECNgyWQ9i1rAKAHhI4mYC3vWq2hyGx7BQ27tTm4OmlddC02bRU9hdvxQ0rWmOOnPRSxWqcyg/Bk6OseodWJfMJgmRwFg+wFx5ubFz3RF3MVwnQombsT4SwNJ6StbOhl69x6cmE6LOZFq97XBfpHBXk3vPuK0gE5fUeE9Zdx8V8PvyOKE936po2WS4EfJjPQOaN4USshUWXPKpPm8DlB7xCJhTuDdv9No090kDpBjBVYsGxPMI0cCpoO7qHzirQ4Ikby/0aq4s32SPB18fZ89xmS6FLHwMeCmqYjWILmrOLqq570z2RVaWgJoAyNHVXUPo3KMfoMuN069iHXgERi2av1psN8VqVGvmXcvCx1UdxayNG9wH2/PqPCyc7PF0AQ3G2
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(7696005)(478600001)(110136005)(70206006)(70586007)(6666004)(54906003)(83380400001)(2616005)(36860700001)(40480700001)(47076005)(426003)(336012)(36756003)(40460700003)(86362001)(4744005)(2906002)(82310400005)(186003)(107886003)(1076003)(26005)(7636003)(356005)(82740400003)(4326008)(316002)(41300700001)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:35:48.1843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7321921f-ca15-4468-48fb-08db725c6c59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds VIC, NVDEC, NVENC, NVJPG, NVDISPLAY clients
of Memory Controller to the Tegra234 MC clients table. It also
improves error handling when some MRQ's are not supported by a
platform. For Example:
- Avoid "tegra186_emc_probe" failure if the "MRQ_EMC_DVFS_LATENCY"
  is not supported.
- Avoid Error returned by icc_set_bw() in the MC client drivers if
  the "MRQ_BWMGR_INT" is not supported.

Sumit Gupta (4):
  memory: tegra: sort tegra234_mc_clients table as per register offsets
  memory: tegra: Add clients used by DRM in Tegra234
  memory: tegra: add check if MRQ_EMC_DVFS_LATENCY is supported
  memory: tegra: make icc_set_bw return zero if BWMGR not supported

 drivers/memory/tegra/tegra186-emc.c | 136 ++++---
 drivers/memory/tegra/tegra234.c     | 604 +++++++++++++++++-----------
 2 files changed, 435 insertions(+), 305 deletions(-)

-- 
2.17.1

