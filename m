Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7036B27BB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjCIOv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjCIOvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:51:04 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03754F401C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:49:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZbhiVt7Qs/DDPrUW+lkpchR0vmv98N23GBDbGLZMKgj3hj1X0v4Ijcu++7AEWTpiBLPmr7m3WW8wTqICycKQH91FCM5JPg6lU2sm9bFJLJeWCmy7Uu8k215QE+FWb7URtSA01ncapcURvLcsLlPl6mHyrAXqZYqU2XA2vrBuBIz7J7yxJqf63KHMA0Rki4L3KBkJstopiY58bz4oVAQIERCWE84B4VU2HvMyCM7BAnQp/FDc9WoQeGkyq1PVCwIiAUo9KvjGZi9J6CPjf5+0lacSQK6eP+XMb/DK88RXOVWYyNXyJD+3L9qh0i3GirP5HpYKhSrwo8MqcufMUXLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTUynoNbXDO/Qlyu0YO912yAavEIzW5FEqMlorlV0Qc=;
 b=JnUjgvs3p8mS83adKnkpuGu9txx7GvU15Q+UdOan5QcQ8fMTz9QbFXLPSlNkdXTXvGUzGF6/z3TgtblopCJtdJgcdHJekVvxeOa0ooPi+BB/n6EHi2xUHoZiuuBdpSE6IRn8EbTgUglky0SZx5FLvJB8qV8rygIy9435gbfyS5YhEYvlZI2s+pX6e2DJlTFZjAs1NUmK6XCvyzIE/HcVRJfsujazPdDP3HYyTMc/DUFoU6ZX2qvb3Th6yMHGLlDIMq73FEERGGxyOA1YQOOgwTeUoJ1lZ9bMKEmvVsFFMLMyrvdn3g6EWs0+BMVNLu2zvq7zdcMl/kkkuTYyChc2Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTUynoNbXDO/Qlyu0YO912yAavEIzW5FEqMlorlV0Qc=;
 b=Uiy+2ZHjJ4IF+gpMIOObwhXWUy1F6OAZwzExEnF/+Klkyw8Q9UaMXj69Pjqz6iNBtbbFYv6akncNE14nzCWmJx8Wo6gZtqqef92BK+7aou7V6TKo2uo0LoO3lQmwIZH/TsVn8r5nJrjqGt+IqP3+UXqf50kIQ/wg9VsYbP9/y3FEDayiN3HBMK5yytJttcR5nyb1rX2xrVJg44c1KxMzAd8ODmeLEARL9fkbWfgqky6yHCJLM8hWwRlcMXStYWe4VoMXhNFYLTXBi4p4vgfyET759PLFg6gcpRvVf5FY7VCHY/h9AzlExnruHcwDf2hcQBfrTOcLxcLl1HqBiJ7QVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Thu, 9 Mar
 2023 14:48:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 14:48:52 +0000
Date:   Thu, 9 Mar 2023 10:48:50 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
        will@kernel.org, eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <ZAnx0lUkw02cVTi+@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309134217.GA1673607@myrica>
