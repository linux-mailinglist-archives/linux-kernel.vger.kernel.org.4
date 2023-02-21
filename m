Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD2F69E235
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjBUOVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjBUOV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:21:26 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56752B619;
        Tue, 21 Feb 2023 06:20:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aa1aKJZAEVRyyyrVhpbb8SjCO+u9xvAuyDpVTRFXZWlxrE+EheXVD3p1hCg0X9VxHAZsM04wiD7WLQnymAXqJ/9w0tl1PiXQ5ZxzPy/1IHpU8z3X7a34i9u1THi23Mwx604Bs8xYaV+bs7vwd2z+/lL5aMvDZW64ZkvXRtzG5HwTM6zhYM3cpo17DXzQl5ao9YtOiGrubX+poJwHKPHGmHo5lm4ZwAOJ1WzAW4/qb6zCtCmd7oLe6Y0oKG4Y+UDwDA/HuCVJCnrPOanofz+IjSRK1QVMnFnjBxC1VmffwNrRL9dX6gXsnVxoEAy+8fUrBXXO8h7NbBHXonRwv54SJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V16ldyIz8EFUm9GUaksDUv+uS7HIqzRfnZnXI0K9e6Q=;
 b=atbwUGDxXX/kmImQ657GN2nQwZ5ckMjRlatjz7oIuk+icL2tM5Xn+Y58lXdGRwjJQZiodDkVMCUi6uo5Ba1T748MnyraE+HNOtIoX8g0MyRmbdNCNRUC7BhdW38urcFaP3jRb8ZYQ2EXXZCFpZcB9TCG14J2TNK5rj4ZRUpZW9tOr2K6FdxWpHd9lX2F9DbBdlAj5e1qrSxTkiJkbQUCt5m9p2m3rxXDS1aZTzUmLVbiwh/pzK+VtJ2hPXjEL42A1IEua1WBkstQd+VRjtlAB4KfGAX6IXNmmow4cMGhZusWV1Chl5XHFCE9GRPHyyX/idsJzbHZr1jaM2fQSrJa9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V16ldyIz8EFUm9GUaksDUv+uS7HIqzRfnZnXI0K9e6Q=;
 b=Bhq658WyHc22ElbKbxeX5P384gJRVP6VimpofNVkBBcYmBm0nfHrV6BZpVnELd+/khApAIWPQgjzM6BhQL3pA0bjKY6TStIkl2xi3bICbmdhmU5aHwTiahjRXNTfkbYdVCRXbZHLa8N0UX0IyjZIl58AotD8YvU62mI5VM/cTPWtUwAj1UCirqDoEmih0VGr73zqwZDPnxCgzaSzK/8JDYKdULPc9s39gD/XZCnP8OTKN3iBdPGbaBeF0d7smDEgGd/rXPs7nqe+fuals6t7Y3XARinhCAH+6ZnlJutLU/BKIUcJQR0EbQg94vyxjRWnZzW2SK8zdprKC5Fhyuup9w==
Received: from BN9PR03CA0175.namprd03.prod.outlook.com (2603:10b6:408:f4::30)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 14:20:56 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:408:f4:cafe::c9) by BN9PR03CA0175.outlook.office365.com
 (2603:10b6:408:f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Tue, 21 Feb 2023 14:20:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.15 via Frontend Transport; Tue, 21 Feb 2023 14:20:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 21 Feb
 2023 06:20:36 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 21 Feb 2023 06:20:36 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 21 Feb 2023 06:20:36 -0800
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
Subject: Re: [PATCH 5.15 00/83] 5.15.95-rc1 review
In-Reply-To: <20230220133553.669025851@linuxfoundation.org>
References: <20230220133553.669025851@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <2bebf4e2-7c7b-4816-87dc-44f8fd8a9036@drhqmail203.nvidia.com>
Date:   Tue, 21 Feb 2023 06:20:36 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|BN9PR12MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: b39fe720-8269-4e05-b686-08db1416d913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGh/yNuNEeAbCQAydwzEU9xLqAIYdPrjZvlaEy9TsCOORff5szD3lJSDHakM1aeIPWx83NbTWzvFdMByjFlzEbOJlnSs8x9K2tezRmB0B3gu4ufRrne+MMAyJi88KK6Dy+Bbcq9aJkGHeZ4AcvTLIPp4wSklnqVqtc0Na11adnvCLB/U5SBTfnW/gofJv4j3PcSdgvqtDv0bAK6ZZ8BrUCus1vk4wzrTu64Am5unJnm+FNftQtGLdR2Wyh8Q4VP26W5Y+wTSjLx5gBWYwJaLqLl91MexKkGbIMDEep/YubD0oVS2T2E0d0JfiC1c26t7HSRZxb4cHanYyxovJdAAsuqWxoweP5KC/+3vTtp3HCJO2yc6Co7YKcSX1dWktK7MPYkwGgiZHhjuiFTsm63a01w8lqIl/UB9iQIIRk8U5F1Kb0gVEJrb3hGM6n0EClB3U7Zseu9bh7a/cHc8uPS48PXdB2VOYBaRS41hyu8NZ1Nl/bffeV65OnpOy5ibUMySNB107dYBHViwX8Z+hLK+XXls+62jije/waUTNxEr/4amru8ESsCcsQO4XGESO9wAIsASOZXLUbebOnVkF3v8vlO41bHJLpr1bsVEhrczreJD2IYt9htJpGVOMTYgMlnooxkZp6Ly8mtMpbMZ0odRRCDRo4aQg8+LLEUSRhiCn0CMp2E4omy2vx6kxW3IXSOD/y+Xg49NghtlxplOat4gq73H4JqFaU6osC7ALNkjPxzSOkp0JkSOmnGHg9CiZF8X
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199018)(36840700001)(40470700004)(46966006)(7416002)(8936002)(5660300002)(4326008)(36860700001)(41300700001)(7636003)(356005)(40460700003)(2906002)(82740400003)(40480700001)(6916009)(478600001)(86362001)(426003)(47076005)(966005)(336012)(82310400005)(31696002)(186003)(26005)(31686004)(54906003)(316002)(70206006)(8676002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 14:20:56.5122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b39fe720-8269-4e05-b686-08db1416d913
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023 14:35:33 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.95 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Feb 2023 13:35:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.95-rc1.gz
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

Linux version:	5.15.95-rc1-g76543d843499
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
