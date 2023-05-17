Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448137061DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjEQHz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjEQHzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:55:31 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996B33AB5;
        Wed, 17 May 2023 00:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMlYhbHp/Pgz2eHUZxbqD+iRuLHxxn5NuOit6um9X4xFmISyWmsgHjXInZF63GUiSm6GKvH4PfjEqpIkfZK62Xpde/mzJ5s/WYauq98KVS/jF60S2sGEPZlXCpIpxlBNdRwwFUxGFgzcFU5HpVM4yZ8ytm81uNPDEB6IkHejOdRSEAltwVj8/qQbMNLIapugk+j6PyDjaPAxla1r5w7yxzgtKjiC5wqzBCLQY8V4l/GCYVKni3anst7q4gLsF8qMotjj7DT7Oo33S6DslnChRTbZSSbORLa3Msnr9zqPUQiaQ518QvLAU4SOKOLf9X0vwxTWxh6qvZ7HUFPX6xKXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nON0WY/mxo8W9OgQ3uA364SL/XkfhMoUSCUCtHcjxaA=;
 b=nV3fa/sVHn2pWRUQog8JPwJgWSSnMz3QhSvvsvuFWGDqOdCr6Eh0T5fYaX10l0SmqU+0pXdsXAyTv2aFZBlqe7T1TifQnCecG96d1iYovisA5y4Re8Kf+b7AKTDschbSCg5d+PPsEHvAQETpZDrEXE5PbWTgihjgzcJ+OgUerrhJgIP8Kyg8RRL1A2OjcveOCyda3WA7Rb7KjCoHEmBH3NJ5vo7HsOChjiSsJPJQQ+D+8q242mcdncIBe9ocDhOSaK6E405FN4KJ3/JLQKZIjRAyAo6veOXVME+XMJtAoJLv9KIquYcc+0NQr2TIQjhsEr+aMfaEKGhW8K8BJzEhkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nON0WY/mxo8W9OgQ3uA364SL/XkfhMoUSCUCtHcjxaA=;
 b=aE8pcjU0188QxdWFDjB3WfalXyHsYpXuREDFaUaLbCaVi3uEzRz7nfgmilcK3SQcOqIP6O3tpxFYN0jvTfJ2KqagyJvjt5p6aptNm2BgxV0vIFxNAdl+v81M2VBBnrjmGiKb0iVdMDVv6DzayyyoTsPgGKFeqFzL7HNaGi953wNV+nVgBFrEHLXdP/9M+8HkPlKuJc/FIXSqpg6Ow3BkGkgKOWfbZJjWGbvzjojTN9aD8tY0Huhw8s7+MP9ugfc1oF6oQC+uP7v35m6Hqr1tPJttUQ1ioPU3EnQpSafKckEvzKqCE1f0Pl4hcSkHuQsKi0daQJESf/SxE2qd5eQPxg==
Received: from MW4PR04CA0160.namprd04.prod.outlook.com (2603:10b6:303:85::15)
 by CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 07:55:28 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::d2) by MW4PR04CA0160.outlook.office365.com
 (2603:10b6:303:85::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 07:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 07:55:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 00:55:12 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 17 May
 2023 00:55:12 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 17 May 2023 00:55:12 -0700
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
Subject: Re: [PATCH 6.1 000/239] 6.1.29-rc1 review
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <d3aa56f2-e7d5-425e-b18e-73206ce9a1fe@rnnvmail203.nvidia.com>
Date:   Wed, 17 May 2023 00:55:12 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT010:EE_|CH0PR12MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: f6744f0d-c63a-4a2e-706d-08db56ac1486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AdoLkiqDPcgxHv0ys8PCvVslaaUTQnNFeKPjFv6fQ4cyoeuuDVXpQId9LFKRrZfCsFdoGHwgwJSSuffngjBE9t3ecUhL4bJIom0qYjSlbSsaJnh/kVEl7PjvEdfhpR/NENWSSGRV7GgdJ7dc2IG4qKi/8PyAIsmMy5AvJ4RfFUQo8DyOy2pteiQsM5F51RwjFECO9IiHNloc2ciLmXlvPM8y/5bRcoZ7JMaxC9m8noxFy6nbB9SQSNvy0VLxmMHEgoxpgEdukB9nI7D6qdLzuWIzdPBy8iEA0Yh7JlmAXk3qeSomE3LNdPANYDWZwk86YnQ6XDJXpjLJkvkGazaNcRDeFeErU0yXFCTiEoBR+rNkkIF+GMxPbP/dvCcCDlTSKyX4nHh/x326DpITTv4qpgtJbzHkeW4V3h775xTrDtb3+e4UB4GDOyg2Z4c7+zdbefmB6Ylbpg0/8xefH39oXWALCv1nt8MJZQz6lp7Vhce7nxIBTVYUCn/aKssIRk6E/rE3c8NR67uIViA0d0pfSRBfqsWKQ4J04uC2gmU7O7g67nYooHR82q3QCEcBrkoMP1GLpeKaF6pLNBOwDLL2pq7bVZ4CzL0+YfCglbhY40LQet5NLswDzCL4ZcJ/OOe8VSG+NDoSzEJd5zad5XdebzGFcjKmuRTZl58ISmHf4xsnydTHjz65ZuCWFWqRKzf15oy1Nsc+mpz4s2q1hqPN6NHRG91Lty0qsuLBbsX03A3zHYC7dABuqUbU5higISPOqdIAJLY11+TMMthotnatR9UXJog1X5Xh+itcpWX2P8k=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(31686004)(966005)(6916009)(316002)(4326008)(70206006)(70586007)(478600001)(54906003)(31696002)(86362001)(47076005)(26005)(426003)(336012)(36860700001)(186003)(41300700001)(5660300002)(8936002)(8676002)(7416002)(2906002)(40480700001)(82310400005)(82740400003)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:55:28.0838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6744f0d-c63a-4a2e-706d-08db56ac1486
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5138
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

On Mon, 15 May 2023 18:24:23 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.29 release.
> There are 239 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.29-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.1.29-rc1-gb82733c0ff99
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
