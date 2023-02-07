Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4951D68DC8D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjBGPIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjBGPIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:08:22 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B75959D5;
        Tue,  7 Feb 2023 07:08:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKsE+VCYNLhzzW0nGXJKGPX7quURULTWW45yGNZiv3hxQgw+bS2W+FxGDUqjphA21F4/rokPSoDZQh74T9zmS+Ul2f5Hn8KvMYtXVPsOpgHyq8vmvCehMVkdMoc9KedBiFhBXqHu5CZkaYBbcP90L5LUeHoceX05GuEMV3FDihF3scVPGQ5AhpuUrsZmePFGOnUS6no4bQomOuR5jHvjMLtahoWQT5jQHns7BMY3/UshJ3Sx5ff1d8xCvYoODVlotayD9vMJxQL0owxyWDhi4E4n5spZS18AF9fGbXQZPtaSiMxeDBwMCuLR4r+huZxvPpXYvqAMg0Dr2y9g8QLGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKPsn0zMRiwER+bBRc0w5qBk+2oTeZ1uFiziNmlOrwg=;
 b=W5pmFSVIT1eH0bE8o1EjzWePywZZQH8ubFReSkwqjdJ/Om4CJ0cvfvftY/D8n5/Hvp8XnGBDYaeO0pgHyYs57n6CDNrvQT5ArE0kh+p/3qA9h7g6GfMsHvBtRZ+p1gcBkAIo0T0ctgqacbhLdeqsB4EKwUfZf6+5axN7tHiCP20P1BMzJSwgqUFQOXxVD0uljdj+Ora2h90dJ9k2fxZagTTDTa7F/kDL/OGrg0Vyes6AAKDZ2WRlMTOiKVFKwKPogYX5XpmDxZ7WUtx6R+jVn8YZ2Sx40rExw4BSf1MWRfxfHMa8Izw1NcwX92VjnS0/BW7LfAAdPPXHZ18kMUBR6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKPsn0zMRiwER+bBRc0w5qBk+2oTeZ1uFiziNmlOrwg=;
 b=jLHhdQIMIfbAx24NYaDtZrmt7R9RZmwQrwh7Pnt4qFXj9uW9bLJi1SQUQsRj7ncakHuNui2zG5PChXVTN7Y3L4Ax6tzQagwOgoMmRdURh4gDpaK82koS+kapBnTZhdPO6JrfMG7bquRb7kcYhmdlyWHvBEftPg5tCX7JnIFA0Zm4q4uSyBe6lzM5ohS7xe5GF7hgR605apwms+aG6rwYeWm6SA36sgY7jM1PlzPnNlK2lV0RpFTrjKVyQG23pMtVxQz14zv4b/m4TBgZmDCTmxPNKGAaQNMeTONQkl4HTHqUlg9QMKxGAcQfWjoYA8U8Ib4m/nRfKzqlkEw2CQXV+w==
Received: from BN8PR03CA0002.namprd03.prod.outlook.com (2603:10b6:408:94::15)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 15:08:19 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::ef) by BN8PR03CA0002.outlook.office365.com
 (2603:10b6:408:94::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 15:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.16 via Frontend Transport; Tue, 7 Feb 2023 15:08:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 07:08:09 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 07:08:09 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 7 Feb 2023 07:08:09 -0800
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
Subject: Re: [PATCH 5.15 000/120] 5.15.93-rc1 review
In-Reply-To: <20230207125618.699726054@linuxfoundation.org>
References: <20230207125618.699726054@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <aaba1134-aceb-4f51-8fc8-8a30026bbfe4@drhqmail202.nvidia.com>
Date:   Tue, 7 Feb 2023 07:08:09 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e927a6d-921d-49ee-4025-08db091d25a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51hYFXt8IM+HQvDbEuKlC2dQOgCU9RQBt7M1bixZXd6sZl+b9O3oZHx/hfK0aBFslVsyAXJ8I4qfxeMQG2BDqOqagbuzpqVvqBFN0Pw2M1LMkNu71Z4AbIjHh1L4s5HpyyZKitXun7BDyNo37jS7s1hukraI7EchLosBNEtWolXfcpDO9z+vg2kDHNQdxMgHO71GoySEKDwX0EbzN8ax+4RJwGnddoKQbFM8SyMsgThKiB0yVKU315z7B/EyFxjuVP6Nqh3nSpi0NZAYWyEq1WXaQBJedzqjOnwdb8OjH9pfAeVgJlIZ08M4AWE3OJEqKAj85ii5ZXidJIRpvA2M/oXwLu+PwT5YxpFu6dHJNdwez1/ewEuIku0WFDEdDMBYDMnep++slGTjd3kh9XYel8n5yiP35INhEPwCwLCh6vRBzbG13kTma4cFvYgIbKpoL5ZfxpshZ/yyNg3w85tRReRZm00OF5b/feC6vwYXpQqdYVQqgoRFWIAhsLxXhE8ZAmQLa1OswBjY1/AnZrRHzbwQYZdoTEkfkH2SxjqTDHthYYZTWJdxsL3GbFa/mXDPP2PxM9f/PDhmSQ+8GgO9qY0JtV9sy9Axih1yNR6siSU8luXGKxk6npNPRn/LZ7JJS1WxKAZmy+YoXPgANW/5Q/eBfG6RoXhzd1oKujUtQoe6YC1ghoCCOC+O4JcoeV7OFhVZ6gfwXh0sSBflTOv+X807V8DGFv02BPby+JwpNDaiswuNPSuQZP1z/OnzwFoy7G45Ffu8Va/swlik/i3U1oPctY106ZMVGPg71LFvIIE=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(40470700004)(46966006)(36840700001)(40460700003)(86362001)(54906003)(316002)(966005)(8676002)(7416002)(70586007)(2906002)(4326008)(5660300002)(8936002)(70206006)(6916009)(41300700001)(36860700001)(7636003)(82740400003)(356005)(31696002)(40480700001)(26005)(426003)(478600001)(336012)(186003)(47076005)(82310400005)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 15:08:19.1420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e927a6d-921d-49ee-4025-08db091d25a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Feb 2023 13:56:11 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.93 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Feb 2023 12:55:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.93-rc1.gz
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

Linux version:	5.15.93-rc1-gbdb0253e989d
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
