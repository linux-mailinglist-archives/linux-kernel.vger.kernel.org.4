Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A6C6F4826
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjEBQSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjEBQST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:18:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E261B1;
        Tue,  2 May 2023 09:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbkQ1M/HJ8PCEwhSZyQ8vCt+jdjdOSHqbXrvuPg8Fzwe12bJoBF1A7bN6wSTOvJ9mrOk367X6A91u9bb+DLShCvxaDI9u7NmnQxvzbAtLVrLGYB0UzT9d4GGcST5J1G6IDvo+bQQ4z+vfJcSZnwlD7Xg5p7l2NoCDNdeI5C07FMkBPpsjgFhxIi0UZpvU1lxlBT4l0a9FJtW/rVKrK9KprAOdQktrdHiDHqJdDVJmbP7eXDHJFNKuEPC8hwNkY6Z3LDHBzVZLgqIYfGv4t/wj4lnN3+4yCA0R964SIw5RXhjjGk00laK/kZQJyN+jNCHvhwycmDX8pB0cI4RIZKyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTOdtbfLz4AmJd/tAZlUjBBl9LyrZWVQ3SupCkI4cdM=;
 b=H02/OVGn2sThd2rKLtnevGiLFKNJ6mp+GwfzNVOsNsDBS81lr6mWQSvGdr44LtpGgUA6728humUp3EqzH+VvitxvKY3ToBQm0YR2SNqUMjTh2jTiD7xn/Q1HJu0PDmZ7UCyrN1WaKNENiyIs5lDjzKjqtTME1sEFfein4br+SFUKiz/FzMEtNLr44ACWiRAqc4DVXXjEpVbTwB/nztv405ChdaTVoAZw6nBbIE11QWaKacgf8t+I4OQb4tWhTHavGKFV6fASHd60mEjgEwRViw4SGRKt4RvpSYyqIHOBxl4L/zN5XFvdsIaPdXnKtNIhZzfs8ueTWjdy9H2kWxm45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTOdtbfLz4AmJd/tAZlUjBBl9LyrZWVQ3SupCkI4cdM=;
 b=tUMZygu7nKHsPXZqg2hvUFIMsYWtTC3pTlW6DFgxNwSnDQZswt3JG4RSfzKoz4z1BhH/cQYO2lyPL3Usaih3jDnPZqEcK2GisRk2+CtQCZcCrfYWz8C9CKnSQQldWqyXwltoy/E4XKKZ7xtHf8j5ZKPLhO04jURHe4F220BOtdPuTnSP/PsJuc8pX9WcPrxzO5a/iVySEC9oi63BrqGiyyq4GNxm2Q+bEcscmOZ1la4xUeb9yx8b4L9jvfTAPjKQsVJwHbOLD+PWuAb3xnJpaMlYudrfRHNffkk/ScYrZEoJQsFKy3kN/43KdPIQyxqEB6rSR7fs/wCqjrjDRY2NEw==
Received: from MW4PR03CA0172.namprd03.prod.outlook.com (2603:10b6:303:8d::27)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 16:18:03 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::42) by MW4PR03CA0172.outlook.office365.com
 (2603:10b6:303:8d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30 via Frontend
 Transport; Tue, 2 May 2023 16:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 16:18:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 2 May 2023
 09:17:50 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 2 May 2023
 09:17:50 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 2 May 2023 09:17:50 -0700
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
Subject: Re: [PATCH 6.1 00/16] 6.1.27-rc1 review
In-Reply-To: <20230428112040.063291126@linuxfoundation.org>
References: <20230428112040.063291126@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <a279f953-2a2d-4bbd-8544-3c5e2f56bbca@rnnvmail204.nvidia.com>
Date:   Tue, 2 May 2023 09:17:50 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: b9279134-3d4d-426c-047b-08db4b28ce3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b44QjCd6GFWdFQ3pkmX9aP7Cod+qfb7LwOcP9ezoMKRXz11OnVh9PFKEQZ8szmf0D03dOJtuXU/5X8oxRUcyZ27Z441kLvXZhyvKtBpghtW/RmiOVF79kIkBDHVpM6WYc+0iwkNM02NboH4Pi8a5QpDRVBlpJTYZvHQYxRvPpdnwoilgzSd+nTRFlhahEmzqkNnD/E62/TFospGBj6zNsKCjLaEPRRyZsy8BjPu82e5t6KgkS6OP4aqEFx8HjTjXTiBBZBTgWUmPdmlGhOAo3HBQjIoMnStMvdx1UPve6DpYThhqfZQx9KRKe/xCGzcOzpFyESkxLSn8S9yQ+d+yYNYDjnMIVD0Acc5LU5k+3C+MmqrmzZ4/hujjT48p5wJ245cthLFgkCxW6CmJRJZvxfoW0OcLLnTBCcmU2sG6F0bZIHh+GR2x++K82x9j/6aWp9EKBvMA3LuwD1VQ8+mp6d4u5P1eBTadk6po6m7ozMzDH/PKqqeNxLy1WEXXMBxWEz1negoN8MAx+2WGqxnJOYP+DSJeb7FCn8R35Zf2MdeeGCG0+pHhUxT4wz7Bs18ErC9nXDSHHbQVppCzKNqUGY4YngrW8ac5Nr+b0gnwzM02jN9EaKTx2lARRnn/MmT2dfojjvI39U1Gp/UpCsxc8TkbuUPx7F9hJySvCuchArmvkYK/Ri1EBgUPJEAZbAeiTEqYDJHXLnwIw3nei1o/cIxCOnvJlZwbLPk/CP5wB6oHYoXHfQ/3IUawCTaw24al
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(6916009)(70586007)(47076005)(316002)(70206006)(41300700001)(336012)(4326008)(966005)(478600001)(426003)(54906003)(8936002)(8676002)(82740400003)(7636003)(356005)(7416002)(5660300002)(2906002)(31686004)(186003)(26005)(31696002)(86362001)(82310400005)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 16:18:03.2974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9279134-3d4d-426c-047b-08db4b28ce3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 13:27:52 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.27 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.27-rc1.gz
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

Linux version:	6.1.27-rc1-g58b654bf36db
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
