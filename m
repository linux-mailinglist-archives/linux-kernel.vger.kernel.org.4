Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933F7640725
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiLBMtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiLBMtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:49:08 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD018DC869;
        Fri,  2 Dec 2022 04:49:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZJFH+vKYj7I/Q5cIb3DY4/mIAVsPGKjDtyIxR1QLm+WlqaQL/3KN4TjIxzsNl1TWx57Bdt9bwnYarK2zHHyrBFGH5ujkpsrdld8uSBsLn1x7xPdYhBTUl/B/8JhrimuccUrYKqEHxbTEyElQU1RW31FmnjZLbZa4mW2TLhbdI3d4wxuP0ujVVjLbRwarHORMAuTZAKtqm04frX2xg1L3Lk+O9UG/KAzjqHTVDr1gQnLnTRIA7VeZ0Y8ublK6pjn+k+UKSCiSrO7ifeUKSF/pAknp35DUrZfeV6L1Z+LaU5s3CTryK+ec4MWlFhfIkawqAktQWVYRxY7Iyj9eP8xBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuaikIznK3jfr1VCd6A7joh07Sq2m60IbSz6ZBkDlCU=;
 b=a5PD0NWtHaa74ZAYsNpnaHV/ZgEc3GnYicuGvshm4QMCJZK3n72Iqm5IzrALG3RKQsuD6WEeT6A3sRW8drnQTP//vg2vonzNYnQUgrbfnyNn2nsLzRMfSww5vCwzdHzy156RLBiTrC7O/5zJkP4rX/1WdP3o3TBnhNH55a+zx0CCg9o/OKFMyA+rmVAtuhPmvfI7d4CdRgoYGvarO4rdRm5cY9KzdDn6+aZMJhAGCHeh9sZpx2Bs9y6Q2wyeS/z/YbTXPpu40cbvMxs1vwNApGP2zKltekrLp1QjSOBUtRoaTEUgEF5h8eVsjHZzWOBTwCgkeoBLp7M3ZBEqc9PIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuaikIznK3jfr1VCd6A7joh07Sq2m60IbSz6ZBkDlCU=;
 b=gcbVHObZ3pJSYJJeg0iP58qidiURdTEqXps7uysRBEA2qTKE71nyim/Mia8lTXxYsb4MEtVh+wUgPLxW3Y6rI+RXiePOguKEbO9pLchV25Tj6eHVKkxiuh9PwAsYAU0ecp/Q/MPCzU6D6jsYAAJJnctdjxfV+DdHwMV9zyzjQO91IFrvG4QyayrUqTXrdiGzz5/OH3+L1bjzbr2z68DQ/j+2jSUF5BisKOF1iSca1Hw1YqN4n/rtFo5ZYrDa6IxWO+LSdNalCHVTYde14jS6BfK67wzR8SpKOc2+0wFhSzf/KXZ8ZLuHhpoNJnszxbsJ3aArigwiWnIopQSMDNr5eQ==
Received: from DM5PR07CA0108.namprd07.prod.outlook.com (2603:10b6:4:ae::37) by
 CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8; Fri, 2 Dec 2022 12:49:02 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::93) by DM5PR07CA0108.outlook.office365.com
 (2603:10b6:4:ae::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10 via Frontend
 Transport; Fri, 2 Dec 2022 12:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.20 via Frontend Transport; Fri, 2 Dec 2022 12:49:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 2 Dec 2022
 04:49:00 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 2 Dec 2022
 04:48:59 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Fri, 2 Dec 2022 04:48:59 -0800
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
Subject: Re: [PATCH 6.0 000/280] 6.0.11-rc2 review
In-Reply-To: <20221201131113.897261583@linuxfoundation.org>
References: <20221201131113.897261583@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <9faca91e-0b7d-4343-869d-ffc0053e5273@rnnvmail204.nvidia.com>
Date:   Fri, 2 Dec 2022 04:48:59 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea8d56e-563c-47cf-857f-08dad46396f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHbnImyxgFSpx5TM/bxVqf/yRissWwE9DG2VZOYxUZ1isSbDC5mRLNocyRBg3/wPlMSqeOoUDCJ/8z/kWfz6R31kPW9ZnwSgfw6vUQlQI68DeyoK3Fegd/i4KWf5MguClG448UMAbNIIX+L+EXRTDFbQTKEXO0PXf4iswRhPjopKShWUdJG3fd4W8qqg/yMBdXUziXCLBnfKBb2AWhw2nJ8Jy5eF5CUAGPYb2PjAPFq2Q1dD1OnNbC5kyNW+viDpKLHs1SsQaBc9GcgW7kr4BEWYh+lTivtMBdTM3VYNqdkb4xzRtk+M69PrxGpNwjbbs6g4H7/wlhVjjotC5caT80BHioeR+9nq86w/WSCiNBiQgeSfQnz76pjks+qd21PpxExR+AXN08SZ6/66/erQ0/G3IDpnODxfOiw/gqCwnyPve5i136CYOhOhHXON3vF2TEE+FNUOryCkGvc7Si45yFoKTv+TyaDMXJgHOYVxB+aSJ8gebGuQhWjItUUGTGYEiDDvpsGyvVoLg9OYwiiZUIBT7GqfOqsV8GdGgy9Cmh+I/zf43jJJMZTePolRqpRgURQmeSPH31xEIhsa6rwJXcq5TOK1TkjVVr6VwiN0trEglabdTRf4lenL90NjMAwz2/4k7dL+XflbuPEeRNESymeAAep/Jbd/XVsz7c1JzCRdP6aJ0jzrTMW4R8MHB1I+t+AY2W1QR1g/xpTiKWQ8gE//tmsYnpiLkJ0HYUF863D9n3bz8de73Ghb7VXMfbjDihzBEiZVTtApfLf3F/8g6FQnWxbH+qaTfwJ43UvOCpA=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(7636003)(356005)(40480700001)(86362001)(40460700003)(966005)(31696002)(478600001)(70586007)(7416002)(8936002)(41300700001)(5660300002)(316002)(4326008)(6916009)(8676002)(2906002)(54906003)(36860700001)(70206006)(82310400005)(336012)(82740400003)(186003)(26005)(47076005)(426003)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 12:49:02.4136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea8d56e-563c-47cf-857f-08dad46396f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Dec 2022 14:11:47 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.11 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Dec 2022 13:10:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.11-rc2.gz
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

Linux version:	6.0.11-rc2-g7a60d1d7c4cd
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
