Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCB56C51F4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjCVRL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjCVRLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:11:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224A8498BE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gptpI0/vYfYYtKJVq3CQYnu9Er+1HmoHW5uXxI5h7Sk9S4p1S57T2nMmFCkY0dDg2Xsfmq2nzUOPWzc//El48HCW7/U81wMRS1MN+msjh1f1bNoJ7Z+S4Lqt/wFA2L+JYIuJJHmtODLiM/kWwCZlxeF9G0qSJH3hZXLamG0tJzf/AN3phHZLFft5S5Wypqe4qoz9Ozwh9AdmSh6a9XszybjQ/J4oKJZUIXiJFNiKqzFGI0RpjqxtUwcb4ohtsxhB/YsYW3hNES/WBUFpQJoMHg+d4afnn/OYTc1JNuixISDPzu82ABkGKqgaILiSS81QNUn3RBmpEs85ddAN0eNOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sT/a5OrCMcxLS0gO5WlW1s5VO2I+fCA5n8elNuLfFM=;
 b=nfeYHVEMZ+agmmVbbxYtWfNVzMVxrNH4jIXLh3ucUZeeiDHuFBRyXEyfXaAQjDLD/My4U3MYmxnPivtzxMgMwR83sVE4Aq6ViF25GCEuLbl42e5wozBnHc3/kN5pt2b14xxjI/PxSSb5Il3TGCOIkvbV4UZgrFCApC/biNErKw+qdI3Lg5RTR2bv+29QlOprrcTxvM063gvGb6XVR9qMSgr31WeGrSsO45fPIUoj+DjAlUzLSu7SDRcarLIkrt7+Z/fTB4MzoCnIuN52aeTsZ1PaX2TG1K43hJDZfJaT3H8Y0Qo5lw9h6XldydHBfvjqVRms4CerNeKMR+yKdUZstw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sT/a5OrCMcxLS0gO5WlW1s5VO2I+fCA5n8elNuLfFM=;
 b=M5Q7imYz1bCwWoAC4xox1Ra382eOlftxJECuv6dScSmXhJkXPj+IZtKaxuP6wOjju7jFgY/cp+BCWT9I0Sz77WcwBO0o674hJznpMTX3OPYV6I4NzJCxEsBQabcN7e6H29MbbxsOFq9DYNBzhJ2rUokEaS+r17tbSMTTmZ2fad6oTdCRvK903vWGkcr03tzp/5Z26pwHNarZqEi4lx++mWbD1uekrNdtLszetYSuo8hb7tJgoULmWzxyt/E5YcuDHGRcB4ZFd3ZBpa/HnI3hmxZXEoAbRpI48avaFSzDYtDLpnsVZ9MPeVgpkxZ+54RxRg0Y4a2QneFI0ECkR3CJPw==
