Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4F7159D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjE3JUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjE3JUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:20:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2801B7;
        Tue, 30 May 2023 02:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0fq26uE3/FL/kyP7V/JKG1GYQyLjcnUUhgTsYLRkww51JZGOy3F5Z9he/+5a4mNq1SRDWCEMJen3YwVwfwT1Q9rcZlK9nZeP0Yk9oPjejHPOyxVCZ48TXcdMqXOw0bXtyb3VjtqU8V81qH0mcyMGnq/KvjK2dYmUQvMYFiYLuzkzS/fOIAW4KaUf7f7mNj2oQgLprbP9pObE1V5eRjfAjgao1561NI+oUkjlnI5UJAEz5HlLVr47EC8T+CYjnOXeyjQ/3E3M2L3+dr5jmvCjxnlDV3bwfSIXlpMhOBAa/sXs1qaZ4VjFKl3ZtgoSqg6c2u+MWxb/i9Gjio2VuCVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkhvm/79K7yYuGz/vav6LOkluDgVnoLSZz/f2hJdFL0=;
 b=oCCbJLKiKNZDfBIw9pMHC8kaxj7ue5LKmQ1hemZ7PU1Za5/pMRxTrcaZQDhXV35gaL6Wyxz521a+BslXlEopstcwrTXHZMP0jS5WLkeTvg55ZOlA4RKTLHSW4gGFSazo6i/L03eOa95+l+kSrBPC4Hu025mxhuV40VPdQiTMahrTDx47dGbYxsFy5qJTGviIhoNlY3T+iesvbXGM2EJwgNUr7rvoy5pPIk6gLxVIBTmgMudYG4KLt5xrF2SW+m9rn0h/hxe6mAQQ9VSf5q0HLOKzX+c1EhHZweiWRxxdW3nfF/kYUdm10H2JJdguDWIwuwGjjW+ZLBJdVoKfQtN7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkhvm/79K7yYuGz/vav6LOkluDgVnoLSZz/f2hJdFL0=;
 b=doduNLwLbbeMeBwFldNAD0zsERRfrsCutSxOlk/2adrevsfolRPvildwkhEtwPdMCufVFE5OnLIX394/PyFZ6fC9fBxjP2dEIxnGLQ2UTLDm3vpTAyPq301vEsIWFbFZysN+mMcp9f5JmsJwqIaBkCehA7B6O/R5ouMYt/RmfrSvXFj8cuWqedT1O2MORZYZCas2yx1jz8w0WqRyLQ2d+A8ENXVDuEm7wTwUKzFnc1zDYKVsUR2dPjWjwRnBvwiqpW3VJzDGFYyAF8SQEqYMmF9kx2JFK6vLozJ/MuzaYNAhf2dUITJWZRwcfIZ6+T90xGrV7zoyQby6bmwmiZt2Mg==
Received: from DM6PR14CA0055.namprd14.prod.outlook.com (2603:10b6:5:18f::32)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 09:19:40 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::a) by DM6PR14CA0055.outlook.office365.com
 (2603:10b6:5:18f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 09:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 09:19:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 02:19:27 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 30 May 2023 02:19:26 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 30 May 2023 02:19:26 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <linux-tegra@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 4.19 000/133] 4.19.284-rc2 review
In-Reply-To: <20230529153919.729418186@linuxfoundation.org>
References: <20230529153919.729418186@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <399d0c6d-997c-4ce0-a181-db1823bb1951@drhqmail201.nvidia.com>
Date:   Tue, 30 May 2023 02:19:26 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: e96d5128-569a-46f0-7f97-08db60eefeb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0a4wLDe3EqGFRgL/XyVVFiSIyOY8b5eaTaHy1pF4241CIEN/EGcx4qRDJLXR0otNZRY6luJq2pJEBIbwBjXLFyz4tNAEhGSQCCrTYRWlt2IJ51YXpbSCe4qB8UEwPFQCBiE0xYmT3oXBj0cr5gC/ecjgACuUqFzKxxN48iRKMUGGRXWzIQWewjb5+UqZECLNgfy9HWGocG4WRdu1dTs+zpTV0YP809V96ygP1NWIR3VzUnwgThRJNnluvpZ6c2fPpS/UqmvihGwF1BfEhiyBdgS6rIjROQUiu/OJ/ic5iDIfBuRRhyGRSDde+7Z/xTR6WMYvifUHFgA/NIRV6IP6b93nK3njT2XFxGE6++DkaVCE34AFpXxmb4x4XdDllX7dFessSjMwcacrHTw9ROXOSMzKGchJHwEdyIZSnTRmiR1ERoT5NVE0c1RUmcpUnlzEcG0JlmklSk0hZu2utfOi1bJHjzKPFIWATdOUWvcj3gKKyFp73rcSO+bCwwjJpDjfpSJr+DHS+CjsenS6pKW293BMNcchPFI+mYKI/aDmNDpLP2AzTa5y5S+W7BwiWSyJY40jYL/IZGBEqeKmlxcFiCGSyfoCLGvlRZ7wMfXn2J0nOlFpdwJ2kcx/mH3mtNymwfZMjmv40mYpTxKMwu9v33JUB9qsHa1EixZEWrseIsa0KeMr4Vk5vNoXevEZlPhongFdqO+eudig5l3LXFexbg+NGFMRRAwF+CeAejn74svsEy6wCLt3G7glY60pf0yqd5RAMqNEIjIvXqFZKOmaAmSE4iXWCjiAS3whJ9mXSM=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(8676002)(8936002)(47076005)(36860700001)(186003)(82740400003)(7636003)(356005)(54906003)(5660300002)(478600001)(7416002)(426003)(336012)(26005)(31686004)(966005)(31696002)(86362001)(41300700001)(82310400005)(6916009)(40460700003)(4326008)(316002)(70586007)(40480700001)(2906002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 09:19:39.3859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96d5128-569a-46f0-7f97-08db60eefeb9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 16:40:38 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.284 release.
> There are 133 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 May 2023 15:39:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.284-rc2.gz
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
    20 boots:	20 pass, 0 fail
    40 tests:	40 pass, 0 fail

Linux version:	4.19.284-rc2-g1b63443ed3b0
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
