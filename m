Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBD8686007
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjBAG5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjBAG5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:57:32 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A5F46A0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 22:57:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRVbRZU7NatCkZIorRyTKxbmcwThW1QV99YVSz7AlUt5zss6frBRl/+BEaX9q7LmIzb+lIqIA7u4CudlMkRtU3h8+BnsA6UXf2nyb88DlKe4JIezJD+5lGxos1LxanpMtADhIE2J0vfts/VEDMpcm5TWCr08bnsf84zEiErzVkyfLk0eGf54P8r11OKoATdL/JwPpFAnF+Y01fOq7xzPI5QjzsjcgkJJEL0OYaB65a4y8SpHkJMtC/NSYLfVvguS5Uc0mtxNa91p3UoFByznFoDpb/alglSQx3KkWMT+w2xhcAOobGqwpuMrb5P+z/HnfwwsJhEX0uSWLImILt2DWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yvVarZTSBwAMpXjr83CotaXizJswu6U4UhR2KDzf2w=;
 b=DFnO4haP0Rq0mu2NPS+z9o0TZyhw0oVsg5DK0apqWvYdcYJXSRjI6rqu5qhvlHLEhogrbGASTwoHxRnNJa7kvI2MhI8Afgov5mrK7sKe4LXN4d1j08VEapIOQCH/+aIVfS5or3IW5ZYI8JozD1EkEHL13NCX48lMCaOO8dUHY00rTqzwXGyI5vyPpNn6T02BhDBH6LJtG5iRoePP203CaTn9m+jEj/1dIE2OIsn1zF7RLtLJJXYHofI8kPI4kjCZCO76HqkPXAsy/KdUd94ItHnI6tncv++4GJngDtLW3jzmLLGuBNGQEr15YDdjhTUXK5LuxMyKgaUjAmxjLZqFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yvVarZTSBwAMpXjr83CotaXizJswu6U4UhR2KDzf2w=;
 b=YPkKuHczFgMcfpqi/eupOoo64B65CurWc6UzSMH89BpfbDk+MdBlowLu78Wl6TzWYlBLtM7lZsnODKxtBEyVWPzFWHw9UtYVJKRKR3bhsdgE3MQGnQaC8QY4535Tzr0jTLSf20zmFD71pAo/8JVuB4jt/kOYd5o575j8JTKeeJ+zfj2sHvsojcrOtF/nln5uVhg2XwnWamgnypwHrH4uXhIZqNOk9hiEvz8zBdegelXer0dw9gYLfV7d6qmmQry5r2ZXB8Uw1Gv1H9LxQS1VAQR/F0N0JYdxJBHLp+mxH1Rg8HiAtC/OX8KnbLyTJLM74Ik97q6t/GR+7iwlREPERw==
Received: from BN9PR03CA0238.namprd03.prod.outlook.com (2603:10b6:408:f8::33)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 06:57:28 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::d) by BN9PR03CA0238.outlook.office365.com
 (2603:10b6:408:f8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24 via Frontend
 Transport; Wed, 1 Feb 2023 06:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.22 via Frontend Transport; Wed, 1 Feb 2023 06:57:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 22:57:15 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 22:57:15 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 31 Jan 2023 22:57:15 -0800
Date:   Tue, 31 Jan 2023 22:57:13 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9oNSUbDe1YOTj+b@Asurada-Nvidia>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <Y9fcAdFxl7GVSH9r@nvidia.com>
 <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
 <Y9gfbx/fszb0aTJn@nvidia.com>
 <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
 <Y9gqFwDNd3VKQvC3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9gqFwDNd3VKQvC3@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: bbacb330-56c8-42f2-f7c5-08db04219439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufkkJQ8B6Us9MKgNzskhE6QBmhLIRXI/w68+QL2cnLSnjhV0xS9RGbrusBD97Ug+pqg2WMj/asxdb2qXQAjukgWJTGkBHHGjmKZGeAanBP5gC8lzJZyQ+9bxnP9dC92NQiELljTFWXtXHt2GQ0flBHm/Mi/SzCRW8GZ/8bF8XQP925ODGXPHSrAyTHsuz9gS0tNQfuE28J8/NUOa97GjkBm50QQWRFQhIRJx7HNlltEW1MVqaVB/eqxqyioF81c4qr1WqEf18M3fM5BfO/+XR7yVLzSiCnCb6278QipC1md10sFUqZI4qBDNIoR0lcsups/UqP/ofTUKNWMd/k/TJAmdBoqvPdpqBooyXT4FwZZfiEInnNC91TdpiwTU/IMPeq0JEmcYymRBQrdBtYyHqJyu196mDW9F8CFgza2cE5DeJMdgKi/cVqn4GFuwFNeiNdEYVRoYzVjLyFwlrPiXMSYZrJZPFeAlS72Hve5IFcAUQrTlX7LN81LuQfqYbpf/WhrKHPGuTaDGNfD6sEr0BVUaZM3DrsIsrWfTrhiy739p1yYNctSPviotiUfpsO6ozYKvHwYFkYtUSiJWykdpoG5ESb3YFHZy9qEcDeFROpju9t9S+XAOK/4o9tR9st1ynuUARwlXsphTSpoetyzS0g2p8IKgf/MCB6G4hmbxPEyoAoMOVfMp0KFOQvwemjNqE9XC/PhTjPXGqU68Z13HR6Kunl89VfYJ8i+/sPSkdZM=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(33716001)(2906002)(6862004)(9686003)(47076005)(36860700001)(55016003)(40480700001)(5660300002)(8936002)(41300700001)(86362001)(26005)(186003)(336012)(426003)(356005)(70206006)(4326008)(40460700003)(7636003)(70586007)(478600001)(54906003)(8676002)(316002)(82740400003)(6636002)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 06:57:26.8441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbacb330-56c8-42f2-f7c5-08db04219439
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 04:35:35PM -0400, Jason Gunthorpe wrote:
 
> IMHO I would structure the smmu driver so that all the different
> iommu_domain formats have their own ops pointer. The special
> "undecided" format would have a special ops with only attach_dev and
> at first attach it would switch the ops to whatever format it
> selected.
> 
> I think this could get rid of a lot of the 'if undecided/S1/S2/CD'
> complexity all over the place. You know what type it is because you
> were called on a op that is only called on its type.

An auto/unmanaged domain allocation via iommu_domain_alloc() would
be S1, while an allocation via ops->domain_alloc_user can be S1 or
S2 with a given parameter/flag. So, actually the format is always
decided. The trouble we have with the iommu_domain_alloc() path is
that we don't pass the dev pointer down to ops->domain_alloc. So,
the SMMU driver can't know which SMMU device the device is behind,
resulting in being unable to finalizing the domain. Robin mentioned
that he has a patch "iommu: Pass device through ops->domain_alloc".
Perhaps that is required for us to entirely fix the add_domain()
problem?

Thanks
Nic
