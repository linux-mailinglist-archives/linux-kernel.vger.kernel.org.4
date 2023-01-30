Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E1A6818B5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbjA3SVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbjA3SVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:21:17 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5263C2BA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:20:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7pWjTf4A/7jb2mshFOd09iYfOJb8CEcLA9ckI+RjmgtDX4ygwS7CyHRzvpQ8tU2qefLSDelq8hSi3om5vF2fFee7uL25Tr/0FC4UsUUmeyeK/H7jcm3bi3+pSDI5Y2G+YQwNBW2dcq/BBsgcYR1We3XYSsONYw/2l2JvrHw4hSyxOjC84gKK4nVDF8c/XK30ZbpqQxvPl+vrQQt8qHfitaWMKA3m9FurCPI93WgXLPCqF+8pQCWOeSxTJNqdi19Fe7CPUJWrs6ZgFUK5I1Y7mggI3/iXMCk2Woz41yM93c96xLEUqa2+KO91kINfQPiXI8GKKKZh1/lHFjbvPogmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hurKCqIE4opkd7qf6mMDkb7MMhfTOpaD6rrZTeGFnlU=;
 b=cp16YhVZc5IDU0WRoTPSnb0C5x7PH7LOqscxC+ZUMtYXrpBF0QTHCGD15lwYk2BZGg+TAVVlBC93bKWEj8NzfFDqJWrymEqc4DvNlctiZipfHuc+5K4KOgtDYQDeVYeHua2bWq44qlCtmXKfXaY6UljZSMnLLhib/18fPcRpiqydAzlwwhxBKh2f70NaOrjVwmNSWIMC1hyu7I3pr7fcW4Z7Hr3A5roNWSqsXTDPgF4xE6q8jI1d73svVqYZVISIOuRxUUTdI/OzGvbsSE0KJxYFuDmftrL3pUCQShVEEv7GbVGeJ9IpbmIFayRJtrK9kfnrBOd6V44XYBwmq2BdmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hurKCqIE4opkd7qf6mMDkb7MMhfTOpaD6rrZTeGFnlU=;
 b=Ddfts0Ky3TiWx0YDc2EakWKDLqDF9qmR2w8DAE+4w3josyLDmSCZae0rB9Formx35mptAEfPQiEnFcdEW65GTLxtSPyIhsszT7EimowvLRJ4zxPt5jFN0hn1c7Sb2rZtRChCJEPdGPvDYtXXZHWmWz6ojW/UoOj2bAvjL+xnfpHWhqc9cXo3UbUIKQghXdInWf8HSunIUx5MRtskE2UV+NbGIt6n+MY+TsBwlJQVcnkpefJa4tkk1vq1v6Kd0JF4jAMwfFZAjGVtSrvCD0+w3ZVghpmV5t5NZ84cJskCIiyweusI8JDvoeZDKk2fR4nAAAELk1KxHrbKeMYxJuf0Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.31; Mon, 30 Jan
 2023 18:20:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 18:20:44 +0000
Date:   Mon, 30 Jan 2023 14:20:43 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 4/8] iommu: Factor out some helpers
Message-ID: <Y9gKewvVuVsrB4nI@nvidia.com>
References: <cover.1674753627.git.robin.murphy@arm.com>
 <959a1e8d598c0a82f94123e017cafb273784f848.1674753627.git.robin.murphy@arm.com>
 <Y9fyaRGp7Q8E5to2@nvidia.com>
 <01b0254f-41b0-2cbc-7d47-5507258f35b5@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b0254f-41b0-2cbc-7d47-5507258f35b5@arm.com>
