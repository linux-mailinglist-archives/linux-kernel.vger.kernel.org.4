Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815766E77C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjDSKwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjDSKwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:52:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10hn2229.outbound.protection.outlook.com [52.100.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896D013C00;
        Wed, 19 Apr 2023 03:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dk7EJQMtmOIvMCMp+44c/sQyaxYP88BUksMWDaYkZ0qkH8XytHmNDsvvXJi5MChzqNkjwp18IkYIsKdLSLQY13y/RwqioBevdYAc1n7ROOK15YJHArIs0Zvvm3T0zVX0QsIzaQhjJT2PzUGCp/KkTK3j2wo2hize9PJIZOnS0Q1ZoLrYA4/DpyjSa+EOLMz6Mvhwwfv6H5lOCpbNxmIxrQhVYx9uNbe98/ilNoGKUBSLz1IBqClpdmr/xx7t/wDUD2zYtMvAc1ZxbyVVs3GM8DwRr+aRruuPa0P/7bKGbYZy5q+72LShjQRkwPMci8ua5/ISa7K4RBzAuaD8wjFzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiGgMAZmNWAhD8HtmtXATd5Da6X2zPeyKHJzrMmLMNQ=;
 b=OkZDFBwcME4e528rIBfHquQYSpfd7iE0poOJ6Kn+l1VZiLQp58xXCnbd927UpbcvQosRmk9f+Nqo7bb1LXmLVVhaYbdH3zPtD9VIBhLHikc+S2btXjEMueXMCv4FOyoL/DokdbBb6Dj1ILDyGgn5ebj3IiyjAWftOFPi/gXha7mgxbcJfpNKjRyvRr90s6wWf5KMz5UCX2wzbOwjpjmdeBaLSGWt4Wh4KG/CP/vGnEBd4M5mx8AyaXRxi18KT23XfLm3RZSZk3/79oeK5zz9SXYMD4BBHElFkZsbY+uvUbkAzeAJH587tM7O9Bwsv8Y05jq7penanaOfWQy5zhjnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiGgMAZmNWAhD8HtmtXATd5Da6X2zPeyKHJzrMmLMNQ=;
 b=El8U69STjEmuWWq9/AV/UuOio052uf6SePVUAzWKplpM5h/bcDgXvdpVuOdCwP42jP+PpyNvKeiL2JNYgiaIya6vq30QcZ0rAXBU7xWnzVtI2FAQFjZcI9nkuKABPGRvnL0wIKcnOT4qUI6XvTfzn5pw/76pTxd+rME0nssPhRwGQlZMyU3k5+5K3wg4nVpbZSkMgGytXL8k1+DPVK27nBcV/lsggMfw1LcfhZ7BHdr9/L4xB8aRIr6eGog4wAl1VZUpqwF+duQfp/NyZAd4pbED/L4Tp7niNa2hzOPZzFs14L3XHMfHlY13Jy+gSvyLcPohvib2tWHxDJIEj3Y64w==
Received: from DS7PR03CA0034.namprd03.prod.outlook.com (2603:10b6:5:3b5::9) by
 MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Wed, 19 Apr 2023 10:52:06 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::1f) by DS7PR03CA0034.outlook.office365.com
 (2603:10b6:5:3b5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Wed, 19 Apr 2023 10:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.23 via Frontend Transport; Wed, 19 Apr 2023 10:52:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Apr 2023
 03:52:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 19 Apr 2023 03:52:03 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 19 Apr 2023 03:52:03 -0700
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
Subject: Re: [PATCH 5.15 00/88] 5.15.108-rc2 review
In-Reply-To: <20230419072156.965447596@linuxfoundation.org>
References: <20230419072156.965447596@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <31aa90d4-e776-4380-8647-683219ce952f@drhqmail201.nvidia.com>
Date:   Wed, 19 Apr 2023 03:52:03 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9664d7-d10d-42d0-229d-08db40c41e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q2TfZrXmgySLLOrIIoSmOzO+ieAqc94wlDYCSBQ5Z2LHrSm98SlcQ1qCNHD0ObETkMEicZU6/Mrk6h1uBP+7dUv/10pMbCiXxy7s1TcpqnzWLyig9uRdtEneEehkiDcUuexFSymz2rt80t9JZFemny02KtQXgwEZuQPCUKBGLbs5WxhB5e/lgivA8o5XqBnfV8A0GqnWoGe4NjgyWOQ3Jt040ypbG/Qw0F3xDiZWWC99p32rznai07FfvVqAwrSpJuPqjSsnT1ZoCNuYv7aRO0B4/tKnXHELa6RrJ043Pkyhes14/3pGH23EeoDoD9BSJdpfEoXWOVsDuAM02EGvGRtsrabLWd1f1OX7TDIza6X5vcjf46G0h5045kTYOEoBVVON8N+ALRilGrNIXRJ9qZrQhFXeoOh7ZcWA8g8R0Suuuv+rjZnsPnvwvR1nxvR9BkryZB7TxEyRM9VXTLSgo4qYr/7grNC8ESNVcrU0rGC4xqivCCpFn+e1WEYWHI4UChG36j+1bMOtejcJ/o9cjgWXreLHr9Q+OaYP5pRilIlEyxVlTZlBseHBIIE1wbOcBWo+3WJdRFD9Rv29DtqLWuGxowuM5lHqbZjuIAQc9lstKye8m4IeN1tAj+jLucfaYZqK5qVq260alOaqQZ6jRjELjLTZICZbc34m9pUaN0v0X1U0fmOF1m/eGKts9nfMAv/GzCMpIwyMbKHx3gY7ta3cl68Qhobk5B95siTVLWiA1yRtWspfPFiC9H1+L0KBYr6SF9pdRTdNFQkZfif8QrFB9hQmDZyMqEp6eM5xs7AHubKTPepi0F0ogC7nYF+rL1qaDd61+iB3yTAsw3UgCUzmEBEHYqkgYlT0eH5uODo=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(5400799015)(40470700004)(36840700001)(46966006)(31686004)(82310400005)(40460700003)(356005)(26005)(82740400003)(7636003)(478600001)(70206006)(70586007)(31696002)(966005)(54906003)(4326008)(6916009)(86362001)(41300700001)(316002)(47076005)(36860700001)(336012)(426003)(40480700001)(186003)(8936002)(8676002)(2906002)(5660300002)(7416002)(34070700002)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 10:52:06.3293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9664d7-d10d-42d0-229d-08db40c41e06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
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

On Wed, 19 Apr 2023 09:23:49 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.108 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Apr 2023 07:21:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.108-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.108-rc2-g6405847d6038
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
