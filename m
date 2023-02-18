Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897C169BAD0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 16:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBRP7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 10:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBRP7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 10:59:00 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0F115C80
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 07:58:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baxASGQCN9uWbzy3BCsajadzQd0Zl10wgqc3plsvtO/ol+JVft9U8BH4kfQocfODJ7uCdyMBZFDg3ZcjCqy7vtoBXfMWoo5/ir3kwBsQ/CMXY1ACUP77rjBRLKYMsL4AnxV6eUNuOo5z+adD+talLNsKSynN9YNl8+zFmdcZgRdg7lDFHhzvDB6uIPYWy7WhBoSEMFyjr55PgvLw2Az4WzqFwNKakbUTv+anUBS/KILG7r/vB+6sCzxhJILqgCI9Z7Qs7D4xyP0xhvHk1vqE1sffZ7r5EluCCjtiJF5PVMxQwqIQ6PKcOCL5HGzhtTS5D6tGl7xX6kB6BkD5F6ZabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK1ckqZMSF7GZbaFc/N/VbMVdjnbUZOwnL0YLSKH8jA=;
 b=YCkNqI5aROBJG+ENAWFKZXq8iXt1FohMcgUgZlbUNCEwvDkYvzqK1bDou9cOFiNsgoGL1dVexvzGZYofR7nXZoTZQi1gc3wxsKQblEfw/+IUkLxMM2GdCXPJ9Qdq0JUwLl8ZPo8pLT4C0sWegK+Pc6Hw1n+YMUIf5wMLpRWgth4PUy/Mvud7nNwvNygDc7CcZuZfEeOcb4e4vV8Tan1hawdG1Z+Lu8GywvMk2dQJ8A4PTzlhAPuXOS7D9afkND+mV9rrhR5SDSD8T6zDyKUvG5cRlxzDCzAtc8NdyPrGLWkA7djRKnJpQn/JZjSBzgasQptAaiSGVEA9otg/gasCbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yK1ckqZMSF7GZbaFc/N/VbMVdjnbUZOwnL0YLSKH8jA=;
 b=H59NDDG9M+aGMsKd4RBNFWDPtNMWwUlMeZCvSGPQLIHIuHveHwZJU0EklzD7UjiNbUksl1SX0wH/gqZbmsMPU5rCvc0YsOkRy2oAyeTDmE356CMESvJxRBT4bePeTaw4kUxBpy8lA1voODNxlJdataHiRC/pr390uhOt86ues967PH/jwIafaFx9+ZjGDUsHIEo4J//4uf1EzrOtjykCyIOMOU9a4j0NWdYEBbsaBu5xJL2LZJk4GkGIBcgMb+3m5Sxx3HQQydu/QbHHVSS4lgy93kTfNhkT+WjsSSpwAkBEOLNty3AZiUot1c8MU/PMAOc0NSwqg0KAI3Cg11RwUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Sat, 18 Feb
 2023 15:58:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Sat, 18 Feb 2023
 15:58:54 +0000
