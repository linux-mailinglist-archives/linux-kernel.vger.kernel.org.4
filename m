Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C366339A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiKVKR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiKVKRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:17:11 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751415655D;
        Tue, 22 Nov 2022 02:17:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXysmEMsYO6xVoW8Z1GDm/3qyHpeHBAw8zWOXXRE5KlqssW7iUFdL+YSQviSf35pskuph/C3Pa31oR0UoOAV1Qk6tK7oOGBw56VN8JoUZBIHggCfuvw6vq2WtSi9lplMXtslUZgxHJxfhx4+xZkmQFaUdlo8WRh/dqMQdnd18cOLlMC4tumaVfOPpRXMUTVywLZ7nYJg2lrhaoQKlqWhZxBGxuvjK1N6/hcfZAsI+avmU4eqXs6KTC1IrCkQug+iIavFMEPfybji45t8XyplTE/DO2slJxhgDc49L2+gjc9PcL/2rgJJGMradUeAdpxDHISYaHzPq1nyW9ZYG5sW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjk3UZt/f26aKIQISvMCx76NAq7g7FRRbLCRwGNer+g=;
 b=OC+n1fbVzBf6emj1QPNcxzyNMgfYEircammGrg3sShUPMsau2OkLuD2dCw4i0NtwwHBQmZXQI5N8eQgXE/IN7QwCgn11qof6X8f7M/F18buBb6hmjU+ubLCTPkkJpP3aNmZejxys5DDBmNGapMKKGcGY1HtKKdT3Y0cmuWxub+KXKr+kOc3biTsJ/S2ebTPOVRmxsb0MQRH0HcDeMjo0xORzQSJrD04N5YW9tiZ+tSEKW1cBKB81vE3jrztaNfwHckfeMDjmWTLNgmtYAkFwZg7Ikb0CIT109/VN1AOyR4L83uXF/d7Hm9e1kROk3cqFXe5dGnw37ujfj8A8URNWlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjk3UZt/f26aKIQISvMCx76NAq7g7FRRbLCRwGNer+g=;
 b=BgeYzyDm7r0huptisBvIsY9LN3vOova+wnSC0qXHXyc1T0XxjECfsz4/ku6Ct6mWzgw/omOPDWOpqwAivBCuAMGZWdvDAqthICPel+kVnzUO4mSsTi5hP0rqxLluoz88mhSxKcgBSeFyfyRM56DiOasZOETcUC4muO8CsO4nQ3zvr6B9QtH5XP+mxOShukNipEH2wFryYlpdAtgCsFSZH5mjm2Hv71HXMabjcUK+lJHB3RwFg/458sw3YWyvmgRDwJdzv4nniWIqXK9Bu6FTB7m4kuu2eK5D/M9OgRk80n7CUhvJOU8FzmJsJetW+B4d2yogvQOOhBDr3PApWyB0LQ==
Received: from BN9PR03CA0176.namprd03.prod.outlook.com (2603:10b6:408:f4::31)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 10:17:09 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::42) by BN9PR03CA0176.outlook.office365.com
 (2603:10b6:408:f4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 10:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 10:17:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 22 Nov
 2022 02:16:59 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 22 Nov
 2022 02:16:59 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 22 Nov 2022 02:16:59 -0800
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
Subject: Re: [PATCH 4.19 00/34] 4.19.266-rc1 review
In-Reply-To: <20221121124150.886779344@linuxfoundation.org>
References: <20221121124150.886779344@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <8d2fd268-6b41-4328-a3f0-e8bf5cb32ea7@rnnvmail205.nvidia.com>
Date:   Tue, 22 Nov 2022 02:16:59 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 69801933-aefc-4621-7f46-08dacc72b65e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NeltFn11JiWo19260gbtPYfnT4kQe30F9e6JWFofSs+CfjU1hHHnlPMAkHDAj75MPBJeIpxlmR/SWxpHMUF294lgvaJZF5ycp7fb3iw6SkRk/i/Ze6tx2F1t4eAjeKKSnKQsaMgPZtLc/uJKVBEuY9ogqDEOFpGCX/nJg2xrhqqjjY7h7srTyMw+x7yQx5n98C4aE6e1Pxk+f3MX2eV62woCFaBrA9ka+yb89GFNy5O/LYiLGTdSRO1L+bMewVxrVgX2MnYFhbYOcPKcsHX9pDdq6iJzSqBnAr5C0U5YH9ctHflTjJBoMnhRNdTwceNz0q2FaBfiLN4onyGmvas8uzPLzKUhilvcMpaTWnT0ukELcSK/tpS2qUr0Wc4HJjjJ8x3OoWELn8sFCwtwqZQRBK+aqhR5KfQVWbqdey68WimkxV2DZv35ZrkjnGmG4OHr2XUIo5ZYjCLmur+MbABOW+oTJtEF2/f7RJKMwDN8Q3hHajcccVLx00n27lTjla/fUvz5YnXfMIcS/ExCDHkDwZPB8ZuaodEq/6tzZ/ayMNLBavRNxsNRPpNsB9lM0ep7TdxDH/liJViOozwY9vkUdfR+O6QiY4/vXiBXX3hulRhq+ITy0few2YgHeXwiXRsfo1akHwWAf171HFyg8dSSzaLgDCx3ivwycprVB105T6hsrKoJ0O8vFuPX8Q4q1NtnncD3Gb+JyPEGBKxN7XmzJT93D5U7avRJ5NzV5zBvKl5ROQ9i/B4YAsrA+/5Vfk9gJzAAg+FobrYYL0DMFZ6ltOido9NsybHX2u1Fg6RNxlA=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(86362001)(82740400003)(47076005)(426003)(41300700001)(7636003)(31696002)(2906002)(7416002)(82310400005)(40480700001)(5660300002)(478600001)(8936002)(6916009)(40460700003)(4326008)(336012)(8676002)(316002)(54906003)(966005)(26005)(356005)(186003)(70206006)(70586007)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 10:17:08.2299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69801933-aefc-4621-7f46-08dacc72b65e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 13:43:22 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.266 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Nov 2022 12:41:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.266-rc1.gz
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

Linux version:	4.19.266-rc1-g002bfba64dfd
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
