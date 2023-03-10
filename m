Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F6B6B3606
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 06:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCJFTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 00:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCJFTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 00:19:03 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF98F2C24
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 21:18:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkUuyy6RJ/tk419JX5dI/SYDRvlE5dNPJe3YJJGgeCnNbSM68qkowyTVsDiIzwIqlk41dmUU75SkRnCDph8CIafu9Aj3+MoM/1Ei3PfPG975hqCwIK08WsGCS/3tHmNfAKq8nYnUExggNcY8Eduo1XfGA6rIY+sHhJ3Y/3XpELJa1nd4l7ZWJ1cygaCu6+n9+WmSult70hgBvIqg2mYTN4HPfSjyQ8kTIn9lBqGh0JVUgXxKqbhpPfE/2BviHUG7aB+v9asZGGpXff2NerLqWPO5BW85BCrmfZzhafKDap6UbfgjLJINcmtZCgWHIs7XxsD7R7tKc3mQLyDRHypwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hTqBCz+IXJB2fLWDGFl4NWtcu03EV5NKB6o0rNvkxA=;
 b=J4WnK/uYIiOdVP0Uynr/lgXwu1/LlEZueII9CAbN3/lD+48rRsOYRvJiexdlUKT7Ki/e3/c1Cv2F0x0uZiVKpTVRKTFzkoZzKgZPgDApT+TJrT2Ih4NZ/N0bs9G7LDycoIvBK/NpblinbmSj+7N9FwD3yohT1VwAWqI06FV8fYYWkOdJibH/+9Gy7KVezCRvvxMVclwapXoGzYtufg17DCA2GBtUlg9+WoVprVX2/13XaAnbJ/+lAwPjW0SoFX2gITafJgKvtBITfdlDursDIONlg3mfNJKOzugyo3sdCitlGRg3diJMg0zJH9j71qarijPkEt5I8mBNDc9eE+Nk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hTqBCz+IXJB2fLWDGFl4NWtcu03EV5NKB6o0rNvkxA=;
 b=cSeDTKJtZEtMxRP7/YW2LCM5NX9rRvLGc6fLA7UGf7w30GsiI6FHkj0fGDlTqfA/xnUk5HxYwN6RxhhBm01LMezTVYechycZmmBhgHtRgCpwk+Q15pegHiAuw3dAfgL9IH/lX4+ljq4G8kQcOLbS6FDL4YHnrhimpgFhzlN5jKZubJD+WbuBMZivoZ1HD6RYcUqLFGccuEHNjChtDll/WdAB+nicpEp0uhfCl4GlJA3whBLcgXkxbjO6as0Y2dnrFRsozmHgMdIqACTL8KqdFWGBknt5gAV1SiIBw75yL37otz+6HhjUOjHkdb/XrhrkYo6eu0s7EsBUwIO6oZ/0PA==
Received: from DM6PR12CA0018.namprd12.prod.outlook.com (2603:10b6:5:1c0::31)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 05:18:57 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::1e) by DM6PR12CA0018.outlook.office365.com
 (2603:10b6:5:1c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 05:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 05:18:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 21:18:55 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 9 Mar 2023 21:18:54 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 9 Mar 2023 21:18:54 -0800
Date:   Thu, 9 Mar 2023 21:18:53 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
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
Message-ID: <ZAq9veG5c48V6lIu@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <213a05ef06944a55a148995053b187f8@huawei.com>
 <ZAn94BXkjiJKQ66O@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZAn94BXkjiJKQ66O@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|PH8PR12MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df17e05-b8ca-42f7-359b-08db2126f2bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4a8uV1JQpjy6wUYD6y+qk4dyTxZqzp0ruI2UbCE3fu1GeP5+msz0LVIYGe4xAbmzbCzLlnHTvHYW4RIGnGTHSpgr4rUvpc7mDgzoHRn86iUpeic5PqIxxaNz6KMgFBtqeckYUHvmOYr9E/VctOqNqV7TPU85W8aG2qoZmAxsBcEg0bk9Xz3TjCTtzuBP2oijQKVUB+Irg1KFK92q/GG7RWJD7QSOTzdv1f6dN5idwzttqz7T5yMP4ig/0snDQosSCwO+Yg1tw3iwBaT+sHhL1QWbLvv6YFO/7cG7A0UJIn2broC/u/XG7LfYvZRnsotfc/EtZx4QBz8UH0fHp99nsZ3mFxRl1DD9iMMjty8Yz0O9WE4bcPQadFtkg57EOvn0yzweHyImVLZxULHcMfXVbIwxOyBfMau5kCflV9vFjp6iQwVTOXVYemOfzemkYqarZLx544hJRHnzbBrbNaYDL7RZZ64OQ8wsdiyais1VUSG6tdIql1lzot8H4RE6R1qRvmY9K4X6rvdBBUJokcVEfqr54jbvO/LUS7BchoBXpcsmkMYAvjcdtMLvvigbVySo6Wru/Li9y7PsaAoS3mnhw2O4iI8xoOIwZftbo/+R1IRyjgzX3IqZA82Bx0z23F+KQtDKVYcI6sR3Ql5RCVv3a3cq5u9XAZueMpPIxibd5cPddkniinS6UkYlgNnKyZdYzaoYd6vybJ6k+fwrnxZy5m2j0NNVQ8NgLZTK84o9paTmqcKQaxuweirY5Gffeu7c
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(70206006)(6862004)(8936002)(356005)(26005)(7416002)(5660300002)(8676002)(47076005)(82740400003)(36860700001)(9686003)(41300700001)(7636003)(82310400005)(336012)(426003)(70586007)(33716001)(186003)(55016003)(86362001)(6636002)(316002)(54906003)(40480700001)(4326008)(40460700003)(478600001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 05:18:56.6480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df17e05-b8ca-42f7-359b-08db2126f2bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 11:40:16AM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 09, 2023 at 03:26:12PM +0000, Shameerali Kolothum Thodi wrote:
> 
> > On platforms that supports BTM [1], we may need the VMID allocated by KVM.
> > But again getting that from user pace doesn't look safe. I have attempted to revise
> > the earlier RFC to pin and use the KVM VMID from SMMUv3 here[2].
> 
> Gurk
> 
> > " In the new design we can require from the start that creating a nesting IOMMU
> > container through /dev/iommu *must* come with a KVM context, that way
> > we're sure to reuse the existing VMID. "
> 
> I've been dreading this but yes I execpt we will eventually need to
> connect kvm and iommufd together. The iommu driver can receive a kvm
> pointer as part of the alloc domain operation to do any setups like
> this.
> 
> If there is no KVM it should either fail to setup the domain or setup
> a domain disconnected from KVM.
> 
> If IOMMU HW and KVM HW are using the same ID number space then
> arguably the two kernel drivers need to use a shared ID allocator in
> the arch, regardless of what iommufd/etc does. Using KVM should not be
> mandatory for iommufd.
> 
> For ARM cases where there is no shared VMID space with KVM, the ARM
> VMID should be somehow assigned to the iommfd_ctx itself and the alloc
> domain op should receive it from there.
> 
> Nicolin, that seems to be missing in this series? I'm not entirely
> sure how to elegantly code it :\

Yea, it's missing. The VMID thing is supposed to be a sneak peek
of my next VCMDQ solution. Now it seems that BTM needs this too.

Remember that my previous VCMDQ series had a big complication to
share VMID across the passthrough devices in the same VM? During
that patch review, we concluded that IOMMUFD would simply align
VMIDs using a unified ctx ID or so, IIRC.

Thanks
Nic
