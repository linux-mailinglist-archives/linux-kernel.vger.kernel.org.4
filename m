Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6026EE094
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjDYKpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjDYKo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:44:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A795C5BB2;
        Tue, 25 Apr 2023 03:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/SMty7QbAvITGp/D1OwmeDcS2Owt73ZBGOO7zOR5DjSrIjPliAomsQqMWhtcTMKUr8fqNWyM8yt3Rsz4A9lV4bvmjhMu75YFFllRukTqOkX3P7ebM4Ajohu9120YKUUEdgLnFGroeD3WqprAT6BM7c8tyTzVz5HhDDQ2kPN9knyEHz9GOf3n26exCm9YO+/MRN80DK6YQZ5NGDwDnHIzcTGgl5K8OXxU6+uqxpzOOKaM9167gZvoM68FYHZcwk8HA971+uPTlx1iIsJHWp7SJrWGm5+7bmUnnwsr3gIY/CXUN9Vy2TI540FME7/+2lZwSEu2ETC/auEOhOYMdm4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSeQiB/YMr5G9MTVH8zvxemAk9gz1TKVB9Gz7z9lzUo=;
 b=gQUwl7kAunKTdPXSgytUKmhUSCRK3u/5nkeqfQEyl0pa4e58msaAVXHXErzZtz7j7bsa9XygF0E7Mc47oAk3Y1oB/E6CT7UfUT9Odi38xBgMLeHS70WstzHvx+Ra38ZjjMGBaTaVnNI3K4WNg6gwMt87lTD4M7v3lYSCVoZ+1zTj+YdcwexPmiwI2aoii3ISyBAi79Cm8BFo2Fjne9hnDDvHdEo3PRJ9rMbluHdQkIgKO5d8qjBEK7+vsr5pezcNQk+ogO5xW1Q4ZYoPUqTQzwVjavbyozMg+k6/AyGquxaMhesEqD1lt8GqCdDuX3G8undVd4RUa3iKn/8ap+6zqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSeQiB/YMr5G9MTVH8zvxemAk9gz1TKVB9Gz7z9lzUo=;
 b=O3AEslc9L5OkLJS+OgEaANEBA26XG5fskEFaidb6qL91GiUIx9iwetGdUBEmKEYIYwrjCQhtxyQBgv30bbCq6m04C9QAbWwhBmj1ryEWYBHyn7WU+nwud3ganUOGIhyIYRCqTJT5DfEyq/ksVVp5v5+rQqPjd/e2qYlPgoWu42PFEPaeDpbtzKxpwvEHbeLpyWa/f9Zo6b7Msa/IE6aICbnZab9OqM1zF7bXINuecesva8hZOVBF4Uhs1INZ/7Ry0hw1uAeASjZlnBu6HzPWNkHdMOkA1ycx0dzaN8R3lkYMSKqFVfZfQy8LkZrIXK+QTDNzh/28yKnKzPONF8DvHQ==
Received: from MW4PR04CA0305.namprd04.prod.outlook.com (2603:10b6:303:82::10)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 10:44:55 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::f9) by MW4PR04CA0305.outlook.office365.com
 (2603:10b6:303:82::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Tue, 25 Apr 2023 10:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.15 via Frontend Transport; Tue, 25 Apr 2023 10:44:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Apr 2023
 03:44:39 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 25 Apr
 2023 03:44:38 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 25 Apr 2023 03:44:38 -0700
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
Subject: Re: [PATCH 4.19 00/29] 4.19.282-rc1 review
In-Reply-To: <20230424131121.155649464@linuxfoundation.org>
References: <20230424131121.155649464@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b094e45e-6c2e-40e4-bab9-32a3c267e561@rnnvmail205.nvidia.com>
Date:   Tue, 25 Apr 2023 03:44:38 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b98ca2-e00f-42a3-f7b0-08db457a1b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUBxVard8fLeb4jnBSCLr4/DXf8f4lXbbJPgATB7hgI961ZHhEJYHfxSPTuQgryhof3BlbBA/rJcw9a6peY9MRpQN8lOrz1oeCykzkwYr9ky0X0u3jV3nGY4CheFxpLlY85M5naRU3W4PugHyh58+2ORrx6kusBeT2BK1M+Pq5ME3oD54hEkwYcs1oa/HDC0SPt2m+XRDPaEIBbov+OHWMtiXfyjO3fNhASHM0skjH2bbNu4OwP1lYBL6NJIAhG1eSd8WeJeFU0wqGEY+JQTcvE5vq6UYJDAxMN5OEDWuUPI+rpAEztPC/3zzZXRqZYkzNuihU4bFZ5tB3qPpyTQsaIY8bjI3RCSZC2vJF5OFfDEE/6yZqsSZidk85k7hjcgTK1jUHLPtt/g0zHWI7Nz9hSSqG0BrqPZl7wKPNVltVJxcCwqvPNRP6FyvSrp786zcQGrtyk96wRsjuOD/4pHh8Lckkv8sy92h9enom+KbtZseWPWz0DHnn+TOzM83OfsJB014gAsFisZn0ETkUG9xN1QeKWi/19erexfvygXUfOxiQCr9+Sfi7MRuWrFWpysqoEPotcJjXRr6ySETSLhx7eOP/hg9APbvPUK48i+xX9jrA2wS126flAsMz7IyzP78FfKz7Skw+WesZkdppu72wv6OWRAUKVUM9yPrixp6L7nU45JbetrnHESjN/EjGXfF3JV1F2d/Ia+sZi7F2VwgbbIBOPg60/QeiN+jraNgTqMm6aZY92rRJgySVMBcoNa
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(8676002)(31686004)(54906003)(7416002)(8936002)(478600001)(31696002)(70206006)(6916009)(86362001)(70586007)(82310400005)(41300700001)(2906002)(316002)(4326008)(5660300002)(966005)(26005)(186003)(47076005)(82740400003)(7636003)(356005)(40460700003)(336012)(426003)(40480700001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 10:44:54.5253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b98ca2-e00f-42a3-f7b0-08db457a1b22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 15:18:27 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.282 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Apr 2023 13:11:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.282-rc1.gz
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

Linux version:	4.19.282-rc1-g8ca3c8d28616
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
