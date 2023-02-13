Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7936947C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjBMOQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBMOQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:16:55 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EAE1449A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:16:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWtrxes+/If6m5nahwPy56XDQSLNVK27tz2tN7EQGY4i58avgjFa+KZHXvxzXvQi0btltA9UrcxnSc15+qWGLxXVcxNZZ645kZXd55lTVGIsYOOw6zyzxkb6oy0y25ikzBFt4PSbDYJ+zQgB0UIkebF+m2f54j2av6MxdDhkZFQ45KQNtI7wOMmL8J0axKUGamqYUaRtKy70c/qkx05gPtKuxXBuGw89mxhbdRpipNX5ILrQyM66N4YrJw7XoB0J3jrfwNYqomAHH4dr65InYpQ4t0wcpItYVL8qN8IxLYVI0sIb6RUEAyKVKZ9eqgVsnHRrf8nTihSGZvG4V+JisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gW6gnqhpsAi+M1nROmLJwL8sXh8y413YRigIK7xwmWg=;
 b=EGaXnSsydf1/LVxsXUBf30UmZCxHrwuQcRrsL6Y4kezSypp5aln3T2rQMvd15bsjQi7BTOl/v0cLbNWUHN0Mgu8rcNr0vbD2CgKpuw6awlKTFEbOYZg1yN79Fr1kTrCW6rwxMMob2KPylFDd0rDFIq9CD4IcGy7ngSAHncDx0CEgqG+9EcizPL8o9NED2yIB1jkUT+y1wF5gwGydDu3rXTzzunZe9l5KUyGKtiY5qZg3rc/Jui/QEZERenI7bNZB6//urG8tgOgNul/E+oTpZSvofFTpkqCg89Wy4mhoOjUNfDib61WpyumUtw0vuApuPkDYsVoQ6Qz3x1003oayqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gW6gnqhpsAi+M1nROmLJwL8sXh8y413YRigIK7xwmWg=;
 b=Yd94bDrN3w9MWaXHqXczG0gFnZmQKqA5n38/wQcewUr20zefjK68dNXoH7z8jiYYMmmIFxKe1EtVxtnBpEPddCBPIgQO8rX4edRCFiHRiroDT45CbduXwWCRMypYIsWEOR1BtOk2ml+xiFPUgPhJLF5aSTcfs7eUNvWztdEAAQbF0T64HYBEtpC3n2HqM6qEaQERjqkmeClcsBHqd5KekXSCEku9NNw+Opz+LkI95pou+/9ibjNLxRBEp4PcZdgLv1OT41ElyoX8DeM19b+VgNacFySGdTYJDTbhHqZbke3aNQ28DvRohK4mI98nmn1sGz/JPNBdSYpJfj1gbXO1MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Mon, 13 Feb 2023 14:16:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 14:16:51 +0000
