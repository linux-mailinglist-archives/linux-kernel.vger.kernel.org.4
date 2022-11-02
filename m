Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1D8616088
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKBKI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiKBKIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:08:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CA524F2F;
        Wed,  2 Nov 2022 03:07:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6Hl7eQ14dPMBn/+ltC05kiNIl/AsWeQ7hzOqm7VqaA2huJiz0iFJYJhnLkOaQCyyTFE53XrAchS4Kyqd7ZOxm5Jfay//lq6YDA1Yvf8mLi4lEzgsjhHB3HQCahm+t8QLXhGoIVILrJAlqf32aJ0nWbQiFjLDbozjMNQytcBiIGNelglv/QjdafORGSQSujHCC63N3+gr/8m9stQ/6KQgan3XROXXcd0yQE+QkhaQudHyQ5jKwO2cckf/ttyOM2UaTMgbR9k/Vo/8gJ2Zw0pGRPyWPk3hhDQxc+e1YIg11YBGkafV/SmJXl/aoMB08KLgvz37b2uvaYGCZGX3kC0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14lyjq0m0+hDZCT5z8Z8SmluMXbAzxBS1TgH6hWSq/w=;
 b=NA3EPDnAcItOn4iBG6ouvcHqNLZa37LbwQWPiRQVZn+3um0s280+o4qDxwy/jDO++0CsGHM18zFD0eQDcrLDxgLK4FE3ndbFRRUzGntGSPVw4amVwGmbQi0iZo3WdN2K4jEiHRJIXq+ZhxE59LlkN6tqgj9C4Sgk8ptgQhI9dpR5kgs/QAotqJbVjuxY5Vx5E4SKq6M/7fixUZOq5p2EWcSsBDTUQgL3woId0C/alMmwWieS3cQYXsohRZDNPrm8MNp23p99p6OWjuLuePSgtNYT/g65kY9vyux6Tx+HerXpTCAcgb/WQqBkNDZB37RW5z/ySszBPjVZTFdc0hvNJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14lyjq0m0+hDZCT5z8Z8SmluMXbAzxBS1TgH6hWSq/w=;
 b=eK0IEnsfjp+OiiNgBlbgE4beQiT4WUmiosCW7geVCjaGVAGOg9F2/viAAJJgE8gjcwDO9/8iGIJy2rTf7+EVetIdrhzvKBYTNCJ18RZRjXwiCt0oLuLvba+19j4WzwJpC3o0YIXH+19Ly/J3azZWEzgUE6+kXHiy2C8pAfP4VRqzFdHVD9BYFezlihtA6xCjrUCxpDNY9tvEUX3pTLOyov/aGGvdbuAVnBOgipQXqmeQI9YpdRKcMY8Pjoyz3S7OGVSr8EBb/kBs/2yiGNbmYH/PvgLI2MUQGog3AO3jPs07BzYOEvAdZz3Hk3E8GIavAGFiMOYV4QZcdw3yX7thpQ==
Received: from MW4PR04CA0148.namprd04.prod.outlook.com (2603:10b6:303:84::33)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Wed, 2 Nov
 2022 10:07:45 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::15) by MW4PR04CA0148.outlook.office365.com
 (2603:10b6:303:84::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Wed, 2 Nov 2022 10:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 10:07:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 2 Nov 2022
 03:07:31 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 2 Nov 2022
 03:07:31 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Wed, 2 Nov 2022 03:07:30 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.14 00/60] 4.14.298-rc1 review
In-Reply-To: <20221102022051.081761052@linuxfoundation.org>
References: <20221102022051.081761052@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <dd610696-b295-4832-a7a9-44b1c16c7827@rnnvmail201.nvidia.com>
Date:   Wed, 2 Nov 2022 03:07:30 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d45f3d6-0917-4949-6126-08dabcba160f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YD9Bp4jxlM2fFtZ9FG/mhxEYx60iEgmSixKkqNFyp2ZPMROAnUiUZ8V2cQIy2qYAZeYRQ8eQNUUhubZ6p3qwz9QktrMOAkd/BSTJaf126U8fb5YcywDZ38V9lnRtfNSp+FGeOU1uxL0K+u64PNjmuH/euYyW6WQmwfPxXNZv+4GdBI1mli9lF5wV6bm8I9uQd3Xyd48HRtRn6MrIrI3xbcGJLYLO4Bekkq/tzrfK1eMnDvZRU2P9NK4qKCDzeaj9VcXuGwU4hbjvCJzwZq6Ah1IPzXEQ/b6hkn/e6N6aAVJZM2e53ITdFrnglSFFeukZeFHMTW3zy/AROVslFxrlR0FizHV6roRwN9BBxsNjmVRTMbPu0v0cRnET4GNN19s04SnEajMLHHISVp6KTiUi+KzeZjiGrDILcYLQSZPaHmx6eEM7BboS0e96UT263WTWnkzMwHgVUASvh3fvnNyRalgyOKqaY4uWpadcLou7O8Gq3nMgcuDXnexPaGCQQOrBWanwXYpS+P922j37ubOZpinzt1cMvGTAEDUGsB9BTeizdqSp10WzXowpSRLy5IYb59xSwni/iw+cz0oZM8oftr6yn2tOjAt4KAbejwbcdqSlmvYgzJFEvDdo8CA6TKa29YVg4xcOYtRR9eZ/At563Pu0TkZLEnOC8iU9OICIm9YTgPnA1gZmPeb3I4+5wA8IkX0zegiy8AhDhNGDoUsxx7OReqYs0mtG1tWFcZ0oc+731X+TJJxN8YASycKNr4GvoAZ/KQPb9K2Eoflgrs1COIufB877B5UDwQNJy+PM3hmeOjjA/c0FaOeEMopeJk+PX0jgiSYGa+XbehKz8EO1ILAYsjEAXqojJ2Gm8cdTUjU=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(356005)(7636003)(966005)(36860700001)(82310400005)(82740400003)(26005)(54906003)(4326008)(2906002)(6916009)(70206006)(70586007)(8676002)(336012)(186003)(316002)(478600001)(47076005)(31696002)(40480700001)(31686004)(8936002)(86362001)(5660300002)(426003)(40460700003)(7416002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 10:07:44.5298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d45f3d6-0917-4949-6126-08dabcba160f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Nov 2022 03:34:21 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.298 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Nov 2022 02:20:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.298-rc1.gz
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

Linux version:	4.14.298-rc1-g0ac5e522677d
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
