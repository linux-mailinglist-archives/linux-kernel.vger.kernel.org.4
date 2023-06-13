Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E9C72DCD2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbjFMIkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241599AbjFMIjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:39:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CE0E4;
        Tue, 13 Jun 2023 01:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeKAKbdJEV+EoJ0Tqh2oXzLt4CbFw1B9lqa9eMxXdiSdVB1Ua2/hEvCKrWhyc4jGygWcWNERVVsFwQQ0jnRA1UeMwbQhBJ+QgLkS/6nYubeakdXvWVKTC0cQJoXR0Rqz4UjxCxeHEYv69X+cCzv3JOeVjTdt19VE/m059WpzsDhhEX6nkOHapXfJWTL7FM92eWn9radOO7R40DFFZwwRSARZNbuTEmyAsV9Xs8Tm1fbKADTtTpMFmG7KZjjqlCYB9J1P62wq1kY+kG8FwvFKW4APifp6ZRMds6IY9Va8qKuqiL7P40Ku7N7udNuJtKpcRdG29HgWj30+YCecEWw9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jn/0GiKxxHXbhT8hCybN2E6Cg/Xx5suuWi+0lQnVLFk=;
 b=XXj8diiteWWZ+zOJ/p4JDGn+rERUP3Du9SwR1MAt8thGL+YW8q8k5O+Y38l0B5EEMYeUqMbRCQYu8+pL6E21URHXn+VTspjVaRbkXEEuaBRXFzhCbkNNCC6ld9js6oKVOCz9bTMXZIv4ynIVxbsgIZhvfUyx2AHWE3fJF8zNJvzm9jWWTg6pB7MrGMB1Q3vuSGQH6VWf33entlcNOad3eIm2Yt82UD/2zooOphkOomkErgjm3Xmb3k2bRX5zbhvB0CjYEvMFQa2dOZpA/DYudiL+6FaPOZHK64rzC1goOGxrBhoV70KQDnFoCn8eRkvrXHe/R65by0YxjlIkbrBszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn/0GiKxxHXbhT8hCybN2E6Cg/Xx5suuWi+0lQnVLFk=;
 b=rbb3kKUsWISZd4Noj6O0vRMuoFdwYONwIdJW1UqjQj36KwextJq1bb71hlIC3QW9JWyNYpDEBGdIeb8PrkK1WORLlFHpinnW+EKEkmP4P/1sduwv6JYVvRDLRT0vzI47sgBXoiWXCo2kO89euP3+jOispUuh4Xm7j5e8OFeKYkDntyfruAyi+SU162kDfTH0fmNBSf9IUNFWUn50Pb9gBU1/26X0rI97xyBHlLk5WDXmdWetTS1IcPcNpeQKkK9XV196PthpUwhWfNg47iq++q/GEXefwxa71qfj694BEjflsYF3FY3e1+NYzNJS6RiAAA2CDZq9v7OfdK8BQlw/nA==
Received: from CY5PR10CA0025.namprd10.prod.outlook.com (2603:10b6:930:1c::22)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 08:39:36 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:1c:cafe::37) by CY5PR10CA0025.outlook.office365.com
 (2603:10b6:930:1c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 08:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 08:39:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 13 Jun 2023
 01:39:18 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 13 Jun
 2023 01:39:18 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 13 Jun 2023 01:39:17 -0700
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
Subject: Re: [PATCH 6.3 000/160] 6.3.8-rc1 review
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <f84b8683-445d-4c14-bd3d-1602a9f17b2e@rnnvmail202.nvidia.com>
Date:   Tue, 13 Jun 2023 01:39:17 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 131718e7-d590-4566-9ed8-08db6be9b7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHXmxER7+d9F972xje7mrZIN97yCEUGu27oKrcYm2jLGxDUtm90SGBWR7xVSIHdVCuGdAr6KqWfJn3G+faHHsMrva+ki+1uGk885Oems1ex/8jAaeMCenuvoO2w2cSRbM7avBGGaKrYOIgUqPjSw1Qe3SvtS8QDIhCYLsJK38eg6VC0IyoCU/mUGNZrN0iMslc1MJytToRyod+V81evelz7dU7JZTyCdF0X5M/XNvvcUXR0dbWSX/lAL17qMKz1WfdG4b8aansgq8nH+PAnH8LIbbjdrzZ3+aknwYSPG+0Uod7pwRYGnl/xvjZFil+4yQ2iCTIjkPkVeVi5yXINe5CtrxoPQRAJwbRBBE31D4VnV8MbNgH2R3/ibDBylu4Fj+dwU90s/oNrUE3EDmmvWOcZ8mCJ6qc+K9SpgsfXjwXr2H6CAtAUvyWdkP8i57fRHJE3O+RGf+Z0QwiUOUeUSsIkcF5h0Ch19wxwdprnhCTr9kibG4eBE6UMKXYZKvppOxUF+Q/PgyVzhs2fh6k2g6Ni7vBPhzxhZX04nPNv0Go+Ub7ZG/rI/EevCx0VTrCiFy5Ws4pDMB9CYatF/Omv7Jnm33HHZR7D/MdpdDnG3rRyMT9DfpwswSl/iX5/RwxWHfwvt1hbut1GVt/BOf0SS3Sprg8LaNhdk+OrIfsQbroWh1StHoG8bqSR2uTgv0Bbf9f78mBc0BAFyOD77p5nWoX1W1sjJwoZKnfljrMmw+ly6Ay9ivYbs9xYddEyY/+i71HXWJAzvrGfWVeBsYbZQCIxEQQ8QK2bGqQGOxPTJOaM=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(47076005)(41300700001)(26005)(31686004)(426003)(966005)(36860700001)(186003)(336012)(40480700001)(478600001)(6916009)(316002)(356005)(82310400005)(54906003)(70206006)(40460700003)(7636003)(4326008)(82740400003)(7416002)(8936002)(70586007)(5660300002)(2906002)(31696002)(86362001)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 08:39:35.6908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 131718e7-d590-4566-9ed8-08db6be9b7cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293
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

On Mon, 12 Jun 2023 12:25:32 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.8 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.3:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.3.8-rc1-g718be3905b8f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
