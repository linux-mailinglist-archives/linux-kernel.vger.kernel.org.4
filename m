Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6448573F82D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjF0JFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjF0JFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:05:03 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722E910D7;
        Tue, 27 Jun 2023 02:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Np5NcZZQ9fzsxCz3xhT1LWAY6j+SV3YkDuHIAOCGpZBnRWzm6JOlXQGFPYzfTPv2ZA8WeqXZgtrQ0CG0WgwPW0wEKKuYR0pxfwEAZEhlhIZtT5WXANih9R6JRC3zMRsGMl8pZnYItXSL7f3IAwlQZWMPSKz06McCYmNQy8hp9fcu+am7E7yfg/e123id6mZpJM7z0sI7t3UdSCVi99F9TgSZwByQjnjW1IiI8NR8jkvgyVBzMyREgVuwbatAoZeytcBhIxmpaMsFESkltB5SkBaB4u4Uoxb0shOMpPs07UzX4StCutN0Dm3vWrolweH6bPKbNLs/Qc+/sURyjrueww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pmm3x65NjgEMk/EyUaXmLPTt5DVaHIj1eDMMaqj5Jx0=;
 b=NVM6LEuNOh+5tn4HBNBQhaG9vZ/+89ffqIUm59zvEqagbnWR0V10/5HKUJV8f+wIbKbgH2hpPVmiHsYkKIPnycSSS6abvm27GVDgNJE7iAwxr0wc6KjTc2FoMhr7ggsHaJIfK1V4QEAQ49bGUN7rffRyoBlI3Vw7QbzmW/v99v0HhZP1cbixz2bqpaiotKo9s4BlvJTsm6maY9PLjO3s8iwuY/puWB5Rt9pTv3QABsJ5s4uq/n1UC6l56+zQDY5spBOhD4ajQjXLhY/sD6+KgO0iflWm6e2FVjnH1bTG5H82YOeSUz5/l3Nuj2t7fYP6UhrWIokVlTFg8QIrsGSntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pmm3x65NjgEMk/EyUaXmLPTt5DVaHIj1eDMMaqj5Jx0=;
 b=FV3uFQcfWnlQ/uhR1R4ENS0zBG3bvp46nLHSp/mNKNjOgEKFu7ZgOLwEbLjRPYaT6Bt/mHu7mQxjtxJfgXCpuCUrRlaJoSMEzbpYfAJHjKQswSvbE44bxRAmTVlVkAvADDukm9TQ33Rn+yxWI3DREqkxgagQcvsYSrCeOzfIocuj45hyOxzczG4WnX2FIGmon3/Z3v5Ol7WBUhNhySaKrJjvk6N5w2E/JELjn/eb/BV9dBbmJyIWOxUiNL3V/dml10E5m8A2PL+yf07k+sZi3G7M7Fmnh0Wkkvb3L6wJ9HzIp+m5lAnlyMAGK4b8r6tgD6amhXpEFeGRKpdPLKG4gg==
Received: from BN8PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:60::29)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.47; Tue, 27 Jun
 2023 09:04:59 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::11) by BN8PR12CA0016.outlook.office365.com
 (2603:10b6:408:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Tue, 27 Jun 2023 09:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 09:04:58 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 27 Jun 2023
 02:04:44 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 27 Jun 2023 02:04:44 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 27 Jun 2023 02:04:44 -0700
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
Subject: Re: [PATCH 6.1 000/170] 6.1.36-rc1 review
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <09149b18-6cbe-4064-b4b3-94493394067c@drhqmail203.nvidia.com>
Date:   Tue, 27 Jun 2023 02:04:44 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT040:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: b4418564-ca92-450a-aaaf-08db76ed957f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1YVC/M4Xm8BImd+CPvY66if0WbbAbgGzqhZ76yxB9Y1BjTW554AElSQNm8tONuw6p8QPw4c+py7qHRV48HhvhLBElbvoSDm7gCH3LW+0jhQk2jG1+yrHxGkAGpjmBE8IkeoW0EO9zaZxzPd2q8LjQf5ogEoRUFMIxyWuIUed7EPIV3Y5MPgOvtlUEw+qSTluzUtxskk3B49j+Uew5OdTtTHgoFLneYXOEAPDTrQ2m8Oucgn0TU3ytbAbCwboaqvX2nRBeq/L8FeT7canZw2ilF69/tRmE/99AL/ca2obRpPAZ33L4+GfyXd7UN3gILZX7Wd11j6riljZwlw9thu6bbzkMxF0X2Y9KtfRfjhNwN3idSXVTnzoIl1iVuAaIDpTt6/X2DgeevkrnelFz1oF1QMhC6UQPgMHGZbKUYRYI5EaImKyuSzh4DES6Y2Eq9YR0xuaS2kcelGNqTKaZ8RE0d7lkyP00+ultE+j6BoRJEU7YESV67OEYsqz2awXeJz+5yK3NSo36FTWdenuSPwhJtG4ab+EeisAHLPWEqp0wPBnQaugkR5Yd4B8k0OTGqejdOiR/XygcESkC0kxDiZwwncJ1nCDtypLxHqjReGnDeGI76lhVwAAapGcMjcPCL3jakRKSXCuidESolPsy+EWlDpuo4edZsbLDroOltsGPEvpg5conH+W7VsZO2xIOf1zVuMMKD6Sk0LHKjZJRfZmsx3yMbKsoSoWIXgmiqOg/vHaPzgLlinQpu44yx8WebDQn6UPdwi2QUn6aA3D/cbfS+Ic4tuJgZyNzWYm/clMcLw=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(7416002)(31686004)(5660300002)(70206006)(70586007)(4326008)(6916009)(478600001)(316002)(8676002)(8936002)(426003)(2906002)(40460700003)(40480700001)(41300700001)(36860700001)(966005)(54906003)(86362001)(31696002)(82310400005)(26005)(47076005)(336012)(82740400003)(356005)(186003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 09:04:58.8524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4418564-ca92-450a-aaaf-08db76ed957f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870
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

On Mon, 26 Jun 2023 20:09:29 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.36 release.
> There are 170 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.36-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.1.36-rc1-g8c805fb9757e
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
