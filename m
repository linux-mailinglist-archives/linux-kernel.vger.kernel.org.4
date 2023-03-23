Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2AC6C67F9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjCWMR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjCWMRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:17:32 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C000F2A6E8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YT2Itb6oBs4x6DI9pz/0s14dgJeKfZrraSHdK7IgXSW4C4aAy75IvMFdT886i4Y3DnPS8yn13vDpc+o99emsfUsoZ8/YRVzJ9TXp/0BD5N0WaLeoe94xA0cKqKXmcZ1YqATifeYYaRNBgmdeEgqn+XXlX4O8a3wgdK7cGSfcJc23vNkWE3DigPuuJae85CDbmiv+tGLImU3nf2vAYrU8TorBabTBACYVyekTNtbTmJ34phiwISMS93Cyrb5UDNOSN+SAiOC1ybjCkig3bo9MJ5S66y2sRxZfRkfFrBSOuM2fx3lmWu8PRfvo8KgK5OqjfrrBc7+93KGOUKV3xsCtng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQ59kI/mFRRw0aYjofbmFU5eXA1X6fG3AIB4Cnfz09s=;
 b=Iglf5Ic+5Wprb1IQ4pauRZYeZQ1N7GgLVvpnF+PymfCKkp1p/L/0uos4UhuhiMVVkPhXKigURfkFAecPXTQa1AqHNTXBCu0ytv2GYHw8kuIY++ecftYwErudHUKPJ5rTL3TM3521CgJfESfZLBDcfn7oaf+rQZCRU0qe0hg84U1Xag5Eo/N5EJH/XUAR5AeBf26qTevTCsKNlvkRKAg4CG9tsy+R3afydVYQWsddLb5GHoYDtZ1LzBUfPHkdZcJf37rMCrvbwoWs+/g+dQmsI8xh8slnXg2Xyse+eLLoQ5GuG8mRFZV+hOmJMc0jj6Vw6N5HoDIL6/39htQSINN66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ59kI/mFRRw0aYjofbmFU5eXA1X6fG3AIB4Cnfz09s=;
 b=rxKiyXEWIFlgKYFnCwqUzuaTlMuexJGYlA1D2VMipaLXgOitv0t86QxXaeMbqp10uIifHSeV4bfiwuxmtdpitl4NG3iPHNUYpVW3fGciMtFUlq90dH2ot+cgjsre0zsXV0vg09GwZfv0ay0+Ty3slTwiIETB41rFdGFsBYiZ3YVpy4swFc/7ceaA4JWRGyz349v6YAR+jcIbbamOC8NHryz2wUSoiGB8N/QOYs9XmiMVzhKgK5GRESGyU0IfzuWZXXzZg78pU+I76FhfBlvEmXmfNA5kI2WX4c83lhjWcFRXO2KlFCcP2D3I2aLhLsaW/+q8T77WNA3dAXeU9Sq3RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 12:16:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 12:16:54 +0000
Date:   Thu, 23 Mar 2023 09:16:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBxDM9JJSbx7yB8e@nvidia.com>
References: <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com>
 <ZBqjUeEjjtCclgLN@Asurada-Nvidia>
 <ZBr3/1NzY5VvJrJQ@nvidia.com>
 <ZBs2xaa7Ow1pnB3C@Asurada-Nvidia>
 <ZBs6xlqMGYhLbI27@nvidia.com>
 <ZBtVN4o7GhjHF5Q7@Asurada-Nvidia>
 <ZBtZ7F3NsxngcKIq@nvidia.com>
 <ZBtoj3deE2Y6k9lq@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBtoj3deE2Y6k9lq@Asurada-Nvidia>
