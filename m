Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B386D5CC3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjDDKMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjDDKMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:12:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9889C2D49;
        Tue,  4 Apr 2023 03:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UApHxnBsG9eQI7w48sPyXwAHVbU7QTDk0f0bTd1rotQ3nNE7a96usXqwJnRMu/505fyKQ/p8yoDFlopEIwmwaDVU6PaBbOFX2eCbXgoGZlFxT+3DxHloi/afrErVqGdJWfrz7fHOmckOdejiNuSKMtE0W4kcDbt1HbQVwz1mqc3tNGcDe5wJsny5HBNLymWeaNbZwkhSoO/C1TKlhs81CWrwlTRnD+XhsITmw8e9zWsXGGJ7C+VkkaVZhS9GAJyRQiUDNMODeCoR9E9/2dGicb7JSVqxDp4CsuuSsJjAGSwJXk4cc9L/P6gRJg4WzYvHfJLhapHHdOXgKW6ON5O2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHL8+ZoGtrEuTAbzk3JM6dO1aPac/YTPWFT5J4aE+Qg=;
 b=Sj59NXRXqar8Gqvhix487KuC9Pr+PausKEVQUvDT7z33V0kQLc4dIQB58wpSZRKoXp8L+SZTVbGbnbaelmHNNC/4t+vd6iWQ6zRoogYS04ttAIlw0zlNzIusRKmKBJ6mKDy0lfajth1B5i6ewdZfhsUGtcCBEHiAa1/Mz6BSBzNp1agYRL6C+/psc9BvWw1hnlTTYcoNbBeQAZKvTo41dj10RpUEhcmtsAqniwaRxAKhNAfy62XTOnd4wNb6nnOGLAeNdM4/yNk5sXlefAA79cqdSPrY1Wi7vYQ/CTrhAkbTgjG9esJr7QR+Dn+aLU/maCJPMdhAFGsQpskS2zxKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHL8+ZoGtrEuTAbzk3JM6dO1aPac/YTPWFT5J4aE+Qg=;
 b=qEcT7h1alVmd7sjkGDWtzbzLObwLggPIFvXttn646/TFUe7PIDn8VynV8CHHiuSC+JOICfUwVOPAp7WjJJ5wevqP3Q42lr3ksGVnQ+/SBAfudfusovL+4VFJPt7nUutsl4iBZ3m3FzVSd4rmXX0viQaLmUcx8Xpo/AYF0b9RqvIMnFcbNQTEs+qj73wYszaZi6+dIPFvCh0oXW7J7pcyZfz5Rmt8o2/Xine4BQWVcNKn7wGFr1Wo1mGm2+YgP1eXgUlmvAJvPvVb+YhNwPepCgSG8sHlJ+wzDoDjQVlChyxRjC7ODai46eMO90LbCiYKdHzPv6KF4aovCXLa3BLdZQ==
Received: from MW4PR03CA0207.namprd03.prod.outlook.com (2603:10b6:303:b8::32)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 10:11:44 +0000
Received: from CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::c6) by MW4PR03CA0207.outlook.office365.com
 (2603:10b6:303:b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Tue, 4 Apr 2023 10:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT115.mail.protection.outlook.com (10.13.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.28 via Frontend Transport; Tue, 4 Apr 2023 10:11:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 4 Apr 2023
 03:11:25 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 4 Apr 2023
 03:11:24 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 4 Apr 2023 03:11:24 -0700
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
Subject: Re: [PATCH 6.2 000/187] 6.2.10-rc1 review
In-Reply-To: <20230403140416.015323160@linuxfoundation.org>
References: <20230403140416.015323160@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <5393d62f-59e4-4d54-9e67-f9f6ca15f324@rnnvmail205.nvidia.com>
Date:   Tue, 4 Apr 2023 03:11:24 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT115:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 762e122b-52f4-4e7f-bda7-08db34f4fdb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTMOh7myCxmMjOKcLAOYELLqWmWus7vlyN8lhuifDl1Tr21zD/+7mANqO+7RbN+IYv9Suu8GXL4enGqGOrbCUDSzFDe4giFIo2FF1bxNhmDqavlsgsT4dUyoyqM5PK27ajjQStrGsWyZT/74doqbxoatogVCsPSWtZc5em+1o2iuIU9oVMa4AF3FyyJ0UWsBWhalrAVJW1ZdgxevpR1E81idFVEjpm6gFYsQG0yBXS+u50uh0BemM93U5ht+u5OrPDe/SLHz5O5z35XHKGBMpSTv33PtO5QbZwGEQEivBs9BdI2w3nFUyHd8sYXhcMo/EweiWpUOkpDPX2jI/3l+61jzt1ogiSHJGB8TgIFjWn1+TORG2ZEvm4g0Ev9Mb9c2RHQXtQmZbsuniiHomdLJzgn8k1rzof+fOdHcfvQr54MX2tPzrWG+DMTmPcMgSYInYcEB29rwMMTTN/XHTmSgOHaSTl1exUE6fG1R5mubxASJlXLwu4bDXeGkdALaEXDeMBasC+pZ2DGqSKK5+C6k4BnbE5SEioWXiQ9BjHBAi11isFJbjNytvKilQgqagkOKknOiNtEBrAvp4NPEaynSLIX6hEYQDbEDfjcxCvQ+utwfF0OQQuKfJajocuCh5N8EQMeAjuU8KiJt0ZW2iUHtGViTSRe7BdC8vZBKa91f4QI5OTPaoLxpU/ehJ9Zfc/GhVsnL6iGyaX1UUGeghgFu7nDHbkXaFzCfEHOPSb/j9F1nzAh/sEiPgNq6+53J834ED7Q9uaifpcRz9X96s6ThxYE9t26ZJ9O/yB63CT39gl0=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(478600001)(40460700003)(8676002)(36860700001)(6916009)(70206006)(70586007)(316002)(54906003)(8936002)(7636003)(5660300002)(356005)(82740400003)(7416002)(41300700001)(4326008)(186003)(47076005)(966005)(336012)(26005)(426003)(86362001)(31696002)(2906002)(82310400005)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 10:11:43.4771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 762e122b-52f4-4e7f-bda7-08db34f4fdb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 16:07:25 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.10 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Apr 2023 14:03:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.2:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.2.10-rc1-g6e4466c69e20
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
