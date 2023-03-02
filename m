Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C54C6A7BDC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCBH1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCBH1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:27:40 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02hn2203.outbound.protection.outlook.com [52.100.158.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F725231EC;
        Wed,  1 Mar 2023 23:27:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNahWxqMDJMyuSY0BPYrKf9S5L6bs9IEbxXyVw43jtXCQh0pxdHLtxtH2dpuvDEVobiwTdZBThRgjYkLIfeVNQHJR+OyAzFcIuvDp5QDzFKBLWZTtUleTwnW18spYZWaRI9W0WEG9a5Q0/YvcHOuygSiDNtq3gJ0MSnwxkRDNuxmK5pyLUeCQGXnbYfm6L2Ak1X21y4OqvM4SyQ0BfWYnm/bjScdXwizaCidGbFj6ialDnm+kCxi0toXrg/T+LzXV5YSAS/IE5f0kLn91CBoaeQJyD76jr/IXBGqAxHcEF/nIbueaJyJT1o7JXPGr6Ieitkl+J5+pWFSdtmNLrQ2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guPJ+aYirjxTaFCtVdtiF0VK0QW56/bjO+iq0M6hVhg=;
 b=hD5aNpYSw9S2/lXSqtxsXzTVfWw1QzwA1gp1GEZaFCQzdkyM8ADowuUdDTvpn2D6v2mOPGL6g81Foug4zOzoXOhDI4+HEdWs8jAH3ww00+9awA5EpeD1umPrFK9NlAM+Wi4tTTWilx/7ZaeOtlurLndWgbBgaSPqrMXyfrGQ1F1hvZcvCtIcZvhVbiU6iijPj0nHBpuaBuf+VkpObRJRgVhs3gWFI1LecmkragQnl1PtFs8uzVwy9drVUAaCztkoYk7pl3JftOVx0rbvyteUVrgeRbiOm5xTw8uBP8uD1KJNdx1pwo1u2nppkEO8dvQ0BMlBSpaB95D30XkNLkWPZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guPJ+aYirjxTaFCtVdtiF0VK0QW56/bjO+iq0M6hVhg=;
 b=UNK0AxL0hgLUg1S0S319qPZDMpnF5RV/q4M7yDHIjwOBbWEwftN+gwfEEXmPe8waUMTXLH/iNBQ4jscCk6AY8svSAi9jm7KK/kef/k8l5Laaxa7UeY6CL+RC9GWt6f5duneWo4keudRdof6UlL5TLX0p/o6lCIjGTjwSEnsYUOWaCj0YiJ60kKSSC67dGqPodSTIZH71X1goG/QARUDEQwW/xoutbDU7szplFv7F+HIeiUyEMZzu0srLSDNk/u9IPdXK/qRmuyZ9Z0ffZ9b9tI9FLxAlD0MtYE7UD3rTZgOaJcU9WhTzEW48CPqkH5n1+N9ShxXpPMV40OcpX7XKLQ==
Received: from MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::8) by
 BY5PR12MB4934.namprd12.prod.outlook.com (2603:10b6:a03:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 07:27:36 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::3b) by MW4P221CA0003.outlook.office365.com
 (2603:10b6:303:8b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 07:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19 via Frontend Transport; Thu, 2 Mar 2023 07:27:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 1 Mar 2023
 23:27:25 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 1 Mar 2023 23:27:25 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 1 Mar 2023 23:27:25 -0800
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
Subject: Re: [PATCH 5.10 00/19] 5.10.171-rc1 review
In-Reply-To: <20230301180652.316428563@linuxfoundation.org>
References: <20230301180652.316428563@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <6fd2d58a-94e2-47d4-8e16-6fffd886bb8b@drhqmail203.nvidia.com>
Date:   Wed, 1 Mar 2023 23:27:25 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|BY5PR12MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a7efa0-bc83-4989-3bf1-08db1aef98ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjTNxrCaewYT36aJK55aVAVLndCoYT8MmDjX+6qy4DjTrJQ18LgNOpe5ZxaQZQE4YqsqlC0zL/h6jS6AMxiA6dmk0Fxn4NdtgWKJZygk53lUgPl+q4xtxfprDtHPM00VkU6AxwCWdy4kok056lOGOAgsCybTX0UGggR/T5Kx3AO7eExX2VCUB81yzX68aONaou6DLLIiaY3dYgZZhGT7L5+pI9EUYgsNRic0gCUuWwoz3TAB8qTrHeT/wu+hSp/6D7sYsg9b4JOTeqClGArgPITtf9Sg1jMtjVpq2aJ8Otbbq354qL4FaSO1rOLS050E42SSnmXqBfkR+VK2D05yiJtXNP5ha5KIly+Oo4pRWsjw0IPQmZ1Tadv8M0maE3Aj58HPpCtkooVESjQvFsaAhEIiKbLk/80efukBPITkRozNMgLMOqW1R6QY1kf8xTnRPw8DCKJDzhH/CpqukKdq2/MiH8TaWb83ATCDgEtFolGSr/gK5Ft/aa7P+91R4ePU3CuGrobAAYfoYTQRF4lqSUPNExRtdMcjR8/C7e56H3hDGBPacXgWcSz194etcr6Ozpv2K3SzrwB4dqcLL8zT8J2z4FRw7GzJNVqizSX2rsjM+zVZ/daFY03eDzLdjO1bWL2lS7h4TNK6u9WzPH97BuSx/KN49sa6G5uItStcc5RmIWRZS5AAiUi5gEG16Cuh9ZKtAY+jlQSeGhM/XQyds6CI4BG/L4YwK1PI54+NLsLFW2p9ypCl7vu/WmNqKJKJGpthTuXpC63FroScaOsGYJHlIqxUA47EapAocoQXAfd+Gxzoi7T4DFEIkoZJaeAT
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199018)(5400799012)(40470700004)(36840700001)(46966006)(966005)(82740400003)(8936002)(82310400005)(86362001)(426003)(316002)(336012)(31696002)(47076005)(36860700001)(34020700004)(41300700001)(356005)(54906003)(40460700003)(40480700001)(26005)(186003)(8676002)(7416002)(4326008)(6916009)(31686004)(478600001)(70586007)(2906002)(70206006)(7636003)(5660300002)(12100799018);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 07:27:36.2828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a7efa0-bc83-4989-3bf1-08db1aef98ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4934
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2023 19:08:29 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.171 release.
> There are 19 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Mar 2023 18:06:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.171-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    75 tests:	75 pass, 0 fail

Linux version:	5.10.171-rc1-g032c569d266c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