Date:   Mon, 13 Feb 2023 10:16:48 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iommu: Add dev_iommu->ops_rwsem
Message-ID: <Y+pGUOkLVUMFYWOb@nvidia.com>
References: <20230213074941.919324-1-baolu.lu@linux.intel.com>
 <20230213074941.919324-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213074941.919324-2-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:208:23c::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: eed19458-e176-4814-34b3-08db0dccf33b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FPFRlQ9T8GLUqHTfpFZGInNVD/7UJANkli2DlNacFuufGNRc4Kt6RcsDeA11AFq5L6Y69eif2Nr27r+vGCn+e79jyZ0iNScI0JfVENc9ceVaEESOmW9/qRfXaymJ5ttvLfay5LnlJa+T+N/xLfGmIY4B4VX1z8W0tFP7dv2csbWvFBXtPWTWDI7xGBLLf4eJzERiSbmBRIqR10rZEMX+GSHnfqwxi0ckun4P+9rHDAkur8EDI7dH4Rh+cCsxgoyrCwnM/NUBZ6B/FD834DaaZU2cgkanLYOxya21bwTT0ItHW+t5xd+CMx3HXfIiBBuFf2lmsHGkcUByYF9GeIOFQVS8IntKs29uueBMvXa3bNrH3VcKzSv1xbt70LNLTYkPEVgD4eJKJAT1vXxLlwLFfELU90J3zJgYtTV5DlZSIuvm0EvMV64LjpCs1ssbxcTX6fwHxOHBlZf9udd3vnSX56/0Sgv7vGeceAR4jNpY0YAFpNkuAyMFKpGbjLxgSbNr8o9xud4WeuIrgvWk19E/gMi/bg3IVRaCHOWEWZ+Mzx0KKUdGVQD/Td+4keN21IJIPX00vXl+f5A0UMXLjoE9JOYd6zRzpUwmJUspEQIK9aisFBjn2fbrBZNQiLJ+gpSYxs0CMuMXBDdf+uOMvFf4Q4wUAuuPuY1C4ZGhVAwj0FZc+EJ/MQQnfComEd6yShko89wFclP6cxv/3P2E5HqkLLv8eZ+t/gwerOXOJsTnMmMLzOWwuWSS/pA8pSV7VIe5AKXrv5mk/XaKLiQDGJKwtvTNn+mHSZWt6SKAZfxVoZPmBp8OSzjubGBquIcROKp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199018)(41300700001)(54906003)(83380400001)(38100700002)(2906002)(6666004)(6512007)(6506007)(86362001)(26005)(186003)(2616005)(5660300002)(966005)(6486002)(478600001)(8936002)(30864003)(36756003)(4326008)(316002)(66946007)(6916009)(8676002)(66476007)(66556008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZvgaGL0qvNc5jHllB3Pnz8Osv6T5HNINJcJ1an4c8wTc2x4hGvMygIjnPJP6?=
 =?us-ascii?Q?YMxhKzKYZrBqlHzOC1R+YK6b/Bc/8LdhjB+7yNiCew+ZNmRhpwNtKEug/pl4?=
 =?us-ascii?Q?Ei9rOn6YP6m7JG9zeGhlRD8GrkiIWVCUGhqqyNJdz7N4tuCaayo5El6X/Re+?=
 =?us-ascii?Q?VwVBdqqxAgIT8XPc0uVb6Yy/J05rbcKtqsxYO31ewK3AbO5p8e+tiVNf0x8F?=
 =?us-ascii?Q?jkY7zM0f7LCYH2ym5sCC35ZYi8UmxTUY7xJVjrttxyRocrKyNo5VQ/y9uYO6?=
 =?us-ascii?Q?u7tAuje5Ncd0liqWj5TTDnqV4652tAQpPKsAsC6gvBJSCY3MwHSB6Kt34Ngi?=
 =?us-ascii?Q?DEw3VltjnASoC9zNNr1I2/BREQh9nIHGWHY36Np+yRg4PwfFACfWZS3Tra8q?=
 =?us-ascii?Q?btrMbvB7+yE7h45K+GuLub4P14ItYy85Tz0pIc9QlxirEfkxNE4MndsaHRzu?=
 =?us-ascii?Q?FPcdPfUFbmkr1WvuNFE4eh8fCwYsM0yWnFeq1rCYQvOdeDnOiAaqoczVDErO?=
 =?us-ascii?Q?i7KWhhvk1Oopp8KRsJdsvrgYZIpaRm6ym+ch6sXHbQxUdaAnyNr2PTL7uJHO?=
 =?us-ascii?Q?Dxz/9N9KGPN54EKf8E4TZ4EaYBQr32EpvAQRVCEt23fSgrKwAejb7VDtwRGY?=
 =?us-ascii?Q?+SiO+BdhuTIrcd2UiBgzaGGYN7HFUDhAWCz2D+my0wRvhtq52ZYlz3uHUpVa?=
 =?us-ascii?Q?0QvbvPrDj6Iinxm7AiFBrIE7pfxPln2hyKStxHVBM5qUReuhPGY+0oltQcjk?=
 =?us-ascii?Q?TUJUSQYpST4fQVPVs4wkvB/aDmSwXYECK8KyLyL0uyRAThnV5ca0ieo7rct2?=
 =?us-ascii?Q?qT7ouoGYx6QkU3bd34h2OE/oS4bPw+csbYjcubdLHZTwBlU5D06xm6aP8XRS?=
 =?us-ascii?Q?HQBHRA7WFm/3Ydz3OeBr6p9XXMWRCaZ6NReuQxlxj/VQzW7sep8SMBUE61fi?=
 =?us-ascii?Q?zQpgz9SuuBflrDWgMN9+SMIkbAYxj0BsXCnDsFarMn/XLGQ7k46V6u4LWzl5?=
 =?us-ascii?Q?ZiUAb4Ey5M7vet7Y2lAbbQsTubcIrB5jSDLE9BrFRgl7050+V4zn3Qo2C4bt?=
 =?us-ascii?Q?5oEbKajJikihQ0Og15gTU+khik8K83HhAtD1mXxglj2SM4mI/QwMyexKjxdx?=
 =?us-ascii?Q?NRrsOmA60HhelFvJn5fMqIMB+HGhNZAwKhVU3iguGQYSf5by5RKifUjTd+aa?=
 =?us-ascii?Q?+BIJcEuSMSafhr7jEWO8B7EUM84ALu+8+YawvkhoadzOLCeoRYdd6jGlfYk3?=
 =?us-ascii?Q?OZaYkNI/YQ+Hq1z2hHTs7fvbpuklYnz2l3o/bXstItg90siakHpgxXWEv9r2?=
 =?us-ascii?Q?ed98qAtm6W1W3pWEvHPv2CxCdQWp3Jh8vmohKLLCU9c1c1+Svkz6467UQKvR?=
 =?us-ascii?Q?r5NuFu6IAVFykApNCFFHbJGMCYLb5pk/SQ73UTtMoaEc+yiaGr8VCVf2kjYn?=
 =?us-ascii?Q?KYSqfW/OKIWGRrFqrLIzZx/r5kdZcIK8o7I+2QJzkWos+nyUsLp87L7cSyuB?=
 =?us-ascii?Q?q52i8cnMaOpUoMJovUshX6U4UdJVr5nOuTLCNZFU/7UDvZ72IrGgU/e3y48Y?=
 =?us-ascii?Q?jHb4ee6suJ7KRPm21oWPztjQS5ym0jkkhIiHt25z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed19458-e176-4814-34b3-08db0dccf33b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:16:51.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZMERoe4RLAu9y1E+d65xMR5297cYwaAh5LuVu/jyh4hwa4feMM56rWZlwD4yHlj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 03:49:38PM +0800, Lu Baolu wrote:

> +static int iommu_group_freeze_dev_ops(struct iommu_group *group)
> +{
> +	struct group_device *device;
> +	struct device *dev;
> +
> +	mutex_lock(&group->mutex);
> +	list_for_each_entry(device, &group->devices, list) {
> +		dev = device->dev;
> +		down_read(&dev->iommu->ops_rwsem);

This isn't allowed, you can't obtain locks in a loop like this, it
will deadlock.

You don't need more locks, we already have the group mutex, the
release path should be fixed to use it properly as I was trying to do here:

https://lore.kernel.org/kvm/4-v1-ef00ffecea52+2cb-iommu_group_lifetime_jgg@nvidia.com/
https://lore.kernel.org/kvm/YyyTxx0HnA3maxEk@nvidia.com/

Then what you'd do in a path like this is:

  mutex_lock(&group->mutex);
  dev = iommu_group_first_device(group)
  if (!dev)
     /* Racing with group cleanup */
     return -EINVAL;
  
  /* Now dev->ops is valid and must remain valid so long as
     group->mutex is held */
   

The only reason this doesn't work already is because of the above
stuff about release not holding the group mutex when manipulating the
devices in the group. This is simply mis-locked.

Robin explained it was done like this because
arm_iommu_detach_device() re-enters the iommu core during release_dev,
so I suggest fixing that by simply not doing that (see above)

Below is the lastest attempt I had tried, I didn't have time to get back
to it and we fixed the bug another way. It needs a bit of adjusting to
also remove the device from the group after release is called within
the same mutex critical region.

Jason

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index fe9ef6f79e9cfe..ea7198a1786186 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -31,6 +31,7 @@ void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
 int arm_iommu_attach_device(struct device *dev,
 					struct dma_iommu_mapping *mapping);
 void arm_iommu_detach_device(struct device *dev);
+void arm_iommu_release_device(struct device *dev);
 
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c135f6e37a00ca..3d7b385e3981ef 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1680,13 +1680,15 @@ int arm_iommu_attach_device(struct device *dev,
 EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
 
 /**
- * arm_iommu_detach_device
+ * arm_iommu_release_device
  * @dev: valid struct device pointer
  *
- * Detaches the provided device from a previously attached map.
- * This overwrites the dma_ops pointer with appropriate non-IOMMU ops.
+ * This is like arm_iommu_detach_device() except it handles the special
+ * case of being called under an iommu driver's release operation. In this
+ * case the driver must have already detached the device from any attached
+ * domain before calling this function.
  */
-void arm_iommu_detach_device(struct device *dev)
+void arm_iommu_release_device(struct device *dev)
 {
 	struct dma_iommu_mapping *mapping;
 
@@ -1696,13 +1698,34 @@ void arm_iommu_detach_device(struct device *dev)
 		return;
 	}
 
-	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
 	to_dma_iommu_mapping(dev) = NULL;
 	set_dma_ops(dev, NULL);
 
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
 }
+EXPORT_SYMBOL_GPL(arm_iommu_release_device);
+
+/**
+ * arm_iommu_detach_device
+ * @dev: valid struct device pointer
+ *
+ * Detaches the provided device from a previously attached map.
+ * This overwrites the dma_ops pointer with appropriate non-IOMMU ops.
+ */
+void arm_iommu_detach_device(struct device *dev)
+{
+	struct dma_iommu_mapping *mapping;
+
+	mapping = to_dma_iommu_mapping(dev);
+	if (!mapping) {
+		dev_warn(dev, "Not attached\n");
+		return;
+	}
+
+	iommu_detach_device(mapping->domain, dev);
+	arm_iommu_release_device(dev);
+}
 EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
 static void arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index de91dd88705bd3..f3dbd980133567 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -101,6 +101,10 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count);
+static struct group_device *
+__iommu_group_remove_device(struct iommu_group *group, struct device *dev);
+static void __iommu_group_remove_device_sysfs(struct iommu_group *group,
+					      struct group_device *device);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -430,18 +434,50 @@ int iommu_probe_device(struct device *dev)
 
 void iommu_release_device(struct device *dev)
 {
+	struct iommu_group *group = dev->iommu_group;
 	const struct iommu_ops *ops;
+	struct group_device *device;
 
 	if (!dev->iommu)
 		return;
 
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
 
+	mutex_lock(&group->mutex);
+	device = __iommu_group_remove_device(group, dev);
 	ops = dev_iommu_ops(dev);
+
+	/*
+	 * If the group has become empty then ownership must have been released,
+	 * and the current domain must be set back to NULL or the default
+	 * domain.
+	 */
+	if (list_empty(&group->devices))
+		WARN_ON(group->owner_cnt ||
+			group->domain != group->default_domain);
+
+	/*
+	 * release_device() must stop using any attached domain on the device.
+	 * If there are still other devices in the group they are not effected
+	 * by this callback.
+	 *
+	 * The IOMMU driver must set the device to either an identity or
+	 * blocking translation and stop using any domain pointer, as it is
+	 * going to be freed.
+	 */
 	if (ops->release_device)
 		ops->release_device(dev);
+	mutex_unlock(&group->mutex);
+
+	__iommu_group_remove_device_sysfs(group, device);
+
+	/*
+	 * This will eventually call iommu_group_release() which will free the
+	 * iommu_domains.
+	 */
+	dev->iommu_group = NULL;
+	kobject_put(group->devices_kobj);
 
-	iommu_group_remove_device(dev);
 	module_put(ops->owner);
 	dev_iommu_free(dev);
 }
@@ -1039,44 +1075,71 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_add_device);
 
-/**
- * iommu_group_remove_device - remove a device from it's current group
- * @dev: device to be removed
- *
- * This function is called by an iommu driver to remove the device from
- * it's current group.  This decrements the iommu group reference count.
- */
-void iommu_group_remove_device(struct device *dev)
+static struct group_device *
+__iommu_group_remove_device(struct iommu_group *group, struct device *dev)
 {
-	struct iommu_group *group = dev->iommu_group;
-	struct group_device *tmp_device, *device = NULL;
+	struct group_device *device;
+
+	lockdep_assert_held(&group->mutex);
 
 	if (!group)
-		return;
+		return NULL;
 
 	dev_info(dev, "Removing from iommu group %d\n", group->id);
 
-	mutex_lock(&group->mutex);
-	list_for_each_entry(tmp_device, &group->devices, list) {
-		if (tmp_device->dev == dev) {
-			device = tmp_device;
+	list_for_each_entry(device, &group->devices, list) {
+		if (device->dev == dev) {
 			list_del(&device->list);
-			break;
+			return device;
 		}
 	}
-	mutex_unlock(&group->mutex);
+	return NULL;
+}
 
+static void __iommu_group_remove_device_sysfs(struct iommu_group *group,
+					      struct group_device *device)
+{
 	if (!device)
 		return;
 
 	sysfs_remove_link(group->devices_kobj, device->name);
-	sysfs_remove_link(&dev->kobj, "iommu_group");
+	sysfs_remove_link(&device->dev->kobj, "iommu_group");
 
-	trace_remove_device_from_group(group->id, dev);
+	trace_remove_device_from_group(group->id, device->dev);
 
 	kfree(device->name);
 	kfree(device);
-	dev->iommu_group = NULL;
+}
+
+/**
+ * iommu_group_remove_device - remove a device from it's current group
+ * @dev: device to be removed
+ *
+ * This function is used by non-iommu drivers to create non-iommu subystem
+ * groups (eg VFIO mdev, SPAPR) Using this from inside an iommu driver is an
+ * abuse. Instead the driver should return the correct group from
+ * ops->device_group()
+ */
+void iommu_group_remove_device(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+	struct group_device *device;
+
+	/*
+	 * Since we don't do ops->release_device() there is no way for the
+	 * driver to stop using any attached domain before we free it. If a
+	 * domain is attached while this function is called it will eventually
+	 * UAF.
+	 *
+	 * Thus it is only useful for cases like VFIO/SPAPR that don't use an
+	 * iommu driver, or for cases like FSL that don't use default domains.
+	 */
+	WARN_ON(group->domain);
+
+	mutex_lock(&group->mutex);
+	device = __iommu_group_remove_device(group, dev);
+	mutex_unlock(&group->mutex);
+	__iommu_group_remove_device_sysfs(group, device);
 	kobject_put(group->devices_kobj);
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index a003bd5fc65c13..703a6083172de1 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -302,11 +302,8 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
 /*
  * Disable MMU translation for the microTLB.
  */
-static void ipmmu_utlb_disable(struct ipmmu_vmsa_domain *domain,
-			       unsigned int utlb)
+static void ipmmu_utlb_disable(struct ipmmu_vmsa_device *mmu, unsigned int utlb)
 {
-	struct ipmmu_vmsa_device *mmu = domain->mmu;
-
 	ipmmu_imuctr_write(mmu, utlb, 0);
 	mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
 }
@@ -647,11 +644,11 @@ static void ipmmu_detach_device(struct iommu_domain *io_domain,
 				struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
+	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
 	unsigned int i;
 
 	for (i = 0; i < fwspec->num_ids; ++i)
-		ipmmu_utlb_disable(domain, fwspec->ids[i]);
+		ipmmu_utlb_disable(mmu, fwspec->ids[i]);
 
 	/*
 	 * TODO: Optimize by disabling the context when no device is attached.
@@ -847,7 +844,8 @@ static void ipmmu_probe_finalize(struct device *dev)
 
 static void ipmmu_release_device(struct device *dev)
 {
-	arm_iommu_detach_device(dev);
+	ipmmu_detach_device(NULL, dev);
+	arm_iommu_release_device(dev);
 }
 
 static struct iommu_group *ipmmu_find_group(struct device *dev)
