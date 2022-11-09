Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1216B6228F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiKIKsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiKIKrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:47:40 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D294A275F3;
        Wed,  9 Nov 2022 02:47:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bs5nCFTIKLnD2BrSvLnvzw/GibK6NgTrHItv/yFFwTEge71KOoyWE/MgN++bHC7GqZAeIosMPngUiGOTG0S7dJnOsbNrlLEJQxdJ2ammooaAe+VMDczT20SqdVsjB/Boh/qPTT5sUdeR6KAiKuzdvMt4acCBFTo1ZL1+Kh7YLpHr0AzGo77cZVR9gYB7FGyRBc4eZI/zlI8LpRftZiUwp1JDDXEifGXTs97nrHBsiPrp0ZOv/wvNyy0ocX9TIsmxbzindLzkyvTbUa3OiJhyWDozRRMm8mTzakksStOuigQNj/aFviPBBN4r66fOmKt9bPHYUqY5zEm/IjEbhPuTnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGSH3Az5bvrM7rAAmbIgHy1PEn44UCb5SmGwf6nvA4Y=;
 b=dTOaCoizrRU/Jc1CjhD8aZix5nLHOYpsxdEXZlwJKpmCoEs/TTG6yL6tVcitpOkqBvNaluTmjXTfvvwpcQy1ucH+5ElZo+CBiN4GIkDzjTiL1R0hR9SLHhyybPhCbSBtC2B8v88H8ZIewrAbx553yiASlD3gXAZ8AC6ZrfWxggh8EpcuCB7IpfniFQAXUNjEuLdbc67r//JJHQL8qMXIDkElcZ+ErRXyv6e4UV0pJtsoEeCEiBg8bPxph2tD9WH2S4RJO1RrCJtROWkzunSufQjCZS1p3JyTfxojwUWg8q6oTGqrUojk9LdYuV7nYnYSx/BlDeSDUw497J8QJJPMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGSH3Az5bvrM7rAAmbIgHy1PEn44UCb5SmGwf6nvA4Y=;
 b=G9h9i8JryTwAef6w1uXKpWLeiERIvCdmWiGWz3MKO+PS3UHeVhPtNOgoVaUlmoUMWs5G0VPIvTpk0ZsFq+KQUJRtIEFmfDQx1om+nuiT9m7O4UxGRCJh2GIoMZcA+fJ5FFJ6g0nFvRZwAgvq0Ch6E7wZKncibPfGZwnH7ixPPqBvd+V3ePEUGUK2/H3dJ8gniaasigyDBzocSovHURE02A+vm7fDvSy8L5l/lSY5mKWnxA0mugCLuDOna1n+NFRGkX9YCryzQ1im6+HxUyF+xopPfCfe9Ca7wjCLE2luoegwGGvThGL4UhRQOT6LDHi2MXhmzlzW+YSzsMV/XN6OdA==
Received: from DS7PR03CA0151.namprd03.prod.outlook.com (2603:10b6:5:3b2::6) by
 PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Wed, 9 Nov 2022 10:47:33 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::b3) by DS7PR03CA0151.outlook.office365.com
 (2603:10b6:5:3b2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 10:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 10:47:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 9 Nov 2022
 02:47:26 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 9 Nov 2022
 02:47:25 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 9 Nov 2022 02:47:25 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 6.0 000/197] 6.0.8-rc1 review
In-Reply-To: <20221108133354.787209461@linuxfoundation.org>
References: <20221108133354.787209461@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <5306540f-0a3a-46c2-9092-da652b61c711@rnnvmail205.nvidia.com>
Date:   Wed, 9 Nov 2022 02:47:25 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: db4db40d-eb3d-4bd6-9e6f-08dac23fce4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ekfEB2De7rQxSgnC/ekmFZe03fVv9BCAziKWOqrSBRMimQdkPmZygeYGniT0knH5tjNZ2x8vMCFwZYXuuVsDzBEQIWLcYyYGAod1yFOw/jycEVDr6BgPAVv7X0bJvb3h/bAUFd00/CcmjXnksh/EmoGs6sBxqAjHGVSCHoAlwJ5tJ04QWiLpY5lVHPvDYUitPObdqwgYm2YTQAsiuRhxxVPYFt+REM0WvMzCXXHL9O+STJ9pDvFOiJBh2pk3TsX9VT3idIjNe4AY9iOLr+bV2jjIIBQOQyDUdADy2VyTeMiLn/jyULM64muuw7niBnrrueD10RL/65G428MxEVv0YgI4+QLx8wNP3goJUWuMDCECe7pyPcIbNqtXp1DWT6wIs7V3MJRYbDX0enLXSYsNaWKZYS29XmqJtCcmwMFwLdYnZj2Iszl2toZvBXChpS8iWuJtMEoAbZUB0bFGcodvCjDWDWvjdVvEubsnf+ptVlrwBiK+mXBR2THplOV8b5+9SPW4VzqF8Z/6iaJB4luHlIErBMxcZnhPg9Zxeps6TWUJ5IgbYaiV32sTVlSbUAQK1IWUg6GqxkpTj8hEuBnsE1OMwnJG244AXz+LT9WDzpqE1ficbipIpqKDJ8GImD50vOTh2BXED88uNXkujFfNmRYkKqVHdRsbQFZaqbI3PeAJUrhbOVQsu1Ks0PUKyeVwTUlPORiMPMFamQ+lCqwzzJcX1i7NnRH3sp3v1eu8jqiWDxe2TYg1iZVpQGoy2X0edZC7jMWXt6mRmR+xFqFB7+nolNYp05zRE6Jgx7GfcaDtWxyUjJh35YTdsEYXTFp3x/L536FSlp4yNlV0EGbjqoXtct0+QDFkwyzr0C59sY=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(47076005)(426003)(26005)(356005)(6916009)(36860700001)(186003)(336012)(7416002)(8936002)(40460700003)(2906002)(40480700001)(82310400005)(41300700001)(5660300002)(966005)(478600001)(54906003)(4326008)(8676002)(70206006)(70586007)(316002)(31686004)(7636003)(31696002)(82740400003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:47:32.4730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db4db40d-eb3d-4bd6-9e6f-08dac23fce4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Nov 2022 14:37:18 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.8 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Nov 2022 13:33:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.0:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.0.8-rc1-g87175bf36da5
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
