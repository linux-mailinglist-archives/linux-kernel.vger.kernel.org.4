Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC346A7BDE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjCBH2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjCBH2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:28:17 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11hn2214.outbound.protection.outlook.com [52.100.173.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7772B5B80;
        Wed,  1 Mar 2023 23:27:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvgvTA0liqrYe6Xj06ldVXYvrhMa+sWcT+EHeSPfbFKk4imXUX6z2IFyRrv2mmPxRcchPlvxQGcxeiW1oQZD1lohNYqcp6cjMOO9jGZJ69anUAhTm7YNoEtPyrtaas00liQIHnrvd5WZ+okW0HnayQKJFCMZ/XCAaaN+MoKCuUVK/bKcV4+n6o5VcNgYTqvaWTk/U0rE0s4vT6RkXtkEV/0FK8TR9JrH+6PQgf520zC6ilrEeGkpDPNndldaV0Zmt9yPOh8tt5R9PPaZSnGDGXhFh1Gl8FhbysPnfuLrUxYfrQYlwAD471XtUkwTiiZLOWIp17qnXvGWtAbF6NhsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2CmDHvQsRc66mi0HfzUcS/djPjayb0Xk8QT8CEwWH0=;
 b=Mr4qKMS6h6Qh4aBhRdTFwuhYjbaCN+euoM2cxRmzz/kPrTyzCGVFKesFlSuY4FNghMnldGaYRPIKzORlgZwCLvz3jMhPvHIsShJdJwzfFdsKnvzyxKiIUCIvNUVLsV4MQxRmph5CH3SYsYlrVfqXYhfXb6PVfx4zpBEQALzGWorwhhz5CLBhCh8fYe6/Yy5WCIYPpakK/VpYxH52rxIDWBVQUx1on0JRTrK5+TZChQONMQ1aOVu9xVaYpfphVDpP5DpDwfIwf3ze4vhJTZpPlo0wj9BECJr1uBmbXh1+6tWLmZFiBwsPnsYmE9lVOohEcWc+rsK6FKH3Tu1X3vzHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2CmDHvQsRc66mi0HfzUcS/djPjayb0Xk8QT8CEwWH0=;
 b=YzHlefPaiYXKAxonJsFP/46RfM3g1/y6ScdcLEJBwX0Cx+lGGfnIAaO0H4a5PkrYtYQ8awrvZvjqGaa11WPFlUhBqIVOwJRfKx9MUIQVlPc8SLMlN3FF+TZkunhaCkCzOzUYcVnU3kfF+gzkVLokcny9sexrpzco3KpavvDSti02f6wIm5AixClaReavLI9ZnvuGM6pry/aENGv7mNh7LEQKL0q3od7jkLh6cCDWA6KQUFtOePsvuji1QR4y8YBy01xLYaqCCchcI4Tw8GdTS7hwL7DGhpjQv2eo8db77hI9+i5bKmpE25xCCCsooZQ9LaVna41Bq8xDrpTZATjyJw==
Received: from DS7PR05CA0100.namprd05.prod.outlook.com (2603:10b6:8:56::23) by
 PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 07:27:51 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::39) by DS7PR05CA0100.outlook.office365.com
 (2603:10b6:8:56::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.7 via Frontend
 Transport; Thu, 2 Mar 2023 07:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19 via Frontend Transport; Thu, 2 Mar 2023 07:27:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 1 Mar 2023
 23:27:43 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 1 Mar 2023
 23:27:43 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 1 Mar 2023 23:27:42 -0800
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
Subject: Re: [PATCH 6.1 00/42] 6.1.15-rc1 review
In-Reply-To: <20230301180657.003689969@linuxfoundation.org>
References: <20230301180657.003689969@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <587de425-88cf-46e5-a92f-8c05f671e3d5@rnnvmail203.nvidia.com>
Date:   Wed, 1 Mar 2023 23:27:42 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae3d0b9-b71f-471f-7c57-08db1aefa169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpGRXpIaq0dE+0/6y9ttYA28d1/t+eHS4rF/MzwPGRzcbgpxUAdWSjtG+v1Oqm5HtxPcX+FxYy4GlEVtpaKo25ULTJ/8SJOgZjOXQw4dyTm2J9jxavc/ysmCVemL9oItLA/e/mmZ/KvTI2LKkio4jCORO1CMlUdUlhKQlqehbuAGzGsJI+UHBPMXQhfiiwO4t6o/S1VwzpU70X9+aDr18ZxHEphllRkFXOfwrfhNI/8ty5fwEcwZQpvZjU2hPYiYszVHW9v2MtYGglHnxdES+WIP4xDDxuG2Ocl/VGJ5ZQ1/Jt/8FmPNUc4CXamdo/7GFRMNV5I+UsKIbtlV+hit4zWt5vJuxHvsnhP6WJp+QxvEYS5KfJrDp8nVaq4B6g4bTbA/9dqF0I9bFK5OFqm/E9De6112JAUcgRYE1WR/hDwHC2EsaKtCwsEfH5ZKJvkbByhOl46MHcPF086GnOLZdfk7IbcYNXHUS49F+ox9YYJdKh3IGa1w8/+jmCXcM8H5MAovqaC6mXGGtp0rX3WnauUTvZzW1yJWkhcsGHbvJ661PFjc8o+OxmnsClewHiNFwNl9PzRYE3bDvHnBtBFDbc5bEx/2Y7JWk+RlaCpf5viLYH8Ispsg4YkJYS/pFO/syYuv0+D8SfM5RUhZXNj6joDc+Wp46LuexRZdT/eUFwlYz663wnFpe9UXvV2sbUBH07Xnr8qrw0y3exAj2RXxoYrK258irKrfnzvky/Q459mo0CkUpZu4UvFtW9xUMTZzbCmhs1y6yofsdyXZsYKMk4fAermcntf4CgfhN+TgjdfC6UYaJCnjU2UcxuzEXWFq
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199018)(5400799012)(40470700004)(46966006)(36840700001)(70206006)(8676002)(8936002)(34020700004)(7636003)(70586007)(82740400003)(6916009)(4326008)(478600001)(7416002)(31686004)(5660300002)(40460700003)(82310400005)(356005)(2906002)(41300700001)(336012)(54906003)(966005)(36860700001)(86362001)(31696002)(47076005)(40480700001)(316002)(426003)(186003)(26005)(12100799018);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 07:27:50.9045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae3d0b9-b71f-471f-7c57-08db1aefa169
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2023 19:08:21 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.15 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Mar 2023 18:06:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.15-rc1.gz
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

Linux version:	6.1.15-rc1-gb6150251d4dd
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
