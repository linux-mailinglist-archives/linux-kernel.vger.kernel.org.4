Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B825EA9D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiIZPLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiIZPK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:10:59 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB19EDD16;
        Mon, 26 Sep 2022 06:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIA+n0e6qg8XLMhGROgBqhNsp97o9Bdo2kVywI/x+PzVtxcm1tQdOIfnVEqejoBqRTfYeXoOzDRfztrVh9mbeRIOYY6Gt9rHmveumbvLu0SPu3CgCNxF9EpQpz371hL0HpweyLt9xg/2jH+jaNvRyYnf2EEdk08PCpI/SPW2wEQvXugJ5Sle9HV6BfdfDSGPZSrqBc4wTSeqzmud7FAkDnbw9CexMbNJ58w2gnPBwk8d3Kf3g8g6vCtyqLTTmuWre2Sn89IDW1QGfMTmkDU1l88S210uqc8lvTmWxhCQu9m76m/cHfYvLlOBJzFVn+VBplZIpurIAKcIRP709SwEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/L+/V+dz4K0dd+kIPz7ejksDOXbZSktCk+QwnWGLAs=;
 b=ZRh1iA+G+rBMg6fVZ7wU7QNGEzzwYS2oW7Lkz7QLJOMANN6mjiH2BzxvkJE2HZcu51gNk8HGDK4G/nlBArhGX4j7Fw7YTR9rTIMfviZnmZF9IYJEEjSCNfAMfqqD31HQJYOba7nJiUaaAVI8izabY7Uf2b/Uo+FZu+DX3yETXq4CNe1sU351ZUdo8oz3iia+hRzDgeLCf3KkV0JYcTe2ClDi0QpQa5vQHIPYY21mJmDx2q9YimR3+JWgLzyGPxFNLvT8plOLn5ZljvjcbGBJQNokH0QOdYS9NWWnKzchCItUEGrhqaez/lzwcsktl/+tu8GaGydWVE/JzsZFAK9CtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/L+/V+dz4K0dd+kIPz7ejksDOXbZSktCk+QwnWGLAs=;
 b=mvl1dZxou1exrQPGjSNAVLEhI36T5WwkX9dceHjE4euGG1gOZ/ydTjLQOj68OGDZG/20wQ4z06SWc/NPYQEGVU9PYyGQkh9moc+hkhgz2HQHhDq3IAGDrXV6mZe8rfPo9cNZBjpliYJkDqOsf+lNnxk+jVGUbtP/QX6A9YlXJd9pf5uZN9YdeDAnji9h8Fo4oNGRMg04bg7ps7KsG/+b9e2E/Hg/vCX4mpUn4GUdhD7bMTq658fKi0ZwyjiAJRsWcvhRVmCeKnuwsMwk5ijcuTEyZoLI/55FRf3JJ9o6qkl7F3rC4Rly3XS+F5P6W1eMcPfXJ6lOFlGvU7Li2wS8aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 13:46:42 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 13:46:42 +0000
Date:   Mon, 26 Sep 2022 10:46:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iommu/s390: Fix duplicate domain attachments
Message-ID: <YzGtQY+uw4ZzZoSH@nvidia.com>
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
 <20220922095239.2115309-2-schnelle@linux.ibm.com>
 <YyxyMtKXyvgHt3Kp@nvidia.com>
 <81463119aeadd55465cfac1f5bc6a8b79f0c9738.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81463119aeadd55465cfac1f5bc6a8b79f0c9738.camel@linux.ibm.com>
