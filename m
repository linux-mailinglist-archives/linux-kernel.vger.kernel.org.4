Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D52628785
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbiKNRwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237763AbiKNRw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:52:26 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981E722B08;
        Mon, 14 Nov 2022 09:52:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2pIfnTIh7VdpkeGtc4mWX7PPBrV/GNGQHcKHPvT38xby8dSCereLMkRUHLOYRfo1kt+u79G8kCF4yO1A55YjpvKQEfK2/wGWG+a8yEgWSKBoFNMZxBx8npnIlJHlz38WukT5DOoUMa4tozvshv19CspmHpwvL2r/p5sfdH2DA0zZ53G9cumXBH+U0dtfApqlw+wO+BjwF+xrmuKShc3XLFxFlb3eeMSNwxMVGCx6OqQTLBLcVfNbBAfHZyUS0xL3pQRB5g6rikamNk2KaXhISinLv0RcfcfYcGda4hLByvOXt/l9agwA8ooK/9DZQl8Y+0yKT3KEQnpxaxiEGSc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQiCRVOzE9XquPSPJomN6sQku0W4fgPUPSh7lXfsf9c=;
 b=iWUVwpDswcKKYPmeFFqAhXHCxq2CE7m2WsXL3sYpWDaNZfWR51E0x7+0Hw3LaLQaS/BX/s7cHAGsGi+cKg3At1xmSBjPYYN5+sQBrw/COS6LPYwVYNgkh+GrrmF6U41BvV2vurcs067hoy12Qa32nAKWpD5qpTzeoMx9ayNt5A83xdsuNPDGta4wOCrTUXeQDIaNtJJhpu1X4LGImvl6luTOXmyA2iESH16uVLK+he+DYc9kgEnsvl28o2t7HknuQ6xoY2yJI6PIM85XJpfeImzkNvdZN/NZBeOyuS/TPUHktDu/jNbcGua75CqWGBAs1UnJ/uQU5f59spwsl/X7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQiCRVOzE9XquPSPJomN6sQku0W4fgPUPSh7lXfsf9c=;
 b=FgES/GGEAQ53hdxToUIWv07T6h/JBWbxDLsFvxbMDMsaalZi1P321C+7Zr9wWXHIVdjBNeekPUU6xXUhcecJs98/pUBa0yONwICy8jmRwNcCVv5uORAJjOeg5rqdUpLHbY5kPq8x43HJqDtsC60rcfSCmLkPN8y7Oj0MlrmuW2bDwScrRG1hjdqMcMxk6j8fu7I+kUPG+rT7WhfRvJxg1pdnG0Lry1cyVEmCwky4fiJ+xNmrFCt3FvkTlMyY4Q7nAVnQKAGTgBTPSqcfqjMH/t+OZsucFCRMzoe+eGgv7iVMFXibvEPyZD/2ZgwLw8ISG4v8VRoQ5LhoT2h4gIa+MQ==
Received: from BN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:408:e6::35)
 by DM6PR12MB5517.namprd12.prod.outlook.com (2603:10b6:5:1be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 17:52:22 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::50) by BN0PR03CA0030.outlook.office365.com
 (2603:10b6:408:e6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 17:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 17:52:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 09:52:05 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 09:52:05 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 09:52:05 -0800
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
Subject: Re: [PATCH 5.10 00/95] 5.10.155-rc1 review
In-Reply-To: <20221114124442.530286937@linuxfoundation.org>
References: <20221114124442.530286937@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <add373f0-ac33-40bf-b488-f46eefa2901b@rnnvmail203.nvidia.com>
Date:   Mon, 14 Nov 2022 09:52:05 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|DM6PR12MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d0c840-36b9-415d-8fcf-08dac668fafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d55QklEVtv2cKGatRhjotWx6JFa3WhCUsgr24go6t6IpHr9pzXULJ0MwpcdS2SJZar+p0n6C8BnOGCKj0ZE5QNwf83roRe2iDew17PAkRAD6KtqEAIul+aBZ5Wc53lYa3v35YQgpqAW074h8YwNQ5Hmm1axyFjXuynBy5b8ko7yvcIlT+dJL+g7MRKe8ennvmQLo3fgvFTp7Co+4E3OvO+Fmr3XK73JJtNZWznDwnK7v7SNHDQjHk0a9O+9Tu3LR7NXDhjh+8x8YrjufXsmH+oh+yF12K8B349PrmNz0wCQcJJA9T0Me+7Q8V+88K0T/O9I4bXJ/6OWFz8xSt5rGKmsRpReVO4Fq7766sz7l0undp9pjvbq6l4A0xus7q9M1q8kHxhnYnBP5pZR4GPZ+s3+cUQNm1pCDn9Nyocf4MJKAf9sKuG2X/DyUWxxcPzFvK7jOcbDghPPYu4kyHSsKqbdjbYqVTY0i7k5Ua3jWT80LKvcF6HjIkCnxnWnI31y2hyn6fzic7MrSYJA9Po08JrPLUqPoDmmxGcBufgjKERUjBLWuBWp+p417EpR28WSDbAmS1u6gtp5YYfdF8vdep2nKTCB73kSDJqDjlgxXlWprI2MJkiOLV9oMPlypKps7qR8/p7Uk0XbW1TiE7MSRFy368wbwTw1Uzht+Trxm6sOTAW1fA8hp/8990OsN1bgPcdeBXepJeIRvWZ+BTHucN7kr2BqJ5Kt+n4BzHQdpSx1K99MYolvf4akb+o8NdTRPzGeuIEO38pkfbKStGgvvxLRVsb+Cp4C8idi5pqt5/n0kQuUWc5e8R2DnbKcSyLPfE223ObYwKEybQ0wH+Gytn8CPMywCWgOWUFsfiakAGjk=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(31686004)(40480700001)(478600001)(7636003)(966005)(356005)(8676002)(36860700001)(31696002)(8936002)(82310400005)(86362001)(7416002)(40460700003)(336012)(2906002)(426003)(186003)(47076005)(70586007)(4326008)(41300700001)(82740400003)(26005)(5660300002)(316002)(54906003)(6916009)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 17:52:21.4044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d0c840-36b9-415d-8fcf-08dac668fafe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 13:44:54 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.155 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Nov 2022 12:44:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.155-rc1.gz
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

Linux version:	5.10.155-rc1-gd59f46a55fcd
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
