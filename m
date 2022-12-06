Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B25D6449AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbiLFQrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiLFQq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:46:58 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F05DBA;
        Tue,  6 Dec 2022 08:46:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKv3a94A/jalKckzyLy+p5Vi3nSwT5iv2VlNNwKOOEtD1PrIO1jscR9JlEJVf7/HQQ1U4ci8uBk3eZM96x5zxFMWUqDyY9nue6nUKy8gBmnfznvrFnqBKE+c40T2vqzuCmCpGUdk0Rm307gyiKnuqd5Qd/iIZYRFyZdYFds/i9EC9awT3A3uOcEfnrV4UhYlwjKy70s9AasxBx2BosOyEHYpq6stZVLtGuXxn5HTsPVWmtn6TwFPu1U4MwrbZkMsr58otUk5UUJbaaThrY6dN/nzg1K6cqKq+/WImRhLw8Ti1fZAueYkq5zD3CnSULiOTmlLm1kAMTkFCwdvwXziEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WN6Y7tGhzzgjEDWt4W1C5GPfv88BmXVaDWiWkc7wviU=;
 b=D4aaCMdknhnTU5EY2nNs931arCD44i6MwbA6CPBwp4O8jEFyzIiYCuRZClveDA/lGQ7LXt5ISItlETD2XOTuizDKPxQrAUIdIBNCOcmUtZWqWrYbVoB52w6EYWrlCs7VeesHXxZ0tZ6oGTS0PbiepWZnB10dp/QQeDSAPBewTyoMVIAaSNzAoOrbcCooAuBTdOQscEm2eU9EW3CqEEGPCNGMhsqNxBagVtpq8J5bsUikKVPzfBMzylX32Atnq4Cz4eaEL0pCCTicYyq+2eoehU0lakb/SKxJDaFJ82J2cXSlDRVJL3RNwAZhAna81X9tioIeskGGr6OUVepaux3Vow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN6Y7tGhzzgjEDWt4W1C5GPfv88BmXVaDWiWkc7wviU=;
 b=SMdG1sGKhLqazFV8Aw4B/ylRtsF/134flJNNCFspIJwkRH7FbOeN9LK+ABwi18+2+fcTCKvUqSmy94Yl08mU6q4RL4FcKupty4+2xCYoeeagksluqfnfUNGBzp2r2cW9AsomKuoPMLiEm4m4v09IUN3BOy9Y8+ZK2ymVU9ZZBY2zHZ0pAas7YiBBrFRYvozJai3s6WgXRUp7dHd2McW9XNVVJuJyPiOvlKFBLVhuXY0pP7cVEoNxs4syZ25O8P1thPAbXIS4kCPDiMml9FOyyPjTb44+IrNLHdq+/HO/8Eg/6Si19FAFm1LLN5QyD7YzYHNX2zoOBCRrJMNg01VicQ==
Received: from BN9PR03CA0214.namprd03.prod.outlook.com (2603:10b6:408:f8::9)
 by CH3PR12MB8259.namprd12.prod.outlook.com (2603:10b6:610:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 16:46:56 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::9c) by BN9PR03CA0214.outlook.office365.com
 (2603:10b6:408:f8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 16:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.14 via Frontend Transport; Tue, 6 Dec 2022 16:46:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 08:46:41 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 08:46:41 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 6 Dec 2022 08:46:40 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 6.0 000/127] 6.0.12-rc2 review
In-Reply-To: <20221206124053.847053972@linuxfoundation.org>
References: <20221206124053.847053972@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b6dca56f-cd92-471f-9de3-2197da71e4d8@rnnvmail201.nvidia.com>
Date:   Tue, 6 Dec 2022 08:46:40 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT052:EE_|CH3PR12MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ffa9a4a-57f9-4d2c-8d31-08dad7a97bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MztYozb27EOcZgbBX5WtpVgFA8i/TL1kMu+skdsfqLSeNG5b1CyLwwsjeT2Cg/jKSB8BLWhll3T4NQdq8xLA/HQg1U8BUWYJ6qbZdEfnR8VmlpMGPspgQ67hZinuLfDeQ2wHyDd9yigV2hav0QhmV9qBtHMqswF8T9UxSonJawkE4tjpNs3blVkPlPBmfAYOozal26ZhUC8cWPdDTaMa0Lw0gol+iqDWrSIAV3EJogKK2qhzayUCh225pFKmDllu3H/7mRct8zsp+5+JKiVl5K9/Buf9tmn649ZakTJsfeoSe1J61QuAd7ikvMbT9+u3TvqUi2VsL2X5ZWXd8p1RZ0bXH9xhi2dYG5ReqqKS8e6AmQ7VtBdXAAmWaAmydUKgFDxyQBxOgUFR+l2vEMDymeTdttY74hHgjdNbdZp2po5FPvMyBefVkxr0qlOlOWnPxAHCJ+ty+dpnyXKXLrUm/uZrmgeaRtH7raya7StPJ3NsfzGKPCwQtLQRQOxHwUv0zvJfL6nfYzS1AwgugzoOxXuYeMyuTJKfOY9sV860u+/aYbOWW0ThMKf2/0N9exASiXySGkZo+dqOclceS0y3C9ICLqe9kSjbOuFlS7HNQ02ZHBQPx/xKo732u3uJ8iteDlP9niI8SZ4cTp8UuEoyUC5t9f/xH7iw30sQlGaTtygBgmqfX2LmOWRL2pNR9CCuHbli2FHVOMzcwXJlRKKh07WpbDpuHBopDVlwLiXPmfCUysPbkELTG3f3VJIimyxywt9xrldZA+Hf/XEgbeC9nK7F05u2Mka1QwdoTq/drgI=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(7636003)(31696002)(86362001)(8936002)(356005)(82740400003)(5660300002)(7416002)(41300700001)(4326008)(2906002)(40460700003)(82310400005)(478600001)(8676002)(40480700001)(186003)(26005)(336012)(426003)(47076005)(6916009)(54906003)(966005)(316002)(70206006)(70586007)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 16:46:55.3057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffa9a4a-57f9-4d2c-8d31-08dad7a97bef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2022 13:42:16 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.12 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 08 Dec 2022 12:40:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.12-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.0:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.0.12-rc2-g2152813a5a74
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
