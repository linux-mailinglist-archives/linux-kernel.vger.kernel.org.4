Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B412E6947D6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjBMOTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBMOTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:19:38 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C22BBA0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:19:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ots8Ga8DPuC0pRLwz+qmr+jIQifGwbwDx8NnnOOhcUxqx/oPPb/eqL29RIOvvUraHgI2xyHGxuXWJgx+TARc2w2p9zMuhO3gMEKDQZby5tY9cF7xwyMBHI/wQ2PcUF9SBQWhUvmzR/ckO3dCKL3Mw6Nga2aAOAK3crbC9FQSZpuPshjL9etyy1zGKmCssfyvWiYZavfnpuYdsiWoXzhIyji2bChwVXgh0P39YJi5/WTwFW8LNswh6hWIVn2pzlfpKRWUpEjltLdVvcUC4+g7BOyMUZ5g1qxIjbJhu2MQBPz68Nw2IZZHn8t1/1NrC7yPrULaD3RjNLgf+oGrF64tLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1PD1bBdHChVE3HFKizRYU4IQSwOk3bm5We9khrKSNs=;
 b=MZfFIopSW14MdU1d5O+vwv7L9l6CMpHseYGiPcMrxhnZ2m5aCU8wgFRCmdV5VH2HtwhnC+EDx3yGmsiBkm9mwo5B6qI61kbfublwPUy4JlKOIQ3wk87+YUIb56v7IX2AGeo4c5/4VrIYVVY2ZBNg+wkPaDU8WGzJr/oAKNJ+NGGWJbApplCTHKDOArKi7fqa9b8uD0eu7wWcGc9gYSk3igMeS8T9ZqUq16rN5HLsgCDgeW3btORqn28a1qSQBYCgwCanqf7L1nUMMCBrxuVNNznZ6VTlJ3xM0+M5eRHciG6RWmD9RozGS51KND1HYsXqmGbXRiSUvlvtoLJ6H9LAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1PD1bBdHChVE3HFKizRYU4IQSwOk3bm5We9khrKSNs=;
 b=LgjG9htwnrbj093MTLb6o09jPyI/Y7vNfNG4yFb/b3Vkbr4Wnbha/90oAgmzW8Qx+uzQf1BQAEolTzHm/08XZp9yZuC76DE6DxCrFFbXV3uoAhw4diKvBFMyGKOsub2hVHPUD+Ou/CR9fi3oFiifP6dzun7acvlSHuWxBQH3nqQ23OnytRL9VdveAglr+n+vp1bE3UnnjLDS+WJpWssdwGntDHKVznl2yNgHnpuQd88TwXpCpOTlLvfvqDQEM8n2sJlYcru8zUoskLiDY6DOv3ZPsNY/XZSGICWsZIx/kF6wFmxLpxOtZG0yvnPTOBhoLdhcG38kisb3Ld1DwRV/+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 14:19:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 14:19:35 +0000
