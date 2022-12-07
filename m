Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB01064592F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiLGLn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiLGLnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:43:23 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B59F3C6D9;
        Wed,  7 Dec 2022 03:43:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQERMWlsnyIvVU9w80Q1RObVy3uwvyANk+ubSxaky/6ta/9NMLzZPRK9IjymBF0vTH6YOnDii+TkpQaERfWSU4a8wvpspfMxMuiTAd51zcIfMEmhJhX/QD2lac3mDg0LcbSvWhRAXBav2/ll0bJYyYbe4Ixopm5ULgJd8cbB/cm96XvfGLbhYGIrZwW1D5QYOq3jqC4VZRfffSRNTS5FHOpivQsLJsNr2m3pGI3ER1pda341uv00EERnR98BmREuqzJs+820q7lSLA0PlYo7TAjg8Miu4baDeInYsLTvZO26uPA9SCUq4EmeGE69ae27v4v652PpPKoPFje366MK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OguEvkvsugF4m6WJE2oVd2YqgwVDqQZAnlao1Y23TY=;
 b=M5gQL+tyZyrWC4Yr65STxTCdIqGk7CGYog81lTdGUpdcDfUKn4kAxkSVLnBgst5zotWfJBauBDyZ1G6oCXVnvMrluOy2y9+WKrvzN8/GBYG8r3PGA2wRFEiT+/UuIGlXmL7mIro6vscUIwIemqfLP5VP31sgx7JhHEJU7gM0kWAZk11Qtci4FwJxLsjV8hCfowXORB9SskuwXiboBXK6wqQQQCm2R1aCS126pSez4+LKnCbnh/N4yL5T65IFRscqnY0NfqGs/3aPmt5JdN9el1+vcKUJo4WvfbQTJzMcCfyoTw7G4SUeWBQq6ifC13mM+AjnwZ7kHY8brMyHmAmE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OguEvkvsugF4m6WJE2oVd2YqgwVDqQZAnlao1Y23TY=;
 b=cvVlBiJIx2RSSdeRRoBsKhErnE58qU9LSvKU73zTp4JqKmLV4pEdrEd8pF+0jpBLVC/UM0NgP7RQJ0xzcXSD84q2lUJMzXrXgqK+0BpP4sgdo48FHS2sFLjf8Phq5c69CfQVdnMzWRT8q3zAbmU8h7AkMoeYmPNpb/3I04H+Bk9X/NUye3anITbT50VFt2eZNKZOw9KGbMW+FFG6bxEgXivjq88cSRQROMeRD7+ZGfERbEBOamTLH7+YQvNA56oqyPsnlfYl0Y+WzNvKZiBwE1chGni/dISpRFPf0rwGX/uLnM9azhtGG10xbOzrZMAl3+nTlGSREgUv77XpOAq8ug==
Received: from BN9PR03CA0649.namprd03.prod.outlook.com (2603:10b6:408:13b::24)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 11:43:20 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::71) by BN9PR03CA0649.outlook.office365.com
 (2603:10b6:408:13b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 11:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.14 via Frontend Transport; Wed, 7 Dec 2022 11:43:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 03:43:05 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 03:43:05 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 7 Dec 2022 03:43:04 -0800
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
Subject: Re: [PATCH 6.0 000/125] 6.0.12-rc3 review
In-Reply-To: <20221206163445.868107856@linuxfoundation.org>
References: <20221206163445.868107856@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <9e6c2435-8b45-476a-a8bf-cde630a9339b@rnnvmail205.nvidia.com>
Date:   Wed, 7 Dec 2022 03:43:04 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT079:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d70163-e383-4755-b0db-08dad8483d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4RAwwruxNuS1xT4428Sm3Leio8govjYiqw+kwZyFoMZi3lHIfrrtzqKEe3NN+rmo3CuF2ld9SgEIIPN0HtV/08F+sgC97lgyfdL3Wbdk0MfKC9KiVT6Ei7L23o66CL/IE6K0DSStlJUx0fum2m32ZUTvfEsteEEi0PzRO3dmEOLqhJ2Y0FpPlA/IJKuq/2xmipZ6gkV6fdlcTv3rclQw1UjVOssZY/lvRGap8hm9QUyZwdPv1CoJpuLKF/7G041UwokTlpfomfv2UoDoDDA77DZ1dkd6wseXcPEzpsdzvrzQs0XLFwYctnU/+o6ZfjIIET9z3BRknHR4pIH0EMRtCATIA4IwXn2yF3flcyhpbNgs1+YcxrHDXbpJrspiNKMPNbag8h2fF0bOynH8Q5Uity4JcVFfaRo1hbY/dMrhxJSTHkMpgWuIPrjBgTigYL6+V49XdzjM22NoElvOAf/nDMN46AsN8Chm3ZbEpDQgGJnqI+Y2zzPs66p891I+9ADGW+gW9lpOv/ljLE7qnATrjVHais6Ip7soeaQtmIONH8rQjlxP+xjTruoDRC2/drN4LiMS00lds06/AX9WJIE0a3tc4gNTQyvm9nR4mLkwyMdJHodlYo2IuNl39XYg58QhMmXKWeuIBFBCBFrZM+jHZNzo0KnYZL8zuTY7CFecImHIJj5kFiyeXXPbi/xOBCWVwy/mKC1Sek7oKWaXguRY4WaBCKLGscBPB/ZoI7LIQqhOTI8ic+n0vW71F8hzNN7sNso94wsiBfmTGfcHJ1hoZYUPKq7acEbGANwMNNPeVo=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(41300700001)(31686004)(36860700001)(966005)(86362001)(478600001)(31696002)(6916009)(82740400003)(7636003)(316002)(40460700003)(54906003)(356005)(4326008)(336012)(8676002)(186003)(7416002)(8936002)(2906002)(40480700001)(26005)(47076005)(5660300002)(426003)(70586007)(70206006)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 11:43:19.7081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d70163-e383-4755-b0db-08dad8483d01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2022 17:39:48 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.12 release.
> There are 125 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 08 Dec 2022 16:34:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.12-rc3.gz
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

Linux version:	6.0.12-rc3-gb2f103096329
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
