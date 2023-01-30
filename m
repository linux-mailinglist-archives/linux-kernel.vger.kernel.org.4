Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871AC68168A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbjA3QiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbjA3QiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:38:06 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE556196
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:38:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oS+NisKxeLSG4mU/sEonGKmpGmRj0xL3j6zHnXiZOEVg9R6XTeSv/qSLHTfYX6WNTioGjpcO4LhqRSqIheSM4xbdJTleBSw6FcuJy4Ku6F6A1TFf3maxsdf+Xw0UI/+I0Q4P61U7PAgjROpN51owUlIEKMvdbE3TINuR9c4lTjHDOowjHSuzYxQOE8auWaTBXHMUFDWxFvpUTqwlEzq3XurCutuyBr9tCSKrVxK8UKMondmvWzhAx1ndJQJqS5T+5FbPVY6jHYtjd53K6xAJ56Tm00w6TZD2eW7CstG9X0fAwpUAUxYHrD89iVtAk+LvMZgj7mxcKOHbpfQ58opXlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te/vxErji1S3SiQMIGGgrYjdWTPSViG0+52l/AMJ8w0=;
 b=ZmYrbq0r0aVsxg0GdPwouxZKZxP9Q9JQdQZ4rcG2HT6/aXPvFRRg8fPUxtiHeUPf21B6LrJcmiV+oqEOt0KjXC91QacwIyAHbf7+JTy5HEN70LeMKSGVubSFO2ycw4Ugr+JVNUnvdX6cnm8Ux4CBqwNt+KWBEKC2yewS54SdIRV2EhzeEWqUG/fBu8EE/BwMmqTmyArX/JkeLxbpFtQFTaHXmarN6ke4ROUxNfmFhoeb3iIPpoPSPlPL9FWhrPAa7VnaPG1ztOX9v6F7coCtpZFphErRmaalZhBJtQgJ+rAFSw5sYPKpPSjAp84pRJWcnX0k5C0epgE2Oe7dIsK1gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=te/vxErji1S3SiQMIGGgrYjdWTPSViG0+52l/AMJ8w0=;
 b=ilOFuWUCQ4zAxXvApy9s57AZZj7Ejiim3NeH3X0GOcgyFbhfR35OMhlHmDwRLB9HNuw/TV7wMuzTcHBCbSZctMl9SReB3gWYgTnuJwVZ+300d4+dC4IEpECTy24Y91ix8MqwGrhxauSQS9uYt5VpR+ItPXfeFx4zFva/Qw1Zm5QP75yzsux+Y9fJBnPCXgeE/Vb8nQABr8pRnGJ3Pjwt7gGetP17YqR3cDMc/OXaR4PlI8zy9I0lbq/83RBPLh028dIl99Z/BdNi2JpdjLEIVrfu0ir2+HxyqphIXsZ+MTeDdgk6YJOwMBKI3z11aDGYzaK7+q1JCEX7ss+d5YkMrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB8497.namprd12.prod.outlook.com (2603:10b6:8:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Mon, 30 Jan
 2023 16:38:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 16:38:03 +0000
Date:   Mon, 30 Jan 2023 12:38:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 4/8] iommu: Factor out some helpers
Message-ID: <Y9fyaRGp7Q8E5to2@nvidia.com>
References: <cover.1674753627.git.robin.murphy@arm.com>
 <959a1e8d598c0a82f94123e017cafb273784f848.1674753627.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <959a1e8d598c0a82f94123e017cafb273784f848.1674753627.git.robin.murphy@arm.com>
