Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7136C5809
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCVUsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjCVUr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:47:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D33166E0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:44:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckkPbCpDoLUX2vfePkT0iTrLlAcYB4w17UqsXj0LLNWMocTKJwDlayhMiDM8JHZhaRQnAVRKh9YsveWbiJvZGz4w/8SMss1tR5mK8fjvQgCDuUic4NgmI9xvrBDpmxzJrYoCp20oFxYU7QEtgphlK/FipJz1GMGVN1830fgZtuQYC6AKa+UTnM3zWre03+72cW9byY4W31pFVy+UgF8ulb3IQ+TYGlTnjlQJiXx3qg043faQfalFWB7tjdn9bSJ6cG68W7Kz+GrDRXO54rod3FqQ8Ef9FWoJUrJphgSd/Honl0NjgPwr6NQv/3IYPU+ue/+Z6fHX92RG7gVRFhDt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA3drQh6DAx2uIrHw1DF/BTvblM1Qx+UPIMKVULY0Lg=;
 b=Ck5vVGlYyQiPH00hQ9aNMBSiIil/CMNV6xUYZdCCPfJGTHnE9EYY3dSELfUg6SBES0JMBQV7O6EylUfBPWrM+VzlBG5rEVhiW/TZCFXSCv5/ZwPhx2w6P90KWoF/ZGlhBikFPumQK++ihhj+Ye69e6wc0ZMt4dkVCuiw706KcIiu48/ILIXqHkF/gXpdlBnXX6G7iFKQLJDZS+m+leZjx9c6cqQq7PGCIQaPB8A/WNy0xgorMD8tsDgf42uk38MDVi4Dk/Um2D68iyULNa/apwSAsqttcnMaxVL2ld0IbwyMLzf5tkvD5tlF3m8K3f9ZIHFAtMQCXjIAmcKIVfTlGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA3drQh6DAx2uIrHw1DF/BTvblM1Qx+UPIMKVULY0Lg=;
 b=VPYDG+918X0CUogWn2fBjx5QCTOogwI9hGN4nRdwI4Pt0+1xTZXKpA72mEJoFZxTOaWvGHhIsiDsBUX8KjZCDzGWa1psqZcKv4ncB5A6bIlRmI1Dhi1HmBliwjfwDu87O6MBxcnpqHAyQ7l1yZqwQjP2PLcmIXhsSPHzXrSuLGRc/cZvcNfq7FyA5MqsnuHLURKtQ8ksvsPiw3kT6035eIkEnATV0otz2OIJI3Wu4MHfhxfFV2S/JhtsPGP/bjIaoL2+KWDXVnRm6EPnKqIvQslF/ldJo36SXW70g+TNynf6jRxEQ7Soef/9X+3xd90eB82PVTCzA2nnvz22qAaQIA==
