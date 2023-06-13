Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8FC72DCC0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbjFMIjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241393AbjFMIjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:39:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597FCD2;
        Tue, 13 Jun 2023 01:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kouuyKrpvk+aHnYwwDovIm7/VJ/yoBuZtqk/3BK48YJ3nrf6TyHPOag7f6Dt6kCfKTx7K+H4YiXHH58Fmvjj1eZEPnAigxkYpir0R61yIfyqHrs1L0YnFZtJAFCogTNlrV2DoNVaj2p1ZH+/4CgjB48o81oA1YD9FE80uisM/1IckvoaEdsdJUe66Ur8MAA3jJ3USXJZBeyir3kTNTr0sEPBjTpcm/5TP3MI6Yi7IO1QpS0CulEm7Ljts2FyJTIDDZ2227zubthaNp40r4jB5f+b//VRZdUgf1qbu3FAAEOGHlgUdIcjmnmlOZJK/db2tuwSjTZrwmSzFpW2DTkqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87bTFPi7t8TZtwX9fkBzdsiWcl3X6FRpt3QAHyzABKA=;
 b=Z85OR7HSrndcAHh9CSvo+sBMvK23G9VJ+Ih5T+oSo8stI0fBL+1buQeB9UfWbuOVFy8d2EpHxgBHTRmeKhCN3x3JO9z7MAFuEgpxGqfdPBDA3AxBZm7E7WL0uPMBune2uZQRwTwLku7mJaZi67eVtIhUTFbUfolnXE7DnclJcz5kNSIQTSoyj4+03aJsyKqFEzs9wGafSNfn8h2Wc5bxwM7RftQrhl7lKhFtjWgqbdmd4JDPwkrplqUEF+bsi6mdyDB4sYkoCGP83ASv4Mf8mJ2ELc4rOD3BfN43TO645MSA9bNYzePWZwT4X6GYduL9z+GAiLm5lM5ncZOfmCp9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87bTFPi7t8TZtwX9fkBzdsiWcl3X6FRpt3QAHyzABKA=;
 b=LHRKlae8sh66+vxXvFaB9DHyyrBy/CgwQdxuUl6l62EEk7B3z5AAu2dOJgEGvHTezwrwlZlhzj8AYieNxfRBjsfaVcMwCz4BpkBuBCN4swIWbFVoc7qaN+aYWCoVhpD8Goui7JtK3RQBjQ+NCW0zCzZ5Ydoqlc5KvMpUrbpdAOhSDoSyiYd3wjMTuK4Nzt5pe9WGMsm7566frc2xKmZVFlXHKcdJo46U4mAzkEHzZQcrrCjGSwOOlp+vUt1k1yu36ps8I1gxGl7hxHC1HhZwbOKV8GrN+XzLuGPgcu9m99SgUqetbjoi6hvTE43+RlvCgJxAWBY4Zda0aJNCDSWQvQ==
Received: from CY5PR19CA0012.namprd19.prod.outlook.com (2603:10b6:930:15::16)
 by CO6PR12MB5425.namprd12.prod.outlook.com (2603:10b6:303:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 08:39:01 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::41) by CY5PR19CA0012.outlook.office365.com
 (2603:10b6:930:15::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 08:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 08:39:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 13 Jun 2023
 01:38:47 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 13 Jun
 2023 01:38:47 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 13 Jun 2023 01:38:46 -0700
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
Subject: Re: [PATCH 5.15 00/91] 5.15.117-rc1 review
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <f26a2986-6fa1-47e2-8946-ad05e0e28d47@rnnvmail205.nvidia.com>
Date:   Tue, 13 Jun 2023 01:38:46 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|CO6PR12MB5425:EE_
X-MS-Office365-Filtering-Correlation-Id: e6457b34-4acd-496b-4020-08db6be9a37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ku/THDsgK40iZKgRRIth37Xt4avi+fAxQdqePb9H+H5RGlafV63rRumrlyraqTsBmrf6LVLUx7Y1IBPjeIIPhgcz60JmuMeYMC/Xw4HCnWPsZI3T2MuTZsrxXmUgOKUL+mVV+S77zDhwYUDqnxDP8uKBO/OPne7L+CYnqIpLmJIyTVALDmG08Ln4uIUEUXxTqQA1Dn+sZgQapHIJTXoe0SNFtl8NKTKInSlJONLWx6RHTRMIYUGuj3bArGC1UdGa9CfKhQ5gr4DFnk06ZPpXXpomBGYAnJlsKt2raBDn70wRCa5r3wk0q9Mo7Nhm60gSFBudoKu6x06w70wMYcmR0QmNVnQS4mHSQnjGsqgkFqGwFjRzCRtELUaUr1fD7iTulKGGYygHluy3UxwghFkIPFG7gB52ce3tskQWj8QSJ1QJ4k+Zk23MUXGQcMZyUOLS7BBvEiLZA1YwR7Aey1a6iMoTeGZUIaTz51inv3RLu0zCFP+QHSfo6NpbaY1S9i0VLhNB9emPb/jKRHm5S3+1jYg+xf0bHn4N4I6mgVEr78sPTVyWW/aGmYT9M/lzZ80GCmEh5D3NFc08n/Ek5nJqbTofhsBDe3xjjPMLxJi0TeILtcgAHlR5YXan14XP1Fm0WE1W/MogSZm5D7TdPwwy5HJ/gUdKJGre+J9uy+/N4457gtI+vdm4zS2/o3OExEb36GMD7P6aDtZ634yFUcz5RPttk7VkS+ByR54sFT1NZPTcYYzuRhNrGShAznQMA3T/m365aWsfVwm8rq0QlPgEKwZjX3Oyc4etFXD6wzocxLE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(31686004)(82310400005)(40480700001)(47076005)(36860700001)(336012)(426003)(7636003)(82740400003)(4326008)(41300700001)(316002)(356005)(26005)(966005)(6916009)(70206006)(70586007)(2906002)(478600001)(40460700003)(86362001)(7416002)(8936002)(8676002)(31696002)(54906003)(5660300002)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 08:39:01.6410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6457b34-4acd-496b-4020-08db6be9a37d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5425
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

On Mon, 12 Jun 2023 12:25:49 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.117 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.117-rc1.gz
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

Linux version:	5.15.117-rc1-g09ab3478acfd
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
