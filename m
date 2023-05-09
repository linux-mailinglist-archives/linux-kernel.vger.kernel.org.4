Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F45F6FC803
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbjEINgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjEINgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:36:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C513A97;
        Tue,  9 May 2023 06:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNH6wODWT6EOjiCWJu9xBZkRrZI9sEKilpimWXgfHL9/0WnV+CEi+uG2nFjtT4mXglbWVZp6B2X5Pn246xKuuz+ZlU9q9TjvQVyxPdEnbdbh32vs6vhl/wp9LdbmEtbrR0iNlexx9CP9nUDhJFf/Lnu6xIxixfgLrqnJAxNkxeX9wrNVYHbl//f79NaGtS9VUCpmr0xertuuijklh1RNZrd0V/HwvMxlESP4qha6U5QJSnCoChJ7nQnsgNqzjNRCcNT74Bd7O4JMxfJSshA7VYD6qYv663IiBpr58vu8FyIWx7Qk5Av5+QlmfR/KOzfACzhG/BEurNO5KaJkXb6fxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8r+9l7rGf/J5MafyXv+ti20kYvy8rDN8x49pRPomrI=;
 b=VhpyLaVvBhcdYi0K5d800vYeHT/FEj/x7Jl0+zYA3stLOhu7npsoMqVmgpR1+ck3Twfv5WGnOVSv9corA0eXSK6O4Sq8iC71LObbGEPN6aUU9qqDcGLHGXIjvcQxX3WwtqaWvxPmsuJM2pcSrpXdWc4qD7oasGYUuB2WynQlwvJ3G8dKiiQQq1sQcGExEQnNB9lrfCm8UxNZouFd7VK0TBvZDY1JLN1TErLOocPW28KAWN9h/y1E4oeT7AS+7E7QClJZBD8ecxQDinB1KeuVf1WUfJc3Hb18JJ069IKPMcqEUxuZiiPQgtfqKkzMqhIdM2CeVgguk4eyxYnOuQcGYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8r+9l7rGf/J5MafyXv+ti20kYvy8rDN8x49pRPomrI=;
 b=IOJeunPcfKPOIj6Vja0isjcJtxLj9CvnHDJHZerl1T0Nzmn2tk/5LwNl39CmEUAeSe5vG2BEcMaR/n7rbwkZIBHC7hkOR7r54naMzchxZtGy6LsE1ivONEqLcLQmOYTVUNhmAVHDOCUfzReZMv5Zyg8mVnReelEaBXg0KnaaNhtR8+XlgafUSzwdYeOv93iKciMIC/7+zaTz8Yqf9dwzhQiOEiGEPCfaUzj7ZCrA9563isD0Sq9CI8I3e/d/AmbK+ej0+qxv7183CsWwSslAwq9TtpRJs7W0a8hqVj7VteXqmaiNSCjUkWCRsu+oMcsVuFXBPGInYwzCdhubhpCQJg==
Received: from BN9PR03CA0460.namprd03.prod.outlook.com (2603:10b6:408:139::15)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 13:36:07 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139::4) by BN9PR03CA0460.outlook.office365.com
 (2603:10b6:408:139::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 13:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 13:36:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 9 May 2023
 06:35:52 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 9 May 2023
 06:35:52 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 9 May 2023 06:35:52 -0700
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
Subject: Re: [PATCH 6.2 000/662] 6.2.15-rc2 review
In-Reply-To: <20230509030701.507375024@linuxfoundation.org>
References: <20230509030701.507375024@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <a72e9834-2e13-4611-891e-6464fc9691f1@rnnvmail201.nvidia.com>
Date:   Tue, 9 May 2023 06:35:52 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7edd06-87cf-4ed2-318d-08db50925844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRlOWHMB4gmyyIy1s29GO+5AgGPjiMpkECZ/fnoqX9wGwDF+oDOnXqlPL/tnrvIEKDeQI4gc92vyDGOKGeRslNF7RfdkHLZo4ZbBz13dJDsml6A9xFeskVGb9Zj/g4aAxyHjHcBkpv1/m31rLbZQPnKFkC3ybXTuRUgcjJTUlbqEQ8fehxC9rQd2M10f6R0TRu+bxnRtNm1pGaRJ9ec3Hs/IHbxcldYgoovCvSMjVwi+4ft5CBW5WKjyqyTZEgmdFp5kW39AbTAh82+lu1vSwzoVBKDCZPmfjlg04erofnES+kINpE3LDP82BI0qR2iq7FwIyzqO1ugUAy2/1PCRFmp6A4uf76KzgL4lDvkSLdQn5OYpFjKkRrHTMg9TYLt8deFuZGChQ5vjBelMwS9QdhS/7Mzojsld+vKwVNpMLWZDS+JVZ9A20Y11dpfin0Mqc8tz4qJWB/g2APdb4pK4sqH2FH9uy7OdO7Bauez6qZ6iDPEAf2l7VkNsmG4n1OzfeMVUmdzheODoWaVo+ibueAqqIRlLQjnPQRCqN65IVx17j5sgqNlbLM3jRI1xiVN1dR5UMu1Ww5Kyu7Ut9KiqF295j+a425dSvzCxERSo1aVmj80OHaXf3zmXJiee9pzIJ6P3LL2u46r7mMuPK7/tOyFWKJOcoAeze2cqaVN43hyga4NPbB581mlaVWXtC4LO0uGlDyQx2szRjYAOCDVED7e8CLVYrHU4OaQI6IC59x71di//fF/Y+JQCAbo1iqKc
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(316002)(54906003)(478600001)(8676002)(8936002)(41300700001)(2906002)(4326008)(70206006)(5660300002)(6916009)(7416002)(70586007)(31686004)(47076005)(966005)(26005)(40480700001)(356005)(82740400003)(186003)(7636003)(40460700003)(36860700001)(426003)(336012)(82310400005)(31696002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 13:36:07.7493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7edd06-87cf-4ed2-318d-08db50925844
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330
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

On Tue, 09 May 2023 05:27:04 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.15 release.
> There are 662 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.15-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.2:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.2.15-rc2-g8336a7c02b6c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
