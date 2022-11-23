Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894AD63639B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbiKWP3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbiKWP23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:28:29 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0265111C18;
        Wed, 23 Nov 2022 07:27:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5ktkz36Rjq+1VxB8YxAR3+tllKfXrwSnDa6nr5H1dLW2J6vbC1zvXNYvlBjuZoHqJdByOAtQhGJoaAc0cRA8rDTjuRL8j0fN7foQ5DPemeGxWYynqb6uyP36Zqev4XCQQvFkZbJtGYXRrhuYMUi0cftJkqT3eLpb/H02Jyr4h6+OSdL8clrx4rNKeM2/tBbHHqwGaXSjgmMiXRFQT55BdFbR1EXInSg/DNdiLAWcxs9eLZvzIh4vYToUybU95KMxHxho32fZzIZx+SQSPR2ZmJxD9zmrR/oUCgCQCLPXSqAE37uF4WugkO4xmxcTQ5hfEWf9Rp8awTn8DBsjMLcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRxpH/pcmWWKY0EgdB1dhaUoLrTLEKod5fdsVw1Fr2M=;
 b=Rs0t76TNbH+kFvBdTm7fz6M7+s8oY+qF5y2c/ZrLutUyKs1OTdTOB7B1T/LV++Q7afi6ADUyyAW2ZTYU4Evt0aGyUdUj+6NpJ2toyeTgnExkbYoDfIiZvuF8yM4CIm0attuY1cj/Ah7c+CDlihX+FRWNGf/R3J6vCIsk+U6n942DnrLd9EzjY2CP1M1cmpcW2Tm3Des7PJc2f0B3GhNqOh2nc4uIJ3edjw+uPbfM+p8S22tYLsarEw6+l7RcQg4uEZyit2WefJTieUf2Gl5fGylh8pmR8lUsEzLJn7rxN4FSIwDfYF/0Pb1IOV35KdG48LtLp3wqfajhYPque1ke3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRxpH/pcmWWKY0EgdB1dhaUoLrTLEKod5fdsVw1Fr2M=;
 b=m1tnanC2HCiJ+KhQfgzhs6W+6cjmSWuoNT0hEgFVsKpjuRidGJVyGs3tyCaaTVcUA0mMldaZ1Ew3eO3tGctXtivyeXoh5f3Hx+1NVWdYEBvrjvk/pL+5cJuhxIpljZdkZJgoEnr5sXh6NzVlD5bhW7xiuG5DRvwpTwIZPwMuuMtxmyyZnemNjXgs7DwAIPp4bu+k0YW6ILOVKtkFGsDn7IN6ta9QH2XEzAxVGtBb5kp67rJ5C/XfEbj1BDNGFD6p3NNOGHxQhk7rs8itmSZzay4yAjpRLWSOrnEEgkBl8aFvz64p4W9/zDQG7JUwnSH5uBoJHO1ReaCd26zB6KFAKg==
Received: from MW4PR04CA0187.namprd04.prod.outlook.com (2603:10b6:303:86::12)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Wed, 23 Nov
 2022 15:27:31 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::7) by MW4PR04CA0187.outlook.office365.com
 (2603:10b6:303:86::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Wed, 23 Nov 2022 15:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Wed, 23 Nov 2022 15:27:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 23 Nov
 2022 07:27:20 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 23 Nov
 2022 07:27:20 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 23 Nov 2022 07:27:20 -0800
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
Subject: Re: [PATCH 5.10 000/149] 5.10.156-rc1 review
In-Reply-To: <20221123084557.945845710@linuxfoundation.org>
References: <20221123084557.945845710@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <7c0dd219-86b9-4684-953f-ea74b9b5feec@rnnvmail203.nvidia.com>
Date:   Wed, 23 Nov 2022 07:27:20 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c06395-228f-4487-0f55-08dacd673cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nugu5D8zdsURA18iauCjRT698/oBLtoAGxYTVtHbu09c8PVdBAAXdu9jd8EGmwt6rJW8+ZsO9tQke3zgwFxD1gSeGwA8S8Zn8Qp/Qu3l0qPhky7rMTr2rVaeTeMdvr0Oxt82+0MfhgVs4ONsRKr1/njOyl9TsRitvkaHjqiU1X0NCJ/KtqNH9XpYw5ZN9ddwCjAXDfhoSQQNFBShU9UdqxVzgWlo4UNbwiXvzF7hsn4gOXC2rP+Ib9TYyj5dUvVSR4hHocvBWPH+/HWzlcJ+56xxbonA2/zDO/QEUo/+cv2Am27kg7CckrgPGkYfsT8Q3mjBDcruj5Zjo8Etmf9mZleJJVrioSl8IqFoBEAr96UexCQfSMspOLMeEl4KcYP3mtJGuTpCYMTST15Qta8sTWbJozypU3EQ9iIZfS1qoq4GhrGUnGuGeiAmkPythsCYpTohXdzNAKDesqX86LqnRMSeIupSuYhS9FRXzyOYv9jJG+r4tQCYa3GAIueVEz5XFCFZNpXS10GnI/f2UKxr0LJqRVzSoQuRWZhrEUwkA7dOP3o3OO8qi31V8mFo3oz6eKFFssE73W4RbX7Ij7u2/8loY2hl+3t2rCUkmIlxgY6D4Wx2aTCycOrsLz+84JnTy3Nrfcafe9A0mzTVswyOl9/oqHU3HZIDcJ3pESYKEDUzCWguLET2Unvo9nRz1YRTDjX7sbB6a/NgoUQ0J6Dl7vh/Z6en3hXiW0DyCGixn+1d4lQzjAvTAtx9N3fHNDif4Ot6KkceJ8cse1HEWTrZVEYb+BX2r3fBQthqkL9hHQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(478600001)(82310400005)(31686004)(966005)(316002)(26005)(4326008)(6916009)(8676002)(70586007)(70206006)(41300700001)(336012)(8936002)(7416002)(5660300002)(186003)(47076005)(54906003)(40460700003)(7636003)(356005)(2906002)(31696002)(426003)(86362001)(36860700001)(82740400003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:27:31.1265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c06395-228f-4487-0f55-08dacd673cd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 09:49:43 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.156 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Nov 2022 08:45:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.156-rc1.gz
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

Linux version:	5.10.156-rc1-g38866e257e18
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
