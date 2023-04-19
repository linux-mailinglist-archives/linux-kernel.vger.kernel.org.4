Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C0A6E77C3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjDSKwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjDSKwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:52:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11hn2240.outbound.protection.outlook.com [52.100.172.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4E186A5;
        Wed, 19 Apr 2023 03:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBZHeewG79sbid0Zlb5BEmCe2TKmGP7upt+f6NlytMYHDyf8YGCO7OhwsJ09JIBczb3CGPHyc2M45dUWghLPEmYLa1+tYBACZiW5SeGwhcpxC8Gc8jRo5J61F29KBgpuxjBZ4gzbSDFtpTAMxutHQczAAXIeCrCt1xSUE/5Il4f9zi64NYhRUrJa7hRhMPDPYvoQXZIBwc4drJBonsZIYGJ6d9fM5StL76+AUPcmb/CdA2YUz9Hzmbbrjuhca9DEBkGBi8AVE01vOCrewUpARJvzds4H1p0Ry9BG2z3U7UGrATcCAV+rf4noroJ7DWgGiwSqfs6slRCAjTd+ZkvqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXjf10cvWkIX4zHyqqqzV50uXDfd/OhIrLwv9hfmeSU=;
 b=XSdy2Ms7VmZcn/tww+imLj802dYMcUmZvyOvylNnnS79NZKwqkh8LzP25cgaY5pkuwNOIY2JWxVnY/H/NGK1L/WjQloWVltIsdgBq8gCjdL0JwmKrj791bfGZyaJwcMS4mS7EPp7JDTK7/UnbA8lucSZtND7IV2jIbiPuoqV/N0Y9cPmJ4dM30C2G0V5B7HveU8MF7jL+9aM788wkAnucN7Os6Nin2czsofMwHEjNIAlE6/GhYYpI9o5awF9RTrQR/nrcLegBV/ck1NJZDUMauLeUwLqq7khM6EErm0f+IDrFu4DNp8bqMcEWVTiGHf9+vP6+VTVjbHLGj1b4gMJDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXjf10cvWkIX4zHyqqqzV50uXDfd/OhIrLwv9hfmeSU=;
 b=ntDsDoM7Q7D+AkYA8xQ345T7dwt3k2GiECB12ytYeKgmnyF0Mjg2UnvOv4YLZZcGARTdsyyuIcGGX5d0jFU4omT7yVD5C0NdDK5jAxEq3B2uZpZZ5XpH0RCEEsLIqxA1OO/xyKRFD58HzaQZSEB/XUtcPHe3837uXV/MgCxB/cYQOXeROgw5gY84z2txJtu4eaz6Ts3R/Wsd/UOucW7hRvOgfM+GXFjyMLbYu5Dfbd+erhpXaeAWH+I66aki13kpDG6jHPaYPnxQT5yZdQoSlrKs2nEBjgXSdGEhOhdIRbh4l9xmniKYgp/S3otVK0GMF4JdqHdUaYXtTXzKqToghQ==
Received: from BN9PR03CA0093.namprd03.prod.outlook.com (2603:10b6:408:fd::8)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 10:51:56 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::d2) by BN9PR03CA0093.outlook.office365.com
 (2603:10b6:408:fd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Wed, 19 Apr 2023 10:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22 via Frontend Transport; Wed, 19 Apr 2023 10:51:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Apr 2023
 03:51:44 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 19 Apr 2023 03:51:44 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 19 Apr 2023 03:51:44 -0700
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
Subject: Re: [PATCH 4.19 00/57] 4.19.281-rc1 review
In-Reply-To: <20230418120258.713853188@linuxfoundation.org>
References: <20230418120258.713853188@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <37897d82-cf18-42ec-8375-3c9a9375134f@drhqmail202.nvidia.com>
Date:   Wed, 19 Apr 2023 03:51:44 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: b24a80d6-ecfb-44bd-ce9f-08db40c417fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUKo7ublnfueLpqFUOACKTtYxKSnRJfDWYVKKx4z0XQwHuqP8liWst1mk6xu8tY9abnWexBWMIb+dWY77K3yNeg5/4wP5ogYZY+0bYwGbXC80kv9tmOtqzbhjzO0oRyi07d3yN8340eLK7FSfZe2GlZ3/IGbK3Yo0jYcxlko9HRagS8yQPsx4BQ5L7XeK3u2mRHqS03vRjZCQ7Z63ryYIx0/36mrKklHpPtx5ffAt9z5akk/olem4EWFIo7uVWYP+V3sV4ku5DYpYOxV2ovz9ECArksZQIVY1UYfrBZjFthJBvKTGhteogjYpYlbz2TI52/XaiQTUwBLGt/H6/4Ew/TYUWOGXrHfKNcWsbaqb7s01M4TqjlytlBUwAF14MzZ2K7ybw0YM79sAFExFHYog8G5wschbQKgquAvBdsSt+v1eHNX3P62r5mFJBOu3ql2c+2b8tM+j84DOiR33ABmYOQr7uZj3UkELm9FKpsxbZ1I6cYZ+ArFAe9KmyWW1ae6FL2bLMCPn89MEt6usPwGn1cE+bxhGKVaQ0AeQxSRGlhbmANFK8MxgN/YTvd9Z/wN25vqUKJkT3sz77Q2IdzU50arQzcQgmbAyMcLlJ5+riIE7PsqEqUsjqf104EC2gbnCeDTfDLIfigVJFmu24EtCt1E+7ljfuYgY/C6yae0cmL+eUVRD3hN83T6po3HrfLTYR2vYXbOam1C/5/2Z0sXWdqMDRDBCX7tGPDKYChzBLkSX3OMXmDyo+hlCy4XlSRHaRUieEaHtBAFLxxCncbrR76jDa0SPV2zGVDV7vVD7zvGwbGJGGrnY8h14J1cIVjdIHTlnuAf12TSbmi2wKFbjCc1Q/1TuaXa7hxsAdJPREM=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(5400799015)(40470700004)(36840700001)(46966006)(2906002)(34070700002)(36860700001)(40460700003)(478600001)(82310400005)(86362001)(966005)(31696002)(26005)(186003)(40480700001)(336012)(426003)(41300700001)(82740400003)(54906003)(7636003)(356005)(8676002)(8936002)(47076005)(31686004)(4326008)(70586007)(70206006)(316002)(6916009)(7416002)(5660300002)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 10:51:56.1106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b24a80d6-ecfb-44bd-ce9f-08db40c417fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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

On Tue, 18 Apr 2023 14:21:00 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.281 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 20 Apr 2023 12:02:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.281-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    22 boots:	22 pass, 0 fail
    40 tests:	40 pass, 0 fail

Linux version:	4.19.281-rc1-gcc0a9b81697f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