Received: from MW4PR03CA0180.namprd03.prod.outlook.com (2603:10b6:303:8d::35)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 20:44:10 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::51) by MW4PR03CA0180.outlook.office365.com
 (2603:10b6:303:8d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 20:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Wed, 22 Mar 2023 20:44:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 13:44:02 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 13:44:02 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 22 Mar 2023 13:44:01 -0700
Date:   Wed, 22 Mar 2023 13:43:59 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Message-ID: <ZBtoj3deE2Y6k9lq@Asurada-Nvidia>
References: <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com>
 <ZBqjUeEjjtCclgLN@Asurada-Nvidia>
 <ZBr3/1NzY5VvJrJQ@nvidia.com>
 <ZBs2xaa7Ow1pnB3C@Asurada-Nvidia>
 <ZBs6xlqMGYhLbI27@nvidia.com>
 <ZBtVN4o7GhjHF5Q7@Asurada-Nvidia>
 <ZBtZ7F3NsxngcKIq@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBtZ7F3NsxngcKIq@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 698fd66e-fd35-4daf-966d-08db2b163091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y8jD8ekSQunHXlx19Ab4akQqTJUmgwQTwVvXjLjfgqndsfTDPw7js1+gMNZHo+LxH989wS7oUs0bzEQrhf4kr5zQYZBGBsK2XSQVgM8YG8YMn3KzRDvmYpjyIqd3IP4Igr47QmQOsn5/XEutNHpJoAJ5Y/h1x4WC5ztfhVVGUbm3wuEIa6Xat1mdlxiEtoHu7Y1eur7k3727SWnx8+yXxjhGeL7h0M4Yl0ECtrpLDi95t4P6PiflxpmbmiWdfYvdzOBhB8Po1rUbkNtb8Pypehnl8DEYGNCKA0q5zVm1OXIe3WhK2xXw27X6PKOiuJYZE2J3kK6cKaUdsi5pfTVm+yfJlXG353OHsihd7ai5oJGh7r2gGuIKEMC79EGtSI0VP1dv+Mz464LroEtEvDDShXMjajDZFYtNAPuOEl/JfvW42mCwpr9yO3338Gj8TMk5dwBcabMV7SipRt7A52/pJIVp47Q33K4Ba0xhGfoFUYleg5l9w2X5oA6g2Nslg7zby/mT6TZ/r8HYj+lG7jNUgmTsAnnLzuQxuGGrQq1BucOU7TJS1V5GhAmP2PHzAWXvolcypN27/wt9wrUEs6ZMIOHVpjBBvSLgu5YmQVhA/nTgcMQTsgxPoS+inmFJi3i3Ch/jOcfcFD+DyLT+SbEWvC0qjTV+lwIRW9SDf8Nkztz2sfQqAV2aXgUEkPJ4GoCx9Dq0gV7rq2swak1rzdmXDLnj/klJ8xKiVjxYRFZ/qudioi8FHI4Q9/wlV2Jmug6K
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199018)(40470700004)(36840700001)(46966006)(356005)(5660300002)(8936002)(6862004)(7636003)(7416002)(36860700001)(82740400003)(66899018)(186003)(33716001)(26005)(2906002)(4326008)(9686003)(336012)(55016003)(8676002)(40480700001)(70586007)(47076005)(40460700003)(70206006)(54906003)(316002)(6636002)(426003)(86362001)(41300700001)(82310400005)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 20:44:10.6242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 698fd66e-fd35-4daf-966d-08db2b163091
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 04:41:32PM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 22, 2023 at 12:21:27PM -0700, Nicolin Chen wrote:
> 
> > Do you prefer this to happen with this series? 
> 
> No, I just don't want to exclude doing it someday if people are
> interested to optimize this. As I said in the other thread I'd rather
> optimize SMMUv3 emulation than try to use virtio-iommu to make it run
> faster.

Got it. I will then just focus on reworking the invalidation
data structure with a list of command queue info.

> > the uAPI would be completely compatible. It seems to me that
> > we would need a different uAPI, so as to setup a queue in an
> > earlier stage, and then to ring a bell when QEMU traps any
> > incoming commands in the emulated VCMDQ.
> 
> Yes, it would need more uAPI. Lets just make sure there is room and
> maybe think a bit about what it would look like.
> 
> You should also draft through the HW vCMDQ stuff to ensure it fits
> in here nicely.

Yes.
  
> > > > Btw, just to confirm my understanding, a use case having two
> > > > or more iommu_domains means an S2 iommu_domain replacement,
> > > > right? I.e. a running S2 iommu_domain gets replaced on the fly
> > > > by a different S2 iommu_domain holding a different VMID, while
> > > > the IOAS still has the previous mappings? When would that
> > > > actually happen in the real world?
> > > 
> > > It doesn't have to be replace - what is needed is that evey vPCI
> > > device connected to the same SMMU instance be using the same S2 and
> > > thus the same VM_ID.
> > > 
> > > IOW evey SID must be linked to the same VM_ID or invalidation commands
> > > will not be properly processed.
> > > 
> > > qemu would have to have multiple SMMU instances according to S2
> > > domains, which is probably true anyhow since we need to know what
> > > physical SMMU instance to deliver the invalidation too anyhow.
> > 
> > I am not 100% following this part. So, you mean that we're
> > safe if we only have one SMMU instance, because there'd be
> > only one S2 domain, while multiple S2 domains would happen
> > if we have multiple SMMU instances?
> 
> Yes, that would happen today, especially since each smmu has its own
> vm_id allocator IIRC
>  
> > Can we still use the same S2 domain for multiple instances?
> 
> I think not today.
> 
> At the core, if we share the same S2 domain then it is a problem to
> figure out what smmu instance to send the invalidation command too. EG
> if the userspace invalidates ASID 1 you'd have to replicate
> invalidation to all SMMU instances. Even if ASID 1 is used by only a
> single SID/STE that has a single SMMU instance backing it.

