Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E924564EBD2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiLPNFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiLPNFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:05:24 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BD82BB1F;
        Fri, 16 Dec 2022 05:05:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tw8ww/+/tYFvau3nLCqHLiXgkl/IKKsnzyV2BB3l0jmcXA3+0eSl7DPX3HpdcLifKRHeoEQoqGiGv65Zwf4UesMSCr6c8IQKwU/q6svlUjFzy+gHN0p93sq+t0ot4/OydsQe9zUqEiJpxIgkmdveQMy/ORxv1RGwxVRePXN3zebwQi6QqKpAZXHVtk0nNFKYFilDL9RaMX3Dgsyp6IDAixqCESOhw7B0YH5MFCR0vraNK27odiTHd0bFD6SY2LtICBxQv1FfN/5pDpbKVo2/zzkl05yeyD93GlO1ucC46oTNnNq1NuSpwMdyfdHRuHX/W4xUvaahTa/9BvbXjopRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM5c0azFwt7mNuMLCRXbCw8vBBFLHpJJiUttpBqEERI=;
 b=WGoaSVB2lTxOgpqnDcqr9Sjlxv6rC4JXT5KndlPwwXUTdy7VNwGGInu6OFWBmidjgzRnvaurW4jlKBM/x4p2MnSo+2HSHO5zRWP/2vw7Ginxk0xfi2ffA18Nn0bc3Ek7axZRiR/nG9/D9GtPbH+eFHOAnbqDHETTcTEAo16wA7g875sqNvyTxdwq9A2RXIjvpuVQA19CVj1N+dOecx+uFmt702vOC7Pz66e+zD0nXTwKc+BCAZwwORqoBPC3mTFRtwr98OhARd6CQYlsJlV+sQJaHxvuG5v9XaWdc0arnPlWhb6AVXzoQluC0T6KwYUwOgR1Y5M8RhCqQq4rq92sTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM5c0azFwt7mNuMLCRXbCw8vBBFLHpJJiUttpBqEERI=;
 b=O6zzxgS4DJmhCVMHSNXIi3gcV8laL32aJh28Ry0XZ5rhyq4h43syyDj4SWXjaSPyA2B9YdBe3928iszktpyzbhteMBwRlU/dKfth9YUm3pk74S5zMLw5r+SWhqUXEqa3FQP46zfbGgOls+nz6xXfl5YArjq33zyAo0O8/a/cyEWbW0MkQExKrUCrO0Gr9oCTWCZOrvx9Ov3Vq5ujdNCnWRYVs6ZUVaWXI8SlXvO5/lVWdN9qOnJPX/a2L0IkvGJ78J3/eToLJWItzcEfPV6JRT2bBeBCk6nAAjltvd6Iwn9N4SjzcHcZywjhpEKQaLsRt7nSmJ0gKnv9rLTxWyWU5w==
Received: from MW4PR04CA0034.namprd04.prod.outlook.com (2603:10b6:303:6a::9)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 13:05:15 +0000
Received: from CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::2b) by MW4PR04CA0034.outlook.office365.com
 (2603:10b6:303:6a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16 via Frontend
 Transport; Fri, 16 Dec 2022 13:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT115.mail.protection.outlook.com (10.13.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16 via Frontend Transport; Fri, 16 Dec 2022 13:05:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 16 Dec
 2022 05:05:04 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 16 Dec
 2022 05:05:03 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Fri, 16 Dec 2022 05:05:03 -0800
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
Subject: Re: [PATCH 6.0 00/16] 6.0.14-rc1 review
In-Reply-To: <20221215172908.162858817@linuxfoundation.org>
References: <20221215172908.162858817@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <ca7d1969-1d2f-442f-9b6f-e1380cc0f26e@rnnvmail205.nvidia.com>
Date:   Fri, 16 Dec 2022 05:05:03 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT115:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8af51c-04d9-4795-1c0e-08dadf662c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AGm3M2Qh1obKQNCyvDIma0gw94FUD2AJJ5KZokt0JBfkRm6rEIqKxwokSz5dX3ScQHIbhW+a+FLYwxQeMUASuIJZz6b0HDFcaaKa++c/8GZj//CUbZNA4+plQNZvZQ49Gj1ifob6KRtIbhAjAHrqQ1hh+rWcBWZXORO4rCRI6B9gLwCrMRgCK8bWW+VmUJG7kk3LcPtUTlcnKbW4wKpWAeaJBaQLUMLkge6RTrbHKo+J3UT2lAA7Ih9LWfwty5zR+rEsbM2I76UGy3SHZQyV1UyVSfrbuqACziTurNAGObFJtpwVCpLB2x3zU7SqW8kKXDy26fxIscw2RhHU5ZyODnSsNrWW0lm9Zw2AyX3QhfHobgAeWSM8paORHD0ok+3wHESlc1QjZLX3s0di+oJcCrmLErK30zlTKhiLhKMcn+vu4N6BBUkf/Hl3JuuOhOlIaQBLFaGjvwyK3AkBtChxFjW6uKgEOyt1uXSGdgalemTlCAMYKY9P/EXdzStMXG/6cha5WYZY/X3FVgS8PfXyx4XdAuqtUHFhnJ1n3hHsHBfYNSDLCkVfc+V8Ku1D1ilYpm02F6LmPXGm3rB5o2WDkFZrO9AraxqH11M2Y2seQ59zbDLxq2/qgmqEBgHzR/HHDL8PsnWMW1WDwKzP6A05Xlr8h/CHldnLUXdJD32cJKoa5XcEPqWg8vP4i560eCVbnZPFSL6EezYbVxmIdDE14mqQACe/x4pojFDRfDtyQWU+Bw4dZIZK78WKWwALSO7SJxav4YeViEHm0h4DuYbkl5LQZLzZEeVsTWZp3+70hk=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(6916009)(82310400005)(336012)(70586007)(47076005)(426003)(54906003)(4326008)(316002)(8676002)(7416002)(2906002)(86362001)(40460700003)(82740400003)(7636003)(36860700001)(70206006)(356005)(31696002)(5660300002)(40480700001)(41300700001)(966005)(8936002)(26005)(478600001)(186003)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 13:05:15.2119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8af51c-04d9-4795-1c0e-08dadf662c87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 19:10:44 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.14 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Dec 2022 17:28:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.0:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.0.14-rc1-g8173f9d249ce
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