X-ClientProxiedBy: BL0PR02CA0140.namprd02.prod.outlook.com
 (2603:10b6:208:35::45) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CH0PR12MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 09551d74-046b-4230-dd40-08da9fc58b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ffGzGxZXgDDyf3iigZAJV79ysmvZliwIEbek3JruiQunWVQth+7UEO5JsHDAMV0eVwNOhGWCL2fzVqdcxfvnyMrFgOH8WZh44r4sIFpRwdoRccU1OF8QNgQtSBzH07j3L8J7pBMU5zWdEgUU0lVsye+oOwZrwqx6kHc46XDZP6aNPOhBfuBfHPU0f/8YrGLgJJd7roIaxu5f9GgyOFpqlSoXR9kG/2x91sMlW0AfxbeGgHAyC7ps1JrUziB0Frjyhl9IFWSEJXBOOYQl0hUg5QK0z9jdPuxZN1yfpnKKbA5vRAgFZnjM7iWTMmF7PMBMfx1tmX+RDF57ZdLxgeVLujBotzCtmbh+VHARpnyAllbrPz49RrFMC/2gIEbjJj0wOUxZ6aWEbeVHciWjtPpvoYl6okqbSxvxYkADTKexI2G/YP1cvNGwox5ufTKOAxP20fY1VYRHPQan8U9o//mGpMOWjdoIyI76Jje8HuGBU226G+sIT8HszS0Tk82yaZbRO6kZm8Xwz7zgerJyvYUuLGwPWpbzoluUvgeggKSR/aYa4mP82otLC5HtHUA9KHTdub8S2dh6kjfrB3OFJNxMMPjfZ+S1oqxuwCj8yfdOdb+LGZ98Q4nrF7iHI4KaybnpppPzOH4kwYNHRX5x0hAIVUbRDKaM9bEz76aXpiOt30/OkrDG/3gDecM41hHKeOBoWGyKe3bh8toQTSkZNwXDwtU+2hrCyia87BkFcLc2OaH3ox3ijnq1brTlxbqq7KdT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199015)(66899012)(2616005)(36756003)(2906002)(186003)(86362001)(5660300002)(8936002)(7416002)(6512007)(66476007)(66556008)(41300700001)(26005)(4326008)(8676002)(66946007)(83380400001)(316002)(6506007)(54906003)(6916009)(478600001)(6486002)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MvFWBSJa+FN/V2qE5hUYXRe+gEdojn7kyAvb7psVJEJrqjmzWYQ4R4EDAfSY?=
 =?us-ascii?Q?jbZyJ5Ji2PSmy8RtX0AeWy8PJ5AiszJ6PnnbzyL3SN+8iKR6x3LMW4jSVUYu?=
 =?us-ascii?Q?P3G74tDhlT9VGJN+gX8UabHji9gRm8tGi6dj7ZfmmbbBj1vLmB5hheBMmQUE?=
 =?us-ascii?Q?I31SEHdEkY9TWzTOJBisDe96ae3Bjnt8OT2azRmBP5iRhqmKuIRTGfRd7SR7?=
 =?us-ascii?Q?Gjztnz+mHtMzoKwqsf9azUl86QRIpfhL2R93OisKDV3xw1ycXsUdn9x6R7Fj?=
 =?us-ascii?Q?vXWLYa/2ghrYYk8gtbGHd85ZQpan52ZRO7wy6/oJCQcKS9fedCyAURn2zgbQ?=
 =?us-ascii?Q?4BktROK77JQDJYBZhOIp6hwE5TnWZb+qW6RvOAiicw3etAO6Bkfm+44WM2Kf?=
 =?us-ascii?Q?q3Ih48Q0IfdAksfZQjyeng0FYmUgBwlooOQ8DareuEL83sZqvba55eBhZLPd?=
 =?us-ascii?Q?ElzJJY+sMdODxfVPU9+q0g0c7U36MAurTuxYGtFg/KwUGTV+q9mmzkScMxbP?=
 =?us-ascii?Q?PUxJ/mjlUluBmiJH754qNAABZPQ/5uwMXwGMzH6p+hPCIvdUtqy8K/r+PLKT?=
 =?us-ascii?Q?h5A6dfB1/lHD1i17q/9CxSvLtsIlyrQgrLNkaVuulPQBmpSTUJ3wKuasyhFq?=
 =?us-ascii?Q?cLea8+156zRmeZ/h8uAPj4kHnAEiUgRBTbOaJmhocsAR2sW5gwi3Pu+2mubD?=
 =?us-ascii?Q?fEq0rSeyZ30n94M2VgTqaYRYy2Ji/IJG7iC3Lv5JhaoK5e+vgsa7XxR+WaY0?=
 =?us-ascii?Q?hgPO14b45fID9d0BuLfkllYQ1wrJunjd/J3CHyLZUudgrrwvutDzdcOxNKrx?=
 =?us-ascii?Q?R0NmRl1hKBWTNe/75DCmrrncSDBveYxJ/5hfeLslLnlBi1kCwsg2z66+ToiX?=
 =?us-ascii?Q?0Z6JKS0TEhEq18DSC93neecSfR2zH00beTxp7brEjKLGR3FWiWeABkv68/b9?=
 =?us-ascii?Q?9yjXC2b9CXTubD7qRZYBzfqSVh7rl8KLNph1ry/ZBELb9OoYYUnEVAWkpsLF?=
 =?us-ascii?Q?aQvUCfzzicApmr04mRYm0B1Kth665w30qVLpcq8vNjHjGovGsySYohw1BNIY?=
 =?us-ascii?Q?/nMfbnpoB2tJz++LkzhDW/XxmcQQYpbe8pSMJgdXZY8QjMmWntQqK8UYDVwA?=
 =?us-ascii?Q?zgn3pqosTCPczzbwBAa+5LXzmvRFxmRzV1+xXKSOOCNmyMuWVwBlEQjSZFzh?=
 =?us-ascii?Q?dPhJ0qLiQCEwe49819j3FeT1+Y6ddX2Jo2vZOdnLTkmzHw+qfG4b4dH6YEiD?=
 =?us-ascii?Q?f/qpzOVbnVbksXRgoj6oYQGGl0Io15+35demlxbDpxL9g8tdYYrkpXn5KXPy?=
 =?us-ascii?Q?RyWy+kqgTLpwplRioFA/v0V9KLKKbPKvGpSjwSqOPVmpHPGyt92MOTK1XOdL?=
 =?us-ascii?Q?0tQECFks7avRUhizUri7tUOJILM/1wKmDjOcQU17PbMyk0ktLdzta9ZN4jl1?=
 =?us-ascii?Q?nsm2XFbVAsK1IVUD7KJ73gZTFVhJr9B7X+PmDK9czD76A002EcY+fDpGKsAh?=
 =?us-ascii?Q?QJVdATaIssqT+meemOtOeH/nM5jq5zEa3HY2zkcs5+TL5gssE1IVo+cqITrB?=
 =?us-ascii?Q?YQ8WFIznJcVkVPzaxYE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09551d74-046b-4230-dd40-08da9fc58b6d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 13:46:42.6390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kv7Jh55Fu6GxsCPkQX8kxyf6Hsl8i2SwqGkaV+SX53RjSxqdsuomgId7wdVq4YhJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 11:00:53AM +0200, Niklas Schnelle wrote:

