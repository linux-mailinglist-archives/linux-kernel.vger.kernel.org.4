Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3546B2F30
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCIVB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCIVBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:01:25 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A82F6920
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 13:01:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMs1LSSHLb98z2149AsbpbQLARsSfr/LaJuIg1M34mlfgyOzc8HWzTkA0/QK3z3HuzxFzaqwXdzNZfKzO0JOUF7td9a5md3vWwsJk2Zrj9QCDMBY497zWNDpHef8eY2LpZXEd4kMK25f5sFpsUDfXyz/+avhOoP9CHxMoNccCINfWeMgfM3KQmxqMwiZ4pm8aszQIroxNVwp3Rez/R5eK2V/OWvaRBzGcsxdUDqbwyB6I1ZYjFXX3onJdpg2rMs/CYc8OdFLdD6J8hdlo6+5Aqg2r9xqtB1OV4/GjjywVtoqDSK9quYI5KRh+t/mxrx3feDRj3Ezpz+WqF9wbEA1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6XWgeWtMC5uOVeEXB6h1vRKsFpmoKA6H0RuZHCr5hc=;
 b=G1ydH5tMcMq/NL56jK0upfXPwIntq9zx+vse4YWzEUxAtqLcrme8FwZmh+khVvKbDjRHUXTKaT2TCtzDVVXTkS+q2hjDQbEGFE87JjYnGbVUYXamx+xfheTz0ZBvwsigM0AT21a/bRGZNuyUIi1BT25+yQ099iN2LJFMDf5Wi8Ni9KoC+dAVxT/1HWDPgOPP+FloyEh4da+bEc/xEJLfj2nZJdRz4gtS8w7br7PaVSLikRQeF1EJPR8ohWsyVQ0fxRceEJ14w8SLAWx1iLXcE/RcAjx0AKsGVi6D1tqiR/FQ8Hi9c/1Mdj9NwsbrNnQZp+oyUXn8kmkP4ZQHwZqPFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6XWgeWtMC5uOVeEXB6h1vRKsFpmoKA6H0RuZHCr5hc=;
 b=pCpQ0AuBQj5T75W4FdWVEwGdfnPDMMNJdYC4vQn/HbTt6XuRQNhVRnLMa+3fEmqIm9HC8Wpx1gJ4155XxEgL1gZDu0/uFsMpwF/SKLhiGaPCrBDraC9MJ6e0sKf/CRaNdkdfs8ng/VPU2oRdD98Je892mgZlZAg6OH0k0s3Q/m6nHAqnUGgNKplfhNJog7pbPWl+pmB2489v+MzNgJKovI0+mXB8iKLXdJBmtJAw0+yd6177TBtc/iqAumT4t9QJmigZ2ruKKp0Aq6xZadJpm1F0agwibMiRc7ziFZV0odMVUhTrBUzJvrMrunRgECoIOZPLsKEakT8k46EsKJTIFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 21:01:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 21:01:19 +0000
