Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D259565C309
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbjACPdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbjACPdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:33:31 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F22D11802;
        Tue,  3 Jan 2023 07:33:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+STTS+xgPZaP2Mz00EL8caZklQAZqyE15AHrSAeRdT+MYBD+IuNjRUoJM6eM2N4l/nzVE8Ofyiuw6PMuDAhQPVHVCti1I7Acvb5zYhkitv0Q1br5Ok56wDzq/128g7XBwAO6VGRpegVCdRDdTLigY8Q+6suIL6KuYYIEmVeYPtrfVznPEckMN3GHn1o+o2MdLULxYm+OmNe58I7Vkpkbxh+dR+v2w6CWiqEWZvu6cY8gr1InH6PdIeK8DOpeAAHcq/yre51I7ZakMQ117GwjtjKSMWMhNEbZo1CI9Uus+XeY6XxgTTYW/O62vV6nkqLaFFBLpwjsW2esjIHSwstMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQapNy6LHlvEa4G3NmYzJbBOn1jikJqbOw2PJ7qcBhY=;
 b=Uzqd8Tkzp6poX96pTKAt2Fbh4UFIwULt5IovBGYT5SA/rpiio1UUJb4VAFD8IKYwsz8TTRoks3BPrHJQshVnpJ1dRaVfLW3iGHM05hXpHwyGgBTPfFiUYcPyFYL1YMdPK0yF765fPpQK9zL7jXISbhvRQke123IFCYjbYYyr3gBiwd/nSfL0xHazQyihr1DmHvb/FcM7tWc0vyTiQCGPmFdi9a4BgRjfgqX2cUsbIX7Jynjgogh/RUZ8jS4KTY7Tbl81XU93+dbG2RSQJ8m/kKrDGJAuS4me2gV7cowJD35buJGH7AjhAqVe71Sv5ffpGZltw9oPcozbF2DUsremQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQapNy6LHlvEa4G3NmYzJbBOn1jikJqbOw2PJ7qcBhY=;
 b=H0D25nYbz5KGMiOapEyzj1adfT2S4nJqMrK4uVAxfYthpZcpcqngadYZevzCngQYlEpa8XHAugOyca5DzZWNi4BJhgmYKblG8t03Qh3PmgBqd5B7/EonfOafv6Uhcbf0Eh29mNeg0d3TkqmjNYRbOUjEIJW4oG0iPEgZ0/rbDD6pJcrsnhTQkckr9uUR60jGpar2oDdnV/ElDZ5zGowZBRhF7PeCSB2lSCIzHXeQxaGI4AWcM5HVcm9Sdd0TJB4M+FYGH6LdCAAzMkpt9gBVKvEVarQbYl4xhh5HxBmQQ9rx+C1RFiJLIpkjDcI56XBaLML75zHl2dh3zArPW0nNCQ==
Received: from DM6PR08CA0015.namprd08.prod.outlook.com (2603:10b6:5:80::28) by
 CH0PR12MB5169.namprd12.prod.outlook.com (2603:10b6:610:b8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Tue, 3 Jan 2023 15:33:29 +0000
Received: from DS1PEPF0000B078.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::2f) by DM6PR08CA0015.outlook.office365.com
 (2603:10b6:5:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Tue, 3 Jan 2023 15:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000B078.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.8 via Frontend Transport; Tue, 3 Jan 2023 15:33:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 3 Jan 2023
 07:33:16 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 3 Jan 2023
 07:33:16 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 3 Jan 2023 07:33:16 -0800
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
Subject: Re: [PATCH 6.0 00/74] 6.0.17-rc1 review
In-Reply-To: <20230102110552.061937047@linuxfoundation.org>
References: <20230102110552.061937047@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <2428f9bc-1950-4af9-8e59-7d2b17edf9ca@rnnvmail204.nvidia.com>
Date:   Tue, 3 Jan 2023 07:33:16 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B078:EE_|CH0PR12MB5169:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d1952f-fdf9-4b24-a884-08daed9fdd17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5+h87Es3fsecpL6udK1s/sMFl9chnH97Usdge0hUD99GquNG9jMc1lFWU68EeQDexxwXG5vfEy6zuxcf93hcl0AP9mj7TCREWEk8a1YiHuRAc9dX6PwHBmVVnDBwgRZk0cdy/sE/Bx2PqeC9k8SJ8Ep+7HIej7sYMFCfUna9Wvn3+8/41ffv7RYaX7pNk6K1XDISwd/hchuzUBzZCIgjdCojmqRjfnBAo2DY282nNsMW7ZDiF+Ie3yq9fuS+TUWU2rGyMyRb/pQ8a7kMyT3gw8RsG7xuEr7oG2R+hB7PjwM0kExXuP4z2LlQZH6M9+rGHZj4gX7LczqH0869iw5vqn95+vVcMRDJW4lkvAoskGBvqe7Mq7vYzKveyGxM3ZQH/2OUTSVj5+FkyrcOYDTo8P5ff8wC4kqO726CUe5Ce3PlMazWAbAuBcAl9mbtlb1bufPmRvoJH3uwQpnkhd2rOwh1m8AVj4jvqrcMagG2Ia4FWtX4McOuLp6Wt75fPQbuVtzeaXrOcKkuv8olJ8ONeiWErLpcsOT9Wi36NVacdzcSGTy10QI6RHlNKbgs1AnIcxjtZCI227xMTe5bZTB/DzuEZGR+KjJKZ2+KM1XycoHb4Z16qA1fDbf7mtb3M/TGnMflfVLP0OFeLiseBk1kD6uRNnva3MDGm0uwUsgx9MagTKlJus1fUrAerRKgmJyK5LO/CKxF4ksY62t8dd1nKTY//9nAf+VSJ6h5fNIAA4jHBT3PbL5vS/NO6Rwxjp+GJEQlPsEioqGSapTQIhgpa9hDHVZEKfHu3dp3EyLIOzl3C2VUXltcyij6potD4HZ
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(426003)(336012)(47076005)(40480700001)(86362001)(31696002)(40460700003)(82310400005)(356005)(7636003)(82740400003)(316002)(70586007)(54906003)(2906002)(6916009)(4326008)(8936002)(41300700001)(7416002)(5660300002)(70206006)(8676002)(186003)(26005)(966005)(478600001)(31686004)(22166006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 15:33:28.9682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d1952f-fdf9-4b24-a884-08daed9fdd17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B078.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5169
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Jan 2023 12:21:33 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.17 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jan 2023 11:05:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.17-rc1.gz
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

Linux version:	6.0.17-rc1-g9c0ac88985a8
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
