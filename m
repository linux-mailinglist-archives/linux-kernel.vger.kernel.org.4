Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C516A7BDA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCBH1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjCBH1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:27:38 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715D728232;
        Wed,  1 Mar 2023 23:27:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eyy9y4vndNhRUgnO8M4fnv0rRL+EksksnnyxPrIh19BaIDsk8QShvkLxAWMQjctJT1szIlpzKhwLLpaz9AJrkl9RVN4cJ8WSK2P3DfPBoCEr469spDrb6rimvaITlxWH2PqagVZF/9Z35kuIKM0y+alDh/WPEC8Tdp6qoZqWF9FGc84FXTj2nmdwzhlZWzWfeLwuNx9SRUYXfR4AeKON5esC1hT3JxOBlszYfj4ZGWdW8f51H0PzMNws4U3yTpiJIsNhXkTfOda/mzb9KjwIpypqWKkyHNmw2T4MOV7GAqd+vbH7e4BCFdkZMft/7yXoFLVZZawZ73xfV2qftn71oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCYM2wkAihAKVYqrpSMM/oxuftZNS9wMUn44VnsK7Q0=;
 b=WFRaCnLbj9O1lv9vigtxEP26+Txo+AJi2l/Jxnv8YJY2ce0HFaZ396Xwd72117t+VYE/ccGZB2UX07snel1/GaFKPkilAAbdKCBSNmulmMcQGYObuNelJx/IRbe6rCvac/OWF55Cf7s0LPLmuoH5XJGN1Kf/BzinZl3L8NKK6opNHynEM43uFu9zqCjTlmSqOB8rvkySqPvCL3oAAY8xEE3xaLDsyh7d3fPwTr7Hx29BXatfcLkG2ehv0RL1XTsrQeAxdKIRrbzvEyWahqv1OP6LJQEkKNAxaAZGV36ZXtoxhvBJQbhNVbts/rSlso9l+da6m/CzQ5nSLGAiZAXoIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCYM2wkAihAKVYqrpSMM/oxuftZNS9wMUn44VnsK7Q0=;
 b=sKZgkYpQ5jHnaN8PfGDZcG+rOMxyH3LgPrXZ33TeW25eNhl5B/2n3wQBftbZvLlaBjELCytIh+OdjGsc/vB0aA4LBYambLKBlvSe4tnPrsG9ktJARc5dKUaZzrrL6FwzgAWzULUovKKIMglG4AuBMR2+8aOrjPtDFM5bD8+hmQBl239PxhRuhsrk9ohwVVI1QZrbZtFoNfu9aaOqHCQcWAjRivcKYYBqxEWAGbyNPW0KyTSqEy1q5XVuhY7ymsWnWhlu2MwlygoWQYV+gRu1JdVKNzU1WbNrGHAlobNkiqu/+eOWmuuhusM2IhuLmRP1npDZj6dy344ujgWDwthiyg==
Received: from BN8PR04CA0002.namprd04.prod.outlook.com (2603:10b6:408:70::15)
 by MW3PR12MB4540.namprd12.prod.outlook.com (2603:10b6:303:52::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 07:27:35 +0000
Received: from BL02EPF00010207.namprd05.prod.outlook.com
 (2603:10b6:408:70:cafe::86) by BN8PR04CA0002.outlook.office365.com
 (2603:10b6:408:70::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 07:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00010207.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.16 via Frontend Transport; Thu, 2 Mar 2023 07:27:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 1 Mar 2023
 23:27:22 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 1 Mar 2023
 23:27:21 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 1 Mar 2023 23:27:21 -0800
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
Subject: Re: [PATCH 5.15 00/22] 5.15.97-rc1 review
In-Reply-To: <20230301180652.658125575@linuxfoundation.org>
References: <20230301180652.658125575@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <6a711b9a-a4ad-4aea-a759-4c06b18deed6@rnnvmail203.nvidia.com>
Date:   Wed, 1 Mar 2023 23:27:21 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010207:EE_|MW3PR12MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6dfe33-cbfd-4a2e-e60d-08db1aef97dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LhxKMLsXKHl9x4oFQ/z8nwkCfnIhRfB4+R6a82PI3n7U+7y9ZBcUxUhEmGWAozIfCY5mFpGc9cC+7jzvQ9H/mlGXDy16I15Vm94gJefEoaIucaqFeFrcjwGTbwMOpXr2pZ240x8w44jPd+OmScZje3RJhm3q9P3cZV/maYGwgglg+eJcewlwHcltz3PDBg4GjQ0iGxtjcbnbljkZO0rn4rbWNvnYlaqlU8ex2mIdgw+voyEida53ntNapEtvhb2Sj+AbHmIoW1IvR39em72+KiW20JYqdM96pe3v6Dd+XMc8rf76aAVTZLHGyiEoxo45cCaHPBdRKsazBCsKjJYh5VpDmn+McXJrYSz63aWq+ftAmM3eACYx2TfBud31+rq4fBtOOFgSW3SmOlpKL93ktFb4LZhsauWnFEEA2KvAmtxJVd5z1MVOHxch5/RWvNtEsTpdSVW+a2j9oNbuVrs7wsiLfFz0CVdgXI/JBp4w+k5ky+oENVZSnTm9ZcnEkSbllGs1MuS42yv0YDryFs6lkeeIbPKKffGGo6F4R2NgD8kxhHpLYwPWCavuCAmfdujoUM8S14/Q5avyUikREeYvqeeYji2DIIDsvw/EhiX3yS8hwT7ZWHioehpFKp8B0NMQDYWudSN+BP4Hc++E1fB50S7j2vFt39sbpex/FS+FOssDRnarSDVtZG7trsWbj1hgBzzj4UfWVguTCeG797dwc3K8h2DuuZY6UbGEP1S6bAA3dy7CZYO20DVocCujMu6O
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(36860700001)(47076005)(31686004)(426003)(40460700003)(5660300002)(7636003)(82740400003)(7416002)(478600001)(8936002)(86362001)(356005)(40480700001)(31696002)(82310400005)(186003)(26005)(336012)(966005)(8676002)(70206006)(2906002)(6916009)(70586007)(316002)(41300700001)(4326008)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 07:27:34.8433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6dfe33-cbfd-4a2e-e60d-08db1aef97dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4540
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2023 19:08:33 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.97 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Mar 2023 18:06:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.97-rc1.gz
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

Linux version:	5.15.97-rc1-g6e657625508d
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