Date:   Sat, 18 Feb 2023 11:58:53 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] ARM/dma-mapping: Remove iommu_detach_device()
Message-ID: <Y/D1vVlqnLAlu2Ck@nvidia.com>
References: <20230217094736.159005-1-baolu.lu@linux.intel.com>
 <20230217094736.159005-2-baolu.lu@linux.intel.com>
 <Y++fqH7Eeq3Njoa9@nvidia.com>
 <6be2aa16-817a-fb85-5371-08e656a29217@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6be2aa16-817a-fb85-5371-08e656a29217@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:207:3c::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2d7258-244e-4de9-c70f-08db11c90918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: liFwOthnpCm5u+4Ut+yubJgs/n1zcxWjmzL8u/vAlIPBansaoWJBKiJh0RfODmWPMLCl9w1iWXi3VgZmB+FXy9t2JPyqiPvVou/KU+mcqbZJ1XpLii4qM65DdJ0nUPxUk4GOFLbE3Oucqe5b8G0cGv7TaE4kn9c7a060Iekyu52osAUCLD9D6puqpz5YZwzAbRN0TjFXlkfoCJB19uUvXLYO89ZdMzmiT8HLiHogyohiPm5C8bc2oPvWOFZEjU5Xbwn55/yxCwyCzzMm2oApedHsWCX2nYTTprUetpcTpQ8+oDPtf7VCXHM2zp0BQhCefSl7UCjhOKJPoyB7m/dfos/6Nj2SOJAG5xkPHoKFmiSCKwXDNqHWgRprHS6uJyZrBVEZ4dUqhyLNKNrlFlOiCSyx5NKo7JnCcaFjMripe/pGraUJdJxCZhHUrF1n5paKJClbmCVckioEpFV1K0IUe595N/el+j2G65lb7IUVGSFkuJKL2AdHDa8PmdI7a/En1YppQ4gpseZ/5O812SbO4HG52vtmlzuUdCRo93eu1xN3rmfx+dzRFxzok+VTvDihe1MCEXTGkVtDlhTQvHwREYw8D0NldKKIH2ETyT0AiukalRwSYqbZCFXAGLthN87TAKhS6lVLC4g2q6A0+gyjTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199018)(2906002)(83380400001)(38100700002)(2616005)(86362001)(316002)(66946007)(8936002)(54906003)(36756003)(66556008)(5660300002)(6916009)(66476007)(8676002)(4326008)(41300700001)(478600001)(6512007)(6506007)(26005)(186003)(6486002)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ogbldtAe23EjRebLSHE37dxRhvM/n4NN14Gdx42BNnCT/KuJALROG6nKWZJj?=
 =?us-ascii?Q?Gf9jdANzUBGUZhXgFI7dxHq3FwjfMSFvA2/YTuWQOZqYuzE4LpjeqtbAu1oY?=
 =?us-ascii?Q?eJzVtzrvFzvR/c2OSiQ+0n/3fB2rOEvZ01rwT3CmOeR1UKcz/7EL07o1t1Tw?=
 =?us-ascii?Q?ep+94TuiGcVSn3JUE34OFLzL+tIB4nHYAnI9LVgji2gv2xrO/n3RpCCcyLTR?=
 =?us-ascii?Q?B0JqlqdRv5Grso942+53wfaRsFapELlNiFboiTbJIiNScBjV90er+Pr1DAPf?=
 =?us-ascii?Q?Vj0x0P9R1bljX0Tow8zWFfgAp2je30XNp39GdsXkUxcNw2fo40e9nwTyyUfS?=
 =?us-ascii?Q?HzVFuC77X45CNCP06LvnrHHon/sONyf2D20lg/lpp6TzWcgvsGPTkgqB4PrE?=
 =?us-ascii?Q?7Jl10gH+MBk/ilhWRCskLEZf//dGE+B4ASjY/UYZL9TZm7veElyK3pd5B+ec?=
 =?us-ascii?Q?1k5yO6xCbNEXEAQbyuqwfyl6H1PasFabr6SRF1aYlVejIewED1sZ/nMWh/R+?=
 =?us-ascii?Q?hWM2rUabnb742OdtjtSYc/mwgRRV188UgXrNw80KulZavQa5hmnlweNnjIl6?=
 =?us-ascii?Q?XrnyOM6PtR85Wga31MXmR2pKSDxD1NosC4Uq1fpkd+ovSYIoAnfVejhmHfvR?=
 =?us-ascii?Q?gq+4EIus+Yy+VxK19KgTu5kQvI5Duby4TiBL3lVdqNnmsYyt2sYd40N6lz8+?=
 =?us-ascii?Q?Cf6mk1eX5mUf5t+sudhFAm35vE9ruUV+0nO7v+C0fQFJkIGZ+KZox+JKgOwm?=
 =?us-ascii?Q?vlxSJd5HEGHqxOqmDRPJWqMKmkQvcH7CB6rTZP57LKh0BwwHgHZdJUsE3WGK?=
 =?us-ascii?Q?PTdCFhpGrpPXWSVtwG+4U5dAxiX6N3TuuuKBeZ88jVRo2HLaCfuK+PCO0LFQ?=
 =?us-ascii?Q?3BQ8zBruE9sdBM/pbznJjsp7yieUY3G0x6Zie2+4IcosLuw4u8iGSEtS+U9T?=
 =?us-ascii?Q?wEcR3B56neRHcX52pZXShoCejH5CIXVAB4b4tZ/xtMvgLvtDkDa+JWwSDiPn?=
 =?us-ascii?Q?TJdPtWYK9TrDEV+pPpwyFzzb12a40MCdqwJwfAUsrdFuJNhNq0drnBujMm9z?=
 =?us-ascii?Q?m5Anw9gsZrbSjo8RvJYi05Zybz2wJFLgRAqhS8D/wacxljb8DkoxUKLIZp+F?=
 =?us-ascii?Q?9ErazCM4WqByq3Li5/pm+A4d5NqRZAxPKhH6/ePrfF3aVq2r5Iz9leuu83Dp?=
 =?us-ascii?Q?ojmD+QeZ+0bA6mFy+SQZxwXsMHKRkAdoC9QDWp/m+5UiLDcm8hXpxZsWa8l3?=
 =?us-ascii?Q?WmnH6HBfaVvIy59joUoI+XPNrB6ssMhTburtKz6+nCO8fd6nbHV8i4+UQSiY?=
 =?us-ascii?Q?97UdvimY7vcrWpGdDR6N0Hujz49rDl2zC3f91ylys0EaJuyUZl5OZ8Ll+z9m?=
 =?us-ascii?Q?iR6/CHNEmV6imAx7EhLscBHHdaCfmJCd9PYmhuJ9OkiGpcGnRYHTRdLAO+dj?=
 =?us-ascii?Q?QYlVbo+C988jRGuEi+iv4knIiavkr1KxL4stXyn8AMGt72KLMSNvHORuc0GF?=
 =?us-ascii?Q?g2fVVWRVf2Amjiw9+2rkJOMw55c5SIl+9s4enZ6OgYe8L+MjytSrDgizqOhn?=
 =?us-ascii?Q?XDE/N6p3Njl2owm5QqST00BazKROfU3wHmYK9YC1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2d7258-244e-4de9-c70f-08db11c90918
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2023 15:58:54.2868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LKYVphuigpvlqk7tdzxT1uY+Mwa1W/V0TzTZ3Y+LElPM/X3aOdYRGcBl3k0hbCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 02:59:16PM +0800, Baolu Lu wrote:

