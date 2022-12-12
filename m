Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB55864A87D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiLLUMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiLLUL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:11:56 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A565E178A7;
        Mon, 12 Dec 2022 12:11:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4B8cr0QuWPfqzIqWYwPYcqLDerTjJ7XTsrBznPoYa3jEc2tv06sygJRWtSg+jhiIX2QHaGr5sK199AUwffqKtRcxZ5nWP/Vb3u06UC2RdK3zsQ9EFZsLy/GJrCBLzD8GJmw1D77wqmGS2iIQnL1fVJXm5/1u7NXyz5aOgQ1mqvdlEITU/1heXfWO0D3alxMS6agK2RqFMEodCNcCAMfToUgEayHCuQelHrfygMuFAvvB8+aDYIItpqZa/dg5YWKTk61BuvXqreyAovaFMyqleT+c5gGfvVJZWhhjIJ3thLGrKHGkD5D8CguZ7DsBEW4i5yTmNqbB159/wx2phoTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVzLa83ISAWOSlHhQhbPgRybwSvGnDNGi63UC2KUBXw=;
 b=aI0S+y/WP621MY4Z+5ulOP9LRuFKr+r8NhRnCnfIgOuQb9ckw7a1/u0714/WepzoIxhIaleFW4HgwkO+9iHQBxTIlWmQUQuHvKbUhdHKPLCA0Xc6tK3PY7kIBN/We44RZdlgKTdbDMnV4yC9v2N8GDdpuYvk3r5SUOkaaVqaNMAFgc7dxmYdv0jsc5hh2uplm+8jtjj/++Cq+Pv5iq2cIWTNTMAHwjAZJWQua7HA2N/lcptjOU3OIbYh0Xoekt4KSTAgbbPAansdAdEEP0sUl3ZJWFPww3lYrBJhk5EvJ9ioz9hBTjK/kIvZF4/ljqv02rTwnWLVZMpA8Qivr+uEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVzLa83ISAWOSlHhQhbPgRybwSvGnDNGi63UC2KUBXw=;
 b=Hw3HoR55uHvZhmz/33P41d0Wn7DeWIpbX47fgKxJ0PW1Ya9vlaWVwbTlxl9RskIaaBI7vvhHF3jCEOzsCFvraBaFxPEtY8bEg/59upGAs8yRlTsZhEXkzhwF80PTNAtpW3I8SYFT44LSywaapozvDJEW3RCy9GgKnhhRhc954oCYGYDjDWzEDi5nFPZOKeW2FmBSfetxd8ozXzdMyQK5cSGVNksgjNMPsHzT/9pMoP5O0z9i2rA+mf9Oedsfa2P9YzcFk9FZeBzMXR2R3IEeYLzL37sSxrE1z6vrxXAeyIUPUCjHFDWkrYR6oUpcmiyQp5i48pvLnsXgEfu2IrJ+/Q==
Received: from BN0PR04CA0150.namprd04.prod.outlook.com (2603:10b6:408:ed::35)
 by BL0PR12MB4994.namprd12.prod.outlook.com (2603:10b6:208:1ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 20:11:50 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::46) by BN0PR04CA0150.outlook.office365.com
 (2603:10b6:408:ed::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 20:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.21 via Frontend Transport; Mon, 12 Dec 2022 20:11:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 12 Dec
 2022 12:11:40 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 12 Dec
 2022 12:11:40 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 12 Dec 2022 12:11:40 -0800
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
Subject: Re: [PATCH 4.19 00/49] 4.19.269-rc1 review
In-Reply-To: <20221212130913.666185567@linuxfoundation.org>
References: <20221212130913.666185567@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <565fa4eb-f8e5-4688-b0cb-5c9d97b3bc68@rnnvmail204.nvidia.com>
Date:   Mon, 12 Dec 2022 12:11:40 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT053:EE_|BL0PR12MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: 7187a7bb-39a0-4380-8f24-08dadc7d1afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iO9AxWVdHltYVILtwOeMc6fuVuzRcwvvs04fDTPEw2LWbLhUE0WqsJwtBROyd4VKQ6LxmOXOTEP/f7OfLM52DaY0Q5j0t2QurffG/Vd58reTyIk1Rw2LMrKOM83pOdibgrDgeRAAAjafvwYO4jEkwFaCK7rJhCxSpriX1teEgPCE9LE9WzEu9+WkJomNcVl02EUJU2uJnwJwlCpPwE8PiUXdPII2BOC3J2Jg+qwM5O2gHJj2V1VVxhsVSMKLeZGcx9MwuEndftJtKPfMxGxqEXIN+UrKWAj60WnB14LDlav//8HWZsag3v1pS7LoXyzXQG62NZB1rpywQedi37HmpcW48SWt6g/WfIvik1SflZ63h5V9F57Uhqjdw5i9ww3wwnD+Kyw68+axXLI2/7tjOfhotWkHZctIphK0acr+1jcHo60O8UrHjA3rXXUHI+L1W6Wz0He889LzQJirh9v66XGbUhDjGCbKDOOtcO2xwdKmh6B/QMVBLYxZUTQrtIpPDLNDkoOp1ySRPjU+/5itTF1rD6LAY/f9HmykQqBLdJT5jTeFzamemEH2dF5V1A8WYgd0UeExdCAc395MV/E5qlNa7JcIA60x3YhONDyH8q7j5z4RTvo6olYGu5PCum0D1z+XB8Heg+3SwP+h+hMx+tj+6Bi7NtkHwVyYbb9ljvUyT2a8Vd9ew1vXcgbRFg1XiPP9O23eu4//fsnuxg+pViYUk3YLN3kKu/HzWVggnxGjo1edHPEBokB0lL8NffhJ1gFmiX2/TtSZA92XQ2OwyxWHKikAsMynHzKrpGEtZFo=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(966005)(478600001)(31686004)(47076005)(2906002)(86362001)(426003)(31696002)(82310400005)(8936002)(7636003)(26005)(186003)(40460700003)(7416002)(356005)(40480700001)(82740400003)(336012)(4326008)(5660300002)(54906003)(41300700001)(36860700001)(8676002)(70206006)(6916009)(70586007)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 20:11:50.5915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7187a7bb-39a0-4380-8f24-08dadc7d1afe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4994
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2022 14:18:38 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.269 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Dec 2022 13:08:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.269-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    22 boots:	22 pass, 0 fail
    40 tests:	40 pass, 0 fail

Linux version:	4.19.269-rc1-gbf741d1d7e6d
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
