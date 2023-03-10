Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11726B32BF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 01:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCJAX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 19:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjCJAXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 19:23:18 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9B312F3F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 16:23:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k85gM2l/jPrmp4myrB9JkYt1aSCVqy4BO9AsHFuk4NL3vNclG4Km5fjlObVQcyJLC/XprADsdYh+pe8+wtaIuHuySEmwA6qDnYM72kGihLjEF94CiDBC5IInhB7ijEL2ovJpb/BHaHkno5lAt2RLYnFxXufYJ+KB7G8HnLCaELImQiYY7H5MGU71aDSEfMnLP2z+CtCiUo64EDqkj62VdRvBKq+cFaktIEdOo3CZJPSZw2yDtsMHu5dvWBiILdEN2O7nr1ts5gwKCo/4qLt4linlVPXe6Jr1w0Wi/bh1wVaoAWjIJWkeMyaIpej37vRHKm6HTAez4Q6sX44RMBqt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpwkXXSkhbyvLAIlXT2DW5dK+uhu3+m0ZxgqyQAkTc0=;
 b=iOjvys+PM+RWG8RIJDV5VcdR+VeyUXkO+IX7zw1ySumNkfl1BqijhcsZQglDQWlUA1XqvfDGN5SZ1O2ch39I/P+shxraZJ1MtPV4RZuJZBniC8kS8z+nHWVudQVzpfRz3ioRy4jIJllwQqUQf9TXPEmxL/vMCUzCJ06RTDrOAIM3TvgyOvlcR6SDfvu6FbfmNfHbf1pZtbXPHuvWI50+VbDyZ+R1BO5qWnivYZvgyofVysaK2soAoE0sTdzFxx+03YhAheSwWpQyRiJASM4552Oo6ZaYCM3O94H1nyjAlGMi1/vYfC+SHz+MJLSq79wBRJQMEbwLUrKcMnN+Jik0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpwkXXSkhbyvLAIlXT2DW5dK+uhu3+m0ZxgqyQAkTc0=;
 b=Et/atzmQanPEs54Wp+Rd9U7pWoRDyj+RQqHjABbPQwnKOGkWKVNQRgWuVmTo1Yyl5reBNapfhKfvz4hSfOhtLq3/Ul9KkLre36YosoC9tu/BzYlDPNxSh+EMkOAYl4cOXTM58Qo0jxQiX1WfODM8/lJOwVmHAkBOumnwgOEJZsjnL20XpcwwW7dMCXabpHV4OI6puiTNeZf+FIBPeS6Mw9c9FsJNI5sY0JwnvATs9QQwAHTX0vgv9gTgL7yftBh4DiA6mRnLsJ6PUiZ55+ihX0q/8+rddzAvFiVMXtxrU48Smdw+BPkM77vTdzciCirhGhd+5PHjvB4eWotzAReQ8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 00:23:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 00:23:13 +0000
