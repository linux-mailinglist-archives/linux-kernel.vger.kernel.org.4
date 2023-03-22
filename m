Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FEE6C4AED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCVMn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCVMnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:43:53 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B73B221
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:43:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZE+x2868TL0y5SFmCB/RTFqxrCnMXx9ooTfxDC2csAnuRFDwrJkQo20ViSjGhy0/Q5AXBTrfdt8xvUEQeK7dfZE/jHGN3NJG3k5pbUPx9ZtDrRfHdnETCvMAjQQE6NWGqMEdrM85QuffbbMtC+Lg8VBnXU8IHZlwRtWT0hYCzkH1aUIZn1ZCfFXOC4DHzCQPOWxPaxJa0MEepjOIWcbDCP2KB8ARt4GuoIlREh+UnRG4XNuWrn23tWvlyBV3AmWbcSHD+cGhhxvcmWZW380D//B2lnMe+eIq55OKkdqr1oBZfIpqv6vUa+NLOk3ZFXW26hkiWfWMX9mfmjlV79Ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQZRcxm3QhLGYxhl7++Wolz63ApavU6rouQP3e9sqLY=;
 b=bpokNw/+qECViLUVmu3/ehbYbpzuXQxTemVH5iib/GLMhnAW2213kmmaCfhgwbxxdoPmgnWOBothFE6sDs71HP9zUD3WfYLjA92hzcVRfGxCSc9INWs1gZAZVt9P8v2FvGcCLFgsF+2f62cZllNquGRGYy9CGRuVKqbW4EB+wtv2kHMNxgb/e4hILl6ECPDEm8KTGg2//OsRkjEe3Lfb2506Ws8CpubCZ9UgdJ0QX25gH1IUV731QS4JBaY+Ar/HucjRxC1xEaUJNSEY/FGk10Y0Qw3AM4fq5NzmgMm1ipST5Jqo/n/5TzDURs0xXElEFkTTmsMM2NkLHVQ3BBp1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQZRcxm3QhLGYxhl7++Wolz63ApavU6rouQP3e9sqLY=;
 b=S6R9UvZ44DRpGXkBcD1KT47Zho/lk1662ag7pRrG1sHQOlknb6O4JToQsSAltTm1hT7iZEQrt8780y3X+On1SmzMvv3oKzDao9RMN/1hcNeJgGXWFqVxBh5QIxKp0AfXL3a0tod3imujmDTlKQgNEyIX0LKT1jtEqt8ND46Hf7gN+x0gK0yXdseQ1BFhIpBnozLB5xVwl7P7eruBdCwkMb5B/evcCp/fZep+qLto0lAin+6vP2nenqenbgrQl4e+ZaBmJKV+W0mzqyHDEdq2G75E3y/+z8VS2k4koWWKdqJQXlH8sErqQjEgbdGmVLPtJK98mGEmA2RT0ya+ibIXuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8264.namprd12.prod.outlook.com (2603:10b6:208:3f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 12:43:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 12:43:44 +0000
Date:   Wed, 22 Mar 2023 09:43:43 -0300
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
Message-ID: <ZBr3/1NzY5VvJrJQ@nvidia.com>
References: <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com>
 <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com>
 <ZBqjUeEjjtCclgLN@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBqjUeEjjtCclgLN@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0386.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: 386175e3-0879-48e3-bf74-08db2ad312bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /pRTktSRUvddzYfMkgS9+aUsTsYMWL/QMfAZuzGxzttxfgDzv1As3iAJCKFBGWyH7RL3KdzOCFvoVwu4cYSiBe8acknn44YKnjhbOvzCHG19wtkGIxAGeEP/Q7BGyhXkoaOO9EQu/EUU9UfnBOms6JdsWHBXzrdnjmkHuAl7GkdldU4xy0lXNRCGoU5Wah/QBfwOigSAIs4asMBOfGdG9Ifj5gCujoC9RvoJ44Lea0jiF1GcxMcOflRnf2JzFQzrEwYPigOavegu0gNos9qfN1xGGCuLvTlSY60iY7OxCoLb2WnNFwL7UMWnn7C8ximmnTdOzFj9qo6Wx4TLHHrftoRMk+d4hWdieU6oJC/Qa8AGj+zm87Q5X8PnTZAMfnT+UpIaguTGNKG8ZYh3Iq3LxWz/s3oGc725zVIxi4gO1aUMiP6JbVPP2Lno3SU3yrfZ8QcRhskaEr7J0q3pErG0IrPVgJFt4C9uS3eZzaYkF/kXGzpfJCmodgbKJPiqhqo2OV+D+3KNEJZwqJAFKErKI8e35uG/lIfP++gxj+TrGTh7k54TpOy3artyT9ol68Qb+1APzFV6VU6PLnVpF2f7qxDBBeLIVo2E74QyQQ5cDKbZaacVkViU1OluO3srEHj+wAy9O2+oetFugnr9XiA+6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(37006003)(316002)(2616005)(6636002)(478600001)(54906003)(83380400001)(186003)(6512007)(6486002)(6506007)(26005)(7416002)(8936002)(38100700002)(6862004)(86362001)(66946007)(5660300002)(2906002)(66556008)(36756003)(66476007)(4326008)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rrFnbRiMsxpJPL1ZDEN9LYpNDIqYedF0D8R00FKQt+kOHMl2LPiSe0w88dPp?=
 =?us-ascii?Q?rlNXuyYWXD04ZGFx7ki9RHl5plgeDkWJHK3crJiEGn0ISaNDjuu3fdelnSTU?=
 =?us-ascii?Q?LyuyW7pt8Lls0nlQrYAgDm2cxbVXLHmf81OAnLeQL9YJuzOWrxYd9cf7coci?=
 =?us-ascii?Q?zsU7b3bUZkXS6JsrjmC4dADxSiILnQhGn/2PKimKWsvqSZ1GuaS4lzUh/8qY?=
 =?us-ascii?Q?9ovVCtb8hRGdjyDLEMIy2wd2sG3ZpuehHnPJu9Cdn6o7XRkH8iGcNMKG2Zdt?=
 =?us-ascii?Q?xn+hqENNQlMsP5honmjZN/IxT2KvA0UNEFYnjHRm+5MGdQ9neeOVGaoY2scl?=
 =?us-ascii?Q?tLVFQWH0R8JKzrM7/vDTGxka5lsor47/5nWLThS/zxuLfSLcRu5Ba6/b/g2o?=
 =?us-ascii?Q?9DNEoMTg7LQ2ymgD1PYBmojbic01Mukbju7Z5Hgs0tAG+xDJrlU8NhhFaad7?=
 =?us-ascii?Q?lgc4ucWY4+zpEOCBPkgWbWvpw3xnxq5vXs2PT8m6UMcKk/9gfBpJVaM2WJlE?=
 =?us-ascii?Q?b8Yr1++VBQEobsmXa0D54XukkXvDOIt0tTIZpZ7fP2kc2i2xcpNvzd8r2Rih?=
 =?us-ascii?Q?4zbv2CobdC0Z4FnNPAlsZmgL9lCb8wt7hLCI4D6ZFHKtlWwJwwXpQxdWtnlq?=
 =?us-ascii?Q?Jz3EXgHxJ0SvyFf9enndQ1O9KFjFS1XZYAOxdmB3yv7rlAUwgyls+R1+xUc0?=
 =?us-ascii?Q?v2o11/X6hGBjurStsjKM2lHr9uIHNgpn4tgKa5eIhoWYr7hp0uCoOvqrppSt?=
 =?us-ascii?Q?9ffKeMjtdKyS0J9FwpF5vo4qXmFLTz1oVwtC9oAdybZ2huJayHLWT8wV1R/H?=
 =?us-ascii?Q?rZszQMMlQxjue9d6AOA+c3zmKvIFjrlVzoH1UGis7x27g9hyOfRk5yZSgB34?=
 =?us-ascii?Q?9ZMIyVld7q9Zzjk0n6CK0hT3VfSbZP9a+azco1wcBx+ORPmJRDogti1p+j3u?=
 =?us-ascii?Q?SP+4t3tmMB9tZQC1uUtVL3/3A6wBSB/pfgGUjplTQcaGxKaW9Sw8eOtfMUHN?=
 =?us-ascii?Q?r1wNwjMoKaIHLVgJV9zE0fbquFoLC8T0pxeDOvWSaqmBj8CYahfSNaEYJW8J?=
 =?us-ascii?Q?nRnmR97r0CIu4SjZcjxfJHsDDrrK+xglXhRMPe0BUyAEbqg47MkVER+rkOMT?=
 =?us-ascii?Q?u58Mao5rQRP/YOXs3p7EQYWMESM9NPJTL5eSeMqBxKc6WjdPW8VYZKHyXMjv?=
 =?us-ascii?Q?zuO7IKKiIrSEehWEqjr9I19wejkiHQetZksoxFLZYTHf4tNEZoEG2pzHLHOB?=
 =?us-ascii?Q?YpqsvkIIaBg8Be4W2wO6satbUr5ZKdADiCfVaU5M9SbdMJDYKlTMRg2T2lfA?=
 =?us-ascii?Q?GDvhfH1nVuBA/l7HeWyfsJi/+hdsl3oUh8J9WnTJTv3Py2DA9NZrcswold7U?=
 =?us-ascii?Q?9APk+zwLR9Zsy35wxa1eEN7vblogLvGq6M6tpnrP6QvkeUkXunekFDT/yoc7?=
 =?us-ascii?Q?EFLcDecRWRht4JXtcQz0gGLWEg2K6mHw7t37NP2BBm29o+Yz+NfAIC2mvEXx?=
 =?us-ascii?Q?XA+37My0fZ3M4kkO7Oi1utmgV0fBf/oV80ixPI92m0fuPDrjFRMXzWGXKFtx?=
 =?us-ascii?Q?7i+RCvGVsLw+ETQJ6o8CGw2jI9v7wr1JBWPeYdTb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386175e3-0879-48e3-bf74-08db2ad312bc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 12:43:44.5288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27wEok1LYR6Y1+mw0JB1BbPV6RT6N+gL4nFdYVzks54z7XzxdUzCudqmb/f4ETYV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8264
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 11:42:25PM -0700, Nicolin Chen wrote:
> On Tue, Mar 21, 2023 at 08:48:31AM -0300, Jason Gunthorpe wrote:
> > On Tue, Mar 21, 2023 at 08:34:00AM +0000, Tian, Kevin wrote:
> > 
> > > > > Rephrasing that to put into a design: the IOCTL would pass a
> > > > > user pointer to the queue, the size of the queue, then a head
> > > > > pointer and a tail pointer? Then the kernel reads out all the
> > > > > commands between the head and the tail and handles all those
> > > > > invalidation commands only?
> > > > 
> > > > Yes, that is one possible design
> > > 
> > > If we cannot have the short path in the kernel then I'm not sure the
> > > value of using native format and queue in the uAPI. Batching can
> > > be enabled over any format.
> > 
> > SMMUv3 will have a hardware short path where the HW itself runs the
> > VM's command queue and does this logic.
> > 
> > So I like the symmetry of the SW path being close to that.
> 
> A tricky thing here that I just realized:
> 
> With VCMDQ, the guest will have two CMDQs. One is the vSMMU's
> CMDQ handling all non-TLBI commands like CMD_CFGI_STE via the
> invalidation IOCTL, and the other hardware accelerated VCMDQ
> handling all TLBI commands by the HW. In this setup, we will
> need a VCMDQ kernel driver to dispatch commands into the two
> different queues.

You mean a VM kernel driver? Yes that was always the point, the VM
would use the extra CMDQ's only for invalidation

The main CMDQ would work as today through a trap.

> Yet, it feels a bit different with this SW path exposing the
> entire SMMU CMDQ, since now theoretically non-TLBI and TLBI
> commands can be interlaced in one batch, so the hypervisor
> should go through the queue first to handle and delete all
> non-TLBI commands, and then forward the CMDQ to the host to
> run remaining TLBI commands, if there's any.

Yes, there are a few different ways to handle this and still preserve
batching. It is part of the reason it would be hard to make the kernel
natively parse the commandq

On the other hand, we could add some more native kernel support for a
SW emulated vCMDQ and that might be interesting for performance.

One of the biggest reasons to use nesting is to get to vSVA and
invalidation performance is very important in a vSVA environment. We
should not ignore this in the design.

> > If the VMID is tied to the entire iommufd_ctx then it can flow
> > independently.
> 
> One more thing about the VMID unification is that SMMU might
> have limitation on the VMID range:
> 	smmu->vmid_bits = reg & IDR0_VMID16 ? 16 : 8;
> 	...
> 	vmid = arm_smmu_bitmap_alloc(smmu->vmid_map, smmu->vmid_bits);
> 
> So, we'd likely need a CAP for that, to apply some limitation
> with the iommufd_ctx too?

I'd imagine the driver would have to allocate its internal data
against the iommufd_ctx

I'm not sure how best to organize that if it is the way to go.

Do we have a use case for more than one S2 iommu_domain on ARM?

Jason
