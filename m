Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8A165E5C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 08:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjAEHCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 02:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjAEHCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 02:02:37 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BF65F50;
        Wed,  4 Jan 2023 23:02:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTPSgLL0uBjxoqqw97SjfC/vyLGtrB7Rf/5hUCJZ5lmQtOn3/Wv21woOuMrmgBVRWlH2ZaFm+gETniup0YGJPFAMH8/Gsbeq155iEHOIN00aQ/mekNsGlhVy1HVTgT3zETWtvTm7DA4+ilJ1/BmxUqSOBekWbtTFuSjHKgX16riPYpVR6zdVjC2XaUYfQNLP7haG4uV45sfRmrbPdGwI7YOWskKZl+a274KG+JZh5rf58wRuf/lkMgsGP8/RC99ZWP0UApBzk1IWo4F6OGDETbvfFfg5dxtmNRcyaGf99Sdc8pwSbPGmcOaa/I1GDdbX+pp/l1TRI5ckFd0mikXSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqRepjA3LvIfUTh7xOM4rq5Kk7oYAL6T8r6FH4YQIx0=;
 b=MORbwgNE062rXJF3yKwHvHngYR3MSD+wajNUO3qjjWPm7kY1fdvhA6o6n1zMzcpjhE7tlz+/drFgMcurQvFDE+jJWoc+gR1WCNF87Le/5HSla84uk50VZO7YJurXf6VuHFMmVkgzN864o6sO2XqYokH9F+hBGelKGENMlwB4I6FwHfa8hrRgx6SaylmeuzmHLLL9FTUHl4ua+C9QxywYUDVyoB0zwhwhzZRLDjgqs2v1I4/eXQGY46oXKbxO27rMlpMF5frQTM6zPgbCwHlYzkvpnKYOPCXgAIjwOOWl8JliKcjrcR/HhmSGCAiRyNH6jTshkfDIFeBMZW/0nB4mcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqRepjA3LvIfUTh7xOM4rq5Kk7oYAL6T8r6FH4YQIx0=;
 b=KHpubenPSHJiP8yOnYMBWov7AMMTzmqFndfo7yjFTCT8/e/6gU2AtBwlkQRHiO2YYtFQaB9pNfwJqWJDO48W/y1RiASUShF9uagBnl55txB+mB8SFLSnMmCa++AeK+hn1BXkqoK3CaLdoLORty5MEVwD4HDmjzY6MvSLUFxt1JkitiU69WX4zLmEXT7FaLeOdhByONgcQFDDh4ly+NkOVmEcuyeCRQTy42dMein61JJtRga3ywKvfW7mWwWmMDLlqrvECy9vQAn83847Z4O1N53UHupVqtXKE7z+7m+hpqqk8E/kr/h3/ZQhkRWmqoinN15UUGP2Jb4h0t3GiKnH/g==
Received: from DS7PR06CA0028.namprd06.prod.outlook.com (2603:10b6:8:54::33) by
 PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 07:02:34 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::46) by DS7PR06CA0028.outlook.office365.com
 (2603:10b6:8:54::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 07:02:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5966.17 via Frontend Transport; Thu, 5 Jan 2023 07:02:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 4 Jan 2023
 23:02:19 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 4 Jan 2023 23:02:19 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 4 Jan 2023 23:02:19 -0800
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
Subject: Re: [PATCH 6.0 000/177] 6.0.18-rc1 review
In-Reply-To: <20230104160507.635888536@linuxfoundation.org>
References: <20230104160507.635888536@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <13be028a-a34e-4121-b136-e0a0b4013a22@drhqmail203.nvidia.com>
Date:   Wed, 4 Jan 2023 23:02:19 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc06ba7-39ef-4633-4b57-08daeeead233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LLOD6Fu/CyVGxRQZto17toyROIDmcn/L6AsGpXLZ8AjK++BA8Np3e3OZAdThibUjsnsLUe0sexv+BGIVXzOxFfcc3ioHQtFpdEtoLGeewXmKklyTeUI1jvWUsMkADCYPTdhw9gFz64x/ZkxHoNUHGbfpPZFWrVtqd32lBWnHcVISp9O9nKU6IPMJuoZ9SOsOMHhn+/IklU6K3VHuVVa2EKPe8DfLFw9AnYBg03yWiYWvvLl05FlUQrM2sOj3pWIHopcFMQkgNsmjdOZy3DI0M/GbdL0Z9t8wbN9mexz45JK0lpyDYUOENoofGp57IlnZfHWt/Go1XWPNc7h1FpRIdfDtoTRu9bsk/fQLj/0j71JloZguRH+OPhMe/T/aBBa9cI8YhMUrBjL8t+SlDyt2AenQTbg6dlM1oYS4jR60UBs86XTTtqWCsuowbthpeEMVrPHE9dWjguCfdBkoDQ1biCIwv2AQe5Jjra/IeJTaQg4wLrGXDmuQ4XyTnY2P1Guyff/u5JzupfgfAW5PBPnc9LKgVVt/PE1csPMoLDw80vbBXZNKcJVGyic6EzJoQXh1hGRgXE7O/Gnsn4RniV/RLQJ35YeyeeXDFsVrQPi6fBWBxhfecKX6ew1WCNFKq5Teo10xifPt+PpRjYRfAuZTCj+Y65Jd6C5Id96cp73HmGTch2YVXqNf3IxaHyaIgNxEtBr9DrrhDYtsYWyOt1kC0zjSqJfs0ImTtlzPrlDUHqdtg6XlyR5/BQl96/fGpBXWe6cNXcLjRv3iAo6bFs2vEryEbRsyDPGMWDrYhj3wdQI=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(478600001)(82740400003)(966005)(40480700001)(5660300002)(40460700003)(7416002)(8936002)(70206006)(47076005)(4326008)(70586007)(41300700001)(426003)(356005)(8676002)(316002)(31686004)(6916009)(26005)(31696002)(82310400005)(7636003)(336012)(86362001)(2906002)(54906003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 07:02:34.1275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc06ba7-39ef-4633-4b57-08daeeead233
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jan 2023 17:04:51 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.18 release.
> There are 177 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Jan 2023 16:04:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.18-rc1.gz
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

Linux version:	6.0.18-rc1-g84ff81fcb901
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
