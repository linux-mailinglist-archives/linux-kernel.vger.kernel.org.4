Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3203C6C1D39
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjCTRGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjCTRGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:06:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFFA311CD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:01:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwNBXBu5PannWzEU3GvPjVIeoaYM5rD+CvA+7rABrHx1NyjjN8t5ZxFXqI9bA/SZwLAq8QeCmW6MBRKdbiaW2yA7aZ36438F3UZ9sk/8Z5XahZqOHwz//WdmYZKIDCrvFcE/Xbdpbd4ZUuskfMcShhZOIR1sFqGbIFIZXHHlcKFjGo/TTi0kKc6gLivWzDh1X4CRRBdOGqblod502J4DD6o5L0RsGGxNOOXOf6LO7rr64krttvqUKl1phccZ5w4FSVKMCLIfP3Jv2Ba4+fLxMcddkW1XYKFiwjMaYRXzpjbunidOMMrvj5oZrfpcjQIkoZTFxgMmI2PXPY+ECwaKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIb+RYiRcDk5pgLnCWcXxNFPcxrx3ZoXLmmCUhvQ78E=;
 b=SyeT0zl3BtWvA7vZdfNXzFxoc4dVOA3alMhnJSHpEXU4YVE4HUugfLrlrC0rKc7PNzTLSdd3RavVtiF48iw1gHn44cTJsw2PpOYf8E7/IjD6R7oAN8uywgpuLwaJdXe7oau/norYfd79588wx7GCCP8LtmCQjI71upLBKABunQb4Lxg0eCjQAB0oITYZ1ICzuedzxAEG9rLASI48VrxEVJomgK8tVpBmScyNO4Mf0sWDZHcf10VB0hXs+O6Tcsf9mLMsTs7oJc4XnXjImfHHXqaZsKmknBPS4Ggx+U70krnD8aW+5ey9qEWdYGvAn/MyQ5oeuXvdjcyl2aDXc6RRPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIb+RYiRcDk5pgLnCWcXxNFPcxrx3ZoXLmmCUhvQ78E=;
 b=UpSRIP9SqgHApqnsFJ2nWKW4k3nfhoxwsYsJzTRCSsiZXIWMu7bN//PkDSgFnchAvs/Xl60nQvRSOFWc/Lf7mI5ZULEImA3FqN76WCNJLrjl1MhezvDn9aoPddtDlYBNqCZSq7G77Tv+n+V+MSNabEgSedr9ArLzVzGOgDT4muKNmG5IP6k8rP3uRc1/qerKt5TI+tdVZgI5uiMkUTESUreU7ba4EqyRvhl5Om+uDh7tkILiDy9DZZje8I9hvjm6ORsGEKWP2PW787rNFCtY8YWr3oIZ8x911zsRHkr0kMQ2d5fViCIJ0jz0E9gNgYpwHZK4VDN8qUKjht5Wc+yJHg==
