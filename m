Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA79D6742CA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjAST05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjAST0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:26:49 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6031095172
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:26:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJuOwFMRebjkeGWJII0IMwxYvUqECAvZyFiQeYUeuA9bhw+UJ5SAJqdwkFqg2tPtwtP/IIt2nUfF1qJhhYMQUsmFRev5oZSTjp93SD/YcdGRGtIaMmBZeaC2Uy5vB3x+fTEy2Liki44eSI3BK55KdiNIPXnsebNUxtBDWbQ3/vFfs1V4CFqkCvoD1N0bFH0yX9DBXIVt49ElGbs30JRwOP8S//S3PV+NxBSuuW29mwnEpk2+wmDpHMYUHPYuiujk5Z+v/ojSaZ3ZXm8bUpKNe4a/oteR96oyPIFlt6rNuqbbQriF5uW1kAEn93znZNgJHF3ciAbafhj4M94kHO4OTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrNpmRpYvAmAVA+MadQo1Dzb4+AnlYQny3+suNqlQNU=;
 b=StZ/E5lINIuMcOnEm2H/77UGV8R6Pt9NubYJ/cBoGiKp6CXDgVPM81uTy152w+eTj/rlozM8E6/du72kWsUpbk4lT+RrFgY7DnyBhFBlD4MYaWRXYbIhajVrqrnCughcqSIhYSIci5V0CTC96J+1e5tOc1A37qY5pDdC1NY5GriefKawM8XymrQtV8zW5exfkS4DafpnFmRkdP66SUKZA/wD4BH3hipAEqyfcq53b9MvIkda3Df6UBiScxrmxzuCF/JtS6QntB+OsextF93CH25eYfRjK/ubDCgM/AG7lMocpvwtq40Tttz825RW/1mVX3EZQKHw57VNq+o1Lxw0gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrNpmRpYvAmAVA+MadQo1Dzb4+AnlYQny3+suNqlQNU=;
 b=uCbn7eAJfXxeyrxu/dTXghTkwcofYzOgy+8s7AwZeJrYE42JGYeqmuVBw/y6x0tqS7uuFBXBj92BvLeNZb4CPCh8nwzNzcQlFFF4YzhH2PMvb/ClWSWYMJeQcUoY7y/bFvAeqcXV+J08D8klz7l7EjUzXZoK9nihqsi34ZZC2L1dQv5QdZL7iX9WEb10X5/3388FkJdWp7PJrkII9i2loCCOk6TUJtWVZGR2M9tSIqCp+AaeBaljHw8IO11R/kIqScNUvyNwvEz30fvCpNu/YX6VCMYLUuixWmKFG9TEPqanYPjIHlDA85mzu+VROVFHLUJyonO5tQDVCgJ36Kz85g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Thu, 19 Jan
 2023 19:26:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Thu, 19 Jan 2023
 19:26:38 +0000
Date:   Thu, 19 Jan 2023 15:26:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, hch@lst.de,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] iommu: Switch __iommu_domain_alloc() to device ops
Message-ID: <Y8mZbh56MzXWpbi9@nvidia.com>
References: <cover.1673978700.git.robin.murphy@arm.com>
 <25ea8128b9228f9893507ad5a764ff25db5961a0.1673978700.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25ea8128b9228f9893507ad5a764ff25db5961a0.1673978700.git.robin.murphy@arm.com>