X-ClientProxiedBy: BL0PR1501CA0009.namprd15.prod.outlook.com
 (2603:10b6:207:17::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd4f750-c8c3-4619-7fa5-08db02e05b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6yyTIceai1o0DqAi9mtFQqcAq9eIYqTj/0RRNC6/E62JOIKmb5RPru+XVlV9oZmU3iKg8jyevYFkrX4pIN0yT3kl/Yk4aVhynbVYnP0t2sfTfcqMMRKGpffuEzqQMtwfau9Egt/ZGfIZyG6gI0Lniw8AT1NqGzJ7lM8fEtA6ZG2pLUYxsjUTGAH3RauoD5/RoTcA4KVVbJHEqybvgL+3KN1xEcppBLjEZGfwVyWsaL91gx+kRpOLzXqt5dUy2m8d+A3pwjbSIvZR8jYMcVgbS+WnMlA/pxh/pL4XBUCEwHMtKgkC/DDozG15Z9vhu/nHfUvNEA7UICk0IcpFnmynLFkWpzwt7kyA3P/UOh1u34/y39n+9lw4hMmkZGjbmkMTRNy1Bp+10itno6vfxzZ+jaNKR8uy2m8HsvdnC4BRvfTp7EKT4AlPsI4bWIdQlagwnirXrp3t/rxS+YYlvwgA9bmqJ2gmaQrUPJLJI5tW4mWCPE3k6yXx5nnoN8e+51mCqBWcYGPeUy6Jxc2gXrfwXSWxxpofgpZgKD821ZzwaPy26wLaxNdADYz8oLYcEfZqhsDwRKUn7G6kQ7OuemxFvGwOx/DHKu32Vs8iZxPo8TVc4XXP6VmYwgk/dvG601CKM77+Xk4darTKJZcJtDO6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199018)(6916009)(5660300002)(8676002)(83380400001)(4326008)(66946007)(66556008)(66476007)(41300700001)(8936002)(316002)(36756003)(6512007)(186003)(2906002)(26005)(478600001)(6506007)(86362001)(6486002)(38100700002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?leY0Ev68jybJUrVzgaY12lzQgWH640WpnEr0UYNWHYqwtYms2t0wNUJ/yXxX?=
 =?us-ascii?Q?aFrWcoXRxH93FSyBEa8xqj2W9P382103wAdunno2JZXxFRPjg7DU/JAnFonw?=
 =?us-ascii?Q?L1T8AeX3GwsO7id5DWz4Wc5TsNNJc5LNUVlSYIfyqZlXW8zKIJGBvj0uRz3X?=
 =?us-ascii?Q?r7TjgKq3mYbF2cxf6WsX8wLL457bS6XSKHXOQ/tyuKTP96YdYIUQEImjLI+G?=
 =?us-ascii?Q?VXkE19iYcZ6MA70Xm8TcvXrM1F77MO4oW55hahvYwL6O9vFwhJhPx7wut4LI?=
 =?us-ascii?Q?TUc0DvU9zehqZkXqqqBJyFYh9lOY4L2GEzLsNOLV4wr+w+AYTvFxg/VmrDsq?=
 =?us-ascii?Q?1S2PA+TvMa+p/q7sUhROy7bcBFcAcUtmlH3DbV9j69+ZlQrFnz1VkE3rUgRY?=
 =?us-ascii?Q?jkDwbh/qPGruB1/qkhCm1T16oieyhI7Uqfv6cb4kRo2+pDtbT6CnQBkW2kcX?=
 =?us-ascii?Q?iv69YzE9BKUfvLI5nzaP8L1siyIJHoJj0jb0o1g2fCEeKHMUpcU5E5HHNkW9?=
 =?us-ascii?Q?2+Ya7YUsDQ45m59wqlRxC72iyEEOYRlxB+dprRypOcb8dpcAWzxaF3Byq/iu?=
 =?us-ascii?Q?Ewj9BZ2UTN8BfxMcl3F4zODAIEFmUQTOV2DrYeskAKH29IHIfK1g9hhuv6my?=
 =?us-ascii?Q?92dCXgEcHkXKyjv6yerIJwAbX8KZ63BZgSU7gQM7AwWIM8jK6mM5eKLYjSo1?=
 =?us-ascii?Q?FfUh5PXNnX0o/BpBsMET7+Tsykcu/7Ft+mMzWvoLkXx4k0JBjvNuqD97Ukxd?=
 =?us-ascii?Q?yRctxwwefbhAiebpadTx4HR2NvaoNmeE3Nae6BRmmvl4DsAFie0F+mmpvt/N?=
 =?us-ascii?Q?WFPLIvsiwMk7j3tdgvuKV8ZuCLOArcIhL3atjAy2bDoLKodGXijeiujGE4tG?=
 =?us-ascii?Q?Wi24csPNV29UXstRzxE160YoTr92RMxOhE6dyKcZJmkmY/7d5K19H1IxT7nz?=
 =?us-ascii?Q?k4ykUUroxiC00H26R+aJ/4FSaAboPLczdElA7kC78VLkLYjGb/YYHZhX2QlM?=
 =?us-ascii?Q?pbh4tcBYow1Ge5BidPuK8HlY0pEClgq+LWyd2n7/LfqvH0bJCa1Dg7bW1Nax?=
 =?us-ascii?Q?JcHi/6HfMYg49j8GRVNQx8q/EpGTE/I85vsP6jqHohE1vzb1JvICF9yvJ0jr?=
 =?us-ascii?Q?E187omAJP8oQcB99B5B7udy7mvmJlVEyizVk1Vg8J2CQibhc31RpOQLRwPA5?=
 =?us-ascii?Q?F1ZkbiBCWn7TMQwFW0g3imyNzvABqF1tNu5nCWsXybjddo+lBFKZC2E0tSpf?=
 =?us-ascii?Q?OXKvdFmu0T4F3wLFzBuq+hhnOFNi2Uy75UY8VQw392PYk+2m7raTZ/VM/keI?=
 =?us-ascii?Q?dPTi8jozRSN4RVDviHs/n1o5hIkb2CMA6DD4MryDiTZ/902ooHZcx7oxErXk?=
 =?us-ascii?Q?N3zBUY5hSdkCLBAvKSeBpOXH2SOil2GQOh8wykk1pknjO6Ln2clvcngWQjS9?=
 =?us-ascii?Q?lSkHV45SPIcH/3YfDVrxsfBeluDzSwIIzk2oCH0ykaK+D+MHL61+cs4buK9x?=
 =?us-ascii?Q?csPHy4xqmOY/GSFwMngL97OuEC0tBFVbYnHVBxM+GzSuL7yOAcAcBgIt5lPP?=
 =?us-ascii?Q?u82tbFdQbtBy4GENQzcSl4ISaOmDd/XIDzy1fwB9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd4f750-c8c3-4619-7fa5-08db02e05b30
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 16:38:03.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vD4GW6LbllSobBIUgftYGECpRvH+0dOlwDfreSl29h3w6PJ85OjYuxOQreJ3K04
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8497
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 06:26:19PM +0000, Robin Murphy wrote:
> The pattern for picking the first device out of the group list is
> repeated a few times now, so it's clearly worth factoring out to hide
> the group_device detail from places that don't need to know. Similarly,
> the safety check for dev_iommu_ops() at public interfaces starts looking
> a bit repetitive, and might not be completely obvious at first glance,
> so let's factor that out for clarity as well, in preparation for more
> uses of both.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: - Add dev_iommu_ops_valid() helper
>     - Add lockdep assertion [Jason]
> 
>  drivers/iommu/iommu.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 77f076030995..440bb3b7bded 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -284,6 +284,12 @@ static void dev_iommu_free(struct device *dev)
>  	kfree(param);
>  }
>  
> +/* Only needed in public APIs which allow unchecked devices for convenience */
> +static bool dev_iommu_ops_valid(struct device *dev)
> +{
> +	return dev->iommu && dev->iommu->iommu_dev;
> +}

