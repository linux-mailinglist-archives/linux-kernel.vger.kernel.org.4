Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4470A71FC62
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbjFBIqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjFBIpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:45:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA7DE7A;
        Fri,  2 Jun 2023 01:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoxQXS1jSO8FiMNJH7ryMNnjrsaqojwIVnUIbPCxIMKs4ish681i8Z3ju39HLk+OG4DG4pddTl/PzQAF1re72MQyB5tjmwiOukcyhp/43rjwI0YdJvibHGa6Sxqtn1k0W1EqpWz+lZGE1BI2RIfT5ZTwj4lLDyNr6R8fHFTupbKRV3/b+oaYhC96ZxRIyZ1Ht11IHdTw2NCrjIBk2SJhUjnExZ2Z6jgYe3JaYwN7qsGV3wA9kZn4wl1TjRc8exq6E+3RChZmVjMXAus7v0UlGA7bSosO3zOHFaBIKQCr5uz8WWWtd9WOcG87RPA/l6WMtpLZBniN+XVX7tosPZ5O/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+FXRG4A+dX4imr202d2NIafYcjRRsJLY4UPfe4ov8w=;
 b=lxM+j1sb8gizVL26/xHtqxvh9Brn3VcxbfON06ZhApekN+iFIE82a66flnaELuCrs9z5dYNroJfz0T34hLuQmRKwgldMGyvyeAfPRK5G3rKsajDCoC3zrVjL5wQ8MsK0dGxQmc0y/W29DU3hZzHGpe1vzm/Tsh4DJVZpBob+XM+wM8UYCTr1sjBo+BKe2CX96r0iMY0zoN1dohOn/oDIrl1QnSbL8/a6fgzM6Lojdq4itoyionvKG2Vx13J8E+6mCKVUJ0fN0wm5e8CPoRL39l73NEJJIAQ5oBZLYQgTtg5wBLBhuzcIWU/PeUWqTOY42Uk4vmurdtDQtTzfl+2z2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+FXRG4A+dX4imr202d2NIafYcjRRsJLY4UPfe4ov8w=;
 b=q32KIqKWYS+b3QQ4ghCGjQrgnjlq64qa5qMlU9w1azkQdik72LtW1xxa2RPCU2L6qaryY7OHAPxXRpFn+eXZAAYZgiqnK288Qw7O/FkJ6dNYNWwmYqKHqkOqYfO70WkrVIieQIHkf60AX5LMz7RBP/QVhBaSKKibG6pbizG8dxiyr9BnSyNFfxLN/T5SmwmK7Xr8uFESQRTS3htTWh5nj36pLabTpvXdrjTfgXDcCecItPTMLuVN4eK6uK97r55gjpXVnultCuk/ceTcuXrvutzfsqxR/LnMwV+JZ2AAGa+IQaHokjwgU5LzreN1z5uppg5wB3LbabrApotQp+EqpA==
Received: from BN0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:408:e6::15)
 by MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 08:45:24 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::c7) by BN0PR03CA0010.outlook.office365.com
 (2603:10b6:408:e6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 08:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 08:45:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 01:45:14 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 01:45:13 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 2 Jun 2023 01:45:13 -0700
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
Subject: Re: [PATCH 5.4 00/16] 5.4.245-rc1 review
In-Reply-To: <20230601131931.947241286@linuxfoundation.org>
References: <20230601131931.947241286@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <2fce4fa6-b6e6-4763-9ae4-d4a05cbe9ba5@rnnvmail205.nvidia.com>
Date:   Fri, 2 Jun 2023 01:45:13 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff7855a-9f62-45a1-a069-08db6345b4dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q16lj7icxDYN5EunCBRFpMIJX4Bz/ZH95oW001G5NScqV6JtM+szmBh+CqMiOVPRDBn4paIawcul76W0Gk8+KSvndxIKOVXaUGY6tCs1W6P0sHoR49Me36+8WTim6mQQTLOrNF8h7JF1al3kkd5TpdHn6MNrJcJLNlB07CTBbxvMaaCwi7ga81UM4sapGoQga+mndRq425wZWEOCCDhwaDaXIkC+77tu2hRLgpeP412Ul5GIiHY9HZooef183g7KWZEYO2psFNEgsyjn6bPAoB0V0zHMotUwem3bMyYz1bfWxp8jLz+w6xUjefVIv7axHb06P1mJTWBglP7zFR9wclyvDeeGnQJVBO3LYX3GRguiV6L4+o9oP1pDcPKtJ2P2QXQWeXVxfD8Rq+xc7BX/ffBxgwiQxJJGhj3hcCT4oAIpb+FaswJPnyaE52njLK56qDrRg7xLmocKfygBEkfL6adTX6psRk1SPPwDgVfZYaOsCnSjmfXZ2nvdJA7Vht9lpX/Q0V5ymXAA9/ZOaYQnwZWcHtM4BqaV2QKDzJLtprtNOT1mk/9DxPMslsV6wZaXtuIeUqivGCy4+urR0xptt/gwZRZhAYeeHSNvn64mS4UNMxGOFv8xgp7gziVZERidKD9NLSpFCO9xhcdUz1nz5lGLnNNGSW08FdMoIyenCDz8nib7B6AfrDNx3qhm6zI7mSVrfTC7im5ZuQeIqp1CFDuMppsYg+Qrpg6biu0bHSA7AXTJG6NO7eUkHZDtE1NJbvFFc8rV+VABzglS1aGp4A==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(31686004)(186003)(31696002)(70586007)(70206006)(6916009)(4326008)(7416002)(5660300002)(426003)(336012)(8936002)(47076005)(8676002)(478600001)(2906002)(82310400005)(36860700001)(356005)(966005)(82740400003)(316002)(7636003)(54906003)(40460700003)(41300700001)(26005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 08:45:23.9433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff7855a-9f62-45a1-a069-08db6345b4dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952
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

On Thu, 01 Jun 2023 14:20:55 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.245 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.245-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    59 tests:	59 pass, 0 fail

Linux version:	5.4.245-rc1-g50329515aa64
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
