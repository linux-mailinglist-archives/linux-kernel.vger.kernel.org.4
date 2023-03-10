Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B866B360D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 06:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjCJF1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 00:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCJF1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 00:27:17 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A519CF7EDF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 21:27:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nn2ac4NnTui6Ijx32O5q6fXbzwtC22ww0yrJvc1uE6Ggc3RYk+P4CfNwhmcq7yBrgXPwpuW+b1cMCZp9COSI/dyNS8JPj1IkZCHcj2G5cjFJGJCZ+/FrZMuoCXKeJ716rDMwFlystAeEw3yjalXcF0UcV3uPsqRHtKvAC1k8DY80Mpep+chCgFSVD/VY947XAopMfoVjMwU7miOCCoZ3+xZE7JuOD70pq2jWLnr4ETcrzumiNbJ4f+tHrAza1jcahyNvNm99RpizEBf9Pe6pkpzmusH5PvqVtQ9Oh7cBZP+Sgb9R/mEfERQZm5Sj9qtlDceL2LodxnUbamIrQ6bQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHMuk4gF7ryax6JunDfUKINV5iqtzLAE/KLQDV+U9hQ=;
 b=NyKmM6hmnefD5jFii46BLL8HaR3cZ/WYnXBR9mmmhw+HAcJV/8zbdq29/AEAre9kaOljoKRq5x8fXEiXkehhGZgr/3hSfJHwPFaN5WJWBFZnZDSn+1tyuUO5JwI39VgGo/QevA4tLDzHKkhIzSjkpOumyT/dYYSFDUGBPxUBMTkKUunHph0gRPjumtpVT1eYL0tU+lueudex2HAoldIbu9talkrOBFGx857nRwq67CVnSGYzGoBtixiCj1tkJ4VAME0rMqwbxwjt5re2BiWfypvHSuhIKnRsa2ZrPXivTrImvY/Ej+TNrbpuN5Pj406hTs86oOu7aWUh1+PCpd/1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHMuk4gF7ryax6JunDfUKINV5iqtzLAE/KLQDV+U9hQ=;
 b=FUNDmIkVMRnnRkZb9UvMwIe3SEJgVnJsj3QwT9SmR7QTLm1wIxfL47myEOm0akBU2q/+c3oQog9mOVrUUwD9QxRwnOS4sKYb6fpVHdCtPXp9ct9gNTooNBMqH7q1Pdk3ykL+3Am6Sg8uBNaWFO3I2PeSHvI1fsBZcSCDttHx5jMWVacI25ijt9AgaD3vYSHOIeJAyyyL5WxPBJ7fT1aPskp+pxOO7ZwH4cHWFPDhT52FZyuPps1wssoOznYXCY2fp6/CHDY/ZJxtyDlAU/ydm5b+kdZbBmZZq2+mkfpp69Obq1Fo2SlVXdeNMwq0qaEaTMxSWjMbijGKJFMBqC4tiQ==
