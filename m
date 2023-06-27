Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D9973F82A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjF0JFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjF0JEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:04:49 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216F819A1;
        Tue, 27 Jun 2023 02:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDIto+/Evwx17vjYuPFqKGe6gjhTxwOzsjSBPscxVLdEMf1pCCKONuACzrXhS3Uukjff4WhiLZYgW3u43TZYz0Sv9HfXLzrEfa2K7rcZNNKRb+pENfCWIavgf/rHoFXRkVigORU8qynzY2DII85ac8n6Q76TjQKKH08kYqOFT9oFSVhcqrBOJnq9aux1ckyVheUJVWFYRJftwOqIYrqGZRz2aAR5jTiHsXkCtjm6Q38R5bB+RPR3591LyA0DhCCoB4EWf60l5g5JMca8tW+pbdsaowpWGbcFrk0nwCQKnjsbg6TpSGHdeRIyDAoLdyAx3MppCFgsQkMDLZxfwlXgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHBblvf6+kp7un2gCIitL9sokg9gCpXQcbKSQxD2xDI=;
 b=ML9zmYQZyXxXMrvI4ZpXrzCIhgHqvg7PPnXzP44gVkOsmcB6fdIbWF7nCIQDPhg02QDzETypDkEZ9P+/jWQRZkZH6HQgyxPg2sw/BhRkwSk2NA115vWe6P/6WY1mSKifrJMl6jzuFgEQNukcnhhh1PxZRlGs0yVuaj7/k8UIaCRjU5QgLJXGOZ51S9iddqNWf9oweh+LdMV6q6cwGT12STx5Q/B2/8WPu/Yl6wrjtygAy1mNZWHyuwfDBvBUeMn+gH8Or0LBi8cF0Oe+0uXd8JUl3m6DhQhhf6v1QZDuEq0PXkXkfQ/FLowbh6Jstc8ikDgCjdTLH29Ha9cKKKcp0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHBblvf6+kp7un2gCIitL9sokg9gCpXQcbKSQxD2xDI=;
 b=FEtKl8ckFxU/5BjsxJA6Vj6ez7cJSyfIRv09hVUZqHpYYwZjCbi2G92pG4bzTRdWTmDWcrW3RUC6h14MfRLrxNSYJ2L0584+RDjDahuC0szX4gPkZClHTw+eg889PEKFBUxJ3SmJ0/DG9KyGJHTB0kJ9aRtxf/cvHSWggMBAD8Kl5gaBK1UTkD5pnkcnp9eAY7XYcUjIrDOoUp6iYQxVGZ7ObIPuxQKqTk055vBxJsCPNq9/k/KokILB8mHR6NIg220Jlv+KCB4LmMWzeAhiRB2eqHMbXRifEsDX4J6g/wt5JSkyEImvT1CvVbqYDUZ0cKIi+ZLxzgGdq/dQMa0aUw==
Received: from BN9PR03CA0226.namprd03.prod.outlook.com (2603:10b6:408:f8::21)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 09:04:45 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::e4) by BN9PR03CA0226.outlook.office365.com
 (2603:10b6:408:f8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Tue, 27 Jun 2023 09:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 09:04:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 27 Jun 2023
 02:04:27 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 27 Jun
 2023 02:04:27 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 27 Jun 2023 02:04:27 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 5.15 00/96] 5.15.119-rc1 review
In-Reply-To: <20230626180746.943455203@linuxfoundation.org>
References: <20230626180746.943455203@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <d437881b-e5b6-4e8b-9b5a-dad9209d342c@rnnvmail203.nvidia.com>
Date:   Tue, 27 Jun 2023 02:04:27 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|MN2PR12MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: e87fba75-bfe5-4192-3e2d-08db76ed8d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /sxJguq9GksH8HGMqhQyxMPmdecrDt0OXt5KMbVeQTBwNLrRArqQkdVj3CTEkWBHOZdwQcRi/XhZ+g03ihcBVE1H/Tut1SGdK9x3iiCeQfyInULI8D0C6ZWMiDyj+GNf3GYp5rOzu9tN5hGXBuWcauaoXUq5Vfdp2ZTWFz54X06jNqtlE1+TIbYBZPIoNBNQ05jaNfJGg113+Nulc+GvaHKvqyPirlgrmXqwlk1FansoTJfy/ErJobvCxqx655K2NsPv5oSo8vc2sB5bVnPnl4C9NJPODSHF96+zezZ2dnsSF4564iG+3tsxaqrjHhMFFBNQWVkJy0J/4isYN2tAjGjS+lgQlb+gcMNgMH6ZqW38MjEliA8Ryye79jvTT6Dm8czeYtJwRdc7OmOr8PhlRX40SE/GM2MKRvI52yOFVt5BK690bL8fotD+WnF1olI+rDCZNVPcUR+3AP1msjrr6d767xmQxFBzfDb4knNuJLuJXBMv2ssCaaEnhPwzYF3Bve3dUl8378Nm7p/1c0cRMWZiImJfGw1Ka97RzpYu7QZ6M5N7yPSwc78KDsGHjGyaHsKsO40U/wJuE52Riv7k8YMqJSddWDckUbCvERhzlMdgKtzVlh5wl0o06tq1eMeElwUNTCCqr27iLSxFPSAzeaR/u13J1lA5n62aXF5iCMfAaNfdET8uQFkF4sS0x9yfOnY42hxdKKnBMDRIawWoYuxcubTxMJ6yS81tzMgicrNhW/r8e2u3osygOqZJ7q4HqfBsU0pPWeZ/A8yuv8o8867heW50UqEMSanOVtKtjdM=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(2906002)(966005)(82310400005)(356005)(26005)(82740400003)(7636003)(186003)(47076005)(336012)(426003)(36860700001)(40460700003)(41300700001)(31696002)(86362001)(40480700001)(54906003)(4326008)(70206006)(478600001)(316002)(70586007)(6916009)(8936002)(8676002)(5660300002)(31686004)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 09:04:44.9979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e87fba75-bfe5-4192-3e2d-08db76ed8d3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
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

On Mon, 26 Jun 2023 20:11:15 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.119 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.119-rc1.gz
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

Linux version:	5.15.119-rc1-g27883eb9b47e
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