Date:   Thu, 9 Mar 2023 17:01:15 -0400
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
Message-ID: <ZApJGwPjHhlDwTDV@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <ZAnx0lUkw02cVTi+@nvidia.com>
 <20230309182659.GA1710571@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309182659.GA1710571@myrica>
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: c843803d-53f9-4267-474f-08db20e16e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FGRPjjVdXVgzQykZTa2kYYKyLAKbHsinEIdlAmXTH39k+2F585THnc+QZ0e8FKMB2YlPGbLdY8tnH8BfyzXJvN2HpMpPLXBffmLke/HUoNuEaLhiYY97WUND3JjTziMqLcGwpbbMQtr/M3F9DcU1Vp+l4spOTqawWsg18MfkPFdbC2QdsRecqhkCXgpcsKWoFE7JkuwUQhNeR7aRgXV5APl6ihjLlGeFz/LzO8c9SCf8e9TO9f4RwgQlnYaBs0IXvIjZueL6zoAvvl+0r2HXwd0/zSDHKRCrxoiCf+3kxOK7rcowyZ5P4B2MHWf4CF6cw2tXRGjfv+qXoGrEAU7uNBOAYrwd1BmFDcOI+DN+/kZvYS4PTAt4Tsx1CAr4DGWHD0nR9absrWTfOHoRw1zgFyqvnb4vvXDw8QmN5ZW/Yymq7WTbk+Y1OJakGIwYcIPIbjy4NFFTMxzPoIXRLaop7+ux2zAuv6D4pq6BPOPcn6xsbE60ImT2stxbMQWLEEp8BGvC8/PtXG8oB4aIVSz+N+gQqoNP/GcW0Gm9ZuvW8d2ez4/Wo8+TsQJdIC3UM5AvYyf4sG8/ompSbnXKgByoYsmS4dj1qHmgUlbH8HcM0mnYIRqHqPIX5eO9NAGzYdTkA+uv3w26uBDfi5Ek4QxJzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199018)(26005)(66556008)(6506007)(66946007)(66476007)(8676002)(8936002)(6916009)(6512007)(186003)(4326008)(7416002)(478600001)(6666004)(2616005)(5660300002)(6486002)(41300700001)(86362001)(83380400001)(36756003)(38100700002)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i3HNMCAoRIm718agRQXZAU6ih/rJ2Tyb7PIfff9ri4xrlhOZg4PM46qVkyLC?=
 =?us-ascii?Q?EO4IrLR3AVFslabNGxU/AXnGOHdmKs2I0bHUIXYkjCGcLn1uN0dymggxjgmN?=
 =?us-ascii?Q?V3dlo4CKYP6zIeQ0QAzrK+UDrIe03I7dUKoOuUbfBhhiHVsBiAkLjDQVFHkT?=
 =?us-ascii?Q?UI34lUBsHWanIxt6CyJ7Iqp+qa/HKy5ElDoTIGPbc9+PT2O0wFnUFjKteMgS?=
 =?us-ascii?Q?gPmeQcwsWn5IMV28RDcNd0ctC2ezjbSqij49Ns3dzD17UgT6fXV/jWerD30J?=
 =?us-ascii?Q?ZGONoh0fP3p17L+z5kDVIry5gapy2oHYx8nZIJP8iwRMNKjkyQs+xZRXyWS/?=
 =?us-ascii?Q?Z9YSXszIqudJXdQfg7GC5otHyMIiZbrNsx0AYP05rxi4a1EoAreOFloLRDX1?=
 =?us-ascii?Q?XYU5JQtcGfggpSLPTdm0HfLNXQCb8MBTcLrLsOADOSEmk0XZpZlVoCEoPXSX?=
 =?us-ascii?Q?0n7lpnVNZqag+EPKJ8MtaUEMVr2YfRJHTCjZZykFUp33VTVVTMoCi6cLH/Px?=
 =?us-ascii?Q?JUEfC/IHE+Y01RRNmt6+f6gWo0S4PqSgCOUAzJ9Ot2nB4nGg05MwAk/PZ3Xw?=
 =?us-ascii?Q?wAtYPmHOSvyFDs1Zbhx+gRfU+i1u7BkTsLT9BqywcI/ovFnx6fXmIrRk9Y0l?=
 =?us-ascii?Q?gNW8pNzYIcRZZhy+/d6q/wowAZxyfntcTJ8Dx+CUJdog+6hPg3dug1YZd/Zc?=
 =?us-ascii?Q?fjy54Toc61X9An+qBduG3paYl6FrENaFVZ89q1Ov81JrmUscc+NejOhUjn1H?=
 =?us-ascii?Q?4aJrdT7E+RcPGsxW02+TLKSf//sFrNap1zS2zK8NxEK8w02ZXdxyWlYOblBm?=
 =?us-ascii?Q?O2+lzxcvtC1O6FkHdTJLLPn3PyujhL0td9MlEbCCX3ERnhp1rLrV92qmpz2y?=
 =?us-ascii?Q?bcARLMKhqWqyGGfuyzGKucpS3aUn8dmRP4QECBlHa6xwQ64Fs3vQmsoKsS5L?=
 =?us-ascii?Q?nzU2xBXvVJzOcbjyeV6hHY/pERWZIX4FrTaH258M2D9twi8m2+fqyFU3HQrU?=
 =?us-ascii?Q?yNZFNDECXxNGgDSQ4FLy+/chdE0WfOJVbNRyRpFKo+QclFTPkbY7QpP7hqP6?=
 =?us-ascii?Q?5oBr8Gh3ne/2yIbjDWWxrCRT+D+5xA455OMEflxT4QCcg8Vs25w0BRh/lmTB?=
 =?us-ascii?Q?DxgnJn6zSbWc9xuakQkS17A/dEDuTKPm6E46CKaRg4RzcB20njru2yIBWF+T?=
 =?us-ascii?Q?LmQW2JF1uQby0jB3N9ke4Ao0xFju/3egmuB+Z4nIyxSVQDEUVHy5xmWj6bC7?=
 =?us-ascii?Q?7GVNpmlMeNaLieCV+CJCsHud8JQNWlFmGgkJ9DIbKLTlflyy57arBERgY15c?=
 =?us-ascii?Q?lIofvZi0nz+WfVms+As8HNX25Fk5Z4yonOCi0tGa6V+j3k5+YoKuiZOJxAbE?=
 =?us-ascii?Q?JghhntykWImHnu6edxS/mv12djt79cQhZ+9YXhRYQv3smxgZGaS5gQkP1iUF?=
 =?us-ascii?Q?Q4m3X08laOX6GsZ+5WFzIw5EoLyuYgvkMXqXYBeLzBa5a8aIJ2UIWcv6HA+x?=
 =?us-ascii?Q?pp/0+6mE79HC9k2+Gltzy/q1VzDjjkTuZXsxEXy6CYxIDBJ1kBiS+Igfnu8E?=
 =?us-ascii?Q?vF97lIeDRMzSv5fvugvaaOjXPeeMfstnwowRGg49?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c843803d-53f9-4267-474f-08db20e16e2b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 21:01:19.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xDfKfzAU2jPFBEhzPxW9sXIvo80n+ersi13qG6ovijsNKMlyCpz0DxO/MVhlHkl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 06:26:59PM +0000, Jean-Philippe Brucker wrote:
> On Thu, Mar 09, 2023 at 10:48:50AM -0400, Jason Gunthorpe wrote:
> > On Thu, Mar 09, 2023 at 01:42:17PM +0000, Jean-Philippe Brucker wrote:
> > 
> > > Although we can keep the alloc and hardware info separate for each IOMMU
> > > architecture, we should try to come up with common invalidation methods.
> > 
> > The invalidation language is tightly linked to the actual cache block
> > and cache tag in the IOMMU HW design.
> 
> Concretely though, what are the incompatibilities between the HW designs?
> They all need to remove a range of TLB entries, using some address space
> tag. But if there is an actual difference I do need to know.

For instance the address space tags and the cache entires they match
to are wildly different.

ARM uses a fine grained ASID and Intel uses a shared ASID called a DID
and incorporates the PASID into the cache tag.

AMD uses something called a DID that covers a different set of stuff
than the Intel DID, and it doesn't seem to work for nesting. AMD uses
PASID as the primary nested cache tag.

Superficially you can say all three have an ASID and you can have an
invalidate ASID Operation and make it "look" the same, but the actual
behavior is totally ill defined and the whole thing is utterly
obfuscated as to what does it actually MEAN.

But this doesn't matter for virtio. You have already got a spec that
defines invalidation in terms of virtio objects that sort of match
things like iommu_domains. I hope the virtio
VIRTIO_IOMMU_INVAL_S_DOMAIN is very well defined as to exactly what
objects a DOMAIN match applies to. The job of the hypervisor is to
translate that to whatever invalidation(s) the real HW requires.

ie virito is going to say "invalidate this domain" and expect the
hypervisor to spew it to every attached PASID if that is what the HW
requires (eg AMD), or do a single ASID invalidation (Intel, sometimes)

But when a vIOMMU gets a vDID or vPASID invalidation command it
doesn't mean the same thing as virtio. The driver must invalidate
exactly what the vIOMMU programming model says to invalidate because
the guest is going to spew more invalidations to cover what it
needs. Over invalidation would be a performance problem.

Exposing these subtle differences to userspace is necessary. What I do
not want is leaking those differences through an ill-defined "generic"
interface.

Even more importantly Intel and ARM should not have to fight about the
subtle implementation specific details of the specification of the
"generic" interface. If Intel needs something dumb to make their
viommu work well then they should simply be able to do it. I don't
want to spend 6 months of pointless arguing about language details in
an unnecessary "generic" spec.

> > The purpose of these interfaces is to support high performance full
> > functionality vIOMMUs of the real HW, we should not loose sight of
> > that goal.
> > 
> > We are actually planning to go futher and expose direct invalidation
> > work queues complete with HW doorbells to userspace. This obviously
> > must be in native HW format.
> 
> Doesn't seem relevant since direct access to command queue wouldn't use
> this struct.