Oh, Right. That would be a perf drawdown from an unnecessary
IOTLB miss potentially, because with a single instance QEMU
has to broadcast that invalidation to all SMMU instances.

> So I think for ARM we want to reflect the physical SMMU instances into
> vSMMU instances and that feels best done by having a unique S2
> iommu_domain for each SMMU instance. Then we know that an invalidation
> for a SMMU instance is delivered to that S2's singular CMDQ and things
> like vCMDQ become possible.

In that environment, do we still need a VMID unification?
 
> > Our approach of setting up a stage-2 mapping in QEMU is to
> > map the entire guest memory. I don't see a point in having
> > a separate S2 domain, even if there are multiple instances?
> 
> And then this is the drawback, we don't really want to have duplicated
> S2 page tables in the system for every stage 2.
> 
> Maybe we have made a mistake by allowing the S2 to be an unmanaged
> domain. Perhaps we should create the S2 out of an unmanaged domain
> like the S1.
> 
> Then the rules could be
>  - Unmanaged domain can be used with every smmu instance, only one
>    copy of the page table. The ASID in the iommu_domain is
>    kernel-global
>  - S2 domain is a child of a shared unmanaged domain. It can be used
>    only with the SMMU it is associated with, it has a per-SMMU VM ID
>  - S1 domain is a child of a S2 domain, it can be used only with the
>    SMMU it's S2 is associated with, just because

The actual S2 pagetable has to stay at the unmanaged domain
for IOAS_MAP, while we maintain an s2_cfg data structure in
the shadow S2 domain per SMMU instance that has its own VMID
but a shared S2 page table pointer?

Hmm... Feels very complicated to me. How does that help?

> > Btw, from a private discussion with Eric, he expressed the
> > difficulty of adding multiple SMMU instances in QEMU, as it
> > would complicate the device and ACPI components. 
> 
> I'm not surprised by this, but for efficiency we probably have to do
> this. Eric am I wrong?
> 
> qemu shouldn't have to do it immediately, but the kernel uAPI should
> allow for a VMM that is optimized. We shouldn't exclude this by
> mis-designing the kernel uAPI. qemu can replicate the invalidations
> itself to make an ineffecient single vSMMU.
> 
> > For VCMDQ, we do need a multi-instance environment, because there
> > are multiple physical pairs of SMMU+VCMDQ, i.e. multiple VCMDQ MMIO
> > regions being attached/used by different devices. 
> 
> Yes. IMHO vCMDQ is the sane design here - invalidation performance is
> important, having a kernel-bypass way to do it is ideal. I understand
> AMD has a similar kernel-bypass queue approach for their stuff too. I
> think everyone will eventually need to do this, especially for CC
> applications. Having the hypervisor able to interfere with
> invalidation feels like an attack vector.
> 
> So we should focus on long term designs that allow kernel-bypass to
> work, and I don't see way to hide multi-instance and still truely
> support vCMDQ??

Well, I agree and hope people across the board decide to move
towards the multi-instance direction.

> > So, I have been exploring a different approach by creating an
> > internal multiplication inside VCMDQ...
> 
> How can that work?
> 
> You'd have to have the guest VM to know to replicate to different
> vCMDQ's? Which isn't the standard SMMU programming model anymore..

VCMDQ has multiple VINTFs (Virtual Interfaces) that's supposed
to be used by the host to expose to multiple VMs.

In a multi-SMMU environment, every single SMMU+VCMDQ instance
would have one VINTF only that contains one or more VCMDQs. In
this case, passthrough devices behind different physical SMMU
instances are straightforwardly attached to different vSMMUs.

However, if we can't have multiple vSMMU instances, the guest
VM (its HW) would enable multiple VINTFs corresponding to the
number of physical SMMU/VCMDQ instances, for devices to attach
accordingly. That means I need to figure out a way to pin the
devices onto those VINTFs, by somehow passing their physical
SMMU IDs. The latest progress that I made is to have a bit of
a hack in the Dsdt table by inserting a physical SMMU ID to
every single passthrough device node, though I still need to
confirm the legality of doing that...

Thanks
Nic