> > > +out_unregister_restore:
> > > +	zpci_unregister_ioat(zdev, 0);
> > >  out_restore:
> > > -	if (!zdev->s390_domain) {
> > > +	zdev->dma_table = NULL;
> > > +	if (prev_domain)
> > > +		s390_iommu_attach_device(&prev_domain->domain,
> > > +					 dev);
> > 
> > Huh. That is a surprising thing
> > 
> > I think this function needs some re-ordering to avoid this condition
> > 
> > The checks for aperture should be earlier, and they are not quite
> > right. The aperture is only allowed to grow. If it starts out as 0 and
> > then is set to something valid on first attach, a later attach cannot
> > then shrink it. There could already be mappings in the domain under
> > the now invalidated aperture and no caller is prepared to deal with
> > this.
> 
> Ohh I think this is indeed broken. Let me rephrase to see if I
> understand correctly. You're saying that while we only allow exactly
> matching apertures on additional attaches, we do allow shrinking if
> there is temporarily no device attached to the domain. That part is
> then broken because there could still be mappings outside the new
> aperture stored in the translation tables?

Right, go from 0 -> sized apperture on first attach, and then once it
is sized it doesn't change again.
 
> > That leaves the only error case as zpci_register_ioat() - which seems
> > like it is the actual "attach" operation. Since
> > __s390_iommu_detach_device() is just internal accounting (and can't
> > fail) it should be moved after
> > 
> > So the logic order should be
> > 
> > 1) Attempt to widen the aperture, if this fails the domain is
> >    incompatible bail immediately
> 
> Question. If the widening succeeds but we fail later during the attach
> e.g. in 2) then the aperture remains widend or would that be rolled
> back? 

