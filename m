Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C606B3381
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCJBJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCJBJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:09:03 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE05D7FD6B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:09:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dx6Pd3xD7MJ8F6YH+O+M3s9MpTUHU9PUWsywCawv56Pa5XX1tz8jgxz/1Sg3kYoUZQc9jEDCKZl4/YR5GEjHKJECngpPhc+fnHps+OA2ydeSrt9HsfK3WW9k8/zyx//V+2lGkMhWQOjykCZxBWEkKfxAy+osUJnaj/IrIcMbyno7RQrjIAEDBMJm86nWq0HHa+Yhgvaw4uP1Oe4akSEp24HsKUraivk3oTOEofX8fOLsDUZ1DMzNoYCuoCUhtIphY6RhR0UZDulcfdb5SzkFv/WQrRXz3SUUZUoAm5nzcjIlFIYHlm89on1QTTr7rz3NT+05F/btthVzIvAeGgxVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzCqbyhWT0vZx3y1MMyDE70FhOY9ajIwFSgmVz8dwAI=;
 b=dGSFJSaEGS83AiaIoLBDCD2+jMeMF7OpKuZ2zWajlgvaxQLb6msYxXk3FoJwBbQ1l3+M7/6AQBfptsTjHBqR3PjkcwuICPC8d81K+Jh1mSnO8iOLbrhoo+XxNe16clpMfOOUWdw5Z8rFduIXTlEBW1S1TSOvn4s3mNv4Ijmx2ZpnmyqqrZ7vPjvkNwv0u7kIC0cjjwS5HBt6dMHIMH0G8cjvqJFO5AXLxGsXIwUGAEQQkXDWHGbHP9zEoyZtrs/zPm82csHd4shhVuEDY80QZI965xJxWtCdwKbbZpZVSHvMUIRtuJz/Snww4SVnVmVIs7r1h/KFsS6quW0asAcC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzCqbyhWT0vZx3y1MMyDE70FhOY9ajIwFSgmVz8dwAI=;
 b=C05Vx2488cXafSv2SsXoOjBzZqTAyApEqYTOHmICwOpxenFCIiPm2eJGhK5ujjPv+8+MLAD39Y1HYy1quFR4erVB8HVWmVy/mZQXUiydz7c9JpCxrxoUumfqO7zkq+/VeR4by4v34H9G1w6GIwOKEc/4LLGbAn+BOkXr8L0qMXxqWXib9zG24mtf/uFb4avId3QtVaG/MEzfgJDF8KrIqQS1p9Ey5wYYV2fkxao8LaZdSEFPwMy1ugKQLOANE15laVjgYYIX71Z7BcKk/g4SFfyvczdV/BAtLGcrHif6MTyoYqKCjcys/Z5lv1twyWGY9qpyPuwBH7JeOLsP+HgCwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 01:08:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 01:08:58 +0000
Date:   Thu, 9 Mar 2023 21:08:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iommu: Same critical region for device release
 and removal