Date:   Thu, 9 Mar 2023 20:23:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Message-ID: <ZAp4bu53sGBBbAo+@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <2118a147-ac95-d846-ad6f-85d7cebca46a@arm.com>
 <ZAnq/8Ak75Dr7JM0@nvidia.com>
 <64c7659b-9bd5-2239-cde9-f7b48f6877ca@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64c7659b-9bd5-2239-cde9-f7b48f6877ca@arm.com>
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e0ba62-c362-4ecb-8bd0-08db20fda304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJo5pF6o8DKwuQUGshXtBJevignwRZxx4qVto3QYjGXY3ekXfo0dZPm5I5eKzxFA5y/MtU2lu+QHUNHiX+NChqhV2Nq7aCi36ORt4QCtVG/q9F1mzzZaPN0cfYYNWrwlHkyzVeHHLbZcYdiCKvYySq8Nxw8iF4/DElUS9FFmvHgvVTEUUkmKIv8oJccsawzD8JeA4qcanoN9WW37oN9Vp1mu0VlXozfgmQEj7CHWZrVivuLqWNV3eXYGeNrDq2RJ7N9x8gqLPas1vEHT69bsXj2RDvoCYN7gIumhiMH+FFp0XBgf7F+QHuqM2A/0xkR4qZCenFGmMhEo437PThJy0F2rfBRUW9ch4icJnyENykkpJqZCp7efECwOSW63pJD2YzENJzKo1U2rPouLTatujPzTiqIYPPox9Bh1WgbE8JJCEHG90vcYFxRpb5aLtngfbg+LOMGv5uXZF6u588Ub38tpWXyBRMUWa77E8srbEqwZS0aUbICN6dAXTiSEivIjdRI+I/neclgkV3C9XxqHCdNTDrW6B6Hl9S72Q0pzKEwh8ZN0tTB+3HdAN2eR/kdh6YS6DSPI1OiuSHT6taxgLxr5VviyesP2LVoHsZFl/yCIVZurxX1R+Vh1WieAnAbiFRR7RD/wzl52rWbfl2rNVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199018)(66899018)(83380400001)(36756003)(478600001)(316002)(38100700002)(2616005)(6486002)(6506007)(6512007)(186003)(26005)(5660300002)(7416002)(8676002)(66476007)(66556008)(66946007)(41300700001)(2906002)(8936002)(4326008)(86362001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MH3HrZfMQVfmia3s7ShgQoVY6en6GCJgBrDYAFsvvpuA06wkMVYpKZ9sLfGx?=
 =?us-ascii?Q?8f5IkLTOa+OcLr60hOoisSllASByVaUlm24fmDH/TQ05pgqs+pqGsSmX9D9D?=
 =?us-ascii?Q?8CouyBxlX1nB45t+RU7CnV6SaHk0/WA8r35Foy+qqQmszS6/8HHOeLR1lR9c?=
 =?us-ascii?Q?75gof8cBTtuluRYEOoK1WqIhTQqa/y+GVl4/EZMxzsfaGR6XzLGQ1lJjNk1A?=
 =?us-ascii?Q?SUW6HB8hUdcjpqGA0RlCD9BWWpu70bKz6Utvtb1Mw/k22s68rLzJMWiA3a1v?=
 =?us-ascii?Q?UUymfQHIa4Jbx1g5B0zCctsXd3SSTUX10+FXhIBXAS76wBIItpETmU7J8Rh2?=
 =?us-ascii?Q?7hnGQgmNDiPmnLPB4jJXguGdIKF3Oj7TqyysHzvjpIImwtJRysgQ4WuEl8GV?=
 =?us-ascii?Q?spvnHnIX+9MXNscr0uEXDa+EwV9VjCMiY5XOfV1EmvQECEFqgPRXRhhm5RDe?=
 =?us-ascii?Q?/EycPXw//SWJSriiUfjhvCkTwkC8QEc9k9ub5awvya/bEwdbH/y9zmiZI7ix?=
 =?us-ascii?Q?g0N1WWbyOFNt4D0nOTi52Gt/wUPl7nlfp+38POaxs7e2hIGrwOGk44WSqATj?=
 =?us-ascii?Q?+XmtwmmaSItRMxKKdWjlszOIAC2/bx45ur2fCDD7+liBtekU2mhLnrAJI5p+?=
 =?us-ascii?Q?DQ+qMZ3uMA+zt/QlSIUG0k6glBTf4CtmH8zgODSJgxxUsTVdg+5b44lNjF6U?=
 =?us-ascii?Q?vkcDTNI3mWuL3k9jf/RntSAK6iq+7aXchmrjwXjaFDgXw4tPazBjmZvakmCc?=
 =?us-ascii?Q?2OUOhcz08acwHu1k3Er6XjYX/33D++fkmhVveLsmKpnaFyGt9WsDrcu5BKv9?=
 =?us-ascii?Q?wzapbesVHQhUgTZVnu3Po0s5JwfW1a4mNBavTe3p5mDygrxXhrhc/oGI8Ucv?=
 =?us-ascii?Q?rR/Fs9nv51YshuTCULnVym307W/p0r+4D2G0FtjJRhDck7wbReOGRjj8h5TB?=
 =?us-ascii?Q?8jqXq1+QbYcY05aKri+izmXm5V5Kxz2V602M8zkM8zpj8yVWUIfd6vJEDRaL?=
 =?us-ascii?Q?oePc4m7QdndhM01mFa1fdUvpa5/yDroPydXP16dZoG0l3cPrHruPARegzkC1?=
 =?us-ascii?Q?eVRNsG1wDNQJUsw4IKIzSmb/Ba0C9S8VO/Cg76F0hFV/3YfkLP7x+cLn7/hH?=
 =?us-ascii?Q?F3CkaxjOAfXih275Ujwef47jUA7XqrnsEQlEZTKPOiqRXpSWxJ8jFoxGZrc6?=
 =?us-ascii?Q?CNSHIEFGqtO0AyjR45IgbDh4WJVb5kwaD7D0PSoJseFfhCO1351C9QxyTHAg?=
 =?us-ascii?Q?BezA3Ajh60iBwIckW/M1vGz4iTNaqNr8KI5wUEAHK698ss9Y9SKM8Bmd4ge7?=
 =?us-ascii?Q?eBw6pgvvz1VA9aUkQvMIt5h0KQIDco+n6w2FAPldZ+FuajItQy5DY7+biITZ?=
 =?us-ascii?Q?fJDlncjmlLGhtM/YEUWqYvTeE5q8BOKzJxCSYZBfRbh5adV8Q1XrAK6G12Kq?=
 =?us-ascii?Q?+hd31ahAxcgB2zU+ba5juEZCL3STwJIoddgQMRATTyrn66cpIfx7eusA1eXc?=
 =?us-ascii?Q?IqZSUUmWL9Z1+SzaC3VBqZpPAniTyszTIv2t5F+LtU1iEOjUrkf2KrqJYCwy?=
 =?us-ascii?Q?7Y8Rpw9Z0iIfx0jZBXPGWRZYCoBtZ6cFVGPngebp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e0ba62-c362-4ecb-8bd0-08db20fda304
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 00:23:13.8730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihCGRb1tK+RrEtRi7LM2FZby6Shx1pA5Hx6OT/pPnPGcTteP0SP+cT3VZ2BuSQv5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 07:04:19PM +0000, Robin Murphy wrote:

> You are literally insisting on changing this core API, to work
> around intentionally breaking an existing behaviour which could easily be
> preserved (far less invasively), for the sake of preserving some other
> theoretical behaviour that IS NOT USEFUL.

No! I am insisting that the core API *make logical sense* and not be a
random mismash of things that just happen to work. I'm not optimizing
for LOC here.

The end goal is to remove access to the S2 and not have this API at
all. It makes no sense to have a temporary step that makes the S2 even
more available then go and undo that.

This is a 'code smell' annotation that it needs to use a special API
because this code has a direct special requirement based on ARM's
definition to work on the S2 of the nest.

The goal for iommufd is to make ITS page mapping to have already
happened at domain allocation time. It cannot be deferred until
irq_domain_ops.alloc() time. Obviously once we do that we don't have a
need to obtain the S2 from a nest domain.

> The overall design of the iommu core APIs *is* being changed, because the
> core API design also follows this logic for any domain type:
> 
> 	domain = iommu_get_domain_for_dev();
> 	phys = iommu_iova_to_phys(domain, iova);
> 	//phys meaningfully represents whether iova was valid

If a nesting domain is used then this really should not translate the
IOVA through the S2.

IMHO the proper answer for a nesting domain is the same as for an SVA
domain - EOPNOTSUP.

But more importantly it is illegal to call this API unless the caller
already has some range lock on the IOVA being queried. It is
impossible to obtain a range lock on a NEST or SVA, so this is not
allowed to be called on those domains.

Currently it looks like it crashes if something calls it with an
SVA/NEST to drive this point home :)

