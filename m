Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFF76C5517
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjCVTlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCVTli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:41:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27EC38659
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 12:41:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJAnd1Jj3CPt/M7+CK0YmTxVVnHz5hwsHKQdEcA89pcL7aLuDeV2rogvSKDcWhBN7uIWp4qrZXjmTvorROC+uRwSOBj/ap2CptkNEXSQ73xHrTNMVk43FyuUR8a3kgh9uosP5nbLuwgk9Z81ZIDkZGzKLrZ4of7mfxpw0WnnE9HorhO8NH1GK8xltYBu5mlBcaT11JOcUgw9ZtBV/n9Pq1OA1chqC/GxMx+UsGwNljmsUlxfVjzrUDrxdYrAELriEuWRDdspvOrZf0GRMxXWKxSLjiLlA/imtcRVah1EwNX6/F1wQR97nxa2MWVTLU7XaU+OXF9PZu87zaYDY4IbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luOXkqncHGtzgkLKAG0E90jxjt1aqZMyrqMWIsdTK34=;
 b=anzlrqyH264vLaogGb0e/ikb7fgQT7OjfxgOb9GF2iGp8jxml8vQN3q/PARfNPdtXjeo7eRng124wv+5TyUjKYu5Bk3hTWuWdbaMbNoxrBc8oP4AT1HEJMNuIJWgbAkNmqBz8MLX3mYueAsF+lGHkvFPe25DrGjj3xEt+rtJ2RIN5lUqTQHfToSsNNweJ1LgvDFQDvFjtyRA8C71n9N8ygX/Gs9x08vSXpXPIgZiouTUNKrqVXR3n4ZBBfjsflJt3RMnKtzw18I7tFOz8bmpmjtkJhESjeupf3AJBoJAbIXdeM+ft1UjtxSD64AwBaRUT7BeHPEdNM+1U1XVxg0PeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luOXkqncHGtzgkLKAG0E90jxjt1aqZMyrqMWIsdTK34=;
 b=kGqP+ttm1UNUg0yfIn79cBjUDi1M5HpO161I+w28/JQyRng5uWkwLX+J5tIcSc9ypPqpzv38QgQNsWgfUCWMNStPIa9Jgx5IICpOXT4iVSC/qwkHgXMWUKiFZUO9b81h42o2pSumHiFAz1cIkK9pfY3kmeMfRAmP8i6tmzuYCRIo+C+vdza120udDnwbecelgRiJD4badlSXakBBKmr9RDHACNVuQFLqBH556o82bOK+wXZwwwsEQayE4urbFEo63XW2XjXXS8fg8CN1/rH3svG1q2d6N3Adh0MIxFDzkEp+I5y/ikHxuK7yTlxGsdAWiDKjVAONnsWveD7NA5MgnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 19:41:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 19:41:33 +0000