Received: from BN9PR03CA0990.namprd03.prod.outlook.com (2603:10b6:408:109::35)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 17:11:49 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::3d) by BN9PR03CA0990.outlook.office365.com
 (2603:10b6:408:109::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 17:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Wed, 22 Mar 2023 17:11:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 10:11:35 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 10:11:35 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 22 Mar 2023 10:11:34 -0700
Date:   Wed, 22 Mar 2023 10:11:33 -0700
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
Message-ID: <ZBs2xaa7Ow1pnB3C@Asurada-Nvidia>
References: <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com>
 <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com>
 <ZBqjUeEjjtCclgLN@Asurada-Nvidia>
 <ZBr3/1NzY5VvJrJQ@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBr3/1NzY5VvJrJQ@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b80ffc-3305-4215-273b-08db2af885e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uk9XFPPwT8qotH7jcv04J35ZYX2ARbFIW28jrUpiSyGYdFrn726MOV5uQSEVMgnTK+lEBz1ONxXHs//95Tx2hmQzq6do/5+aWQFyXox+b20/d7DBxN/SDaHc8XCQfEPYQR9e9fgPXgCxeo3AcXO06FYt6E1+uTRp1RZaX4cNUVCrfjmxT/IzeKvJAXvCH646ZMrfgsWcsCpMFI9EIBBKploohkdfFzTlL2A70/sOXYKkERgQOlQKWwG5e44ZUnXLqJkkDIaegecyyygIrUhAxs2CSF1x40jGikABNXLwIi/W/Wf5bVYca8vspYY1At1CAIOE05Gi3ClwlnMiDxVT/gPB76WpZiwvc5VQGUP7q4uaSHatvAP6pncGWm8zdeW1ObhUDcFOiAFmh+LA0vQcvFHnw0KxZf82meHgWhT3mXP9d5dzWdCQYdXs4Nny+b4e3+GLk6sdSeYYDlQBzq9CXUfecC6XfVUH29Vg3O+h8nlQLN4XdhGl/f8YbttVD8EajUTIWeGfCdgHcMyvaRtWYz5S5+BHdzNriCI9NwAK2s8HQB/f+MaJXTTUaHY8rtTM/cBhixc7CMBd1RvubdV0cXVeQtdXxtlZEalUfHuynvQSxxYwD9JjWQ6ZriBG7NRirrAEceNumvcNa7fpahiCZ4XneAPoH5JS8TQCnzwHwaK6y4HChRAupPtHz6f6L3dsJ9XLbWMaIelbYV5gkudjM6xvBMTjwFJ5Ubd1Ja7wbfwxw7Bf+j/vC2u6NbdUY7nR
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(336012)(9686003)(426003)(6636002)(478600001)(83380400001)(316002)(47076005)(70586007)(4326008)(54906003)(26005)(186003)(8676002)(7416002)(36860700001)(2906002)(8936002)(7636003)(82740400003)(6862004)(41300700001)(5660300002)(70206006)(356005)(40480700001)(33716001)(82310400005)(86362001)(55016003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 17:11:48.7866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b80ffc-3305-4215-273b-08db2af885e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 09:43:43AM -0300, Jason Gunthorpe wrote:
> On Tue, Mar 21, 2023 at 11:42:25PM -0700, Nicolin Chen wrote:
> > On Tue, Mar 21, 2023 at 08:48:31AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Mar 21, 2023 at 08:34:00AM +0000, Tian, Kevin wrote:
> > > 
> > > > > > Rephrasing that to put into a design: the IOCTL would pass a
> > > > > > user pointer to the queue, the size of the queue, then a head
> > > > > > pointer and a tail pointer? Then the kernel reads out all the
> > > > > > commands between the head and the tail and handles all those
> > > > > > invalidation commands only?
> > > > > 
> > > > > Yes, that is one possible design
> > > > 
> > > > If we cannot have the short path in the kernel then I'm not sure the
> > > > value of using native format and queue in the uAPI. Batching can
> > > > be enabled over any format.
> > > 
> > > SMMUv3 will have a hardware short path where the HW itself runs the
> > > VM's command queue and does this logic.
> > > 
> > > So I like the symmetry of the SW path being close to that.
> > 
> > A tricky thing here that I just realized:
> > 
> > With VCMDQ, the guest will have two CMDQs. One is the vSMMU's
> > CMDQ handling all non-TLBI commands like CMD_CFGI_STE via the
> > invalidation IOCTL, and the other hardware accelerated VCMDQ
> > handling all TLBI commands by the HW. In this setup, we will
> > need a VCMDQ kernel driver to dispatch commands into the two
> > different queues.
> 
> You mean a VM kernel driver? Yes that was always the point, the VM
> would use the extra CMDQ's only for invalidation

Yes, I was saying the guest kernel driver would dispatch the
commands.

> The main CMDQ would work as today through a trap.

Yes.

> > Yet, it feels a bit different with this SW path exposing the
> > entire SMMU CMDQ, since now theoretically non-TLBI and TLBI
> > commands can be interlaced in one batch, so the hypervisor
> > should go through the queue first to handle and delete all
> > non-TLBI commands, and then forward the CMDQ to the host to
> > run remaining TLBI commands, if there's any.
> 
> Yes, there are a few different ways to handle this and still preserve
> batching. It is part of the reason it would be hard to make the kernel
> natively parse the commandq

Yea. I think the way I described above might be the cleanest,
since the host kernel would only handle all the leftover TLBI
commands? I am open for other better idea, if there's any.

> On the other hand, we could add some more native kernel support for a
> SW emulated vCMDQ and that might be interesting for performance.

That's something I have thought about too. But it would feel
like changing the "hardware" of the VM, right? If the host
kernel enables nesting, then we'd have this extra queue for
TLBI commands. From the driver prospective, it would feels
like detecting an extra feature bit in the HW register, but
there's no such bit in the SMMU HW spec :)

Yet, would you please elaborate how it impacts performance?
I can only see the benefit of isolation, from having a SW
emulated VCMDQ exclusively for TLBI commands v.s. having a
single CMDQ interlacing different commands, because both of
them requires trapping and some sort of dispatching.

> One of the biggest reasons to use nesting is to get to vSVA and
> invalidation performance is very important in a vSVA environment. We
> should not ignore this in the design.
> 
> > > If the VMID is tied to the entire iommufd_ctx then it can flow
> > > independently.
> > 
> > One more thing about the VMID unification is that SMMU might
> > have limitation on the VMID range:
> > 	smmu->vmid_bits = reg & IDR0_VMID16 ? 16 : 8;
> > 	...
> > 	vmid = arm_smmu_bitmap_alloc(smmu->vmid_map, smmu->vmid_bits);
> > 
> > So, we'd likely need a CAP for that, to apply some limitation
> > with the iommufd_ctx too?
> 
> I'd imagine the driver would have to allocate its internal data
> against the iommufd_ctx
> 
> I'm not sure how best to organize that if it is the way to go.
> 
> Do we have a use case for more than one S2 iommu_domain on ARM?

In the previous VFIO solution from Eric, a nested iommu_domain
represented an S1+S2 two-stage setup. Since every CMD_CFGI_STE
could trigger an iommu_domain allocation of that, there could
be multiple S2 domains, when we have 2+ passthrough devices.
That's why I had quite a few patch for VMID unification in the
old VCMDQ series.

But now, we have only one S2 domain that works well with multi-
devices. So, I can't really think of a use case that needs two
S2 domains. Yet, I am not very sure.

Btw, just to confirm my understanding, a use case having two
or more iommu_domains means an S2 iommu_domain replacement,
right? I.e. a running S2 iommu_domain gets replaced on the fly
by a different S2 iommu_domain holding a different VMID, while
the IOAS still has the previous mappings? When would that
actually happen in the real world?

Thanks
Nic
