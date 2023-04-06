Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8CA6D8F5C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbjDFG0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjDFG0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:26:45 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC0E9ECB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 23:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvuSVuWLjtQop//YGjqCVlM0GGd0USQ4lLYs4LOWeVivpSXnw+kH0C8bBeAKosfJrZBXR2S3WJtOJOevLBkzGa2/9hHq311PyV40RWx/J1h4t7JBeWZL7rZHH5P35aT/s0pCwwOza+OI3b4skobNq+LE2WGoFECI56qWSHSVA2vE0IY55BDX43nTKvxiNK6TtCkB84iYPQ6dZreaRTd/6syLNKHPQHQHHsAmAPgm1T24MOdQ1P2rKk7nBojINsoYX6/j6TniCRPneg+OcDl4Gt+vZ0L6lz0ueKB5zt3KUptLw/1HH4EKh33WSWYQhrpeKUkxgxYBGtW5yj+N7uzV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0H6i6gzXzsgNtNcrJyTPpDKoMctl0CBEawcbeZkQAa8=;
 b=Wzwz5uBqm4OX6dGqxo74j2rdyAb7sRJqdYxCtUJW0vnUkSCiEdJXH7DlJaJzA2FzAtg1TOYawdi8OadIXQDyc/mmcYGEtsx9RtybP6F0xaxlqMKNft+DKNr7/JfW4Ye65sbK0gXP4+wep/2y+RRb66ebf5xcWzC+66nPlNO9Z7P41wFN9hhbWPYfdhwrF8wna8pNKLGTxvxnKPhF4XKaMNSV6PdJBOnbDTBrg/CnQvxSPV29+TZh9io4vExqF6XpjUILhHEyX4bq1Bafi7EJZFBznyP326PuhB/hCs0FNd/iHuYgWY/9+XSOsQG5c98Cc+k9suZ9/CtZeWem6aFWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0H6i6gzXzsgNtNcrJyTPpDKoMctl0CBEawcbeZkQAa8=;
 b=ps64GQVOw8mskGfZVbh18iUWxWs6UF770dpp6xtmgREWvnQLdtd/B/iOeXvYlz0sNpAOPbEVCJkgVfNhu6Z7tRSgYMEqXl5OQnH5TPEECiVc7WmOQMv4Nuc97YVPIwhTdqKDiMYfX19FvLeO7cykQQLDWVJ+bEq3tj2vxd5wEqYyvtLAbQnB68O1E0iLmGOGB3m1GVrHz0w6uR8LIJtgDvdQ4/KZyyeWPP92KIoVJPKpY4Yj4J7oDV/exri+s/0S8vR4pztHgDgNA3CoLJV1VLpSogHTwJA8gwRpVSrgXa/T22/i0C5Qul4o8nlpgEbtxCROiZ1Jh/9xjWhA+LAHcQ==
Received: from MW2PR16CA0050.namprd16.prod.outlook.com (2603:10b6:907:1::27)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 06:26:30 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::74) by MW2PR16CA0050.outlook.office365.com
 (2603:10b6:907:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 6 Apr 2023 06:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.30 via Frontend Transport; Thu, 6 Apr 2023 06:26:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 5 Apr 2023
 23:26:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 5 Apr 2023 23:26:19 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 5 Apr 2023 23:26:19 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <kevin.tian@intel.com>
CC:     <eric.auger@redhat.com>, <yi.l.liu@intel.com>,
        <baolu.lu@linux.intel.com>, <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v1 0/3] Add set_rid_user and unset_rid_user support
Date:   Wed, 5 Apr 2023 23:25:33 -0700
Message-ID: <cover.1680762112.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT012:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f6d250-2a02-4687-a7ab-08db3667dbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: llP2rqJskYEkYNBlXahwvsDxgN9b/GSHnsM5iRWDXW/r4L4zEG+TpXYB9Q1mkwOeiLg7Ublp92wtw7XrvCK1zfpqWypAeFjiNrkaFw2KnHUqgcwAVbDjQWzKrnlxP35vnwnO0wv01z6sYz/C+hZz3wMYCKZ14e+dvyis4WtMokoKyQQq8m3bx7bLfDGR26pZaqz6tSOcivPLfZk8AxgAwHeir/OInmvOIlKp1jM46K+fh0ORxZAV5ltlF1e8ibs1uvr1RUaQaQzyW5erpXyWDFrGlAUYtEHyKZzMrnpjUdLAAx4fzbKPMalRWfCCFIAacEY+4ur45slpGxTRzgNZyVBvC4LBIMwtY55xVoeh4aOksi5Lfpc8PMj8EGX9WrwLs39O2wMGH3KjDylqVou1Zp/jVX3oI5jhIM+9SARI5dNGjREARpWvBR5giSccYs1KBu8eSggT8T/3aBPt4xHziqKIo6eBftjJlqZCE/zTpySgVY5kiU/Rrni1UN3X6z3ug7tZ8OV9lYrNIupYVCoHamp64lN8yxegymJkGl2wG38dACvekttlcxrC0xffdm3U9+RsfCk49DmMLz6JCI7l212/X3WT+mzVFOfmzCdEX9OeMxTXxbTjJA0/7Q26Pav6bIRgqqlcD19Q8XCThH6ZvNEVU7J3Vbe1erLVdujyeyYLUdV1xq0hqCcyX0F4/CBrKlxVINXGdUocLTvUZY4Sn0afI3DXWzxVWE+AaVEZnVFqBPTRHnUrtGoTyLLtJCJQJkjy2uQYbSE2z4zQIagla5h8I9gCTTqohp+QET3QN5U=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(2906002)(36756003)(82310400005)(86362001)(40480700001)(7696005)(47076005)(966005)(2616005)(83380400001)(186003)(426003)(26005)(336012)(6666004)(36860700001)(70206006)(8676002)(7416002)(40460700003)(41300700001)(82740400003)(356005)(70586007)(5660300002)(54906003)(478600001)(110136005)(7636003)(316002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 06:26:29.9823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f6d250-2a02-4687-a7ab-08db3667dbd2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a pair of new uAPI/ops for user space to set a user space virtual
Request ID for a passthrough PCI device, down to the IOMMU driver. This's
primarily used by SMMUv3 driver for now, to link the vSID and the pSID of
a device behind the SMMU. The link (lookup table) will be used to verify
an ATC_INV command from the user space for that device, and then replace
the virtual SID with the corresponding physical SID.

This is a RFC series, since I am not confident at all about the uAPI/ops
namings. Hopefully we can finalize this small series soon and include it
in the next version of SMMUv3 nesting series.

This series is available on Github:
https://github.com/nicolinc/iommufd/commits/set_rid_user-rfc-v1

Thanks!
Nicolin

Nicolin Chen (3):
  iommu: Add set/unset_rid_user ops
  iommufd: Add IOMMUFD_CMD_DEVICE_SET_RID and
    IOMMUFD_CMD_DEVICE_UNSET_RID
  iommu/arm-smmu-v3: Implement set_rid_user and unset_rid_user

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 45 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 +
 drivers/iommu/iommufd/device.c              | 39 ++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h     |  2 +
 drivers/iommu/iommufd/main.c                |  4 ++
 include/linux/iommu.h                       |  4 ++
 include/uapi/linux/iommufd.h                | 31 ++++++++++++++
 7 files changed, 127 insertions(+)

-- 
2.40.0