X-ClientProxiedBy: YQBPR0101CA0254.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 687b3e4b-b1e0-42a2-64ff-08db2b987d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Hye6O5E9RhnVdhCwDQWWnMYBbdArnnh+WWR88TFtYEz4YAlseu+GPTz+2iuAEpsJ4u030Ixd3lHQcytrxInpHi8Ck6lEcquURi4OuNiwV0CG2rzr5IEIIJDGgYlMcu8FSgJO+RyTa9oTJENNysSQ4P2Am1rVxnGUCef4keg1THbHMhfHMV+ZQqniaxTHT1Hi3zZ1OJon9tJr5Fk3fJ+h0E2t3At98JYWfC7rVw7dJrDBX9imCJeXiRDyH/EXH2YLv+pRZvi4FlBAxetUjaB1Qv8gNqyZyXCecT9o6wm64UDDRZe9AOxRJSZEwq+uDWoL3hNYl2KYMp7QQ4qWAU9dtEdv+1eop4m2a9hoMFahgK39l/6fFa2ndsT/aHMDtZyzuY41j7Dz8Op4Pt+3nNgSem9n3GDMdIyBwdk/kH+8QDQmwdTSuRtDdkqbz2Aq+G4lNuvDFWgwegfHo1lYjAaCJ4Z/CD0R9N5qDFYTQis/HflufzbRyHrC9GEaq3bzoni0mynGH7vlKZm90nfHtBKRIh/bllhAwOsCgNpDXqlod5VqKWIXEM8u5QX+fd33zvgVBQWX23mOh4gaEohBjrHJshNADpgXz5bRuXANnEP2uUvUMaBxbZopWSvb8RhxTD/SnOrwUtA7uteAdKWW5lpvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199018)(4326008)(66556008)(66476007)(8676002)(66946007)(37006003)(316002)(54906003)(6636002)(5660300002)(7416002)(41300700001)(8936002)(6862004)(26005)(6512007)(6506007)(6666004)(2616005)(186003)(83380400001)(478600001)(6486002)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RwOYlkX3t17BqfGnm/SS0iVCE9u+n5nWTZhCi8miP9VYzEQ/jgepvKK/AUth?=
 =?us-ascii?Q?oY9zZ+lPMDv2896c67Y9wIr4DeQOpeUq0VwQH1S3zQZvFkGSjgyzssNVuQVd?=
 =?us-ascii?Q?7ceWmGQK4d3gXo6xMG6stfLKpmBtAT5/CZ1QE7Mj6QGZTMKCpNTy7eEtCIQm?=
 =?us-ascii?Q?XNT3g3uVcjj0BzFH2x/LVP/Q7Q5SiK1954CVn7HtOVJC5iSRY8dzrOEZKq1l?=
 =?us-ascii?Q?CS2EvsvrXcdwai5GX0QEiwPFPIl/ZFrMQ1UrukGInd3gGG4OA8oWiFblE8zm?=
 =?us-ascii?Q?LKBaVq7I0dqh647RPQ0U296tmm8CKBs3DrdWQfSgqe6V3R42KEmSE0kZ1t9R?=
 =?us-ascii?Q?g8mSe4it+a1n5+PqQeqU8S5qOpMgaP2W5bBfptQuQZnBqvMTHbdOIE+iw7Lu?=
 =?us-ascii?Q?f1AieFgUMGTDvRoDlj+FxGDfifw7Z52ZXVFJhHfxnNeTprBL7isxUCZLv9/1?=
 =?us-ascii?Q?84m6aHtkvBzptPNyoUAq7J8AtpqRJO7XxTGFtlSulctrpmRziRBIG8ScVAjq?=
 =?us-ascii?Q?K9+NfAhB4G17XerE35U9l/rNRdI/jp/T7cBtnyzxq/XOgtdd9nos/MEnLLsS?=
 =?us-ascii?Q?H0oiZPcWDnxp4UHJVgR51sP8+ZuQGGbZwygbaE53F3bGNI+bSbUVsq1XA2XM?=
 =?us-ascii?Q?wAu2NiCKV9A5Do8pnWpTgockonxpLnu07XTSTsItzqnSibAswkZv22FghFII?=
 =?us-ascii?Q?LuogonW5cJPDTOzVm0TdRHtQq2/X7b4zWLBxA8YKRcjizkZLSCiw90+/0rgn?=
 =?us-ascii?Q?/K0uYZSAMG10vIw6G8m0Wpn2qpsMypUXCX6UDSXzh5jbgByE5K8WesPLl4qI?=
 =?us-ascii?Q?g5KPwDhsia2HIYwp5VK/ie3xcEfnjjicpp9XW4hhxbg05d6rOk2jUnCE8V3a?=
 =?us-ascii?Q?KTU/XmTr3OiXca3MG3c2hVSjpXk2tU5L45MgzJ3fXCI3kiEkpsZ6G47GluMJ?=
 =?us-ascii?Q?EeVbxt1+7AwNj8CqirEx3j5eegbKYY0ABEkBpDhba8upy87LY2eMbQ92WHha?=
 =?us-ascii?Q?Ep4VbG+4/Gp5qthGk14uaMLRDYmx/EH5w1wMhFdQSkBGM7ZkKQjEcuDqy95e?=
 =?us-ascii?Q?Vdie6D/4BIoiR1BUiaM/4z7VDVRQhlbr7aS2c3LAyeKybWMcwwaCcEeDLlNa?=
 =?us-ascii?Q?WuAaDl5JizRcz0if3WZ8JJnFnHUA5wN/QdVH+vtHynqDAId6KyDLZv+cizS0?=
 =?us-ascii?Q?kwiIfyqUq8m/09xwRdz5xfBgyHnDVpqoWyZf1tJXcf6tXHz7SMBKjTQmxS09?=
 =?us-ascii?Q?1Oi6wUdvf+McppjUHVcHAqQ961P+7QwqaM3+NErAjLvP3NLAFDIuZo4/Gebm?=
 =?us-ascii?Q?7OpyMGlkrHHUaexS4TiN5m0FjNHwMhuLXt/weeh0hNtKDheWv735WhEJfGx7?=
 =?us-ascii?Q?VI6ElFGRItGYCqs8xaEZIRT4UQX2FuI+IUe3gvlAXT5+36J01ExuLMoKmXXn?=
 =?us-ascii?Q?QeCLJkhq/7Nj1wci7Kzc3a9lKl0Hzo1JdvhyNL8fjjuIE132OyNvF41CR2jT?=
 =?us-ascii?Q?uHUuhe8VkvSGKCNpyrayk3DKqo/PUFqnEGLYeYmXf3sA7GZvggVg5OAebpc+?=
 =?us-ascii?Q?g7KS71q0O+49YXG1uWo3ybHSVzZA9dAUAGsEaAfr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687b3e4b-b1e0-42a2-64ff-08db2b987d31
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 12:16:54.0344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQYK6Edgxh7+SF3cJgU74papWwNqQ/oUL2ppwiMMsyaXTm6voNyarhlFH0IYDHrX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 01:43:59PM -0700, Nicolin Chen wrote:

