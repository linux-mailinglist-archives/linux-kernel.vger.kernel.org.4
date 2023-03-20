Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9D46C2065
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCTSxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCTSxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:53:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A3323649
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ah2+XfRHWwnF1nNo9BKzqJIv0/9l51axen+WEMI43TLvkrhWbqNSXHM5gZk97IhLJUxqirWLioRupDxQmd4wFQ/EFH3A+KueeDgVeGeSJJ+p08u87VfK9QldMIQlN2JXrpqMM+FCaWb2z+1tDsYBStd1e3M5z+9o/kMWw/ZH0kFrQuDbUxxLU2ma8xyXy+m3I8PGO6jGgufpexGSr7k2KnGi2qge8WRV9hl0QPVdJXJEMxhlxxKKh5eaYoMekiXL0t6cIL2AocYqKydjqeesYc/ArHp/CU7PPKTfoDO6thvOmzDzA0qWDemxwBqhin2Omb4m8OjHX2PEzJ/1iNdqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5lhSLOozcnRHQFOkrf3/sBQ73W5XhCKWLcdsEhsIjI=;
 b=kEqgcY4umPZCYeEzyYqspYhwoyJA5YmQULIRd1SES5OtlKXkedLfezS7mX1ArsxmUwuKM4tK/5zUqntM5ns7DUxS6FJNqifmzfvJqmJFZxQLnYF8aje4lzlPFU52SQ2nmoMDvNk36U0BKitfxnw1uqei1XCHM0ZbPSgbD0EJoKt4JqTxnSLWK4MC4cCKWCZQJwcbtIIMYTxEarrzJdwyxvikqmJ0sg+O3IXwrV/HKMfX4I9SJTatlFFN+chOlQJhLGFmCbWNwRqctpTkYq4rJFim7QicTmooYUxEDO1amq3DpRNcEfi63VlWllVXhgF9TtIpTvFtlx9hIPwBoi6V0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5lhSLOozcnRHQFOkrf3/sBQ73W5XhCKWLcdsEhsIjI=;
 b=anph0LSh+Hq85RKv0M9UXWP8PAZFMDI42TW4+gFxTzXDTC7o8Sy4ZfF7lUQNA2GCijvrMF5mUMbh56Ea9b5Cf/8PaUpbSMZzzgiLIAd6jHzsYIHuz8Nf1yyYJOCz/Mp1Eha06bAYFqWTyrrPFhX+tNMNT1/mELOHZZ/LlebToqtaI1J8B2BzvAo7D3G8zVY2dTqjaN8sqdMdwY+GW2L5Nbmzrlk4SIOWnVUgLlm3mHWBjJGetpL/iJIuLYloEKh/LdU/pfbTgVW1Uu03zlNFthqQymaxw/XCOivLudBSHxdIKrfoT1uz7Nb/MKtQjRJ0YqtqO1TRSPDqAfrtnOzdNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 18:45:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 18:45:57 +0000
