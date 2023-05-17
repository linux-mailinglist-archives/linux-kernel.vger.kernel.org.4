Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EF87061CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjEQHz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjEQHzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:55:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A42810E6;
        Wed, 17 May 2023 00:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6jFxpkk5Sur9QkOdZiIyia5NKgbu6lZ0UbRMtLD2kwCfTUfbuLzr0WPJWPODswit8u2yN/PzTC0mC1gYdhzbXKoBUIzsjAsk9tcri/9K+tiA3W4LKrHbhJOh8EXPeL2VYZrwd3zIwC901GqDNr+PsAos8HldG49RWYTmGGstQV9SdApBBc7isnaOAJRErInC41G6+P3XA/GZnZQQTExLV6/A0tVbk3oiwRHk4BEd9svdZ35L3xrxry8LWpdoosQMLOv94h6FTOHovDr9bQI7TfF1HG+KF/xGSf1Rdu1nwvcYJP2FyV1IRkHiUP1BCvOQc5mq7f13zizJdSCzVnxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9OSIxbH48Qwmtk4X9QY+WMi5e3SZVl0I3P7bQv1vUk=;
 b=aUt8Gp2YSOH2bxWkLkCXVJxDxRVV9MVbUsylwXnvDAHqJyN3AEaj5eJYCAqVpLCY58NVQXTmzl2FBJ+Vwk4Cdux1efloyoahKhX0TJX5MeENofLDbmgkM+OakhujQt2ENBBecJnh8ghJlpsaLY1hpB0mezUU2/iebt1hlJfLkDa74CoWLbiBMqVpjqjYkcnwGobm5jbKYURNlX1AExD/KBculKvoTCE5Qx2bdXcp0bXQGwvwwrtrk+nn9F6eRdbYVk/LgKdV3QiSy0UlbK5A35mGIPZA1DO6FiNZJEZCYxYtIElcDBo2lZBH7FKw89xUA1Z20VXlFDtWwnK7ibMbvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9OSIxbH48Qwmtk4X9QY+WMi5e3SZVl0I3P7bQv1vUk=;
 b=LjNNpBTsqBrBgTuvSlKVKn6/fR7DmOXHRC7nHPkOXCMYKfmwzS1hoK0c/xAGirimigrw8qvfUmFC8V5wPsnbu0p23QRSkXeMJ0rfCq6Jwa4OEKVFWEqu5vI1xLOJ75suktLTIny/othJyy0FGcg+BbhHAg8Ghg/jmCBFag65w7S5Luv8eJ7mOtYNF6UnlzT7diYjiqEokhUReJgr1q4nZOO3sUXZX90irKv0tzGl0Llp20sy82kLn5qN2pmzCixWiE3Q3Y2uUgvjuFEg+kzH28vwz2vosqkTbC2B6EPugwVjFzbBD7GUATTak34b8JaZVFU/1q4Vz6Zd/A8ggamzTA==
Received: from BN9PR03CA0539.namprd03.prod.outlook.com (2603:10b6:408:131::34)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 07:55:21 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::fb) by BN9PR03CA0539.outlook.office365.com
 (2603:10b6:408:131::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 07:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 07:55:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 00:55:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 17 May 2023 00:55:07 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 17 May 2023 00:55:07 -0700
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
Subject: Re: [PATCH 4.14 000/116] 4.14.315-rc1 review
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <463a1e93-fda4-4cd8-941f-6cd9f34af6b1@drhqmail202.nvidia.com>
Date:   Wed, 17 May 2023 00:55:07 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8671cf-3c13-4927-0803-08db56ac109b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDoi1t8MF2grvlulWDwss3L+E35sZJyyiHUElGJGfEH7e6TjFGMwcb/ymwNvkYmcvr48EEDE68mqDj04jCHBMUlOmyMEnKNWmXqkIrAn9E5CtBgsShTS/YTGRB6KU4BLTcPLnyqc0tE/wUtH8NsM+MgRdRzzPZMUHWj+b0vBuWvN3gXhTfoYXsICtoVjVQN9+3vZJxSQC/P9FKIsnrsQvZFR/93ypmEEfqfzsakruy8WWroIWdKR9TVpAqPJ7TjU970A5hoaYZJChAWSr5q+d1RnXC5R9mHJ82pEt7he6x9EXWKxJWZmhuTvfYnA3RGaInjsIabddjixHVpZZE2qg801k7leR06x86F6k/rYy3T2jFUDYmt2G0kHpp4H+iHmdpdoOvquGIzmkcFC18HbZUfApZ0O74RrYteOEvFFoWhfNp8uV2NiQMD/EiXI+Le5TXv4/qkSIiatD2HKf3BDaroTIIrkBDaN1aTAIenxZCNKQO8dRpOylfXlHTvdqJCbxRZan5w3MOwHnLCOZF/lntvWBBI9XxAaKtfvUSH5vrhX0y2rAcWSQAwMFos7EwyvQpnoCBKGfpkeLvBBj7HY2xKAt5WaIoGodaTqtiuT5ny6dyWZUPHUq6jMDbUgsheppz/3gIImOMctCDVduOp6Kxr913ktKOMhS9OLyZIH4In+YqngSNAZ1VkKH268U5H+MBEYq8+23Y65a1tWV598xxmxPD1NOC6L8knd6gACPpw92Lqb2+yx95hA/u38Gh7vl+kXNUX+hJkLnL4/pnrFMjLydarByJDSZhoMHE8Z5go=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(31686004)(54906003)(2906002)(5660300002)(47076005)(7416002)(8676002)(8936002)(40460700003)(41300700001)(70586007)(70206006)(316002)(478600001)(82310400005)(4326008)(6916009)(40480700001)(966005)(336012)(426003)(26005)(356005)(7636003)(31696002)(86362001)(36860700001)(186003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:55:21.3985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8671cf-3c13-4927-0803-08db56ac109b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 18:24:57 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.315 release.
> There are 116 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.315-rc1.gz
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

Linux version:	4.14.315-rc1-g854d9237fbd3
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