Date:   Wed, 22 Mar 2023 16:41:32 -0300
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
Message-ID: <ZBtZ7F3NsxngcKIq@nvidia.com>
References: <ZBhYq8o4gqFZVb6k@nvidia.com>
 <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com>
 <ZBqjUeEjjtCclgLN@Asurada-Nvidia>
 <ZBr3/1NzY5VvJrJQ@nvidia.com>
 <ZBs2xaa7Ow1pnB3C@Asurada-Nvidia>
 <ZBs6xlqMGYhLbI27@nvidia.com>
 <ZBtVN4o7GhjHF5Q7@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBtVN4o7GhjHF5Q7@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:208:23d::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: f176dcc3-9528-496d-aa06-08db2b0d7122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrcf36F7SgpoEZ6m+5nPOA9WnWeOGpbXgxA6J37bALw8PIQpEv0rM91NVn8nxesLe/3/bnPpQaRjaomOc0aZuwRYAMn34gGMNIiDqHQWvYw31ih6lVcoit31ggBU+SPDKrOir474NTznLjYp/YPHX+2yShul1UyXyiqMNVlXfJfZ5kFbC4GrZgAc7ct3FO2fj+zHJGMxdoJoEpOIUXp/q78Q8KEsoL3yrKi4yckmuyVKokgKebLROlFC1oIJywsso12gSbEMVdRiGY1oRcwaNulNHM1nHup4M55K8eGJfAB33NVYJTnF8kSYmX4SyQIzeBNVVZ67W4EX6CelXBLHPLvEsD1BsMD+N2ApXmb1YeNEC8s/8MItzXoBTnkfvbOKvyRLQjGJP2nYQgrzaJZcFNNGiKrDwqOyLEoFMem+bKMPS4zKE7qCrxWWzkP5xjYu6nnbCzOYghmIHkyEHJ1AkbdwDSRCdfq1EcBlygR9f96NNNFrpTt6SF9NeHHqWXZzmFr5MpFsLHnS5zxiv6pe6CGQpLmqCddP4ONBLtgarvdjScVel3F1R5Uq8HwGnHMZw4zsGcJGxulWwl41ZMBIYFH8LuBYD/uoUCjT/qBSNBb7KdTvJbo1XoAK63gPpafEp5QbWhRf6g0Q635Gk2C4aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199018)(26005)(83380400001)(86362001)(8936002)(4326008)(8676002)(6862004)(6506007)(38100700002)(5660300002)(7416002)(36756003)(41300700001)(66946007)(66556008)(2906002)(66476007)(186003)(6512007)(54906003)(37006003)(2616005)(6486002)(316002)(478600001)(6636002)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HRJxLKw+XpHAa64f6G6H7gcnctXgR+Cob+LPrRJUcqWeiV2N6o/h43cWAldU?=
 =?us-ascii?Q?SO3O2SmwXgg/1K49CvW39SsgNwSGg2IUphWY/cjO3TZR/dvIGuQQ5EooPMGI?=
 =?us-ascii?Q?Im9B4CnsGxLNV7pujhkM0vcNvLraJ6CoNrhPsNr2bi+ZTCYoNSRjGEiguR5P?=
 =?us-ascii?Q?2vIsmg2rGLwP1NuqhGBELaIrV4Ahm4EQTLIL/4KQqMVs25sIbiUe7zBXBDtO?=
 =?us-ascii?Q?Mqp0AIpFpkxqlrUgnaVH62XcC0WgHsUNDMDKFtbn3Jk+nPFxh3xnz/DXfrE2?=
 =?us-ascii?Q?ptuCwzqG6btehbItCAW/QrTHq8x6GILO4LI60PHttzlpXzEspQg6xYJKrNJL?=
 =?us-ascii?Q?mVsebIwRpLxyGJW4cACl4sq9671X6Fa3NTkDM4foI9bSKNwH7a6k/5PzAdej?=
 =?us-ascii?Q?wzabhweW2igUMa9sNWfWgBY4MPDLoZkIkFtSzdu6Xq88p04zjXl8ZPcc2Uie?=
 =?us-ascii?Q?ECfJ9FTioNcXJ9UUNczd1eUhD1K1gI/19U6COmCpOoks066EnPn4bpo60gov?=
 =?us-ascii?Q?zSy8ubswBlAhFWSuyzyaPaHZljjDaFXiJzwq/rI+BDpsgRN3r7wYOYs1eS3+?=
 =?us-ascii?Q?TOtHG/qwlwvk2BNg+Sz1WMBPbLslRNMbqM0QGI7O9BT9Pv9d6S8ah4u+h+mw?=
 =?us-ascii?Q?HOtsT2QWpCDKo1V1Lr2P9hK+5m02VwXYZWFXMt9t6K+2PacXHGd2lQ8xGEwp?=
 =?us-ascii?Q?J/Ykd2L+LhfzpG5efmU/383UuMe8WHJIohjjETjp9HOHKATUPX3EoBxCx3Ow?=
 =?us-ascii?Q?2n1HlxA46mnps0RENsqIO9WnsR8lA56HComIf4xfXDLvq4OQNdw7XyKpXUZr?=
 =?us-ascii?Q?vqrV42m2NYyoHc27tMcNpKmyQgc0Er6C4jO5FIja+NpnHkL1MwBcJI+C+aV6?=
 =?us-ascii?Q?TkBOfim4htaPjXQgwR+cY7yokeqHY1hVb3lgEw+pAYrZR3Smlp/uxSPEm5j8?=
 =?us-ascii?Q?7DXamJ88c1TfS9LZRyOL0pjyfmRoY1OPL1ooZZiUnuuXc8H6+PWy3bFkanFa?=
 =?us-ascii?Q?m/eTWECjGQd0cY0Zdfe3InLaZ89MNM4Scgf46Bjuuj81qH3zNhwOqlocpRrj?=
 =?us-ascii?Q?aH3NdEV6Xc5SFKsYI1rcUdDOz6Q2G9q596CU4k5HRwLJE/3u28QCgZK1rnwS?=
 =?us-ascii?Q?g5WysbcnZuTz/WnQTyhvfYjAkibnbYW6U+3KCsmPoYlW+Zq1z6LyLIVffV1m?=
 =?us-ascii?Q?/aPtAvsLYmI1TzjlpUos31P+E2pFASvaevUQAjJU6PB1qVxOK+gWqVC1KMLR?=
 =?us-ascii?Q?QQAGA9pAqseMV522ypT4LW3yC1Ra2iQFUXz/Zs7pkASl1f6defOdrKHwW63i?=
 =?us-ascii?Q?CPiGKlWTH/mLzZx1BJHmaXBZaC5329FtqfV3uScb7gIfSV3u816efQrkc8Wr?=
 =?us-ascii?Q?FnaFHJ4PX1TMeCeBqR5hpEmOFbpmwWLE5cbMz8ZuZ2DoI4TC8kbrvOSMZzve?=
 =?us-ascii?Q?4fchFmfK6aZrEJTvehyA8tisVaShSIegpfdoShxDzjbEY/1GfNDufirxVv9F?=
 =?us-ascii?Q?IQv/eDyRtYQZGWxn7N2ac4clSuY5stTNCZO7ZMvHTTlWsUudrqQNzgkc08a1?=
 =?us-ascii?Q?+Uaxajwqfe5zVsWY2gxP9cFZpPNMYxITB5+2vw1q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f176dcc3-9528-496d-aa06-08db2b0d7122
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 19:41:33.7421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhOhHnonR4rJAIPalKvWFOiSRyEuQdA34XDTJ1D3IV7GECASYZ65mdy/FMGH3+UU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 12:21:27PM -0700, Nicolin Chen wrote:

