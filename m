Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADFB65C30C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbjACPdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjACPca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:32:30 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C1A1055B;
        Tue,  3 Jan 2023 07:32:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8PJwtK6N+vkrtzmOSq99KB4ST0QEDGm2UyzXUN4ROIxvPzAt0HMB0uqO811+IPmwd1ZVRhpcPGpP1viPG0aY1YzVXULWM9V4ERvNsx6Luq6rCm2V8kLWHSFJbUJpxC/drvFB4XvGzCnazGD7wjSflrslEro/eRdm6x3kQn1v7uyQmqh3X99KsaYnJ4eXTjTJDNhdcYbBgeyFKSivHw/zxMfG0UYtaK69BDpB0JFeUxUv2gvhNhv583eDyxr0HVo5ApFhcUt+4c5XYVaEizMonPqWfdCA6httCPBfJwgSGPQJSzUk8jn+nH1bIf1biWtgIgXKTJP4F9m51AibzGFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHpiwLVL6CYq7TR5TA2LwgTzST9jx2KZkviYUwKq3E8=;
 b=Ji3JFUQt17uMwu8svE+0YA5ynwaMC49IR2vCWHUTgOR7/BOzWR+Od6ZMlvylpB8omezR/Djo2G+YFME81FVQ9yLMxVbzNSQkiflysdMQrFfh5baNEOnwN/s+KbmvRlrAadStlZatTxVU2YGFZdQ/4XtRe4JJRTOA2/mpQF+aKwh2nRWUFVNx1Xo3PndZ+HkeW5FNkbmzOG11He0NcvnNQ8craciSOS3JVfK+uis9ErrmgIBK5OHFjcSZ5hYiOCfOWB2+rfbLQjwtCZWHyZPd/gp2p8NbrhnAFyKOpzAk2nigERUR4/AhLqe6QLcQCha5DEJ5y1FQkIUc54wYSrc5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHpiwLVL6CYq7TR5TA2LwgTzST9jx2KZkviYUwKq3E8=;
 b=KO0zCm+o4eVP3IbhsL71zi+9gKSUQqKV6vaXLRMBn2JJNr6EmrpdOn0FuQVy8ke5rUKyk2jqkQDY3a4Z1B5vVNoDeiERReVJA9782MX/KO2JOnMkyYC7fndz+jH7YdhhGwrp+o+44ap+wrGjF9aE2h8HdukPGQRLxASJDph43ptv40At5FjlJslF+zs9kVbkPgXoe09/Tijtq51pu8x5ZJoNYoIa5+4/FjdlsK1NTXPQvidiFuBdTHiZYaY8y/n6s0+cKYUlNmoGtfQ6QpHDzmHKHShUZOYO022WYdu1j3O/xSOfopLikN0v+Xe3h383P6BxGTTXFs/MtqyLQ1ec6g==
Received: from MW2PR2101CA0014.namprd21.prod.outlook.com (2603:10b6:302:1::27)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 3 Jan
 2023 15:32:27 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::7) by MW2PR2101CA0014.outlook.office365.com
 (2603:10b6:302:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.4 via Frontend
 Transport; Tue, 3 Jan 2023 15:32:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.17 via Frontend Transport; Tue, 3 Jan 2023 15:32:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 3 Jan 2023
 07:32:23 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 3 Jan 2023 07:32:22 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 3 Jan 2023 07:32:22 -0800
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
Subject: Re: [PATCH 5.10 00/63] 5.10.162-rc1 review
In-Reply-To: <20230103081308.548338576@linuxfoundation.org>
References: <20230103081308.548338576@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <31fdb008-b2a0-481f-a595-ba8ad6201c37@drhqmail201.nvidia.com>
Date:   Tue, 3 Jan 2023 07:32:22 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT011:EE_|IA1PR12MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 52822e54-f7c3-455e-147b-08daed9fb858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJwBsTwytjIjqFv2E5cudh1zJunR22QfO4JtCR23YCtEYgQEsOfJG7zc7AQmbZ8QtTGa7haKX+qd2Ea1zZjB5iCe2UxaI9j5grKKhxBlprD5fi1glmCpxhxsdCt8zAP0ZO/jfi+d6343mVwegt/0xwkdv90zkLnC69wTYlDnI8877KT3Hy3ExSGC/27nq1hisuOtzf38j3BORxtaJQTuZnoub5VYWrdZafIxv7Hs5Ul3y65hr4G13vylOOur9fT9kDsR7w9VBHZLJvV4lWQTkH1Tj7Su6RDCr0jBVdntz6ROiQNjlxkGdzJACGrfMFe13Sl1yRdzex+EJhNOnYPv7PakTlG4iRVoGY0BnkHxKHqELggidza0afm+lR3eXEHf9bEdCFxRNXrJ2aaTzPFkazQvSLi9jzfdf1VUZHv7m7Kg7p1NgrV57Zq5T5D0EPQkQZCGM1emoX8//CzggVA/G4sLiVcwb4w+XJYmGlIfWunPMM4LDASkmZfx6BemnBLrJE3kbQ/HSbf+hS8NasnjpCrWHnZfx+qGrCy9COTUolvK8OEx1nu91Mt8wyk7eC//t1s+7LiqHEbRS8UKlFdkGSHzLpBYj1HnLGN5w4phQF1Fu6tHVIpvIuoX2KnBB9cxtLDenVcTIlYO5rcjxpCpl9+uFtLLq9L1TFtr6w/umXXNT7a5sLdetl3z35BYzp9U76cfaiA5WQ9kgGMxlaPG1ma0TJYz4+nKLlwY5xe4zmYlcZ89OgT46VHYMemcM3Did8AhNijRYVDD1mGdqxZx7IxRw6ZNco1iC/BsuwtvmwTQT6AiZ4Y1Go/8221JXV39
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(31686004)(82740400003)(7636003)(2906002)(4326008)(70206006)(8676002)(70586007)(356005)(7416002)(5660300002)(31696002)(86362001)(36860700001)(478600001)(316002)(6916009)(54906003)(40460700003)(336012)(966005)(40480700001)(8936002)(41300700001)(82310400005)(426003)(47076005)(26005)(186003)(22166006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 15:32:27.3772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52822e54-f7c3-455e-147b-08daed9fb858
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jan 2023 09:13:30 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.162 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 05 Jan 2023 08:12:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.162-rc1.gz
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

Linux version:	5.10.162-rc1-gc5bc645ae6f9
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
