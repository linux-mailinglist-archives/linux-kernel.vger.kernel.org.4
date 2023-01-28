Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5FC67FB1B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 22:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjA1VTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 16:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjA1VSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 16:18:39 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2915594
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 13:18:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPVhoilcpyuOPt7sPXH0KoGCD1w/MSUM4iT9o8H9U5aalgTAuTB9TICpaqcnMVMepoC12sQlSW08ZETO8SQdGyIfDOhrxOk7A1xunfIxTwI7mXKdQuohK6vwEjG2Jcjk4rBR44ut9ZdXNgCDEoY5TLr3FvtUSzP9pVFSdthmA59pWdeawbN0pU0VKqEBGy5da7l5D4D3b+aQpGXC0gfHPIG9ldMw4Af+xo2/EfocfnJOEvSUP0l4GLWNG3lxnbcEFkOODeQXdqJrVBPgguxtJaMsTiVp9Bj4N+Z8974PHqNSrcjyTfcVPMOs6eb3MyiJkAEJWMYVT/A3XVOY4mmhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKxaHl7AlC4ddCrECQMxfM27OVWT/5at9nEVuRa6zAI=;
 b=QuXghoZyw+OQXG1h96m0uWuQGNEqbHLHoO/e9eTpVoeDC/DdAJyHXXcGoFTuvRcTEiIsgsTENXLEotkgud/1PmVAZhhPM4AWVKN8eM/ay7ZQAQ7TGQWdzbkTNIbQLxd/MMR4gO0VWJc7Cf9Off7c3Ls4qvQQFrxjfBSHXxHIB0+5jXi9YIwrCEa4KKVGA/EH4fgZbb6lHCzPQutxRxZXSFo2mCC/K/V+c31xyI40zpzkQk/0iIRRF/D8vJr+RvgGy5kLs+OQsSAA4/arMflDwFw5Oq4BeCJS6rOjJ4x35PBM+FXcXVFbflfSn5ux0jmUFbPAgtoRGrJOvorT7LXFVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKxaHl7AlC4ddCrECQMxfM27OVWT/5at9nEVuRa6zAI=;
 b=S50mVJS2y4avuLZD0VOwrW+8iT3JGeUgJ+arYRd4sxBas7EaUDux1TnJy/NmYKD6hj6ad/Dp8lVkD4J4ieK7J4rVZKVXPJppNAxTqftOVH5ikJxhS7kjkyxoAn/YKopREtVZUqPoNztnqqIqettDkebmpshwSonkl3AnU4G1Eo2p0nXvUJ+NokR0UOS9Yccn61TpSy6Fl4PZB6Oc3hLnI3X3wPPglbsJoBnYq8gmMs8VbZxR12jr1h1aUlLMrcmzzoLdx1BNf3BV6nhj23WJABaN9HrFAPJH9bQmvKIpejGPRxYu3q4U3VvXQ8kBwWCWykln3uHgYhMuXtRv5O3U4w==
Received: from MW4PR04CA0381.namprd04.prod.outlook.com (2603:10b6:303:81::26)
 by BN9PR12MB5275.namprd12.prod.outlook.com (2603:10b6:408:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30; Sat, 28 Jan
 2023 21:18:34 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::8c) by MW4PR04CA0381.outlook.office365.com
 (2603:10b6:303:81::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Sat, 28 Jan 2023 21:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22 via Frontend Transport; Sat, 28 Jan 2023 21:18:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 28 Jan
 2023 13:18:24 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 28 Jan
 2023 13:18:24 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sat, 28 Jan 2023 13:18:23 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] iommufd: Remove iommufd_hw_pagetable_has_group