> Forgive me for getting wound up, but I'm a pragmatist and my tolerance for
> ignoring reality is low.

Well, I would like this settled and it seems bike-shedding to me.

> > Attaching the S1 always causes the embedded S2 to be used too - they
> > are not separable so we don't have APIs talking about about
> > "attaching" the S2.
> 
> Yes, that is one way of viewing things, but it's far from the only
> way.

Sure, but it is the design we are going with. It is the design that
was built into iommufd from day 1.

If there is a good reason to change it, I'm open to hear it, but we've
gone through a lot of use cases now and it is holding up well.

> typical lifecycle will involve starting the VM with S2 alone, then enabling
> nesting later - we can view that as allocating a nested domain based on S2,
> then "replacing" S2 with nested, but we could equally view it as just
> attaching the nested domain on top of the existing S2, like pushing to a
> stack (I do agree that trying to model it as two completely independent and
> orthogonal attachments would not be sensible). It's really just semantics of
> how we prefer to describe things, and whether the s2_domain pointer is
> passed up-front to domain_alloc or later to attach_dev.

We settled on domain_alloc time for a pretty basic reason - it keeps
the invariant that the IOVA to Phys of an iommu_domain is
universal. Meaning IOVA to Phys always gives the same answer
regardless of what device is attached.

We directly disallow mixing a S1 with different S2's. I also don't
like the idea of 'first to reach attach_dev assigns the S2', partially
initialized iommu_domains have not worked well so far IMHO.

