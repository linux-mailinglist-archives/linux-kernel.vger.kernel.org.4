Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452B364A889
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiLLUNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiLLUMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:12:46 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D0D17AAF;
        Mon, 12 Dec 2022 12:12:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHzavumvtD+HgAofhCl28N8G/LCahODL0c5Dx8CXryxrq28uAo651M9BXILgGoSUvctytLwgwdTHuyYe8w6Ep1axRAx9Ng8Kv3A9Y6RJHp5C2/uBQxcncY7piTslSOeYgagsx6u75upf1ucLASz7q0HzxWfZwuD/f76y4iTDyNkocVr4NBp0lluTLrXP+p6r194Yj4Anh5BheAwWqIWBhJHAV3ZkRVMs+492TEkO8QGYhe7LDgca3cCNIKVkV8OucOq0RMW2QeGSclQbgI17rOQbIJ8MDhIfKf10C0VLO3YZzP8U9ZIc9C6NcvkxnKgc8IyPX9mamczHzzWSi9mwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u67tPwgHyRzkBVBhS5KraPgN1ThLo1U2rPm7FiLot3Q=;
 b=f2XRgfnAeS0ixzUXKo8xLFabFFanB3HqbBeLLIpJ3VoNlEGhwyMb/NkK2+w+tSOXmeundwN3pPUoA1jW/+h1dt1sKxNXIRkNq9PAoSp6vD8rcJJfLfXcgkNZoR88s3QjAHDXG4oupQvmdGcZBwtFcO+trCWDB5taHg7Y9S9qIF4E7umkLyInnQ+HuX2zLEk1QoDeaqtwQDQHuHfvDEXxW71nBWbyu9ALJTN3h2NLwETrkebdRXHGtNwdq+gdSfgR29kIlTwBw0/e7hhRa6TbHNCEFenBlfrzKLagSIBBtT24XCILvld8FjeE5LuqcztpQt2htAs8DFgfJlss7mL3cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u67tPwgHyRzkBVBhS5KraPgN1ThLo1U2rPm7FiLot3Q=;
 b=gq3KrBIzTfgC3QpcwlD0KoY/NjoN+STVtrUx9ASC+OwMUHmwR/jhJju8NBULRGBmQVYT9butZFz1Go2/Uw4JUL/6tU59g4gAynR3vrpqEfe0JxUjzqT7XNXXw4BAwrtoSfaxsXeZfH7hJR1rI4rXrtXR0GmkX/tKFoEGX7wp4noO+HsH2umvr1Wzrz+HP56k9Yvtyfi6YI0sB768dRIAUpLReyPhUQsTyIWjrdoZXF4W/aQBmCjvqBirUkB5WApKLNoluTwKsT8N5dZwGUpG7PC9C1FyAyxYEHE2vrB3umny8NnwtEKGYFEY1v6u4sWGhey8Kkfr2sC1JzMb/23kBQ==
Received: from BL1PR13CA0248.namprd13.prod.outlook.com (2603:10b6:208:2ba::13)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 20:12:21 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::ef) by BL1PR13CA0248.outlook.office365.com
 (2603:10b6:208:2ba::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.10 via Frontend
 Transport; Mon, 12 Dec 2022 20:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.8 via Frontend Transport; Mon, 12 Dec 2022 20:12:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 12 Dec
 2022 12:12:10 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 12 Dec 2022 12:12:09 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 12 Dec 2022 12:12:09 -0800
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
Subject: Re: [PATCH 6.0 000/157] 6.0.13-rc1 review
In-Reply-To: <20221212130934.337225088@linuxfoundation.org>
References: <20221212130934.337225088@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <d9508947-b76b-49d4-9eff-e5be68ca857f@drhqmail202.nvidia.com>
Date:   Mon, 12 Dec 2022 12:12:09 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f9bde6-6bfc-4887-f2d4-08dadc7d2d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8GyVg+4ESMcgsCCcm51k+JQ3f55peA94Mdhoz6DeC6YaZhrPLzkWIUXs2KIg/SJhrtdyR3SVDPu8mZL0C0iROavxxLaeIPxYw2l9U87XeUy5bOdXdfImiyPYGq9Yma/fXvNuZV1vu6dDkwqNc0/aKAdlwxliZV0P5x47ObEluEcWNTQr4rWbdw+0jWQ7X3AUFZzTtDieldHsZMR0KC2cGvuK5bCBFVEYYuTPakg8F4+ErHLYmLVoO2RmXEk8tkZbx9U/uenxponap8tJScvp3Ps+9uXL+Dlx3NbiM/L4Xp1klKQOsUVanVMDK6pssrEzFJqV/UFW0FcvwPLH2B9XkyOcwuh0wXyf4+3Re4Q3/PKKyNmlIc14ZPcIIzS5JhjyAaABeFwnuHaYDPwI1UjUXswvw7Nh7NtrUWm+op6igdixg8QjPQWwx+qBAcHcegwf6IukHKsunXbuDGOy58qKABC74M1VMc6xdeYl662I7VoIWQvnulakgf8dzLAikaoBGV5rvMHtSodnnsC1NwLpUscgszW/TU+djI/+T2zl+ZnTyp/LQENzp+Vr2aXMn3Bra8mY2rIaDCfvW8nE+w7T5e2w7BIcEG1c9m9Ancqaq4VgLa/nl4+MCIvCpy8C+MGWt3/ZXTsTWW1BNqsjpr0kSLh2rJ7fPyuVK3LSoRnEypPbNt9KW9UIe93iCW0SVtOGM4e5wkwDXYa0FUY5AdabGjO+HU8mO4LTEGtiNX1dj7WwcyDneZWwk57bxMV6w2nKgGTRNg8RouJ1LaON8ntDqgan0zL9WCCmOT1rKDWnoI=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(966005)(478600001)(7636003)(356005)(36860700001)(82310400005)(40460700003)(26005)(47076005)(336012)(426003)(2906002)(186003)(31696002)(7416002)(8936002)(31686004)(40480700001)(41300700001)(4326008)(70586007)(8676002)(70206006)(5660300002)(316002)(86362001)(54906003)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 20:12:21.5125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f9bde6-6bfc-4887-f2d4-08dadc7d2d67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2022 14:15:48 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.13 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Dec 2022 13:08:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.13-rc1.gz
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

Linux version:	6.0.13-rc1-g57dda3cf2efc
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
