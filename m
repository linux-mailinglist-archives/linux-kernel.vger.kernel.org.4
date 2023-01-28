Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F68C67FAD2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 21:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjA1U1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 15:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjA1U1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 15:27:52 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839B11024E
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 12:27:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em4/aD5CzJvob46igR62D2NHChN5L6BFKe3bfBsAUyN24rgk786OZ+zFETo0yFNSOc+gTsOiOhKEJhD3Z1YM4OG0W6Fc6Vxs7/DOp4whO9MDEVFAN4Q06krSmIVJBR37pk/FkEh5J259+Lr5x5rmrt8/psfO+aZv1Qt8aGdywMPO4cmDHsaXA8cDvjsLclhAU9muN6g4vh2Qlqucr+rmVpqc9W0DcNvl2wt50ax7K/56MvLNp4byPDe0IvaDM6QIg+m+Xm/erXVYKp/bVnOA60pMO4oXNb2KE7dKCTVMtcWTPyXVVub10rcLXEhELU1YqPE1jMHkEoFeaOYNzwWh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amJQYjNi3OKa4VAcyXiEE3GC+puyM1XPVAsv7ALTcv8=;
 b=mCFktX4XTioqQRKGayZSrDAZU9GQmFIGyeRvzOvf7L8AzW2YrqkVCbK4gzoJUq+kdcmCc6F0O3FIeG2EMz5i13+bA/z/ZpgiMZzLnoGDvM/oLwDZ83YFqnVmMatQiidFS55bPZTaDC/d6Drn9MUUmvAQsDsxAuoeSuXwuQI0KD5H4+jagSTS5rURFwdBHpPcSKU/4a/hUDzcCVefS4u8N/2SbfsqQAHvKf7/eKdnzTOyoC8Q2wYe7Y3tv3zYfYzIvwPLFpD1PyosatJc9ZFvUaWgfA0y7Jpp71WrmZZRKS1H/SDBLELdrDr0/NxLMrwMAUHH/sYI6si3USgBQaFDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amJQYjNi3OKa4VAcyXiEE3GC+puyM1XPVAsv7ALTcv8=;
 b=GaU/BzCkOHIAEpIeq2/oRl44RNpZIYfMj6QXnNDevXv9mqdWpAoHwptMtW4CpvhulFMH2kYzvwHXnTtrCUcK9o544mDu0pS6yjCkUOVkGHIlLppXVCaQUlwGM2PtpOaICEXGFexakzmd2gHXOC+KkMCvEr/gUsQoDAL36nWJN1o1d8I12l9ZDrN6WLGZHoHlTtIEKO0VX3sD96ZKx4M27EnXCRWMQMz6YBkK6Mh+G8sH9Dqx2DhrV5/jFVvJkGCHa6SsjcKwTydRM+RFUKD5upLuRJuPNKazfEMp+2pjm4MmWq690vpiIM37ZmkYOru85Q0HZ3wxoNCUpLQwlxsXfw==
Received: from BN9P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::20)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.25; Sat, 28 Jan 2023 20:27:50 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::4f) by BN9P220CA0015.outlook.office365.com
 (2603:10b6:408:13e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30 via Frontend
 Transport; Sat, 28 Jan 2023 20:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.30 via Frontend Transport; Sat, 28 Jan 2023 20:27:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 28 Jan
 2023 12:27:46 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sat, 28 Jan 2023 12:27:46 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Sat, 28 Jan 2023 12:27:45 -0800
Date:   Sat, 28 Jan 2023 12:27:44 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        kernel test robot <lkp@intel.com>
CC:     <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] iommufd/device: Make hwpt_list list_add/del symmetric
Message-ID: <Y9WFQDP1qURYxtCa@Asurada-Nvidia>
References: <25b3b85b03fc2a7968c476b0533f451acecdfd13.1674872884.git.nicolinc@nvidia.com>
 <202301281943.Jdvwci2p-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202301281943.Jdvwci2p-lkp@intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT005:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: aad7e3ec-8668-4d1c-25a2-08db016e201d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKkl7+v/UO7KQvnlxw1Eyak/ZpI5XmmXgRw0qIECCYRXPdr5xCKRhPtUJdduKZROPoiuErhd7loAE5v1L1SL0V+gc10mJAYLC7JbBXB5JOYptjX+3uyV5X8III0Bac+X32Xn3MjoKfgymEA9BVxsu95KC9GCxa+MrBBH0yv9guJvRaBKWZtbxBQ1evIRDd1L3NAwC6Zi88erEN/YuO/LyMbEq2u97UMctrW/gLyVayrL+lRJfNpAC2U3T4ZkuSPTAJ06CPVpSUMzf9tmJAmjthxVf1BWeOPq0GGZNUO7gU9epcePI7o9GBGri+8aIuAfsLq4qNnalQ0KEzwfKcdPg+JY+8vmJmzL++WnZy/7Dmxs7H6Qlae/OsUJxyLVlrabtVUOvW6deakgPteRaVQSBqXVeEXXGxXXdXlbbJRRo/NY6FVzCrPvutxDyrDb3Znp221qqgy+hn74r13SNAN4Ee5sDiE6IXHsQZutrkuDLCpdIySlW3tjesi7flncKZLjV0sZ8I2T1cfxfEyeaGM1UYLN+ZuCz/DIl9slsSvgwCEB117NpLSpP9KKoovTbc4oOISCmLxdQ6UCwqsMnGoqrVVIqNrm5U+efZEvFsnBzGz9d34oWUEvyJje0Vs35LuoK/lK9twxgFd9NRb6hnUHvbfvU6118Ky/IBmC+URkXvihR/Y3X9i9lWWy9YYwqQiit5ymGp8RVlayQKRHjgz1/A==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199018)(46966006)(40470700004)(36840700001)(47076005)(5660300002)(356005)(316002)(8936002)(82740400003)(110136005)(54906003)(70206006)(70586007)(7636003)(4326008)(41300700001)(8676002)(36860700001)(2906002)(40480700001)(40460700003)(4744005)(55016003)(478600001)(83380400001)(426003)(33716001)(186003)(86362001)(336012)(26005)(82310400005)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 20:27:49.7837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aad7e3ec-8668-4d1c-25a2-08db016e201d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 07:52:54PM +0800, kernel test robot wrote:

> >> drivers/iommu/iommufd/device.c:279:23: warning: variable 'hwpt' is uninitialized when used here [-Wuninitialized]
>            lockdep_assert_held(&hwpt->ioas->mutex);
>                                 ^~~~

A mistake here...will fix with a v2:
            lockdep_assert_held(&ioas->mutex);

Thanks
Nicolin
