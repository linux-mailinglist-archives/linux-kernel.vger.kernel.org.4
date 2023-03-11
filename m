Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A944C6B5BFE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCKMxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCKMxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:53:17 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B47B1BADF
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:53:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTIqqdZYf3awB3pw9+SmYxEInMzYf2fSRmAKUhgfboA1vmPksVwkPS9Yx7ahjmysCYX3ZxmMbjvT+TFpZux42ZL5BMTJstJeOcNooRA0qUeLEu/oR6shg2BoCXxCzY9vw37hR47ek861b2qNMhqTCOqcRfGMDTwARUI9JchwNDKZj2fXAPvtzcsWPqoy5I9R73l0NtmWnuhk0RpARK8dDB9PsNZ8T8PZxVyI8HA3Agca3Bi8oMnTfQVwa1rbpz2WEd0e5SSe8C0gNLteJfUA3uFVD/ywYZw8ZN5VQvDpIUrJALfXz0TU8UHCWBItKSbpKtsvk2r1KZz8wPCoQsZmTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maWc9Gax2msHB8eKtnrWT1VPdLaBUMAKSyKgxPUil5g=;
 b=oF9J/6b4uLz8sYrL4egb3R1tn4z9B7re90urcYRxR5AN9wzmm5/MfE/YPAqJxNmzTI5R+BGqE6aL/ZW4q+J6EnnAgqLJ/+3dVBHlCs3NuMaNlu2Bx/8XH2euTFzGPnzPW+TOAo92nEuL8eEvotl7sitAawcOW0LU+nvtKtNzhcLbMtXHB6JYF+hNbxub6JOlLt6CCrv0oejUxiGWG7ZUidqu2nxvohmnhdWh6uzcOWzNgjPhnvXfp5Sf2OrN8Tf1JIgny9yeooYNptSWz4EoWqBIz61J4j0LMHy3tS0WmaVg8qVO1n/Gkeyd+/jrE7zPk+PNRmg3GrmgIraAeIYlxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maWc9Gax2msHB8eKtnrWT1VPdLaBUMAKSyKgxPUil5g=;
 b=pfrEUOB7hDHx0pnzlSq5Z4jIWcf2zVxUhNhfAKgjkQnBXdZsGjiZluxLT63h3j9lds9nXyRsJRUN10tz1YHre6F5BnJSEp1+xFfBGPv5NtrUjZWk1NEOXYU3pwPGJ/tFQF+uQIcpyzWk2IcuQx3qD+4gL+3m524FqjS+DKLDrINMY42aYMTQJh+cG9IORIZMhyu/Var0XUdtVer5/V1lcwSuh1VqpbVBmh8V2pfqsdX6j2xyKNVysQ+qWHd00yahzflDgOAIxjhGWJwuav64CWIKd1z9R9z/a8jLzo+sYHnE/irOIqxodnTeINZSJ416G7qDorQnhcb/RRPwbtPBKA==
Received: from BN1PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:e0::16)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Sat, 11 Mar
 2023 12:53:10 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::18) by BN1PR10CA0011.outlook.office365.com
 (2603:10b6:408:e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23 via Frontend
 Transport; Sat, 11 Mar 2023 12:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.22 via Frontend Transport; Sat, 11 Mar 2023 12:53:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 11 Mar 2023
 04:53:09 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sat, 11 Mar
 2023 04:53:09 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Sat, 11 Mar 2023 04:53:08 -0800
Date:   Sat, 11 Mar 2023 04:53:07 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>,
        <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZAx5s9tXiwFi50N9@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <ZAxsgjuuG3ziqs9E@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZAxsgjuuG3ziqs9E@Asurada-Nvidia>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdd582a-f792-44fa-4132-08db222f9196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kztolyfCSvkaYrN8G1TeszY57075DhgL4yRluV5zegLtA5jtHO2SX9Fr73Rx9ooboJ5mYA6ONH/iFBPDP/hamLmFC9u8b6hOEb3h4SrsO7mNrYMyGhztyUAfPRzCwfjGjaq8tzHMY8ecxH/VRBsEvuIVY26/8PNh7ry2aCcyhD8zRkpkBThV6D0q0xXiahmaV0TX2/rkjenTojyzV2E5mg3Ct1S2YMjwanQxs0IBTLX+8PqsbE4yz8C5Fw8+temgdXJimrIW3Abzn64pYSefuLunp1jQk3eYJpy6THTruaoEBx18E1LDtpaw6TqMw6r7ua/dIKNgs3KWmPPpEe2yRYgu1IS2SaxeYyxnD2LkyBkwh9DbsHkLTtWmjq4uAWchHlwfDP+XqT5lcQDGa68SLmWoZB06QMMqdsCTOx4ACQ7CuTY1AfWcCYqRdQP6VKw1BBfgQ7lvGSKP3DhfYFf4Im1ZxU+zTCy9+i36rxmKxb9+Hf+vI7Z4DWRNNKkDbAmlmnEfRdD4PlfvN7s4zS5UBjYCqVmhTr1WvNZxuL6G+e+dz/W1tATr9n4XtJYpZszNzrm9357bm+5XWH1e/gKBulCQkyu2ZzEgwX9jxkkR9scgJWkZXgrou2/ITxpUSxn045ZYRLmC73tZW9pEKriHmR+W7gjqGAUrfRMK0wkV2vIK89oQO/5wsU5jbdYPHCuRVFW6IX/zX8wpxcr8jxgUxe8Sj6TJQjqKO+DK5szEvxvNpHDOxGvSAvmHNej6TRY0
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199018)(46966006)(40470700004)(36840700001)(82310400005)(33716001)(82740400003)(36860700001)(426003)(47076005)(54906003)(55016003)(6636002)(40480700001)(478600001)(26005)(7636003)(316002)(356005)(336012)(41300700001)(40460700003)(8936002)(186003)(9686003)(5660300002)(7416002)(4744005)(8676002)(2906002)(6862004)(4326008)(70586007)(86362001)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 12:53:10.2376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdd582a-f792-44fa-4132-08db222f9196
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 03:56:56AM -0800, Nicolin Chen wrote:
 
> I recall that one difficulty is to pass the vSID from the guest
> down to the host kernel driver and to link with the pSID. What I
> did previously for VCMDQ was to set the SID_MATCH register with
> iommu_group_id(group) and set the SID_REPLACE register with the
> pSID. Then hyper will use the iommu_group_id to search for the
> pair of the registers, and to set vSID. Perhaps we should think
> of something smarter.

I just found that the CFGI_STE command has the SID field, yet
we just didn't pack it in the data structure for a hwpt_alloc
ioctl. So, perhaps it isn't that difficult at all. I'll try a
bit of a test run next week.

Thanks
Nic
