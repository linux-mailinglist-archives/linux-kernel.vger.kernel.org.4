Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9CF6B5B5E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCKL5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCKL5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:57:03 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A081151F6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:57:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFWsYJMWkODAsvDk9V38MwQOcFahXG53S2KVhtXVo+b7DpGzY4kA4Pf2KG1Le4HIisg6ntCi/GR2/e/H0VFe9A3x3v1mwdWl+hnzBljBojRYKUJQNEo2UJnnZyXFbrUJfNFsyRj/NfT3fqDwDMU9JoLGdjnCTBU36bysC6rVmydoDkpt89A2rIjYjTbcGG4vxa84PNs7ADmRZZ/D1Y+3rbfM62eZuSYX1Y/B07ekYWK+o0MLen081jmW+kd5lxODEYsDP20rOGGno5Lo+k07SvcwNmMPXGTcVCc+/grXk56uMLEnqbBrqwWVJidJSJ1OzqAalY7Rg/WRUp3n5m/5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tawc8RJY6OJGfSW3WJT5DG1Ws4J/TPGXahwj9v1vXU=;
 b=mpPhXjKXWlmWEguRbeX3gYul2UIj40m/qrQbFXfJJKbdImBOQ4/Qb9054TcLYKglxoz1uYSegYvvtwld20SS/obhfwu3TweyUzk3paNKUB+HFK8ZUUz/DnkC64WxHE3YgkGYg0Q/AtaMFlsnRpC4yigOHXREPK2GhZOPccbTUYsW6+J6eszZLD47BFZ80a7rzV7rC18r5z4SFoo6m9ruGZmJ9UV8mTWB9Wcxgz/hDC2WrQZW/pxcDOwtik1j7IIRCAqvJlZ/X7jpOh2Rpram27TSDUweFWAJLzRaLKF/aPjnXNTS3SvbNkS8mQZRVwB7wzAz4CNLV+XLBhUDWTb4Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tawc8RJY6OJGfSW3WJT5DG1Ws4J/TPGXahwj9v1vXU=;
 b=uNFgEBLHsgKmTG6RNg4fiDNrDIs3Vrs9dSsEAebGDDQavT4PuYF9TbbfP7JdJ8xdLqCR9AowbXVX7dE/yIarjk9hxEHJwmN82KA9wUcbmJ2lqEjh8kbdt4NSAxwzVJGv1c/rVNdIKcjFT83Z+px2SGS7YiCryZom2IIIgAYzCEE+G92b+dN2lgefNNJO/hYohAVzUg4TxCdKsgSWwjmtaXnSr1Y3alVuHpQgK1AFztoQ9oY+Sj+rB1oA1VJjLnTDoCWTX30Z4azZlqTg6P2rY3dpmoQ0HqzqfnPVz+qSmRLB9bANxelXqyZq33lGkDgAPKkbbZfU4TwWNUGrPquh7w==
