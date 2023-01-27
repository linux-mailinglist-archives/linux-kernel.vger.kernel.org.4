Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468F167E9C2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjA0Pnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjA0Pnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:43:40 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F34A83250
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:43:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVgmCLLkXq+y5nwJfxIRHIT+hxjHbGrntYuTGJhUuMqDECkSwEMwjUW3bXBHxZHJS1DjP4kNQlv/cAqAVNUvOig84TmZ0Rh0Li2CpRDtYnU/bpkFKPbhVm3eyXN62La06DpAv2cBxxCHVhCut3mYjjKycxlGT4SIVumI8ljjn1Jk2Zlrwl5P97Fgw7Wy3deKlqY3fObsJmKruGddODMmdmdtP0Ix6qFfE13fUPb5C/jWdjCYWQyM1RZ9uvz4gZ7RFkJ4+6Pu55eRqa6lvSyS4O+l0yL00o1rCDOSK63Xv19Mhjl+77rH2Vv4J5W7pmsqR6ztKJH+0vA7o0A8wgsR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auY4wTQ3kLaV68UAS4kT5g7lEXXkzRlecKdpmQ84kCg=;
 b=a93eZmUVAhVZiSn8U8lUCcYC9i2E80uNxOAaAkwMAc5YHDfj+Uy23YiFgJVXatQ2DnQB0xWrXbvZKOmkQ8OnPi00GK97m/3JZx/uOhhWQz/mZWzjFOflOTchhHuIBA5QhREdoWQ2o5DRLsJHrO/9xm4NPxqKhzoYoRPlq9jtLmxula2wrmBV0K45WkY4+yQWz/oYduLPhl20uyg7LwJIw/7lh4Np06Kzx6sXui0UiRG4PIe+ruH4Txve3wLdvbXcNRkuaBSoxlai3+F4oeBjja97qBoJHhRgRtxPD/9WZ1q48Hr6GI3evOccmfDo1u6K5+m0pGUmaLAMjK7sWZKcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auY4wTQ3kLaV68UAS4kT5g7lEXXkzRlecKdpmQ84kCg=;
 b=AjITRPE8jpzq1TImyxeiWlVDO+tG2fDYBSsx3q3ubeHOr8l/Ys9iGpbPtj1HSvHiRov2EPUauMUeT3o7Iyp7Dlcb8bAjyuZFU90ZvDy0cnYztEvPTO2QRWoTZgRIfoI8ikSyBCYPAj2+qZ4Zm9NCG4Rl/v4Mi3QJZtHR9ngYRpU8XgVoGucAVyKPTNAGpyILrmNCFMDVrUlUvU6owy4+gQarhfM7KBR1c3vqhG4LNXCjVnvtuLaDgY6Pp/cvTFhYTSR5vOvHgyqjupoW1QSE9Usq/w2MoUx1WYS5vlzGGxBB+GjHtNLfsBMdusmBwGeJVk9NZxJNMCG7WvaCc6BkGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 15:43:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.021; Fri, 27 Jan 2023
 15:43:37 +0000
Date:   Fri, 27 Jan 2023 11:43:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, hch@lst.de, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iommu: Decouple iommu_present() from bus ops
Message-ID: <Y9PxKLyQg/+ZrK6a@nvidia.com>
References: <cover.1673978700.git.robin.murphy@arm.com>
 <1fb168b22cbbb5c24162d29d2a9aca339cda2c72.1673978700.git.robin.murphy@arm.com>
 <c96aaa6c-0f46-39dc-0c72-f38394e37cc3@linux.intel.com>
 <ce25dcdc-99a9-61ff-0cad-6c6cd9552680@arm.com>
 <Y9KRBRKdwSIRrvQw@nvidia.com>
 <b6b55688-1390-4e92-8184-770154a8955d@linux.intel.com>
 <6e0728ae-74a3-b76f-c5c3-6504e13c721f@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e0728ae-74a3-b76f-c5c3-6504e13c721f@arm.com>
