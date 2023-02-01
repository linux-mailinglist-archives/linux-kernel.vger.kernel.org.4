Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8444D68610B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjBAH4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjBAH4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:56:19 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA49183EF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:56:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDfByL6iAab/rOCdtmjwu/7bGPJSBoR0PmcqaFyMJfJIKPrQE3d0dcBmqFW9eS1Ibi+D+Bfxcgcv1q+zBvHhJPwfy1QWiUzrGxSRlO9QI/66gB5eeMsc+TY8w5kGM/kn6LMpv83ISV0WfXsBvViituF0RanlHallqzcVxwWBVKlVlQnLoc0LAsv5nzxN6tbcgieV07oLrBpv4lZSBbB8N1JNEGv20qQtmtgPLaOeERLQLYBI8Aad/92Y0exb1ILdJv7V2CgFvx24g9rnArZJLxqIqEMdAaEe8gJ/Xu7v81GtWcKPk1ExUvLTV+9IJTS1QtYWHKxavWC2Z80e/AjFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGu/IJsL8GTl4kXctjMaByKl4keLj+Tnrg5HnnsBuo0=;
 b=I3cukDTC0a3GNkvJJLH2dU2N/pLpjhrF30R5LCTerumSR2Exnb7eLf3E+wef9G+f95gF3rRWhsU2xnuwwaJuje6AoRWFUySKoy58f8e1ZRN7ya4GbS+Y5fzTj4rCDqporuaUK508V1MiFVW4C9NWF91XbCZ4C3upYJjVcr6ozixOB0mFwhVT5/YvcF2UYPNEQS/LrVE3VgKqvpeIQ+TKl7TRoS+dBadjBsnds+74V/cBivpahLpTOxGjeI0lKeyX1IelKE3PnAjXEan9/axTEV1jg7eyRg/f9wvf4j7apeJEomL7uHQv4MtOYSlPNpvrrziVqvM/Thkm/SWHSRMveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGu/IJsL8GTl4kXctjMaByKl4keLj+Tnrg5HnnsBuo0=;
 b=HaJQ/4ILgQNnFHfaUFX81J6oLN55nPhAV4YG06Ayo0QNhehznMZYPfz9zX8vjfV9UPgYlGvsBnhfncn8iCreXsx9Jc5hr//KeIh1gHxMBz+9Jr5FHMWRbvUsqiz0ccEVKEq89DWJKHaeHyLXLjZiA+F6uokAXkK4zVg7Na6kUGgbhU6z4lPX2eUWCUVhq28MIpjmu6GBEIjbBliggYxVHldsXJjz+I/jZsbNrHqT16/5HrpOZT7JRw6iDVS59JKZRyK870bvmBszdV+fpAk44vN9Euits0iKptCkMjkp1+9KKUrdRpwmSnCvVK991oQUSerGcFeoePUo/4GcKiKtfA==
Received: from MW2PR16CA0049.namprd16.prod.outlook.com (2603:10b6:907:1::26)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 07:56:15 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::ad) by MW2PR16CA0049.outlook.office365.com
 (2603:10b6:907:1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.23 via Frontend
 Transport; Wed, 1 Feb 2023 07:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.25 via Frontend Transport; Wed, 1 Feb 2023 07:56:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 23:56:05 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 23:56:05 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 31 Jan 2023 23:56:04 -0800
Date:   Tue, 31 Jan 2023 23:56:03 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9obE5HpTkqlpXO5@Asurada-Nvidia>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <Y9fcAdFxl7GVSH9r@nvidia.com>
 <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
 <Y9gfbx/fszb0aTJn@nvidia.com>
 <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
 <Y9gqFwDNd3VKQvC3@nvidia.com>
 <Y9oNSUbDe1YOTj+b@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9oNSUbDe1YOTj+b@Asurada-Nvidia>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT013:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e70a1a-4e35-4513-2b9c-08db0429cb59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1yalXd2ZJGNQY0dMmwIlB3d56bfar6TpBqo7GNHKuRkyB1ftHuwXmWObya1dFUKj+KSKSoUKln/LNUWqxXWxl5UYj9OLYta10EFoWj2gT6wZ9PHwximHqOBAxFk3gKm0FLHfUxVd2ZbflBNvuDDXSweEqrEWBBBcxnYRLDpDGcHD+GnsFwq7NRMMmNXDQFDbjOiiypKyRoO5zfS0NmzKxi935KjfJR/z9nohLwyDnOp1dUbfw82smtoPOULaXlUJQBgSQkpluBXGvLrbzb32gxwPCr0fkhTFImPUjvohE+AQvbXLdNM7E+YlqngXlbVWnfzNEM4nXa+xbA8Smbj3eMJYYftG7yEvt7HLO5npLM1rQJ0OrQcJH5u69K7qFRBtURLjCZQGrmxN83Nnl7B/24Pnu1/H4VT9M9ZmIagrUX/Pf2TO0PYoTJOxcrucZ33GhHBLfUri+atC7hgYbmr0BY9craFNH1q65m4CJNPuTawAHuctOB9c7CT5e3EbfIno0dz3escHJgpnflQCjidb51ac6OoHc91z96Jr300qJbpMKlIz6O4XDN99pYYBWSf0Q58uYDdDsWbc+v+EyUnPh1jGPpdVwqBnN/RjHqVKcl3+JwWo7elxRA+VWxf+mEPnFiOtKPfa+tsnVGsAuHz+dnZuTBCDdGB+9ZxS4Te0yuyoD5tr++6byjJGlROSmg4d4goPLrfVz4TH8ec6Mm2v4Q==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199018)(36840700001)(46966006)(40470700004)(356005)(7636003)(86362001)(70206006)(82740400003)(54906003)(6862004)(6636002)(5660300002)(316002)(70586007)(4326008)(33716001)(36860700001)(8936002)(8676002)(40460700003)(2906002)(40480700001)(41300700001)(55016003)(82310400005)(336012)(83380400001)(426003)(478600001)(47076005)(26005)(9686003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 07:56:15.3908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e70a1a-4e35-4513-2b9c-08db0429cb59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 10:57:19PM -0800, Nicolin Chen wrote:
> On Mon, Jan 30, 2023 at 04:35:35PM -0400, Jason Gunthorpe wrote:
>  
> > IMHO I would structure the smmu driver so that all the different
> > iommu_domain formats have their own ops pointer. The special
> > "undecided" format would have a special ops with only attach_dev and
> > at first attach it would switch the ops to whatever format it
> > selected.
> > 
> > I think this could get rid of a lot of the 'if undecided/S1/S2/CD'
> > complexity all over the place. You know what type it is because you
> > were called on a op that is only called on its type.
> 
> An auto/unmanaged domain allocation via iommu_domain_alloc() would
> be S1, while an allocation via ops->domain_alloc_user can be S1 or
> S2 with a given parameter/flag. So, actually the format is always
> decided. The trouble we have with the iommu_domain_alloc() path is
> that we don't pass the dev pointer down to ops->domain_alloc. So,

Precisely, the undecided part is not the format but the ias/ios
and SMMU feature bits of the SMMU HW device's, in order to set
up the domain->geometry. And the regular domain_alloc() taking
a "type" augment alone can't get the SMMU pointer.

Thanks
Nic

> the SMMU driver can't know which SMMU device the device is behind,
> resulting in being unable to finalizing the domain. Robin mentioned
> that he has a patch "iommu: Pass device through ops->domain_alloc".
> Perhaps that is required for us to entirely fix the add_domain()
> problem?
> 
> Thanks
> Nic