X-ClientProxiedBy: YT1P288CA0009.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b85b1a8-d94a-43ac-0131-08db20ad6696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1jOmdzfM6T4yQtYYqaJZjREub7hZAFkDsSpKZ6v8DokeWz/cdnUTMyJXxFl23Qq3pfFZ1wiiLYjqKjVw4oKBH12jce7a3K1xbvePyhE6mL4b3Hgw08+DRMiVj0WgiDazJ7TZo1TFRasQUkO7kfDr1V/N+bqOrT4NL70zTLR8RMy4L03jaOOaJoMOi0NlPYuwjGMhmUwJLxV4a0e3kBwhODje7z0PARDTXqXtu23T2jGraGmVSgUpQtgODKrlx6RoCjxQB4/kIQBVhLzTl+tjSjacw9VdVWA/BZ3WFkuiaa2RfJL5as+s4+nsqifGKcqjNvCO2l9aQR3aUu/IzD1Nwj3K22WD63ey/vnXj5zD/CL6ObE9QFMzjgQ8KzrKybLgGTOjdrnxTnY0dTnUsEz+LQv7eCHTF348HC6USAObN3SKzOo4l6FLepEOzPSCYnPMaJdPIotMf2FHao7Dg2fMVIIIveHRzZQCIez7cnrG+/rG65hufjbM+tSunm4+830wD+yZFakVNI24SxhmpoLgLHI9h0y/mLi8+DMkpSWYs9ezNqTxyaQ7191BlICc83xXprxcnvvWPbT1nmrS8lYuufTynmxk3pbTyYenNCKfibKFqMiQIvfbf3r6V6famX7O//bIf/58Y3ybRP1p1leJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199018)(2616005)(36756003)(316002)(478600001)(66476007)(41300700001)(66946007)(4326008)(66556008)(8676002)(6916009)(26005)(86362001)(6486002)(6506007)(6512007)(66899018)(38100700002)(7416002)(8936002)(5660300002)(186003)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VxXxmNmkLMNJLt1EAt8mo1+lBskET6A57LSVKVJsUp82osCP8/ZkWcmW/xuk?=
 =?us-ascii?Q?3jQW0iitYr/nwOEZmX7EG5SR0zZTpjVo/YtDnoxsMXAF0noLyvkDE7SULpFA?=
 =?us-ascii?Q?KlGbA4yhirhByYZB1HOykvimUchWBRQMLjzxhRYq/k2DqpX52XlsokLRijSX?=
 =?us-ascii?Q?a2Ei1WaVSSc7mscVmskD8KnpOTK93QMQN58IsaLM6uCsTQ65YMwgoHEOaW6H?=
 =?us-ascii?Q?SKY3C7Q/4MVoCueE9uOArOlQHbQ6wjUqVgKGjeLljJdXU3m2Y9D1VJxtS39V?=
 =?us-ascii?Q?MBY74fCpKo3abmdRqT6LePIXuZ3tDyjAzYm+9PMBLApVPPsaJlhgPCFHA+T0?=
 =?us-ascii?Q?2qVtyeVCn9uVl/7csgV2fJ2tBS2iQau1YJUtM1qmeQQ2pNL+S7PiqDVm9cWP?=
 =?us-ascii?Q?U04gsX8NEO4v7Z1/F76wXI57tjNamu8IO3ZMeBw+ZwUWjcXf3f1tcOTMR0hQ?=
 =?us-ascii?Q?jWSukqJPmMPbmOZr/q5YCwXDfmHh2SDMKjQ0B9mce1APUE8Qu96vVOrYWkmp?=
 =?us-ascii?Q?hnABi3UZOp2I6hrIzwOWbmqPWjBzNoaqR55Y5xQVCnC/mSdBbkhwqVfP/awA?=
 =?us-ascii?Q?g389taA5YRxHMGk+Caq9T7k59Xg9YPyyy2Y1ySX7FYgvEgCF6nolyqKa9ELp?=
 =?us-ascii?Q?P6UW5Nddi6BjXCvbzX1oNP6r7L09wzS08JdPP4O/NWqnsTGeB2g/C085+gtH?=
 =?us-ascii?Q?TwMfqn0b4+3MIObSNF4aRjK4+/RqL3C5g+x3KYdWsVtcoiuMUa7NE5nHniuU?=
 =?us-ascii?Q?hq25kRdD0t/UKGVi5oy6na5HMJAqXiBahqmWEaTlZaUOOt83vdtFUfTixv9i?=
 =?us-ascii?Q?JMHrieYv71XLLaO/T+ge7U+9vtxhP9EnMWnXQaJJrOmEabvYi91Ybzf1lIx/?=
 =?us-ascii?Q?29wpfjKJD4sMLN7pDrs8vaP4NNbcF362D2UKzbNw0mIPpJDnqJ2u18kr4WLA?=
 =?us-ascii?Q?MIHjMRwYhIpyIt62cTRaQ14P0LHr74Mmh52ka0XEuhUmA3FNslkGkuEssGAK?=
 =?us-ascii?Q?bkw4i0Z0XP5O3KaescddUS94jnSTUVoXGx4YSDk2724nI307iVGupXYjRSam?=
 =?us-ascii?Q?Ay8F9uhONvQrNWw9YYOlA/wQ0/p5/X8UiffHIMyeutvzHHmiyUdJCk9YILeA?=
 =?us-ascii?Q?j8FX+S4U0+xM9jlJztEQEB3NDrnOSJma704XsINlAAWj9JM+exPhiy1LHhsP?=
 =?us-ascii?Q?xLUTC10uYUpr6SVEloYqUi4pZDjIkPgJDFU8/HKVKT2beUHFl75nNp9+Gc4y?=
 =?us-ascii?Q?/nFihfAQeH9hGqJbVIkVKiRflMztsElbPn4m8i0N2R+NGaanQrGAJiJ1DHAf?=
 =?us-ascii?Q?e7ntT2E9HKd11XC1iiCsfsKs+89bmlO3yLFsOA3tatWy1wPqy1Pif8d3A1lH?=
 =?us-ascii?Q?7y8MR9+SuAo5bEfPEiURK8AbnVZgGnVQ0LrqUGdBEovtfKFdLtxFbxfxIsTR?=
 =?us-ascii?Q?ro78hTd5gQhtlHkH16Kzh/dnS0t4kyR8N1HDSPQQkjiWuD69NJ3SxvI1lGVR?=
 =?us-ascii?Q?dpDCSIvBhzQxsui5i1sRSCAOecKiDUJT8bT/RLmg75FeILc5TN1Z2ldIzHxm?=
 =?us-ascii?Q?VFb4gCmnaeOM+lXweyv9djV6T15L7b4nawByQEVq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b85b1a8-d94a-43ac-0131-08db20ad6696
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 14:48:52.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXDEVeHRDOGPouOYddmvKykuZqETwQtAe4+vD8Y4vjkrT2iv4RfcwofHsI+l0NVX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 01:42:17PM +0000, Jean-Philippe Brucker wrote:

