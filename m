Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9604C6FC7FF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjEINf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjEINfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:35:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FB5E61;
        Tue,  9 May 2023 06:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/jhmAevHfsMqpx6KfHBmtKcuSUS86pIXA4uf7h28uSuu0OuuUrr6AC0TwXCgVylOatB1hsVEWeD8TntROIqSfb7RP4yDj0OKg57BKTfYBgvmdpLGhScgdzd6YNwbzySPdCGsWwBwQWvOK6Br+l2El1jUuJRvt+nTYCyj9sUha7+yy9UsetVwQoQZjwc8/tbC6h24sJL1DYslamTjzJcW2JL6o6j9RJiybvH8/H7HN1FAFDsa0dqdRtr0BrusYvGtOPlHRewLe0oqNvybZ5Q/F1LPilSCJuW79lk9bTq6MViK/mbqv3whXdvOFLAunm3d0oX2DLbUrTLeBXtz8ZWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkDXg4V0LqBP51xPIteRqCeSCVG7an4UElY4AmsqcHg=;
 b=oZYHsNOtvfDPuDzO9E/IdY8LHSDbeS8kf5k3WEwXxT2q1+EDGPmrTt6J3Pubq68WIVl6qRwSA2FvngKc3cx7X52zoonZahcIHmwUgodswh0n7GVByCO5qC0l2iCB8tMCCMXElBKPgtgIm1tWIpibw9n7pSQinvFaySttiwPxOyWu1lrivv2rrgDsRQkE30ysu5RcVbQpU1oEq0/0jZWruSqj2CRYlFM32ga2yqTfD67BNSatU2R4dd3yJ1d8d/C5DqP3pQe3Wo94isdkq5KAcHouvR3BPQ41LyyI1uBpjizfecs8aDsZ7Zxp4YT/696iM9PEH50V5YkGSBRvcNsOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkDXg4V0LqBP51xPIteRqCeSCVG7an4UElY4AmsqcHg=;
 b=cqdGt0hTleshqNmnqz3fvZf9PGMHYysDnoS46hOYSL/ekWdG2z+k0TTRPqJEvZyjiFbfifLR3PgTwGjxBkXjZ7l/ikHVjtMXD2hfUeBVHJQvjAb9k5lMh/AAk1XCHKe3LyJthTT65k775kAlASRJqk9joh00NK1P0DTlUxwEJmYJQ5oI0FfR2JY2C8hdLomzk40PqxKFnvcNwrszmTR3Pe1roqR9mVTpv8VxrdLqqK1ICsWE54ji4kfAu8BW1/S4MprBxGUAaw0OUnDs3Kw2NSYUpkqFD3trP1OxceqHhRY1n4bhDCP67AN0CIZlN8Y1fsruPfVdwkx9a89TA41XOQ==
Received: from BN0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:408:ee::11)
 by CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 13:35:46 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::74) by BN0PR04CA0006.outlook.office365.com
 (2603:10b6:408:ee::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 13:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 13:35:45 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 9 May 2023
 06:35:31 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 9 May 2023
 06:35:31 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 9 May 2023 06:35:31 -0700
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
Subject: Re: [PATCH 5.15 000/370] 5.15.111-rc2 review
In-Reply-To: <20230509030611.521807993@linuxfoundation.org>
References: <20230509030611.521807993@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <da955ce7-3f50-49a1-813c-c89d2917a58f@rnnvmail202.nvidia.com>
Date:   Tue, 9 May 2023 06:35:31 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT017:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: b48d0ba0-860d-4035-9fd9-08db50924af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLFy9py9OQph1K6vG0CrahatKaoHzaDY+hgJQpYzWAPdmqljGOGSbc8XFH297aunzrxAjpCRHZqQznVFI54/8lJ5wSsWZ2lPTHUN4RsG9gVOYiVFod4Wobv9oS1sUOhHJEYDv4P6AQ1peZ3CUduY3JdSRsJ8hIZF3DoVAPHQowQ8oAmWozhcoeVp3pvqDStoAncrcrxrSq6y9wzOFqoftTZUmYynQHNr0kPwuInuz/P3rzAtaz4daPHWDk1E+qMJ3mjnE7DVYEbLvWWNaexPTzYlHLlXlfPc86lm0Ql8qns8llrcvI1D7qkmlUWnRlDuSQsyRDixMiWC5EGQlSOmCjbSWQojTaAcYnJku+UzRtGI62mvzQ9FR4ZDGCA+uPrSCwM/AsV/HuCkxMzeNWTOaUSUTmEiNlqf0EaO++RniDgQ2vYD6VkqtMm+qEe2BoaA/pZMEFLU2iNpx4rGgcDGYZAp5wED/wgthRhECbnlAuPPkTRtWb++gKEAC6vveNuj6Cj4aDIIQT0rbNlFMg+/CN3REDwMDYOdSSveTTH/Ma+2ZDEpT3G88tnVBrk0nT3uG2ToCPkczM/XApx2xcax3cQbzJzXGwr8/FAW/A8nfXa1I+WNxJO5j1Wex+sm3/OSJdwWcCWsIxqd99zNBiJnJXKN9yy2GFNTf8tMyFnIZqJbEE94odVTpgTS25a9ojUPHkjHgoxlhzqDIXr0wI07azdChLy+aqUoWl+xKRnxfih/jHaytJ1p6DD9Fzqf0Dr6
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(336012)(426003)(186003)(2906002)(40480700001)(40460700003)(31696002)(86362001)(82310400005)(82740400003)(7636003)(356005)(36860700001)(8676002)(966005)(8936002)(316002)(41300700001)(7416002)(5660300002)(31686004)(478600001)(54906003)(70586007)(70206006)(6916009)(4326008)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 13:35:45.4502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b48d0ba0-860d-4035-9fd9-08db50924af9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 May 2023 05:26:15 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.111 release.
> There are 370 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.111-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.111-rc2-g16cddd4d5f85
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
