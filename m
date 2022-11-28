Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC16163A984
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiK1NaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiK1N36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:29:58 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA1B1E3E8;
        Mon, 28 Nov 2022 05:29:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOei92wAvIxfACbWOB6pMjvutAnaac5taxvmxgPAx8hxHjPQfRNyTKVLxYWrmhZGpFF3+B2C1YS/a8r0gaNwF9qmQDEVMQz4nlKOgVyL0IjjIWshjRI7lcLpM3OIfYTsPMc+IU4iCgwqQpCttM5mNNGCErzQg1AQALeSo9CGWn73M8AihQN0LSOHKPgtMEX63aWQw5FYUo5zJvvJUAnMXHzJRy15r4Q62VjXldnaj1ASgDSTXj7YdrCSKa3ZIcd6oR4YQ24VxIGE5oCiAAFI/RjGwIkzuiv27HE8Q2tdvB/292u2Eb8HoRzE5Why5uiOgMhRneSqAD4f4Wb2Uc+F8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pnv+axmQ2v/PQadUxc0Fs12JCzWl6uxl/vu+XCY3gzg=;
 b=Kc38Un3EUGLu5azRTtf/XiyFkDmj0o05YsfKwVl2+eIkWR5kI492LnpiilviefzjlN9w8SbHM/U0t2r/zzvUPbCc3vnscja1aFhXYD7bm9Ai1lu8dxmu5Xwc+KaqeM6YKucwRn8ZvtuQ+fRaXdKKtB4e/wi8PHcvdsVqipAdTc/I3gMEt7TzJZCCeUhDGz2AvFCVW1o0jwiNhiXyC19cLbY2dvYHRXXZBSYgHIvBkPPSOZNSBrxzv4FLlNy4BWkG4ZzQxNUexfDkkkCNpdydNs2AWt0wMzvXqrkcqYkpsmeRAMDdjJbD80sWiXSRtJxFXxXbSCW4UCgdrLuAHxhcyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pnv+axmQ2v/PQadUxc0Fs12JCzWl6uxl/vu+XCY3gzg=;
 b=azZ9CJIz9Sjx9zzKZo6BRYpoDGWo5INuqGJglrnqVAwvc3MFozXjGMjTSSv0d8iHW3z+G+b4cGWROXLZMM4wxNGvbXyGALtFRgP/pwX773DuH/yum0CvZJ1Mr316VFS4tC1Xk5pD1FFb9Z2FsBF2sZQE6LoSK6p/KQv22naDkf9kHUMgYwt1F438me88fx24sUkNSkOnYa3oQfJEMlYAQy3L35VytBpDMknpA5DmC2XTiMofpYj2eO2aU/eJ/WHGnj/99gxUf+u/LctgRFT36aNvLBaUj7OfICvfmIA1NngEqw+492S6psnQ7Gn1/jx7ZNn8MrftziEM3Ql53s/KSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 13:29:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 13:29:52 +0000