I think this makes it easier for the IOMMU to assign cache tags as the
the S1 iommu_domain always gives the same translation so it can
trivially be assigned to a cache tag.

Ie a basic Intel implementation can assign a DID to the S1. We know
that no matter what device the NEST iommu domain is used the DID is
the correct cache tag because of the universal translation rule.

ARM will assign a VMID to the S2, the S1 is actually a CD table handle
and has its own invalidation.

AFAICT AMD will assign a DID per-device to the S1, because they don't
have ASIDs in their PASID table :\

> The opaque nested domain looks clean in some ways, but on the other hand it
> also heavily obfuscates how translations may be shared between one nested
> domain and other nested and non-nested domains, such that changing mappings
> in one may affect others.

Well, it keeps the logic in iommufd which should be the only user of
this stuff.

If we develop a non-iommufd user then we can revist where the
abstractions should live, but for now iommufd is handling the thin
common abstraction.

> This is a major and potentially surprising
> paradigm shift away from the current notion that all domains represent
> individual isolated address spaces, so abstracting it more openly within the
> core API internals would be clearer about what's really going on. And
> putting common concepts at common levels of abstraction makes things simpler
> and is why we have core API code at all.

I'm all for more commen concepts, but I'm pragmatic here - I'd like to
see duplicated code in the drivers become unduplicated by the
abstraction. I'm not sure what this is in the S2 area, so far I
haven't noticed anything in the ARM and Intel patch series.

Without a need for S2 pointers in any code outside iommufd and the
driver I'd prefer to keep APIs out of there to prevent abuse.

> ultimately be a good deal neater and more productive than adding yet more
> special-case ops that every driver is just going to implement identically.

To be clear for this patch only SMMUv3 will implement this op because
only SMMUv3 has this ITS problem. Once we fix it the op will be
deleted.

It really is a hack because we are all too scared to fix this properly
right now :)

> And to even imagine the future possibility of things like S2 pagetable
> sharing with KVM, or unpinned S2 with ATS/PRI or SMMU stalls, by tunnelling
> more private nesting interfaces directly between IOMMUFD and individual
> drivers without some degree of common IOMMU API abstraction in between...
> no. Just... no.

I'm all for abstractions that remove duplicated code from drivers, I'm
just not sure right now what they will actualy be...

Like I say, I don't view this as duplicated code, this is hack for ARM
to temporarily break the architectural model of a hidden S2, not true
lasting design.

Thanks,
Jason
