Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E560D613427
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJaLFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJaLFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:05:33 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E1762CF;
        Mon, 31 Oct 2022 04:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmmS8xHzA2ipVshtO73/h2o5RPrkrzFUz50fRJYSrhunOOLqoOcJKXMTuVmQl32VE6ec0NZOxF7Uc1MxNHufNDDP2bia+7pF1gyn95l62mybyQf42XlfdDSHARERYBa//q+3YGKjSWoUN6NF2dnvUnlatd5ObXtTUqdblqj7Rb66HIvStT5kPzEcU5wfRMIFs3wPPC7AleQMUUJhsuyyr85ZUirVpBAzeMiENN9eg5WmrjwHKZ/cBPSQy5cWPGWbq2Bd13moiyby4r3xx7l68NWTkB6i7E952QbOxjiev9xCvOIx1g18vEA9aplwIWglrQdcLK+b8nAUm+WJKgPw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro8BsbNfQVKLwD3jvInbu2ehLbRtODRKvo4jjYeqOuo=;
 b=jh3x/2hjbvR2HfGYhBp+pJNrNb+SkGrlOSZj3QIq3UzwnrahEcKCxdkAp3p/ZoqWvx6AaGRLi26a6hRg7XoOlHfoUIgws7cA286hP0Ap9DS2/z00oBJAWS1I6DFVgeUcbOxr6NTCFZvU/Va3gtfA/zGZRnMfEH8EMcE/O1MK86M3yMwzH11UINEf9peLMCufxxvjyR7d8wznRpZqXGiOSCoHR4O3/SfStHH2kEIeS3CI8VvL9ZHULNhoNxpvptJ9oya0v0iVbrub5BTZ2VzWfRxQl7xdiWi0iFmCxCK4va5mWUS1QmMvLzW0PJZkvp+hu5z6xpO3sFe8oUDf79/A/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro8BsbNfQVKLwD3jvInbu2ehLbRtODRKvo4jjYeqOuo=;
 b=eRXWa6uIdYhMOk5xhTAb+dmvVLM5vXBXUfegy4N4IoekFO/e/+/304kRurhPGvPDBeppaYkGe3vo+ymldZuCpV2hgreWAI9f3Fz6e3lpM++nlLEqyvHEioflVWaAUYjif4OiWjAqFOSDG40u90SJXlW/41gl9NTWpLx6E0fWJpIJU3RLR0AnG1AvYB4909iKudnVfbZKKyCayI4ftqQWBgERIvg2c7YeZSlZkncyg+I8gsVSSiDDLnMPwCkNnOw/Ohn4wrsRbY3fQpiYuzr+n+XuL/IG4kmEXH4ECQTNBKSEHAr9lYDbVFKiSqEPf2CV7b99or303VB8pRdACHF/UA==
Received: from BN0PR04CA0047.namprd04.prod.outlook.com (2603:10b6:408:e8::22)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 31 Oct
 2022 11:05:29 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::b0) by BN0PR04CA0047.outlook.office365.com
 (2603:10b6:408:e8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 11:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 11:05:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 31 Oct
 2022 04:05:20 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 31 Oct
 2022 04:05:19 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Mon, 31 Oct 2022 04:05:19 -0700
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
Subject: Re: [PATCH 4.14 00/34] 4.14.297-rc1 review
In-Reply-To: <20221031070140.108124105@linuxfoundation.org>
References: <20221031070140.108124105@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b410c84e-61dc-4d04-8a90-b522097517f4@rnnvmail204.nvidia.com>
Date:   Mon, 31 Oct 2022 04:05:19 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT062:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 42eacc0e-f5ae-4128-cb29-08dabb2fd26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IH9Ak9fBy/wk2DfLj2PMvRcteLDEI3rmCSSfZUAUoyMe33l7pCnDVmegrHhzpvJiHc3ZKi6LFfxqk3QkwBtCuPXz1rLDHgs2syN8ciRchbFiII/J/t/FKiLdeKN3/0uxIzRGCPyiIVLuaZ8QRG6od0Taz1j0vkCGtkVG+LtSuoMHZK5ZncGzHfPx4sg6GECk2Y+f14W5taT7Q1VdgLlLT7biEaweGmR9f4KXO93TeFRS/8zWoyyXFiGq/x0RAqlql+K21utykTE6nGoEacsqBKGY4Q9o4hBvVaQFqBce1XFshtuyJF46TVVhPX2xmaRb4zXVnA5cZTCkJf9arXKYuFzlQPWvcGUr5zvd73bATnaMS89wNpY8fMPwE1hVQiBI5XMlMUBqqmaWlaLN1+HJbEUc3QiUK+uD9glCiZy1nrzD50vTi0G3kCsC4qaUwB57sFiQb+hsaffhfbNG3NOb0p17clLOkePZ67JOfT9BsIUvg2NAi2FUROR5cnqmGpLx+zABR7sFGEM2WU3VCdz1fqHTW736FjVG5sKFP0FXbSG6XzCAtLXBOdiyEQYpLSt/47n/r4qbGH+1I6ZRMwRtOBmZYqWn8TZtxJzOwj/QNOdx+EQwPQWKt/jFVJ8vpcNDxzLLJRzI0BK8HDXxkR+Nw/ccqSe2DEpFfDntczTfLfbxVB1kpmMT2VKchqqVZ3ikBmupszh59wTSl6687JKeHXc7sH84DPy2nRFmubzsOTtay/O6OK72tnnPrVdWbqEB8mzWO/Whxr9NDREHsUetkVWl9oD3Nx+GG5PzprfVG4BlqR0mFvnmahBUADuGwzwe5rurTYbiNDs8z3c/d5Yl5PBgq2bhC72bTNhKkzwocCQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(7416002)(41300700001)(26005)(6916009)(8676002)(40480700001)(5660300002)(54906003)(8936002)(4326008)(336012)(40460700003)(356005)(82740400003)(316002)(186003)(7636003)(36860700001)(426003)(47076005)(70586007)(82310400005)(2906002)(70206006)(31686004)(31696002)(86362001)(966005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 11:05:29.2452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42eacc0e-f5ae-4128-cb29-08dabb2fd26b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022 08:02:33 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.297 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Nov 2022 07:01:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.297-rc1.gz
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

Linux version:	4.14.297-rc1-g822f96245cec
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
