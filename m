Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631676B3621
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 06:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCJFgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 00:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCJFgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 00:36:41 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAF5F34D6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 21:36:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdOGJSfkeFwzCG75AahD7VxzMeNqY4Tqn0SgeC6yZpHIXAyCqqXtsgcs/I6cFnr4hBft/gBYMKFiBjL/8B/W17i92902xhsSWemYi9xCEBeVyVg14PPtM97V9p1s5ZhXgFZCYDu4UhlPyG5oY3kvZZ5HlN0wen9iVfP63y+3kUXwHCTjwbBvUmgmm3QFXvoeD6XvJ65Xd5UtGHOFXjan2ZDuxG39X+PbT/aNN82SoAnlaLSV7pRLcXEXFqx9by2wV9K2BRFtfE2Dvf+HxjeRmWotJA+aOUq3jHcO3Ig6Equ0vKs1oDJo0Zkpnks+ZUAXYM9i5MKcsQE/N2F6uZdTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi7fBG/MtgpBvfuLwyZ1KulaW7gbnAUgcf75uXv6E/M=;
 b=b+GG6CrPCrt1j5VGLnWjFOK/uvmZpQkaCDvIHsU89llNwlrPdNrYYbkIFgwo1Vlax+6iPWuYPbzPjlL6+foFqBGH0HrYPvx/nTVJ2dkwbf+3GRYAVV9mSBWpuEqBjRj9yZFXE9/gqT5KQNJl19rlz3lj7QPEakBiHjPNryG5k4F+8HJBDqhrGjp/BKJCOw5Lo23siU2/pjaPYNhNxE1In40cEQuDMZNkyqZUlxlM5xoVW2HHWO6eSlwx3pMMFCCdkvAykkKgJpKvh7ARn7pN1jZE0FaTUQS+Rz0FHIg2lTuvxa4pXjkDyFqJ8bwkZr8jkUyqU8optfSP8dNL7Gilqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi7fBG/MtgpBvfuLwyZ1KulaW7gbnAUgcf75uXv6E/M=;
 b=YV3Av4Sdqq9KhgkaqMCkJpdRkha9jBKUrY/WAorE+llWCp02KVpdqq9hTQw5OlxLnoZtvrtIYAK2H/E6W47gMiuKtgPdUy9L9KIxjGGBunEY/3uaAchJscFgT+3XjV6+pQgQnYMGQNtts3ibSpslYLmfohVTdK1rpQYlVtXsVhxPqdLqSInmaNUqgqLXUKyuB6JCbXbvUEyKqLsLIeiqRXoa5NklOHQc4Zq0lDh/YC+hrjEUZvYh/tQm7OtDl9qZ4EsOXLFECLd9wxvNNglDDznDGL40V58voBgTtqVY+k7RSYOMFDduHE5D403Ht9ZZ1ZOoffiB6XOsWwiKykvN2Q==