I did an audit and more than half the callers need this test, and a
few places are missing it already.

We've kind of made a systematic error that assumes being in a group is
sufficient to prove there are non-NULL ops.

So I suggest that we make dev_iommu_ops() return NULL in all cases
where there is no driver and have a new API to get the ops in cases
where the call chain knows that it is safe, and there are only 5 of
those cases.

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index de91dd88705bd3..4b04ad50de8d6b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -98,7 +98,8 @@ static int __iommu_group_set_domain(struct iommu_group *group,
 				    struct iommu_domain *new_domain);
 static int iommu_create_device_direct_mappings(struct iommu_group *group,
 					       struct device *dev);
-static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
+static struct iommu_group *iommu_group_get_for_dev(struct device *dev,
+						   const struct iommu_ops *ops);
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count);
 
@@ -130,6 +131,19 @@ static struct bus_type * const iommu_buses[] = {
 #endif
 };
 
+/*
+ * This may only be called if it is already clear from the calling context that
+ * the device has an ops. Seeing the device is part of an iommu_group is not
+ * enough as VFIO and POWER put devices in iommu_groups and do not attach
+ * drivers. Thus the only places that are safe have either already called
+ * dev_iommu_ops() on their call chain, or were responsible for assigning ops in
+ * the first place.
+ */
+static inline const struct iommu_ops *dev_iommu_ops_safe(struct device *dev)
+{
+	return dev->iommu->iommu_dev->ops;
+}
+
 /*
  * Use a function instead of an array here because the domain-type is a
  * bit-field, so an array would waste memory.
@@ -338,7 +352,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	dev->iommu->iommu_dev = iommu_dev;
 	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
 
-	group = iommu_group_get_for_dev(dev);
+	group = iommu_group_get_for_dev(dev, ops);
 	if (IS_ERR(group)) {
 		ret = PTR_ERR(group);
 		goto out_release;
@@ -414,7 +428,8 @@ int iommu_probe_device(struct device *dev)
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 
-	ops = dev_iommu_ops(dev);
+	/* __iommu_probe_device() set the ops */
+	ops = dev_iommu_ops_safe(dev);
 	if (ops->probe_finalize)
 		ops->probe_finalize(dev);
 
