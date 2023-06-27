Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87D773F827
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjF0JFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjF0JEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:04:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC910D2;
        Tue, 27 Jun 2023 02:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nu885JuV9V+IiPDVaqQcxmvFS07xE9IfPKS0b8hJCGOynvwSOZJ5fSdLDYppiyc5Eu1lvgaS5WL4Yoj9IQyC8E8yuXERMvJW0Rfuwn0Fd67vOYi4ZxXo+BHsRq21i3dFNNPAFmp1H2ke0BWDG2fAHmmB/3WshV2CTBZO/BwXgjiYQFfidvf6HZ+jzDUcVBDHGEqoSyIpyV3afeU+4OQ09Q1HQttiL/EbqgJ/klGiKiLkhTh750TNMLrGtegn50Fm2Q07YKQkdmNyLYAUELJJzZgv1KRaYOtAlM7WRUt3RbZCow1GwrbRJRK5FSN/4E9ycZpruUglIYu62Edo7F2K3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uat54oplTW9QtVZQUWxff27EG9pymSQF6yDiTQWFxZg=;
 b=i00vHPOvY22+b+t8aR+J37VhUG4LOBjOhBJG6lckQ9BPyxd1tVQ0riFAOx3IHhhvoqqNCIRX7wk7agsdI9KwD+4NjyqegErxOhWDb/VkeKeTY+uLLVUI6nyoiw9OSKJNqWRW4PFYyAX3KOtj66X0jgN/QI3HxSbkTLywexKmK3lDQt399ky6opXTgpcXaHy6PDHephbxytwFQipRa70QeY5xBtHrq0MMeKGEyfjUKkVc6lWrFgKukO+YFP0PKBuWHW4AceFEe2xqbmfPp+TlI8nVEDOiSymC82/jTanBgfkmL4eduhyugvxMhoTMTOnr1bWBQqKDKfNzI5lmayiWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uat54oplTW9QtVZQUWxff27EG9pymSQF6yDiTQWFxZg=;
 b=UbTOSr9e/kQ9GLQAfEOWwQKM6p4ZzGLpwWkHE1yPopdTCG+ZtEDgxgCoxFwvlz+CZTaMfFO6f4ZT/26gvqjhqvpoRQZcQcdbiUeqwQ7VOb6EOI4ou8R4h1dpIhrpMH4PaPmsaFa00s+RHbGfPcLr3pK71Zzb1MFfRsK57zFh1HElHbHhvzFoui41I1n7NJs44Rt0WewktsCDkFal0/yPvNS2+vXWb99l/CJx94myj3bwd6Y+OtMSldmqPyWVTVJjx8XkrjVzXOf7XzG6mVcFI97Ir5ZL7e36/yHESNJ2PGQFiwO6FS3cyGYnduzWXKT+vcWkprc6dzn8OG/3HW1Gtw==
Received: from BN0PR04CA0161.namprd04.prod.outlook.com (2603:10b6:408:eb::16)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 09:04:42 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::63) by BN0PR04CA0161.outlook.office365.com
 (2603:10b6:408:eb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Tue, 27 Jun 2023 09:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 09:04:42 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 27 Jun 2023
 02:04:29 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 27 Jun 2023 02:04:29 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 27 Jun 2023 02:04:29 -0700
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
Subject: Re: [PATCH 5.4 00/60] 5.4.249-rc1 review
In-Reply-To: <20230626180739.558575012@linuxfoundation.org>
References: <20230626180739.558575012@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b09b0f39-399d-41ac-95af-f9486ff03cf3@drhqmail203.nvidia.com>
Date:   Tue, 27 Jun 2023 02:04:29 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 37aae958-06d2-43be-8ad6-08db76ed8b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDKkVEFbiSxZae6ryf4+cMKLga3BFUK+BkKVZ+SuGSR+iZ+Hjz1YxBwt8w4Fwhl6bF+a0JcIf3cy5qqSVPz28XLE1Baavx01OO8T+SNq1rgSfkEsxaIditYPRHkdclUFWFjPAMLLfuiBqyBKXLRyzcbQ7wG+Nk2t6RF3z60hN0JPZCYb3uF14DE4LOTuEHaqK305utAIraT7jYelcQmpl/zE4003fymv4IKjNWXDFol0XMmv4JoeuRsBo1h23ProNE3kbIo0WPPWUWbaCbhs/Qcgb83djuXAmdp20UnA3g65NOVOPQtkTkos0ESx6+z8x6NskUs6qi/+O7tH7c+MYDKWgFknJTO14hQfDDTrcxIm5u9RdL+2Eo6nf9MJnSsceEaVy/wQw/dKvIAzv08yZ8Oz914Fd8YGQPkvurLpZ6AJT6e6LAn5+1lII5NXyw/KT2J/UrlVyEhPoXCzoYT9XAdsIgnby4+oUY4qM8YUB/s4o3ZzJiCPabs8R7weuZLSQMl5CoacZUlmHcBlqkPLo/ueZosatAYJnrpEvvVldPQAtdxW3CKY3DBe3zwccx/zg3sPcC5/R7nq7MCMgTAhNR1YAm/TKxkweoNZ9SYMGtmyKQva1HLgWkNmH5wQHmeD80WlR+fyi1RR68gQkEe+5GqXgYzwLxOcQ/4vvDt4I4+2NlSoRXkz3MxvBAC3UUImJkrxIFe5MRKLghmrOYE5HanrptXBIJKgLZjSL0YtrbeT98xPeEnsWrwPrp1XjvlaeIMgQPSMvlUffaQ5cbWulpOyQ0zMYvKfWAbPXPGsdT0=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(8676002)(4326008)(316002)(8936002)(70206006)(6916009)(70586007)(41300700001)(186003)(26005)(336012)(966005)(478600001)(54906003)(40460700003)(2906002)(82310400005)(5660300002)(40480700001)(7416002)(82740400003)(356005)(31696002)(7636003)(31686004)(36860700001)(86362001)(47076005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 09:04:42.1097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37aae958-06d2-43be-8ad6-08db76ed8b82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
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

On Mon, 26 Jun 2023 20:11:39 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.249 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.249-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    59 tests:	59 pass, 0 fail

Linux version:	5.4.249-rc1-g824b023c3cda
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
