Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEEE669875
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjAMN1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241062AbjAMN1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:27:03 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A10718B8;
        Fri, 13 Jan 2023 05:18:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1Prq/kilpXSQodgxXgIgMmrECw8uHmFFV19ZOrjbv6Tf8XLQxAxE6JePVsPyW6T5FHHCqVhNgByIVtjWYAs0SoB/vv/BS4RvPvX8YfMp/bSX0HMsCGIdXY8Jtz2ooi8YvXT8kK3/flXbkxOdLs5teSw05zPYCPcXUxa4/Q9QgHncnsZBjRo7Db5X5h/f9dYO0KTHS27NszEoOliP9z3Rk5nwMFRWEoHgdAR3hxEUAbVOVODXTlOJ+yfnFSs2DQNYhMuDqAdyFz3vHnkoHr7Fxy8HuiSlQyJYKp5Hy3wua51QfkLDEb04xZkAYCqmAmUajb8j8YKIYt5jB7SH6OwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu7AWxQ1G1PleCN36FNclGiL5hHA24jl0q5xM7ja9Cs=;
 b=ne8xm/0rm4svbphG/gJd/sgF/Bhw1rSE7KU58Mv7haRGSQJqS0d52Bkir3ypFi0iojeXWRReG+f/cE/yKHNmDxb6g5mALyXiZ4eznMVFnVtgOAqeZnTJFzBCc1DgmmfyZORpnmIV1aKFPs8y3xj7/0D4euU523XSLP+AqI2MSkP/k1Ee2+BWB3tvEzWwxIDsirnrfsOD4V2KOj8600onsIPjMhN66JAZTYcJ2kds0dG+dccVYqxgj/IPUq+OhnFalGPMD+KftgejNdQO3OtGysRRuiAHqwql5w76OhVRxLkoP6GEYoOSMrE4bScAOSdU1z8e/leLnveFCZ1KP2UaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu7AWxQ1G1PleCN36FNclGiL5hHA24jl0q5xM7ja9Cs=;
 b=qWmRAViFD2ZXYV4ZeceVMbCtgqgPRgj3Kpm+6x5Tp5+BJZxYj8sPtAKnNMax+kWurK0LOuf1vMBpxkU7VPqjqylHzFZ4hlC4z0xEoutnNEf0Zl5IhkPJK+QRkOfYPrRa3IG/5auiExb9Kg0iZ19Vh5vYP1Iz7gc8Zv88MU5kV6bZqnJeKIO3SPmpviRBOnoSHDL5jhh0lxHS6b74/01q1JhhOVmmIuI59KW7lnGmjxCjYUUiDjHotyeywnLcFAqcQTOLsFpFEOQEdYwoDAyLjmbc3eUAaFPSobW0Too/beVSPzok6NDTvMmzOF6YcXFQqgsUClexEsWmUW610n6tUA==
Received: from DM6PR02CA0112.namprd02.prod.outlook.com (2603:10b6:5:1b4::14)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 13:18:16 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::10) by DM6PR02CA0112.outlook.office365.com
 (2603:10b6:5:1b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 13:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000B8EF.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.4 via Frontend Transport; Fri, 13 Jan 2023 13:18:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 05:18:02 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 05:18:02 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Fri, 13 Jan 2023 05:18:02 -0800
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
Subject: Re: [PATCH 5.10 000/783] 5.10.163-rc1 review
In-Reply-To: <20230112135524.143670746@linuxfoundation.org>
References: <20230112135524.143670746@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <5f0d06c7-9da8-4406-b205-8547f5094e90@drhqmail201.nvidia.com>
Date:   Fri, 13 Jan 2023 05:18:02 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c273fb-c9ad-4d86-d79d-08daf568a10f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vUSLsq8+8JHZu+i9sAfdufOiuLhKp+U5lFahC/CTB0yYTF6t1+4cut0hzV/GIqOPrJgBFAbrcDkotD0HEOfOqKBV+oe4tUiFwy7DLQKWKhGjW4dkq9ZXCGeXog8bq/B7w/zkqnszD7ywyzuK4v8V/44abO6vU89gC7peEuVzdi/pnP+BESOQe5MLMEG1CdGa+xVMwXElBtfWIeASVBmXoLH7btgdvipk4vZm6Mp8sY6K9ulvJPHcHiDSpWyV23YatsF7ckdeHv7oshgoIMOThZpIXGgK0LGPuVBrANk3n7PoYUxPyU9XYT9yYzZeFr8m4UBu0h4onpvbggk7jcnDx03jKSndA7leNqUzcW+JIDwWzpQtaJoEVxsV30KaJX0U0OlbAlDgr5x0pc4AEr7etqjkXgbFGPs0bVZo4C4F925XLXJDGza0zDMY8A+l0w4osa2gpnQTxB8fOKq0igjxS2xYESGsgn2uJRguV0XsaymvSuuXAza3/95b0GJajito9wxOqty/7Jt1tlQI8d8bvnvEN5r84xuemJ2m4EElgjQ2yi+cFnqfNnBPxQ8ODoVpDvoxQareQQewJ9maSkF4R5LvNlesKcv5fnrtPMzWaFasNkxHk8Q1W7lEqXv8IEpv/svBO2ziKnfEZ92AMa7dUYGmKcn9raKcOOmB6AZJIEUSJgaofOdrD49S2HXSDD8l8C9wX79XDtgJuiPBUBAPiZcm1oZsrX2yuxDZERm0UozNBeqvrBbaQBiwaxkODvzrvNsCWRq3Nx6hAA0h+6KDJcJVofl5V9Ku63gkAN9+vI=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(5660300002)(7416002)(316002)(54906003)(82310400005)(36860700001)(336012)(426003)(47076005)(31696002)(966005)(86362001)(26005)(40480700001)(356005)(186003)(7636003)(82740400003)(478600001)(31686004)(8936002)(4326008)(6916009)(8676002)(70586007)(41300700001)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 13:18:15.2826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c273fb-c9ad-4d86-d79d-08daf568a10f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 14:45:16 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.163 release.
> There are 783 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Jan 2023 13:53:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.163-rc1.gz
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

Linux version:	5.10.163-rc1-gd33d55703c78
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