@@ -430,14 +445,13 @@ int iommu_probe_device(struct device *dev)
 
 void iommu_release_device(struct device *dev)
 {
-	const struct iommu_ops *ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (!dev->iommu)
+	if (!ops)
 		return;
 
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
 
-	ops = dev_iommu_ops(dev);
 	if (ops->release_device)
 		ops->release_device(dev);
 
@@ -614,13 +628,6 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
 	list_for_each_entry(device, &group->devices, list) {
 		struct list_head dev_resv_regions;
 
-		/*
-		 * Non-API groups still expose reserved_regions in sysfs,
-		 * so filter out calls that get here that way.
-		 */
-		if (!device->dev->iommu)
-			break;
-
 		INIT_LIST_HEAD(&dev_resv_regions);
 		iommu_get_resv_regions(device->dev, &dev_resv_regions);
 		ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
@@ -1332,7 +1339,8 @@ int iommu_page_response(struct device *dev,
 	struct iommu_fault_event *evt;
 	struct iommu_fault_page_request *prm;
 	struct dev_iommu *param = dev->iommu;
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	/* This API should only be called from an IOMMU driver */
+	const struct iommu_ops *ops = dev_iommu_ops_safe(dev);
 	bool has_pasid = msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
 
 	if (!ops->page_response)
@@ -1601,7 +1609,8 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
 static int iommu_get_def_domain_type(struct device *dev)
 {
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	/* It is not locked but all callers know there is an ops */
+	const struct iommu_ops *ops = dev_iommu_ops_safe(dev);
 
 	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
 		return IOMMU_DOMAIN_DMA;
@@ -1658,9 +1667,9 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
  * to the returned IOMMU group, which will already include the provided
  * device.  The reference should be released with iommu_group_put().
  */
-static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
+static struct iommu_group *iommu_group_get_for_dev(struct device *dev,
+						   const struct iommu_ops *ops)
 {
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_group *group;
 	int ret;
 
@@ -1795,7 +1804,8 @@ static int __iommu_group_dma_attach(struct iommu_group *group)
 
 static int iommu_group_do_probe_finalize(struct device *dev, void *data)
 {
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	/* It is unlocked but all callers know there is an ops */
+	const struct iommu_ops *ops = dev_iommu_ops_safe(dev);
 
 	if (ops->probe_finalize)
 		ops->probe_finalize(dev);
@@ -1884,13 +1894,9 @@ EXPORT_SYMBOL_GPL(iommu_present);
  */
 bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
-	const struct iommu_ops *ops;
-
-	if (!dev->iommu || !dev->iommu->iommu_dev)
-		return false;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	ops = dev_iommu_ops(dev);
-	if (!ops->capable)
+	if (!ops || !ops->capable)
 		return false;
 
 	return ops->capable(dev, cap);
@@ -2620,7 +2626,11 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (ops->get_resv_regions)
+	/*
+	 * Non-API groups still expose reserved_regions in sysfs, so filter out
+	 * calls that get here that way.
+	 */
+	if (ops && ops->get_resv_regions)
 		ops->get_resv_regions(dev, list);
 }
 
@@ -2979,6 +2989,11 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	/* Since group has only one device */
 	grp_dev = list_first_entry(&group->devices, struct group_device, list);
 	dev = grp_dev->dev;
+	if (!dev_iommu_ops(dev)) {
+		/* The group doesn't have an iommu driver attached */
+		mutex_unlock(&group->mutex);
+		return -EINVAL;
+	}
 	get_device(dev);
 
 	/*
@@ -3301,7 +3316,7 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 	const struct iommu_ops *ops;
 
 	list_for_each_entry(device, &group->devices, list) {
-		ops = dev_iommu_ops(device->dev);
+		ops = dev_iommu_ops_safe(device->dev);
 		ops->remove_dev_pasid(device->dev, pasid);
 	}
 }
@@ -3413,6 +3428,9 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *domain;
 
+	if (!ops)
+		return NULL;
+
 	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
 	if (!domain)
 		return NULL;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 46e1347bfa2286..60e84f8c7c46e9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -441,14 +441,11 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 	};
 }
 
+/* May return NULL if the device has no iommu driver */
 static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 {
-	/*
-	 * Assume that valid ops must be installed if iommu_probe_device()
-	 * has succeeded. The device ops are essentially for internal use
-	 * within the IOMMU subsystem itself, so we should be able to trust
-	 * ourselves not to misuse the helper.
-	 */
+	if (!dev->iommu)
+		return NULL;
 	return dev->iommu->iommu_dev->ops;
 }
 