Date:   Mon, 20 Mar 2023 15:45:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBip4sbxUQo8RjGv@nvidia.com>
References: <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <ZAxsgjuuG3ziqs9E@Asurada-Nvidia>
 <ZBhZiCOQHAxEaamy@nvidia.com>
 <ZBiCEAqP1OU5EvoG@Asurada-Nvidia>
 <ZBiEE+QLjPpxBjkQ@nvidia.com>
 <ZBiRAVROma5/Os2S@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBiRAVROma5/Os2S@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0353.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: b3407516-e550-40af-3fce-08db29735753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ka9t+VbTomlll6qJu120SULVIriAnVTOl2iSGEAfI6lRwA3DBB6rjiLe4Vr23BOuiLljsv/R8VUpqDY9LbJUX/SEzL+0i68QplO2P0WZf8z+e7iB5E01Djce+rO69zPySu+eE9UAYHpzXTCKoocvJ5kTg8Dw40ISriZqF4g9hV3LfDFeewehIGPrsyTNWBLwfh39eufsGyXideZIs6Yp7uS3T/Cwl2rtwInILG8bKozgtjRhOshFMcZcKMibAbFKmvFmKYmFghcJG/kCpE2iUwIu6WrjIe5wG6/ld2dvpryaXnDtXmzGB+a4xTa8nhnnWrmkP5gQIReA4Y713pWCKdlQ4kVh21HD4HenjM95Yo1iA4eSBBd64GdofeB13mNNq8W5e5SiramC8WQGNKB3x4jFtCtNKfH8z4mcSuLzGeg23oRijspwp+2GjEoU+XjGT67dgcTe+HmoXTkFIS65XowdYljlzj4smrqGaZqeUrssO1dq6B8OAJZZ2hfMyblrVLBlePfSC7VRyeCEstvSVy2olKMagwYukLSrwLiEz0L+ay8BOR1AO3tmLjdKhqffhC8H85f6GsIqr2DnEI1rpVjnn/guNW2KXf+7r7ljo16gXhLCS6aBWGTFTmTCRRxbW8DxByuKCOD6Od9uJmfKCtsjUfy7JGOdhz3LS+okyqDNM7v3qTpfjO+4sXcEE0GBpAxb7bsZJEkeeeadYy0JjyOBcb+tdKggVJoXBM+BtVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199018)(37006003)(316002)(478600001)(6636002)(66946007)(8676002)(66476007)(66556008)(6666004)(4326008)(6512007)(41300700001)(6506007)(26005)(6486002)(186003)(8936002)(6862004)(7416002)(2906002)(5660300002)(2616005)(83380400001)(36756003)(38100700002)(86362001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i9yaPA7xbWTa/eKI0qEy3y+42JoACq+CZ8PzzLXTMDBfk/dMCw5cu5juGk2E?=
 =?us-ascii?Q?7b3rXBmRZ25+jukU3F0COOZjMJ6fLGSx0WXwf/a07rsY127CJmr9JYw3wpzw?=
 =?us-ascii?Q?4+4JIzNnMznYwqViVYg8dyJMtBl9XS33nh9Jh+RRFsMmYQSQj4y20YKQFB2c?=
 =?us-ascii?Q?FY6E4O0cE3boQJrQaVi9I/AAS+Z6yQjJWhoe5mTogOQJFlNBhTR9yuoxlitS?=
 =?us-ascii?Q?4Zo1EE/pByg1CcfdO1zXiWivdMuExlQtIZqmlJD/EgXxO+H2Ts+CfOWd6dLA?=
 =?us-ascii?Q?xnqKmSNRmz7zNt4GHCynBlwzKF0REt9dPx1o3gUoPCVR8jVszKmhPWbd1gmr?=
 =?us-ascii?Q?rZnur5HvGrbfjZk7gQO4XLlkw3cThTwuGXRMndfqbOmOWTXINylvYzVf6Sjj?=
 =?us-ascii?Q?Ww2DNWjcokWXedu3MZPSr9HvElr7l23gzAWsq/m90bc127bAqlF69Ii37u6N?=
 =?us-ascii?Q?G6Q9NNvd2rm/OULi3WUFPtbqOJtAnW1ki3pn2/k6ExyaO30kr75GPPZvk0uQ?=
 =?us-ascii?Q?YfP+ucLSAMDiLkvus8dO3IRas/wsrF6leEdcvx2frbFgQuqOjRgWg+Ha/5iK?=
 =?us-ascii?Q?rxRKQ05LPCTmWkLgkUrlpTZhRhsWfb2LbWyGDWlwcUscvSMeYw+nTLqukNpe?=
 =?us-ascii?Q?aB9SrAJ/BAgJHhKO5/vvmA2AcNpIXuOdKiCPRwk1ClTE/vmPDN5TV8whWY0j?=
 =?us-ascii?Q?xQJhtNPW6x0wVrO1J3yo1ioXKzPTvxjL+f8/cfkGBJZ5q7SqWeGhZX5ScPvp?=
 =?us-ascii?Q?Pdxp2qnxpaTkvnK9SgiY3kOLAyFw7PeCvkG9E4C7KgVjCF4sy7jnmGGknHV7?=
 =?us-ascii?Q?kx0xCUYW0dfl8+Fgc4IBBAY5v1Lxs39kvzubnXvtK617BmmI+8Hi5hUEoDzm?=
 =?us-ascii?Q?DlOP2U/dmw9iZSA5Hyan4LewEwn/evK6OLa74V0rVgI6OqKrlxqArTVlfcQ5?=
 =?us-ascii?Q?NP46ok+kuvsOOWK+xWlvBYS6fuN8JPHiIL4a+18gJLg7L4vZJf5X6BykvekF?=
 =?us-ascii?Q?yWUw023n8SaCj0uL+2LGhH24JjGMNSANGzk2y5T/nKMR4EPqSbD7S+Z7wHPx?=
 =?us-ascii?Q?Sl6FVV5vu8/4xkAIgUd+XURGZa+0mbJ8ZQaFfx53dyeaIE9zXaqRLfFOVVia?=
 =?us-ascii?Q?+EofqcCTMOsbl1KM/xWPWMhNbtbpOjChJpSw/Z976yfB/uQ2OTqRkB6xFRXF?=
 =?us-ascii?Q?6P7kUp0qaJFm/wz1JP6ozAHyAHwNmBCcL9Chfd7hYUsMovUh0G3nLvCj3Sxf?=
 =?us-ascii?Q?HTv+DEmEYF8CV0I1WtV4mHi6Sl2Vc0le0psmC7T1DlVvluhJgaU14LGM0Giz?=
 =?us-ascii?Q?rdYSjuZPY34HSSNzHpaKkTdeMalm3zQ6nOO5p1JLYbNwI5cbuHnbfwU2GSzg?=
 =?us-ascii?Q?43I9Hz/m3UNGUElAp87gt80FTbb6BZI5z1hP8u1LFk8c9n4+/g6pcXdSqdB2?=
 =?us-ascii?Q?dy63SbbdGUtf72EOVYbmlUaQWDRznwchM3/4pA8V8jUQ2HYpYfmYhwwI+b0n?=
 =?us-ascii?Q?f8Ali5YVpPjMX14OKN9R/Kx6fXYryGqrDm42bNWscQclsZgzr3N0Hr3hYcEl?=
 =?us-ascii?Q?M9t5IHxqzuH62fT5r6rdtui6eKr7E+vjqU8FXLXE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3407516-e550-40af-3fce-08db29735753
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:45:56.7679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwtgErf5/WSUdWS4gCKW2QknGtrd5nJM3TeozRbs7GlWhnUvFAm2+7GNOwAj/CTL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 09:59:45AM -0700, Nicolin Chen wrote:
> On Mon, Mar 20, 2023 at 01:04:35PM -0300, Jason Gunthorpe wrote:
> 
> > > > We need an ioctl for this, I think. To load a map of vSID to dev_id
> > > > into the driver. Kernel will convert dev_id to pSID. Driver will
> > > > program the map into HW.
> > > 
> > > Can we just pass a vSID via the alloc ioctl like this?
> > > 
> > > -----------------------------------------------------------
> > > @@ -429,7 +429,7 @@ struct iommu_hwpt_arm_smmuv3 {
> > >  #define IOMMU_SMMUV3_FLAG_VMID (1 << 1) /* vmid override */
> > >         __u64 flags;
> > >         __u32 s2vmid;
> > > -       __u32 __reserved;
> > > +       __u32 sid;
> > >         __u64 s1ctxptr;
> > >         __u64 s1cdmax;
> > >         __u64 s1fmt;
> > > -----------------------------------------------------------
> > > 
> > > An alloc is initiated by an SMMU_CMD_CFGI_STE command that has
> > > an SID filed anyway.
> > 
> > No, a HWPT is not a device or a SID. a HWPT is an ASID in the ARM
> > model.
> > 
> > dev_id is the SID.
> > 
> > The cfgi_ste will carry the vSID which is mapped to a iommufd dev_id.
> > 
> > The kernel has to translate the vSID to the dev_id to the pSID to
> > issue an ATC invalidation for the correct entity.
> 
> OK. This narrative makes sense. I think our solution (the entire
> stack) here mixes these two terms between HWPT/ASID and STE/SID.

HWPT is an "ASID/DID" on Intel and a CD table on SMMUv3

> What QEMU does is trapping an SMMU_CMD_CFGI_STE command to send
> the host an HWPT alloc ioctl. The former one is based on an SID
> or a device, while the latter one is based on ASID.
> 
> So the correct way should be for QEMU to maintain an ASID-based
> list, corresponding to the s1ctxptr from STEs, and only send an
> alloc ioctl upon a new s1ctxptr/ASID. Meanwhile, at every trap
> of SMMU_CMD_CFGI_STE, it calls a separate ioctl to tie a vSID to
> a dev_id (and pSID accordingly).

It is not ASID, it just s1ctxptr's - de-duplicate them.

Do something about SMMUv3 not being able to interwork iommu_domains
across instances

> In another word, an SMMU_CMD_CFGI_STE should do a mandatory SID
> ioctl and an optional HWPT alloc ioctl (only allocates a HWPT if
> the s1ctxptr in the STE is new).

No, there is no SID ioctl at the STE stage.

The vSID was decided by qemu before the VM booted. It created it when
it built the vRID and the vPCI device. The vSID is tied to the vfio
device FD.

Somehow the VM knows the relationship between vSID and vPCI/vRID. IIRC
this is passed in through ACPI from qemu.

So vSID is an alais for the dev_id in iommfd language, and quemu
always has a translation table for it.

So CFGI_STE maps to allocating a de-duplicated HWPT for the CD table,
and then a replace operation on the device FD represented by the vSID
to change the pSTE to point to the HWPT.

The HWPT is effectively the "shadow STE".

> What could be a good prototype of the ioctl? Would it be a VFIO
> device one or IOMMUFD one?

If we load the vSID table it should be a iommufd one, linked to the
ARM SMMUv3 driver and probably take in a pointer to an array of
vSID/dev_id pairs. Maybe an add/remove type of operation.

> > I would expect that if invalidation can fail that we have a way to
> > signal that failure back to the guest.
> 
> That's plausible to me, and it could apply to a translation
> fault too. So, should we add back the iommufd infrastructure
> for the fault injection (without PRI), in v2?

It would be nice if things were not so big, I don't think we need to
tackle translation fault at this time, but we should be thinking about
what invalidation cmd fault converts into.

Jason
