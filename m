Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C496B5072
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCJS6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjCJS6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:58:18 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7C5EC57;
        Fri, 10 Mar 2023 10:58:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJiJ3Y4StkIYRi5uR9oowvUN96tkerTKnPgNQgqiKsDTimGzJPfcb5o4zBIgPDr8KT/kbhZsWZnSSjer3nbaA+dFMvNdpjkwsA3vKfgfStAnRvXrcy8rRHh/Rq2+7yGAdy1mE1PX5SqM6JzGdW0eakIv0I399bR274/SkP5OsjTo2yMU2iPsSBzPoud55rJTylURC7RtmhXTFXs36EOQZfcpD5Ea3fb6Zj2hQHn3x2tJ4O3Xd1UEIQSbTBy76H6tFff5+BVfBmprbSgXaMvu9n4oSz2tK9/a9DyL7z8O/kiYfAmPwabjivvbJsSUAQ4kd7oNjUUYizisSL6LIhK+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWEaC2KDC9IITrhrrHJYySx5UjDzMjsGuGtbG1kzzlw=;
 b=gUuQQEfA6p1GrGKMsE7YPVFVeyporykaaACjO+pgXOMZIf22KrYeGZ2gYIwfFTmc3koUnO/L64QXeXz3LwXPziFg+1gxR2webs4UCZjZFR9wYP+9dHezrRUUuPwAoz9u5GLTGAVoggUqP5KSjahXiQ9/4f4Np42TUCt8wmo31T50U8NdMBhDM5q+wU+1eDrJLlmumy46vVCmg/P17x2nHulBZYOrh0JEAiyi+qNt14iDYEIMvwW/tJRm46VfL9VhqHTlESCujhw6hylveU2Ogfv/x0wjX/H2upq/5tg476cuacP1rf1q7dhGBdY0rM1WeLsYv0edxVwM/atUcbNOyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWEaC2KDC9IITrhrrHJYySx5UjDzMjsGuGtbG1kzzlw=;
 b=bX33k6xhRHU476BGWbLtOGJAKJ3xYxWhXtcQJ0GZw7UJZSboFBCwwvA2u12c/S9bhq1HG/2GVKsRjJb+ctjd/jlc8cem4zQr903QciVbzDp0WSgPTWt333hU7Cep9Jaf1ssDYB9es6qb3udSuDtyoxzlySvdNtIe9WgMICThp3UvkwbaxZJ14bRFgJMeuTPI3zsLEz7ZSyT0s/tsgmQBt1mTQFyh0ngv8FsErckh6iHmXz3fZKAzuBehnWjQVe7kMV58rC8ndYCJkaak+HuGzZeZyt1sx+83a63LKMrEHM5XkCaQuccqHat2IlQ4NzkvBYDOS8Zr9YLARNklLSuluQ==
Received: from CYZPR05CA0035.namprd05.prod.outlook.com (2603:10b6:930:a3::27)
 by CY8PR12MB7730.namprd12.prod.outlook.com (2603:10b6:930:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 18:58:02 +0000
Received: from CY4PEPF0000C978.namprd02.prod.outlook.com
 (2603:10b6:930:a3:cafe::15) by CYZPR05CA0035.outlook.office365.com
 (2603:10b6:930:a3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 18:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000C978.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.12 via Frontend Transport; Fri, 10 Mar 2023 18:58:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 10:57:52 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 10 Mar 2023 10:57:52 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 10:57:52 -0800
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
Subject: Re: [PATCH 5.4 000/357] 5.4.235-rc1 review
In-Reply-To: <20230310133733.973883071@linuxfoundation.org>
References: <20230310133733.973883071@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <d06bfffb-394e-4f50-9fba-da58e98a13b5@drhqmail202.nvidia.com>
Date:   Fri, 10 Mar 2023 10:57:52 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C978:EE_|CY8PR12MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 73148bd2-e988-4b3c-7895-08db2199601b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lk02/Of3iBR+iNCne2R8DWbaYAWCP4vjYWHOEpuDNKyA5NlXgVQtmALpUt6NAx2UJtNRsTW4X3hHAB6cNa0P+T70IDDPEhhK3X+Q2AkkdbAdZic/mf5Gx4uNiuaNJBmbP7mbWdxMbv8WTyuWN+cBSQIbKpeiifmU2otNv/2t5d/SWAlV42glO/aPS2d9LZYelw8qEgu+JG2nxn7icf25SZ4fkkjcPgMl9ekWZpBOY9yy6JdpmlO+ifuN1Wf6QFIcjUhIUAKLV8uWL+0SnQg657OXDziShspJsVT1BJybSUFYk4rq6QecT8l8RmLqg/rjQ8FRxx9s7wuZH1g6zwhVpQJOCRXDqPHzPmtcZH4jl2Yc6wi0SQoWAtPiMKNqW86zV7FOradt7MUrJMMZnPm+fwG48ObMKn2ytwTCzsTA+/k0CsfLsm/zelCglMTf0KA0bfHip/xkklyYHykbuLe44zvH9q13RF44ALWdFFN7aR24f1qyGsj1NT6ozQ6LKxuPTZH2cJUBtlB3FFpUUCXM/aBIwh5mGrtx4+Dyw2Epu6U49wqXWjHPBflSuQTD0svHwZMMZH4sSzCRSPXEvctdi0rmMOPuENMsqFsRpAHygUSqwpLc2GFMFza/+9SzMeFydmlxR3C/4Fpuxk7uchbP4sXq1OV5jhZAlaPtV4+caHuq/xxpa9+0EqSfeMM9nFL23DkxbMrQLBzF8/3ojQ/hOWSxB37/hViE1I1iskqVv+W+8HyCnD/ALL44mCGqMHgabPJInEMx5AUa4icpDeZc6BNBXmI7I4GiF1WQe0eAigI=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(31696002)(82310400005)(86362001)(478600001)(356005)(47076005)(426003)(54906003)(70206006)(8676002)(70586007)(336012)(316002)(186003)(31686004)(26005)(966005)(2906002)(7416002)(6916009)(7636003)(36860700001)(8936002)(82740400003)(4326008)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 18:58:02.8245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73148bd2-e988-4b3c-7895-08db2199601b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C978.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7730
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 14:34:49 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.235 release.
> There are 357 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Mar 2023 13:36:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.235-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    59 tests:	59 pass, 0 fail

Linux version:	5.4.235-rc1-g90cb39c89956
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