I'd leave it widened.

IMHO I don't like this trick of setting the aperture on attach. It is
logically wrong. The aperture is part of the configuration of the page
table itself. The domain should know what page table format and thus
apterture it has the moment it is allocated. Usually this is the
related to the number of levels in the radix tree.

It seems to me that the issue here is trying to use the aperture when
the reserved region is the appropriate tool.

eg I see that s390_domain_alloc calls dma_alloc_cpu_table() which just
allocates a 3 level radix tree. This means it has a specific max
address that can be passed to dma_walk_cpu_trans(). So the aperture
should be fixed based on the radix tree parameters.

The device specific start/end should be represented as a reserved
regions per-device. See patch below..

This is meaningful because it effects when VFIO can share the domains
across devices. If devices have different reserved ranges we can still
share domains, so long as no mapping is placed in the union of the
reserved ranges. However if you vary the aperture, like is currently
happening, then the domains become unsharable.

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index c898bcbbce118f..ba80325da76cd9 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -51,6 +51,12 @@ static bool s390_iommu_capable(enum iommu_cap cap)
 	}
 }
 
+/*
+ * dma_alloc_cpu_table() creates a 3 level table, rtx, sx, px, so the address
+ * that can be passed to dma_walk_cpu_trans() must be less than this.
+ */
+#define MAX_DMA_TABLE_ADDR (ZPCI_TABLE_SIZE * ZPCI_TABLE_SIZE * ZPCI_PT_SIZE)
+
 static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
 {
 	struct s390_domain *s390_domain;
@@ -68,6 +74,10 @@ static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
 		return NULL;
 	}
 
+	s390_domain->domain.geometry.force_aperture = true;
+	s390_domain->domain.geometry.aperture_start = 0;
+	s390_domain->domain.geometry.aperture_end = MAX_DMA_TABLE_ADDR;
+
 	spin_lock_init(&s390_domain->dma_table_lock);
 	spin_lock_init(&s390_domain->list_lock);
 	INIT_LIST_HEAD(&s390_domain->devices);
@@ -119,18 +129,6 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	}
 
 	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	/* First device defines the DMA range limits */
-	if (list_empty(&s390_domain->devices)) {
-		domain->geometry.aperture_start = zdev->start_dma;
-		domain->geometry.aperture_end = zdev->end_dma;
-		domain->geometry.force_aperture = true;
-	/* Allow only devices with identical DMA range limits */
-	} else if (domain->geometry.aperture_start != zdev->start_dma ||
-		   domain->geometry.aperture_end != zdev->end_dma) {
-		rc = -EINVAL;
-		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
-		goto out_restore;
-	}
 	domain_device->zdev = zdev;
 	zdev->s390_domain = s390_domain;
 	list_add(&domain_device->list, &s390_domain->devices);
@@ -152,6 +150,30 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	return rc;
 }
 
+static void s390_iommu_get_resv_regions(struct device *dev,
+					struct list_head *list)
+{
+	struct zpci_dev *zdev = to_zpci_dev(dev);
+	struct iommu_resv_region *region;
+
+	if (zdev->start_dma) {
+		region = iommu_alloc_resv_region(0, zdev->start_dma, 0,
+						 IOMMU_RESV_RESERVED);
+		if (!region)
+			return;
+		list_add_tail(&region->list, list);
+	}
+
+	if (zdev->end_dma < MAX_DMA_TABLE_ADDR) {
+		region = iommu_alloc_resv_region(
+			zdev->end_dma, MAX_DMA_TABLE_ADDR - zdev->end_dma, 0,
+			IOMMU_RESV_RESERVED);
+		if (!region)
+			return;
+		list_add_tail(&region->list, list);
+	}
+}
+
 static void s390_iommu_detach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
@@ -376,6 +398,7 @@ static const struct iommu_ops s390_iommu_ops = {
 	.release_device = s390_iommu_release_device,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = S390_IOMMU_PGSIZES,
+	.get_resv_regions = s390_iommu_get_resv_regions,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= s390_iommu_attach_device,
 		.detach_dev	= s390_iommu_detach_device,
