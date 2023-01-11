Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498E76659E2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjAKLSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjAKLSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:18:04 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E13AE025;
        Wed, 11 Jan 2023 03:18:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHLygNZg5HGl+914JrGYs2iKQhSJ7MJV5Km8il5hrV3F5hVC3suT8yk2brXdHlGBukzKhwe5n55E0FaLiC95rvOvTwkGNzltHdj5g46tugzBa+bmcK9lVDJ1biTdAar1Ey1I3NJW2t9Ay2Zjcr8EiMOd/oCyTPDV9Elv154ChFbX1eoLc2ZwL1BfSOq/RTqjl+QH5IpNt2vrmCgN3dv2sygmmJgXJRxRsVZTBfGi4Be7OiyaOv8RmC3Pg+qYNcRuV+TWVDBtJ9Te1pgF4tPfhbcJAABm+7XaPnRi3/pI7rIw2PzmOFawXWhiI5n2SdtPN5OgWTMqDgbiEBf9O1HFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg/6ygzIQO8snJm7D6MtoZG3W2PdM625WkcvhHiYKjE=;
 b=MNhgcEQCXV8X1YOWzhDUx4+gua9CjirQMFbAGfPq1wCXtBzEn6Q2c5UYnxwY2/4MIY6MTHQNE0OtRlUXs5y78dnCbXW5JE16LsUkPHGUo4TIxhTkbAdWyzIGlXDYhsCzZrsjvZOeGCvji6JGYf8cY3ez42vNB7RaXLrlNAhcsOHGYvzLGUJqw/gzeLf+RnWOLsTOmXiB7GdEYzvjG45Z94KZzSUoMyK4rRV/mtmcPf604IgcWjExcCsOsYD83HcK/gZD6+WzhdKDv7mTcj1lq0fdEiwfxe7H+pyXxgsMGA/HdtLf9Djcrcjs/Q5sPm/GQuIHasUJ4NvhhdyFgCViyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg/6ygzIQO8snJm7D6MtoZG3W2PdM625WkcvhHiYKjE=;
 b=uPwH/PpLtmy8RtVMIiKCns+ny3gAbMxBpMdLZqRrA8/yYz1cFYwNvjkv1cZSMps1ka9U+h5jlVzDSPh7T2VL8oM+PZUrnyi1tMDdqiewY9xJA5mXa15syue/KoSswhtwpX/fGRO+E0ONtnxtX9/r1t8ApSb30SyjRDlSH5vIIQdfPMFQdOI51pKlQ6UUMGFfvXX3Sj6vH+V/T0dSbmpwttW7CDTZ5LLKrNSWfBciA2RrexDZKSxabyrYcM3WCJHcIWOe6cYulyiTs0rtJhIEujyP7aryOYSmNZ2/jtiBfAlYoj0RJrvEViZnWUWWXplf4dZdEowO0xV5m3cteRn74A==
Received: from DM5PR07CA0096.namprd07.prod.outlook.com (2603:10b6:4:ae::25) by
 MW4PR12MB6973.namprd12.prod.outlook.com (2603:10b6:303:20a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 11:18:01 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::6c) by DM5PR07CA0096.outlook.office365.com
 (2603:10b6:4:ae::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Wed, 11 Jan 2023 11:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12 via Frontend Transport; Wed, 11 Jan 2023 11:18:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 03:17:52 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 03:17:52 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 11 Jan 2023 03:17:52 -0800
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
Subject: Re: [PATCH 6.1 000/159] 6.1.5-rc1 review
In-Reply-To: <20230110180018.288460217@linuxfoundation.org>
References: <20230110180018.288460217@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b9d8c283-7609-4a1d-bc35-6a296bfbc819@rnnvmail204.nvidia.com>
Date:   Wed, 11 Jan 2023 03:17:52 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|MW4PR12MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ea06de-4d47-4ea9-6121-08daf3c58039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Zq1afpYxwLSQ3c7Yu0ai5dTPMvqm+hu4ryJaSJbuZ6peXgcEZx0x6P+cWdMJUUjpFZkVPKTnS0kdm5/o30c4jjpASEZ1b+Q5J2rsOx8obNxv30w2O1x4HiSRePsfQgvdPrPnU/WZ596wg4ltXSZzG8bATV4hyF8YPTWfXPyHyplLRD1hQY62nQtxb6B/gcmZZuAZeEHe3aEQ0zqqAQsiMgoJ8+lxbU19ycvRClFurLgh7/yAlcasv4gY/Cc7whIKx1UkikTDz3zEvqFzHeBWwM69Ad9YdP7sW7Ip4Jo1D2IbsMqcLnanLyFFKC/0JtqDeyCt/hIiw3tFsUfDvj8OZq5Ma4klmB2Htsb+Cqtve1VFqMH2bIt5OzkIlipfDJIKOZ56gZP9IYgNrj3vVMqDqPBkvu20gSP7SIe9VGSAy/WPd02jiJ9QtIJkSiSafXp8/OaM+KyYBh77iVKFc9sXkWQzzdEUyWaVwQEdjfApBk/O+mrlZcKnglqal1Ok4qhlGkpjUQPhEgeog7r3f+psJPdN4gH9hiUYmVPH+e8jtN0vqf9xmTl/mRASeRn5PFeRk5IYXfEvknpBwvSd4M+s8PXpHKwS6MO7knHZtwGgmHEt3hSN1uO3A1BYrkAWAwCGcc/Zsltm/JJ2Q3dqLYXNtd/9kBLaKf8X/uKWH011bymReHVNrbZTn67bEd6XTFQBzIaW9LBzUIWEkwGQHujrLPUozrJbGztdUR6la0oiWql8VdWgVMl9nJiok1goeEetIPyOs1XtVINic5o14wkHr23VW4kAhslg/DlqX2UB+Y=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(356005)(478600001)(426003)(966005)(7636003)(41300700001)(47076005)(86362001)(40460700003)(54906003)(316002)(31696002)(186003)(40480700001)(70586007)(26005)(336012)(82310400005)(70206006)(8676002)(4326008)(6916009)(5660300002)(36860700001)(7416002)(2906002)(31686004)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 11:18:01.0291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ea06de-4d47-4ea9-6121-08daf3c58039
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6973
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 19:02:28 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.5 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Jan 2023 17:59:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.5-rc1.gz
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

Linux version:	6.1.5-rc1-g06bcfb15cd3b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