X-ClientProxiedBy: BL0PR0102CA0009.prod.exchangelabs.com
 (2603:10b6:207:18::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 8583b31b-a241-49c1-e56b-08db02eeb36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NPKXF/+59eYSvGp6elMoT12SU0ssnHiZ5Khsuvn78qPoFpiDAaeq8NTObLsRqy7eeCeR08Puvl1xHleGC0WBzO/53m0c5nkUYrroW6o+XXoi2W9AsIZncbAPmdOBKj/yWe+i/oxMxHGWepZZOsg1f9+F6xSsd5UEA7V3fTrR66woWSM5ne1a0Fpdlg9gZKPKnUMnuUjERqSh4KVhKRUi9JOO8HkvBtzzdpzkmQCdHnJtyLadNX60nzmy4jB6jLfEY5GcJ1JkSYNF45Cap3fRCmHGvRkg++XTWWInhYIzCljBA/wxxjVzOW+zUb5qaG+l8nQyXRlDlUiohk2Q95o1Vo7X6sI8tpNrvj6nKidrs2Sat8fePPnTR99Eo8f4IwkBag6515TCOEfEvRAWhCvA2g0Hw2l2eTk9Uu93mdh/BAdXoPTQcpEGcXC23bo/hoEws5agQrSPHDojUCl8lG9dejLgByCGrQPAj/v0vM1Wv42Uc9QQCyhh3pgVzfdFjA285Gn3YOdd3pAdGFF3oZ3FbW+FQ8KXJ0N5rXg90fQm5aSA7ysdsCm25QVjxajuMU9TaAam1ol89SAD7lpHHp1euDLAKNGseOLVUJOMqXdrCpdTMhJFFeTbl/OpS3tBbpV5Kve1fdSCYMqxoGRzN01XoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199018)(36756003)(478600001)(6486002)(41300700001)(86362001)(38100700002)(2906002)(2616005)(6506007)(6916009)(8676002)(4326008)(316002)(66556008)(66946007)(8936002)(5660300002)(186003)(66476007)(26005)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gl7sWWsNqkg8VBNsqEn69IVsHU1MMd8+2KtI2ELv21xH75KTyOCTXeYwFiOz?=
 =?us-ascii?Q?VSoKZQLiyumFM3ifgnBNzQULN2NcjHzl9WyUdHfKO4ISejlnnevstmHGF6iZ?=
 =?us-ascii?Q?pZHGaN+hXG92I0QJUPXRCl1oIlX3aHAr3uKe6DLRv4XClaPWOQ4VDMKvphLN?=
 =?us-ascii?Q?xJlFYrylNouywGwr989PzUfOMaGm+/X+gM5AMPe5GrlTO9e3QzKxkNRcxhVq?=
 =?us-ascii?Q?qNHqZP6V1+ExcgAgNvu40UcBPb6QUXrJm2W5tp2KGsMgDWfU9SG3l+gZYAbx?=
 =?us-ascii?Q?QtZ7HWpjdvfcw5kOyx/Jk4BxM5Ku4AbA94gof6EhYRzFr9z1gcMsRi9rkogJ?=
 =?us-ascii?Q?MNFZjR4Dc6hOUYLi9HmYH8u/sW2tMhKRrH4FA+/PSr9yzn7pmy/jhDi3Wdmd?=
 =?us-ascii?Q?JnINFQlMMMrWlXRnPL4ej4d/n/vpa9NGm8B0KbYRe0A3m4CAbSsWdO0lEJ/q?=
 =?us-ascii?Q?UagmERYsETH9RBzJ/zfnSrKBN9baPwRuv20QZoohZ7KV/Piot8Jrmz0rcHF9?=
 =?us-ascii?Q?SrTYW8jRHSTQH7Pzc7zo4UvR9G/kSwKWyLlQ0J4f3VOg6xk8UAOiiDJIWWz7?=
 =?us-ascii?Q?1vH3mreCzQZmxcsOwByYUzr105hnvfNmlwTIYlYrLzWkfI63Ez3ZKpVrMSqp?=
 =?us-ascii?Q?e2cUfVRbZjvPg12kO1n6GJQFzVSTHovewvhYXC70TzQ6RCBamBbSKYNA3bFV?=
 =?us-ascii?Q?V2YU/p2Eclectk5WL1hcukXK+PrGyuPMv6KPpSCmTt+NNaKZktzjpnIjWiZx?=
 =?us-ascii?Q?wtDJCga+WsjxsBqFgB3QNpiLF36U5MdngMa2sJHoOX2JVMKpdj4YovrH9j2i?=
 =?us-ascii?Q?1e/exK32l7qzsoINtDDN2L0g70a0TjlXg2AhLlt7WxvCXqMBlkZLU/loTfzV?=
 =?us-ascii?Q?lt3N8mcwc66ZqX9OwsvnyllyEwicRn7tBiPD42mZcHjVmaOED0wIZAb2pLc0?=
 =?us-ascii?Q?BySbKSCB+Ml4NolOr2gEXy4UvPzrQg2n4GlIcIzuYDenoWiS/1kKcfYEDe76?=
 =?us-ascii?Q?XHsyiYyfEKWA0/sQnkFCZ/tsStxBtum/NxlbBXd7jhPX7z9w/EGsVHT74d1N?=
 =?us-ascii?Q?E0BVtoOylXDC1ZhZnRforMNJ6Uwfx1UyIyjWVbDMEHcSKRcvQVV3TiVLWU2C?=
 =?us-ascii?Q?Buj1KrT4KQxsgmqDwp3TkYDjScdshOSZA33rNzZ/LbbBf+Cqn17s/QAaDZ0L?=
 =?us-ascii?Q?SnvwRhOO9Z/ezfCNyRzUJoZmPTqDndQNMZjGFkJ31WI3pDFTAzW+72SSNX4n?=
 =?us-ascii?Q?aVBtp2vtNTGofW+FRUrSNKD5dFApxLvFGso+m8uhK+0ch3CdPS5YibJ7iS4U?=
 =?us-ascii?Q?Zqcs2sXYYwBG6satXqaxRvS+yngk5yvCBCmkH7pn4NdOoqwcFuN2fqUvzJHU?=
 =?us-ascii?Q?VC7O9kRwi728Ex6PL7fU6BlzLVx3hVcsoLeDTNFVAUfo/SLPhHGsrjSrsCtZ?=
 =?us-ascii?Q?Q/29YY/b2ku2zemMz65COpZb9gtDHp6LQKo9UkktlAy9NWsPyFpBfiLA0XXD?=
 =?us-ascii?Q?nHTiIhm4G6d7W+T6Vj16WFkYRh1U8vlycgEDmxZA1rDvVT63s8+xOhz+i6FW?=
 =?us-ascii?Q?wMb2unYgvLItRwBC+UdmoIoBy+pYFJ8k5n/PdKZf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8583b31b-a241-49c1-e56b-08db02eeb36f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 18:20:44.0233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qu/S1jOpoL99uqiS9L6PxZmNrwZd7laHOiUNC0S0e9LcpHuMXYgv+QqJfI4kxwSP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 06:05:12PM +0000, Robin Murphy wrote:
