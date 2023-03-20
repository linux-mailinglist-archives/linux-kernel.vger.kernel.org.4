Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373E06C1AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjCTQHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjCTQGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:06:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E3EA271
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPr6ZSijllRweXiL7dhmHS7nRmLpoDeSr2kSzO640Qi9PaFp07rqePpddkOooubtMqduz+VLJgsJUtcOW7bklDgmGkOQw9yUwvSJDUOveUQHJF+Mtkxjfbx28FVfYZ52d5jdPMiWxA9e41zOhXMHxBM2PhibmAIaz+rkJZKuZ9NHw6K/oHr+j9r3DqGUAO/AsDeCQK5/03CxCOJROtkLh5odTDUL4Ej+H+HEen1GBqCD5V8I8tCZA+fkvgYMlEJEYxHTwzDlgwgB4AnbtGLLONxOUWcvEa0ESN4xwCOnAY2j2f6iaZyz5yfkiD3oVq7jbG9bhxZaDvUDYuczcSru7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVAgmrLxxwhrqeRpcQZ8j/75hnqrSBthIOuBKUaQoRE=;
 b=h6GQE3Im8Fk1uvcwU1CBreboGKceZBAWK9QiaEKQicRWlQ4Y6p7W9Vs+ICDy0dtcOOIhlcI0h2NyHi7WcAlGdxmgAqjCBv6gLWiLh6q+isO+LFsU/4AjpmFTUuLtoqnyU6UXCJC3QIDDcDs4Zs8IwHulxMw5EOCCOdvz6arsgXHFVyqIyC66DPX8T+fi066UI0ptQfP3oZhzmXXQk9J5SN3dKY6riW3RrQ4wRZnDG1nqc7ri4BTRf/ljKm+uoJPjYanEBT3ZJyRIvhFVgem+WC02RzeD0eXZ11vVNZkQP2lby2kfh7Czp1M38RjmJOIS2+4yujTJmERJuVDKXrUNVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVAgmrLxxwhrqeRpcQZ8j/75hnqrSBthIOuBKUaQoRE=;
 b=sCxfRyqQ6wSQnzc8QFrnWJ5/pIVyu8mfMl0F3C4kcZ+uYzIaATh9+OBkb6c0wAHmfpPuqqsZ+i7mrfhxml03EFvDv+Os1RHUIjD081uINV8j5xhB8XYKE2h9zqnw6HEIC8/bGe/gvf4CDg90vFGZCdcbs6hNjgra0uwhM5x5pm5Eoc8EOGaVIYj9qmPeju0c5s14HstrQTAljDKXYcGgtYH5Hom3PN0EwmCuDyobyNIMrIX7VF7SIJylH3d5IaTria6ZkKWE5jCY9sQf2/znXEnotM0MRLFhiM1RjuMQLeiZ4k+FDp+athhLEi3ejuk0TMSjIETgwIZscd6LuDdsxA==