> Do you prefer this to happen with this series? 

No, I just don't want to exclude doing it someday if people are
interested to optimize this. As I said in the other thread I'd rather
optimize SMMUv3 emulation than try to use virtio-iommu to make it run
faster.

> the uAPI would be completely compatible. It seems to me that
> we would need a different uAPI, so as to setup a queue in an
> earlier stage, and then to ring a bell when QEMU traps any
> incoming commands in the emulated VCMDQ.

Yes, it would need more uAPI. Lets just make sure there is room and
maybe think a bit about what it would look like.

You should also draft through the HW vCMDQ stuff to ensure it fits
in here nicely.

 
> > > Btw, just to confirm my understanding, a use case having two
> > > or more iommu_domains means an S2 iommu_domain replacement,
> > > right? I.e. a running S2 iommu_domain gets replaced on the fly
> > > by a different S2 iommu_domain holding a different VMID, while
> > > the IOAS still has the previous mappings? When would that
> > > actually happen in the real world?
> > 
> > It doesn't have to be replace - what is needed is that evey vPCI
> > device connected to the same SMMU instance be using the same S2 and
> > thus the same VM_ID.
> > 
> > IOW evey SID must be linked to the same VM_ID or invalidation commands
> > will not be properly processed.
> > 
> > qemu would have to have multiple SMMU instances according to S2
> > domains, which is probably true anyhow since we need to know what
> > physical SMMU instance to deliver the invalidation too anyhow.
> 
> I am not 100% following this part. So, you mean that we're
> safe if we only have one SMMU instance, because there'd be
> only one S2 domain, while multiple S2 domains would happen
> if we have multiple SMMU instances?

Yes, that would happen today, especially since each smmu has its own
vm_id allocator IIRC
 
> Can we still use the same S2 domain for multiple instances?

I think not today.

At the core, if we share the same S2 domain then it is a problem to
figure out what smmu instance to send the invalidation command too. EG
if the userspace invalidates ASID 1 you'd have to replicate
invalidation to all SMMU instances. Even if ASID 1 is used by only a
single SID/STE that has a single SMMU instance backing it.

So I think for ARM we want to reflect the physical SMMU instances into
vSMMU instances and that feels best done by having a unique S2
iommu_domain for each SMMU instance. Then we know that an invalidation
for a SMMU instance is delivered to that S2's singular CMDQ and things
like vCMDQ become possible.

> Our approach of setting up a stage-2 mapping in QEMU is to
> map the entire guest memory. I don't see a point in having
> a separate S2 domain, even if there are multiple instances?

And then this is the drawback, we don't really want to have duplicated
S2 page tables in the system for every stage 2.

Maybe we have made a mistake by allowing the S2 to be an unmanaged
domain. Perhaps we should create the S2 out of an unmanaged domain
like the S1.

Then the rules could be
 - Unmanaged domain can be used with every smmu instance, only one
   copy of the page table. The ASID in the iommu_domain is
   kernel-global
 - S2 domain is a child of a shared unmanaged domain. It can be used
   only with the SMMU it is associated with, it has a per-SMMU VM ID
 - S1 domain is a child of a S2 domain, it can be used only with the
   SMMU it's S2 is associated with, just because

> Btw, from a private discussion with Eric, he expressed the
> difficulty of adding multiple SMMU instances in QEMU, as it
> would complicate the device and ACPI components. 

I'm not surprised by this, but for efficiency we probably have to do
this. Eric am I wrong?

qemu shouldn't have to do it immediately, but the kernel uAPI should
allow for a VMM that is optimized. We shouldn't exclude this by
mis-designing the kernel uAPI. qemu can replicate the invalidations
itself to make an ineffecient single vSMMU.

> For VCMDQ, we do need a multi-instance environment, because there
> are multiple physical pairs of SMMU+VCMDQ, i.e. multiple VCMDQ MMIO
> regions being attached/used by different devices. 

Yes. IMHO vCMDQ is the sane design here - invalidation performance is
important, having a kernel-bypass way to do it is ideal. I understand
AMD has a similar kernel-bypass queue approach for their stuff too. I
think everyone will eventually need to do this, especially for CC
applications. Having the hypervisor able to interfere with
invalidation feels like an attack vector.

So we should focus on long term designs that allow kernel-bypass to
work, and I don't see way to hide multi-instance and still truely
support vCMDQ??

> So, I have been exploring a different approach by creating an
> internal multiplication inside VCMDQ...

How can that work?

You'd have to have the guest VM to know to replicate to different
vCMDQ's? Which isn't the standard SMMU programming model anymore..

Jason
