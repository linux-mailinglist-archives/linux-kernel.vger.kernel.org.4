Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17661681BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjA3Uyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjA3Uyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:54:46 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F20647ED3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:54:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuR3xfuZ2IhPnTbLBlpiUAXyyD0RL7EpeFOvzPXUY1XA2VmxXOZlhGDJWSi4pKIX7noQYjVKopMYv9ng7NDiNeqRVxe2BMaaC4JcSg1NrUizoE86CKvGmhXAmwwIe070hY0C6Tqzb9pWUpaE+kXhgfr+f4hzd91107ko7auzRr/ACbWhWOHSNOMZTn23hs67C34FocCb6MFElxtpJbNMAd+8MfA28BBWk7jmHZ8hrfsFCc5YGhnAGegEAXCy9zgb7AAPFDFGjuMRVGhzU9Avbc2YjJ/yVMRZGnlZ6SkkTmdwQPw1RNWPZ3GU6hPlmJeVMeSHGRHK1jGyVRBj3ototQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWRl1T6FeG8vRd/lOkR3G5o95rOX0BlgyOKNRzwL4pY=;
 b=eY0ImjRBAqddLLDdUXqLcXYDgif8YjIXIjqbMij8+h2l/Jj1Ps4tXPlTsnPPrax8njzcQdBrvMZWq5crxZwZHILHVaZLXbLqS46WKzkG/qSAiO8xLeeCix4Kp6RdUGHasIxQtbln+YEDZeNdkUEMCfZYcRqNaZO621Jzp3V+wSHpHLumJ81cvE4+N7WAe9wkIM/7JlGd1NX3VTfgsK7jyQQA9+sPtIGqF/JcBw6e8MsYiC08qZIiwcyftmTUtWsjZpWBZHcqglIj2CgGP5LcGq0gohg/DWgDgZhepmNrQcHELZBfTpMsxHq64e8RNSUpIQp7pCOC9Xj5Qsfuxwjwhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWRl1T6FeG8vRd/lOkR3G5o95rOX0BlgyOKNRzwL4pY=;
 b=QYsqhc8q/B1sgOPEYinVLBYoKN26o1+lXuwktpEE0efRAGnRqAFU7vg1TaOkx8reCZsa3LhvkE1Zth3f6d1Tt1aKMVMgy5DSqoKB41KtNT9pObWoJs+nMU6DqL37qRhm9q+WWld6emZqDt20DKx4FMyAZVMvDWBeAJgTd1ykUMzLi51XwM2+0hNf9/zv8mNXFpBAlEzfIFaTfc69ziA4HAvFHWc6+qFG00zBB+tsWiLiJA36I460agkfBWGIk0N01ikKxJu/APMwHm8wnFatuAt98O4NFb38izF/pwjH2wWa6UJpas8gGo2KMlSvmJPuVK/uAApf0R2Bwa1TB+2HuA==
Received: from BL1PR13CA0272.namprd13.prod.outlook.com (2603:10b6:208:2bc::7)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 20:54:16 +0000
Received: from BL02EPF000108E9.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::81) by BL1PR13CA0272.outlook.office365.com
 (2603:10b6:208:2bc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.21 via Frontend
 Transport; Mon, 30 Jan 2023 20:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000108E9.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.17 via Frontend Transport; Mon, 30 Jan 2023 20:54:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 12:54:01 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 12:54:00 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 30 Jan 2023 12:54:00 -0800
Date:   Mon, 30 Jan 2023 12:53:58 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9guZhNve8A1DGL6@Asurada-Nvidia>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000108E9:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4c87ff-8f4d-447d-8099-08db03042656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVXRAz+K7OQvabNr7RoeX7Y5uGuy9Zf6+mdC8rvxuhM+6ck7qh14u+X/91nTKyqKj6hfattIkk6W2TCpbzAyIkP089visV2+pIUu+ez4/UnCFFbdZY0NEk3DpwaG29mJs4ab20buRtKi7Rxl/ZQN6jzl69Mfy2CYh7ay9ExZYmRinNUYXwaYlLVOxVtCTz7Qn8TwpeIW+8YEDKpJ+TvhebBX/auLfpaUOi/VQj/1MO4xrmRbsD5TpVZPv5812iezaXAtua2MkjwOWcCnZdLfyzQQE3yqA6uasoD2yVDAo588QIDStzcf88ofspDpl4xgiKoo7rxnR7iuBQbSwrn42Xw5yl9qTPt/jF2YNytHQG1w1ImhxZYERyJY3HcxJldAjYoCKnaPvi7PrGmT3A7+ebHerGQ80DkHzRmBvHHQssEWEyTyykTwYSKpi9d4qDF2q7cnVev8WF85vtWBugJKmNjJArxj7TUrHiI9l6Vs1BaRJ3EyReX5bViRFrXAxIwglu5W6Agp+j2dwoV5fr21zPcSCAZlZzPhuNAMD62oRgbHycM/TkK5e1cwU1TeO5vz4gvmSFhsJLV5q2xO0dQIV0v639T+lTav1Spxm6gBygm2FNfgg7ZmpJcthfwUKvdV1L/cDqyzIilwLXr0TJ7ZGxJlyq9UU1zRmajbv44uNWJRLzdlCCPsJjC6ayeaLC6YHzW0PV5jggHQEkUV+j21OQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199018)(46966006)(40470700004)(36840700001)(70586007)(336012)(70206006)(4326008)(7636003)(82740400003)(40460700003)(54906003)(36860700001)(6636002)(86362001)(6862004)(33716001)(356005)(55016003)(5660300002)(40480700001)(316002)(2906002)(426003)(83380400001)(82310400005)(8936002)(41300700001)(47076005)(9686003)(26005)(478600001)(8676002)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 20:54:15.9137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4c87ff-8f4d-447d-8099-08db03042656
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211
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
> On Mon, Jan 30, 2023 at 12:04:33PM -0800, Nicolin Chen wrote:
> 
> > I recall we've discussed this that SMMU sets up domain when it
> > attaches the device to, so we made a compromise here...
> 
> The ARM driver has a problem that it doesn't know what SMMU instance
> will host the domain when it is allocated so it doesn't know if it
> should select a S1 or S2 page table format - which is determined by
> the capabilities of the specific SMMU HW block.
> 
> However, we don't have this problem when creating the S2. The S2
> should be created by a special alloc_domain_iommufd() asking for the
> S2 format. Not only does the new alloc_domain_iommufd API directly
> request a S2 format table, but it also specifies the struct device so
> any residual details can be determined directly.
> 
> Thus there is no need to do the two stage process when working with
> the S2.

Ah, right! Taking a quick look, we should be able to call that
arm_smmu_domain_finalise when handling alloc_domain_iommufd().

> So fixup the driver to create fully configured iommu_domain's
> immediately and get rid of this problem.

OK. I will draft a patch today.

> IMHO I would structure the smmu driver so that all the different
> iommu_domain formats have their own ops pointer. The special
> "undecided" format would have a special ops with only attach_dev and
> at first attach it would switch the ops to whatever format it
> selected.
> 
> I think this could get rid of a lot of the 'if undecided/S1/S2/CD'
> complexity all over the place. You know what type it is because you
> were called on a op that is only called on its type.

I see. I can try that as well. Hopefully it won't touch too
many places that cam raise a potential big concern/objection..

Thanks
Nicolin
