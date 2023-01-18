Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAECA671B91
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjARMK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjARMHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:07:46 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC39F3EC5E;
        Wed, 18 Jan 2023 03:27:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUTid3rZPw+sH3Q++v1kRmlFaEatK7uypAuDDIIryrqiyfDFZgGop/eMeiia/Qbcddc1fHaTm9cURP40MQMzYbGeRVHHFc9KuU2hMu1b46tfH7DxhGQR8Liy1ulcoYvaCGGK0nT7v+ZBqDEVnqlE5/CFucrypXvhzi4ejudMgFYfs0duqjC6ooEZwp5zCGX2rHA08PnWNQPMFgR3nEAwciq3pO0U17PYovmj8WRgrlUvou/g2iBZbV7/jdW1a3Ghw3e0CxJeVSsYfSOWISZk5BMsedzziPtrde/xCgMLs/T3YxbneXUQu3AzgELxk4o2R5wPQtXqNHqNWnKpLCJ+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYwAycxeqyDJECqRHph8WcCERo4Zxf07VZQwCoTEN9s=;
 b=Y40DDu9KiyV6B6RsyGlcBdMN6mYBPRLKahgGaHoKDIV1O+sijvx+VZpQNpfbzc3et0g+mYHtTee0Qpt4zytSTUhIKSZ/1N3PmSsSGd/wvuparTWrP+O5Hek25Lb+xU4taBbQvmNY8HOXnFkP+ApE+nA6lEm2fp6FzHghIeKPQK/yqHx83VIo7MUT7KZpv4tRNQiQzwhQn1Tc+TTkFqftXmvZJrS/syOCcVls7ET4QNCotfm2wx1xZBanIhn9l5UqgCXLSBcIdhleIz2hklr0I9a5aD7HnwKCyCd5xZHErl2gcuYln33YuttBJ9Nov4riYRRnvsE1TQWHlFROTWBxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYwAycxeqyDJECqRHph8WcCERo4Zxf07VZQwCoTEN9s=;
 b=AQVGPJ5nzZoJfO1nkR7ZpMqNKrko616Xrxdr+V7UML1xRmPZZtSjhcdLnDcM7/BPVMQK/bHRIXvSdw7yVlDmHSeB0RdV3yhTdl0nqSEJj74L30iunX5UY7/WKHshKu074BAhQ6z8SXNZY4T9hYTW6obx2mhkLE7h4tqtxF3GJNjEQvP2ClnvyjNwMWb3RguajoyTjxAd70yqc8j1SYelpzrGtOS2b6TWTBNnxNca6XhYUYC5Qc55tqu59TzNIyyNwuUZYfIsiiCHigivZcE3LfNLMRCtDAK9ooT49un32EHu5Z5gMeBePjJnKzoPWAlNrcEkcFpKM71FonwLVqvXpA==
Received: from MW4PR03CA0117.namprd03.prod.outlook.com (2603:10b6:303:b7::32)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 11:27:33 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::c0) by MW4PR03CA0117.outlook.office365.com
 (2603:10b6:303:b7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 11:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Wed, 18 Jan 2023 11:27:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 18 Jan
 2023 03:27:23 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 18 Jan
 2023 03:27:23 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 18 Jan 2023 03:27:23 -0800
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
Subject: Re: [PATCH 5.10 00/64] 5.10.164-rc2 review
In-Reply-To: <20230117124526.766388541@linuxfoundation.org>
References: <20230117124526.766388541@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <5be6cec4-2f1f-4e50-a331-45e90dff1da4@rnnvmail204.nvidia.com>
Date:   Wed, 18 Jan 2023 03:27:23 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 5358073b-f40f-460f-952e-08daf946fdec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDG4wBFYxzEAWtEi7ORJaAyqpq7FVOAhLyZRNPnizOEd0vNQp9CmWCorU9i3FzXHhvnqcY+1bNXaP/udKN3ViBB+eHQJdFdd1DlzToX+jCt5DA5/tEPhl07DJT3wvhmbvAd/6xjNMKbpUdGicVC98uV3UfapfIZTKoZ3DCmzs2N1HaXebXIWSLMSogzoQdcGeW5lOxZ3JVaaqok7+2Fop64gPpFqbr1+oPzRMOxm2tLdIvtRmVrr2EszP5IUtdUcY/9LNeoxqI7ZoGlXjbsk/4bmoIaveOq2Jh792FUoHhm/lpe2CcMI4s3NvPvEQ2sGrN0SdxooZpmOTSkYa/bmMNWJWCJdSEGQ6vH5ea1iOfwS8VidbpwdUOzMdY0QC1TRNsUCYFh7YVQaspsEZQFPcZvppwjk9s777vhUkl70oEWhGv+V0wOVfH52h6E6pjDoYZOqc+bVU64pPjvWGlTf60wEzB9mwasItZ4lZhX4mJk7b/MMHd+MFnQbxOLGvcTmN/10ctZAzY4QOcUYbkBe2LQkr0ZQm1zKXZ0dOWYV0j5KZ1MJhOAwWJJV6/fe34H9QoW2XSvtWPXOBdIYp/kgDla2KsG3Ge4hHzHhoF1Tez7c7WwuLy1PM+rXXbwzngAkZoDuDyikKrpo75zJM/HA33cet+pEl1+XsSEN0DKgdVOOeM5In9D4vM11coLekZX30p5Gop8YEQuVMlRiOfYaP6t47P0JxknPSkF82GL9+xQhD4D1Uzi6bbVLqZbh7qrhzcwi8y12rdw7UQwyjgGhUAIiPqZd4mOb21zgJ33/0x0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(7636003)(36860700001)(31696002)(356005)(86362001)(5660300002)(8936002)(7416002)(2906002)(82740400003)(70206006)(70586007)(40480700001)(4326008)(8676002)(6916009)(41300700001)(82310400005)(40460700003)(336012)(186003)(26005)(47076005)(426003)(316002)(54906003)(478600001)(966005)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 11:27:32.8420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5358073b-f40f-460f-952e-08daf946fdec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 13:48:01 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.164 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Jan 2023 12:45:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.164-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    75 tests:	75 pass, 0 fail

Linux version:	5.10.164-rc2-geeaac3cf2eb3
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
