Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F11E66DBFB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbjAQLMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbjAQLMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:12:10 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECA920072;
        Tue, 17 Jan 2023 03:12:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFj8rdUE/+JMP1d006h+SeUzTMcurIrqg7Wx8hvor6CWobOO5ABaSNhRhhyuuyEm1Uk0x+KmxwF8Pv5+WX3CtGogZNLSdt3vh891M3dVmF+B5IaAl51GDgLN/l29oaLRUdY9of5eLBN30DvtipDZzZwwy9G5XJ/lAkwjLFMHtN+giMatlAaqcaw2uhHjsCwqOkHTxIMpjh9PhIV+fN8OoXweVXS/wfYb9ip2ZMb45wVreiMTlKZwrUfm094nBnkApeChsgVsdh/xiwOu6v13IWn4yz4JITCMfHroXeQfNAiEBZ0NLcNJ5n2Nvy8GFOhooYUdOJnDx9ZU/Ye6Tf+q2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cI5J+yHTonWgm20KhvV2MXiHp9AE9oE4AUGlW/qeQ7I=;
 b=KTWrpsQ6fzEwMPOp8Bv2dBzJPkKmeF6WLHPSQ/rHrZgQpFGB4BN9S9ZgmGlYxKd9jKCHPGs9gL4xYvQbcaPqfzg9LFrcwT3sE+SjKyxKWqJNgSomBZKVWuPFpN1yzIdb1UoitCKqlxrTsptBRvteiRv6Z5NDE7XkzmISxlBML4hzx3SPlzxALxaJZIXFe7f27sM9R4+fTXzifWMHkKvkiINIk+2dy4QgsNDUG2QDs07vP2TfZsiPekIAqziHH4K/+tuQWqBOV/3dDjGyKxGtKe9fv5SJhUmBD/se/Tj20d+1UBRmLTscNel82NNOiH7jpyLn9rxRBIy5B+z5pJOvXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI5J+yHTonWgm20KhvV2MXiHp9AE9oE4AUGlW/qeQ7I=;
 b=lTT/0c0QdPpSqhvNxdKIA4cHvniB7rCFnUQHf9bOC2BYDNkUwuESzZnTvztqQxkvC5EvEgTtVmnVtpkLqyEwfEunFf5yEDLprcxFR7es03wH0l+/c0RFm0bPWJG6sfo6hvDijCJdnLRgJjrW7WQ6fl14Y9ouncY2NXIc1XsdxSRA+EQCZONBdkO0UbXtjHsJWQY1a4+GBMv8EXU3xTH1XQw6Visvem0sfS+rvaK0MWX+1vVxlCSqxAEXxaA33rXLKsHIOc6XHHQzSKlMZ6a1XAHC85tW0iG6vUBB/1y5vuFTjJayXyxLoZIfqUWRmHPK+oSmwzb5SLnu/aOBVZmKDw==
Received: from CY5PR19CA0075.namprd19.prod.outlook.com (2603:10b6:930:69::19)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Tue, 17 Jan
 2023 11:12:08 +0000
Received: from CY4PEPF0000B8EC.namprd05.prod.outlook.com
 (2603:10b6:930:69:cafe::78) by CY5PR19CA0075.outlook.office365.com
 (2603:10b6:930:69::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 11:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000B8EC.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.6 via Frontend Transport; Tue, 17 Jan 2023 11:12:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 03:11:51 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 03:11:50 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 17 Jan 2023 03:11:50 -0800
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
Subject: Re: [PATCH 4.14 000/338] 4.14.303-rc1 review
In-Reply-To: <20230116154820.689115727@linuxfoundation.org>
References: <20230116154820.689115727@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <80ca4b5e-fd15-47b3-8d99-da0e367875dd@rnnvmail201.nvidia.com>
Date:   Tue, 17 Jan 2023 03:11:50 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EC:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: f8fc2f32-84d2-4222-a9d6-08daf87bac28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5fQynIQGXPy++DJINxRuwSo4eLLHD4vReSPpCiab8Nu/DsNfgATISQfhW85Gig4myRWP+E4sNDomVKSRjd11fvHGJI96snMNhU6eWBabq2YUsXmbhabqRd5ZqSg6F7CzOjxu7sY/NzT8mz+4cbLGHc0S2soRUVcTVNiS6pBTicdIaH6dCpC15rWKvaLrw+JLAX6citWYwY+SBbze2uCSwcXPxMcsYVHO7JPUSb699JHznTc2WA50sxIojxzfNegWEUsSb3dmNIQgMJvdUYxtlMK7nxvVs3Wj+gJbhEH/q9qazf2EOdbE0yqL90x8Su6OkElVNYtA8QgDMWNcEscLbE4vMJuMyOEDfkecqfMBgSOltneK4PSZgbkQ3/oL+Pdx/X84LWK6kwk+TQt3xFGPcU0n+YYIwEbB1Z5igoom7qHx3DjQZ84CL7ETim7s8wAiC8uZKLFQoK/ksI4z5OWgwzpECOiwqapslKZPkhdZtTqLxXfkyfFsy6qZI4QbvMBZJq9MHsdzINOCceC9uIs/xT+mp9jAnYB9WsATkiYxZX5P89ML3Olk8duMpVoV6qeHj4ca2IHA2rjHcCWDu42V5CLgnoQi3Gfd/MRtjRXwdEtDFbNE3bd0rKHR3VWq8t1lMrTPWlePm5Y5nMBNhLw1HNaVZyc0R36HBFljpxbAeFBSxnygJ3AtgDHy6kfEhXR3u4TQR7HLrNS7mor2SrhQ0hy/DdV0h/vQc9ZjeLiWSqB7K+NvWKPkMcK6JT5p7ZLSL7hhK4+xinQTlYGRQ9QqDgpNlA3nY5QJZCvuKtd1iY=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(5660300002)(40460700003)(7416002)(82740400003)(186003)(54906003)(82310400005)(2906002)(36860700001)(426003)(316002)(336012)(26005)(47076005)(31696002)(86362001)(40480700001)(966005)(7636003)(356005)(31686004)(70206006)(478600001)(8936002)(6916009)(8676002)(70586007)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 11:12:07.8264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fc2f32-84d2-4222-a9d6-08daf87bac28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 16:47:53 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.303 release.
> There are 338 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Jan 2023 15:47:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.303-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.303-rc1-g4e9c6da20b2b
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