X-ClientProxiedBy: MN2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: 825a1d6b-b08e-4ace-a11b-08dafa531614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TIy2iaOM9F6i0YVqylUtMzd7qsD+KiB5t/8wvOs2tUSPoeZ7EVX0LUS4u0tXIm0rzQUTDZ5o7fJLGu5MFY5q5/oY6X1eka2g8rcxPMa5bzECAnfnqxt5vDPJwf+4Az5J6owLW2yYEwkRZjjhUHxrebucyO3IWm+3l0wEeFUN5LfOnNJgJb/TWSat6qZXvHfl77lj8PdTajo7iJcXXcvISM0BFiO7fYoLpochsw/11Vqg+LY9tCJ7PTmR+LCRE00+5BIGRRlAn8zo0eKzxtYZPF+w3zTUf9uP5BZEhAYPQSgue6J6dB2k/OeUi/GNb2sHXgmqChC4D/Ujyle5Gac9JNajDpAOE3Ln4Y661q2JOrtGezMyEhAqCKgL7srV7bZ3v3OygRzH/m4x3GAsrZalY0xtFG+PxMnS7VcxduV5DwAaRgV8Er27QRkZTbKKHSfvBrYtPBs5Esg1LQWd2eWALWfdhTRSZV9E3TGcchfWGfX18VpmkBURJECirNtf2FMPnYHLSmhNKrAlL+iWvrHoI5rSksgBl6xIvMiUcvbyK8AsZgfo3jRDM1PD9ZMBmJMWHiR3EljnPZYMO6lTSD92utWMUznXnyMJsW2Dy1hE8UyCd6loclMsWD7dVjLLi6eZ9Z08ps29dR3JL6C4p6oNYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199015)(186003)(6512007)(26005)(38100700002)(478600001)(6506007)(6486002)(86362001)(2906002)(41300700001)(8936002)(2616005)(316002)(5660300002)(8676002)(6916009)(66476007)(4326008)(66946007)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jnu40UETrZUkZtzk9rXf4bceYpIJAiBJQh4wZEZ6e9qqShMx23A2WcCe8q5D?=
 =?us-ascii?Q?XjF7AbZbev9fcdcM5iHq0GMwwIJ1NNe7FPOub1pMdoquWWd/MuTjxfHyYo/4?=
 =?us-ascii?Q?1KZ9peyGBis50Rv20pYMrMeg6Cc7Gw3FcY48OOf1onFJxp5ButTlxQT3FYmp?=
 =?us-ascii?Q?qnUkvxUymsCA49YO1FGXcxGsGRMW9IG5LaWQEqCBMglSRvhfPSOSztp645SJ?=
 =?us-ascii?Q?EjIEd5dWrVPGLdq8VhdxFkMrqzRjiuVbya2O8BBzGXaLsbrrSWjlqHpIMPTM?=
 =?us-ascii?Q?fdfLYAarvX/ixog2XH9pjZv+GGbDrV+QP4TpmTl6TPKog2kKayCHw9qG4hsj?=
 =?us-ascii?Q?s/RVwlx4gBXlz98S1cFcXbLt4T/38J/lMf46dJlWBq+g7PZ46RNaI270+SWh?=
 =?us-ascii?Q?jvSZHPcDP9W8gdHTBssLVvWBzWZ4yTWw6sReYAFiPnKUzbmE48ebLvC6JFsx?=
 =?us-ascii?Q?oJxoWKzuWk5ze+yA8YA/xmesI5xxS4dXpl6oTycah3oO6Ti8jHdq7xtbryfZ?=
 =?us-ascii?Q?M2YuzOvW3sydu73kMEfS2p1GCcN4Pz4MPMRwnyB+CDfd0NT1Hh/C4SyS7o/G?=
 =?us-ascii?Q?89JfqiMng4K96XIc5e4ifexwyFz3pEcAGbSs7FbLLYuwInwyms5NFSkCXUlU?=
 =?us-ascii?Q?14uoOmpP3Mq5g3r+0STcA7zpVuRIN+qEvEcTXOMkqNB2JRwm/jwvFBbhCVQG?=
 =?us-ascii?Q?E0+fR9CIPl4YCyALCwsRRG5q7VPeTYowbLxQ/OVPb1tVme4oLQiOniGfRHSI?=
 =?us-ascii?Q?xp7eViCRTT1dplo2VZJi9RoPBIOUqLDiBE8Hx/0T/HU0m/+tL9Uh+BtIVbYY?=
 =?us-ascii?Q?0gEuZr5wUXPo5olVNBwIeFaOESVKp11JX7d6gMMMXnOPS9zlrE6vJFAChpnD?=
 =?us-ascii?Q?ro1kzelx+K65pGWAlwqVyVviJIVksVZUPUZrck2WKcCBppk10xZBrDFLRHqs?=
 =?us-ascii?Q?vNYWbu45DwSGioYF0yXjX495HarrvUr+gmVK6niLVYr+lGSaBjZTsHj9ziJo?=
 =?us-ascii?Q?9Pipiux8bf/I8x16slLD3fpgdNGl3a1pcZ3/M5B0Op0FmZNzCZYzCe6xUBKr?=
 =?us-ascii?Q?+AUXdXWxgAFrIx2A0Edw8Qpzn53TuRcSCwWYgOMWRFvXclOJyLniyt/OHRiT?=
 =?us-ascii?Q?ySR63GvTdDDOYeJfkxs/gWg8JrJsfOdC66yd3JU+WiZ8kePqyyrtEyeuxefu?=
 =?us-ascii?Q?cWUYzC0YUIGpUT9Lsm7WkJ9Xp8ex9aQ1RZxcP5/v5tx+pDTlCNdALA+umi9Q?=
 =?us-ascii?Q?j7KcufahUwZkCo8Q7hlHTT2j8W9a8VaqXIw34s41UZy/j0kaj++prT+M51yL?=
 =?us-ascii?Q?2f0tbIHbcHRqxH8DqsBNusULAMk3ZKPBp7mIzkSp+DuVFdeeAURF/9zYONWW?=
 =?us-ascii?Q?KDcAhgsChj14p1cusrImEYMabxnFl9JWMonyOiopjuWzbUTXdNZv1OeE2TkZ?=
 =?us-ascii?Q?TPFcJm8t1AA+ZYXyTmDv15r8lPjshGktoMyw+zutKjOojrESlHcK096DAeHU?=
 =?us-ascii?Q?yB5jmHbplFVNCHk+Cxt5quzYZH2IOOdWpXkrc5mLxhjd2lxzNUK99VvAaJfQ?=
 =?us-ascii?Q?p5b6DbCQM8aUYftgkC8VbbaKu3iAxSP5Npfi8Oky?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825a1d6b-b08e-4ace-a11b-08dafa531614
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 19:26:38.7120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWZX4eu5Sz1iuMw7Oq7aN6GsNnZhm8OiXdnrfZjOkR+5O/jY3H0qmRuw+Au2+jhV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 07:18:22PM +0000, Robin Murphy wrote:

