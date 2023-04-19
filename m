Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF746E82B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjDSU25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjDSU2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:28:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691A22685;
        Wed, 19 Apr 2023 13:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQDquMuJZ8nPN06FVxbRdm380giPwXHXMjUB479yH5qjfUHPM7zFISNTgabIv1LhovcfFq83NFWQ9dvkhBUjkrEgQ5V64GIdmmWRWl/QPpCxWyqqg1omXME78kRQy48hj842CjXswqoqoKO/u1JiNPQP2n68edD/dJUgJKygluAUixAcqv/1/U9SXyL7caEZjptzvSlGEko52yXpU0telQSF4BMEx5KSL2XnzEPL6/DlvrLGPrkRU8srjunSCwnX3/nkYmKdA75raygx4B5EHy0QNDxElH2CrJbqQ6Gpc9x+WhBemxGSSMLmOrTF4gV9b1uqVqa+9ByLQZirsHFAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GgM0xtrChp/eSAPoUXAd84+SLRPmq+TsEVO4tF7UTc=;
 b=eUY88/vCOSxVfIzc60z7ExgGEjgbVe+pRKaHq+OaiYYu2NgM0LYHP7llS9hjtixO11PeazTaoDAFQjmteU7T3AGafHjOjiHfRSg/QDwZ39cqc9LZtM1uiHtN/Y5+DQ4mgkChquqO2Q/PMQXMrvMVXTy3Rt8ihy2L9wayhVcJ+WU2C5qKoE2RChLaicRMmKckhsNr6xWSLj8Bdyk9LXCAdimwym0U0Xth4sq75zrNuSPsSB2vlvu2c4cGLHBbt8nVsJCQgX/9CJxkjKQzS4RrgCCIfF3JtRkA1cg+l8vbBDvwjm1y3ZMNFef0aGHpbAKDvmX0BTIwIcwX/bLHzhWj4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GgM0xtrChp/eSAPoUXAd84+SLRPmq+TsEVO4tF7UTc=;
 b=BOn5N2dJCnVQ4nHgrb4KQpPGuY7qNsu0Qk+EiOdK1wUuklJ99chY7TcCSYa2krZkjn7ksKyAmY5bgrLP0CZyiw1IcWdBVfr7WnBfpmxnPaIlipEu4WM08P+ggRhUkyZeHRN+JE+ULKJ/mHh2qXhKl0fvnMdTUFlbOMpKKCdSciIZ9kBdzZaamkyl+cFRDvT4CINaLn+FwAPSxSDcIJPTYeyxqmsZbyrvR2YBLZyosnCNdBASqEFtyi9PIG0DBEuQPZn1AipLR6vOa1DV0Z8zLX9rsE4BHJ/kQehGFxe5OvYRPe1iu3bsbNzkSY8X33LVZQ8gpaireyqteYTMD3kbAg==
Received: from BN0PR10CA0004.namprd10.prod.outlook.com (2603:10b6:408:143::18)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 19 Apr
 2023 20:28:35 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::9e) by BN0PR10CA0004.outlook.office365.com
 (2603:10b6:408:143::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Wed, 19 Apr 2023 20:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.14 via Frontend Transport; Wed, 19 Apr 2023 20:28:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Apr 2023
 13:28:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 19 Apr 2023 13:28:24 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 19 Apr 2023 13:28:24 -0700
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
Subject: Re: [PATCH 6.1 000/129] 6.1.25-rc3 review
In-Reply-To: <20230419132048.193275637@linuxfoundation.org>
References: <20230419132048.193275637@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <a1b757b7-8489-4872-a13b-b39e2175ba9b@drhqmail202.nvidia.com>
Date:   Wed, 19 Apr 2023 13:28:24 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4f9127-bbfb-48c9-3141-08db4114a6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcqRXjLqZguRt5xqdHkokT//P/5PCRM+RUXiIZk+eUicAMyPi4Wd2dw2G/8dbnK/Rc741xFWQNr/Oi9emxYJmZHDGVoPqN1srbIlQiAL0OrJXidH2YqgSBfsUMwdBQdWbfa/aKO6rbAvoR1RogFXO56ki3itFRs5UkpFxqqyAxNgX/lTNDyybk1ajSEY1XEDsOFg//k74gW79YtOPjfsV0zDWK+AB/A37pK8w3CzxckqiYY8mDixocCGQgEr/DxDQZkj1sY7+XirFMyN7FFWcKUx2WGqCkTr+s814JJ8akb4DeyJF05yL59MYbNQ+ITwfStcU9FqMBRK7D8VO+YTk1NaB6FZtBBqkahPZsd+XeuR4B43xUmENWHNmwYf1OUb4EcrqFSkXQcGpMghQpmyD3oHeDjLd1lBslaIViCMvLu32/UfTkswOTxxmgmKHa8/CbJykk0AP/9Yd5R3SBLcGmxoTbge/bgkMEhkl5RD/xMNu7ZFAc7BggHmokYWLFBccxR57fP+GHb+c20TL3DdVbRyqnMDGz/IiQZkMj3cHAuxh5xLF4mFutBzdQ97RDkpmx1FRqNt88xFppnzvssUWdJILYSxjKLkEyoKzPiXLaLX/b60e9jR8Tmt3Rx3yQuW/7grOgvr3MIYqc48HnwvonGtRSJ1mHHW+dESUMm2SEDuI5wxw8/U/QZ1ouS4r0Cfw6LmBM71O2X5Jxa+vZ3ys4IeymWsMAtgMPHQANIc4Y73bH2KSOy5nvT0TvPbkS5EcZvFIe7xD1TVv+PtK3WT88sE+Ef11WcwxhJpN6QRgEk=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(966005)(40460700003)(82740400003)(2906002)(4326008)(70206006)(70586007)(6916009)(7416002)(86362001)(8936002)(41300700001)(316002)(7636003)(356005)(82310400005)(8676002)(31696002)(478600001)(40480700001)(54906003)(26005)(31686004)(336012)(426003)(36860700001)(47076005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 20:28:35.5847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4f9127-bbfb-48c9-3141-08db4114a6dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657
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

On Wed, 19 Apr 2023 15:21:54 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.25 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Apr 2023 13:20:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.25-rc3.gz
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

Linux version:	6.1.25-rc3-g45df5d9a8cbd
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