X-ClientProxiedBy: BL0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:2d::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 933adc15-196b-4f5b-0387-08db007d415f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1oUKqf2v+F20Gf8qxJGUFdV9A6Z07RefqYi9FtfjBtH7tTG1WDaoFCe77i8iWT/2lM82cq2t5iq08IewKAOOTe5j1CQ5ZVs6p7En9/UTvYLbZGtgXu77utBUk7Lwm2DhaVk7dO/eiwxwT3/OyouprbojFezMpYBlCw6MkJvh9UntPgfOFOGtWRmj8crhUR9lIU3wI1g9NYrstFJ5wNzYPdqZQTNpuOHaoBgqwUPLoWAsUhcS065uMawp4ZzHmU63y/sxcWxJgVWf9li4UAwPFDLvk8Vz2i1esE2PXQnQ6bCKzNMkzn6nv38OpJRqxAtrve4knNzHiY8DB/20kSXl/ugdDNjP1phuNU/OQZszme4VaW/aYHpilEfwXPsKTjW/rNX/Wpur/sVBqqplhCFyak4I0Vv7Tegp97eO8UWyC6or1szCqkSdhdVGcVomed3VZMrJdm+XdebsLiv9KT8VZ++gf1SD61qvt2N8I7RKGzqlwAhwj/z0t1Gg17Masetp0s+AXeEA8zfQEijbt/drnp4hL4n/0+W/BXGe2B1MFOXMJeJxRvEkYLNZX1ofDiyr/5emgd1NKJXkn7qxLgfaDpEtPgKvGTzv44FSljJJs3JtAJEgTQj5/4IqPVx+U/+NL6MFp3o8HqU9h+Ah0UHslg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199018)(36756003)(8676002)(6486002)(6506007)(316002)(478600001)(5660300002)(4326008)(2906002)(66476007)(66556008)(6916009)(41300700001)(8936002)(66946007)(26005)(86362001)(38100700002)(186003)(83380400001)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9zBxJ4LQFS0hhDlCowAl1FO62Sjb95J4OwP2Y16tR5GsNS6I9+ZSwl9iByQS?=
 =?us-ascii?Q?1kKtQMPTTlNfHOPCB3uQb402iIKfPIgsZvRg86MwfgY+aGm2FjOyBQIFB55V?=
 =?us-ascii?Q?VtDTG1O8l8IaQvf9XbltdMfboBXm/3AcwObZFlZoJKMslJlUY9BOUJtXl28h?=
 =?us-ascii?Q?BLySMxRKrMeuYTzc5ulXybskh/fP3Ax7EyG82lY1BjPBtVhQZ3PU2Pp9obz0?=
 =?us-ascii?Q?SO0YSvXGG5eBCzgEOBadXDL0XIeyacI7NQSX8gnSA2MQ6mmiZfe87VkrXBJA?=
 =?us-ascii?Q?VwkqJ9qplCAwUt6WCwCJqtF6xw2RVmEhZNAmBq2tZQtKh/Ax55O+8TKI4jZo?=
 =?us-ascii?Q?mcw8qJUXCC94ORHOW2xUSEFy1f0Ar3uQWi9/tFUUwBg2ntd4tIUy29sz5mu+?=
 =?us-ascii?Q?xWmlqXITxqvwL9x+unO3MpuTbKnLxjRKHaPD3TIQj3aAE8PXGHl4fR2D/Cb5?=
 =?us-ascii?Q?2IUMx6pNfoi4ajs8Ygixpr0eDMXbzPN88ve4seoauzGDTV0h1YmdXXpQFqnB?=
 =?us-ascii?Q?4QoMg4/qQ2+ybMfnwIDAFmU1vTLhG9538yKYUQYnJTCMXTdGer9WUPdmGlJl?=
 =?us-ascii?Q?XEOX2zhFtIodTAZK7xD8zJMmzRmEtulwAvt4bNVP1iwpzHzCEVjKgFEO3v39?=
 =?us-ascii?Q?DFCS780OBh3SYGkWFHQnWBqBbDz4/wlGgshP34YMMQp1RlGYmFVF4VP3JN4T?=
 =?us-ascii?Q?Pm0vjPV1YnzNV+gSQvUNqpZrVV01KtcaMvY4cG7vioo5aRxkcTWDBuG3Q1Gu?=
 =?us-ascii?Q?WUPu0+yQ5MRhtKNBX5v0rnXRhwnbu+N92n+RLrbgd0LWixZqEVMkdU0i5vyz?=
 =?us-ascii?Q?8Q9q4jB4eDYhbOhcUiqwuSZq4l9a27KF/jVS9ZwSTwIrqJzmJVlJe1Oxhvbz?=
 =?us-ascii?Q?8/oKn2jTTYg83UiDmH8TPTAdgq7JCTvYsEgjswHInrKweYGeYgZ17ZEIFFSE?=
 =?us-ascii?Q?6PzuZhEa6GhqXmRHR8pRbijmArrkz13amlSS+T0RGhft6Gniv/h/7FNIjtdB?=
 =?us-ascii?Q?LLDqiyTU3sq7Ipcy+KCXyubZCUqCByny/WC+8KAmCdqEFNm76oN2Tv6c6AUQ?=
 =?us-ascii?Q?7Ec/mS/K9jNr0R5qjIBOF6uTNxw+HhVoi5roDqcB1XP2dKCvJfr0vmfICV5Q?=
 =?us-ascii?Q?+YldHFcyLtFcsSz1wIJt/lIUVI5yJxzsiKDz3FLhrvrVTg2w1DT6nC0uAU72?=
 =?us-ascii?Q?mJgaFIf9T3+N/T3Jpai5eVVjInzR3yjUIbb1jvzBdrIZuC3lUYNKGL77EvD0?=
 =?us-ascii?Q?gWh569tca4mxRxZSYhyLMr0O9bmpB5zHxtzDllJHOzdoRGC+JgYGl0taKLie?=
 =?us-ascii?Q?VEKj8eMJEDKuCpaRLbRKDwi9JJ09MPDPQK+bFm+GkyyD75HGeu5p5msL13qj?=
 =?us-ascii?Q?9wS7b0LlZVr+Jyetw4jDGj9prOkpXv7ITKyBQyH5EpIKlmh+IThntgJUb2w4?=
 =?us-ascii?Q?nlHCD5cU4tp6gTVWPFXM5AFB5Rm1xfNHBU3MmSWsAZcvKMlV+WXjYKyAmvcg?=
 =?us-ascii?Q?6RgM7BEBKsUbEhcpHWcNFfruv72pShCp7tGiI+u+43X9G9IwVBoDysC99s8n?=
 =?us-ascii?Q?IZg+F2RLw0enV7Va0MOkyuCDxR5tqBnrPSJYuPuP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933adc15-196b-4f5b-0387-08db007d415f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 15:43:37.2121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrnLJOjTkov638phUhEnH3WTP54CTqM9s51NJa64uMXriJcAyGJV6rtz5i0tOcU6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 03:19:55PM +0000, Robin Murphy wrote:

