Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0376C1C29
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjCTQlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCTQkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:40:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9272597D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmgvE7QKUQ4edTinCwS0oPGvPAm4/LEFa9F0RjNWvJXS1Oej1KbM6MLqjCsmgBnrWkePdTHoUQ4a50QmY7HtYhqGh6Mn3LQX1Pzz3nIO97sUPi44U6/TSxlesSLkQyVYydz2bKWB0jFvsMXR6opBGK3725EfdK4Ho4T8YHGxQcn9tFLTDc/GcSxfVmITDHm997OwaHd3Ma868zXCI2kMdl3SYJX3L1sDsTxF72vQOLjWmTBFXczLkaVjAIsxzhuD9E7osvCXmeKWSy1Wo7qXPblKKnYenPRF3qLWERM2+vWMJkyvi3MBN0F012OrOxNfELUNrgKHYikSWxsMDxIHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXhevIw6A9pBrv4OnhpJpZ57QdmkqYIYIM6TCQn6tA4=;
 b=DEZ5x923ViyKp0K0IWWw4Kkyq1qHJ9ZYVzCs3dr3i2ZRPDfyJqkpHyIeMGsZAAFcaQo/CMtE4paschP7o/dW4gjXM8FAAFZ5wviiFSu9v49Pp6KhQmQmT40nD8EOxj/F57MY2u/oA0i0ttUO7BabXM+HtYSp3+IBe6iqaEcuujR/dq58K2BHJ0+M7Kot9IRQf9GqnkWeiigR/Dh2K+Qp35gx88tjos5FtIxYt2FKjhR4p7ysKPy+6uHANkP1kqkCJygUDgdrBRwbqPH7mBk2yY2RI8Z6kOD1cXO5dMDjhfiqiadip4aC7GG4/1WGuLQCVa8KXd7BgS+zmxutQF534g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXhevIw6A9pBrv4OnhpJpZ57QdmkqYIYIM6TCQn6tA4=;
 b=an5s6zCLO06yVAtzMafEwhYT/UPbcNXKyriVziZyktJxCGMpSDMibQw57T5Rus6p0c5/BwIWXkjUFYOCh0x6PGstGA5S1w/aS1vuPfzFUJvxZZnfiHJyxNgR2nvYbunYhksM/V7u0f18pwGQrmfGrSRJKYhQPN481oRqUcZLJsauesQ25sTdDOoAKTWfVbJrrhvMgT6z3obD9Qc7FnGAUfxdEU8jDaYgTk82cRFbPq/WhF63ErhRnlXetCmFK2UNFWcpRaIC+VW0D21LdmTxGRZ30Jp+kKNdQa4frrSIo7SJe4VKa4l9J29vsf8gJL4ouqaaLHLlC1EKdGtz3iPpig==
