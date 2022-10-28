Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC3B61103C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiJ1L65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiJ1L6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:58:48 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1791D2F6A;
        Fri, 28 Oct 2022 04:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZaX5ylCwqWLsoh3gCurX4jOtFZH6bD+REEeoszISrOcfaYQcb29JfZ+FaN9LJlDawu7SLFBw8v6FLb89pat/F74tQ/+N49JU2p7J0tGOmXXgcj/no5DdG8uQChDwtW+hzxdVbdyXEK9UWGezQTvRyTiD+vUFcYOmyoKD3Q5/1r3vNNfDK+aY126nb4aBuToka8J623N6+52bf83E8CQLlrEPh6tg8xMYnkakhPKC2eQ8Ey/3oAw6sxJ6VPnD7qUKqfnFR3CaBli/XnvbOcvOYmkVLRJ2xiEz0Ma38f2rHHxJYTanMNzBgDP1AebsdT5gMEIT/CUdPgbqPPU7cAc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0t4bJyvCacZHZON3jIqOlLBxzxWCfBie62vN4O2/XU=;
 b=HrUGaQEKsMjAj6mxZZ9Uo/XYQjbg29gr1Wo2w9w5uifV8QgD8+pBogUzhkoiCts8Pos6YeBAXEoV5Lugk80fNl9ixmTpttD7gkLaYZ6B21HFYFalolgqzLF2FB8yMMZiVdiZl4tdscNwO6WFh4DdXrDE0xOD2aVrjCWziwXx2XdynAHF0YkV/NODGglgDi4CsCBHUKlRLWlMFXsGS2dB81Pc1J00GHbmQwuJteXHEvJiJCtu6CUe/e9NrDXRZncRu7+CGK+ni5TliagLxdJ3JX+nijfcxtSph/83doLPy6LmDzzi4SgKWfBrxBwsS4nnX4Srmze0yvzFbmc3LMNzNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0t4bJyvCacZHZON3jIqOlLBxzxWCfBie62vN4O2/XU=;
 b=IGbWDgZq/A+YazUoT+7x76ssvixD9ii2IcG1NLH1fqrxlTVCS0LhsE0MyrR0JceDfFBd5uezplcJP5JWDDHV9KvkJTOLf2fSKKujVrZnPytEHgG9c/o6RjFlRwVWdhNpXHrdw6ftGrg2SpJbA6733ulxDWG773xNmz6Max058IpHJTco7+FwHqIGAaw3PQ6k22yj6vEDCOTn4nRkzLHpYUR8dZ3fLUdI6ldiZyzjxdW/IA8uIlP/Zcq8ZSHS5dSy10wP8mtfPSXIqEKZl1bImORSpWZ8CAY/Xr+xsDiQFzt/IC/Ws6kI8/cnLitkrNHDbEjX9cudgSsLuCbI51AcLA==
Received: from MW4PR04CA0193.namprd04.prod.outlook.com (2603:10b6:303:86::18)
 by DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 11:58:44 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::e2) by MW4PR04CA0193.outlook.office365.com
 (2603:10b6:303:86::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.29 via Frontend
 Transport; Fri, 28 Oct 2022 11:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 11:58:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 28 Oct
 2022 04:58:39 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 28 Oct 2022 04:58:39 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Fri, 28 Oct 2022 04:58:39 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.15 00/79] 5.15.76-rc1 review
In-Reply-To: <20221027165054.917467648@linuxfoundation.org>
References: <20221027165054.917467648@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <a5ab055f-b10d-4497-9227-a1871ea0070f@drhqmail203.nvidia.com>
Date:   Fri, 28 Oct 2022 04:58:39 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d2cbcf-fb5f-4fcb-620a-08dab8dbc373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jorUKaeIbuPJF4Wqn6NxYdPhpqWn6q6YRNKDfz7sJxgJyzoOBtrBDCCB6xbcSN4f+GP6IQXgRc+zFIPS7R31B+gAFwIzlPwERQxoaZOyyVgl/2O7fnEpfdjhtPUlNTgZYygpYvwC7QQbgwibS9tGCsRUj71g9eH5LC2Es9h/FrrTavFoat+2Wf9dryAOV3I4TFaddV0o26CMbyXwIx7JUNX3vXJQHII6sPftHH3S1lplBclL58cuFN/7uqnU7+OPlw3VPxQrS3E8zlMYKKKuxd68ESu6ovFcT8AzKs0YyhfLQ/iGtBjZ9XQXjgU/Nm1hMgqbbS6njxtSeNA0HEfLNaDd+PG1w7doMbDZaA+wakMZs/Ktewg3DvBcJK5se8osRdVPdDUY6+0SMw+e2BSSTgl3cwBAFwo+Jda4DY0TyauF2ckhAKIFljwEwf328AF7zhzmbxjYZ+k0Rkvb5OtetMTMbI0moD4UxfAzr1wAEA6Logg/iJpccwizIEY1MHuRtKguzQNbFtWTkMYN0gXdq4Sx72rX+bGYAh8xRNzm0DjLEpwb6LZOtlDcwLhyEIxGyseGiKILHSyHpXBWJQvp1hRooBsZSfIkY1445REZCTTS8uvyGbcbP15lz6Ye2V6kKmFh1axTNmLCV6ESUzDjVd6DPr2uwXtwfbbmoAIM/kxBNsqx8Kdk+gWRXCVz7cFOgi0jqHcVs/Glbok0lSHFGMPvZ7M5c4CAOxY8KVDdIeMyaJRqgG5I5JF1wv/oXWwivrOWZwb/gh/PuQiWyDmOx2oL/brG5STvT63B7bzUMTmYp8epNy3NydxlQ8mzu7ehtMIeedLtfibGZQbBTQGnboEOBYvg1LjHLjEvKOKgcY4=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(186003)(966005)(426003)(40480700001)(478600001)(47076005)(336012)(26005)(2906002)(7636003)(356005)(82740400003)(54906003)(6916009)(7416002)(41300700001)(5660300002)(4326008)(40460700003)(31686004)(316002)(31696002)(70206006)(70586007)(36860700001)(86362001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 11:58:44.1720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d2cbcf-fb5f-4fcb-620a-08dab8dbc373
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2022 18:54:58 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.76 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Oct 2022 16:50:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.76-rc1.gz
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

Linux version:	5.15.76-rc1-g5ea1b40eb208
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