> > arm_iommu doesn't work that way, it allocates and assigns domains so
> > when the platform DMA ops are in control the group->domain is not NULL
> 
> This is what the iommu core assumes, right? Any iommu group should
> always has a domain attached, default domain, blocking domain or driver-
> owned unmanaged domain. The iommu core just switches between different
> domains.

That would be nice, but we still have NULL domains in some cases right
now.
 
> > - which is the opposite of S390's design. Further when arm_iommu asks
> > for a NULL domain it doesn't mean "put it back to platform DMA ops" it
> > really means "park the IOMMU it is not being used anymore"
> 
> This is what identity domain and blocking domains were designed to do,
> right?
>
> If my understanding is right, ARM presumably could implement the
> identity default domain and blocking domain. With that implemented,
> iommu_attach/detac_device() could be removed from drivers and everything
> then could go through the iommu core.

Yes, ideally, but I have no idea what the few reamining drivers do
with their code to properly classify it. So what I showed in the
little sketch was to just mark it DOMAIN_PRIVATE and if someone knows
the right answer they can change it to blocking/identity someday.

In the mean time we can get rid of the NULL domain situation. The core
code would immediately attach either the default or 'idle' domain on
probe and a device will always have a domain attached until release.

I still don't entirely understand how exynox works. In ARM64 mode it
should have default domains, but since it doesn't supply a
def_domain_type() op it only gets the default set of default domains
eg PCI devices.

So on ARM64 some devices don't get default domains, and on ARM32 those
devices use arm_iommu but crashed because of a lack of default domain?

It is confusing. It is harmelss to create a DMA default domain on
ARM32, at worst it wastes a bit of memory. So maybe the fact it
crashes on ARM32 indicates a bug on ARM64 where some devices are not
properly using default domains??

Jason
