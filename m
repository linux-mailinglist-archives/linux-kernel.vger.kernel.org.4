Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF876B5071
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjCJS63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjCJS6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:58:18 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC49B2BF28;
        Fri, 10 Mar 2023 10:58:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCF7284Q+7qtRItbR/DUOJ8HKsEtDl9EBFEaJk4MwQkDApcZ7l85d89cgTrXrJL0L6xKnJoX90Xa2HfKPH6b/lRWyALzma037cHQG9DaJLteuj89xvmUqpu+dEUemgZ9YGXj3GpvYheNAYLasGAWafAvv6Bru8xoesh4CA/hTBE/uatlRxpt8bYnXy0vI1jIQ1AZ/9V6lsS2iG+uqsLK+2K0Tlf/1OuCyUJzXqqldAooCuqnSQdghTYrdVnK0RGE1nWWDLh058hWhJ1AzJfP9geB7yio2MU51FPYPaRbSe8IZkCjzjTu2W9UhE/+M0F1gcelLgS1EqWdzXAdEuKo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etN21hbhlXSLw2aNQERa81REuLtUOOar6e1YTvqLUY8=;
 b=oDZ5TlNiYU96Uvw/WWMPZGnr/Ry9g4ev/pqDBQKol4gj4jg6r9kLhXCV78OTNkAOokLhbJwqxODuebL3nDm0GhZPZLCrSOCM43Sz/Htp53+uY4wc+UX+Qz3xwBg8yziNN5mKcb0U0mattZlEJfGhkwJL6kmyxrxZHGhmeYSnO8JVi8T+hcmk6Uf4sG1/3JneIty7OaMSyo8lhqoRpup9MMjlBlpxN2015dC01idfu5LuCiJ2ajjUdJsvVo44O2Xa20Omjmr5xXt2QI1/AjH+LWMvKo3yP8KUyoqgBPKWPUSxRlcwTVc4KDRNtknHnZwMJeYuIqKwrbBB8wBiK2P3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etN21hbhlXSLw2aNQERa81REuLtUOOar6e1YTvqLUY8=;
 b=LtvFJB9mxeOJ2P2TL3AsXGHWeZKtKJV0Te5nEzVabsrg8s32RFJwltDs2CvgItF69Wdd+gxmvYXslZPTIRUfPCF04yd+BywYlfXxc6iD2cd/gja7JCH69BRQqi6SQB1zEc5BltR/mI5150K89hxUtngFcDHulwmUAh6fFKmcmhynneseeFnwfLCOMLNHTWXmh3dUFNOgS3J84HCKvJiPHFF2axJxzUv1AsEXwlTeJ8CXiCf49fETjTu5VFKas0nr9l2839rPDaHUMWqXBOwp24ej5H1AOQIo+S02nXeqhh7K0znpuw+SvxuyY407+KAiIhRF25XPRDXR9c0hU6y/kg==
Received: from BN9P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::12)
 by CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 18:58:01 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::5b) by BN9P220CA0007.outlook.office365.com
 (2603:10b6:408:13e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 18:58:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 18:58:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 10:57:50 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 10 Mar
 2023 10:57:49 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 10:57:49 -0800
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
Subject: Re: [PATCH 5.15 000/136] 5.15.100-rc1 review
In-Reply-To: <20230310133706.811226272@linuxfoundation.org>
References: <20230310133706.811226272@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <6b9c9df1-17e1-47e9-a678-2bfea997fb3d@rnnvmail205.nvidia.com>
Date:   Fri, 10 Mar 2023 10:57:49 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|CYYPR12MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d8ba5f-0461-4c0a-814e-08db21995f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UogTqZvnH2YC8VWRG1mVfaRUxJHD6C5ag81oz0OdqCQ5eYeHbZYQKMNTmR+Tp+l99oEcGMr+N3rbAvdjziRdNBWUdjm+S4fxPc3nLLQU6iFi+bBXUJ5qdulcjfy5EEBnqk4omGgtbiBisINgmw9mLHJTG4I1I9Vt9EhTvC7Qy1CDPINB/CrFqhn2Qdwn4CfpnLd2hgpBbcRWg7pp/2dEz+Jj44X2R7i1+DBE6JkB3M57NJxNKBXJKDrBXErQMx8lGJR7S0SxS4ZuX54cZxR8U0ibSdRI5txmDikAlvBqK4nFVkpEljd9eqmxnzrZjb7MVSFDge42l4RieF/RTDWTLLKD9dQv3Pba9/6IrygbJ9tOf3kHs3GPgvF60jmLA42aTTFgpv+QDtcoblLcYsH3y46ZsmFhzPcPpAEFJFdRf0SIdOSy5lxMOgR8yHbQ4cyQYZJPHOpdvvyfWT2Ea9tOf7Qgyht+jwTMRq2BeA8iythVaYE7ObgcE9/GV3hTJoNq96+XPrQITJ0lnDiv8F2NJUWHy5L+jOjv+rxJ+9gE/G/eHpkinw7bHSrap8n/Vpb4uEs3J2cP4Gf+iKizWGXTcYokSVIFb0gXyeFpX5vbkz8gw9H3+DGHMBamm+7mU7jv8HCR1oj9ZyJyQ3K/zFI5/K5I39VVz3f6bxu2XveBsMIWrIeOv69iL3O3Jzeked+1BhH0t2KkJPcvLJSbNRmpcwVgD5ybs0J632TtXSxYDpWz4KLbBisF2t4i0slRa00HqPJot/hJk7fUNZnfabPV7g==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199018)(36840700001)(46966006)(82740400003)(36860700001)(186003)(966005)(336012)(478600001)(316002)(7636003)(54906003)(86362001)(31686004)(356005)(82310400005)(41300700001)(31696002)(426003)(47076005)(5660300002)(7416002)(8936002)(70586007)(40480700001)(2906002)(8676002)(4326008)(26005)(70206006)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 18:58:01.2867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d8ba5f-0461-4c0a-814e-08db21995f41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8731
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 14:42:02 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.100 release.
> There are 136 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Mar 2023 13:36:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.100-rc1.gz
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

Linux version:	5.15.100-rc1-g7bc88ced9f27
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