The point is our design direction with iommufd is to expose the raw HW
to userspace, not to obfuscate it with ill defined generalizations.

> > Someone has to do the conversion. If you don't think virito should do
> > it then I'd be OK to add a type tag for virtio format invalidation and
> > put it in the IOMMU driver.
> 
> Implementing two invalidation formats in each IOMMU driver does not seem
> practical.

I don't see why.

The advantage of the kernel side is that the implementation is not
strong ABI. If we want to adjust and review the virtio invalidation
path as new HW comes along we can, so long as it is only in the
kernel.

On the other hand if we mess up the uABI for iommufd we are stuck with
it.

The safest and best uABI for iommufd is the HW native uABI because it,
almost by definition, cannot be wrong.

Anyhow, I'm still not very convinced adapting to virtio invalidation
format should be in iommu drivers. I think what you end up with for
virtio is that Intel/AMD have some nice common code to invalidate an
iommu_domain address range (probably even the existing invalidation
interface), and SMMUv3 is just totally different and special.

This is because SMMUv3 has no option to keep the PASID table in the
hypervisor so you are sadly forced to expose both the native ASID and
native PASID caches to the virtio protocol.

Given that the VM virtio driver has to have SMMUv3 specific code to
handle the CD table it must get, I don't see the problem with also
having SMMUv3 specific code in the hypervisor virtio driver to handle
invalidating based on the CD table.

Really, I want to see patches implementing all of this before we make
any decision on what the ops interface is for virtio-iommu kernel
side.

> > However, I don't know the rational for virtio-viommu, it seems like a
> > strange direction to me.
> 
> A couple of reasons are relevant here: non-QEMU VMMs don't want to emulate
> all vendor IOMMUs, new architectures get vIOMMU mostly for free,

So your argument is you can implement a simple map/unmap API riding
on the common IOMMU API and this is portable?

Seems sensible, but that falls apart pretty quickly when we talk about
nesting.. I don't think we can avoid VMM components to set this up, so
it stops being portable. At that point I'm back to asking why not use
the real HW model?

> > All the iommu drivers have native command
> > queues. ARM and AMD are both supporting native command queues directly
> > in the guest, complete with a direct guest MMIO doorbell ring.
> 
> Arm SMMUv3 mandates a single global command queue (SMMUv2 uses
> registers). An SMMUv3 can optionally implement multiple command
> queues, though I don't know if they can be safely assigned to
> guests.

It is not standardized by ARM, but it can (and has) been done.

> For a lot of SMMUv3 implementations that have a single queue and for
> other architectures, we can do better than hardware emulation.

How is using a SW emulated virtio formatted queue better than using a
SW emulated SMMUv3 ECMDQ?

The vSMMUv3 driver controls what capabilites are shown to the guest it
can definitely create a ECMDQ enabled device and do something like
assign the 2ndary ECMDQs to hypervisor kernel SW queues the same way
virito does.

I don't think there is a very solid argument that virtio-iommu is
necessary to get faster invalidation.

> > If someone wants to optimize this I'd think the way to do it is to use
> > virtio like techniques to put SW command queue processing in the
> > kernel iommu driver and continue to use the HW native interface in the
> > VM.
> 
> I didn't get which kernel this is.

hypervisor kernel.

> > IMHO this was just unioning all the different invalidation types
> > together. It makes sense for something like virtio but it is
> > illogical/obfuscated as a user/kernel interface since it still
> > requires a userspace HW driver to understand what subset of the
> > invalidations are used on the actual HW.
> 
> As above, decoding arch-specific structures into generic ones is what an
> emulated IOMMU does,

No, it is what virtio wants to do. We are deliberately trying not to
do that for real accelerated HW vIOMMU emulators.

> and it doesn't make a performance difference in which
> format it forwards that to the kernel. The host IOMMU driver checks the
> guest request and copies them into the command queue. Whether that request
> comes in the form of a structure binary-compatible with Arm SMMUvX.Y, or
> some generic structure, does not make a difference.

It is not the structure layouts that matter!

It is the semantic meaning of each request, on each unique piece of
hardware. We actually want to leak the subtle semantic differences to
userspace.

Doing that and continuing to give them the same command label is
exactly the kind of obfuscated ill defined "generic" interface I do
not want.

Jason
