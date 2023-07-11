Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E84574EB95
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjGKKP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjGKKP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:15:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74792136;
        Tue, 11 Jul 2023 03:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDBG1fepRLxUOz1r1TLxh9NVNBDwWShxW28xnwCvj5sjWMrV2xV5reMlR/xU99S+edZYDIhee5UYgYIYgncdcc4de1ZNyCObGPTxcpQXJttj/raIEyFdiXYijl0DLbGzMrNzqtbGAlMdzNKyRlxqDO+nptbf4pDSiu1k9tUBdagW5aVB8/wfsPYqXY5eo24OD1zfhE22qfl+AyLAoaPfWyge6XTgenQJCwq8Jy+zA0PhUB3+m8NLBooc3yoUltiADuJfVcNK456jdcwB9NzhcwVlS07m1Hy7e52fvbJbWCshQmVta7Y6YrR1pdBYx/SvGvFcZOrehZ2hCPhrhYx1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgE87rkP2JPSMAeBo5lIxDWbsA6msdbeXMSiAJW/QI0=;
 b=bHCDVJZDVNLvYXA0kVQnXubQV2UTVxe56cugae7D8fLWkify0kMHs9agsoasnQ6sg+zkZyUgTFjTs3JBYbnHckDM27omtZ4aRhRepqTPL0yot2VbKpQaPmVKc3OzLayac3QDalii6vljFHOmd1enRc9tUVXJ5pYvGFQUQkSHeqfCZW9MSE5TaqgSvLqHEDhPIk8DXB3Ra/rDxC8AtYS2/CF3rCA7YEVB4eHpwnpEQhBV9zq3xMxdru6BQDO2QLaOwbwPkxjJgr5JvBp1HuUmqgF+aUiAisHSsdLQsBaK426k+6aEOCoGx7zGfFBkLkN/6IkJyw3JYPMEBnkNC2+UyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgE87rkP2JPSMAeBo5lIxDWbsA6msdbeXMSiAJW/QI0=;
 b=m7Jjgryl4YtqC9x0y9KOmLGNEL7HcfTziq0B7UTYEN1VmmMZvUFXolPKil3dS+Paqfgy98+wml9TpveVQA6Z7xYUYl85zY2+MrK+7UQjpuJ5TOieo0RJo8/EsDN8oFhSl2X7dlxqjVQjylwZ+OWp+4meoY0iNpFgIJ/GM6Cdc3yGhG4M2GT/PaVNsxiyz+h+ztrh16Fk7yvWFXEKcUcZn9PQm89CHcKDuDNxnIopDLUA/6ZjjZdFkzvcbtxW8sKm9pV32LqGmGYDZUDbM1a8VZIDQseSwj2nzxc6J4UjgOw8S/9oszXxVr48rtQ1PVm4Jzq6T1q5hYw9268Cks8Wng==
Received: from MW4PR03CA0241.namprd03.prod.outlook.com (2603:10b6:303:b4::6)
 by SA3PR12MB7806.namprd12.prod.outlook.com (2603:10b6:806:31d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 10:15:23 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::d8) by MW4PR03CA0241.outlook.office365.com
 (2603:10b6:303:b4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Tue, 11 Jul 2023 10:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 10:15:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Jul 2023
 03:15:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 11 Jul 2023 03:15:10 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 11 Jul 2023 03:15:10 -0700
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
Subject: Re: [PATCH 6.3 000/424] 6.3.13-rc4 review
In-Reply-To: <20230710142227.965586663@linuxfoundation.org>
References: <20230710142227.965586663@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <e11d34c0-0b89-410e-a162-4be35ba8695b@drhqmail202.nvidia.com>
Date:   Tue, 11 Jul 2023 03:15:10 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|SA3PR12MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 901dba81-60a2-4d2c-3479-08db81f7bcf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zpwBGVG+EKo8e2GgYnCzVcC5Is7MsO1XfjcHa6ze/GFOuBi1VwJD3x1IXfxgPjccukdNLBtTrQU9VefefjTZdd8JewFFUE8k3LeHCWsStH6DKtzGfuTgOliw/CaBfm9Lq1oxnBxmEvx12WpOd156DtZHOFmVcyx/3hBw/Zum96DQ4xtm1iPHt6z4Nl79kHlao1VKcKtHdoty0b0ciQeaw1SuZdbLIdJNZAUXP5vCqAtX8Gsg7fw11VYr931R5ZYZdJDUfIYaTGTplQfdWk0LepVVhFzrJ08xFZhTImv+/Prb5RGupurQ1ezc11HAGT0BJfREAJ8ziWKf6EsDx1bnoTFkbcD7WK8GzP/zhdrvH17k6XfT0wHuKuoY0va02Sq79oHgK2n6NPBUDC4v4ZWhyoS351W5OBrvMyKJWuZ0I2+8FZp0Dz8+9J+9emwvwX3ySrF0tR9Ho9sZfsXGW4GTXpu6gsJBp/cCIAkYnZ7DK3xqD4ZXLy2CcnUBnJOeehE2fTObYUdeetNrJ6Fkkyl5nHm/A5EKPgtUl6rmoj5CTTJUN2eXg36WG9g/V4czl/KpFhFDLB+IIDJlq129b+UQjd8VTkqLNyFhHmQzQrco7eFBPqhdG+N42McMGSVdfvpDwQEAI3uBtg8ViyYPGZ08clapYg1IDNJnpvbJqmAmR8lW4MAZ9ZcqOckOpmtOMdrAmW1RkaLL22SyuImnf6im4OPkB1f72gj2mO1nIbQFHaM6tLqGNcxQzzoUxlRpcnJL80JcveralUHCNFd9RjZAx9jv1uVNT0GuWbj7mXv/8o=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(186003)(26005)(966005)(36860700001)(478600001)(426003)(336012)(4326008)(41300700001)(47076005)(2906002)(5660300002)(7416002)(316002)(8936002)(8676002)(6916009)(70586007)(70206006)(54906003)(40480700001)(356005)(7636003)(82310400005)(86362001)(31696002)(82740400003)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 10:15:22.9080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 901dba81-60a2-4d2c-3479-08db81f7bcf3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7806
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 16:23:32 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.13 release.
> There are 424 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Jul 2023 14:21:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.13-rc4.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.3:
    7 builds:	7 pass, 0 fail
    22 boots:	22 pass, 0 fail
    104 tests:	104 pass, 0 fail

Linux version:	6.3.13-rc4-g4882b85b0b1d
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
