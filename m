Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9DD68B7D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjBFI5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjBFI47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:56:59 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DAF18170;
        Mon,  6 Feb 2023 00:56:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPVHV/d/ECHAp5F7U1UQj3EauLGP9qNAoJ+oKUpXzYFuzjo4H+GHJd1M0onmFA0tg8xnB+vynxAxul8AaKFHmjLxFYdk204xbWUbHM+IdluUGUCyyAdsnGlD3eoFkMybSaQ9G0V6WW1OIhZ/L7jGuaE6poRoAsOIg846IFqkeYyLoItSc3g46L7+aU/V4YR5x5roLGPg/edqW906ltM6a4jgxFwW+ToT6gWzxRcExRHzucb8E4mlS2PAaRuBCcPmePrLO3zEU7tbY6Vq516a7prij1E1an3B9s9bf5An2U5dkZmdpoVw92bzV3CN5QfN9+7Jh1ePgE/lo1mNg/SXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnPjwkFiGVc97ABOqtwL6vPQL5xJqWwHQz6d2jSEk1c=;
 b=d0u+kNC4CQUFC0F029on7d7NZgxqp0sIonbiPrATSNjXaHJT7DMy4F1VuBOyAtMJCJDUu89ySA5Qh+FKu0XnJXpEny2FsTiim6CaDw60X9cEY3i8SasFnZoJdMvd5ReYsnhtOqXDuS13e/u3nd2dM8vSirTX2BmkocTxlDe/H2VeYoo0LExtSZfGic4+h3nZ6Qk7veR9yO8GkoA9+KdTDYBEqMUEGBfZGuf2TLgpSPj++TejTZGNjZfLyqE6R7YCVrtICgUzL8OQIXYCLlxbJufb6pb/wBLRIuZZvJWvCgBQY+ZmiXYBX84kK8SrnhVuaqlIO9dtITC9j7BZq3e7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnPjwkFiGVc97ABOqtwL6vPQL5xJqWwHQz6d2jSEk1c=;
 b=XX9jOt8RBp4bgkqeIQSKr+aA2U8qjjdbupzj/CmJFI6RKED6PR5zizvGG2/JcTS/DNH8qfb/yAACn6iaMZnZoPw6/PbaypgApzpdcC8BPlH+SgmQ3bN9TnOWoPs4xMDr6cEe+2iMgF0s0FpOzrj8k7/gkZNu8Kl5dQdu+82SDNvvawtYDsXwLVBtnGl18swuhd9usDWtz7QpThcgo9pXJ25Hg8HZ0RZg2SBjjr0OeVub4i3AUKVHemAYOZzAx8YSL3MzxMv2SXS+zCA3BnFRgBPooUr+Gk7s0SYjTjUDDiKJlZcIy6Gjipu36Tz+of2cq2nwa94UlyiH4uoVIb4kng==
Received: from DM6PR12CA0009.namprd12.prod.outlook.com (2603:10b6:5:1c0::22)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 08:56:55 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::6f) by DM6PR12CA0009.outlook.office365.com
 (2603:10b6:5:1c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32 via Frontend
 Transport; Mon, 6 Feb 2023 08:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.32 via Frontend Transport; Mon, 6 Feb 2023 08:56:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 00:56:50 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 00:56:50 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 6 Feb 2023 00:56:49 -0800
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
Subject: Re: [PATCH 4.14 00/62] 4.14.305-rc2 review
In-Reply-To: <20230204143556.057468358@linuxfoundation.org>
References: <20230204143556.057468358@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <59eff61b-2e64-45c0-9894-43b1a3562bae@rnnvmail205.nvidia.com>
Date:   Mon, 6 Feb 2023 00:56:49 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac1e5b1-7b33-4c41-328c-08db08201926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3quupmkTRIzPGMLwwejq2CiWRJGVeGXNapClKMuq4UuS204fvKjlKfZa6k0Rzaogj2HLIlB2BfwI6O9vpkfsObcBY5OUAIr2t7QvHVB37OmGkwQEB/HoupemZ+kjr+R6fjTCxU0vX0n197dLj+jxWBnjSmoA1bp49FciFHJeHPV22sqneZmKho6ovJNCN2JhIdPcznSKDAnbg1W0Yig4j5tUxQO51MO20wgDdH9W7YMrW34VuIsnYxiu+z3ZtIAeBQtbaRVzWaY1AomTqfiil5qGrPlpYc5hZZIOOK+XzvUspL5Nh078pYE+2RRu8+yq/rVJeAERfUiEF+LR/K+qwaze5s0y/y8+b9wqgRmEkgSeu64ViH+G092VODVcwO9arMLNYcdmf0mdSFmiiuPLmW3aZSJctUVrjatpSlgxwC+77pA6WG8Z9ySvMX0sFx1zU5HpAzYvCw2fqorsmKW1rAdrD5CykZxx45bVO/naym2Csurm5VFq1CSKSmPypDVZ1YZV31vmlKEOooYGQrm6I7q0R2cx252w2AM38ayushrMkYJhxJrbcave4UKCr9UkxW+9V99tKXMusgjvXW2yFuDZS//U9Q4R6RJq985m9KERUy3HA3gM72lvxn7NmPZCZnh24dWkE2jjDcWsD7BrjnAv79OmM3E8vuWkgNEhXOfBM7A6j8p1+CJHoE2R1l3Flw5aUOq0hTQ4ggFxHAdjA6dBC2mHUJvKTrbHv8MXSR3rdSyY78ntVaxEmQ5TbZf5NmoUyaA1P1cXnPaoIXi5TwXE7CAcGrh56xmoWeYcogQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(41300700001)(8936002)(4326008)(966005)(478600001)(40480700001)(86362001)(426003)(82310400005)(26005)(47076005)(186003)(31696002)(356005)(336012)(36860700001)(40460700003)(82740400003)(7636003)(70586007)(6916009)(8676002)(54906003)(70206006)(316002)(5660300002)(2906002)(31686004)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 08:56:55.5404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac1e5b1-7b33-4c41-328c-08db08201926
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Feb 2023 15:42:23 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.305 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 06 Feb 2023 14:35:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.305-rc2.gz
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

Linux version:	4.14.305-rc2-g76cd9cefc3a2
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