> >    * Use a function instead of an array here because the domain-type is a
> >    * bit-field, so an array would waste memory.
> > @@ -338,7 +352,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
> >   	dev->iommu->iommu_dev = iommu_dev;
> >   	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
> > -	group = iommu_group_get_for_dev(dev);
> > +	group = iommu_group_get_for_dev(dev, ops);
> 
> Why? We've literally just assigned dev->iommu->iommu_dev 2 lines above; it
> is not allowed to have invalid ops. Plus in future they may potentially be a
> different set of device ops from the ones we initially found to provide
> ->probe_device - in that case we definitely want group_get_for_dev to use
> the proper instance ops. This is the only place it is (and should be)
> called, so I don't see any problem.

Sure, but IMHO it was clearer to pass the ops down than to obtain it
again. But maybe this could be tidied in a different way.

> >   	if (IS_ERR(group)) {
> >   		ret = PTR_ERR(group);
> >   		goto out_release;
> > @@ -414,7 +428,8 @@ int iommu_probe_device(struct device *dev)
> >   	mutex_unlock(&group->mutex);
> >   	iommu_group_put(group);
> > -	ops = dev_iommu_ops(dev);
> > +	/* __iommu_probe_device() set the ops */
> > +	ops = dev_iommu_ops_safe(dev);
> >   	if (ops->probe_finalize)
> >   		ops->probe_finalize(dev);
> > @@ -430,14 +445,13 @@ int iommu_probe_device(struct device *dev)
> >   void iommu_release_device(struct device *dev)
> >   {
> > -	const struct iommu_ops *ops;
> > +	const struct iommu_ops *ops = dev_iommu_ops(dev);
> 
> This is just moving an existing check around.

The point is to have one check. If you need to get the ops and you
don't know the state of dev then you calll dev_iommu_ops() and check
for NULL. Simple and consistent.

> > -     if (!dev->iommu)
> > +     if (!ops)
> >               return;

As you pointed out below this isn't even coded right since iommu can
be non-NULL.

> > @@ -2620,7 +2626,11 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
> >   {
> >   	const struct iommu_ops *ops = dev_iommu_ops(dev);
> > -	if (ops->get_resv_regions)
> > +	/*
> > +	 * Non-API groups still expose reserved_regions in sysfs, so filter out
> > +	 * calls that get here that way.
> > +	 */
> > +	if (ops && ops->get_resv_regions)
> 
> This is just moving the existing check from the public interface to
> pointlessly impose it on the internal call path as well.

Who cares? We don't need to micro-optimize this stuff. The fact there
are a few bugs already is proof enough of that.

> >   		ops->get_resv_regions(dev, list);
> >   }
> > @@ -2979,6 +2989,11 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
> >   	/* Since group has only one device */
> >   	grp_dev = list_first_entry(&group->devices, struct group_device, list);
> >   	dev = grp_dev->dev;
> > +	if (!dev_iommu_ops(dev)) {
> > +		/* The group doesn't have an iommu driver attached */
> > +		mutex_unlock(&group->mutex);
> > +		return -EINVAL;
> > +	}
> 
> Withot any ops, group->default_domain will be NULL so we could never even
> get here.

Fair enough, deserves a comment

> >   	get_device(dev);
> >   	/*
> > @@ -3301,7 +3316,7 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
> >   	const struct iommu_ops *ops;
> >   	list_for_each_entry(device, &group->devices, list) {
> > -		ops = dev_iommu_ops(device->dev);
> > +		ops = dev_iommu_ops_safe(device->dev);
> >   		ops->remove_dev_pasid(device->dev, pasid);
> >   	}
> >   }
> > @@ -3413,6 +3428,9 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
> >   	const struct iommu_ops *ops = dev_iommu_ops(dev);
> >   	struct iommu_domain *domain;
> > +	if (!ops)
> > +		return NULL;
> 
> Anyone who incorrectly calls sva_domain_alloc() directly without having
> successfully called iommu_dev_enable_feature() first deserves to crash.

Lets not build assumptions like this into the code please. That
iommu_dev_enable_feature() thing is on my hitlist too :(

> (Incidentally, you've missed enable/disable_feature here.)

Yes, because they don't call dev_iommu_ops for some reason. It should
be fixed too.

> > +/* May return NULL if the device has no iommu driver */
> >   static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
> >   {
> > -	/*
> > -	 * Assume that valid ops must be installed if iommu_probe_device()
> > -	 * has succeeded. The device ops are essentially for internal use
> > -	 * within the IOMMU subsystem itself, so we should be able to trust
> > -	 * ourselves not to misuse the helper.
> > -	 */
> > +	if (!dev->iommu)
> > +		return NULL;
> >   	return dev->iommu->iommu_dev->ops;
> 
> This is actively broken, since dev->iommu may be non-NULL before
> dev->iommu->iommu_dev is set (a fwspec will always be set before the
> instyance is registered, and a device may potentially hang around in that
> state for evertt if the relevant IOMMU instance never appears).

Sure, I missed a NULL

> Sorry, I don't think any of this makes sense :/

The point is to be more consistent and not just blindly add more
helpers. If you need ops then ask for the ops. If you aren't sure the
dev has ops then check ops for NULL. It is pretty simple.

Jason
