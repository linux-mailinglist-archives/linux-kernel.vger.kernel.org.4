Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835DD64A882
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiLLUMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbiLLUMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:12:00 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52307178BC;
        Mon, 12 Dec 2022 12:11:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsCc9+hJ0AgNXqnhx05sqoIy4E3JxuXeFvWDefAjb0z9+9xapvFRDRjFcd2SelK6k2YhUNO9fGG7oHmUtIUZ+aO3Q4vzx4bXaQdCO+TWg5SwWgQ5uuQmSMxuw/9O2NVAS3JKBG2UtAm3rBaqqeycALj0SMS1FJ/elu4kh9szyogFcI9gauwIMN8SDLSLwB8+z+l9SGuIMv2dabcEevqGRf40dwkgijCluHIAEa96PzMC+ds2wc+Q3saY5KNKetXWy6y+binhR0bOOkfu2q7A+NqUe93XyvXUsNZ0UFL7rIpzSBFxaZ68Bs9xLyvWC42A2+4ijm04mzDAKSs6gp+FfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxPoMMcGSbe4Qz542UUjr19GB3A8lmS49/PpN2qShLU=;
 b=QuJiobK59SXqOturdEvfKA1JqWBxZAidlfjveUVx1tHAtplSvMHB1aI7zOKNGjfJ5b9tWTp9NhV8AqSek057/Fo5tQn+2wSz9fsNJQ9xuco91AGhUluG/5ifN2wOhvwVZP/97kPVm/2wV62of7Z4T2pu6X3cuzvL+bTNay01gKiZeRhhgcnyQ8lC6C3v5gLPriY9vA20TIAhkUgGQqunS8gTufwgkQ8/qrqXgvMA06Yr2YbI45fxiT/u44Zb1COOk+D3Afv30cmJf7+/UddkLsUw3YaCUWDqUEJEdb2wQ/MrfZ3FZDDMw3HcMUKEB4ZbUsY/Ol+6Ho6OgV26su/s1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxPoMMcGSbe4Qz542UUjr19GB3A8lmS49/PpN2qShLU=;
 b=UWnZcHsGebpVMGgsLtONtPyspjkaoOSRCnxCDvHCzqAfWj1t1L1y4dMTGFqJmiC66XXSFgLO94uxlknWdD+ONvLeR5H9RCPg+xpEo0BBP895XBELI1wbawhp/YQEBAWZ3UAik2OuGv6O30F9GATCwaYzWJ/IfMZVGuOxFGBmPFH3ClZ+VSD59Hd6fn6G9onKz01cTjyxnZ3kSnFkV8bHxMvDDDE8+UcefHiHb/h66ls9zrZw44lFqiP/dpJBGF9sM4lcYV8I2ezEHnqEXWisP/vVHaBK7Y+D2nVJRbn2KnE3wSsaG57d35EWFeGjN4c6Lf4pXxwORyR/PrCBfum6lQ==
Received: from BN9PR03CA0669.namprd03.prod.outlook.com (2603:10b6:408:10e::14)
 by CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 20:11:57 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::6f) by BN9PR03CA0669.outlook.office365.com
 (2603:10b6:408:10e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 20:11:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.7 via Frontend Transport; Mon, 12 Dec 2022 20:11:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 12 Dec
 2022 12:11:45 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 12 Dec 2022 12:11:45 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 12 Dec 2022 12:11:45 -0800
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
Subject: Re: [PATCH 5.15 000/123] 5.15.83-rc1 review
In-Reply-To: <20221212130926.811961601@linuxfoundation.org>
References: <20221212130926.811961601@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <e7437a61-4d0e-46e0-93ed-003727991eb3@drhqmail201.nvidia.com>
Date:   Mon, 12 Dec 2022 12:11:45 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|CH0PR12MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: 23af523e-3730-4f60-d6c7-08dadc7d1f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDjWDnKZBFN0AfUC5B9vXd/XSmniPBHcb+twkPgAOwXSD6bhPOkmfCjW4l8eFORGlL7nTI+j/yP6gSMjW1VP63b2r3L6IseeEi23iW5jpp2KsEjpsRsZmAZGhvv29ylwEANbq2kzowtK0G2mAFGVBAnmT4jyVmveOVwhTwDHgAOWwrv/Gse4EmsYG9JD0/3GOYnJ7O95oUoi2VAcoxK5SWEtkaZ1JYG1Ne8i2fz+2lU6F5OiJLiVnijhnmJFv+Rznob3YhAOHmAiwMbtiD8ZPU1yRAAUxfXvJFGd5NF2Uw1O5ltuxG7r7bYDo4cZRnVFtlKKsZ1c4J+c5DFymS9VavpOS/YnRNBoaiHaIx35XQQn5mncjv3veHT3plYNcQtfTc15owfFmp/xcacJtdf9qdrPvnruYkgbypZ2NeDS0QQ81LrPmViSuAJz1oVHIyGg0TE8+fgd+uVrhFgDfxXqMWQImK2IsQ9sVRZBBGkHQtQ8E8z3eW1qnvPpqnP9Ng44DapC1EIOqRM3pR95i7WIRrt4CED90nGFk8hvpvsMxW/K1NFQzLoxSYw53FyRPfrGMbD5vQHC7U+DoKEQtXW9czdP7LNAyxT2bWEBjwJPZCCUU8zNisLgoda5uK4R0XeUepGliqIRCV6NoJVnv+PM9fHnEWqPJQVyTgfX/Mu9PUJ/fK5o9TwiLJNLBseGJ99Rn3tYp4bSCMQltsJ5LRbNQjDXycMhFukQhhzunSXLvd9awWN8Oy0B4NAHH6fn977uJywVp/HFvcRsVxGBsbFJsHSzN5QSfk0S18x3aKcUH3k=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(7636003)(2906002)(40480700001)(31686004)(31696002)(36860700001)(41300700001)(70586007)(4326008)(86362001)(6916009)(54906003)(5660300002)(26005)(316002)(70206006)(8676002)(7416002)(8936002)(82310400005)(966005)(478600001)(356005)(47076005)(336012)(186003)(426003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 20:11:57.5346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23af523e-3730-4f60-d6c7-08dadc7d1f1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5387
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2022 14:16:06 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.83 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Dec 2022 13:08:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.83-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.83-rc1-gd731c63c25d1
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
