Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48706228F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiKIKr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiKIKrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:47:32 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E17B12610;
        Wed,  9 Nov 2022 02:47:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXBqB9gOiOPrgFgdMGmgK281r93VrZl0C1qFAEV2Eg2p+zk9YGg0Aj0HvFsHRkHjkeK6flnZdji9tjZPQ5O/z/K+B8c/ywBo06vExJ55jEDUVWCyjeuevFTnfpTvWUnxINIjg9wWsJah0LBPj/3upeo/niyCqbvSVFvJCR5lJevnGy/W7UCF6ciw5BmMkdNxulPwWQ1wphd0jmjpaDM6IHDseOqda7ukqehyScDULR3jm6FU9HysbiFhqNaPz51sP2p2SBsLDGA2uRlAy3L5d+1B9Qs3WCh2AD6/baKyiDu+mJu/atc+4GAU3OEBjis526/KRH+eaW2yvWs7Z2ZJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWLxnd3swktcP3mDOaEqBWkXiBuUJMw1UP7cDzciGYU=;
 b=XNCs1RP8rZbaEwTUVJLkqfnLQmB3RcNy0kWzFc9s4ZaD4xxW9y4gVyWb9KTuTCT6ZgCtjextB+QiaUwE33dbo1edBj2c3SI0Z2S9Br2hC1Xe2gexMTQW/xRyj+zRtyY1z4b5bytNCqCBLTIq9p5nHqkfdp+h7FAPVupye/V9wvJZUXqhnVyBLdCzGa1+l4J78MUu/5j6IESuSevdZD79LjFoY/UlRcookFGMb1H9H2QtmRtlJZ93WxBWsSO2vsPT6piODSjP4e3U0lkcYvXJfky4g36PBV4OcBqC5nrZp9bQCZ4v7VnwSuXeal1ShGsKRN61uFtwHVjOhsC9LePXHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWLxnd3swktcP3mDOaEqBWkXiBuUJMw1UP7cDzciGYU=;
 b=OY2RyCX+u7gdCDYwwzIfESEOAlAzaIIDVBn1+GboT/iH3b8i8T3x+e0yu088ZpuI2533UcC0/j53UJ/AZ9Lgbi9OnN0Qs+5xHYEfXyNxtO80X8oB3pdHqJMPfVed7w11QZ7M3ipt4uRS4E8+uqspFsWy+8hLzK3E4eYQ2VP6lKRw2NpIo0DqlJmhxMfg0JfrFHtjWQxyLMC12LFHLmzaq5G4adTsY7I898rZi5I/RMSjE/BkC2n28SrrSu7DoHZeIatDItVdMJbAXzIIRPHj6B4gSU6pUzJfYIOmwrHA2KFFU32bgZ6kh24VMATBEfmdkTXEIB0Ubp9iyHmPI06V1Q==
Received: from MW4PR04CA0050.namprd04.prod.outlook.com (2603:10b6:303:6a::25)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 10:47:27 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::b2) by MW4PR04CA0050.outlook.office365.com
 (2603:10b6:303:6a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 10:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 10:47:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 9 Nov 2022
 02:47:24 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 9 Nov 2022 02:47:23 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 9 Nov 2022 02:47:23 -0800
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
Subject: Re: [PATCH 4.19 00/48] 4.19.265-rc1 review
In-Reply-To: <20221108133329.533809494@linuxfoundation.org>
References: <20221108133329.533809494@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <f0141196-bca7-4391-8e7d-9dd03fb0ce69@drhqmail202.nvidia.com>
Date:   Wed, 9 Nov 2022 02:47:23 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: fa89f29a-2690-4c79-3c34-08dac23fcaec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SI8ZIXTJdgi9V3U6GRWVv9vJopzm50l+ZVkXdn/GF8YAzKTRSV9e/LG04GHHfMOgP0I8XawkMgq1PIPPQYycwTgbjZTdrNOPfOzDMpMB5BrCkpT40UBsdE49YyFduJDdmUaj0VgXbuDoVeDiCgM3chTN97glvc97u33DvBP0heTkHPmWQktdqh31A2GrIwoMbiUDRk7XXGNnL+DOwMCSf7tkQGIOHvUObiY8lUmsqK0ZtR/AmbpEHWYuPaJ9QQVKRZ7DLVHp2cHnhahJ62qhM2awcWNF1t682lLlH30nlT04o/DmFq81XuK9UszTpkUsHZnRXMF505kMXt50O+U4e65VrXxqJu6/0w0LSk7appnM7scpOoQ2+sHnWUe4ByzltMo65TdZP+FdvsuF5xZAfpTdaFdY/nCKq5D2ra01RGw2P+yleQ5I8ftT1wqNb5jZu/mPpMJpZHDmAl9LkmN30A45qaJ2DNFi9JReiwtlDkKG/QWQDxxk3xB3AxZuoSNmKKtstD2sjf/qel7+mlSWE9Xis/i7yB6V7q9lnW7W8v8kHpmxdCDwcCXJdNUpLD2TKK0mrMbAfnTagr9tQ2Rdcqi1NZLf6HxMhSzN9wGM22YEqREbBfxkmiHWPFudWSDJIUA+K/NVIMKu9YI81EYjhnLQ8VKpFT6ckfSXdp1DL4KXkGQ8X6wrDIXlCvN3y1d5qlO8E1ma8/tEc1ySKupgrsJKPzVIXDaswCVhZj56UtWzy+v9hpjKjN171BTlzphv+fsBvtJ4K0dm98cpfpRU6Tq/+xasgt61F3ewTufLcKBl8P/Gjj6J8HFDyUm618/aKf+0v2Q8QeFwipkXgdYjZ1QM4Cl1PDrhkxDBgPx3mmE=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(336012)(2906002)(26005)(186003)(47076005)(426003)(36860700001)(40460700003)(40480700001)(82310400005)(316002)(7416002)(478600001)(6916009)(54906003)(5660300002)(70586007)(966005)(41300700001)(8936002)(70206006)(8676002)(4326008)(82740400003)(356005)(86362001)(7636003)(31686004)(31696002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:47:26.8616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa89f29a-2690-4c79-3c34-08dac23fcaec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Nov 2022 14:38:45 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.265 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Nov 2022 13:33:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.265-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    22 boots:	22 pass, 0 fail
    40 tests:	40 pass, 0 fail

Linux version:	4.19.265-rc1-gde1300f83201
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
