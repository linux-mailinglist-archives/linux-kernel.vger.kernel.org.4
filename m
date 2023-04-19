Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB64B6E82AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDSU2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjDSU2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:28:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10hn2222.outbound.protection.outlook.com [52.100.157.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F245BAE;
        Wed, 19 Apr 2023 13:28:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kW9dK/LmS7bFtvx4grNwLv5jnOyV9CMxDbEoTjPoeuf9r34LOQWmnvfFHKWoKPSFksRBdrmOuxV0LYwKpytPLL/AvfRhFrc8yu5Ba9h0aVIvZScYzV8sIsNTCXpV3fc/RyD2q6B+TvZszwjtK7uBBdvFAc2ro0p4IQM2LCsW6Oheg31R8s3L+RJ+gYLmuLM4tIuavBoKrrM2VqruXrcndqB9MtStxq3Q9qBqm4dpmyQnh5C5g8bH7lE3sNJGJcgNVfTeVxIxeZFoXK0L+FqoiL/kNBDQvuE7aRKjMaBEhn4DUZn5DM0vzFK3w71PqgaJxvVCidLf4faZx/QDmCATRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOLam+qtPTfrsylBvEOGjkrmLh7VESz5E7wESI0arDQ=;
 b=DiWf23YvjxZ1a/bhTKquvPpQvvzmudQj508nmI3OXxKzUNIy5kKY1VFvm8EkPLGjfEhy0de/7mk5lkZ9zrOnB/IKvZxcL4r1Z9HC8LKba9ouXSf++qvRee3XA1zH3dsSq+6fe/UXeNBKlR6DwP3UU0xycF0tkA9I7oVFKcYNeEexyQvkTaCyUAJlBT0K3T85OeBNvvaNbY9LP+t7vmg4Eh9Eiery4yevrlzr0rkR5eZ3Bu57m6P+x+M40VxogqmYGSxFzfhgO6oyED6rdkOW7Azg+B04XFhdcy06OnNQkJkXXocgM3+CdeFp2Rs3+vEjxG/45ag9GnmuSyaH+p3DQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOLam+qtPTfrsylBvEOGjkrmLh7VESz5E7wESI0arDQ=;
 b=X6uyTBgiF5d5d8+ZE3hDbMsj6kgtIRHGbGe2BspObUbznF64za87cdaYkLGtszyLtQPnmsszojPLe1R62MvKw01COU+uMyx3inRFzQ4Jm+GsN74tOJgUUJuR6KsgfDZUGgzBVMpG2r6KIA9hn5KCtdr6++zVieDxrtZsfcGQ5NUeUPUvhT9YuQmZcTT3a76f3oYCSTmmMtX4Gcq+gffxR/K4Muf/5LEQ53wDIUuGVo6Gnp9yowBGV6s+GpTMJUpUaoza2OZtSdmr9C0cappHlsJUoUcht+LcKP8gM3vgEYNBFZ83dT1B0cmQTECs2u116Z9ENpfS3Mp/3LNDvvdQPw==
Received: from DS0PR17CA0014.namprd17.prod.outlook.com (2603:10b6:8:191::10)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 20:28:27 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:191:cafe::c8) by DS0PR17CA0014.outlook.office365.com
 (2603:10b6:8:191::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20 via Frontend
 Transport; Wed, 19 Apr 2023 20:28:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22 via Frontend Transport; Wed, 19 Apr 2023 20:28:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Apr 2023
 13:28:24 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 19 Apr 2023 13:28:23 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 19 Apr 2023 13:28:23 -0700
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
Subject: Re: [PATCH 5.15 00/84] 5.15.108-rc4 review
In-Reply-To: <20230419132034.475843587@linuxfoundation.org>
References: <20230419132034.475843587@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <5a00e8a4-ecba-4e83-b621-882ac48f6584@drhqmail201.nvidia.com>
Date:   Wed, 19 Apr 2023 13:28:23 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c6374f-cc86-4227-b420-08db4114a1a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0M6es/rol6YTZAGYOPG1Yg91Nw9FFbZ2oJ4TjFfvsUAdanZT5asjrnze9BtHVnpeJE4Z1toFovUW6+bI8SIjrZ36heC5oSWjcMSKrOd5NDfGYFmd73gPrt5cEWv7nYUzUHSmTfob/55o3RShjqeGHlkc+6TlzbtJ6UIHjAIkwadiLirW5S765xHKYKJGtc9TtaPGQaK4+ui3z0/fvCCTrAL8R5auMpcJuDEAg22IzUGEYQpHYcBg9UseT+eD77sD2G38sz3qJGBJtTeOsEubsDFaMulubUZn9eoQCUUF9mhKszuq7Gfw7qDpfz4BVHDraBHIPGKkt6G82QY9psy1nQPvx4dzEmy29NzjuQRxSayUNVe6psuKOUthdgfjEPBjGzyymR2lqN0LJMLT4zdrkcI1x4n3UAbNDu5XftQV4irSlgHJS+0PXITCxWERxuNh0B9ATlDUp46nP4kttAwjTMgqYN1FGTsDvnImOFv6wUVUvGOdbOfGBqkr+kJRBMnJuHO9Uz5FkfCrXz8tp8eKspiMuFF+FYHkWoz6MrEisMPGG+w2G93CceIq7aFYO4y1mIDhQHm/q/AEp0edwEZntgO8PbYJdlH3GkgEjsSF5QBxvwhiKXtuSuYo1WFCvjsVy9yFbMPJMWzj1UjlBMYD+Dkx94uoThEljMnQiTLn7H1zwbMnVmxzNCQ1/Ghpq0Z7szJwzKFKQicBzaE0tSu/t5Z69ATosb439r4PoXcPCL1mhn2uvh44EJMmOUT5brW3kzT/5CEJVXx4b5Fyt7F05VbOxoEoGoSGxTziTRRSsT/l35d/kmxhvkgmJB9JNOnbcQmJbwS2PXR7qAkP38hI09l8xShMV1efjVIag3DENhY=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(5400799015)(40470700004)(46966006)(36840700001)(31696002)(356005)(7636003)(2906002)(82740400003)(40480700001)(40460700003)(966005)(36860700001)(478600001)(47076005)(26005)(336012)(426003)(31686004)(186003)(86362001)(5660300002)(7416002)(41300700001)(316002)(34070700002)(8936002)(8676002)(82310400005)(54906003)(6916009)(4326008)(70206006)(70586007)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 20:28:26.8531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c6374f-cc86-4227-b420-08db4114a1a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 15:22:09 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.108 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Apr 2023 13:20:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.108-rc4.gz
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

Linux version:	5.15.108-rc4-gdf26c2ac7eda
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
