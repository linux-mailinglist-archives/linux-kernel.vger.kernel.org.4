Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BA3729FE9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241819AbjFIQR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241062AbjFIQRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:17:54 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD1B2D44;
        Fri,  9 Jun 2023 09:17:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNryYFDD+HB5tJekNSFyA622WZYX+dLQvk41HqXMeAy8SSuyd+4lPkGxMdgyylQ1wul9f529QdN8MblImNE+EXhIIfW5s8aCWHxVstmd+M7fA/L9V5k/RBbtuBhEtN63wh5QDUo0COyQsWtyuMeBsmqPw1SD767QxxWpbesWpd47n73R19K+win+k7ceyB0rQ7fQoxVziwjLEymZ2QpRz43CIIM6/jB29pLgct8X3nAYF809ACvCw/XHcChY2LYES/hIlKWdLKhxfWPsD8XArQLqPurRi8SLqqL6028qZAuNsfY/vC+sFhmtqBKX+VNc3q232VrlyNvO2zlwKUHQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jU3cvXzOOF8xG9CSk8qU64gNmCDgxyV1H6iX2QGP9XE=;
 b=He99pTP27axVUl1F0hXhs4J1QCsPMFQDUqhili8WuQyuoaVyEXLNvuD3bDarH5tzNPT8mSPg/1xatlE/48KFWfItSYFXbxhU/xcAw/GWhqPRi4CcpcV380vStNRnzbU6/rAlmxs3YqohvH0DJWxIDAXimcd3qpmaRdljUQ/iHrZgOU7bT42RRDTfLe0f2ezAlMZ3hEpbosI1nbblrhqFJbCZVgq3JHlE3eaMkD8ue3nku+e676Qgk1P5Mdi+W4yX2xPOol+hoZSkoz/kVIffMo2FyM8dZ3rIyrsYTmu9pZ3bYVNQRI0IVkvGE6VSboVAnc/YFsxyUVr9U+vg5Oul5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jU3cvXzOOF8xG9CSk8qU64gNmCDgxyV1H6iX2QGP9XE=;
 b=hc7okkQaSezIwcWPQJQKjFv1ybFtLIRFiAiEDcmnwWCWY7JetLDuTV20ghAJrJ22x9XjK4tpOOY6trbF7Zq5z7OL0WECqu6hFSr4ldrd/5vMqFhMZ4/zAdO4mmH+JOT+mMcm5AH1C88yo901+MmbG2zdr0hjdhxMbzaZxWu6dPtre3h/0l2UIFUWgRtzuCmjyLAhTiy7dV9ieRhoQU0fFk04oTVy2MhCmOWe1ezPI2bSCt13wr++ombfJE5NzfxyAkSrJ5oSl1ZsihHUNDposK7hjNaSh3MTYrfwlAJPTef3Sd3O58d0H8ddZ1ytBI1og6qTGym+CAiM730wMjUkvg==
Received: from DS7PR03CA0137.namprd03.prod.outlook.com (2603:10b6:5:3b4::22)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Fri, 9 Jun
 2023 16:17:49 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::76) by DS7PR03CA0137.outlook.office365.com
 (2603:10b6:5:3b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 16:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Fri, 9 Jun 2023 16:17:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 9 Jun 2023
 09:17:31 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 9 Jun 2023
 09:17:30 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 9 Jun 2023 09:17:30 -0700
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
Subject: Re: [PATCH 4.14 00/61] 4.14.317-rc1 review
In-Reply-To: <20230607200835.310274198@linuxfoundation.org>
References: <20230607200835.310274198@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <678af2a3-f94e-4da9-a8d1-e5e1c1e92173@rnnvmail202.nvidia.com>
Date:   Fri, 9 Jun 2023 09:17:30 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MN0PR12MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f27856-293a-4019-6575-08db690511a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pX0nYNqxXifAZRKTYpomkMXx7cXTt+IhLcZpPYTREl3YQSYNnhlvkSz2NjScvd+iAFztNWlQUlYXkN/ldEHae9i4Xd5YuQFHqaJYfMDhQyylcyaP9g33Gf2X/4oK7sGvw6PjdE8LX+euQ/8uwi1VXe8qSSgfpfDXraDC2of1r6s/8hcns2wAYdgGYlrkUnoWsm4LLFL8gEz5EojK+1RXXPkaXA6m26LOA1qpEINgsjkBxRByisE2oX0d4HqWbAddyjGfiGlI3GfTPS2V2p9gh2BWKd0Qy+Pzhjse6z5wX/ILLHGhRK/PZOt7Dge3vJBTsU/FnKMQilY3rkvP/lkZ5BLRfFHQilAk2mC5Zqst/eCz+SsVqzUoACtS0iNT0UPZyYd79hjDDuHF+aSUChXjvp4JktoNNmaL8nW+ziBvzzSS2Nm8M4dHxfISigJtF2Xvtmh2H4SXKw4b4c0mrioUXrD09hHODxJfRkv5gLvjNEXZsnX07XUqrcneAw3XLZ+fIdkxQExUbFivkaohRyuvI4egE82kECSJcRiDNDTPWK5d1EDp/t9bqIrObNsriZjiDsFznIR1AZEBbzfM3tBJ8wTfz/MJLrnHEhf2O740d+ZAgaWpzYsgjbvcLdLPgyNwlt5iR+NyYDfQkilcbBFiftc+/TKrXtI9zbfKAZk9hu2GRlIRD8CRQKFhfr5nfIGmPicYx5LS7TOi3Ls3F57PmgsUcpM0KrUlcQafdunMJM6HKXndlrv+jC4fjyZhAEgDjDxUbFjWKJumDZMgUOS1qQE49yWUUXFa/ehFSw/a7l0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(186003)(86362001)(26005)(47076005)(82740400003)(7416002)(7636003)(40480700001)(356005)(31696002)(966005)(82310400005)(31686004)(36860700001)(426003)(336012)(40460700003)(8676002)(8936002)(5660300002)(478600001)(54906003)(2906002)(316002)(6916009)(41300700001)(4326008)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 16:17:49.3440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f27856-293a-4019-6575-08db690511a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223
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

On Wed, 07 Jun 2023 22:15:14 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.317 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.317-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.317-rc1-gc6b4cc5cb549
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