Received: from BN0PR02CA0007.namprd02.prod.outlook.com (2603:10b6:408:e4::12)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:00:00 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::de) by BN0PR02CA0007.outlook.office365.com
 (2603:10b6:408:e4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 16:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 16:59:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 09:59:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 20 Mar
 2023 09:59:47 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Mon, 20 Mar 2023 09:59:46 -0700
Date:   Mon, 20 Mar 2023 09:59:45 -0700
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
Message-ID: <ZBiRAVROma5/Os2S@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <ZAxsgjuuG3ziqs9E@Asurada-Nvidia>
 <ZBhZiCOQHAxEaamy@nvidia.com>
 <ZBiCEAqP1OU5EvoG@Asurada-Nvidia>
 <ZBiEE+QLjPpxBjkQ@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBiEE+QLjPpxBjkQ@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: 57832742-18e9-4bc8-fc11-08db29648a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qn+4gh8MxWefhAz/Wof9OAW6R0SPdf5gzqdZB4xn8Y7Pgwp50qvRrdCNOc8Lpfr8gjYRZ2sDtB/jZm6NdFTYwlMZMLFFXpzxCQNr1mpEozgSQqVkiQ7qL86oHsWvdQ/Q/3ckKO8Mi+QbrfRnJkwC3u7nsolJgVOlrXW+FtBHrq0OMmifSXKxD2leWkWD2l4WAAbh4zuSRkd/AVJwwlx9LxOGJiYeZT4KEMsY5CPjhBL0MxdasUvSqWryZDcOsx76w0dznZT20i6vGkLmOyAEcqx3TlpYgPIy0TFLdxmKp6RHsGNPzumy/4eHe9ArvMgO3/7HkSum+0Ga/l3dhzuHSevEDR9Na9gEsUQbdMpHjphdXk9MAXftbVogc2KfywJBVqQEqps4Z0+A8ciKYgMPJd9gak2aRrOiExXMk3434oR3ORKSaewm3w3FvB2hosbsM7smmhbtaYW0S8sAGAEfAnag116uFSsK40ZeE4j5hCPER9jM9n1EQZDXHi+N3gjfOOxC//SohHg9lUFi4g75gTNH3KM51gG24in7sJZ5IhSYxnZYgdHOK3rXv0X1uQidpKmgBj9SDOXcaGpQDw4rdGJO5xTbC6Re+1fqumSfBB3Kw2vGRbxQIOspp9cETKljwNoCa7ohXPU9/ywrqqVexpKMbuPnh6nndsDZuqlnz5XJkGc/z9tiZ094dfKUvssFtLo9lJHPoFNjLRQEJPmqViN1SwaUBI8gS/CYq/GaPVAM24NrOTd1sOlbM9k1pd76vCKh770QtX/ZhnZ8iNZMjEsG9Q8+L+JGVYbOfo0AxK3ptKAw5EDjrzojlkzJDiZD
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(6862004)(83380400001)(8936002)(7416002)(55016003)(40480700001)(36860700001)(356005)(82310400005)(33716001)(82740400003)(7636003)(86362001)(47076005)(336012)(426003)(40460700003)(4326008)(8676002)(70586007)(70206006)(54906003)(316002)(6636002)(478600001)(186003)(9686003)(26005)(41300700001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 16:59:59.8858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57832742-18e9-4bc8-fc11-08db29648a8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 01:04:35PM -0300, Jason Gunthorpe wrote:

> > > We need an ioctl for this, I think. To load a map of vSID to dev_id
> > > into the driver. Kernel will convert dev_id to pSID. Driver will
> > > program the map into HW.
> > 
> > Can we just pass a vSID via the alloc ioctl like this?
> > 
> > -----------------------------------------------------------
> > @@ -429,7 +429,7 @@ struct iommu_hwpt_arm_smmuv3 {
> >  #define IOMMU_SMMUV3_FLAG_VMID (1 << 1) /* vmid override */
> >         __u64 flags;
> >         __u32 s2vmid;
> > -       __u32 __reserved;
> > +       __u32 sid;
> >         __u64 s1ctxptr;
> >         __u64 s1cdmax;
> >         __u64 s1fmt;
> > -----------------------------------------------------------
> > 
> > An alloc is initiated by an SMMU_CMD_CFGI_STE command that has
> > an SID filed anyway.
> 
> No, a HWPT is not a device or a SID. a HWPT is an ASID in the ARM
> model.
> 
> dev_id is the SID.
> 
> The cfgi_ste will carry the vSID which is mapped to a iommufd dev_id.
> 
> The kernel has to translate the vSID to the dev_id to the pSID to
> issue an ATC invalidation for the correct entity.

OK. This narrative makes sense. I think our solution (the entire
stack) here mixes these two terms between HWPT/ASID and STE/SID.

What QEMU does is trapping an SMMU_CMD_CFGI_STE command to send
the host an HWPT alloc ioctl. The former one is based on an SID
or a device, while the latter one is based on ASID.

So the correct way should be for QEMU to maintain an ASID-based
list, corresponding to the s1ctxptr from STEs, and only send an
alloc ioctl upon a new s1ctxptr/ASID. Meanwhile, at every trap
of SMMU_CMD_CFGI_STE, it calls a separate ioctl to tie a vSID to
a dev_id (and pSID accordingly).

In another word, an SMMU_CMD_CFGI_STE should do a mandatory SID
ioctl and an optional HWPT alloc ioctl (only allocates a HWPT if
the s1ctxptr in the STE is new).

What could be a good prototype of the ioctl? Would it be a VFIO
device one or IOMMUFD one?

> > > SW path will program the map into an xarray
> > 
> > I found a tricky thing about SIDs in the SMMU driver when doing
> > this experiment: the SMMU kernel driver mostly handles devices
> > using struct arm_smmu_master. However, an arm_smmu_master might
> > have a num_streams>1, meaning a device can have multiple SIDs.
> > Though it seems that PCI devices might not be in this scope, a
> > plain xarray might not work for other type of devices in a long
> > run, if there'd be?
> 
> You'd replicate each of the vSIDs of the extra SIDs in the xarray.

Noted it down.

> > > > cache_invalidate_user as void, like we are doing now? An fault
> > > > injection pathway to report CERROR asynchronously is what we've
> > > > been doing though -- even with Eric's previous VFIO solution.
> > > 
> > > Where is this? How does it look?
> > 
> > That's postponed with the PRI support, right? My use case does
> > not need PRI actually, but a fault injection pathway to guests.
> > This pathway should be able to take care of any CERROR (detected
> > by a host interrupt) or something funky in cache_invalidate_user
> > requests itself?
> 
> I would expect that if invalidation can fail that we have a way to
> signal that failure back to the guest.

That's plausible to me, and it could apply to a translation
fault too. So, should we add back the iommufd infrastructure
for the fault injection (without PRI), in v2?

Thanks
Nic
