Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4617C61607F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiKBKHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiKBKHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:07:21 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3553224093;
        Wed,  2 Nov 2022 03:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsZi5yv2R4OX8Sz32D5w2vrYaCezggiWBeGy25sFs10bNDrfgCKRnTwHgPTIrBla275utsdqGI6gJKKsbDi10yu9xLcnXWqcW1FAceBqGvC81G5P2f9JFaW13VGZTdyU5S14w1/DSizwFXE3JpEhs+LM8ERSPWYpYKBPFuaJ3UoMKgrMdZ7dp0XtlGjzG0Z0cU4eg3+O2w8alZHNMcWuYnoQQJ+8Lm+x9lmVQTpJ1rsW2Oej5ostKHYsO32cztPIba70JPRSsHN4xCxxa7HT9EdnFYDSP/tVx/bpGEg7DGV3ws5oOj2OltgrdU5XImhpJoH6PvUXeRkJdIc6p2YU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wiU4nf4VziSKP34TpMsdFZKQoSvndgebytTQc1g7m8=;
 b=CrdiHJJsihNiTlNvA023cDOTO6Mpo1/4OmBWO59/u4R9oCn+1V4NaDt0IxePAtUzv7KB8x4Zk5lhPOzVvMAN6txHbACNMDfcIIXGH5zR7d0ZOPrhnCYNwasIsmmkjfGHKqW3VG7t/VvC4k74ac5kcFYhJ+xyF1oRSd89putnK5X12np9ZeA1KiIfq001bEDnkQDTYDrLTW5W5J9zLBakNqM377orGuj21cx98jjbKn1PEBs4ilTkJDpahuHLdvi2nmzwW9VT3E60V99QY/eu4wKFeFfJ0qAzfExL9eUNHWZu33R8jRWSHE0g9xy8UIRfR76AXP9R3eEvJlaDogpjqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wiU4nf4VziSKP34TpMsdFZKQoSvndgebytTQc1g7m8=;
 b=Sa/sJK18HwBSZlJLeCx3TrfRcKS6T0iOZeGTgG2GS7+FO5on9tNVnWOsy7ARggYzaAN9msunZHNfLBg4swiQcmlYUvG4CZl4vTCHFS6QJZe1tj8KzveGm3xYa9WqIxeoZAPtd/8KlVggrc2FWqXn+bleBRNVMnBXc3APfFY3WhwuOm+7/4oU2IQitUMYy7GEYLnpClGBvBnKTQjsW3A3urwe0OA6mWLSPbWxGH64Ic/6MatsqVVRmxoVY+4/9rWjWOIyxnYaw4oJYsZnAX2SGrAEt5cew4Smu0BZYKm5CLHfhY203IA3CsNRuAOd7i1EL5wLr6yxSNt8KoNNylptoQ==
Received: from BN9PR03CA0868.namprd03.prod.outlook.com (2603:10b6:408:13d::33)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Wed, 2 Nov
 2022 10:07:15 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::1a) by BN9PR03CA0868.outlook.office365.com
 (2603:10b6:408:13d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Wed, 2 Nov 2022 10:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 10:07:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 2 Nov 2022
 03:07:02 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 2 Nov 2022
 03:07:01 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Wed, 2 Nov 2022 03:07:01 -0700
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
Subject: Re: [PATCH 4.9 00/44] 4.9.332-rc1 review
In-Reply-To: <20221102022049.017479464@linuxfoundation.org>
References: <20221102022049.017479464@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <9089fc6e-7052-49b3-af88-1355dccbb0a6@rnnvmail205.nvidia.com>
Date:   Wed, 2 Nov 2022 03:07:01 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT035:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 622c9c2d-9f2c-4e6b-13d2-08dabcba048c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgcKZ5R4JumyrzakqwjPLrnlAMhCIkAS/l6v4e1S4/Llf+WAlAP/pUljZVGHop1Un5SewFR6aSfb2qYLJtqzfXl59uhe1ODwkHx1bzXYc7BwEBa+7/PW81WvEii8VKFZOsyHKsneXhHmYLxmuL8prK+vFD1Wor5Uu8YJGDFb8qwyKeBDRGLNr6Ok/yg8lM4VGsZHzTllmkq4PpuhS9S5TLHUy7zDzul90QzA3iYM6duIwMvxPB9YPa+PXjnCRpIVHqYpd5ErB4PG2xd/eA4db9psSqxaOFU3U5yi6O4z9oBP30KTeUStSZ0LWBwDstgxlCCzAefqFvOWbpxus54BiBdIkTQo/MS8bNK8jUMYdSxUvnzg8YYHbo7RjdOd8Pi4FwwI+y64TSYWvYJXL/a3brKp0CvM/NtOFRXwKNBQWtvuEzrG0QNi1Lk7lttaO1aiFPuHma5a17M2q1TwWlrI+uX75BlWvcSkaWXp6jGo3Fce4qUyLvzx8IcQNuOGoZmYxG9HL148Z/MBaKOtow68PmueoXANqHaJgDXfa0xpdKYP5gm2wMW+WADlAUhQ2w12dKTwh+37pPMYJysDZjsDZIhjoJgQa0+Sv+OK3B+Yb+uxFbZylOD3tgwE6GiJQCgsp0EYT7Bh8c/n3ZBfPL8CcctOtNBx84JbRgUYRg5PFfxiXA/g4TD7jeF4586RrExx2BqfhNSmEWuqx1jrbheGfv5snR9lJ6r71h0AxI1jp4pZ8aQx3nG3K3MRnRwSmyq9ZEWdpnBn2R2RYUmQG9tk7N8O4Vulqd28taYoZ3guRDNPbOz9UbnvhGxshuN3sHL4I9Xsskkin5QFf8woI5UKYYeTy24hCuVzdt31cKtU704=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(8676002)(70206006)(70586007)(2906002)(4326008)(7416002)(8936002)(5660300002)(41300700001)(31696002)(82310400005)(966005)(478600001)(36860700001)(26005)(6916009)(316002)(7636003)(54906003)(47076005)(31686004)(86362001)(426003)(356005)(40460700003)(40480700001)(336012)(186003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 10:07:15.0543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 622c9c2d-9f2c-4e6b-13d2-08dabcba048c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Nov 2022 03:34:46 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.332 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Nov 2022 02:20:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.332-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.9:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.9.332-rc1-gc8644fcd3008
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
