Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C056C83B6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCXRv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCXRv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:51:27 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769471ABFA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RW6bjajtzlJ2GpUWvrH8k+qGCBaEASND7Uvw6ux7XYkP3cbjJNY5Dyp9SKXQHEyZrzekDiRQwqbGGUQh53fA8u3giV3yj6fND/aMHV3M3lqfiVl6u/dx29JeyacihNHDtPs2l7v3Lk7cx8M6zt78m3s2ew+Aee4AOMRlAXV+uPPEcvnIHDD+BVKWaXvpdFJkjScvz1mCXfwM/BHOff3O3IfdHbkJhqrRaVNzJ/Tj/PQpmXq0AgCxsIDUi8hHUsQLcMrGk3yAFRrw2wXVaI9Mx48j59UvzTPPhRs0sZ8uSGNWc4N3dabNVSLa1Axi//KwHHr3YXv7II+c245XumcLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zGtpsAZGfR/zrpAJtNmR8fimrgOvBtkbqApdZlCc+s=;
 b=ecAnNm2mDcOSpK1yNHZMxMzsNURKRuShQ2C6FETI0BJWh9W9x8gbkMXw19rl+CveKEsfZgylsz+rBoNMSSfb1wjAX1NZuaEMhFnptYZaWRJOzRWuQvmQTxPn0d6QXf+Z+aiNluk7nDHSriUy1IF9lLHbhX6FxzVo4L8/CFgtEW+J/EjI4zrD4dRTcf/s5AXbb9OkM6lbjtWJGrDOyrlEVqkjZHk5M1Gk8kHtz8MI2BRXxAQmD+0q2JgKnEFaPH+aiJO7RK4tD4+sothhqcVbJKHQmK3WQF2tXULvT5uKnehYubbNMADntbQfRwAm/ZxS9FejMk5phzg/S+ouyGR1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zGtpsAZGfR/zrpAJtNmR8fimrgOvBtkbqApdZlCc+s=;
 b=MWCKzFIMk5I/lxb0VNB07rcTkej2NgNclhwzNBMIxGHDB/XF7wNHlo03ghhUf47QrprJ3h7A9jqWUr4d/Yqu9WbOHfKotWd6aXARKyq1cebOusm0PzqX8RTm/XqNw19a/Hqrs8/NjlKq4q0cZX06c6ljr9PiIwjV+OFR+nYtIZU+Ge2YvmG2tuFp9SPQzTPPg2etdOI0zNif4QTLoOYJ3TEJIQ2EASRk5DRTE3fe9AVU9+rzJbhs2ozaXX9GnWU3Z0GyBpH6t/66AD9mTacCaQNwYjgjA9mstVeIuyMQT+LMPgDZqvgtuvEl92u8gXF97SUaGOoTvHAFekdieERNeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8860.namprd12.prod.outlook.com (2603:10b6:806:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 17:50:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 17:50:44 +0000
Date:   Fri, 24 Mar 2023 14:50:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Eric Auger <eric.auger@redhat.com>, robin.murphy@arm.com,
        will@kernel.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
        joro@8bytes.org, shameerali.kolothum.thodi@huawei.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 11/14] iommu/arm-smmu-v3: Add
 arm_smmu_domain_alloc_user
Message-ID: <ZB3i8pMdz/DCnGGM@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <7d26e897780bdc009b11bc0c0ddc7b755a769b24.1678348754.git.nicolinc@nvidia.com>
 <857004e1-6ab1-f825-7796-9c0b557e7cc8@redhat.com>
 <ZB3gnjeE2I/ubdug@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB3gnjeE2I/ubdug@Asurada-Nvidia>
