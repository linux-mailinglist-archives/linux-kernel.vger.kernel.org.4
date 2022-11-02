Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2377616080
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiKBKHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiKBKHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:07:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AC924096;
        Wed,  2 Nov 2022 03:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuXKIvRIXwxoaz5Xmviy+ugP+36YqvbPuDO22QgAszojRXWDWtUZucB47Wkc/oiqh1oYMIsCD9CZXt2adZ7D5L84pSufo7WtBbNtDGWCnRHppbIk95TPnrGL961JBpWEXx1lhPcF9L2nplvhmXbX35oQL2/kBUjdUDqdLUuap2ucafxuqAAQgal3dKxD+xF6mKIOojkGjv0OmNfCNPTjHlLKmQmEFv27OlJwaNOWzkxLR8fu1lHqp6t4WgjYOs7j95d/lRWZSu5fyIAQXRbzyUy9Z93M+3abGZt7B19bgsTd6bnjOu9PUJv5paxz1RVSIof7cquwXZVTJBPBrkS8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixCW5KzIH0HnBfwvAlx0TFhuWh1oaGJpOWfgU89K+KM=;
 b=TZpC2HUJQuztO4eT0ks0eK/AIP1uUIkEwGgPe0/vXlN51GsKOobMWSxKl5JOMtBvpaZd9aUoyuZmsgZ2U+tq6fiFmxeHATS8AX/28Xr9cqsG1rrPjtACjPRPR+A3tDhuNJSOIfxCpl0z72aBv9Q2T4/QEDX4NaL6glw3iy825ghiiPqusRi90lCrjgduhyqAAPocAtgtZDmzXnEj4hbxaucdxthPgnBSEeqX7LWtKuAQL77V1tAeMA4QAZ2w5CcT2b8Niri9k5PgvZimNRhSktHqlWN9WMp/oypfWd6DA2KxNpQxUNMBG/OlYhVkzGToYN39Tw4LApyVwp7NcudN5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixCW5KzIH0HnBfwvAlx0TFhuWh1oaGJpOWfgU89K+KM=;
 b=S1thUppZdc3oZE0OrPY+sbRL+WzQlpd/uZr3NDeT0coLW9LC7GC/EzSCQhiT1bWogdeiBfQ6Ujt0bLxKs41NpSSuX4GPFjOZUfKbullGNx2/xrOzm31eFlJEbYxtKWQ8A3BXRNB7CBD0q1JWLd7WTfjldWyCmHcP9/Yx5tyTB4KVX8Yx0ZLbcfTy2bKexYFjjzlUbHAOUxbk1qcH8Bz/cb1BDaHdpY3bAHJOTHTm7fod7LNrPsdZD57oYiMD0u09S3hVnwltF07N/5Y3NquHxcwTNb9BcLXXPg8tpW95Ozuyiba+mEIdYm3mFlNd4jpHbwUJy1pFVke4Znor314pDQ==
Received: from DS7PR03CA0224.namprd03.prod.outlook.com (2603:10b6:5:3ba::19)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.17; Wed, 2 Nov
 2022 10:07:19 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::2f) by DS7PR03CA0224.outlook.office365.com
 (2603:10b6:5:3ba::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Wed, 2 Nov 2022 10:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 10:07:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 2 Nov 2022
 03:07:07 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 2 Nov 2022
 03:07:07 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Wed, 2 Nov 2022 03:07:07 -0700
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
Subject: Re: [PATCH 5.10 00/91] 5.10.153-rc1 review
In-Reply-To: <20221102022055.039689234@linuxfoundation.org>
References: <20221102022055.039689234@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <fc39ff03-c3a7-4591-86fa-7f160202fe06@rnnvmail203.nvidia.com>
Date:   Wed, 2 Nov 2022 03:07:07 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: f791f43e-5856-4c1f-7fcf-08dabcba0742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZL1X9c/4zTeA6V5+S4sbo0H4sWekES1AKsyXCRsCCI3rKfWBUlcuWkaPvphdMiK8cvra2f+xpqHGLoPdp9xl6G/NUo1F/g7KiLdlJK4sz2MVpIoxRI48CDvmgoSIt7tC8B5xn1TEuXukJqXGM5kSQU2L66+MWKeryabgHphy8miRL8/Szc8UzTF2KNjVizduEoYMXCX1DaHgFVyjaE51LZ49/BII2vpgE2YTX6rhsFL1w+nbSVObiVEfT8INQO345qd+ImmZsfiaRCtbdq3lSIBPkZ+a/S8fKNXhwMxkI51UcQAc5bs8WaoIE8qiO1Mk9HCwwqB+I87pl9ktH5BGoqP0rJEHNGwY6PoY1cz7a6zSlDeVmqzbxRMD2Lyu91FYsYPC9RxP4j/mKUeWJuOSdjZUTHdP6vqhvRMHIW83bfvISm/Uv3Pqj2k0cWnXC/rZOJEyXov5Y9a8OiyoetcZiKhsDE0gti3JkUAorNeXca58us/sGF+/sR6hf6kRX/Qe0Rf75TBMBus7p82QpPD7fjCu+/MqLxTZRs7G4t9Lx+Y1ji01tdyI4X0zKAHbkUkRCfuyhUcrgA97KdvI18yonke48cnFstARkELmnKX0vi87uP32q//O/zS/NO6xTJN3XQV+KKLPgCD/zBwPtwPvVPsJWdSposrP/My4CKjeAyk3nqfB2qjwB7DJ1BEH7biaQqUwyhKPNSGB99bIvk1PCULTfmmWzFfbE8u0Yqv3PJwGI5lA6G1BDnp277Bqsncg7XXKW4tloIVKfD8PGh5m9jbC6bx4LL9TTTfWQLJwBOvIQxCVeiRIdaMfO5A21Haw2K5CdqQ05ecthMZiCFLKIlYOPcNsTaCr4py0bYzfCyQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199015)(36840700001)(40470700004)(46966006)(31686004)(4326008)(8676002)(7636003)(356005)(82740400003)(70206006)(70586007)(7416002)(8936002)(6916009)(54906003)(316002)(5660300002)(36860700001)(40460700003)(31696002)(86362001)(478600001)(26005)(966005)(40480700001)(41300700001)(2906002)(186003)(82310400005)(426003)(47076005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 10:07:19.6521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f791f43e-5856-4c1f-7fcf-08dabcba0742
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Nov 2022 03:32:43 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.153 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Nov 2022 02:20:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.153-rc1.gz
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

Linux version:	5.10.153-rc1-g2f6e4754098c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
