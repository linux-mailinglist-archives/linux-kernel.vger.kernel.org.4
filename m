Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089767159C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjE3JT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjE3JTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:19:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E19E8;
        Tue, 30 May 2023 02:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkmiPqJmdP0eM7iBzC3xbWOQYHslTydN7r+hA6yetSb2f83zpw1lSFJ2E5RRDkeir66nvZo1zDzv62cjG698j/gAEWCqcWQEuDzWuSw1LVKgjq+zlEXZYvg/12zrgPnnunssEtyJL3rsPQX1U/tityVmNk/LHdM7tVgPbraRyrmMHovKiHwOByYHCckOX/yqwLjojfLv2UoxEuuhW7fCBtEovZkAoySs9+q4o+UwGlQQmxoaPEWa2g3nFXMmN3TIAEQ5e1a3y7qYYjsc3pEZjiXNtw5dr4eLidtHldpgwGQyGLe6q9DQINlHyIK0/HhFSvD3uJwodlzX+5P+cy7Srg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJUwuROpPt3J/xs5BMt1eh18Fuh/TVTr+NkR1SwDjA0=;
 b=YSvfZFgE5wD0oUYceqTyF0PzMhZnhPVwDo0vkhPHK+orLgS294nmb7yXgnXDPYm1Nv8AazFmAcHdD7TBL1N9oS4+VefWGx0js7DxdANL43vP03da+BZaebFNYWm8Mf+kYd2pD+aLdJK3zmrsMsT/B9l2+dJFtgkvd4qB0i3qsXAAzncyLMqQ/5+1Ty5eCOSyNiP0II6g8T5uqilX4aoRkIYD2LwRUHFRBY9GrVK4/RLqHXi5hMWLH5ySIj3HFKU4eoizwHGXRDIgDFZdgkf7lZYxP3+uhj+wpPeUi8+NW6meFc9XVG4FM5Mi6jUKT1P3wUoEO9JAyc9BTCdo9O/WLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJUwuROpPt3J/xs5BMt1eh18Fuh/TVTr+NkR1SwDjA0=;
 b=srvg8BKErqe3Ru5fTva2gYlnkmgDDk+Khd6C0HN2BJLZcY2xIa2ZcD6JTwE33KnwCd9k+BmuplRtcFvO/qykfJANpLHEY1G6EDXyIutCCcsXy0RwfTWYk3g3w7bqHGCpVkTwETpDkg7tapyz6pZyddlkcF66NKq8gxQ+ekeHz3byx4eEo3UXsylEQHk4lKDtcDL382sqnVeKr5iTNpiSePVsLE8KPY7jJCvt8BF7PZ4LZaVbJcgn564yUKCA+Q0StHJG91UG6l/70R4qqmzZZ9OfQhSSHQIstvu1HIxGqSCWdgjL+lM1X3+sbWP0vYRPIM1Mb7nw9Hn7MpP1oTZ3Zw==
Received: from DM6PR05CA0041.namprd05.prod.outlook.com (2603:10b6:5:335::10)
 by PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 09:19:15 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::5d) by DM6PR05CA0041.outlook.office365.com
 (2603:10b6:5:335::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 09:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.21 via Frontend Transport; Tue, 30 May 2023 09:19:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 02:19:05 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 30 May
 2023 02:19:05 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 30 May 2023 02:19:04 -0700
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
Subject: Re: [PATCH 6.3 000/127] 6.3.5-rc1 review
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <bbd30d42-c7ac-4401-9480-883ab6d719d4@rnnvmail202.nvidia.com>
Date:   Tue, 30 May 2023 02:19:04 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|PH8PR12MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2fe598-cd32-4c4e-816b-08db60eeeffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNMy4oN4YdemYFKt0adyJig4CKVGTMXC6egZv3FFKo5DUB91YMyw9KolBHI3gX4qFX5KK5wCyYNyFi7DvLRSIpWA53HysZtnMKPr2tLVXAH2fMRMEX4gDdkb58HUrmuO6pdpxv0E0ffdxn60rZyvpuK2AcjztHvvrSl2LnZX2/PqIzovVqJFARbsEOVjbqzbzlD+C10zZ+kJkXYMfAijAv5rirhhTu6MTD1Hea4g5Wj/aWZZjUSHXKFeIqOqLuAoWPB6H6BGvyTK38LiZ4nA6+hbOVlFf4QHvu/eeO4potjN9/HKO2zxQXEazo0uIYUU0qtpTfjBpT0NYILBPWtZpMx+GV0omt8vVlcYtTlq1BL3l3dgMUWUVc5rjVY+jnCyq4ACLDiM/WI2+qEb+cE3Pli/e1bTTg++YlWTJniUApJS1/k6GtN64aZ10Tlsy49xnvWYRg+mbrOcAHaObZX7/c4OaNyr9ePVP36p7dPziO03ET+dohoYMiwAHkEl8o+YJJQZG+iQZfHosz0/KydrGfw6gLSvxJJVWFhG0lFXrEqGjM4ynVaI4ZQmbECT+sroH6W5194ZoYynPFadu5UdvFphuKAP/k7/3VQonHm0qHeTLnqJvzP9Nnw3FVHa0+I1s+PFeRzuC74h3zNad4WxegMP0T2ROYDD4R7aT/YSpe152zAAAOsUsZ+nTzPVmoPZpNVNf2HQfAiEwRcb3lbcOZP0mxaw7iNuBU5LfZiVWsBGNSidmtrpcu0VST2TJ5XnRv/D3jMNrD0F/xpDUA9iq/WpXWRjR3mOrXhztTkR4zE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(966005)(186003)(41300700001)(426003)(336012)(31686004)(36860700001)(26005)(47076005)(478600001)(40460700003)(54906003)(7636003)(356005)(82740400003)(70206006)(4326008)(6916009)(70586007)(40480700001)(316002)(5660300002)(8676002)(8936002)(7416002)(2906002)(31696002)(86362001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 09:19:14.6502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2fe598-cd32-4c4e-816b-08db60eeeffd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746
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

On Sun, 28 May 2023 20:09:36 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.5 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.5-rc1.gz
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

Linux version:	6.3.5-rc1-g1cd506b5ec44
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
