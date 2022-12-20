Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAFD6525C9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiLTRvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiLTRvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:51:12 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FA565DB;
        Tue, 20 Dec 2022 09:51:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pco3tuzFeAhZqehCNlzujfMm54EbkK1wS0w+4RGmgtfkLMTCAvfL4rUAqo7ZgEKuz1dL0erAPB/qLD+vm8rL0RBzSaLJ0aje5YcgpbMQKT8BS4ZmsNKbHBjNG3zsCPW3W1Vauosjc1rk3JmElFShE9OQDoGRowTCgb7ZhjhoZl74rRlASEY4d9XrmiURik7F3c9Jp/W3xuIErgumRX1MytW7utpiyuEwHXnFWRQ8lYOef0Tfl4wiToatHTviCVJpc1d5nqQVYSruCWmGlQ2EyR6FWqpE0s+KbgNDWJrCKnOZ0jP2K9LN5NAM1dbEhA2jG1vj0lgHrMDNbQBk3jJ2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npyHmLAosJYukZvV4XLhalcO9dc6kZKphGILHORvuj4=;
 b=VYmyerQ6al6I2hKHS7UbsE3qQfrx7hmLb6rplz4JkPv8rj+7VFdZozgUUL7YngWr1RGIFoIXHTGMaoYdYRR8jty6Cq5jTk7v18/h0RTtykbG9ul4l5xKzLVefb+9p4twGWShwXq/pghr/azvnv4DUgzY7IMqBA04DSJCxgbRHzkH3o9eHeDJVlZKTpEMCYyZK8+XUAIxkkAhQROVIdc7AVK46Ylwszf4+exI13nvyh67OSRacCVAI4945NQSay81Ytfj56evBsEY9EnPi1pq9zSqqy+Jz78Gjf98mSPR8brrKZ5p+9VOGMi9hlWO+EBoTxUyNXRMi2KX0trfbaxPVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npyHmLAosJYukZvV4XLhalcO9dc6kZKphGILHORvuj4=;
 b=lmtLdsv3He9Jn50zv+G8EQlndUDMcfv/v3ogqupmnSjMWex0iFovtM2SAaNbuyUzOKFccIfQShcKC6WD4eeDrPPj6KMFVy38NXoPOiuPdOR/WgqSzatOTNXTZXgVOqpDSh0SXeyU7oCsRRHrw96wh6VlBnxkTg1G1PeoER9CdwmxLmbIzwf/Mg/bJRraSvhGQpR7I00G+Z+RqmNneAy4+0T/en7zl2g6Tpm2wSxhypTEckJDh3U8RpvS8r5GjCOjDoa5eX2LeuCpksyZ9qppw7uRGeou/ng4k++wWMqLYbS+4ueey1L4ch1/XIkk+bW/iUJK0NWaWcqmoKDPhIa4eg==
Received: from MW4PR04CA0074.namprd04.prod.outlook.com (2603:10b6:303:6b::19)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 17:51:09 +0000
Received: from CO1PEPF00001A60.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::65) by MW4PR04CA0074.outlook.office365.com
 (2603:10b6:303:6b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 17:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00001A60.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.8 via Frontend Transport; Tue, 20 Dec 2022 17:51:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 09:50:53 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 09:50:53 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 20 Dec 2022 09:50:53 -0800
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
Subject: Re: [PATCH 6.0 00/28] 6.0.15-rc1 review
In-Reply-To: <20221219182944.179389009@linuxfoundation.org>
References: <20221219182944.179389009@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <cf53c0cc-95ec-4563-89d0-b0f3fc54def7@rnnvmail205.nvidia.com>
Date:   Tue, 20 Dec 2022 09:50:53 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A60:EE_|BL1PR12MB5351:EE_
X-MS-Office365-Filtering-Correlation-Id: bda423e5-b849-4ae8-deab-08dae2b2c6cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UAXJIHqldDocrQ5nVX2jGUIme7M74aYfwTiBd09rPha1LObjr8FdjufNZWp6QthRwJcCZ7gbSvs92FYwlnHcmot+8WOftCUrNNnPMzxhdyN2E8C2N3iBghobzNg8lVNvBBVRbXDCzMGMw9dy974RGi+HpOQigYDbB35w4r5krb6zXbkeTzFXGB+CnP+DXnjv6E2qh2ZeCw3tahlJgOqdTEmWEJ635bWTPFCo3YxcxXtSdoaFAoSu/cwARm8QLXixGn+mpul1S/64u57JJ9Ty1hTJ6vCeupdBunH27+BGrLp1Z4UZATQH4Kkyt5o+q2qWY1IAGFHg0zEWCnXcsPwsT0BXJCHNUp66kSoKXS0J9oyFZiELM1vtnE50fVCH0behrv/h0hHJI+wJFo/qAIQ1wSuuAjIHc3DzIMWsA4E3g04AE+zlCJeo+9lN0jQEG5pKPcwJwtODwD8HW0mTkVdIzNb9SsTHDCcdeiETgt5By4Y2O14ouF/mEM1LCsW0kygIAEcRfCMvd1NGJbBKNnO2tzbGPRvvfX1dm0kFWk8ipKrOFlGVgpS/X9Z9wJcJVIDDIyJyzJi9vPQL3W4wsjg93FEFiFjG0uNNjHTiYzL0l5iRVlzryp1LJJbt75HmTUAdhR2Z/OUZ/vyb3ZUH2QMbfOovfkThDDS6Ic6NWojG8dIJbaD8cW358hueNYVyxJedjibJhUbudVMqF8S+rD0FlTRRkNRjr1rgLlT8Z8roLxvTkO5hJ2ajM9gJwmoEkETF+zb2RjwqDQtibHppjO5rbgVOIbRuZnlMWxdbhvIsQNw=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(40480700001)(2906002)(6916009)(82740400003)(54906003)(478600001)(7636003)(966005)(7416002)(31686004)(316002)(5660300002)(36860700001)(8936002)(86362001)(70586007)(31696002)(70206006)(4326008)(40460700003)(8676002)(47076005)(426003)(356005)(336012)(41300700001)(26005)(186003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 17:51:09.2714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bda423e5-b849-4ae8-deab-08dae2b2c6cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2022 20:22:47 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.15 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Dec 2022 18:29:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.0:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.0.15-rc1-g65f3ab07fb24
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