Message-ID: <ZAqDJz4ckNsRz2Cx@nvidia.com>
References: <20230306025804.13912-1-baolu.lu@linux.intel.com>
 <20230306025804.13912-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306025804.13912-4-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BY5PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: c108d1a0-00a4-4c01-a4aa-08db21040707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJU1VZHkZR6e3ESsJz1bn2xY7NqdeMvENb4RFgkKGqBeaIBptu80GX+GqjKPY+n9r1BGpkjz423VMpNmZsIiICfagow/ETeZA/C9GAfsaNj/OXRE3FaoEDNw5qZefswlhY88fklDtA4/vlBTUC7YLQRehhCmV0lJyYtrzpn0bX0QU0XVAb2DSJF7FN2J/1H5yHc87lzJq6D9fK2QNJ4meHmsfwb0SsSmROWIgndom9SBSAQkIw9Mepy/7V54FnVYgqnmIgQARX+6kzKauK7y0jwjAJFNd2/NBA6sJLVQYUM5QjF11rbhML5KEwLRfFPRRcNFg73OU9tcQnDCuYX6CWe5d/NiaAzpSY10NduSWlIZwof4yvNUyynidDpZTGEMKexI8ChiPJb8H7lMKsOjhBwYO7/9zgH6mGfwnB9QCJdJ8WDOR1ZP2wBeTpvmavXSjknV+eBMPd6e3gdVXtwjq4sBiQFykPSIUWeH9o1vc/flhw6HjjRhnilAzDF12NDVTzqsPl768CIGkALm3FWnDeHxGQtssIjzntMeAVATEMzSXR46jybE/dxRuHjarvvEbEtseYnIcwPMMQJo02BhR5SeooX8VfAlHk5LVvFry+eEfeJp9DOT9Ltcqjbu0YoP7JtefjoM2CyTqifEUQ14yA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199018)(5660300002)(36756003)(83380400001)(478600001)(6666004)(6506007)(6486002)(6512007)(2616005)(186003)(4326008)(6916009)(66476007)(66556008)(66946007)(8936002)(8676002)(41300700001)(86362001)(54906003)(26005)(316002)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M8McOntds6FUqRMIkBh7h8dBMCquwECpGQkPiXvgT7D4dxGPSp9XDYk46+Bc?=
 =?us-ascii?Q?SbQ7eaCi6D0Vsar3DpKJ8qFxrVxMCog6Y9iXEnmA07ihubZUrw+ut6YB0h7Q?=
 =?us-ascii?Q?FZ0dFU2isg5iw51sR4mACeXXvBP1PR74Si/CwJG/ETb9/3G0vHFVzTscHrBp?=
 =?us-ascii?Q?mIod6LEz2fXa9YACmGFQcRvDxJjNO6pD95zhS+utRT4Ev+pGFUW1Ff2+Hkf5?=
 =?us-ascii?Q?cLazCjzKq1KbzAi1w4zmcOX1LAbdIUCqtIM/G+rAg2Db4gd/IPLJl+0CZIN2?=
 =?us-ascii?Q?f61unQrqn4YF9osGsgSagwGwT06py3Hb9V5DaaLDd+XlMy6Cuwlmy0rD7Vfi?=
 =?us-ascii?Q?PsilOKNRZ/JobWjWms3dBMM79HPjqPLXL9ccIp7artwUhAP+taYATeqDeJSj?=
 =?us-ascii?Q?PZpDLZ0RkABXdd2F/CR91t59Iww3UiDPMkr5xhTwPkdlr4+fwkfKWTPBAh94?=
 =?us-ascii?Q?RGsB4VV+PU7ljvqxXlVf/O7ZZX5ajPJ7NGehVbJhFnLkn3l1FvAJJFdD5Ej2?=
 =?us-ascii?Q?K6CFytMDWCA/kMsTBnH/q9Er8kHZwihHVt1j2SeSNEeUkz5BpM71N20juGDh?=
 =?us-ascii?Q?/9aCM9ADt1ThWP1oVHyLq0D1AVpiHlCTCONrr/EgbdP4Sq1DdG6OQjDA7LSh?=
 =?us-ascii?Q?AGbBAA5mWlVBv9eEdo2CScI8HCtk94lb9hryLlONEEpctgoSVHGeK1b0JN6N?=
 =?us-ascii?Q?zBbRVDhEzZf/KpclJTyr1xSNHbnmKSgNrqtSyYKWFBHhmrtz0Ajwur88oa96?=
 =?us-ascii?Q?2iNs3rm29ylV//ASggb8IvgOXkV3tu6Cd3MvnUHTEOX0j48nDsfHwQUcsuGZ?=
 =?us-ascii?Q?dXeyiXmXucQi6dlf2B3bsgeVElVnCKHTkQXa4/X8l2pnNlfn85BnPpgp+XlC?=
 =?us-ascii?Q?z9ZbIDMmxkgL7mNuXXGMzcXqDyLH6++CKMnSlWHVvCycDNblNgcVdzjlLLGd?=
 =?us-ascii?Q?ts+FSf8sGTBBso8uAOAzX52dcDY25eblz4+dZXhLMp0Yf7oNjNwAGiPyvNzt?=
 =?us-ascii?Q?5WN/vGyPs0vuSCeex+KUABsstBeHshtrxIChPPWHNQInRVz9f+mKwVPp7CSr?=
 =?us-ascii?Q?v/Yh160doQTEe9yfw5gzjjlB0x9syDq/aTlvm70gAGKqkACpdHaUtiujtrYl?=
 =?us-ascii?Q?dInanjRFjCqqJljJpW+dSvthdCXf6C2V8pkRw0yr8FY8hR93+LkumPMHfqbi?=
 =?us-ascii?Q?6wPv0Wb/8sqy7iKHLdUbBPrzA2DyOuI5op69wQwp6wdZY98CJ4ooehujfYsr?=
 =?us-ascii?Q?ofalS9abku81aJTJ0Yp9OXDwC1fsEYVS/UM8tlenkLh4OyPeWA1qFBKMHrsC?=
 =?us-ascii?Q?oZx/XduakVUXFvX3HXP4oLRUnX7A+bc9l6Gcdo5elbjCPfv7ut7uquLeiU66?=
 =?us-ascii?Q?/8wgS4hwAKWlgZhjbcP1YA9/oScFVDl2g4arvft+Em40boqcZjva4vhHMWjE?=
 =?us-ascii?Q?KIfySNonoiXg/koPYWMokoqICiAPKP9vUmlFAZPPdScH4NsWDcMYaiJAQBUL?=
 =?us-ascii?Q?V//guCFug0LeMKyyAPmKoH1feT5cx7sSHEeHS6iCY1e8ZzWs6kTHEDSjeUug?=
 =?us-ascii?Q?IqhdoTwhE4r4JM0o3r7+TpuyzWq6Uq1IhQkat84m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c108d1a0-00a4-4c01-a4aa-08db21040707
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 01:08:58.6302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulcYHhFmnomC2vr/nXIznQC1lQM5rHOwJzithvii2HFPCLTiY4g6YKeNAVbvBjaT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 10:58:01AM +0800, Lu Baolu wrote:
> In a non-driver context, it is crucial to ensure the consistency of a
> device's iommu ops. Otherwise, it may result in a situation where a
> device is released but it's iommu ops are still used.
> 
> Put the ops->release_device and __iommu_group_remove_device() in a some
> group->mutext critical region, so that, as long as group->mutex is held
> and the device is in its group's device list, its iommu ops are always
> consistent. Add check of group ownership if the released device is the
> last one.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)


> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index bd9b293e07a8..0bcd9625090d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -507,18 +507,44 @@ static void __iommu_group_release_device(struct iommu_group *group,
>  
>  void iommu_release_device(struct device *dev)
>  {
> +	struct iommu_group *group = dev->iommu_group;
> +	struct group_device *device;
>  	const struct iommu_ops *ops;
>  
> -	if (!dev->iommu)
> +	if (!dev->iommu || !group)
>  		return;
>  
>  	iommu_device_unlink(dev->iommu->iommu_dev, dev);
>  
> +	mutex_lock(&group->mutex);
> +	device = __iommu_group_remove_device(group, dev);
> +
> +	/*
> +	 * If the group has become empty then ownership must have been released,
> +	 * and the current domain must be set back to NULL or the default
> +	 * domain.
> +	 */
> +	if (list_empty(&group->devices))
> +		WARN_ON(group->owner_cnt ||
> +			group->domain != group->default_domain);
> +
> +	/*
> +	 * release_device() must stop using any attached domain on the device.
> +	 * If there are still other devices in the group they are not effected
> +	 * by this callback.
> +	 *
> +	 * The IOMMU driver must set the device to either an identity or
> +	 * blocking translation and stop using any domain pointer, as it is
> +	 * going to be freed.
> +	 */
>  	ops = dev_iommu_ops(dev);
>  	if (ops->release_device)
>  		ops->release_device(dev);
> +	mutex_unlock(&group->mutex);

IMHO it is best to be locked like this

But for this series, if you run into problems with ARM and
release_device I think we could still safely unlock group->mutex
before calling this?

It would still be OK because the iommu_group_first_dev() will either
return NULL so iommu_group_store_type() wills top, or it will block
the ultimate call to release here which invalidate's ops.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
