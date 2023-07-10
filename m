Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D13874D902
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjGJO0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGJO0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:26:13 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EEAF9;
        Mon, 10 Jul 2023 07:26:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZLFN+s2GRhiSExiJzhVTJtJ5dmz245avqr+yASdDYooIPDZ1Po2lDta8K8Bma1l5bhpd0gXvFF+TSerUF5Z4uFDjokYIhBnqSQyddbSGrYA7loqMvCMtSoBW8urdkvOdcMK2J1hgC4XMNACF6MuPpSI9O//JtUCYvNGVXkJwdVo8exXdi9GfdOse11IY1nOpNq5yB/efJMN6y+SKnDUyaPGhlHU8orv0WMU1TGlNM6ALsbcAx68f9o7bamx1VRgdu22C0t3u/GLNjRKPgMgshmrxyRjMhDQouGDN/TJS6u2r5blNtJgBAaY2FJCdDeVsFL54I9DhQ/cEvQwTKoqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRV0mYGYHC4gbDtfJOStZsOTc2/fA5U2cpxUb1qhk8A=;
 b=jg2H8MWVGn+cMWSxzqj1OsEFQYUVjjSAS0RoPY77DmKCEfTNgWPzeLhvxJXV5jlb7T+dRuOj3Xzglnmutx9gh3OofkRhZKMVIvjv7dC60OY2usJU4x2U1h/DXCagWZKW0CxE5XQPFLEJ3D6q02hy7Z/BRD9d+CmdsXbmRddmVMDDo1U51IDtnTJa6Fq+gBwzA0xSxj+Hnl7TsCNAONqidJ43n2VETluW5WYEKeG7bMZD+nfewzejLmWWIRHZtc1kXfWkg0MnKEZHrxg828qOxdbwyQSbqQUl9krPWb0DduHIDtF/obaEACehov86FvmIc+bdumbwlIR7vYrVWft9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRV0mYGYHC4gbDtfJOStZsOTc2/fA5U2cpxUb1qhk8A=;
 b=LVWHkpENoXDLgmtYrhxdwMG05DFuHguLj6CrtznWaU+bFeq92xb7CMRAjpfzI6yyfbzaC0OitU3gjHQGxJzAB+HGK+qXGAWk+JeBSCnjYJFBmIpFW6DIcv8dcU48lcykZvDXN98MtS0+2XDRxEsUFF06G3eWzJIAp2xKm2SiFOqzFL4ojE9B402NSOHjXMNeVB9q95JdktPa16Uz5S4pCk5yjLsxp4YgGRTyCjqYHdzJTnrwKubuSUyb/WUIQ82Upzex5QZbE4bZxpiPIhHgTvqGcjfUlOw19uVap1eTY7bB6vYi0RNGGAxRFpiKm96N5gHfcTIuo+3yi33J2L4fvA==
Received: from SJ0PR03CA0134.namprd03.prod.outlook.com (2603:10b6:a03:33c::19)
 by CO6PR12MB5393.namprd12.prod.outlook.com (2603:10b6:5:356::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 14:26:06 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33c:cafe::43) by SJ0PR03CA0134.outlook.office365.com
 (2603:10b6:a03:33c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 14:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 14:26:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 07:25:56 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 10 Jul 2023 07:25:55 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 10 Jul 2023 07:25:55 -0700
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
Subject: Re: [PATCH 6.3 000/426] 6.3.13-rc3 review
In-Reply-To: <20230710054619.475084489@linuxfoundation.org>
References: <20230710054619.475084489@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <c52277d5-cb61-4164-ae17-d7bd3019327b@drhqmail202.nvidia.com>
Date:   Mon, 10 Jul 2023 07:25:55 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|CO6PR12MB5393:EE_
X-MS-Office365-Filtering-Correlation-Id: 65efe3d8-0b2e-4528-ecb5-08db815198a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6fh+c+nMiR0MihRWiT82r8fptOk9pGiTy0o93iOSqFUbnnimFeDfEcFx2W7JKtiTjt9385m9d8gqjly37zCIscD+mXhdQly0TqmASjvtt+ixDCP6esTX+T8mqthestOSQgCEY5XsWxAGHgvxp0a25+okNEHoqyFCjHo40HNjBcvjp+3sxPd/WMa5r98YM0Ado+XoKw9uorGI5248vru0dQF0Z+Ey+jvHD9V2sucsnWZE9DEV36QLRnn07EpJ36TZ8oieALtjYWEVbeW6okgbiSwI4PHAsvVSlPYkAOiOZYmCl2uQrfq93YiYOgek5VJbhabuST0unLBF+ZHnkeOJgCGAsAgkMV9TGkPgsbH4SsykqwvujcHZVpOhqK+j/rxQ8HPZI0EJ3FNJTGHgGs90Q/7FyYb11bJ7b3W3TJ7pAYN2lDj/aciF/Seajl5+VJ5+H1kXerZB6BEc2m/WKj/hdKFWHs62XL8rh9h1i49pk8ArIfv0XDoKr1nRKd6XNetfYnv6j8EIghvdppvNCII6EoplJtqYwbVlEPuWfPFoELxhJY5aZJenEyPWEXmxgYd0LSA1Js25kEjFcOtQlg4necPEWcImYo+YTphsD7tPskq1My0+ETuVY9J+g0hKP11qf36KHs98mJXh+H1RA6W6FQwaaLZyt5LZqnXsWhIPZFvrStk+hqtKtE47oUWLuMfDqjcnG7o2jBreGGHG2Axnb/4e7WEY6D4IroIf6vP6+oXOir5RtcVmGpJoiikevVAaDgCGtNIurlLOGZln3Il1ZwA0fkv9r6J28a9pIkiico=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(7416002)(5660300002)(8676002)(8936002)(316002)(70586007)(70206006)(31686004)(41300700001)(2906002)(6916009)(4326008)(54906003)(966005)(47076005)(26005)(186003)(426003)(336012)(36860700001)(40460700003)(478600001)(82740400003)(7636003)(356005)(82310400005)(86362001)(31696002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:26:05.5258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65efe3d8-0b2e-4528-ecb5-08db815198a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5393
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 07:47:20 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.13 release.
> There are 426 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Jul 2023 05:45:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.13-rc3.gz
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

Linux version:	6.3.13-rc3-gb95b57082420
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
