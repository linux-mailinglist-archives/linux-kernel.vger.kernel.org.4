Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838B767F400
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 03:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjA1CaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 21:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjA1CaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 21:30:10 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661588CAB9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 18:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWUIzosy6E+ruB72Kxew7FM8Cj+33gfhZGbQKtxbj/lu65UwccN1TICDYH5AawhR4v6wKfmHhjYnYW78CrQ+8r2Tp4cOfFvHIRINcCmxXihV+UmSeb6k3nC4FvtKh/9mWDx7z3cMFHz/eWw4fnvGsdPhJStHsch3ScssPknLxWh3XYIDNrhO5xW+qR8cEAR0Z0DScJ9t1kS/FWOLE8hyD7Ne007FCOISlJWVy4rKZR5teg1JlaYHrYv2uzWCkCoP/kLa5Q7xbkHC7/2H1t1wkW4lXJzX6qmkomCXMDBIxJfwlutE6vqfwWF05KQKUjnspyYvAK0ESWeS8Ug19YLtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2U+QTpfYZULBCD+BnrvwHuunpSVInT4gfpSXHj3L2k=;
 b=ChwQr5E36MqXa79okvPj+PsedvUko82Qj1y9Kh4wx+UD7kGzUAAd45igriAyMAERCzJKzmqMGF6/GIBPtniwGO1hQBULhikx3VEQ/jubfKdw8qarLlx/o2a5KYGsVKSN2CV4g9N2UuALgGIctthx/xfq5RmhnU0xdiWaNaEk70x1A6VSAJpnPTgsCVUtGsuCH1HmTI1FXbJLWaULlHqLSZdaAyGQyG38UJJ4qLWLO7RB/6ALj13b8BzJxvddDTFqTD5GrZZEpNFhvBmEpEheUX2VxtELhCNquihjxquv01UHp+HFs7CqBE0lIZRHrZKli5Y9ZN3tVqqt5as1tyw0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2U+QTpfYZULBCD+BnrvwHuunpSVInT4gfpSXHj3L2k=;
 b=NlvRng0yKzt4KHPST+0Dt5qNsa7ng3vUfOZGgTHaZ88qLR4nyjEfxn87GmLpcqdLT6UjMkXofrqAalipXyPKjAemCyvbB2ZhyaGw0/AC/sien3RnFEyAflEOJ/Z+3liU38oEl6FYDO+YLYiCckD0T4vRyBtW5McjmXWkFJIUz/HaXd3+rqMiDNvgSAi/72tUe3FLShbeDyy2qPwdPihkTmTuI3/gxpwOby9Vtho4b0RBxKuAv8LrDLOvZ9j6AIrtyKLUB4aQpTdvWCZ2THRWxhIzJRjVDkhCctkRzDZki+XFz8e1vqpry/y27V3Rx5ke+DAIDts6UDasRIy8o7iPaQ==
Received: from MW4PR03CA0103.namprd03.prod.outlook.com (2603:10b6:303:b7::18)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Sat, 28 Jan
 2023 02:30:06 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::cb) by MW4PR03CA0103.outlook.office365.com
 (2603:10b6:303:b7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Sat, 28 Jan 2023 02:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.23 via Frontend Transport; Sat, 28 Jan 2023 02:30:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 27 Jan
 2023 18:29:59 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 27 Jan 2023 18:29:59 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 27 Jan 2023 18:29:59 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] iommufd: Remove iommufd_hw_pagetable_has_group
Date:   Fri, 27 Jan 2023 18:29:39 -0800
Message-ID: <cover.1674872884.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: bef3df45-5d4d-4aa3-d5d6-08db00d79190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wNfSu4r4/2Gj2+cfc3yV7fk+DEuNE9OCxYwXVe4wXZTxFb1YgPpWAzXREKth5W226bp7NPEgaycpudvhgFZrZWDPJHYcxq9PFLQmHnNIXl0gB1NgH/zLvv1pNusjLD1qZKP3OOB1kBzF7EX8SjIq+dVIIGLIa/wDLHDE2qCGtZzk6XwkQL10UTUogODVyHif6ATKm5cIewnOD8E5pEpyE21O2xJVjzaEqKl4FAzY20qx18bjj7VjBWqA9fSdkkdfVCof4Jts5UZJu0SXMjJ9UZdxAHm8K/21E/HAVTzm8dxDRgdbcktb6vvhWhSXEnsVEZjqHO7LtHDBoA2A7S66HScdkqBrAZzC7jzpUGtzXggOO6BGYYMKeuEx4upCMvIbvHI63oKVry0L4bZq0K3ZpjArs6JZ3ZbEPbdetEVUDb0Qf9maPY820quCQ5RrfDFIwegBA5OyAUiRWRobcecNA86hfgYe1DTkudPYv+x+q+aC0J9TAqRdJ+VCTtrXtWHzJK57a4lio4VdcPOtRL0/c5CNASfUu/dqTVq4NarFDsbfEPcCuVkPyrhc56SCNP7EsqRnUXM5mDxKTe/bA1uQEsz5l3L1VvHIyVOrKRBhbcxbsMmvB1jsy49XesixWuVY2uaqk11CizYe5JPJN9N98OLWjW8gGa2qKbqMXPvzXpuXRHgFSTFB2Y1oWpayF2GrW9zURy/fv5+oc7dEuKv+UTnsmDkimRY3BV21DGndzGiTnNx+6Y1RNNPgZW3nktw4QzJH32TvuEQobEUB88MA3/yHRa90967OWuIl8Nv3afE=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(7696005)(26005)(82310400005)(186003)(6666004)(478600001)(36860700001)(54906003)(110136005)(316002)(40460700003)(40480700001)(70206006)(8676002)(4326008)(70586007)(36756003)(356005)(47076005)(41300700001)(426003)(2616005)(336012)(8936002)(966005)(83380400001)(86362001)(82740400003)(7636003)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 02:30:06.2120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bef3df45-5d4d-4aa3-d5d6-08db00d79190
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935
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

