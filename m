Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DABD74D8FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjGJOZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGJOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:25:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9FD8E;
        Mon, 10 Jul 2023 07:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmzKagS3aCXvf70PyTSnxSwoz4tA90RrAcVXbrH60gGY0xiI8WO1WmIyjqKaPnc+vD4kQF2SIncrS/xlCNLUHAn4BIuuOri9BbxAcfQYe9/XZNH2Uj9nRCX4tBhOESlsu5T4xPjpCoHDGyluh6R4oeKUk6tTzMnZjyU0yO4Z5B1Yb+bYDZOwJXCdxTXlSnaizcQyPwtShfAuIGl/KFAzHFHyQSy4V1m1gajsaHL77h+0HK2VZloqB/UVXrjs8Li59OCsPzIytsOKZ8bgsYGOI1OcWxrFqYB5B8UEkKrnmGj1kxdDURXUVIKWDTeiIZW1ER+0wEqDLGGdeSbfYgOKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGWXnivAhK5xqwDL/2Np+ZgNZm3pKMigZEOVjUsJreM=;
 b=dLu7zprzIin+p0cIz0firE0vSVxiD1zGHHmWYPzcpZ/pWS9RF7uDeNPmOgxs9JFIBHzYz8URc0jnhYxu8MeRn/pSO3YmW+YGS1XBgXZW+7p3AYjCNEn+muS+8uX0Q3TDY5X/ZGp5SvGc2wQ2sAeOZtxyiRZpQmqqcnYZKGTHnxZdNxrBwRIGHW8VtTcaFVWdnRq24lntOPsVajmeU2dIqrS0Vt5FhANPmBu8rTV18VUA+A22LiOULqXgFWrzuJYi4ZqIh9KEuOouBdSPRuaRb5kR2/+5ilalmKSOuCn7lOQYG+riFYNvjC8PBUdE7dY/bWom2s05afaNqJcEeATYWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGWXnivAhK5xqwDL/2Np+ZgNZm3pKMigZEOVjUsJreM=;
 b=JI/sABkf351tsMidYlZW6ID1j4174fD8LJRh7QTFgBgb3a7V9Lre+CAO+2IDUAmowQ3ZFDJmRiFuyLRMhrBov5wr2A+/JSZI4xx01S6UexT7M1CIeHIp7gAgssrIK8YB1e7B0jJ8Ww47N+sio0NoWERRsXwiHMvVRI1WRYKU3SHaVqHFJdyIPnjxq+A7sNzFfL0O+081Q4nzYUUWL2JrqDziRaq9piDOuiuZZZFuUcw604R50XwgmMgY8ZTbr9XvskJbSuvQKY116dpqu+OC8sw3Qo7ASQtV5GAKHLI6IA/XYZ+xTaOVZCP9SzuhjqF8Gsulv67vH8BVU6bfWZI3CQ==
Received: from BYAPR01CA0002.prod.exchangelabs.com (2603:10b6:a02:80::15) by
 IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 14:25:42 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:80:cafe::74) by BYAPR01CA0002.outlook.office365.com
 (2603:10b6:a02:80::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 14:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 14:25:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 07:25:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 10 Jul 2023 07:25:28 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 10 Jul 2023 07:25:28 -0700
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
Subject: Re: [PATCH 5.15 00/17] 5.15.120-rc2 review
In-Reply-To: <20230704084610.981452877@linuxfoundation.org>
References: <20230704084610.981452877@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <263b32ba-d409-41f2-b597-2785bd111e94@drhqmail203.nvidia.com>
Date:   Mon, 10 Jul 2023 07:25:28 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|IA0PR12MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: 2324d814-4700-4b1f-2ab0-08db81518abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: af40kMjYDdcShYPdshv9pOflfjoLGXtSttcNUN0Obded/czE2vBYAhVD0mXzzpnCb49S92I5ofbL5nO1mffBHk1aRaDBsWDxrvC1mLVMH73db30dlalk+jYV7bpKQjR8jjzK6h12AP6uj8Yz3YFMp7xkkYg+k8fe2tRTi5iSBDwzvaDPutn6gLhW5ihQcQH0u9YVNGe0z4kxSdtMonKKRRUK88csAnqcbC5EBipE8jQr+NnvpWZMiUEJfnp6P3P8sErbRRwlql1bUEjJxFBw/z3u/tv5U1tbeQAjqFW8v0F2CCMEMrnk0l/l4O+IRfoPqDEfj2ba6Htvfc7HO++5LzDHz9giP4E1amUOouC7INJresPXOxhYxowzdlU7e4QFX19MN8CGG0eZB2EjDcxGmx1ln2+pDewC2BO8jXS296aQzVLb4XFFNeRgmlbTBqV50z1/6UsmEowQrrQ7Uz0thE6+w7xAtfrEAHQgKpf1bGsm4Wagz/u9GzxYkVsWkl2CKA3fLGAmfmDwQbk9OU1JGOc1H+OPMpFZa45NysfLmhuZZjuuWlK9Jy8rzF0dl/6a0U3D1zbqxR39r4BKCmfxju52iiw5kpx+qUw4VvpUtdgbqiRIRomI5mEFCyZz/zFJRlCs2gzc5P9jUEIr2rsFUe05STDuj7KwbsNatdOQ/f99f2mI0IaODN1eXzQNoEcUL1sK7a+/tKrDI4aLOj4T5V/G4gsnWg5JQ23WcuxwkajfsgjVnh6pwm/LAz21pOhwHp2UluUM6GOBwmGzFPX0+amMZhL3ntIcPcATagQfcPw=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(41300700001)(5660300002)(7416002)(31686004)(54906003)(40480700001)(316002)(2906002)(8676002)(8936002)(966005)(4326008)(6916009)(70206006)(70586007)(40460700003)(426003)(478600001)(336012)(186003)(86362001)(31696002)(82740400003)(82310400005)(356005)(7636003)(47076005)(36860700001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:25:42.1416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2324d814-4700-4b1f-2ab0-08db81518abc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jul 2023 09:48:47 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.120 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.120-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    7 builds:	7 pass, 0 fail
    22 boots:	22 pass, 0 fail
    90 tests:	90 pass, 0 fail

Linux version:	5.15.120-rc2-g492521f41846
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
