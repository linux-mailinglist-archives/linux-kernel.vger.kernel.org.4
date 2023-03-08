Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92096B09E0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjCHNwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjCHNwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:52:15 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8907DBCFD8;
        Wed,  8 Mar 2023 05:51:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0K7vtWoliZeenORc/TtorQWzaLZ9i+DkdpvF1z2SKUzF1D/ZbOF3CtGy2/2bXwyETKaGBfI3LOMgbVQMvunhuz83M3xhzd6Y/N8MoPN5GVTWgkaOnBZYlt9n+7x2WUNZ2YQCZ86NpZ9atGTof1hNU+cejjnO7qgYsA6Kc9mPxBMijeGN/pllRdBautsM4/5ygpyqI5n+BbVh4yTLc+tX9uRzuZvVTUQl1+ZAQG3WeCIJECSf9kmV1BOFinU98HjW3wTafS8p6FtmDcN9UtJmV/hmExZppkmTMXuWiJxSC+vkWDs8PlnnkQcHE1i3PpbU3CcdY9naaICb2+oh7iy8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClY3TUL37roBLG/WyBycah8+A8pFfESxHjna6nMYiO8=;
 b=RnZJz7sWPwkzfXkqSSrV6lpR02ZTIdYfUAQ73a3C1mTxAIiFkocQRYqvSzwRyM2OCfi/Tl+jw5Ix5QDnPkf1bmrElX9bvfLDXYXVf7lDYBrhIH5ZpwTGVkJeJcYJuu8Hmwi/3gTMNdIrleF8co8AUpdqNrs3OqoxyRAMEQuzCMuC4ZowPimWMfi1My49sV9RLIs76NFZ607JHqYOg41MXP8YoF24eZUArkurt5i0Bl2Sv9rqKnSy6qxdGR05c7S++6zgfx1SzqzdMiX5IWp55XeWd5alQNG/0DrDaKiTZwFirapM49FpkJxzBvyUX+NzXs0bPb/cpXOjWMw9o5j0Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClY3TUL37roBLG/WyBycah8+A8pFfESxHjna6nMYiO8=;
 b=szvzf2thBoX0mqk2FCuVGHfBDShVpPQhadNN7if9azNDGFLL+i8fRXhdxHAEiDfaM6uTVZQiNLwth0pIQ19QI2R2zc/pyoxW7wnPVZzYNa3UKcIDqH4bkpNjlmTiCWsFEmwtdO9nl9rZWQB5aAlMIzGelDYzpqOdzNQJjif+rkrItoJ0nsO1gp2gxg1iZn66NI4pmtlpdjSiXTiA0ay6ehmJYpQ3Jabugu1cN+hh/ewG1/zSsNhKNOwjm9C5e3spCfgWO4/DXiSGip4cARvTonapcek6IVMpPC62PHe1ti+aKdNoZIJBRMZinwsAmCQGgoyc5j/8aYlT4Ma5dJkZOg==
Received: from DM6PR10CA0023.namprd10.prod.outlook.com (2603:10b6:5:60::36) by
 SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.29; Wed, 8 Mar 2023 13:51:56 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::8d) by DM6PR10CA0023.outlook.office365.com
 (2603:10b6:5:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 13:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.18 via Frontend Transport; Wed, 8 Mar 2023 13:51:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 8 Mar 2023
 05:51:50 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 8 Mar 2023
 05:51:49 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 8 Mar 2023 05:51:49 -0800
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
Subject: Re: [PATCH 6.1 000/887] 6.1.16-rc2 review
In-Reply-To: <20230308091853.132772149@linuxfoundation.org>
References: <20230308091853.132772149@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <37ca75d7-cbbd-4d41-b360-d597e0e8bf18@rnnvmail204.nvidia.com>
Date:   Wed, 8 Mar 2023 05:51:49 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|SA0PR12MB4575:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e35677-45dc-4134-48df-08db1fdc4814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTbcb6dx8cRz3ZzfobNhHxDK4jyS/ceazUlScofUbia5NUP+us/UWo1boEnpq1TTmJ4T2IGghhPJSs90Ok6TZB/NwNUAhyoZmqB6lg7XW5PgQQi+zOjWoDFJZbJcKuq2Zw9Roblnn5A1AqT7sAb7p60h49KmRmgDJ65xdNySH3wSBidrC5879CIMSShulERf4hywdU9e4jLz+JqZ298rNlCPjMFIiXV4woEwlXgT4v2RhHWFTSxjuJiVwjSZPuPqevpw2fUEwGwVFgGKJMFv2RWmJpSg98m4vWLgVbfCwwSsjVPxeo92jEdgLAy1d9N2vmkfQJwH+bbWtZo5tIONeQeON7V6BrfYckKk9+3cySA94CosLERpZ95h7571Xqad8KzBmGgv+FRIHNw5SzQjzzGqz73xQeMKLNtfAyxsgOmFhnsNH0Igg5SrK9FTMNETw8UKZaV2P9fOSmGRbXe+blLZTcMMphFQkJP3Sr9mYeXf4k0y5fDkVQ6KbBDztqk1KYgPDmCol6gmwpzS2Ll25xt9hihIKYvj8bIPmAp+WI2i3l3MPi5vqCfwUtp7Y7efS3a4U4iqMKIPD2/8+gQ/ACdOVokq5+YtoWGWn5iuLegzE2K/gF2enjgJPfarhCY/WuuZiX4wjK5UvDpYMYgxsXH9PipQxjyYFGZvIBm9iIFswTTan6OgrjH1OXvnnsZQuts4Es8jRboJejgRhiDY8bZZfJ7Nv05AwMUKIQD/9daA+iCU9tJ3pKHCRQLuQCJV
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199018)(36840700001)(46966006)(40470700004)(36860700001)(86362001)(31696002)(356005)(7636003)(70206006)(5660300002)(4326008)(7416002)(70586007)(2906002)(41300700001)(8936002)(82740400003)(6916009)(8676002)(82310400005)(40480700001)(40460700003)(186003)(336012)(26005)(47076005)(426003)(966005)(316002)(478600001)(31686004)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 13:51:56.4206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e35677-45dc-4134-48df-08db1fdc4814
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Mar 2023 10:29:31 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.16 release.
> There are 887 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Mar 2023 09:16:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.16-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.1.16-rc2-g328c6bc301e2
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
