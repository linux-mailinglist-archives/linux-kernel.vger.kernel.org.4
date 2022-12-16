Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D9264EBCE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiLPNFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiLPNFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:05:10 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA9C14D03;
        Fri, 16 Dec 2022 05:05:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StoylNTCICj9fT3wv/tbmRAuWdpgnFwquWdvoCahHJaQoV2DduHDJRUYihrBnmoRo9jL911asrKou3yjmK1nzc+NZQz/FQHw4m4DvgW3ZaTOH1K38VsboQ1j1XuT/zhLa59RjmZI1KBIZ3BrVHaa3gnExJnQSelTJ6enAMGwUFigBiaINjXLt/Iy/j2eschbJxH2PZTTIqa7yONp/csbanS1YZ5qEmTvrJp+qWI8fXq7fZvOTpKy7Pb0ra66cJ+n2vP+T2kYug1e6oYY/bAkYrUroim1nVoWe+J8MKfSxboeUYMcezKXsZZPVL0Q5JLlcSEM/+XQ6e962Iws1qMXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8n3Z4mEXkmA+gIvfbOGJdn59DkynM5pAjrZa5ho+aY=;
 b=iG54v30m1aa4XFFhjvpb/VPuhcs3wGM0cYO5DEJ/LSB4EHJuVoJ8rHjjBGZOghyuTZb3F5xdVm1zYI3lO98iUDWKA39hSCkMOZdwrbU7CrmGc4cdGyqp5VjRkwXi/bQQ8teCIuyVH0r5y40mbIvqHvkcOtntnsBGxC2X/uIF6EGnrt0uxqJjYi33Wt3QT4VAW2bEFR1m2WrC5ZFWoBjedmwrQ9lQVGLge/4l5JWy18q/zxFWPfaxiFHB3qmSZXTSyZWEDBgMgF1zs//bIzhNFtC+NoF/XdRzi+1QPmEZnbnNfanO+mEacfo28n3HZhGxEvWVGu3RhUM6F59aBPgKEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8n3Z4mEXkmA+gIvfbOGJdn59DkynM5pAjrZa5ho+aY=;
 b=lGNFBbJ4XMOC9ZDgd3r26jPwh/8x7NTaQYw1dQzvkWIzqeFrut/m6IyC0fMio+9foI27OO6PAhysVOUm7tIYyK1lMBcgLw/jiaB8ISZb7VgXXr0rVmfqs2X9pGe2ts2JV5kvrw0CBdsfMlWzSu/45fA4qlsRg80bgy+xwvq/tfIjP7dJhU/Q9nKcvuqsrlqXp4g/l73JyEcXvVDMqWQVapsw5SqJPUpMKKay+vST8CDa+x0/3LYPBtVQvvH7p9OkfZ9wNjcQo2TDtBHkep6BENmy0lN51gKx+b5yraPDXAn0HEpc4ygmE+Q7KPA+bwmMWXOiHf5930BlM67LaiNHLA==
Received: from MW2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:907:1::23)
 by MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 13:05:06 +0000
Received: from CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::d6) by MW2PR16CA0046.outlook.office365.com
 (2603:10b6:907:1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15 via Frontend
 Transport; Fri, 16 Dec 2022 13:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT092.mail.protection.outlook.com (10.13.175.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.15 via Frontend Transport; Fri, 16 Dec 2022 13:05:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 16 Dec
 2022 05:04:54 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 16 Dec
 2022 05:04:54 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Fri, 16 Dec 2022 05:04:54 -0800
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
Subject: Re: [PATCH 5.15 00/14] 5.15.84-rc1 review
In-Reply-To: <20221215172906.338769943@linuxfoundation.org>
References: <20221215172906.338769943@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <784aa672-96ba-4bfc-a622-d8bdac00df35@rnnvmail201.nvidia.com>
Date:   Fri, 16 Dec 2022 05:04:54 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT092:EE_|MN0PR12MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 26de6c4c-3a7c-43bc-e684-08dadf6626d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jbgqSHm0xPwTEKp37w1bUiJ+I1G5Y+6UT2jtZWX2C+8b3jIycLjHKKNrZFabVqr/l2xw3MgbCxQ1tWAYRr26wuFRN0HNTumw0jnY+mD19OwtjUJcymQr9NyprlA6xiLBFjwThE53zFdbNfdxHhM9SLbvpmU9WltTWSrDd8OlOZos7hw1bfAsir45B1LmMj9qbDmvh9e8aj14bpb5PEVTUO4FKIvHGvIxkp4NsbcoRqKF4vDmwZBEEkEE+Jg6Z8gfj67fdEVc3Du+yQvRPlEx544nCRBy5sTggi6vdBihwSlt92E/XmVKne8undr/OBFctZgsWJkdQB1Dkp/5D+A0WHgaXfZ3Txbo3ZJ0Y7J18Qxv9qZhijOUgovzLYvllfwAHOn47kRJOLLL7ToD0XNvFN5P3TELTANQ69TpXJdOp0TKaWOiQuxk5cnkBJDdrjUNPOaEJEvOor1eSAhH+TlFRzMIbeMbGob+vqrDolyaQB0uvKeD2N3OFZ+iEiji1Oa5JNFpdPNUYnzua3q7oqMVor9O+wlfy25O+H/7UzOXwRK9u1/6NciBjoMKmNhxEuNnXmP9he8Y55lYkUC+jioCbp1qt4RBa8Tw8oQZCfUgHCMoQ71uL8qMiynH1WY5uW/ADgeUar29VSfnK83+OiXX4ypMf+/arN5RVg4ng64l0+A3Xszn3+4AklOOXieJGxdR3GOI43PUwGk7sZsISdWk1Tvg1Uj0cGeBGIiwZE0kbP5fzpEPrLRSWgWL/IGHpi6dpdg0aPG/n2+mt7ChkJlL1S74PS7au6qv4l1xkaosT8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(31686004)(4326008)(2906002)(31696002)(7636003)(82740400003)(40480700001)(356005)(86362001)(47076005)(82310400005)(41300700001)(54906003)(70586007)(36860700001)(6916009)(5660300002)(316002)(8936002)(966005)(7416002)(8676002)(26005)(70206006)(336012)(478600001)(186003)(426003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 13:05:05.6266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26de6c4c-3a7c-43bc-e684-08dadf6626d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 19:10:36 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.84 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Dec 2022 17:28:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.84-rc1.gz
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

Linux version:	5.15.84-rc1-g1d22ad610255
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
