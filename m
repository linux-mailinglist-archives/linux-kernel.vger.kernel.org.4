Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1D565C313
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbjACPeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237933AbjACPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:33:49 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF9A11C17;
        Tue,  3 Jan 2023 07:33:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c42wCLwJMAITcbrWi1++aU6emzRq8VDolWJPTqGtGWviM3DKgxlLU2AB3HMu21mjHjexvfXjZUY6YczFcRgk7WWRG/p66v504zP9RpSGI5ohDUiruyW9x3ImaK2eXHTYcDo4KzZFaPYhaBPvbrEl/P3y9ylJZBG+i0M8qtAaOOyr/7rBo2ILFUeepYkvTMBfC1QAkbGUFcmzPA7oep/4Vy9cxd13D64X6ldzZH+UVGBGXSjxb8kIZ6p/c9pdkPBYN6CTWA5SSHcS1AyD4vwpxqdLDERS0hd/ENX2C/QMorgeoi8thCqXaKQiAQirBkcdTcVDV2cXW04UVKoetM7V2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bw9kUhUXPn5owWEbR/JulGpZgKLbz3ly31Nb9BdIAeM=;
 b=PBpNaQRB+W9wogAPaCEOjvpPPWcVuObTYphq4lE5c9ZKRtkqHSGVGcD3mqwmebmDhziKXsWgE5bJov7J5R9g8+4pHtbg2R7Ef1LBs1KwLHQWv6PX1AyDGwS4lwZRNO9mkvw3Q5GqkZJ8GHXowJuAI4eMuuGUU9S1YKJ3ulQ8JrN+IUq1+Bcl5nEHdiAA2wEvU0Ggd+dC7suAIa6oCZJ6IDstntTpxYn9TAhjkwiI4ePVEz2vtdN40B/WzsDaeXl10jRn/HbW0bNfuABgiCi+dR5XUjMHDiUpvMjhy4oqkFpPOT90kEbAJIHRrwSPEh+i2wtdZsUw8E6N2PrWW8tVpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bw9kUhUXPn5owWEbR/JulGpZgKLbz3ly31Nb9BdIAeM=;
 b=YHLbB6BRy9LvYVFgpQyRbbVe321ESbXAB+3c9ucZPREcvBKBGuxnbiGCf3O0DDxf3EF3e1swGh5SF2IOaJcAmxJ+TdVzpTICSKtUABH+zVVdds1NCrip4ApNuoakAxjZnVcQvAeoKfH1ZCZNVVcNAEcRS7Z8Z1qUjqudtK4eadUesVmdkqX/1HiMXpOUcD3CQKFRbjSCkvlf4bYdaDVaCY8QJCL4I3iGiZxaiUmxv3ujxOdhHomZS7DRZza3n4mAbm3qV1WI9sZ6Y01zbGKBnxh3OOt45s2GY5BXDKwTvY/rU1hup+pp7IiI0dcHOybhUVV9aHEz1bewtMYZWcqJdQ==
Received: from BN9PR03CA0040.namprd03.prod.outlook.com (2603:10b6:408:fb::15)
 by DM8PR12MB5480.namprd12.prod.outlook.com (2603:10b6:8:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 15:33:47 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::28) by BN9PR03CA0040.outlook.office365.com
 (2603:10b6:408:fb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Tue, 3 Jan 2023 15:33:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.17 via Frontend Transport; Tue, 3 Jan 2023 15:33:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 3 Jan 2023
 07:33:34 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 3 Jan 2023
 07:33:34 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 3 Jan 2023 07:33:34 -0800
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
Subject: Re: [PATCH 6.1 00/71] 6.1.3-rc1 review
In-Reply-To: <20230102110551.509937186@linuxfoundation.org>
References: <20230102110551.509937186@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b791ded2-a4b2-4e55-b798-20c2b4fa9cdf@rnnvmail205.nvidia.com>
Date:   Tue, 3 Jan 2023 07:33:34 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|DM8PR12MB5480:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd3f16b-d899-4a75-5eec-08daed9fe7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gzzeMY4UycccRYclNtpzquyBk+7HZMANRJH863xy+O7fwrx5uKjWKQXZMtzn9FRc73cVRupvIpDiG00ml0yhuc0KIQz9//u7bovLJi00Uajf50mhmJXC5papIIypD+jHNG+Ag4IwQyJmrjASvkd1tohU8XwtVBM5Bj4VDkiuad2upyY+Zj0FAv0s8CxMRmv7lXRj2lPXBo/kNETGhA5mGFuiujVMDv2ZqmDXKcJSEeAiEDbBRDjw1cCTU2tKailRIyAr1DIOl3KrarDGSUoSAPMzGg6FFI5vOWfsGUpAnSIAIPszipILMKFa98etsfYOQcrpNH1IN1fIQOnO3k0iwInNU0NowkkEI2YBTl1azXTMPMwnM0lcb4JgHi4QUL0qelnkUN/tM+rapD7pn5qVYEw4tpH9vS6JuDZ8FPrqlKv/32ENVfpdFgo/Ge9lQoMdlx/j85abrjcsdx+b+9LOm5kmoG3sgsxtxBzbG+w9XspvJKFIoiZBz0EpZeMrp67wrTr7Ik/HOnbqCsjMsNkn4DlPDIz60SOW1lZuXd7l1U/8ksNpPkFUMZiM1AGiuOpVoF5mqhg8QhZcFl5NbqRSYyav8upFkW9JPj5W8BvaZzoK237uT2UhjhXrCOPM8iQT3AfHn63yNi0KoSVCNTfeQd4lD2NQAyc3XJMq5dl0HFPbaLjytwAdKLoIh3qFjRukrQMM3/lhPDs7jW3jb6CsF3cLNYULaqm74d9/JYkVGldAeWx2v7fvTIwpAwFHbkHbMJCkuNrFH+396a+Ml7e9M3EQyGVo0bQQoPViVx9BCPSkNSQsmAU1YUgEMcRbtNoO
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(47076005)(8936002)(426003)(31686004)(8676002)(41300700001)(336012)(4326008)(36860700001)(70586007)(70206006)(7416002)(5660300002)(82740400003)(2906002)(186003)(478600001)(966005)(356005)(40480700001)(26005)(7636003)(316002)(54906003)(31696002)(6916009)(40460700003)(82310400005)(86362001)(22166006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 15:33:46.9746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd3f16b-d899-4a75-5eec-08daed9fe7da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5480
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Jan 2023 12:21:25 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.3 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jan 2023 11:05:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.3-rc1.gz
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
    120 tests:	120 pass, 0 fail

Linux version:	6.1.3-rc1-g6b5c4463f777
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
