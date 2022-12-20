Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783B3652606
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiLTSJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLTSJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:09:47 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE89B380;
        Tue, 20 Dec 2022 10:09:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oav0J4Pvp033xvYrBad0icWkbnjZV2YRg9wbb3CgxejciOw6g5a5WOZypEMBNCPZKTr2TBYHS9D7Rn8ahjLYC7vhno35D35anFQH2z90taBU0Sqz1aQaOeesocpKVcFjB1Hx6M8nKi+BqlwtkEdfJJ/Mg4F+w8/0qOv+32M4lpNyWCpSP4pEw5q9qkCBemk1AhlKPsb1xqD04kDKeDzfYgH4TlbVm7OmZzjkkytL4GCzaPt5eJvP3C2a0hLi8WeV3LkmCaUVFlhJQeLpdulZ6IQ6alOBBuv2OArhjaGYPkfkDANuu7GaPVr2ljHkOmivFZVdRzDy9F1DnVv9hQkXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFO6W+Xx76V5181aOb0d1ktYMSzn6teFfixcm9IwRnY=;
 b=LDFlgcU6JzpOFaHkSpUTaNwk3/9tQVIBKFr+eFKCAEvMyOfGBrwbrl/QR7fNmO8PI1+exkskTG4oh0t5euUPM7iq9GJMlW+H5CkWn4c5U6qfBg4fUCXw5prHgrZt9v3jmXv1t+3/ID2m+HrD+fDfBPeAUFzCDSw4Q8VMwoDSrezA9w3uWR7ajP8I3AlaCnLpZdthlj9jQG4qLYVieGcW3LGUqD4fxPWYpGFAtk1FCxcE173STYVDdqNwGmDQYiEYP0VX5wqcsHLkdQzfS5qI1YQFNiHXsYIlq5OUB0H0hzMJZrL3Nc8q0STU2WSXXXJ9egtXBSbrpeTFa+EkcshoYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFO6W+Xx76V5181aOb0d1ktYMSzn6teFfixcm9IwRnY=;
 b=jCKsXxnsGYBut7hMmBITPqzYZEy4FsqVMVbpcE4XIyrdxI5VizgK+1WxNnXBfbA2f0IGDe/lvadecYeFi8oho0IhfWl+wIxUGW7enxxPDPdMYUF+a2At7J4CmkrBbO43ACP2FIuBH0u9AjsVfPGw6PI4vwGjqKwvLwrROGscHm+CVIAL7/vBqjqzx10+UqCtU5HheuTWYhPLm4eZlL3knoHDbthGyU/SWz+biT1zK3rPNToCJ5vxySxVGectCps+3kjpGEJQDXl2uA6aqUOw0NVcR3gOfoiIOSu4lD5P4swiqgO8uEnXY9YAWvqwia1ZVU4beqJ+OH8N8MjEQ+oi0A==
Received: from BN0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:408:e7::12)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 18:09:43 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::bf) by BN0PR03CA0037.outlook.office365.com
 (2603:10b6:408:e7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 18:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.6 via Frontend Transport; Tue, 20 Dec 2022 18:09:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 10:09:25 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 10:09:25 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 20 Dec 2022 10:09:24 -0800
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
Subject: Re: [PATCH 6.1 00/25] 6.1.1-rc1 review
In-Reply-To: <20221219182943.395169070@linuxfoundation.org>
References: <20221219182943.395169070@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <1eb93980-15f6-423e-9f50-9c05bb25dfd8@rnnvmail202.nvidia.com>
Date:   Tue, 20 Dec 2022 10:09:24 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 31531a03-997c-40fc-771f-08dae2b55e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qr36L5vJooJG5Iv/6xXbwXOba9VTzIDoaBwK7Ng3r7WHYQxHjPuuQWL5BewC/DSSncGAcZ+KDrgrBtGzotxNmNwtHPaMtNzEH47ZhdkmEJpwtx45k2i4fmxbdMw8X3bGX6SSqgeqOHiiLZZWksKKIhqrnl8YqhtSU6hYPNPlfkBqWG9KWpdQWmU6I54yY7FD6dul0t4z0ePhLBj0A3hhU4SdvRalZdHGnjeqH8YglHB1A/4ZprB6yLuY/aVtdu5fx97eS05t8fWiW1c8g55UeGWm0t3xkDazaKM/1B22/GCCsUrvLJSMb2r5BcD24G9rU+PCRAlY8k+XJ9/RVs/RQKCxC0wtoex7QeEtourS62pXT7iSUwsl2ACoj39Y40ut7xqvPrEaDpo0k9404i+L5oUvRsMzNEZD9HbhENMcZoZIJy66kNxwo/vFEJW7qxaK00+ACmJHCgi5iJE7Z6c2ed+IAZ64ieH60RAJaA1WWOiteTw8Gn4tCW/UAK/8WhTQAXv41+/HO+MC/1thp+Q4dBRE2rLZUEm+M7fGPBLF/xA7j2keVfB5iAfylgid6MK9HyxinTjLJ0syTr3OoPTbYLlZ8eNlFHn8p73K3JZEnIeFHnDhIBeDwF1p2uozDU1+OSW6437M4nopgWNpNF87Lm34YH2/ti6hFfNPJOLx0jmUf7kku6viot1xLAsVS8rkHhJmytfAFBjdpFonjcZC74f0OojNQk1t5wote6L58vLA0s6cwI+2/68mW/CmOaiuGVjYE90m0r84TmQSG/JjWm7nWenSTFck0hONHJmcSo8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(426003)(8936002)(47076005)(40480700001)(31686004)(5660300002)(186003)(41300700001)(26005)(336012)(2906002)(316002)(70206006)(40460700003)(36860700001)(82740400003)(478600001)(966005)(54906003)(6916009)(7416002)(86362001)(31696002)(356005)(82310400005)(70586007)(4326008)(7636003)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 18:09:42.6922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31531a03-997c-40fc-771f-08dae2b55e85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2022 20:22:39 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.1 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Dec 2022 18:29:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.1.1-rc1-g4478ff938eb5
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
