Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BACF6228FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKIKsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiKIKsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:48:12 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9CADFC0;
        Wed,  9 Nov 2022 02:48:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjW20y2hHZLSHr3VlRCROzcvi+xoO5aEC0QzpsEIn4AgaJb4LxvQAeXMvolVGkOuIIf/HroP47kmlSgjdPejPmvVRTTBNLcEdXNnNnN4lR7xk2yVt29f6aJY535hNH0oK+hzUzMG+sa/dYUYuXJltFUYXVsOueH9BoqwzYv54mO3mpwbgiuXiZ+IgJt/ptSDlaqOG2GwjFfUXdkfbrpJRS4B0eoqAG14nIkeh60TQP2/DjCfVwLEEuU7DJ/JlwB0h9lMCWHRJUTaWsf4tl9WTV/8GGEo5d0zL77J6zeWr6tIrdDcBjJVTNIdZeO4WnEQKh2fgy00YVaNORjTCELdCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwPUYs7OabrIpNntg/2U30eKXctal6TD+CElbMdfstU=;
 b=Zxahq0S2jNT2GEw7+HE+w0S3Jh9Up2OqoKFE70kfPjZdSddChgPHhFMrjjymjON7mHbgumiXdTtQfUQi0Sndy5HNr2F0vHvEIMxvvD7Ev6iYEhlmTuGRkQAiAfpzYC4oP6kmmvUlvbKkmy90HjFJjyWoQbpma/fws8NQ75NoQM9ZbGBQ1WQYcup1gWIa1Bdo1UEGqAEOG0SuIQJG9wFNqWYJoeckxfPJW7T2b+HTLtputjmHd8ZYCoRWjHxY0IrzT7bChn36QdpSGuaqR4F9S2AimKfwGvvm0BCB/R4xnD7eUjnBuuk5uxYlWXhvIAAA+xMHsy8WPGZ/5XbKQEkDvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwPUYs7OabrIpNntg/2U30eKXctal6TD+CElbMdfstU=;
 b=T81ySevM30dd49hSyWr5aiUuftM9rW9eB0Ny40qDjZ9HUwrRTjvhXubreZczk6BCQPIL647N1YOL6XgiMNH94XN1EaRTBGnBrZt8FfQnqKLCnqPWiCgHAFbc7n7sHE+LbW/okqgFXLP8cAPtUvvqx/tzYAUuadRzB/Hf1lH0j/rMFm+3wZFANTrb7DmM0Vw9M7NX6uJ2ieGQspqvsV3stva8L+wazxS1ppTp5Do/OyEq5OcpaiNtJDd/8wOI9bbYHf6xCKtTa2pw6wMc4d4/9cKcl8M5VxgQKeIA3tIFslEPm2KHzswO4wzFnke91U8fbOHzSto9Lq53C2gJ9K5yEA==
Received: from BN9PR03CA0977.namprd03.prod.outlook.com (2603:10b6:408:109::22)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 10:48:09 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::c5) by BN9PR03CA0977.outlook.office365.com
 (2603:10b6:408:109::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 10:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 10:48:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 9 Nov 2022
 02:47:52 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 9 Nov 2022
 02:47:51 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 9 Nov 2022 02:47:51 -0800
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
Subject: Re: [PATCH 5.4 00/74] 5.4.224-rc1 review
In-Reply-To: <20221108133333.659601604@linuxfoundation.org>
References: <20221108133333.659601604@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <00df8fd3-c1e5-4778-879d-e16c31382348@rnnvmail204.nvidia.com>
Date:   Wed, 9 Nov 2022 02:47:51 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|MW3PR12MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: a27a2584-50d7-4ff3-a220-08dac23fe38b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQLS6mgkpY3CBUwoosmTsrL2qAPunfDSUClEwEYISzceVzWfwUcM4ROptmsRlGj7973CYDW0cpNClQvksfBLO2CBb+BAnw/pxHEbEu2aVkCJQZsNl1M5F/yzbvqHJT6OhtrIWuu/L6AthTZIqv38ANy+AeAtOKCMOO1HjC4VFSQOVh8pzC6WigXNi+2NgsivkM4F8D6c653NZorYqlmSkvzuXoL6igc1VhMiOdiwWY5JehfzLTkr4fcBYHmVu1EbQOg7clmkNX0X27Tx6F5xE6nA1/ohHPgkREUK0PENSHQjDWGI7LKVTEPbO2NtfQf6seYVabKd1wMKI8WQQ4BJShCYXlgZLTQ2xg+umqzG92tJF6tAgq6vkBnXsVa5fSLLynYv2ASa0jj3QDNa1xyz94H44HJCtY0HTit2z4BZoWWLWOxTJDMcX+UgEmfISc4r0a2E69MDv5NCtpminYT+MXumaCG53Oo6Dqw2tmR+QKLLij84erb0i/XOXvXCFw2W9lt4a1WwfSAVq7bAJsWGGZB8eUhBbmI67B7Xw0FwVeyF66ilobD2NQckKV4k/iiH+5eGNSU3DEOWtK8g8Ms+UNGB62XF1YNbYu1BsSaEJgFHq6IlOXpgaVLZZ2GhwFv8nprRMBV0y/UA3nnvcYYJ52jCfvXEXyVJ9gqgwhRpedsu480I44zja4ngYgPQkBk1AMTblfZu6NvFkeh9Uk0y3Xwn6RVtM5Wv6xOq3n8fuSI0j5jFnAP/13tC2prKU8jx+9vR+JRmp0Qg74aUs1RIy6mRTd4S9pGoZUFCAe4y+o8W/rjw+96lHlbdi30Od0srY5QmfN2Q6aPNX1na6eRomliHy+wk8H0Ofoy934dsZBI=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(7636003)(356005)(82310400005)(86362001)(31696002)(54906003)(6916009)(40480700001)(41300700001)(26005)(70586007)(4326008)(8676002)(70206006)(40460700003)(316002)(31686004)(966005)(336012)(478600001)(47076005)(5660300002)(2906002)(426003)(7416002)(186003)(82740400003)(8936002)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:48:08.0466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a27a2584-50d7-4ff3-a220-08dac23fe38b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Nov 2022 14:38:28 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.224 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Nov 2022 13:33:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.224-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    59 tests:	59 pass, 0 fail

Linux version:	5.4.224-rc1-gdc8d80bb822a
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