Received: from MW3PR06CA0013.namprd06.prod.outlook.com (2603:10b6:303:2a::18)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Fri, 10 Mar
 2023 05:27:13 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::5) by MW3PR06CA0013.outlook.office365.com
 (2603:10b6:303:2a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Fri, 10 Mar 2023 05:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19 via Frontend Transport; Fri, 10 Mar 2023 05:27:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 21:26:57 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 9 Mar 2023
 21:26:57 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 9 Mar 2023 21:26:56 -0800
Date:   Thu, 9 Mar 2023 21:26:55 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <ZAq/n4PNeow6wftN@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <213a05ef06944a55a148995053b187f8@huawei.com>
 <ZAn94BXkjiJKQ66O@nvidia.com>
 <39979642ba8042ba9d4de651fecfeffb@huawei.com>
 <ZAoCf9+kpMof6R+4@nvidia.com>
 <4c1f57adbe0c4d48849d585508595939@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4c1f57adbe0c4d48849d585508595939@huawei.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|MN0PR12MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: b3eae554-9d5e-49ec-1710-08db212819a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7bdhJaoc0hov9JKQBw2H2Azc+d1c7PpWs4n/yoBcG1PQKrebjJiMJbXJWIJwhF9dp7hZRcPuZDFthpnhCPYduCh/9gHeb9YKc7lPbEXuYLTBV7Xs4oM1erXyWuK0cEMbNHSOqdjlDGdkQhDIqb5uqiAMJbLWk42MXwxbs8qjCk7ztR1zfBRebfbzS+kK45pnzNgPVOiLPhmsXqzE1SoWzmCMoWqiBVvSPq6eWY0JkEy2u5X30RwRzOUAfS6CdmI3WfWmUsJKQe/VNrjZdWY5Wg4DQdvpT4Ts7lJPVWIWdUPR41buccs5mDiUCl7cpHnvLRBApNDHv6EIFKaFHlPbYj7BFUkURLd62l7S17WZp63Geq7/pdBO0s4IUXQzpwCqTBQQ3tpeJdmKyXP0or7CG4AX72Aq8onsz6hvfDsEzGsrTleKKOa21x7LjC5bQgWWRgf8PKf575Dw8CUgL2ydtfeXdqZEtZ4psiHNmIBv8mb5wah1TfUDndD6FbLcRtNiQhzGORgtX6daeD2eK5ab1nR96rNBlE8hoZfbIUIX1PvuiPWl+WOcaDPXWfFHES3eSU/1kZpyd50S4vYjT4qT8OYny0mWpxEbD5Bb00uwjYY4Xq5hBY4fIdwiHsmPMvfazqPviagOkYr3m8JGP6gKY+GnpidypcrHCMVkP9P1D/fOPUUFiehJ11IdPTcm3vcOpJmbkJRQmpqVzaA4wytn0iM9z3Ab3gq77FKfn4c+sW3K10uhz386Mb5xFUstSOm
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(336012)(7636003)(47076005)(2906002)(426003)(356005)(40460700003)(82740400003)(8676002)(70586007)(70206006)(36860700001)(4326008)(26005)(8936002)(55016003)(478600001)(6916009)(40480700001)(9686003)(86362001)(83380400001)(7416002)(53546011)(5660300002)(186003)(33716001)(41300700001)(54906003)(316002)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 05:27:11.3890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3eae554-9d5e-49ec-1710-08db212819a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 04:07:54PM +0000, Shameerali Kolothum Thodi wrote:
> External email: Use caution opening links or attachments
> 
> 
> > -----Original Message-----
> > From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> > Sent: 09 March 2023 16:00
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>; Nicolin Chen
> > <nicolinc@nvidia.com>; robin.murphy@arm.com; will@kernel.org;
> > eric.auger@redhat.com; kevin.tian@intel.com; baolu.lu@linux.intel.com;
> > joro@8bytes.org; linux-arm-kernel@lists.infradead.org;
> > iommu@lists.linux.dev; linux-kernel@vger.kernel.org; yi.l.liu@intel.com
> > Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
> > for ARM SMMUv3
> >
> > On Thu, Mar 09, 2023 at 03:51:42PM +0000, Shameerali Kolothum Thodi
> > wrote:
> >
> > > > For ARM cases where there is no shared VMID space with KVM, the ARM
> > > > VMID should be somehow assigned to the iommfd_ctx itself and the alloc
> > > > domain op should receive it from there.
> > >
> > > Is there any use of VMID outside SMMUv3? I was thinking if nested domain
> > alloc
> > > doesn't provide the KVM instance, then SMMUv3 can use its internal VMID.
> >
> > When we talk about exposing an SMMUv3 IOMMU CMDQ directly to
> > userspace then
> > VMID is the security token that protects it.
> >
> > So in that environment every domain under the same iommufd should
> > share the same VMID so that the CMDQ's also share the same VMID.
> >
> > I expect this to be a common sort of requirement as we will see
> > userspace command queues in the other HW as well.
> >
> > So, I suppose the answer for now is that ARM SMMUv3 should just
> > allocate one VMID per iommu_domain and there should be no VMID in the
> > uapi at all.
> >
> > Moving all iommu_domains to share the same VMID is a future patch.
> >
> > Though.. I have no idea how vVMID is handled in the SMMUv3
> > architecture. I suppose the guest IOMMU HW caps are set in a way that
> > it knows it does not have VMID?
> 
> I think, Guest only sets up the SMMUv3 S1 stage and it doesn't use VMID.

Yea, a vmid is only allocated in an S2 domain allocation. So,
a guest allocating only S1 domains always sets VMID=0. Yet, I
think that the hypervisor or some where in host kernel should
replace the VMID=0 with a unified VMID.

Thanks
Nic