Date:   Mon, 13 Feb 2023 10:19:34 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iommu: Use group ownership to avoid driver attachment
Message-ID: <Y+pG9kWzR2c5I9FU@nvidia.com>
References: <20230213074941.919324-1-baolu.lu@linux.intel.com>
 <20230213074941.919324-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213074941.919324-3-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0094.namprd02.prod.outlook.com
 (2603:10b6:208:51::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: a2859257-0533-47e2-e1bf-08db0dcd5529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArG5wES1oON2YVvESwi2MaakGlgDkp/0FPJSeuPVnc+YDJjZh7+PmiuOX5pViQYe8sN7Z43D9787PwSaadvV2Rtibee2CQUgwWjuZPjKtCrp+cXH7eh8g6hbkinCV0L93tI/lra2vxcRpihQcpOWJHl1t7jItBOokyUynO8fjr2v4Uj/u+zdYTmY5JyCNqUKTC6XbbbSYdsEAIKw9yKTBrCtwl+2/GATs2LZg1xa1/5z2Ea4hKTG/T65kTD0fqkHFwRwtM4rSE0ykKj0+DS/6IkK0JG8Rd+VOGxuFzl+no4yZQFfDkGbH8ci3EqX8a4RhKfk+NU7f+WGcwLF0yaA9G8jfHtdXAayFoQZTKCR8wJRw+SdmELdlnYG0cGTOiWerlWHFcfxw10pe59Tg2w8CTSQlgj6TpT4VVEwIJZ6bcuWL5TAgLYDEnti81ajja9Cnzt3tUVJIwOd3srKrNOtpTK2YU56xxXXrWkUlb/D9TtpczNNCTGC0hwV91aFx1FERa0yp3/TcwOfb9Tu6m0jmb8mdE9wtSJPt71QmHv4cCaA/iv/hT7h0Jiev+m2YtbpPvjF5DbEsMvYnE8qLDqvJ6kapAqSSkBy01MaXYwDE6GYDE5G1Lf2hQsAZJHxXgRCTAi/lpZDNvBpv6b3Lqc56jvAIVjrsyQebVRYu8xc/l8sog4sGalnqDEdDOMGG/+n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199018)(36756003)(4326008)(66946007)(6916009)(8676002)(66476007)(66556008)(316002)(41300700001)(54906003)(83380400001)(5660300002)(478600001)(8936002)(6486002)(2616005)(2906002)(38100700002)(6512007)(6506007)(186003)(86362001)(26005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yAh2bDn+0nCyt3dbi6/+jjHO8RNUrV36MvIUjIri7i796VCctqzabbtRWawt?=
 =?us-ascii?Q?lNKy4WaC9yIz9e30SMHlwjU9IiSJLkrrP7xl65m1CHojolVRwbs1l0d5Al51?=
 =?us-ascii?Q?nmhxcYXcOzTM5SbM755ct6aggPlJd6srgp+UUiFyb0vLyPaieuqm9CBK1Zit?=
 =?us-ascii?Q?QyzzpaHnzwMsUIbQNVNcVEa3GNbR72vRIxILKX+a5trJ9RM71A9MSTWr12vE?=
 =?us-ascii?Q?HbXYAY4Rjs4Sme3a3mu2MZNbe9VuMrQ0I2tjEdmd0risT2wlx8Yqz/ULj1YX?=
 =?us-ascii?Q?PAVZ+ItRx1OHNk9JpZ7fUyqB3JXX9Xt9jnA8ksPyeOd4R5kjWY9hFXKK28dd?=
 =?us-ascii?Q?rFZsp6ygOjnOm4jsB1zBFfsTS5xjr+sZaH6Cl6xCEY9uHCGyP1XWdtvMTIhp?=
 =?us-ascii?Q?5LunjtaN+Ja83Lu4cAD9a/3NXD6u5gpchm/r8zFiJ+BgXw4yUbKlZkAxY3pj?=
 =?us-ascii?Q?huJSn1QMsTB1J3EdUgxB7Z2T9JqX8MTbkAYlk7KX5EK8/CXzNqaU8Dlpk60r?=
 =?us-ascii?Q?8qkNY3hnMXHpbvtOu2JUd5i46f6Z5cr16OGMR5eilLFaa/vsbUNmdG79b1dU?=
 =?us-ascii?Q?3N5+2x4nCFfge5u/P0gAzuVfXqXPxz7+jexrMrKPty1IzBVc5JK+vHsXYLN0?=
 =?us-ascii?Q?g99SSMMM5c1O+PD4x1LGaaYD1OpMLctg59x8gLf32kDQoLXn6/WW9OoRyrYH?=
 =?us-ascii?Q?48wvsQeqan0ujufRvPS5DdxbdMtsmhJhPPBf/19V59bR8lWHkD3HE0Jk3A3K?=
 =?us-ascii?Q?n0tGFfssUcyI5Pm3uJYsS8tA1AWL0m2SzdYBo9D/5kurqB8ZbmFTEXWMV+7m?=
 =?us-ascii?Q?LCG7Y4cMIn1fonS58INOMmPzvWu552iU5nS7x/FrtTDQrNPp+Zv5DGqMcze6?=
 =?us-ascii?Q?2kBPqruaHTPnCUiT8IQXuiYLsR+8lvhz/5AOiyapiqw+wynzsoX/QDy91trx?=
 =?us-ascii?Q?+9suBj2dvJFzyf5pFY+v25cUldbfKh2JFkS9s66IB1GA3tqd8IU6niDOS+M1?=
 =?us-ascii?Q?yI4QS4IfwmgyP7cDrffT8HFHi3RdzMfCmPusQIwnPCBcfXyHqv2MD/V6lr53?=
 =?us-ascii?Q?p+EnpwMhTgKt8hs41GS14TiKslxSQKJ/pQ1BEHI/+yOK6wdYYldKezYaFQRh?=
 =?us-ascii?Q?0bUj39Pl0dSOJzOGR5cwQvZ7LOSKzXBapwsCouW8fBUU2hD3DQDUY2bS+vdh?=
 =?us-ascii?Q?cVIsrhviLTvFrdLo11Ee2JQeCVafQ68ez7RO+NL23WpT6JdUfjLYdUWiBO0J?=
 =?us-ascii?Q?UskM80m1QWJle23wYlC808jP+92jbh2nbkIQWEWoegxcXufXBY5LfLZNQe5m?=
 =?us-ascii?Q?YAmd/kS3E2JmxnB1NN+JE5/GTiNSuiAkyrq4d4FrZPVMIvSZGVuXFTS/tHIc?=
 =?us-ascii?Q?7PJPaNQXWTW3KCkzZ9lzwFl5w4bULETdczRB0rlpcJNl4gAgQvNhR34w7s8k?=
 =?us-ascii?Q?eel9b6nVD/K3xZwnjgl8PAP6t1bMFivMiYAUVuZuLN+wLaBmse9xctu8fs9t?=
 =?us-ascii?Q?LdzIpkhfJZ2YvBsWgSvgXv0LwNWBUqXaV1F/R5o1vG1+gMlpiULlMyUDkFMI?=
 =?us-ascii?Q?zt/zTBmFxGck2QjsjYxZfhcMWl04zsprCuhBHZXN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2859257-0533-47e2-e1bf-08db0dcd5529
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:19:35.3040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxxCI2kYf41TALrnlW3q4/woRU+nqNvD8+FT/NHWcbLUqwiRX9PLOcgEl+kzsmVV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 03:49:39PM +0800, Lu Baolu wrote:
> The iommu_group_store_type() requires the devices in the iommu group are
> not bound to any device driver during the whole operation. The existing
> code locks the device with device_lock(dev) and use device_is_bound() to
> check whether any driver is bound to device.
> 
> In fact, this can be achieved through the DMA ownership helpers. Replace
> them with iommu_group_claim/release_dma_owner() helpers.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4f71dcd2621b..6547cb38480c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2807,12 +2807,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
>  
>  	mutex_lock(&group->mutex);
>  
> -	if (group->default_domain != group->domain) {
> -		dev_err_ratelimited(prev_dev, "Group not assigned to default domain\n");
> -		ret = -EBUSY;
> -		goto out;
> -	}
> -
>  	/*
>  	 * iommu group wasn't locked while acquiring device lock in
>  	 * iommu_group_store_type(). So, make sure that the device count hasn't
> @@ -2971,6 +2965,7 @@ static void iommu_group_unfreeze_dev_ops(struct iommu_group *group)
>  static ssize_t iommu_group_store_type(struct iommu_group *group,
>  				      const char *buf, size_t count)
>  {
> +	bool group_owner_claimed = false;
>  	struct group_device *grp_dev;
>  	struct device *dev;
>  	int ret, req_type;
> @@ -2992,6 +2987,14 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>  	else
>  		return -EINVAL;
>  
> +	if (req_type != IOMMU_DOMAIN_DMA_FQ ||
> +	    group->default_domain->type != IOMMU_DOMAIN_DMA) {
> +		ret = iommu_group_claim_dma_owner(group, (void *)buf);
> +		if (ret)
> +			return ret;
> +		group_owner_claimed = true;
> +	}

I don't get it, this should be done unconditionally. If we couldn't
take ownership then we simply can't progress.

But there is more to it than that, a device that is owned should not
be release and to achieve this the general logic around the owner
scheme assumes that a driver is attached.

So if you call it from this non-driver context you have to hold the
group_mutex as previously discussed, which also means this needs to be
an externally version of iommu_group_claim_dma_owner()

Jason
