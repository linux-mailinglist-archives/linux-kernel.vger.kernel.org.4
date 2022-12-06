Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C186449A1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbiLFQqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiLFQqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:46:51 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72442BB0;
        Tue,  6 Dec 2022 08:46:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTsqhy2pX24LOCe5NOAGHKJcMhgx32FASXdZMflCSIvUqvGwu1KS433UKwt5IZ1ZweU50VadyxdjWaX0RKTHUs7ZeoXb+xcIB5I4fnhXnsLJcaS1fSattVp1/MrVY18yMeNXgwv9EGGXwzf621rUBcRsQi052Tde8qwsWoazC2W17dQeexdDyuAAO9XgMcuSzycaerIQzZCj05KthsIuEn7vamHnd9ldbyzq/ctcJ7M8VAT93bayBJe2N+039zi3VQLwQm1mtW00w6m+H+gSsXK+j/gSi0o3UKg1inhohU2ucxZTCOJWFIaCbAYJhprg8KlD+SqdjvEGXE47R6Nn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lN3lr1NEJ4BYun/nXI1BCtJyIdqF3T62urHIc5D0/Ss=;
 b=mdrlOTlumPHBxDKAuoHrRCQvHDUCpOBpu35xROL2JLAfKeG2Dou8+dDOlz6i9mAcGLM0rKGXeTK0X5vRSWrfzGQu/nQJmm+V8QH2XE0Nt0OZ5PoovEgZhJYWp7WGuB2goav69Mqaksr68qwkJojiYEuvt4kVMIvDMd8gt0LoQwrgB8+CD2b+/Se7q4WxpcABU1WjyLA7sR+dRnq2PFR2ALlcfbNjt5gv5VNaAUQKokIj7oAWZexAga25NeGQGzB2BdIAbHgUaAkaOTgT60a+im8LMw8sbjRi8mWqH/hB9kul6ZMZU530m55sTly7nTc7wVRT2W6hPFUvZw/R8z6ACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN3lr1NEJ4BYun/nXI1BCtJyIdqF3T62urHIc5D0/Ss=;
 b=oTc4R5CDLhtBthoaTdCDmECJi12qC4uC3MNSSB0cMg7pFrJFMkj1id7aOfx1EtC4mEhuGsGD3J5GhRkhV7hCTnMU7NCaJWpG+Ci/+VCZWKV8PQUAWfdAY0mfcTrBGa7ZFvfwsPjxIfVxr5+iu6t0Pz3/fsqlQklItgYmfNg7JSh7XNQOA79Zf+VCn3+qwZYGEHDWjuHZN1EJlztIkibF1ohL2KIfGPjaJDuXi6gaS7wSFSS8lrjT3TuTFKjn66PkxtxYhHQ/KioY0C7qGnS5x+pbEYPJhl7iHAuHtC+YrJ5udd8vZtxp5d8Nk53PDcHwy2EgzExQRmTzUX69ZVFFGA==
Received: from DS7PR05CA0044.namprd05.prod.outlook.com (2603:10b6:8:2f::10) by
 DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:389::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Tue, 6 Dec 2022 16:46:48 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::ee) by DS7PR05CA0044.outlook.office365.com
 (2603:10b6:8:2f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5901.8 via Frontend
 Transport; Tue, 6 Dec 2022 16:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.14 via Frontend Transport; Tue, 6 Dec 2022 16:46:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 08:46:40 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 08:46:39 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 6 Dec 2022 08:46:39 -0800
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
Subject: Re: [PATCH 4.14 00/83] 4.14.301-rc2 review
In-Reply-To: <20221206124046.347571765@linuxfoundation.org>
References: <20221206124046.347571765@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <acfde5a5-0252-442f-b662-dd8015b1140e@rnnvmail205.nvidia.com>
Date:   Tue, 6 Dec 2022 08:46:39 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|DM4PR12MB5343:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a7176c-2d19-4ec8-ca7a-08dad7a976c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCZQB+AZnxP6J3tFqonLencOeJr9Af4nuKV0RS7bqFY+2bt/rmWTokqu1191eqDbbmUM973T9NDMNW9cZ3+Pb8vlH4/SmmOmPiU2bHlkIsNHneS4b06WDif0E+g6+IQD8oCckrR1HsKHjc/QcFSVhwiwqcyoFpJTP1Sk9EeCtBbPCn+GaN37vswaM1M8Qxsb+6DUqN7X2cqBtm+cd4xr/YuLaVg1rl85eTaw56ijCWYizIBwqw2RSV9A1GwshNaEnP28RMS7wFv8LSd9ikGNnkufpKtL5B6JZBMHYkMTLZGpvIsOayoXjvszepeHYzADKHpg9H4tm+DHm0fUTsAuPYK+nIW2GBdGu0qrTL3VUcj3n+znGDCDylBoPnl9l6C8agn4rSDdFu+hQROZ7jbfqDrrFRLWFpLh0fRxowKM6Hrajvb8Sy2hCbbDDfwe1ZPF9hW3kW1WaeCGlB/2zWe7efr++JGOiHqbUhmsPolwg9nZsDefrwfbPKlLpaJwLlONKcbXxoWpdKSz/bKydjWa858yB/mS/TVOIvYLpnIDoFBWbDxGmqK/N5PZePrTUt3e03ESHEkq1QpxqkPzmMvvF+1Pg5ipoW+8j7YNmPh0gEiw5lAP5Y2BibNnBGofvQ/QqmxV2ufSXkPAYQs89CDwprne+JrGAoK38N0i6hVvrjSTACLtJq2tmLVpZr0Mi50E8Bb6I684gFv8JrY+BHcQEm+kTXD80ZTJnPsr71XYYXmw72KWO34XCjpTJE6hhmbNYaHRfg9CXWks15ATbxiQmydTKWJivfGu0iFjbFbJIWg=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(31686004)(31696002)(86362001)(4326008)(7636003)(70586007)(8936002)(356005)(41300700001)(2906002)(70206006)(478600001)(8676002)(36860700001)(40460700003)(6916009)(316002)(54906003)(7416002)(82740400003)(966005)(5660300002)(40480700001)(186003)(82310400005)(336012)(47076005)(426003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 16:46:46.7321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a7176c-2d19-4ec8-ca7a-08dad7a976c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2022 13:41:52 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.301 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 08 Dec 2022 12:40:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.301-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.301-rc2-gdd6fc0ede260
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