Received: from BN9PR03CA0750.namprd03.prod.outlook.com (2603:10b6:408:110::35)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:35:35 +0000
Received: from BL02EPF000108E9.namprd05.prod.outlook.com
 (2603:10b6:408:110:cafe::7e) by BN9PR03CA0750.outlook.office365.com
 (2603:10b6:408:110::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 16:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000108E9.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 20 Mar 2023 16:35:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 09:35:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 20 Mar 2023 09:35:22 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Mon, 20 Mar 2023 09:35:21 -0700
Date:   Mon, 20 Mar 2023 09:35:20 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>,
        <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBiLSJvtY5UKDJ5l@Asurada-Nvidia>
References: <92fdb06f-e5b1-8534-fb0e-ad47b5be9e1d@arm.com>
 <ZAx2K08L5TIm6r3y@Asurada-Nvidia>
 <ab762cc6-5adf-2515-d9d2-d21d916eb6ad@arm.com>
 <ZBJcS07G3mt7gjkA@Asurada-Nvidia>
 <c753c2a8-024d-5bef-8987-96582084991e@arm.com>
 <ZBOFcenanpRsGFzF@Asurada-Nvidia>
 <ZBe3kxRXf+VbKy+m@Asurada-Nvidia>
 <ZBhbmqprnux4q00i@nvidia.com>
 <ZBh7hSX5hdW4vxwh@Asurada-Nvidia>
 <ZBiDcYwxL7eV1EmQ@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBiDcYwxL7eV1EmQ@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E9:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: d508a18b-0a75-4d77-0430-08db29612113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qtg/idDYi3bdtlhDSjhFJYvygePWpPaumi2McvPaJeoroYLR+w6JV9vMWc9cUmCRVPe6Wc1DoKV9mvCD0hKqy25W4hkbC+RMyNLWXCsRTQFmb0BCki0M9kNslygVvuNZ5khEsYXvFdBhkE6j1DcjULBgsJviBkxFqhwIFsIx6ooHpBnuznAM2HEDRtHjVE4j1/se15KvKNwzyORcSJOmfubD5HECrvgWIX/kDeZR2FN6iXu6AHELZX8exO/rLIjJ5aM3eL94siYzF8XxB02chu5OVVR5ab8/Zp91sYX3r8Q2Nnn3sUwxKloYaLoTfxJufo7Fq1Vg/kH6dMHw+z7DCF8tGxyg3E1EvMRkiWMTZoDx9o0JwNYAc87b0P6l+1puqVi0GRlc91nAFauUsfmOUBGMmjRla0Zm+wPp1DHHsB6Ja2sWTODJgFFjqoUwwjOUDwxkrUMmAEJHfySrEzHh6n1KNj7XBG2wE1DGZMmf6qKvVT8+46V3BcUuzcOGVo12Of8lfRs19xl4EJpFiFEcQYtpMaRJZ9EnMQYiq0SqP26JmhOBgPJpWlZpZMIU7sDh3PPH+qnsZ32eu1fYs2EY8xOZuQrLcdM/41sFDh3ui2Rq3VB2TlJnMMjYi24PX74hr7tSVzPmRlhGHqtDJ+ykXmzKSUTRvSoA5TgbN/Tfxj0c/sUK8KQK8lx3x+DnKw2uIUEcAx1LMmvGNCY7Qjn+cTcUiQqumMXq3uIc6Cu4FCp5bp5dU6hqXiiP4XM3cYf/tHcuM9Cr54c6xDkMmCjEpoxQlfdkXo4V8c7v1/ROmCU=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(83380400001)(2906002)(316002)(54906003)(6636002)(7636003)(55016003)(478600001)(70586007)(70206006)(4326008)(8676002)(5660300002)(356005)(7416002)(41300700001)(86362001)(8936002)(40460700003)(6862004)(33716001)(40480700001)(82310400005)(82740400003)(36860700001)(336012)(186003)(9686003)(426003)(47076005)(26005)(341764005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 16:35:34.4643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d508a18b-0a75-4d77-0430-08db29612113
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 01:01:53PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 20, 2023 at 08:28:05AM -0700, Nicolin Chen wrote:
> > On Mon, Mar 20, 2023 at 10:11:54AM -0300, Jason Gunthorpe wrote:
> > > On Sun, Mar 19, 2023 at 06:32:03PM -0700, Nicolin Chen wrote:
> > > 
> > > > +struct iommu_hwpt_invalidate_arm_smmuv3 {
> > > > +       struct iommu_iova_range range;
> > > 
> > > what is this?
> > 
> > Not used. A copy-n-paste mistake :(
> > 
> > > 
> > > > +       __u64 cmd[2];
> > > > +};
> > > 
> > > You still have to do something with the SID. We can't just allow any
> > > un-validated SID value - the driver has to check the incoming SID
> > > against allowed SIDs for this iommufd_ctx
> > 
> > Hmm, that's something "missing" even in the current design.
> > 
> > Yet, most of the TLBI commands don't hold an SID field. So,
> > the hypervisor only trapping a queue write-pointer movement
> > cannot get the exact vSID for a TLBI command. What our QEMU
> > code currently does is simply broadcasting all the devices
> > on the list of attaching devices to the vSMMU, which means
> > that such an enforcement in the kernel would basically just
> > allow any vSID (device) that's attached to the domain?
> 
> SID is only used for managing the ATC as far as I know. It is because
> the ASID doesn't convey enough information to determine what PCI RID
> to generate an ATC invalidation for.

Yes. And a CD invalidation too, though the kernel eventually
would do a broadcast to all devices that are using the same
CD.

> We shouldn't be broadcasting for efficiency, at least it should not be
> baked into the API.
> 
> You need to know what devices the vSID is targetting ang issues
> invalidations only for those devices.

I agree with that, yet cannot think of a solution to achieve
that out of vSID. QEMU code by means of emulating a physical
SMMU only reads the commands from the queue, without knowing
which device (vSID) actually sent these commands.

I probably can do something to the solution that is doing an
entire broadcasting, with the ASID fields from the commands,
yet it'd only improve the situation by having an ASID-based
broadcasting...

Thanks
Nic
