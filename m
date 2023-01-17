Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E177E66DBE8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbjAQLKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbjAQLKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:10:17 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD525274;
        Tue, 17 Jan 2023 03:10:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceJv9cdeFBS8dr1sacI88xphpTD+Hz90XuycyFqMJr5ew2UVh1Qe2N7fVHp9zdD5d29vhNcCq73QqvqwieVrjPShEoelYqchQPUxFAODjrlfRTP6ewARNySg4tQjlSRJQV9jfzvJQerVS3M+FaHpn0GN1kh7l9U1g2J4BDGbu0lbdiEBwrFZ3qh5UeZU3CUkZ+sQvHF1lHY3iPHVLWCnQihjit3sSARJ1ADfqKqhz19F3pvWZislrmxbV/eOakY7O2v+INqcS0gxak9awueeQVmDXmXpjnVw5G0aBXZ08h3CvgFihvnoCf7e/qAmHjq9/YTM3DBY0XR14xeGDZVvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wjTB0TsPY6RWYm36JmXjczOkZeXe9waFQz+toGvo80=;
 b=oKOPz/XUJp8MzF+sgEeThQXQyO8J2aoXVvqlr80pxdgukuLh2UqXn2tHV8XyDP92hI4T6BXy/8vjmwoUMXWIowR6FGAInfv3prr9rPfYCY08fIwellKkcCaRkSWrEoyO6kR+lvQvuzDmh355d3+JepfVcGr+9ujbFXHoVz/zLIjogJfWgGDxBnVtnvEyLZ+VvXG0S/oNxT9CLjjCvF7ZTS1lDZZ7ExRPN6l/gbQ+HyDHTlmPf1eNCgJakgiMIdrTnkcIbriqsZ7vMI3VFPQirRqx033DZsnrpiHs9zWMBao37HTJVqWsQedz+soKd++2V8tPmXpl121xb7MhyKm7qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wjTB0TsPY6RWYm36JmXjczOkZeXe9waFQz+toGvo80=;
 b=d3pcvdVQr1PcQI8EDUXR/bUr7g8mad1CAGjOCCxKg1H1j52ovozxDdw3kQnKkz95mH+oZvJA1rXlpGejBx9a1wTNPMIpfVBmvfJH9lVAxCOTrYVH1idpLlQkK0QEtqv/w8fzoWv9sTsGFoIXFFYil+2LDlXo89zAIdySw2mimvrVXYX3fa6j7QxNjXRC8aj29JmcYd5SXb6rZV0lK3MeRMuE7MLBMC+UKZPrCBx2RHdSIxKaKyBBUdR6JgdVLuCMciaXtlwCfP8MYFSh8CV2Cj6lYB/6wL/1DtQwbwzlf/F35cZYYd2mvbfCNxr0SwHpxbiax9SLaQ891xG7SFkYkA==
Received: from MW4PR03CA0229.namprd03.prod.outlook.com (2603:10b6:303:b9::24)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 11:10:13 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::16) by MW4PR03CA0229.outlook.office365.com
 (2603:10b6:303:b9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 11:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 11:10:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 03:10:05 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 03:10:05 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 17 Jan 2023 03:10:04 -0800
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
Subject: Re: [PATCH 4.19 000/521] 4.19.270-rc1 review
In-Reply-To: <20230116154847.246743274@linuxfoundation.org>
References: <20230116154847.246743274@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <6a7dc8de-7974-43a7-906c-367939ef6df4@rnnvmail205.nvidia.com>
Date:   Tue, 17 Jan 2023 03:10:04 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT019:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed90515-d325-4d0b-a250-08daf87b67f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: damMArH5VAE31nEVLsiYNaL1ggkxxAK/SjkRcHO0gXtli9cguemSqccBP0zOir7RjkvxzUcXD1EOmmbZ3FpLVfm3xYS8FJ+MGc0k4cSHgt4Ow2VK6OsM4OQPx0ZzbdmjkNQON0u17FlvfaCb9e/ubKTdNvEsAFqowGxRC6XCyJW5RHKHfB8uU6Vt5FBSFoHeHGPYWBiwoeHr1KJ8uDvF4J/InOMVBzqw7493wtqIHop04lU7xnv/jypx1/F3mDU4hUrnAKUa1nI82yI6jFxDM6AaWYnl7oEd4PcdWh3pbs6GOXUu7prItMv05BAPqjv0vnVwrC1ZHiXYo2Fr6G4/cyxRNTav/TS0tQjVRPYfiKz9DOy6BQ5dPobGBsNVUJ4j6lIUkHf9Lm1JpEfiBZlZJEp0XUTb0R9a1DUkzoWuqv+L7wpfBQ7zAkWeILuArNrsKBQjsuKJXi4DnMlo2MAJwdxY4T0//qfzVvMjQrc1w89XTlaZlWalFLwKuDowCz0AcX9jTWrXH7VtHY0PSfV35ibgor8Dm7A5i+g+LWcj4KWfZ2ACDx9QEnACesCXmWRuG4hx9Nzsp41jCPq1B/7lg34FeTqD78PUttZggUZGuyw77QqiakaQn8fAfasP4e13JLVD8Lix5lGNQ2x6IKPHp0/gEKulmT70ZY3s9gOsIXb78s7zrxhrVSmfg6sgCg/yJtPEpKEUcQqEbQQwOFfudq9u/FG9hcR/izGN/P1JYaaJ9TEBZbfJ83GWUcH/EYNcuM+O+KGnW5aWARpzQqDnBTyGyXip9QSDnlz2lNrSVNc=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(40480700001)(31696002)(478600001)(40460700003)(54906003)(966005)(26005)(41300700001)(2906002)(7416002)(316002)(5660300002)(4326008)(70586007)(6916009)(70206006)(8936002)(8676002)(36860700001)(186003)(356005)(7636003)(47076005)(86362001)(82740400003)(426003)(336012)(82310400005)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 11:10:13.3666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed90515-d325-4d0b-a250-08daf87b67f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 16:44:22 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.270 release.
> There are 521 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Jan 2023 15:47:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.270-rc1.gz
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

Linux version:	4.19.270-rc1-gc75d2b5524ab
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