> The current implementation of device_iommu_mapped() just dates back to when
> dev->iommu_group was the only per-device thing we had, so in principle I
> don't have any conceptual objection to redefining it in terms of "device has
> ops" rather than "device has a group", but as things stand you'd still have
> to do something about PPC first (I know Jason had been pushing on that, but
> I've not kept track of where it got to).

PPC hasn't moved at all, AFAICT. In a few more months I'm going to
suggest we delete the special VFIO support due to it being broken,
distros already having turned it off and nobody caring enough to fix
it..

What does device_iommu_mapped() even really mean?

Looking at usages..

These are fixing SOC HW bugs/issues - the desire seems to be "is the SOC's
IOMMU enabled"

drivers/char/agp/intel-gtt.c:           device_iommu_mapped(&intel_private.pcidev->dev));
drivers/dma/sh/rcar-dmac.c:     if (device_iommu_mapped(&pdev->dev))
drivers/gpu/drm/i915/i915_utils.c:      if (device_iommu_mapped(i915->drm.dev))
?
drivers/usb/dwc3/dwc3-xilinx.c: if (of_dma_is_coherent(dev->of_node) || device_iommu_mapped(dev)) {
drivers/usb/host/xhci.c:        if (!(xhci->quirks & XHCI_ZERO_64B_REGS) || !device_iommu_mapped(dev))
drivers/crypto/qat/qat_common/adf_sriov.c:      if (!device_iommu_mapped(&pdev->dev))
?

These seem to be trying to decide if iommu_domain's can be used (and
they can't be on power):

drivers/gpu/drm/msm/msm_drv.c:  if (device_iommu_mapped(mdp_dev))
drivers/gpu/drm/msm/msm_drv.c:          device_iommu_mapped(dev->dev) ||
drivers/gpu/drm/msm/msm_drv.c:          device_iommu_mapped(dev->dev->parent);
drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c:     if (device_iommu_mapped(dev)) {
drivers/gpu/drm/rockchip/rockchip_drm_drv.c:    if (!device_iommu_mapped(dev))
drivers/gpu/drm/tegra/uapi.c:   if (device_iommu_mapped(client->base.dev) && client->ops->can_use_memory_ctx) {
drivers/gpu/host1x/context.c:           if (!fwspec || !device_iommu_mapped(&ctx->dev)) {
drivers/infiniband/hw/usnic/usnic_ib_main.c:    if (!device_iommu_mapped(&pdev->dev)) {

Yikes, trying to map DMA addresses programmed into devices back to CPU addresses:

drivers/misc/habanalabs/common/debugfs.c: if (!user_address || device_iommu_mapped(&hdev->pdev->dev)) {
drivers/misc/habanalabs/gaudi2/gaudi2.c:                if (!device_iommu_mapped(&hdev->pdev->dev))

And then sequencing the call to iommu_probe_device() which doesn't
apply to power:

drivers/acpi/scan.c:    if (!err && dev->bus && !device_iommu_mapped(dev))
drivers/iommu/of_iommu.c:       if (!err && dev->bus && !device_iommu_mapped(dev))

Leaving these:

arch/powerpc/kernel/eeh.c:      if (device_iommu_mapped(dev)) {

This is only used to support eeh_iommu_group_to_pe which is only
caleld by vfio_iommu_spapr_tce.c. Since power vfio doesn't work right
now this is uncallable, and when power is fixed this will work
properly.

arch/powerpc/kernel/iommu.c:    if (device_iommu_mapped(dev)) {
arch/powerpc/kernel/iommu.c:    if (!device_iommu_mapped(dev)) {

These should both be replaced with some kind of 'device has iommu group', since
it is really driving ppc unique group logic.

So, I'd say Baolu's approach is the right thing, just replace the
above two in ppc with something else.

Jason