Date:   Mon, 28 Nov 2022 09:29:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
Message-ID: <Y4S3z6IpeDHmdUs/@nvidia.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
 <20221116171656.4128212-5-schnelle@linux.ibm.com>
 <33eea9bd-e101-4836-19e8-d4b191b78b00@linux.intel.com>
 <9163440eb6a47fe02730638bbdf72fda5ee5ad2c.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9163440eb6a47fe02730638bbdf72fda5ee5ad2c.camel@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:208:256::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a8a091-8b91-48d5-2eff-08dad144a157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DK0al0j+WpgX7NX753FPkrQQdWFix3w3DQrDQuILgF8rUKA+IuQO7CEXdMrJQ+E59+fK7qQQx5G1nNc2mEFnsAAsZbDEeWIQ3Wwxp2PE4DKESu0KhWi/1kwNjX8OQlr33vszcG32lnhE8OQhhIy8gSFVNBQQ7F2SiCfzCUnYexvP4Qy5UX0cNW5bN1v4cMqr6YWI0UKbwTvZphefZPwDGadL7P3HVuXp8m+MYRp7TlnRJNH9fEYh7EZ3VhuHTxtr0SaAhb02mBQLAcU1mTzwErHI4Qh8aIH8e326k8Vvy+8vdnojpvjU7d5k5wA6frtW6fsoawPzpvuHI+Y8CwZeD9QlipuKrrPIO8zM6JyGbPVH09eAIC0RUn85JRltYiM5NRx4hbWlUnbREdN+yLB3FBFu1ANnqshO//lVuaoPrRqOc3QK1wNItAp03B/tPdDkrtj/P815XeNXEv5dIvK2n/vY3h6IPZXLTQtp1fxVi8ffFBHKb61U2T9y8COioyBl27B1s809kUx/AiMmzBB0PPblxRHAAKy8pc2jjWgmUAA1Q1CHQ1PgsCPCcW1zx/jwYu5C9CoTWKecFJchHYV6qxpDR5sKJtL7gNHehi5rsHKQkjYsgtXBZmlLFWlBaRI685cgzYCjtjV7t55Cg/bD8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199015)(2906002)(36756003)(86362001)(53546011)(6506007)(6512007)(26005)(2616005)(186003)(38100700002)(66556008)(66476007)(66946007)(8936002)(4001150100001)(7416002)(4326008)(8676002)(5660300002)(41300700001)(6486002)(6916009)(478600001)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ix9ZXWO7m5SSzNvW6ROhbevhedv4D7/jJOnsxx6oS34Oqsu1L3GCVOup3nq1?=
 =?us-ascii?Q?lgtpZIdp+oPwm+UoH3eVR9tq+JciEI6kY227SKtampHMy+q9CdiH3X37sShp?=
 =?us-ascii?Q?OVgRSh47XTTMeyHfVLqKQ5ZUllyWes4tsfZZSjJAYjWVTMPTKd1gv4TZ6Bt7?=
 =?us-ascii?Q?kWYnfBOetSjxLABnlj7wnTWcKUjPrpzh7aoSj/c1GI034eguIPcaADZNRTYJ?=
 =?us-ascii?Q?0Dby8oL4Xk7pFIg9vg2pnFu6uOfHNm+n3nRhCzayIlC9b67CZ3DAxhBpAAAA?=
 =?us-ascii?Q?M0GJtAo1pwbeX3Ixc9o5SB7xa25bX440CNh64OYyCXpvCX2LIj+wzE/VCpnI?=
 =?us-ascii?Q?9GdJte18KOznNi4fXAyd8Qxx8N3ay0I0MAbsAdbBrZ4ik7h8a9XZ19VohNKb?=
 =?us-ascii?Q?J9Le8okI98MKJ893TavyGnlv8cXDqHDmtySgse1Di3L8sSLWLYsT8QWqgJL4?=
 =?us-ascii?Q?FW0KBIIA4o058s1o+CY5by+9wWACRS2R/hJb7LdB14DXivPAd6is8Mt4H8Mi?=
 =?us-ascii?Q?br4GoQLdymyqExZRtnr3jZbWgnrtfbNTxPLzI9mh8WiUQN1HNuGSX/xcNRSu?=
 =?us-ascii?Q?bvhXuTpS2Vs0/+ZjBqK2vL5ObL8VC7+Cg5aPiRnGmZ1xlU3ONSzo/rd1JyuP?=
 =?us-ascii?Q?3G6U/4cGAu+HR8ksg/KlAE61DnCf0YBHw/gsc+UFbS6B548CiuvzfYpdc2OH?=
 =?us-ascii?Q?N29izZGefCKyeivFTmYdtczc4rHPpLyC2RppmRwoUXNwAIBNk1s0rQ6BhUGq?=
 =?us-ascii?Q?73dEMTDEMUVXWHF8mt78Bhpqg6ihnyaabH0P7tMjNe0g0Owu4fVwtuXZiNZE?=
 =?us-ascii?Q?fxniPjVU5DgIejG1T1RxXtXsqyLgksOx5XIpO1wubRRGmmsfEs6SXCH9zb9F?=
 =?us-ascii?Q?xa5yA/v4A6hQFdHdUkm05xZiR31HfnqAfboOG+BFypZ0TloLvQzxidhrABy6?=
 =?us-ascii?Q?of+w+VlCdQtjVqWaYb+dTxVERBw9MMJxiw3Jsbq/6TWEUg0EbY7QE63qraFv?=
 =?us-ascii?Q?6dWG6+UeoISaLww5f+BP7CUJkRLkJPRSWZiWAMI950/t4Wyu+rbOeAcoWioO?=
 =?us-ascii?Q?CdI60K6QlB7Le3lazQeVXB7IIrd8K2/hxjL6UGbNpohm3PjFlltWb5LTa40i?=
 =?us-ascii?Q?l/zeL6hP5H+kUBoVIn8dVPA1HZJbm6tMJWfmZ3XPiKoFyqkVVVdklNzr5vt0?=
 =?us-ascii?Q?gdsi8goCdSFoCphvoYoaKpFZmE7u9YKsJvWm7NjLmLybolJ+Z2U4sgPHIrgC?=
 =?us-ascii?Q?giN3Unb+vpEV1qRB1Ziscj2WtA50tC4+HpFeVhB14fDEKt/sJySM17/ieRik?=
 =?us-ascii?Q?LwZcSGExH7kQZmktnFVpzcemSVtOpoXgSEaPuYshCfhIEY9HHC5GkUHgRkSg?=
 =?us-ascii?Q?5cR+DWOOoWJn/rHfd+KldSehj6xiFN3LrWTFc1U831BQZC3uoyLxjTt+J506?=
 =?us-ascii?Q?5/5zq6sOV3FECfCt14HqFfYy3c4WFYKB95WRc0OMu+m3I6k6DWD89IvoJWIu?=
 =?us-ascii?Q?hxkaH4PDKsj2wukq4bn8XLgHN2QdR0eFXBM97t10d29Etko9u3y5mK2T9Ptu?=
 =?us-ascii?Q?qFr6ikh7h45Bmu+SkXA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a8a091-8b91-48d5-2eff-08dad144a157
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 13:29:52.2110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9mAyqZ3dXNK9iVgr+HHCHpuJWDsqRTuuh1MzCo54fnZnIZwMjXYHA+OTIwG2p8i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 12:10:39PM +0100, Niklas Schnelle wrote:
> On Thu, 2022-11-17 at 09:55 +0800, Baolu Lu wrote:
> > On 2022/11/17 1:16, Niklas Schnelle wrote:
> > > When iommu.strict=1 is set or iommu_set_dma_strict() was called we
> > > should use IOMMU_DOMAIN_DMA irrespective of ops->def_domain_type.
> > > 
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > >   drivers/iommu/iommu.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 65a3b3d886dc..d9bf94d198df 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -1562,6 +1562,9 @@ static int iommu_get_def_domain_type(struct device *dev)
> > >   {
> > >   	const struct iommu_ops *ops = dev_iommu_ops(dev);
> > >   
> > > +	if (iommu_dma_strict)
> > > +		return IOMMU_DOMAIN_DMA;
> > 
> > If any quirky device must work in IOMMU identity mapping mode, this
> > might introduce functional regression. At least for VT-d platforms, some
> > devices do require IOMMU identity mapping mode for functionality.
> 
> That's a good point. How about instead of unconditionally returning
> IOMMU_DOMAIN_DMA we just do so if the domain type returned by ops-
> >def_domain_type uses a flush queue (i.e. the __IOMMU_DOMAIN_DMA_FQ bit
> is set). That way a device that only supports identity mapping gets to
> set that but iommu_dma_strict at least always prevents use of an IOVA
> flush queue.

I would prefer we create some formal caps in iommu_ops to describe
whatever it is you are trying to do.

Jason