Received: from BN9PR03CA0369.namprd03.prod.outlook.com (2603:10b6:408:f7::14)
 by BL0PR12MB5009.namprd12.prod.outlook.com (2603:10b6:208:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 05:36:37 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::2e) by BN9PR03CA0369.outlook.office365.com
 (2603:10b6:408:f7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 05:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 05:36:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 21:36:21 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 9 Mar 2023
 21:36:21 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 9 Mar 2023 21:36:20 -0800
Date:   Thu, 9 Mar 2023 21:36:18 -0800
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
Message-ID: <ZArB0n0J3GW75WNz@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <213a05ef06944a55a148995053b187f8@huawei.com>
 <ZAn94BXkjiJKQ66O@nvidia.com>
 <39979642ba8042ba9d4de651fecfeffb@huawei.com>
 <ZAoCf9+kpMof6R+4@nvidia.com>
 <4c1f57adbe0c4d48849d585508595939@huawei.com>
 <ZAq/n4PNeow6wftN@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZAq/n4PNeow6wftN@Asurada-Nvidia>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|BL0PR12MB5009:EE_
X-MS-Office365-Filtering-Correlation-Id: a56c21cb-0a74-42e1-d7ab-08db21296add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrUB+zYoIvYQDnGNoP2YfEXzlmoeD9u4psy0t6HShyWLseFjFTXKDAfNgLv5T9uWst8jQGDJhNt+cY8rnEi2dnxRnwn3waA05y3SWj/F9A9RDeDVw0JRS+FgIJizrLRtv5R3dKm6TaWeXXXj334f6tTFu7rsSRwc/KDJpLlI9iKmY7WUSdvmavGdmP/cDyhB7ez9+SOVxwWEU3QzJr6M3rGXRCqIFq+WdS7Tz6TSoW/1liKK3ehh0IyH54jczxj9rKDfap3Ub2fPxEwPRAwNH2irtnSKrPHYd6iO0UfKYqZ4GcilTpJLMlZq3fQh5taAqdF5l115oZgfyTXUBknO+mkJNXvVSzcIft/8qJ3c0cYLdl4UQ0ws/TflU+bF6A7dB1c+FtWHGie4NGkDtXh+gfYS4l1C7Xkfs9hjM+56+KL5TvDopLEZYj5/CWnYvX1YNqkdmVl0FuvLLeLArliKZ96lv0C0hGTgwI4IR3opVlCTdsbpMtluF4a8IQEE7Pxc6/jDDmTiqV1tEJkR2jUuPnXAUhPtm1CINNRvZU1mGDCEzMWAMuqR1cv3pUclA27j/itXsRoIFURPXP8z6JV2+sC+q2qtbWn4ZxoehyNqbgixTHIe5LFm9WO7x4OKw536moAR2tAJrFvpCBR8f+bHWsQrmBDjqOPJLxOuN6SO1E+vt44b47oHAAf+A3Ux18e+qzjdtK3SyvTNxQ0dc4ftc723LThAq6W7KaYpx5oYPrA=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199018)(36840700001)(46966006)(70586007)(70206006)(8676002)(4326008)(6916009)(54906003)(316002)(2906002)(5660300002)(7416002)(53546011)(26005)(41300700001)(9686003)(186003)(47076005)(426003)(336012)(8936002)(478600001)(356005)(82310400005)(86362001)(40480700001)(55016003)(36860700001)(83380400001)(82740400003)(33716001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 05:36:37.1325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a56c21cb-0a74-42e1-d7ab-08db21296add
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 09:26:57PM -0800, Nicolin Chen wrote:
> On Thu, Mar 09, 2023 at 04:07:54PM +0000, Shameerali Kolothum Thodi wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > > -----Original Message-----
> > > From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> > > Sent: 09 March 2023 16:00
> > > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>; Nicolin Chen
> > > <nicolinc@nvidia.com>; robin.murphy@arm.com; will@kernel.org;
> > > eric.auger@redhat.com; kevin.tian@intel.com; baolu.lu@linux.intel.com;
> > > joro@8bytes.org; linux-arm-kernel@lists.infradead.org;
> > > iommu@lists.linux.dev; linux-kernel@vger.kernel.org; yi.l.liu@intel.com
> > > Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
> > > for ARM SMMUv3
> > >
> > > On Thu, Mar 09, 2023 at 03:51:42PM +0000, Shameerali Kolothum Thodi
> > > wrote:
> > >
> > > > > For ARM cases where there is no shared VMID space with KVM, the ARM
> > > > > VMID should be somehow assigned to the iommfd_ctx itself and the alloc
> > > > > domain op should receive it from there.
> > > >
> > > > Is there any use of VMID outside SMMUv3? I was thinking if nested domain
> > > alloc
> > > > doesn't provide the KVM instance, then SMMUv3 can use its internal VMID.
> > >
> > > When we talk about exposing an SMMUv3 IOMMU CMDQ directly to
> > > userspace then
> > > VMID is the security token that protects it.
> > >
> > > So in that environment every domain under the same iommufd should
> > > share the same VMID so that the CMDQ's also share the same VMID.
> > >
> > > I expect this to be a common sort of requirement as we will see
> > > userspace command queues in the other HW as well.
> > >
> > > So, I suppose the answer for now is that ARM SMMUv3 should just
> > > allocate one VMID per iommu_domain and there should be no VMID in the
> > > uapi at all.
> > >
> > > Moving all iommu_domains to share the same VMID is a future patch.
> > >
> > > Though.. I have no idea how vVMID is handled in the SMMUv3
> > > architecture. I suppose the guest IOMMU HW caps are set in a way that
> > > it knows it does not have VMID?
> > 
> > I think, Guest only sets up the SMMUv3 S1 stage and it doesn't use VMID.
> 
> Yea, a vmid is only allocated in an S2 domain allocation. So,
> a guest allocating only S1 domains always sets VMID=0. Yet, I
> think that the hypervisor or some where in host kernel should
> replace the VMID=0 with a unified VMID.

Ah, I just recall a conversation with Jason that a VM should only
have one S2 domain. In that case, the VMID is already unified?

Thanks
Nic
