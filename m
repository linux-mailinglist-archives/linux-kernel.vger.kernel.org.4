Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780FD6449A6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiLFQrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiLFQq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:46:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73757BB0;
        Tue,  6 Dec 2022 08:46:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X31pnnndBdN5Zi9K2IVRdiEf3EBxMs6yBuO4QceuMxOyolEOF26lpLNWe00Z4O5+4gzcFZ6x+mOg2nmZrjdT9TIz95NzvY/TjoHaa7g7sbNkI+uTVlvnOWyLvGkcul0Z2i3DjwIAaQBE+6It+O4Gu2n7Th/e4roJdxl0Y96aAnP+K9IExQDxc+CGGbwxTbcivSqXdX8Dxds2k626fc+pdK47a46zMP9FLtp1gx7WcgsxNcoKN+koEejj0asKAD/B1jcejVO81BxLDrj5YdLohCvgjsi4vOoveZW+JDVxelke7/jfIpP5qp7sXXLmPq4ntdX91XS5EIa2l8ZtX5LH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imk+ILTjAv/fJxzwCQowiBK1sND6NZmYUsNznQjO8Bw=;
 b=PhtDoSPMVhlY8Itxx/QewUNhe/02JfzbbvgBmcgi0tCKjZJjef/zWxFBXHpwovfvZEXJRO3s5rpYoN5dUOTw8sgatI1nOLM/WiQnhZUDSLHfzlxJcC80Lg/u1JpcSmUbM8Yt4h9dibAyI8mP5gKPXGRfaRFVv9vaUlhi4894A0Fsq5c19CCLuO8uuJGC2uhdDdpOoUpfcpoAQO4DMfbd8XqK17XIJkchGWme7+yX8iCCAJN/401CY3w9w6eRY2SZYUXL6CI1JY64MxdRLOvrrna4O0o/0mPMwm2s6xhuhZZziTIjEqZWpWCrFjwArPudsPRSgp2i7I81O5HAq8IKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imk+ILTjAv/fJxzwCQowiBK1sND6NZmYUsNznQjO8Bw=;
 b=p7UJKf4mnMVFqMQ/dz7tGPrdPhsxYCMJpEpcA46NlFuPn16oyqtdnYfmb3iC24MBP7mdUUVGwI5XQI6LDloCQ8lJkLmw3D9rnrmFyKDMbWh2niRGVBpLN0phOh+LhFN7WWvUJgaeKgFJO+QSO1Qw55ZE1NpWkDUkEqAF70o7M2eq9YM8uTZXFXTjfbxbfz2TTBckmixZTXHsd74n0CjhaDd8wlEJUoJWqRYC89fcSiuO4n+VAGsvIE4HRKrfvffZXu8CgXK58Nu2m8w0XRgQe7DQx56SaRYeNHQfrQ+uKRIJmVyQAoVWEsiE4axpiOrLm4Os+ko1BVm91ST8VjoZYA==
Received: from MW4PR03CA0176.namprd03.prod.outlook.com (2603:10b6:303:8d::31)
 by MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Tue, 6 Dec
 2022 16:46:51 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::4e) by MW4PR03CA0176.outlook.office365.com
 (2603:10b6:303:8d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 16:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.14 via Frontend Transport; Tue, 6 Dec 2022 16:46:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 08:46:40 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 6 Dec 2022 08:46:38 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 6 Dec 2022 08:46:38 -0800
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
Subject: Re: [PATCH 4.9 00/63] 4.9.335-rc2 review
In-Reply-To: <20221206124043.386388226@linuxfoundation.org>
References: <20221206124043.386388226@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <f4ff1703-63d8-4ab4-9e04-138799cef38e@drhqmail202.nvidia.com>
Date:   Tue, 6 Dec 2022 08:46:38 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|MW4PR12MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 927e390f-3cc9-4a05-74f9-08dad7a97995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JyX5+ZKy07w8QFUUr4SogN2QIn4+tAjffqmKdh5zcrouKt/OcwJn4duWCKmO55jcRC5J5ACYkVloKwEdtLlC53ggcJvbqEHIEiJ4PlkmpqcwkhGbq/lgQEIsTdo2rOKLnEd4UlL1vzZT2lRks77hZeNpWQCojLeILgDEhX8VC0BTobiMNFEa2fWuHptzmPEnMGht6wGA2reHTTiB/0fmldRSAK7uEh+UHs1iNrml8qvFCYiH4Hla5mCYy1jm3IgfV5M6MxQbxfOuPmZ8Tlsz0L4LxcRv6PJZXJ/1a2SdWvw3Me1VTdCM/6ORakqkaVg7hu0L90CaLUXrfGfYQOgSG2Hn4F1BeC33lR3aIuu5Yyu1ZoDFB6ZjyydkRu0Bc/Rf40+2wbEDBto1SOEU3iiYj9/LZH/EbyjCu/dY/arAtPWUBi47jlOGsSFQ8tegxJ/zgcbBiZUjdjnfD2TQbUuE/MSHfGvWdz8SUzgWrNjzK/hFFiIwJCzNh7R/5Vva4J4NEqtNEZxlIm/hKapxwC+IJtgmHBL9t/63auVTTPte/ymHCcS2KVW5CE1ZLZEOZGUlU1wnho93Jl6eoY0/mAHkyM/LX/nqM0W1GROyLW5DwHnyZ1knxvbYCYtxlib8zN5fxev5yIU6g/YZAxbo3rMApHvyn1Low3DRIX9/rz08OBuw3DbcCjc4pZQC5Es+oI5WZ0elABO+3zwKYRmtBSAGgGcLFaNwM6H8juygCX2KFsGM2/uyLRFKRKuXTHRE9033ejAe47tHwndNNxLDP9BmNwS506VTaGtmRnpDOW1JhPo=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(54906003)(47076005)(426003)(336012)(31686004)(478600001)(966005)(40460700003)(86362001)(40480700001)(82740400003)(356005)(31696002)(2906002)(36860700001)(186003)(82310400005)(26005)(8676002)(7416002)(7636003)(70206006)(4326008)(41300700001)(316002)(70586007)(6916009)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 16:46:51.4691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 927e390f-3cc9-4a05-74f9-08dad7a97995
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2022 13:41:45 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.335 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 08 Dec 2022 12:40:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.335-rc2.gz
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

Linux version:	4.9.335-rc2-g5e545e94a559
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
