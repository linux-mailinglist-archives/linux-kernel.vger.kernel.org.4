Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185166449A9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbiLFQrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbiLFQq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:46:58 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2484DDB;
        Tue,  6 Dec 2022 08:46:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xwr5X6rcfY2T8I3DsDSvgeCpTPxg2c8maeXjVSXKZZfaO2NzSfjwE5C0F/GmAwNv3+w38xTwOhWjaMICrR0PvxGMs9fzoCl7HA8lUCIYLKaWOV0xizLG6fMZA4ljn4WDV1SmQMXhHwXXzaP+WZJKL0+mEKvoz7N2Y9nr8S2h1HFpDX80MrG/AGCQEaX/3aahUDAFZQIoHaLS6qLpNDi0Ue1H8Gmz6U1x8wh3TgIEwbBrdpXthgWMwJBRBH50Ctnnk4zGB1Yh7VeND6F9Jol2OV5hdR7QDqIOR0FSQyvs9AU+tTXcgDE51zX/NvhJN3i4gRmK02U9oDdu4Y0vR06TCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGPsuXe2gFZrxuX48BJa31YhhpbmMtg/f8EzWCKPWms=;
 b=fdw7gX70NHjre1+3AY5m1DuWRDUeE2Gq3/6Y1UrLnzuDdW6c0mgXfZ4+JaMspZI2pAqdyojRrUyok4qVsnXvbbQr/br14VZ2aHVATjGSId5SUw9gDsFGh88WGLRtN7IXsj3EeuNnwLCWBGhQm+Jq7CQm81O58KfaV+w8Y6i51YL1uKzicBVlM7yoPzaTY3VGanZaWYgrN2bVuTMobuI0Q8MQK7EznkfjkV0cLvPKPAg5NS/jDUW1dAZOgAL7vX4QdXz6/n3aogoIOsHPcfK7WlgOl9gebJSi6Z1D8N273vwbWnVgRpSMJhzwUqx2L5Nga9xlbq7H1Uqtl/t4GiI9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGPsuXe2gFZrxuX48BJa31YhhpbmMtg/f8EzWCKPWms=;
 b=H6Olb+V5C1SoHM0z6sKgUkDz+PDkuZMd7hxnSydS4w1zlbEyIaBvHXa6ocLuzryyIcMdYbhYI61HKafk20S/blxThlyJHv9bloglTYZYCGCDhVesSOGOtueBwdKB+2fTOjrrMPNxVODncQZSz46O/yM0MCzQ+oaJEbhypDljsxPLxTHEAFweFFyD16H9CgDAVFHi+sH62iQQKxd9VhSy8iMZUQ6PIqxESOZdIeuR/fjSUwxn9XvFOjPeBYjOoccqMNpFjMfcCdC6c8noEowbANMpBvMQgJKtYp/554RLz6lTdmU5p2/IFOx8yMKfxhqzFNmjfiQ+KY48XPcOCF6ZPQ==
Received: from DS7PR03CA0261.namprd03.prod.outlook.com (2603:10b6:5:3b3::26)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 16:46:54 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::78) by DS7PR03CA0261.outlook.office365.com
 (2603:10b6:5:3b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 16:46:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.14 via Frontend Transport; Tue, 6 Dec 2022 16:46:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 08:46:47 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 08:46:47 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 6 Dec 2022 08:46:47 -0800
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
Subject: Re: [PATCH 5.15 000/123] 5.15.82-rc2 review
In-Reply-To: <20221206124052.595650754@linuxfoundation.org>
References: <20221206124052.595650754@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <139735d0-7d95-4a9b-8da4-933c7e86aea8@rnnvmail203.nvidia.com>
Date:   Tue, 6 Dec 2022 08:46:47 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f091663-6c88-4cf6-4ee3-08dad7a97b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V5iaWQw5oQJ8avcoLGpZlbayvHlfEucWjdKaDg4yAr6zeykSw9Gr0XWxufaBJUVvH0wR0PB49SKoAyNgsWMUAeVoRzPwpFLQ5cyqYghQJJfssMupxiHjZFDU1jCh0v9aR6ilANEora6TD5qacxyll69PRYJrhUbiYkM5Ep+JyIU6z+WWpcTbbisK6WgGqlIF4CPG0863V5WyBEkGKMzeOwCkytQuZiV52TgdxLTje9DUOQgpx6iNTL46izxKdFATXYcOnNeKAnMhz1mNfhEsNUTKaQb145nSYpHgzXnN5JRs8bXnM1iqEvoxZC43C150HuMknWo+6rbmwiPW6wEWLY2VAjKF8uEXX80SoOyRloB83AJUYIPJBLTYGUt79yqwbACXepDneheYh8ww3NQpHps4KtrZIraiX2tcfWy0xnY79lkeI4JxZLswQqX1fY3CQqUjzDQLzMwIxv19yt/UO5R4qmlHtn6uxFpLQEsZZJqNVYEqK1T9h5YJqX1RlQkqVgDWGf6XQttaxS51KGvEPr2KaO/tByZM3Ufd7kYd3M/JkQjeu9H1M6KDwV0sd5L4rWbC1YZDL8VMI+rHlyAuRMVJOVNtG+f6A69v/T1snDpP+ranOCpZa8Sz7ZkYz6uheSFSImo914v23vnR0H/zYro4I/Uki9BaT9jxE0CmyJHaWEH3MSWP3Mr+MuSayGBr9ir2lVPMZ6CoRTAOCEcTizAm3pi4G5foLik7MeebXgNDnBtRzI0Pfkp0i+A0+1omVsJcX9ThZpuu1jZ9cZSE86xs+HJYlJe+7JRLzNY9olU=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(8676002)(966005)(478600001)(36860700001)(26005)(82310400005)(2906002)(8936002)(70586007)(86362001)(41300700001)(40480700001)(31696002)(316002)(54906003)(40460700003)(7636003)(4326008)(70206006)(6916009)(7416002)(5660300002)(82740400003)(356005)(31686004)(47076005)(336012)(426003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 16:46:54.2565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f091663-6c88-4cf6-4ee3-08dad7a97b48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2022 13:42:25 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.82 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 08 Dec 2022 12:40:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.82-rc2.gz
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

Linux version:	5.15.82-rc2-g9269e46bc838
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