Received: from BL1PR13CA0017.namprd13.prod.outlook.com (2603:10b6:208:256::22)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 15:56:21 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:208:256:cafe::cc) by BL1PR13CA0017.outlook.office365.com
 (2603:10b6:208:256::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.15 via Frontend
 Transport; Mon, 20 Mar 2023 15:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 20 Mar 2023 15:56:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 08:56:03 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 20 Mar
 2023 08:56:02 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Mon, 20 Mar 2023 08:56:02 -0700
Date:   Mon, 20 Mar 2023 08:56:00 -0700
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
Message-ID: <ZBiCEAqP1OU5EvoG@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <ZAxsgjuuG3ziqs9E@Asurada-Nvidia>
 <ZBhZiCOQHAxEaamy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBhZiCOQHAxEaamy@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 5327c643-cf01-46fc-2521-08db295ba477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QdqrXAy/q3jGLMJbQuFzExl8XqKfy6R83HBTwWlHf2rn3p9bD00mEIx4FzYCopROQ7fYGipmGtrpHoSN+aoJO94vCSqWslZL3dtSlrtiphBAJirlRUWVtgN7tfxamQKnUk1zah5NIxk6jODX6ISm+lfpar9v5qzBxkolEC2HreN8o7ON22pe0ZUEqos0CZJmClEOxdacSHCaYqRvEy5NQrddRhLLg9ImDnGPJdxl4znl5obAiGu2QxOSxHgKIAz8RGX7fHqTn9BvlW7igo3n4YlicXtyODnOKWLBXSDUCnnbr1kvTCbDRXhR+v/+oy3LAKhYx+Es0X9udwbUbhnUNriO7TtfoxcEitk6G505/zoqx16mG0zfzGRJ5PGi/EyrrvOg2OyF3h2FmZk9WEVzvb/usboTP8AnzU1RWY7nY80O+jv6EZN1HKQrh9x28q9tTvBMZn/fmTQJt2Y/frX0aStYr56Cn/x7numlv1kVHMxa1J2MlfNYPszDn/xzhE3OH0mWXfOyojFD/ZnAbFGei3iqVnMKkdU0t0DlNM0MuGP7EYEK18H6p2g6mAeAMv02Q2ioHuZIIzmz5v6wnORAoBC7fVVYVYdgvpajoHuRyjYhv7D7gz5Xcg9w6GpXcrgHXUdws3W1JyT6/B/W7yO8u88GCBKW9+sdqkpSXMx4JwcTzoje2DImcrs9TDB0Ayw9tjiwhP5foQEqdrMXqFMzoomKRTLEk1ZDKIK926sl/EBpsXoiopoLuOBS79qkNBSj7r6it6SU4Xs2FRY0Ja0qjbv3DUXcqurhiz4l4wXWQ0OC8AMfe54SBg5/tNuiyNn
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199018)(46966006)(40470700004)(36840700001)(7636003)(82740400003)(86362001)(82310400005)(33716001)(40480700001)(55016003)(40460700003)(356005)(70206006)(70586007)(8676002)(186003)(6862004)(8936002)(4326008)(41300700001)(26005)(478600001)(9686003)(426003)(6636002)(54906003)(316002)(83380400001)(36860700001)(336012)(47076005)(2906002)(5660300002)(7416002)(473944003)(414714003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 15:56:17.8905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5327c643-cf01-46fc-2521-08db295ba477
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:03:04AM -0300, Jason Gunthorpe wrote:
> On Sat, Mar 11, 2023 at 03:56:50AM -0800, Nicolin Chen wrote:
> 
> > I recall that one difficulty is to pass the vSID from the guest
> > down to the host kernel driver and to link with the pSID. What I
> > did previously for VCMDQ was to set the SID_MATCH register with
> > iommu_group_id(group) and set the SID_REPLACE register with the
> > pSID. Then hyper will use the iommu_group_id to search for the
> > pair of the registers, and to set vSID. Perhaps we should think
> > of something smarter.
> 
> We need an ioctl for this, I think. To load a map of vSID to dev_id
> into the driver. Kernel will convert dev_id to pSID. Driver will
> program the map into HW.

Can we just pass a vSID via the alloc ioctl like this?

-----------------------------------------------------------
@@ -429,7 +429,7 @@ struct iommu_hwpt_arm_smmuv3 {
 #define IOMMU_SMMUV3_FLAG_VMID (1 << 1) /* vmid override */
        __u64 flags;
        __u32 s2vmid;
-       __u32 __reserved;
+       __u32 sid;
        __u64 s1ctxptr;
        __u64 s1cdmax;
        __u64 s1fmt;
-----------------------------------------------------------

An alloc is initiated by an SMMU_CMD_CFGI_STE command that has
an SID filed anyway.

> SW path will program the map into an xarray

I found a tricky thing about SIDs in the SMMU driver when doing
this experiment: the SMMU kernel driver mostly handles devices
using struct arm_smmu_master. However, an arm_smmu_master might
have a num_streams>1, meaning a device can have multiple SIDs.
Though it seems that PCI devices might not be in this scope, a
plain xarray might not work for other type of devices in a long
run, if there'd be?

> > > I suspect the answer to Robin's question on how to handle errors is
> > > the most important deciding factor. If we have to capture and relay
> > > actual HW errors back to userspace that really suggests we should do
> > > something different than a synchronous ioctl.
> > 
> > A synchronous ioctl is to return some values other than defining
> > cache_invalidate_user as void, like we are doing now? An fault
> > injection pathway to report CERROR asynchronously is what we've
> > been doing though -- even with Eric's previous VFIO solution.
> 
> Where is this? How does it look?

That's postponed with the PRI support, right? My use case does
not need PRI actually, but a fault injection pathway to guests.
This pathway should be able to take care of any CERROR (detected
by a host interrupt) or something funky in cache_invalidate_user
requests itself?

Thanks
Nic