X-ClientProxiedBy: YT4PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: 455c9209-e748-41ce-8fad-08db2c904ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1sueb2JmKGGP+v059EPShSbG1GTRDwrF91sh89ZsT9I99kswr7UeBipXAhqcDTKMkfm/UxGszyhEqM6lhoiMTOOyyASOSEHyOgG0vcu6T+50kbme6T4YkLLrQChaC104WrOu/eaZnP5ryFUPVevsYsMeB3qQtFv9wGvDhDqB62RNG1qm9xFiD7ssT3/hiRENfbtFVO0vxkpPcyPtzzu2Pr3xhM6mtDQMJyvJICC5NzFd6DB2kd/ZIiXv0yqq2sjC25WHLTs/+jMUb9TGQ0k+1woruqP/IwP8zUepRFWpD3tON1RaXhhSLwxV/uja98d7N4pHfF8cZlf3pnNhrV1x1Ymd+ufastinbHsRu1KiRQyU3oYb+XORhZA5T355RjdbyNw+3b0rT3ivq4oDwboRW/Fq43vvVEcLRoA0gFf0K/MtZfq0Vm2xXKmMGhyyyhOa4185SNmZW78J79oCcKneDD4ZPNCrZdCYzPYsJclQf2d/INP0jn20tbLEWlvAJ0wJzbVz7dehrG2ahnWRH913t0cxIdFmpi+F2whZB06HMhGfDf9K1zljKlejWCujYLLJXe9ATeSX7zEfDKmjJzaOV9cuubj2Q0XoI1hcGhCNI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(966005)(6506007)(6512007)(7416002)(6486002)(26005)(66946007)(83380400001)(2906002)(38100700002)(86362001)(316002)(2616005)(36756003)(4326008)(8676002)(186003)(66476007)(8936002)(37006003)(41300700001)(66556008)(6636002)(478600001)(5660300002)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M4mscDmBIbIIlK/cNtgBPazlG3Z1QHJpx6WdyeTCTRvwFd6fLv8eYhfN9bys?=
 =?us-ascii?Q?UX68u/9RA8bQEv+XA4r9dhToGv2bB24RlHCobfUSq97kiFVcZCK5lj7s3VnN?=
 =?us-ascii?Q?y64ddL23b1haTDiq1h6g2woumWnk8ScuD0h4n/wDu9Q6R5GNZKwtlkVKDFF5?=
 =?us-ascii?Q?g/O8UdJOch/ewI+rPZsHOvMDpxLmPVvd0FH+4iBv6kmA8DDz2fMUOEJERO03?=
 =?us-ascii?Q?uuhzYtN8T0d5Tj51sew8yCWDffOFBXCj2Q2sp1zGL1gqEYUlpqVkkPN+D5VX?=
 =?us-ascii?Q?LtKJKP3Cfc5ooytp7OvohwsKhBmRO3g32VudzupN5QdC8PFJ6hqEfRPmJXaH?=
 =?us-ascii?Q?WPPJcgtVZ8TRgZb6J+FZibmojfPqz8f1VGyA4BTUuF3k1uZOg2Hf+MN7VSj2?=
 =?us-ascii?Q?WdXV0kiDjAbX1JR9sq6+m9+SdcQVFsv4xaiNmOwxeZp5ps9t08aJ/FpMkz6t?=
 =?us-ascii?Q?V0mpqf2b4MokPEqgNjsViPdyWAmvVYHNHi+uzEh0rhOAaOmuFG5kP2Xx5PMX?=
 =?us-ascii?Q?/gR2QuKSODBoBRRMC5yEioxkI1dtcm8VYhVyn0FZCp/lZhbr74fMgz5DAH70?=
 =?us-ascii?Q?Bo5bDM9Embx0DXnuUNLON4O7RKsnAbTvBGnCs7LInEc9l3DJIruxoRmCsdsj?=
 =?us-ascii?Q?GGTU9j11akefEG5lrIHFHSiRnvyv16DTlr+QqTsyfKEabmsBMA0CT3m3g81s?=
 =?us-ascii?Q?LYaYh1uDix6hDdYT6JJ0mwYcLI7OVnS4oqUVc9YDPcrzh5tR9c8qRESPHMiE?=
 =?us-ascii?Q?oe68FPzaSNohS3c+6epSxH9h7huO4SKfaDHJJSWIdx3zxicki/wetTOnEDlM?=
 =?us-ascii?Q?ijSDoNMQlNI0qZ31OFs1SG/iikTRixkmCB0IVgdD3qo7kF89xOA6Ap8gghCQ?=
 =?us-ascii?Q?E6OHWeVVuzUhEXUqNznkOt6gb1mWzNEMlpyKuBglWCxq2zrkI0D3pEsgCmbM?=
 =?us-ascii?Q?kq7cVSD4IDDrOlfGRaXykLZkFL425YtzoSPsqxHkEQL5C6m9OFjlDUIFPtfR?=
 =?us-ascii?Q?IfxsDlmias2mE/anVCHTOfYw1/XhX/qPrBK+QmH6mztnwVZnT6DEhprsKSnV?=
 =?us-ascii?Q?W/sU7cclXVuuxNtlTn7aJvK3mDU41ahHhXBDyeshzoz08CDZQS5CnHR9DgEr?=
 =?us-ascii?Q?W6/1HQqm5cwhs26aJq89JsI76bE68oo0NcX1dHkb59BWeLlgGB9UeHLWlcyv?=
 =?us-ascii?Q?1A5YBnAeJMcXprw5J5IcW/FZvjPEk+RGk0SO+FEygntBuluaVlMK1aRJvpta?=
 =?us-ascii?Q?wGAazKNhyRAdTQauMJwLFZBiAMXCYBpuS820qQoKjeNv4VJ0r2hLGkHdvtnS?=
 =?us-ascii?Q?tCvjynaN5Dc5Hl6o2dg8eyrhenzhGl9lBzvzWu7DInOUjIOSXb+B1nCxM3fm?=
 =?us-ascii?Q?7dUxfyA8aE377wH1reoGYCOhmGFz6O8ziEfqMRvEWxeiPyzA1YUH8KM17RiD?=
 =?us-ascii?Q?OHiTTnpCLSSsL0yD1VsYvKk72Y/MHfITqZCBcBXqYAUGYl//zZ2BgLNmMwpR?=
 =?us-ascii?Q?ZnwovsLYNX9vVip8vJKBKV5Pl6ukYajeioCKqEOjTmqcQQ2TIUS1OW/l5Sl3?=
 =?us-ascii?Q?rZ2EzklC/BaSjvkgRuOrf69e5KC2nybBAlqUiCA1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455c9209-e748-41ce-8fad-08db2c904ab1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 17:50:44.5132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULBRikQfGDN/BwT26MNErHrVLTFmzduP08va8laKXIrJlDZcHl3P9pS8k/Ezlw8h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8860
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 10:40:46AM -0700, Nicolin Chen wrote:
> Hi Eirc,
> 
> Thanks for the review.
> 
> On Fri, Mar 24, 2023 at 04:28:26PM +0100, Eric Auger wrote:
> 
> > > +static struct iommu_domain *
> > > +__arm_smmu_domain_alloc(unsigned type,
> > > +                     struct arm_smmu_domain *s2,
> > > +                     struct arm_smmu_master *master,
> > > +                     const struct iommu_hwpt_arm_smmuv3 *user_cfg)
> > > +{
> > > +     struct arm_smmu_domain *smmu_domain;
> > > +     struct iommu_domain *domain;
> > > +     int ret = 0;
> > > +
> > > +     if (type == IOMMU_DOMAIN_SVA)
> > > +             return arm_smmu_sva_domain_alloc();
> > > +
> > > +     if (type != IOMMU_DOMAIN_UNMANAGED &&
> > > +         type != IOMMU_DOMAIN_DMA &&
> > > +         type != IOMMU_DOMAIN_DMA_FQ &&
> > > +         type != IOMMU_DOMAIN_IDENTITY)
> > > +             return NULL;
> > > +
> > > +     /*
> > > +      * Allocate the domain and initialise some of its data structures.
> > > +      * We can't really finalise the domain unless a master is given.
> > > +      */
> > > +     smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
> > > +     if (!smmu_domain)
> > > +             return NULL;
> > > +     domain = &smmu_domain->domain;
> > > +
> > > +     domain->type = type;
> > > +     domain->ops = arm_smmu_ops.default_domain_ops;
> > Compared to the original code, that's something new. Please can you
> > explain why this is added in this patch?
> 
> Yea, I probably should have mentioned in the commit message that
> this function via ops->domain_alloc_user() is called by IOMMUFD
> directly without a wrapper, v.s. the other callers all go with
> the __iommu_domain_alloc() helper in the iommu core where an ops
> pointer gets setup.
> 
> So, this is something new, in order to work with IOMMUFD.

But using default_domain_ops is not great, the ops should be set based
on the domain type being created and the various different flavours
should have their own types and ops.

So name the existing ops something logical like 'unmanaged_domain_ops'
and move it out of the inline initializer.

Make another ops for identity like shown here to get the ball rolling:

 https://lore.kernel.org/r/20230324111127.221640-1-steven.price@arm.com

There is a whole bunch of tidying here to make things follow the op
per type design.

Jason
