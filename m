Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68B869E22F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjBUOUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjBUOUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:20:33 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D279D2B29D;
        Tue, 21 Feb 2023 06:20:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW+86CSvVyggOP+BvwJNYTrY/0Nex9Ron55R30oHM6M67u0VnrgNOT9IJZBuWWzNqW2Eyiz4XPq31Gj+rYXscGr7UC/mo2tJtTk2ag9RW1M7Tc+xPvHQ9xqmIvO1NXkYZ5I2XctWQ8cpxTiUOmbGm9/olvHbbaEaf+tCECD89NU/tJ1Fk7x65cZhtHDWNB8WvHXd6euBGxShjl7BReZIDiVi07JQu2TlbXcJCc1TOjQfz8bFd3Q+aLi1AHEc/Gsgfv+Ix5VqLII6PgE9KOGNRfsXDXlaUlfzcbJg4JyvOguneZ/ji2c4Ce7Ys+2Io69wu9MN9CrLN+2ttz6IY9ubYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3V/zT0fBjBRdhr9oOUNSBj6Mqqixi6vqxkbFqwZKM34=;
 b=Rhu/82EEGpvoGUNP35isbFC7NYJP0OLQXCFmmStxMthzhBHj05jjAE2CYxnU+vJi4za7P7DIe4gp4mRl7A7Nbl4VYZTmrEA2qI1IGL4mvh1UZn7drWmPh+XgwVwzEpx4dnftoaYVVkC/VDI319Ei49gC6x1jAyNXox2EEGM8H1DlHJw1xyjYG+cOOQsAW5+AG1b+i2bcHjbLPLEgHY6/gjc0wUDdFm2ai1eLw6oIHmWwOIFOizUN90PvqubWBK0C5W5N1Bj9HcJsWjorXm6ELwM7S5Yhr8IXZ676C4uF0dB7jUiEjBaERMpEd53WX00WoZxtb8D24vwC+PuP7zedkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3V/zT0fBjBRdhr9oOUNSBj6Mqqixi6vqxkbFqwZKM34=;
 b=CGEv+BoJfQEpvqT1xfD4RXrvAspDy7RKhC+B0bItuqgDZDKgGIbADcarG4Sy2mBDbaqGewzYeyOpdvCw4qolroWQ2kWlfpytC+IOco1TyXZlxXQPDmc7ptbY7kfVGT5G9hAdUT3UptuaAlPhXN1hnQvk5YL4HtHzjxcCo3ra2TABaPX8CbSNwbNqm0m/KunxdwiO4eZv7jrWDCwJ9Wnb9z9TExhHyve4lzJJmk2fkYVJK14q39eh4asvHD3KHa4cFxBL1FrC/Grm4M0hn9B6vYd0dXuvdbgjvrJDggWuzYMRMfpue/Ebu5KfpMqjcKRil7UHFgc/V0Tgjum0kCPa3w==
Received: from BN1PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:e0::13)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.21; Tue, 21 Feb 2023 14:20:28 +0000
Received: from BL02EPF0000EE3C.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::68) by BN1PR10CA0008.outlook.office365.com
 (2603:10b6:408:e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Tue, 21 Feb 2023 14:20:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0000EE3C.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.15 via Frontend Transport; Tue, 21 Feb 2023 14:20:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 21 Feb
 2023 06:20:07 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 21 Feb 2023 06:20:06 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 21 Feb 2023 06:20:06 -0800
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
Subject: Re: [PATCH 4.19 00/89] 4.19.273-rc1 review
In-Reply-To: <20230220133553.066768704@linuxfoundation.org>
References: <20230220133553.066768704@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <f04c76d2-5006-4e32-b45f-64d71a00b9fa@drhqmail201.nvidia.com>
Date:   Tue, 21 Feb 2023 06:20:06 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 31afb135-d331-46dc-87fc-08db1416c7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8MfzDSsFqFqMCiFAeKApq7U8cjn59UMLrFB0Kp7MtWr+lvrTkD9WQxqdnKgRFn8PzbnaL0RYc2rnZQt3ZAieTOuBdvqrcTl2wI/tbURznVptIZjAx+4/s9OPIPQI1JC4KCPiI7l0h2buQoJfyAiI5fCG30PhbInNcc4/ycHtud3ilbF1doZBQZViokR6mZeE4wYA5aXXadG9a4GeyMgmj4mEFVSxkNDms97r4PQ0a6gQu83r/4nL4I36vstzVE3qsrD9+Mpghrmt+1sLjbrOhnmJNxe9v434m70nRoodoVhKTInqy27jDRY7UndxChXrBlUE+LtvbOfaLQmc0gYU7q+FtWUYCw3mSEQuQpiu6Jgs5DCLD61IksLXcWCMHx0YPRyolHfjQJhqPDM/6Ev6Q/9AUbulBWdstmKrqMnqGon5FZOhDZ7c+BOWxAs1CrL0iSdFCcQ9/v+8WnKsksg2LA9Ht5Lo1gQSYfd0ocm5N4lg2HM18VqloHxaCcXS3WTnLhVj4T4yHOOyLU1sklD7ve2fr4TLTqIH8ZwzfKG1zppC/Tkrg4pIAZICKrgRqUWnsJS+XqTJkDzs5oZoCWDtCiE2kLRK0r3Yn3Ay0Jp3T5SDotJcGhRysCTR/GOd6joI7HR/OE+isP3CX1uV1HS3850wbPczhl4t6FaZaKXvKNZpQj2LDL34E4UNf4f3CLLOCWhEcgNKGi+SKUgbfP+Epw==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199018)(36840700001)(46966006)(186003)(26005)(966005)(336012)(82310400005)(31696002)(31686004)(6916009)(478600001)(426003)(47076005)(86362001)(316002)(8676002)(70206006)(70586007)(54906003)(4326008)(41300700001)(7416002)(36860700001)(8936002)(5660300002)(40480700001)(82740400003)(2906002)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 14:20:27.6988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31afb135-d331-46dc-87fc-08db1416c7e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023 14:34:59 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.273 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Feb 2023 13:35:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.273-rc1.gz
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

Linux version:	4.19.273-rc1-g717ab64d0adf
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