Date:   Sat, 28 Jan 2023 13:18:08 -0800
Message-ID: <cover.1674939002.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|BN9PR12MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 128efdb0-ddeb-47f0-146a-08db017536ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xiEbdX2OMTzwofe+lf+xNr7UTFI/xV6BMfaZGJLQoOp/hNhSJpYl6px5jo8I5f00RsWCDBr6rJKM7BWuumW2u+xmmhOta5s5+rwVq3i6omjPWWPPOn2zR0T69qC3CkRFrq9QsickBiOWG7e34870q6gg3ncaxztMwOCwkdfDjE3gG/Q+Pz0Q/hWf3Ez8+9i27FUg9hKjKnjVK6DB0JNzClAwV3tgJ4UmdaSyGrKlgmobdBHfNbswUKWO57pfLTw0ryf64LLrIksYAa0CUODnmQUfPYsmj9AaUUoVx5VRK2fsLaI6hr9GkGwxZGs1ysGPypfEMplZOixYomNV9/1WEETr8q0raHW80eeylHTKFaaCnOkaJuUejhPrN8rOJvKGjgvKsSTiVZIXCp0WMJ6KDxq+/wkhexUKT3fxmTQqjyn6s4+oeopGt4EHjweptapumWRDO3gFaXciNs4KtUWzwv2LxItdiBlpnB9eFyZnqB9CDDP9i3BbC2tk7qfhu8ciLjxLS8DqeuazTab8kZVU/i5v4J9VqiCDCJSXYWqoxMQdSsMxV2UBB+lPUF0noYtJPvmTNAMAlEJPw6dsEk3MJGFm0QmwHXGFlMpdbpoddiO27ifU0mQuqejTFeVtMweNoY6UbcPEt3ynJmhLxdrmLs5zJwLTm+71GL/XRD4HciQR1kqRhxvcAdgCwNpX45sc3SSN2LC8regQjxetPQ7vrYnVd4cuDD3rnjVHPbkUET39tAqXf0I7CiywwA8MQEYUmyDsaLGGYRvhtQDuH7INb5ezKhds0p+32K7Lt61UkM3EpfHPfpCzJzNJmm5/qZx
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199018)(36840700001)(40470700004)(46966006)(2616005)(7636003)(82740400003)(40460700003)(36756003)(186003)(356005)(26005)(40480700001)(7696005)(966005)(6666004)(478600001)(86362001)(2906002)(82310400005)(316002)(110136005)(54906003)(5660300002)(70206006)(47076005)(36860700001)(41300700001)(70586007)(4326008)(83380400001)(8676002)(426003)(336012)(8936002)(341764005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 21:18:34.6231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 128efdb0-ddeb-47f0-146a-08db017536ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5275
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommufd_hw_pagetable_has_group is not a device-centric API and has
been a bit of a hack. And it needs to keep tracking an attached device
list on the hw_pagetable, and a device lock to protect the device list.

However, the coming domain replacement series can overcomplicate this
list/lock solution, especially to handle nested hw_pagetable use cases.
So, as a preparatory series, remove the device list/lock and also fix
the iommufd_hw_pagetable_has_group hack.

The iommufd_hw_pagetable_has_group() using the device list could be
replaced with a domain-pointer comparison between the hwpt->domain and
iommu_get_domain_for_dev(). The piece of dependency on list_empty() of
the device list can be also replaced with a refcount. Yet, the removal
of the device lock might introduce a race condition, so the ioas mutex
can be moved as an alternative protection.

You can also find this series on Github:
https://github.com/nicolinc/iommufd/commits/remove_iommufd_hw_pagetable_has_group

Changelog
v1->v2:
 * Fixed a copy-n-paste mistake at a lockdep_assert_held() line

Thanks
Nicolin Chen

Nicolin Chen (2):
  iommufd/device: Make hwpt_list list_add/del symmetric
  iommufd/device: Change iommufd_hw_pagetable_has_group to device
    centric

Yi Liu (1):
  iommufd: Add devices_users to track the hw_pagetable usage by device

 drivers/iommu/iommufd/device.c          | 72 ++++++++++---------------
 drivers/iommu/iommufd/hw_pagetable.c    | 16 ++++--
 drivers/iommu/iommufd/iommufd_private.h |  3 +-
 3 files changed, 40 insertions(+), 51 deletions(-)

-- 
2.39.1

