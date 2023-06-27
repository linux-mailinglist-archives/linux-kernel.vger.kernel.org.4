Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DBC73F82B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjF0JF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjF0JEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:04:53 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1B310CC;
        Tue, 27 Jun 2023 02:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpIyfDthplYgal/HTK9q77tVxhldTNTRAOgWDcPxy6YGqLbrtFsTebuaK5cJnIenkkPyG7WzXthFW4Wn6rY8Ns7oCe1ZlTKdHtBXKgZ5xyk6nd4YRDMyNVYMliiq3AkxDBC3u4UUCCoIzN6+S+a1IW9kGYyQ+7T8Ovt4CFZjF+QoeYmqCNXFtlb+D8RHJ9tcwwtmoSLhIePmCCsZUJnQ53qdm/3Y8g1/EpjziVJh7plj+sOMu9GrA20rd4Uy/IDiYvFuwLM4iEFHLRCEQBW1fiMny4LKWcbEG5EAx9i7tUas4yZBWZWozBp9YXACNQZVvEXWRAPDQdX8IjpKk+mAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xx4Q7N53U9xK/+AEo2Y2ZKhziomrftadwVgYpxrbwyg=;
 b=KYY79v2T3hasKronkbwr/PnzRSU6//+r8K736hlSxmrldfV3h7BpRvk2aCfflana7tpLt3d8UGMZAsS5Wgyfei4xfvfGdYUy4hVjSERKwhq5Ixm9M5KjBJWpxR3QXkplHa+m+5tRw2R3NbG0Hscfwp0+ee2EqpOXUd9Po48Y+OptcgsL0VeOYk054Nqz7Bx3vvGr1XfCdmQi7/cmbuKw8lJ4kydHsK8SpCqLI4vnmpY2X6myx7vJfW0FkWoiWSJ0xRJkaBNYm3jy+BTa633c0AomVmSmM9jp+K9N+vEUGQw0XiDxkvtyJkJPrFT/wJlOEukI5q7YQqHW/8bcBYuZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx4Q7N53U9xK/+AEo2Y2ZKhziomrftadwVgYpxrbwyg=;
 b=il5rhxAoYZvLOSBzStuJBBfBrfZ8sWfs9tixwiExj1CbJCSq8R7k4JhpxMFw8wFd1S6HzVfph83QbLRQ1MDfTlPAHOBAxFxKzHaQkYelIADZVGlxYH6xSa/CaJ75GUWjtnYRNveJvOZXZ3NAWH2OfymWbRpgHMUjPb6wNEGcAxpx05GIZkcxiFItlmIau3XqJVr0WIeCxKpGuuU/1VNGbjCgGEptaXvQ0HT1DWyYA+5Wv91098457yx7Tl66O0bxHOoq2FoXnSqB9GY2ve323t1IHbJw/uvhLeP9TXvtJsb2jndADD/8NHV9+sA69ynmig8z3fxLyG53gTOn/yHneA==
Received: from SJ0PR05CA0090.namprd05.prod.outlook.com (2603:10b6:a03:332::35)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 09:04:47 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:332:cafe::4b) by SJ0PR05CA0090.outlook.office365.com
 (2603:10b6:a03:332::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.16 via Frontend
 Transport; Tue, 27 Jun 2023 09:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 09:04:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 27 Jun 2023
 02:04:32 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 27 Jun
 2023 02:04:31 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 27 Jun 2023 02:04:31 -0700
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
Subject: Re: [PATCH 6.3 000/199] 6.3.10-rc1 review
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <5e8be0ce-2398-416f-9eb6-3ca61cd567b2@rnnvmail205.nvidia.com>
Date:   Tue, 27 Jun 2023 02:04:31 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f3671d-303a-4d8f-d5c2-08db76ed8e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxVykRHOwr3ZAq5AH+qadh3+wd5d0aOyJ1OoBRF33cVKmQJNXYxqE2KhMLiI5FUFg4EI3Ck63UpMd1fN/xn1GG/lSgZVadWddWPK2+Dz1JgsAT1Vvfh8ZfXwajz2D6R9aFJDkRWMZTIZuQdCxv/V6ivWMTDuaviMr+uV7nS/yyGzglv4EDDsnz8AqtSkxY97clHiph5K4s6fm+38XDkwVuT0gibkHJr9AELSVNb+CSB+VA/kBig1lScrbsH3b19u0dqxkVvwtCioqrxXXsDktVmaB7R6Vb3dGOIp1A3iy2Vn48L91Bs2UuHHihSHb7ZvGpmtIiZwk5d4h9ne/H/MOIxFFHrHi9pcSIoz5mchxgnXuXacZ365Twtanyqn0psfew92zFTO7L7m7KuHGP4AkRRwEZv8Lf31Nxr4lgYlCUClCJlkfpJIJ+/y5QjwjTELKAaoDwUEAw4/tKCs1xp/8ZxOTK4w0JcDhJJ2zjXOZgQwfdFbyVSv5v6ZrPKwEW1jCgmPPjbN1H8VtAsMamTTG10asgBTYa3U9dA8dscd8qdqjNv7qDeEDh6KltYAuvK8J0aNmJ3NL2yul2YUSc4JeTQ40nzZN9X44YRc9wDTivkzwGF5bFoD5od3noJxgflqyeKqFJS5Pwx2XgIFxpsnmvBE1JKwt4vdLFPOACzXkJqt1HLy+YaFZ+d2nngf4Oa7rI5/2FRL0OginXxOqp7Wq99+7CE+V4qNce3xvOLcuICJdKG6qp28ty77SXh7Ore7EiUXG4H7yebpHrtHnoOrLUCjfMr8BFlF4Di5/yIB5ec=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(2906002)(966005)(82310400005)(356005)(26005)(82740400003)(7636003)(186003)(47076005)(336012)(426003)(36860700001)(40460700003)(41300700001)(31696002)(86362001)(40480700001)(54906003)(4326008)(70206006)(478600001)(316002)(70586007)(6916009)(8936002)(8676002)(5660300002)(31686004)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 09:04:47.1367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f3671d-303a-4d8f-d5c2-08db76ed8e7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550
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

On Mon, 26 Jun 2023 20:08:26 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.10 release.
> There are 199 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.3:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.3.10-rc1-g3d49488718bf
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
