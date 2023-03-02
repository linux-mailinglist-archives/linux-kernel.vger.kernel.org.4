Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9876A7BDB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCBH1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjCBH1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:27:40 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11hn2200.outbound.protection.outlook.com [52.100.171.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4162BF1D;
        Wed,  1 Mar 2023 23:27:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMw+r2x8l/HuXEaJ7ADXLPzgfmKI0n6a0UfJEALZ3d93CaNh4XS0A0M0u6uA4XnaPjDcNxHd/6vuTmk2B9uYWc3qYWT2+zZG+BKqhIYQI/jxTg8dQiMFsCQnSUISjlw3y5y8C3XbLyUswN/JPSZLMr1gVCMlbOQSRgN/5eurnZ8xP2whF0Ipz2zQmm0Pe3hIuevq0Euthgzqbiu3FtuufPouashgjqNo0loTl7ns4TW+BpbTvVBwyqsVXdOJLNoO5pmjqEzcBJIZH9Tf2XBUjFbUU/7/GP73Vr0H8gsyIOtd4YTOs1DdUd8IZhh7FKPOnHTBVzqs6bQKaObNzTnGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcqBioB3b6EDY/GxpXIyOHMCvxVPWvQCy5VZ2ODU5Ts=;
 b=YGCbyGIy1QWJbvnN8W9arrItKA7A4Cv+1+A4myhmahbLaDqciOIlqHyrvL3+0PRIXuuBwjPYuE/IqT22823b1lw+TmhBGwE0C7jQQMpmyr0xIHgWKI7jBOWIiFvI4VUs5rmhb93gbzbMLnQN8jbQsKTz+vbSvV5hyI6RZkJ8O1okvBPXbWpzwT9OcHk2uGKJIiVtgfhDAqwMKLy5cqGZRs/knFZsHLRfV9PImVeAHvp6J8nKWFEK7HnGpaf6Rl6VrQawtl6cDkQbP359CcQBNKdl4t2Q6pYuChU+uEQ6SdmMXmjaSNwhFDG6m2etcc744pkhELDdfVVM9CDYqThJNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcqBioB3b6EDY/GxpXIyOHMCvxVPWvQCy5VZ2ODU5Ts=;
 b=JyS4zrY3AAiT1QpsilIIA57R+x9FHT1IzBbIDPEyS/qGfxZYNap+3liqGEt7yFCZMTA+hJCfSlE/Pl9gNb8WMSVBX5UyhetEtASs5ZQ46spNnOAW2tyhzp8R4CyqLkxUVlessEnzQ6WPBhQ4VJrw+CrBHo/o2HJIylMPwCIJMb1PYYNM+b21ImmVayULwhzpdCoFwqc3SW7ECmm4m1sikynpNOWS44vXuHTCBRhdNaLdfy9V+GauAfulGZBbaDjfB3MWz6Zu2zSq9CyfcEoKFJMA+XMfEvmmhcxJhICqDzV/WrKCPHclfe6C/Vtwcd9jhRZTBA31fNkhhNOtoOfZWQ==
Received: from MW4PR04CA0217.namprd04.prod.outlook.com (2603:10b6:303:87::12)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 07:27:36 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::49) by MW4PR04CA0217.outlook.office365.com
 (2603:10b6:303:87::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 07:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 07:27:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 1 Mar 2023
 23:27:24 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 1 Mar 2023 23:27:24 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 1 Mar 2023 23:27:24 -0800
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
Subject: Re: [PATCH 5.4 00/13] 5.4.234-rc1 review
In-Reply-To: <20230301180651.177668495@linuxfoundation.org>
References: <20230301180651.177668495@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <9180a0e3-90f8-41f1-a4c0-e5eb5d7b74cf@drhqmail203.nvidia.com>
Date:   Wed, 1 Mar 2023 23:27:24 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f701c2a-5645-4e7d-a1db-08db1aef97aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9uCuY/sRxIeA3w7gIB3zBKAaNYufUZwx1MlpoI6xBu5xixUpU/zZW36ihiEzGbHbezKDYuKu1XpsZhE6PvQHOcUyzFjA8DsG6Ytfya0E3Cy9Wl/4O+17vX13/YWUuve1o5qDQCIQkNxDgsJStokO+4vu6gBSyvOk5URkVxrG6r4V5wZo4fD2U8HHuA6HHkaR29KlQenqjw7roEs8VNIAgoJQu9cRt7cpXZAb0jnqF5PPLfp2wr+ZdGT0GTjC1i/0Z1VRdUI3D9mRSdJSCUmAaStAhOU4AizI2+DIGw5D11ojx4lIUCZ8yd1DZLphSP0UZI+zE/QZyBTwKo8HLFHfpAD3KEdaMWcdIB72kr3qRFc/ZOjRQB5uucFH8kzlR+bfB6h2OTePblA9SsoekSg57uDX7a1noOCN5bVVbYMYoqWkINSmXY9wA87CdVYU7wRD1DynWKeUm2JFx96jigN5yvK5EzjCwOI+1EmEcOhRKVXbg20hTL4NudBDimFYABthFdr5bMVnBybBDuNDopIWPSUuvUjLC3d60btnWloKIzg/iMvUQ1opo7NQbatH0KHdvglsaE7ytZDSd8T6Qz4QvTcTFCzTmjL8MElbBFra6e4eLGVsGW6cf4KPNSr//IszV3PfPa9Y0XeY9K34Y3yfC42SQeyUTR9L0iabuZCczv3IbddGTxKeY4tB+s6e0k56SH4SO2hc0i5ni5G16L+8uDZL7yaEjkN4ei8gOSPRvTtApqsQXTJxe8+pjBQeTK+TsBHo0Sjv/PI8Yj6Or85eRwgug3baQmNdsdRwjuwxd715cSVN4hgS6fjFxQMoDgk
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(5400799012)(451199018)(40470700004)(46966006)(36840700001)(31686004)(478600001)(82310400005)(54906003)(47076005)(336012)(7636003)(426003)(316002)(82740400003)(4326008)(34020700004)(6916009)(36860700001)(8676002)(40480700001)(5660300002)(40460700003)(186003)(26005)(966005)(31696002)(7416002)(8936002)(70586007)(70206006)(41300700001)(86362001)(2906002)(356005)(12100799018);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 07:27:34.6167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f701c2a-5645-4e7d-a1db-08db1aef97aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2023 19:07:23 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.234 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Mar 2023 18:06:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.234-rc1.gz
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

Linux version:	5.4.234-rc1-g71be0366b84f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