Received: from BN8PR04CA0038.namprd04.prod.outlook.com (2603:10b6:408:d4::12)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Sat, 11 Mar
 2023 11:57:00 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::dc) by BN8PR04CA0038.outlook.office365.com
 (2603:10b6:408:d4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23 via Frontend
 Transport; Sat, 11 Mar 2023 11:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.23 via Frontend Transport; Sat, 11 Mar 2023 11:56:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 11 Mar 2023
 03:56:53 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sat, 11 Mar
 2023 03:56:53 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Sat, 11 Mar 2023 03:56:52 -0800
Date:   Sat, 11 Mar 2023 03:56:50 -0800
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
Message-ID: <ZAxsgjuuG3ziqs9E@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZAtYphmOuEqQ1BiC@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT060:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 33cdc44a-af29-4628-8df6-08db2227b8b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R6DCXFIFAubuYfHsxXDhl5XOYFLijX/r5Klh3rdPRvRoW4LnXjCHFqgN9oRd8VfT5O7aTwLCtxG+bAJfhVGGrZvYAuoycbxHUaJQtTyNpp1jjWAhfit66PPOlSgH4agbzg2Jm2ivZ9Shiky3+reJF1glnzWj1xSaUF46dPfAzNH0aT3Qbj6RkIOW90Sk0cmmmYe91c3rPTHbnqumvcrQZF2VhKIU/kqH3BkQSIIkmZSnVBJwy8+ZN/R85NGvSTeUOfRvt1uvP9lrnLVpadW4aovdrViieHfNcpmcBc5qNCJhf8qNvClSfrFMe34VLAuI8WqM+kjwQmCjpOZRMJTBE1WZOeM2uIqMUos0D07wQHh8+N2S+jYsKisZA+zqN95mHdjA/Ajd0aKN64yCMaGwztmySvK+wD7IbAcic61UDooawJM5qscakLNPSQPg0tVHGVwfYNMtNtt34D2wPonzCan86fq+rOHRKDQvUcBoUK1vPyePK4E7YeFInkUKm9BTYiUOEsgiJY71TdSZDkC6YgDxVEAi/jSJJ3NyMkjMcOz21oLyD42sIQwhAjhpGPvR12BnM+UVdngSO+3S+T4PMo99NCFXpMjgbcJFM0De8+qiC60uLuF2nZqmEXb/br7VihPb+VgBkn6wy1b061aFhZYQdvl3+ymLVc/kdg7Q5/3/LRdq2XFT5nbGnH/HAhyfPXuiihI7wxtE6WsiosBqHiuoxcF/D2eOmFwws5doZCMr+OmMdWWKAPNHLEDCYksD
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(6636002)(54906003)(36860700001)(2906002)(82310400005)(336012)(7636003)(40480700001)(55016003)(186003)(9686003)(86362001)(26005)(356005)(6862004)(8936002)(40460700003)(7416002)(82740400003)(47076005)(33716001)(426003)(83380400001)(41300700001)(8676002)(316002)(4326008)(70206006)(478600001)(5660300002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 11:56:59.8869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cdc44a-af29-4628-8df6-08db2227b8b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 12:19:50PM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 09, 2023 at 08:20:03PM -0800, Nicolin Chen wrote:
> > On Thu, Mar 09, 2023 at 11:31:04AM -0400, Jason Gunthorpe wrote:
> > > On Thu, Mar 09, 2023 at 02:49:14PM +0000, Robin Murphy wrote:
> > > 
> > > > If the design here is that user_data is so deeply driver-specific and
> > > > special to the point that it can't possibly be passed as a type-checked
> > > > union of the known and publicly-visible UAPI types that it is, wouldn't it
> > > > make sense to just encode the whole thing in the expected format and not
> > > > have to make these kinds of niggling little conversions at both ends?
> > > 
> > > Yes, I suspect the design for ARM should have the input be the entire
> > > actual command work queue entry. There is no reason to burn CPU cycles
> > > in userspace marshalling it to something else and then decode it again
> > > in the kernel. Organize things to point the ioctl directly at the
> > > queue entry, and the kernel can do a single memcpy from guest
> > > controlled pages to kernel memory then parse it?
> > 
> > There still can be complications to do something straightforward
> > like that. 
> 
> > Firstly, the consumer and producer indexes might need
> > to be synced between the host and kernel?
> 
> No, qemu would handles this. The kernel would just read the command
> entries it is told by qemu to read which qemu has already sorted out.

Then, instead of sending command, forwarding the consumer index?

> > Secondly, things like SID and VMID fields in the commands need to
> > be replaced manually when the host kernel reads commands out, which
> > means that there need to be a translation table(s) in the host
> > kernel to replace those fields. These actually are parts of the
> > features of VCMDQ hardware itself.
> 
> VMID should be ignored in a guest request.

The guest always set VMID fields to zero. But it should be then
handled in the host for most of TLBI commands.

VCMDQ has a register to set VMID explicitly so hardware can fill
the VMID fields spontaneously.

> SID translation is a good point. Can qemu do this? How does SID
> translation work with VCMDQ in HW? (Jean this is exactly the sort of
> tiny detail that the generic interface ignored)

VCMDQ has multiple pairs of MATCH and REPLACE registers to set
up hardware lookup table for SIDs. So hardware can do the job,
replacing the SID fields in the TLBI commands.

> What I'm broadly thinking is if we have to make the infrastructure for
> VCMDQ HW accelerated invalidation then it is not a big step to also
> have the kernel SW path use the same infrastructure just with a CPU
> wake up instead of a MMIO poke.
> 
> Ie we have a SW version of VCMDQ to speed up SMMUv3 cases without HW
> support.

Very interesting idea!

I recall that one difficulty is to pass the vSID from the guest
down to the host kernel driver and to link with the pSID. What I
did previously for VCMDQ was to set the SID_MATCH register with
iommu_group_id(group) and set the SID_REPLACE register with the
pSID. Then hyper will use the iommu_group_id to search for the
pair of the registers, and to set vSID. Perhaps we should think
of something smarter.

> I suspect the answer to Robin's question on how to handle errors is
> the most important deciding factor. If we have to capture and relay
> actual HW errors back to userspace that really suggests we should do
> something different than a synchronous ioctl.

A synchronous ioctl is to return some values other than defining
cache_invalidate_user as void, like we are doing now? An fault
injection pathway to report CERROR asynchronously is what we've
been doing though -- even with Eric's previous VFIO solution.

Thanks
Nic
