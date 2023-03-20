Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4647D6C1B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjCTQPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjCTQPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:15:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E86B399CD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDZ9cZl6InnPLa4AF+Pgxz3nDo9rh2lFQvuJgVvpLSSzDXgfPEPwjKMZTcH9WK9FbTQV+jG8trJZZU5hxSUf6Pp173Az/9Nv6qvTRRJPlZl72LlGOrY5utJEFnlUm3ss+dc8pkfwGEuQYOVpYudjzyCAZZXLZgXv8T3yuwT4+DsCEeSXQnMS3tKGZr+QjchoQJ36zGqseLTi2n2V8e0HDVE93cU8HB6VLmebjH5nZ5hhhy747rDeaapZBbbUti//UwJigm26pbztXxN9YA6DtbaVqX2+524yXDvDl0GkSsL1zHPoM27QhOkDZg/60/nkv+UggN46c2WRcECrKgAfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZosQ2t8zMBeani3FdrG5beIMMefbxoHSDm11AXSI6bk=;
 b=enI35bMtSHKvtyuqhDckQTRmW1CiRFbxsKvNQ8dnvNHYTOtXdJiFJ5dkp+3P8DKwWlvQnjy1nEBXZWSIW6lBwg7adQNRK/h52xR8sNIjHmSpducsIiXGjaav6CUQjk2Cd6iQwliAMfOYEO/irLowNyeBMERwnNLkHP4EhTfSwuvT9oPpXiMlbwWajbZZ8wAhVy46rCXJ37lT0Qy2Nbo6XoErWXBhnU5vsAoYGYYf65FAg3Bq9udLEMwhQCFbhFj41txCei6doSH3G944G+LlTYd+ZBZ/l/EYCHr06x9nJISC6apq147RiFLOFYwpglnrSJV1/eiAxqveaM3WJPxPUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZosQ2t8zMBeani3FdrG5beIMMefbxoHSDm11AXSI6bk=;
 b=mMCUIEOB1Grxak7aqN3pPvYjvPMXuzqDq4wVZryTnCCX0oJ+pxN2/s/70iaZKk+t94qfERGOkv9q4ZJJvZc8VPrxAz79o1EeVNSGVV2JUTlLRQBcMygF25MiY6XBSzZEp48rVL+hCJcv7clIXqAUN4Dr+xUPsL20Rha0bYqT3e7Bw03PzjLRJGQa6Q7hsJ/ijQyHxRW6QRzSjTVMSZ5Vtfmoliruogre06TngpHtuf+nV8jKwlhbfGwD2feC+0huPfSxiC+IQ+0GLlP/5MqvYKVuUDCL0SzPS/3HZu6qTbUM/2bjBhP6AIfPBfDbfBdyy7jZeF2WjqLNcHuT8LR8yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6836.namprd12.prod.outlook.com (2603:10b6:510:1b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:04:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 16:04:36 +0000
Date:   Mon, 20 Mar 2023 13:04:35 -0300
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
Message-ID: <ZBiEE+QLjPpxBjkQ@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <ZAxsgjuuG3ziqs9E@Asurada-Nvidia>
 <ZBhZiCOQHAxEaamy@nvidia.com>
 <ZBiCEAqP1OU5EvoG@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBiCEAqP1OU5EvoG@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:32b::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 3342a8ed-aa3c-4e1c-8fa1-08db295ccd7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSLTKxBhCsteP0aJrtABUpd7Vty7v3FO4MbxaPoSsrJ7sArPQ6bZFJr1OieFVNZ1T6rg/bQ0r9AVDdjbFMETyisxCeVY7uB3J5/GI84ImQFtkPqbhPYlMGHPDCJ9iE+r+dsZODrUPAJBPRNqL1jySH+rniEbX7NtSJaojWVvgV2LNSvwOJzEsK5aOOjmbsZldYjcnN0kFhc+X+xlRRQ4+487ZjPVNZubJuuQgCFkTctA0Ad1DqgJPXObkW346Mrx9HA34QCO7hxhaMTTxOwVcsRJZWKCvpgs/Sz++o6VKTtxKdlALmYeB5fNJlWOqdyGZvU8rOXOMJqa/VitjVIKCnMQh9wSTpGqxPUHNYGW+y9NIfCKfzxaf9STt2pz4/mRi9+hFTQvoZx8ngeaRdcCp2RmEy1W6/E3cxfpLoBlSJByB59r90FHtgMdf9nbUuEzBFSbnCd1s/hVbFHyBDvuq8s3oWPn7HH5qEfWHZkQENUUVtzwkeRaE8I3zRWAH+De9Tx1MyZBfoh4dCL/heDzT1qOoawBQidJDEztr9WVomm5LRJLepw82NIdLJnidtlD5OKQzBPWkX4QLpmSFnk57yvjflJ9ArL783NKJCMLXhp+PafbHfKMGn1E62Smn9kEe8GyCjxIC/GT+MHvXmgnFhLezjvrFfPi0RwCwKzstMO80gI9OvNjCSh4itoHjn2T6NhpjQIP3D0qOewrFZA6oyNOJ8VhzIWWCIrmsG0B5RxkkU/T8diTORC2Hp2KEKkB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199018)(8676002)(4326008)(66946007)(66476007)(66556008)(26005)(186003)(6512007)(6506007)(36756003)(5660300002)(41300700001)(83380400001)(2616005)(8936002)(7416002)(6862004)(2906002)(38100700002)(86362001)(37006003)(316002)(6636002)(478600001)(6486002)(67856001)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OesTaQkqWC/qK4IXMN4Tha2S3SGb8TQXPWyrUEOcP8qE/4gxPfA82+5Tg7QI?=
 =?us-ascii?Q?Bk6EXnn5A5xQTnvLr9gtEv+DH2qdoh5o4TTXExikblwfPGKiecNxEULC2PQa?=
 =?us-ascii?Q?/FBoRdste1moYZDU67c02syMj2ebiQ52m4A79SnojlsxRdi4lRVKplRJj8Co?=
 =?us-ascii?Q?qOOJh4pX025toGSJWQ+TDXijVhfmk81qPpyT/xiQYfR4OpMWcNzycQYK2VJH?=
 =?us-ascii?Q?RPZ5T07LojKULsCgftO0Uw9DCQprxzhWU7Jhy6r6iAlvxqouu+URPQdc2hno?=
 =?us-ascii?Q?LUT0aouDJSqnU67Tyvvc3iS38etNLJn4OtCabe6Q9TYU0w2nmv1FQ7sdGb0z?=
 =?us-ascii?Q?flnH/qjouh28omoVMxVLmVTQSct+CLUxDXlLi1E6ASAySZSwMR1zvNdEX6DA?=
 =?us-ascii?Q?L8IqzH/O45ieiCRiOLjer4BmMFMEgXW5porl+qlstj+ehe3ya/Al4iUPfn3k?=
 =?us-ascii?Q?C03gR6sf/30FRqxd+3B70qZVlWkJEOy+enmLkjVRN+99vZfo3+XwnqxE7YH/?=
 =?us-ascii?Q?HoM5LZpN7N74HFdZu/YNX8pTTGS4P42v0rBN2z4ShHHA2EW77bHdI1vnI5Ye?=
 =?us-ascii?Q?eCQhblU56iy+o4wZsbVk2ZgC99rdnwCxlrIYat319ztAMXnZRVETr5csR+le?=
 =?us-ascii?Q?dkVUVECBDyg0d3DG9+2sbSgfqCxogBOwTVd3HEpicZGHyWVqbb0M5pX9o1uv?=
 =?us-ascii?Q?U/fnITcB0DLufQy1Z7OETe+o8p6RDl+iSwYZXpW9YBNNpi+2COMIZzcYf8tB?=
 =?us-ascii?Q?2ws8aWq+oRKOK46fVDT6IJfjf68EpgR5oHLOL3tVE5UTmC17DqWuB/UKfGlD?=
 =?us-ascii?Q?P0WvW+NQQqDwTS2RwJw4eNDtwlBtOv8TVPgy+ofg3Rae2VOjKprcDrsAu/FS?=
 =?us-ascii?Q?+iDeVMynn2nJg9slPOHBDI7rwV1qnM2E2UNu9RDZkMzHKNnqV2s9EbblFpzQ?=
 =?us-ascii?Q?GAI1r5L8gRpH+axWmM7AI0vnwoDaIAXl4TbyIOSpv+7VX23lcvNz7VrquRnP?=
 =?us-ascii?Q?2guXVCH5BVwWZsAEw8j+qHNUREG6D3YBxgDNcmUWNRxoPWer0pLnaCZHdZNN?=
 =?us-ascii?Q?0dNNqZR2WEA8A+DY2ktUjEF1WxmDbD0oc+SnbS7fGMRtgn3RXG5mCdCtWuIm?=
 =?us-ascii?Q?MQOSEBq6mJd0bJdVui+6edvWHdbgJSF72k4/hnQa58htu4j6vWniJS+jVsZb?=
 =?us-ascii?Q?7HRtC3QdKk9JkPFj8HaP4QujDWQk4IPhnDfJ5Mukh9tIoyIv/d41kkI6uJ0f?=
 =?us-ascii?Q?BnsARl0QuqtVkrOFWfI+dcBNs2gdwVdV+6lY68P8bt1+jIQsnJgG4BqRecSA?=
 =?us-ascii?Q?Dq8D/3b23kArDXw5sG9K23HAccIG9zYZQwU+k64WKBL7g+mtLid2OR+hZK4b?=
 =?us-ascii?Q?o4UNjvZgt6K58T1KhRc0OHRREEG0WpPRFtlyvRoQ6vxmmYEdt5Zx58HtIxw4?=
 =?us-ascii?Q?JGpmeYnNeQ9dtAhM5ISVr98R4eFgn1s9fXwtj/H9PZ6YhgNcni8tlwvPbIcr?=
 =?us-ascii?Q?Go66A08Ee+MD9sCx+b0w4oT/K+6hvXuCrtqqdBcmT3vuvVmZtDuGwL6bwAgO?=
 =?us-ascii?Q?ynVNrh/pgrMMUAIVdS+zAUmRFtFItjhdm1aZ1sZm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3342a8ed-aa3c-4e1c-8fa1-08db295ccd7b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 16:04:36.7520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RrEvz4/XzScXVRh0YFLZB5Y0oyNSvNieKktfUFF8zC4ANd+M9Vk/Xe/mpWkYNUz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6836
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 08:56:00AM -0700, Nicolin Chen wrote:
> On Mon, Mar 20, 2023 at 10:03:04AM -0300, Jason Gunthorpe wrote:
> > On Sat, Mar 11, 2023 at 03:56:50AM -0800, Nicolin Chen wrote:
> > 
> > > I recall that one difficulty is to pass the vSID from the guest
> > > down to the host kernel driver and to link with the pSID. What I
> > > did previously for VCMDQ was to set the SID_MATCH register with
> > > iommu_group_id(group) and set the SID_REPLACE register with the
> > > pSID. Then hyper will use the iommu_group_id to search for the
> > > pair of the registers, and to set vSID. Perhaps we should think
> > > of something smarter.
> > 
> > We need an ioctl for this, I think. To load a map of vSID to dev_id
> > into the driver. Kernel will convert dev_id to pSID. Driver will
> > program the map into HW.
> 
> Can we just pass a vSID via the alloc ioctl like this?
> 
> -----------------------------------------------------------
> @@ -429,7 +429,7 @@ struct iommu_hwpt_arm_smmuv3 {
>  #define IOMMU_SMMUV3_FLAG_VMID (1 << 1) /* vmid override */
>         __u64 flags;
>         __u32 s2vmid;
> -       __u32 __reserved;
> +       __u32 sid;
>         __u64 s1ctxptr;
>         __u64 s1cdmax;
>         __u64 s1fmt;
> -----------------------------------------------------------
> 
> An alloc is initiated by an SMMU_CMD_CFGI_STE command that has
> an SID filed anyway.

No, a HWPT is not a device or a SID. a HWPT is an ASID in the ARM
model.

dev_id is the SID.

The cfgi_ste will carry the vSID which is mapped to a iommufd dev_id.

The kernel has to translate the vSID to the dev_id to the pSID to
issue an ATC invalidation for the correct entity.

> > SW path will program the map into an xarray
> 
> I found a tricky thing about SIDs in the SMMU driver when doing
> this experiment: the SMMU kernel driver mostly handles devices
> using struct arm_smmu_master. However, an arm_smmu_master might
> have a num_streams>1, meaning a device can have multiple SIDs.
> Though it seems that PCI devices might not be in this scope, a
> plain xarray might not work for other type of devices in a long
> run, if there'd be?

You'd replicate each of the vSIDs of the extra SIDs in the xarray.

> > > cache_invalidate_user as void, like we are doing now? An fault
> > > injection pathway to report CERROR asynchronously is what we've
> > > been doing though -- even with Eric's previous VFIO solution.
> > 
> > Where is this? How does it look?
> 
> That's postponed with the PRI support, right? My use case does
> not need PRI actually, but a fault injection pathway to guests.
> This pathway should be able to take care of any CERROR (detected
> by a host interrupt) or something funky in cache_invalidate_user
> requests itself?

I would expect that if invalidation can fail that we have a way to
signal that failure back to the guest.

Jason
