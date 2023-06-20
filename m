Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27057736919
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjFTKV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjFTKVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:21:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB54E6C;
        Tue, 20 Jun 2023 03:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYUAS1BWrCWyZx32mDLoU7hs2fL+T0rxGDPLcHo5/wbJf0nbU8OVVFn/yr6nrO5K62AKQCgyPnJWXNc++ftPzj8SGAKWBcSLE1nXr6nIwpaPngUHAOCkyr9vfVdft6AOfKFoCufgLZqxol7RISBxAjkomYPoCKZMm8rSIzhedcSpejJ0tbkZRTGtwscJo+v92j7stHsPpv30cTHGTgn14r4+KesslOxKbyg8QObjlJcsm+sePu4eKAvllJCQ/ahDBzp8rANennMYq9a4gZas8tOiMgJJIqtIJXLl+qXmx5dc5HZAP4+yxsz2x89bhrhrJVFRkTITWAMNRh2aueYBWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBNBKwIcP2ZjMM7xsISpgLAuBMu1PwFzr0zRmfQp8Js=;
 b=d/kJEBdLhcwfNfox151TZL6tBOLRAyeDQY1WLAfH+X4C+Rkul58xwiGTQN8TPVwpg8iUJIXqSw/SC2nqRK4xF1PJ/1rh5NMkkPzbj2h1dcwvNmw4eGw6X6t5ULmltJaHIjr694yHLY1h5FK5zDIZyA4Q35KAweHSCrkMPxbkuBnO1GiAEGWVnl0au0zhOzN7dAZ8RKx53LpOIrUF5DWzTr5H88h5ealBFsPp6FRqAlN+rWIegd+mbolzk36gJAcoBirpIirqoVmT9nghyGTQ1WNi+9CwqqHPTH85L+Qw86q/05NQDdk+FKpQlo3Q9vb8YtImf24DYVc089Yzri/qvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBNBKwIcP2ZjMM7xsISpgLAuBMu1PwFzr0zRmfQp8Js=;
 b=r+GEGDBmddp+EOWfTh63rutacTuoGSzLfUoZ8bDVVVjPz3bMttvj73qRwQDNFTb66tJ0Pbaq3PyIvse5FX+LxPeQoCrWb/eZGIPUY4irwFpx605JQ4rXUceqUvjWkngSY6cWMVGVlc0Nhc/WyFMVSs6mkgDvCHtBjQx3v/7OATUoa+DcCPOOQd4pp8RgNxZ15Rwh2nzeGNlnZMNbsitxJicsPoFn74FEptb3FI7E8rQNV7UyxTGcCIEw8I1PZh7b+bH/MiuA4PFU0HfGMUx8ABcYfZDismnsU3AYzAuCn7eUplifkicaDGahe/As85UZ5x+8rlDzuU/e/VoCZ2BbNw==
Received: from DM6PR07CA0081.namprd07.prod.outlook.com (2603:10b6:5:337::14)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 10:21:36 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::4) by DM6PR07CA0081.outlook.office365.com
 (2603:10b6:5:337::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 10:21:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.19 via Frontend Transport; Tue, 20 Jun 2023 10:21:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 20 Jun 2023
 03:21:19 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 20 Jun 2023 03:21:19 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 20 Jun 2023 03:21:19 -0700
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
Subject: Re: [PATCH 6.1 000/166] 6.1.35-rc1 review
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b56904a4-16d6-4d56-becd-b25ec0f95d76@drhqmail201.nvidia.com>
Date:   Tue, 20 Jun 2023 03:21:19 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 236b9394-d79e-468f-91d7-08db717820b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHNiieYg0f9MSJ9jnKWb2eEeSSZyVDDd8sngmuvv4yDAUV9DbB2gRRyWxbVYrylTEwrkJbTYqkQFTWLNajbx0BgQiP28EVL6x+vPdB+CCEj4dY8Y0hpap5j6z2GI5F4pdr9cVJiP1xKhf3lfFbCAeRtSTSbGJmzQg1O7eYyMffb46rrN3vxZMymrom6FrhMaGeQZSUlXbOygikSU0Y9I2Zq7c5mlOYjbxeadRxYveZzWUtBuOIm+9+iB+jlr64jMn1UG+MQmVvV9FElYzAGiU3Z5fiVvCl7wyOvtrwqSgmq+7EvnXwlcE+YtIiQEn692ItpOe1Y14Mv6y4xZR2iJ5A99tdPRm7UmmZRy8HTfr2qp7i93a8NlPCxu/LrFGxLFwxD2Kxhl2HasZR3i3cd/VgnPsNtTZVOhsqAIHrax69UdVyKOmpJa2lTxKEFYfcIsageVklS9J6iOgOhaxt/d9WjBt3JinkkEZMR5kXCyX7J1Aofu1SXaYTdDMgNj2G6t3mlyv9XJeKhqeMGN3IjcVU9UIFiiTv4kTvefGq3TVnSBGeozFOk0DnwFUUxe+Tx4Q1vhrOHJZwoWSlE9ybemZdjDu7uSS0enJHaGZ3vXQ6eFma/RpBlHutYxFXiQmNYyz7oBG/eYQ40Mck5l4Vd6lq0XnvYvKDranqS3q3/qpSDWwsN7MssJG1ZBVq7UukTz22pPm88x7O6+M26CNFTLyQ6w6I2ryRj2wzMtmvHKpod6hFlNspx0TjYYGc+GQezwDn3oEKMz8ILArZqpkvloE+qzWjVZwqOU0uCc3phuDgU=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(4326008)(478600001)(54906003)(26005)(40460700003)(40480700001)(186003)(966005)(2906002)(8676002)(41300700001)(70586007)(70206006)(6916009)(316002)(5660300002)(8936002)(7416002)(31696002)(82310400005)(426003)(47076005)(86362001)(31686004)(336012)(356005)(7636003)(36860700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 10:21:36.0722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 236b9394-d79e-468f-91d7-08db717820b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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

On Mon, 19 Jun 2023 12:27:57 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.35 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.35-rc1.gz
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

Linux version:	6.1.35-rc1-g1781b36a0958
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
