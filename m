Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903E76A7BD4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjCBH1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCBH1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:27:33 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11hn20300.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::300])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACF4211C1;
        Wed,  1 Mar 2023 23:27:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGcsnHpPrIZ1/WkiapE0aw1vsjVUmSVwQg/3SLtg+I84eGIb6pyOI98EB2AQ1anK1txoFD/yNOhfxTMKimY7WnzBMhRYyF93DiPjtDN4h+Eteo68pXihWdsRhRIXZB6An0QgQnKgMA2JRVAr5s5raM+E23c5fZWbAOYt2Hso7nWjg8Wngo4rxMCCwReRDz98TVoqmVntdfVRmb/WSJKEniCxYWJPIt3mg5NBBF1robvu/c/RwBBrqYY4jy3ml63/m+Wa8Xx3Shx0m2UAxy8z/qHJfMy1C+cGgEOhP1CkOOJXPGcZEV7q5RDIIwZl5y8q/HPY8uCfF2jJHXs+AGKg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJBgOXQTn2yKDSG/2xhdGEYA1Prb1Pp7rPzl0e56W5g=;
 b=ahFiufHQBsxNGqX9SN7yak7YqBjHTViXtM+DTnAj+JIOyb/74+9/whIe7ZbJo+4ZSVTVpguLrTQSuTmoB4vPsGvPyT4Jmp4yhzOP9J1W2rcSQ2mOWcswEjqJKhbynDWwzD3XHbQvgd41LdX+IoBVWa5RkccwUrnUN7O3nN1VElvood8SKhlilKkJs7L6dFucU6U2HEJH/qBuR31KlYaI2jiFtFkTe28E+UDrgV5JQpnyo9Gu4CJGOm3ieqBUdOruk7Ok14vlNX7NVfzmUa6jYT6rdZGFix8j0NFrhnctLVgpzAUTD8HZ23dFYb4C5aHCjgsJGgNQt9JtQIkp9oQmig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJBgOXQTn2yKDSG/2xhdGEYA1Prb1Pp7rPzl0e56W5g=;
 b=ieDfZw4r6apAteU1cX7aS6vmhCSOl9o11gplQx6NXa7/gJIxg/bjR8LlDk/nGtc8kdJNQcEaY40+m1nFrCYhYF8u4z4Zit+svk9bBw3lqiZa8RhX+Zf+U5DUPXiTXXzzs5WBqP5/ql3UQ48eEmDTxPJXwwsmag8oAOr22NAHRwz5CiV6OXSRvlhxaiN+GgAZZAEm8a8PLKFPSur5GqupqNO6xBmdpUCBv86RFUucasXxgkV8WYSwKIIcN9VdKWM3gl0o87Y+Vs/Ovf77RhGGt8fg0/N9LKxu2bOEwKdx8+Yq7bf7UpfME4DqylvtKtk8rofZFshENhWhMechJ3XcMg==
Received: from MW4PR03CA0117.namprd03.prod.outlook.com (2603:10b6:303:b7::32)
 by DM6PR12MB5007.namprd12.prod.outlook.com (2603:10b6:5:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 07:27:27 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::c6) by MW4PR03CA0117.outlook.office365.com
 (2603:10b6:303:b7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 07:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18 via Frontend Transport; Thu, 2 Mar 2023 07:27:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 1 Mar 2023
 23:27:21 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 1 Mar 2023 23:27:20 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 1 Mar 2023 23:27:20 -0800
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
Subject: Re: [PATCH 4.19 0/9] 4.19.275-rc1 review
In-Reply-To: <20230301180650.395562988@linuxfoundation.org>
References: <20230301180650.395562988@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <213d1fee-73c4-48be-9bec-729fe972d87d@drhqmail201.nvidia.com>
Date:   Wed, 1 Mar 2023 23:27:20 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT030:EE_|DM6PR12MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: d45456a4-224e-46b9-3981-08db1aef9329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GaosgIm1A4eUMV/1Rbu1+4x7WJ3LmtfGota3wDtEzlD4iTY42wA1uZLAXhBxjH9m6YdDVDI3fPkiZNCIutlxQSh5YOmVO6r015l0wgMvYXrOHiT6IMYRy0RFMK8psncRubpN2SKPFpXRD3xYmnMNIzmIlNEYKBsslhyCuniqfSW6yAU9JSY1vmPYMOt10x84/SVbYQutld/DiJDnvi0jU/K3oxVuzbzDqo2MPjI+mAkHDW1KtHpMEPw36J3Xp8or22F0X9bzq3nr/p5cbfA3Dhtzo4BxoNOmtcJM6rfMy+hbIXg8r3N3Jc+hgj/WMB5nwfcfDF26shRtJptcQ89RfVMKs+Lo0+bvKuvnVSJs+VLf6X3ooO5II7Zywvife7vzyjTLrXlOuVisRPkA7ySZsRD2/5IAvVtdyisMumsqN7/T7MBYzHvJXDsEi686lTkAKBWXUShH9jHLLHBI2ihtk/FjCjwm4xzojd0slWQr1rFmY2P1LCag56iOVbBZVNSwNRDHI8A9gtFQh1uvIrGw0arJSnRE+VwQXkQn6ZVkPzBk29veHxuaJ8CGlwPlVV0obOZSc1TAYk8mzbm6uUB0R8JA9nvCMvNg1XuPvb1rf2WBUhlD3bUO8L3gLVlclUs2MZlRmW4frVt7N5uKj7X0Z5nFfFYtM9+cu2ZLNr+KCUvJIVmmjChoDZ8vOMuMLNjYtO7Fo4Qc2icErde9+56eni0/GKNU0w3yR2a4BZXx+SetaU+qdGwjIZeMmmO/olwI9R33UYZ0hz9PUAwOfUX0RcahDg4ehJJZEAbj5y3Pwdfmff6f8Q7qz50m8ZbYW+T+
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(376002)(39860400002)(5400799012)(451199018)(36840700001)(46966006)(40470700004)(40460700003)(966005)(186003)(336012)(26005)(6916009)(316002)(41300700001)(54906003)(4326008)(70206006)(2906002)(8676002)(70586007)(5660300002)(8936002)(7416002)(478600001)(82740400003)(7636003)(86362001)(31696002)(40480700001)(82310400005)(356005)(36860700001)(34020700004)(47076005)(31686004)(426003)(12100799018);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 07:27:27.0578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45456a4-224e-46b9-3981-08db1aef9329
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5007
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2023 19:07:16 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.275 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Mar 2023 18:06:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.275-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    22 boots:	22 pass, 0 fail
    40 tests:	40 pass, 0 fail

Linux version:	4.19.275-rc1-gc17367998a27
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