> Although we can keep the alloc and hardware info separate for each IOMMU
> architecture, we should try to come up with common invalidation methods.

The invalidation language is tightly linked to the actual cache block
and cache tag in the IOMMU HW design. Generality will loose or
obfuscate the necessary specificity that is required for creating real
vIOMMUs.

Further, invalidation is a fast path, it is crazy to take a vIOMMU of
a real HW receving a native invalidation request, mangle it to some
obfuscated kernel version and then de-mangle it again in the kernel
driver. IMHO ideally qemu will simply point the invalidation at the
WQE in the SW vIOMMU command queue and invoke the ioctl. (Nicolin, we
should check more into this)

The purpose of these interfaces is to support high performance full
functionality vIOMMUs of the real HW, we should not loose sight of
that goal.

We are actually planning to go futher and expose direct invalidation
work queues complete with HW doorbells to userspace. This obviously
must be in native HW format.

Nicolin, I think we should tweak the uAPI here so that the
invalidation opaque data has a format tagged on its own, instead of
re-using the HWPT tag. Ie you can have a ARM SMMUv3 invalidate type
tag and also a virtio-viommu invalidate type tag.

This will allow Jean to put the invalidation decoding in the iommu
drivers if we think that is the right direction. virtio can
standardize it as a "HW format".

> Ideally I'd like something like this for vhost-iommu:
> 
> * slow path through userspace for complex requests like attach-table and
>   probe, where the VMM can decode arch-specific information and translate
>   them to iommufd and vhost-iommu ioctls to update the configuration.
> 
> * fast path within the kernel for performance-critical requests like
>   invalidate, page request and response. It would be absurd for the
>   vhost-iommu driver to translate generic invalidation requests from the
>   guest into arch-specific commands with special opcodes, when the next
>   step is calling the IOMMU driver which does that for free.

Someone has to do the conversion. If you don't think virito should do
it then I'd be OK to add a type tag for virtio format invalidation and
put it in the IOMMU driver.

But given virtio overall already has to know *alot* about how the HW
it is wrapping works I don't think it is necessarily absurd for virtio
to do the conversion. I'd like to evaluate this in patches in context
with how much other unique HW code ends up in kernel-side vhost-iommu.

However, I don't know the rational for virtio-viommu, it seems like a
strange direction to me. All the iommu drivers have native command
queues. ARM and AMD are both supporting native command queues directly
in the guest, complete with a direct guest MMIO doorbell ring.

If someone wants to optimize this I'd think the way to do it is to use
virtio like techniques to put SW command queue processing in the
kernel iommu driver and continue to use the HW native interface in the
VM.

What benifit comes from replacing the HW native interface with virtio?
Especially on ARM where the native interface is pretty clean?

> During previous discussions we came up with generic invalidations that
> could fit both Arm and x86 [1][2]. The only difference was the ASID
> (called archid/id in those proposals) which VT-d didn't need. Could we try
> to build on that?

IMHO this was just unioning all the different invalidation types
together. It makes sense for something like virtio but it is
illogical/obfuscated as a user/kernel interface since it still
requires a userspace HW driver to understand what subset of the
invalidations are used on the actual HW.

Jason