> -static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
> +static struct iommu_domain *__iommu_domain_alloc(struct device *dev,
>  						 unsigned type)
>  {
> -	const struct iommu_ops *ops = bus ? bus->iommu_ops : NULL;
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>  	struct iommu_domain *domain;
>  
> -	if (!ops)
> -		return NULL;
> -
>  	domain = ops->domain_alloc(type);
>  	if (!domain)
>  		return NULL;
> @@ -1970,9 +1968,28 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>  	return domain;
>  }
>  
> +static int __iommu_domain_alloc_dev(struct device *dev, void *data)
> +{
> +	struct device **alloc_dev = data;
> +
> +	if (!device_iommu_mapped(dev))
> +		return 0;

Is 0 the right thing? see below

> +
> +	WARN_ONCE(*alloc_dev && dev_iommu_ops(dev) != dev_iommu_ops(*alloc_dev),
> +		"Multiple IOMMU drivers present, which the public IOMMU API can't fully support yet. This may not work as expected, sorry!\n");

if (WARN_ONCE(..))
   return -EINVAL

So that iommu_domain_alloc fails?

> +	*alloc_dev = dev;
> +	return 0;
> +}
> +
>  struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
>  {
> -	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED);
> +	struct device *dev = NULL;
> +
> +	if (bus_for_each_dev(bus, NULL, &dev, __iommu_domain_alloc_dev))
> +		return NULL;

eg shouldn't iommu_domain_alloc() return NULL if any devices are
!device_iommu_mapped ?

Jason
