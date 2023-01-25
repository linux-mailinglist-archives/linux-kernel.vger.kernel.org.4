Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30B867AFB4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbjAYKbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjAYKbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:31:05 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5DA59D0;
        Wed, 25 Jan 2023 02:31:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOKv3UAGLUdy4A2UmEPx4SC/Tt4vYvHdL1A9LpSrUmx8wdh68BQrB0vJ6ToRJva4osx4OaXMZCbN/2zXsUZj2/uljOMHSw58tpdi/z6pQicduWWLa+tjMxfssYro62mRL3subrze1/7BP5vsgmC0pCyNWTPrQrn5QzoKj6GGWcU5+9lgSCNlp1MMgJH2E9lKtmLUuT1MgahdWsbcuoMrNST0pjron0kKsO2/7quR/SnnD70VFrZlO8twYQ3xQ56nq5Jh0+gb8ZLT4aYFYkMUo7mcdligrfyQ3uNV5HvEyEdrrmaZGYsGnj1n++al2a1BKRujPhj03uQlK2lsaper4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYemyZ5Xs7w5Zk+qP/Gyw8YBnppeTT6E2A8rEV9lFJU=;
 b=eb1pCws2h9RrKTuCNiIXygAWH7bjcqLv4TpSF8wTLYahTymZGhNneu3wnL4oNixxBz7S2UTdiUElXeYTY0dzLvpi4eE10DhWSFpVLxPklmS9NwzDmG6T82jaK0JX6UbZtYeXZ6spx72xf5oc12CbHDS+jRgI5fvY00JJK826m7J68UN/vowXX80gczb8J1VN/w5z0oTfK+aqMYJab2LpAHE5cJrlQvq9LM52BTkn9L4uXwwngaQsEFbLNzZ85vZiRGJmQHcwPnh3iRsylu/TH7PeVQ4idLBQdCYVLKLvVHga3dxZuVpgSDDsCGUMX6JDiHXd9FqqV16bi56qn+o/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYemyZ5Xs7w5Zk+qP/Gyw8YBnppeTT6E2A8rEV9lFJU=;
 b=ZLefBc16kLlHzJx7+PtEt1MaJl9T9S9nXZQqIV3DpG751qmWVRU18WH6XQNHjUI+ylK2Zx8mMbyAKd41MFq8D+bqbeG0L9ttjblr9y/YOxx+EKuf7BWKx2OQsrRJvsxCcUZ5lqyljjMJ8eRYvhhNAWmcteySmzfIJ9yqgYhWgQ+ZMt+g3g6SqiFMtLe74ScDOrhHSfRnAUzarky2S7iLRs5RBxujpCPfjFoCXtyMRreT3hUKSjz51uYNLKZak+alftcWJgW26QW8zdJKs1fNP9OzuXk86+t1aveCOUqm1IUf+urIbom6mpo5ijn9UyVHkuzNmitSrhaqRkXOhZoHOQ==
Received: from MN2PR06CA0026.namprd06.prod.outlook.com (2603:10b6:208:23d::31)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 10:30:58 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:208:23d:cafe::a4) by MN2PR06CA0026.outlook.office365.com
 (2603:10b6:208:23d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Wed, 25 Jan 2023 10:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.10 via Frontend Transport; Wed, 25 Jan 2023 10:30:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 02:30:38 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 02:30:37 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 25 Jan 2023 02:30:37 -0800
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
Subject: Re: [PATCH 4.19 00/37] 4.19.271-rc1 review
In-Reply-To: <20230122150219.557984692@linuxfoundation.org>
References: <20230122150219.557984692@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <1f99fa61-105a-430e-9e4c-7e053bb7ca01@rnnvmail202.nvidia.com>
Date:   Wed, 25 Jan 2023 02:30:37 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|SN7PR12MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: efcb94f8-bde5-4976-bee5-08dafebf3f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BcH/jfLREXoXAHW93K9DIGIBnDZLpmth3lG+hJePBYuf2RJAfsiZs5b3qQg0bfL1nIBdedO8w3+R4PNDEVb1ZaOsF0jXoKyoyPOdPStEO2ybolxN/LwzJ6Z79OJ67RGZzmtsle2KHRXSiugFi07/SDYOPyDh5ZQAfWnhS7Gb04uhJJFXDMRyoipXC/mbvsRI9bkayIEp1cQ5bDRly1ykFITOiPeFD2r6lJwi9Qi16XRJRiQo145e60IZvBbSakNpdPMtgwABnbWoodkirYGWTQAcsXT+m09JulLM8Ig840y2UQDDFD+brylpBmv35IXvUDj21kOxBa+i0gCyXIBJ3E/Lae7jX94qpxFTNyzybPIyfK+JGwBdTNNWhHwwgXCWSDt8MV+lZOY5gM2qw+2Qd3de2M8j8tK0GSvg9B2dveVt1uoEnSEJ45G5b66D4L0DL0uVgEPJvYLs/wbbPmWoFDcYsUtDQy2QCuNgPltzMJBsH+KdbiiJ5O69OM18fd2LRtzmT3Gk3XyB0RO0frGUYoqkBmtZq5Z6hw//TSe24BFNHqWH++9QrWt2Cj6VYln20qRPBmQ+TXCIX6ixz1/5X09RNueZnCA27l+IQ2Q/G9B0sexR4fr5HfxzkKPmPFQLSBwCeRLswAzU324I4vBCIcuICFSn6a4qGv71IdWkQoaOTWP7GcCkeuuwJIUnwV6u1Go55AWrSusAOz8zZ/lg9ymgIM7NDe0TvY4m6oQY9VOHmPPKWnskqTVSzG85d2g4eKafQm8tZ+VpY+kBPs5mcbLf7Aty97k6/mN13sEc3oo=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(40460700003)(54906003)(316002)(31696002)(40480700001)(86362001)(6916009)(478600001)(186003)(82740400003)(36860700001)(356005)(7636003)(82310400005)(336012)(47076005)(426003)(31686004)(26005)(70586007)(4326008)(7416002)(70206006)(8676002)(2906002)(5660300002)(8936002)(966005)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 10:30:58.1925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efcb94f8-bde5-4976-bee5-08dafebf3f80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2023 16:03:57 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.271 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 24 Jan 2023 15:02:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.271-rc1.gz
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

Linux version:	4.19.271-rc1-gde8db55b044b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
