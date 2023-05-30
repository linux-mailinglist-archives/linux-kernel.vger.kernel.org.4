Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92B97159CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjE3JTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjE3JT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:19:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD90710D;
        Tue, 30 May 2023 02:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2L8E30987evmh7ZKxkmBxoha0YnVtxSyne8ro7dkpdGuzNwMrIXmKhFnO7imgzrd+3BthsPwYQbXJAdawuUzAGmBqM7qsRpR7Wf7ItClq/e3jCjPQp87i35VW+XMW2YjWJOrqEvA/xfSUVpqh+oCFt6Lx48QXWnP4fnL6mlVU6V+VvCnL6ls5U9F1dbSFOmS+6903NDNByHi06qFA+1eoLIs7EzcgrMvrHLSLqACCgpvgA/OapLzBkVDj8mcKOkjGHzODfooJhorIjWJwTuu2bc74wYuQqkAq/iqzzcRYHxhjCamosYWhQYOzTCIOcKQN9MJB7ayjORMK0jZoV9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAh1SwpJl+YTB4ivcJoDoB+W1ic38x7870kMaqtFuGg=;
 b=MleJmd7LDbL0oxusZ5BcnM1UQ76c2YykTpOQh6/zEq+mfK/seM3D5xFjBBKI/R8tjaCu4RnWCVmPHkBY78ixR7Azf8CS6T70D+J22QZ2SEUsuTgz3Ds/AunN9S0agKzk7KHDdzRdLG0FW1LpfgVwPkkLzM5aVROuLD8HHyvBkcgxa/OYEx8BrtqqcyCEOJZz7cMXMlSMsn4IPtDv1U4qjNxwAXhJIw9ZtA+ZZKPGEz2XSjNs6N7xUVlxxFnGEEerK2SL22F88mrHBKJEDom+K3NHTJGAmZFLRudZ9ZlTzUYbjOieL0dAYVpXU3pUHmRc9kvhFHiyy01ezuWSfSbaLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAh1SwpJl+YTB4ivcJoDoB+W1ic38x7870kMaqtFuGg=;
 b=eyWr7w3UgOG6KS1IKJGBzZy1rl6qgyYmFqbKyZ0a3akQKKkYaUhm2rRpVUBCwtbEqnoyuVzAyAOs7ZQHVS/GC2i/HzwlbGhsODh5qM+XIG+rp/xYfxvaZAhqLzpmltI79R5NLiVkuNwfZVpzi/Lq+PUX1T4aprF5gjo4YUZ6VKwmqyL6c/q23PGUp/7QoYDy7nm7a+/fdwA+4KxEAyEh/05eqOLq4T+3HDRYwPt0WKFQa853RITKIhKEF4UfcQQsy46TpydpWIXJGFSFrYVJezgjfKczdPM/9pLqTNx9LUxRbh1yD4TzHOmKpioTHrJul6+HRHT2/pIDCNyH/WrxkA==
Received: from SJ0PR05CA0187.namprd05.prod.outlook.com (2603:10b6:a03:330::12)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 09:19:20 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:330:cafe::23) by SJ0PR05CA0187.outlook.office365.com
 (2603:10b6:a03:330::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 09:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 09:19:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 02:19:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 30 May 2023 02:19:03 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 30 May 2023 02:19:03 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <linux-tegra@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 4.19 000/132] 4.19.284-rc1 review
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <a81b6311-35f5-403e-adb0-7b86013310ea@drhqmail202.nvidia.com>
Date:   Tue, 30 May 2023 02:19:03 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fabfe8e-f1fe-44b1-8b11-08db60eef2fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8axjfMFUeKCBsoVkel46ItZKIs0U43t6e6/qo2+D27BPTnaHfMT2e6DRlOsKiZa1DCWCBXJGkRonHgaaNBsPEfHYs4VX6KsILEVAmUhZ4ZBdUQL8G5qXPUqg8Cd/8RVVuZ7HXAlfm2NsEgug2CSj9hvkViCu1pEetaKKtpDjerj3MI/y+psPTLZHY/c0nbsA4oUSj8vWKFjDX4I2O4eKmj1nJ1RTkK3Nvxt1YglotfZOqTALVziUbEht0sUKQjWtA1EeLrHW+b2VtfXQ9KLJfVDp7QQL9ZJk9Ol956bmVPd1//SV8XC44/mdynqbd1L+T+BHPebqOXoOkFf2aukFZMtG1mnOXfBFSAFA6r4FibIpbC5tAKAa/N78EoQa95L02O7CbllPk9aa06h7OsPq/PT6Ex3uy1DRbozz1sxie5UZybLcdv4j4ip6a55ZPJXMagE36O/zJ5bGNjJ/9Oe2tgwjCciPJGoCpPiZXnBF21/ac6z3jSotgL2NZiQJRBj/UMFR6yGEO2k3S7BoQTd3lx5ssIV8kHkD8o100MBUADvWSA/ktBvXRUEbYzNoM23/WPay9t4rsYcIReWEezYZJgQMcjrSQnyDA5Z5W3PJbqTs/nHvClRt+2+WViy8uFUkFh8Ub8osNG34S/PrXzA9L2HfcrAavt9XG40sYNlbv7VxA2qUHbJXvKBLtuE4BRgrMzPIT55p8axe/FjO6pm+khN/neN6Vj4VWL6D2DsTW9ZCLFFDgpUSu1ftsssSspwugfXbqZ10IXZXFvGNazBiZBeDGXqOTIAqJO+Vpe2t+I=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(31686004)(40480700001)(26005)(336012)(426003)(47076005)(82310400005)(186003)(41300700001)(36860700001)(7416002)(4326008)(966005)(316002)(70206006)(70586007)(8676002)(5660300002)(8936002)(54906003)(478600001)(86362001)(31696002)(6916009)(82740400003)(356005)(7636003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 09:19:19.6705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fabfe8e-f1fe-44b1-8b11-08db60eef2fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2023 20:08:59 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.284 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.284-rc1.gz
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

Linux version:	4.19.284-rc1-gca80c4a612a7
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
