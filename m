Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4030671FC68
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjFBIqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjFBIpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:45:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE8F1A2;
        Fri,  2 Jun 2023 01:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOSqS4+ne3jfWQrDK2N9uEBNz6kwQSWOdNoT7HBuO27youJN+nGjSK2r5OXN8Ry/WRBFN2WAH42qsxqYqR2s/QYsf0dFHJB87xL9DJKCQGdV3LBe79YCnYad14+elg/7SCXMJNNG7tmAQ02P/QTm7h2EOyWiaGWMG+/vLLRAtbd/p0fa86ikqWKUEkPb95hyK0UNugJQMLCyo0/qrRwDPXElFM/kv25H0LkWFklyveHmBaaRLSYFOg3yMAZrBLRgU9BNihqCFjHfmTK4kf2nPHnsydGO1pVA3qr5TC8CTkGGgV7vPk5oEjVitfHDqPlWtp5QqsUvFnnDPw9xUXNKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zb8Gps1QzJTOOzL9R6pMBZh5WqFyLBgUfGN1Nk4oZI=;
 b=DpMJn068o1JVsRBX7/CTR1AKD4l/G508MnomxEe4l9I+doana0Gom7VOvfikCymxmKRxSKAA8kCvxmsBNB44UWJr98BudXHRnQFU4Qr1eK5bDytMvlD5Dwq8Hv+KY7ibwI+/QEdJ0qSaKvBivNVTVbYkomQnV+boE/v9tbpspZdqu2S2ptEDsaDbT1FVRUVG8cMOJ8p42iQ/LQiOy//0eNdZETgUeaSllP04RdJnnKNgkZMWcgE4295n0A34j2DraTj4rH1847ecXxaMrthFf53MIcpP17q/44Th2SZiFx7HME69EsyL8LBPhIQyqVhhQI14dOTmPlXylwZ3swuA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zb8Gps1QzJTOOzL9R6pMBZh5WqFyLBgUfGN1Nk4oZI=;
 b=gqUku1sOeGL3t0pCnWFvPqiV23rypL2Ukd1VDxHNL6t1K40h1L5bd5L2OnIyBOgdItmo1xZ40TYCxezSUzv98eh3+aXiE9qwBTX3AQpnel1Z+jPN5KH0OOm5ruygAHWAeJawNJZoGi842PDnv4MyaNs7d2Y8KEECkQbE5Vx6mWzCQtnHsYSsJGEvVZD18RndogEpwD1+npuYY1SI27tu/lkE9yQq8iCJ9PH1rjXb0CD5ugDrs0r+3emYKfPJ2RzsvDficB+DK03mpGPD0xgKmVIfTpGl2sVNDKRLv6gJr8qpQf+ahrxWifhJRYRi31/mB4I874WnTJm0d4RXCJZCzw==
Received: from BN8PR04CA0020.namprd04.prod.outlook.com (2603:10b6:408:70::33)
 by BY5PR12MB4933.namprd12.prod.outlook.com (2603:10b6:a03:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 08:45:26 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::c6) by BN8PR04CA0020.outlook.office365.com
 (2603:10b6:408:70::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24 via Frontend
 Transport; Fri, 2 Jun 2023 08:45:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.26 via Frontend Transport; Fri, 2 Jun 2023 08:45:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 01:45:15 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 01:45:14 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 2 Jun 2023 01:45:14 -0700
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
Subject: Re: [PATCH 6.3 00/45] 6.3.6-rc1 review
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <2e2d5f5f-a63b-4b0e-bb15-1fcb9f78fe90@rnnvmail202.nvidia.com>
Date:   Fri, 2 Jun 2023 01:45:14 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|BY5PR12MB4933:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d51e78-4e6d-4fe5-dfae-08db6345b5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VqYBAv15mbhRHbn2IdktqhQEa+3U522+0ZkGVhJotKWZVCj6hQyeE8VEP1qP07QnZtEKES60WSYtA5HiaskdBiV3LemzWWancWWgcTF3L0wwkzUs13LQm0jvGe/Bkt/0TEJ16ueJmy9l/Sh5QVWC4Kib7qwKkOkf43UmPF7eWroY1dAAgzr7+5ztCz7RGwEFmvhxarR8GGvfX4Ff5rRTenWJJqwpUTN2BcAnePZeLk1NHZK+ejfjKcCZhu9ZlHMx9lTrAeZ3RYGoF03o6Xlsl+DVzx83OAP1sD08lCyHtIROjAgPtJ7nufrUMpyNe2YF4/5gFN/q0F2T42Q6w+pHVttcAj0XRUdWOzpkIreKDEehlr8J4lmQrF0Id0nDuOLAzkdHuNtRff2kUf3mopGG2Mv95lKyzJVKMTvIuYRvnzRQhnPm7N8ywNRkmT9ii26RDCkM6ddOV3ONGLMhoGau2/CfTuJKXQ+hHWrYCohWm7Mi0KQSjyOZtqgj9/6muoB2HR8pHandBut1jElwCip1TT4W0ipunD/Yvx4ACP5AuwV4oPpYC+GsvQolAaw1/VrmDPCmZAzhlw9XrUDAaMUkju6QnxNLCrEcb6/kEz+ljbRLiEyq1ovfXTReSKezQ8nVlbw8Vv+38/MBV+NnpQJS0h0v2vgZhQQxyQk1Nyhlj2UWdepJnVG+PD39nPliAh5oRMbiyX3cKNR1JL5xSCXFOOy1/cwT+lmUfRWGr8q0MetM5D1+D1LoQ3yxq2bCqusk5c5ZJj1xPXdvvFaYtlDh7A==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(336012)(426003)(47076005)(40460700003)(2906002)(86362001)(82310400005)(31696002)(7636003)(356005)(82740400003)(36860700001)(40480700001)(316002)(5660300002)(4326008)(7416002)(41300700001)(966005)(478600001)(54906003)(8936002)(8676002)(186003)(31686004)(6916009)(70206006)(70586007)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 08:45:25.8233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d51e78-4e6d-4fe5-dfae-08db6345b5fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4933
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

On Thu, 01 Jun 2023 14:20:56 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.6 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.6-rc1.gz
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

Linux version:	6.3.6-rc1-gb8c049753f7c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