> > So I think for ARM we want to reflect the physical SMMU instances into
> > vSMMU instances and that feels best done by having a unique S2
> > iommu_domain for each SMMU instance. Then we know that an invalidation
> > for a SMMU instance is delivered to that S2's singular CMDQ and things
> > like vCMDQ become possible.
> 
> In that environment, do we still need a VMID unification?

If each S2 is per-smmu-instance then the VMID can be local to the SMMU
instance

> > > Our approach of setting up a stage-2 mapping in QEMU is to
> > > map the entire guest memory. I don't see a point in having
> > > a separate S2 domain, even if there are multiple instances?
> > 
> > And then this is the drawback, we don't really want to have duplicated
> > S2 page tables in the system for every stage 2.
> > 
> > Maybe we have made a mistake by allowing the S2 to be an unmanaged
> > domain. Perhaps we should create the S2 out of an unmanaged domain
> > like the S1.
> > 
> > Then the rules could be
> >  - Unmanaged domain can be used with every smmu instance, only one
> >    copy of the page table. The ASID in the iommu_domain is
> >    kernel-global
> >  - S2 domain is a child of a shared unmanaged domain. It can be used
> >    only with the SMMU it is associated with, it has a per-SMMU VM ID
> >  - S1 domain is a child of a S2 domain, it can be used only with the
> >    SMMU it's S2 is associated with, just because
> 
> The actual S2 pagetable has to stay at the unmanaged domain
> for IOAS_MAP, while we maintain an s2_cfg data structure in
> the shadow S2 domain per SMMU instance that has its own VMID
> but a shared S2 page table pointer?

Yes

> Hmm... Feels very complicated to me. How does that help?

It de-duplicates the page table across multiple SMMU instances.

> > So, I have been exploring a different approach by creating an
> > > internal multiplication inside VCMDQ...
> > 
> > How can that work?
> > 
> > You'd have to have the guest VM to know to replicate to different
> > vCMDQ's? Which isn't the standard SMMU programming model anymore..
> 
> VCMDQ has multiple VINTFs (Virtual Interfaces) that's supposed
> to be used by the host to expose to multiple VMs.
> 
> In a multi-SMMU environment, every single SMMU+VCMDQ instance
> would have one VINTF only that contains one or more VCMDQs. In
> this case, passthrough devices behind different physical SMMU
> instances are straightforwardly attached to different vSMMUs.

Yes, this is the obvious simple impementation

> However, if we can't have multiple vSMMU instances, the guest
> VM (its HW) would enable multiple VINTFs corresponding to the
> number of physical SMMU/VCMDQ instances, for devices to attach
> accordingly. That means I need to figure out a way to pin the
> devices onto those VINTFs, by somehow passing their physical
> SMMU IDs. 

And a way to request the correctly bound vCMDQ from the guest as well.
Sounds really messsy, I'd think multi-smmu is the much cleaner choice

Jason
