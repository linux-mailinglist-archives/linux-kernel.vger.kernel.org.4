Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FB5682E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjAaNl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjAaNl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:41:27 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7D14AA6D;
        Tue, 31 Jan 2023 05:41:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQVfGEnUhjq6ypJB4MjbqgiXp462vEAf1c3O3eb5EcYoCsWuHNh85RttHhy0vyyJWFluD1nIpv1kj6m37+IkVzKGAQOsCsr35jqTm59GOBMkfq2agZ5oxy4XQg7fzxP+TQwkU7D46iMz2LUBimEL8gQUzReNXHq9blEpaJAgUcCmGv1idnpPineOAC/4kb/U0mx8pLeUcQ2TkBecGIXqUai+/gHirwiOrjLUpRL/tZJWYsUc4u6anTnF1lFz8jLa0BHpM66BjgJV2iJpq1B7NFrlKDRzwQQlXLvn3Cu/udWt59x2upO5osNKuifKOQ9jWNIYGa3+Gh6s+9Qtbx7lbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Il7ASnQ0uPADU8HGpgDtmF19wor7b0WPL0T36W19wGg=;
 b=OZ/IWe4BGGu6U96Uym+xL/5evGJ5Tuu6W5y3oUhDVdPf6wMx/3WXBykANh+l/oAvNnj0jjBp2m3XoSvwEx57SGe1vZbrsNwahhqOkrtPOewlQB5ode2MC94DrxPqmFxJswn3xwhvA8Xpkkt/4TFo5+lO6zrVO4397v8kPPypg9tRUf7H/HIjXppbxAYbSVWXs11lfC1hUKzaflGHJc444EU5pBnOibaQQlFXpSDNDq87Rj6VcdVGHH6HQREHL0EUdOj4a/fpfpTbKHsbtyZaWpy4H0cCCuU8KBZPFB0vHj4LyY90IwhI1qPYle8Py8OpKCF8VzNP53NO0vZKIza4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Il7ASnQ0uPADU8HGpgDtmF19wor7b0WPL0T36W19wGg=;
 b=JEInr2vp2jZVAl/tjKpZf0N+44wyI0lh2atyhW7Nz46yjjZhZpTmObQkLigvlL6AqVKgyTIQ6P+0Bz/xc+/R300MndpffYOYb1F9sMWKG/0uDTGIN7EW7uiVwNF0eAwCs15SenEUkYmrLeUv4LG6KkBUjwEW7W4HaO3u8WgC4rexmufrSqkjy7eNeyEBVIjp7caIUuVUBmbAcWO74JhqrWjRmM1cW6Ey/4+gFKxMRWQA1XGWDKQqFjn1vqoiY2k/KePwLerczU6hM6AKM9yR4DU5kJGkKGJL0saKUV5tSXQQPhBHndKJyM4YZ3qc5RASWWYN/yg/q2HvOU+M3qT0BA==
Received: from MW4PR03CA0011.namprd03.prod.outlook.com (2603:10b6:303:8f::16)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 13:41:24 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::82) by MW4PR03CA0011.outlook.office365.com
 (2603:10b6:303:8f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Tue, 31 Jan 2023 13:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22 via Frontend Transport; Tue, 31 Jan 2023 13:41:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 05:41:18 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 05:41:18 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 31 Jan 2023 05:41:17 -0800
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
Subject: Re: [PATCH 5.10 000/143] 5.10.166-rc1 review
In-Reply-To: <20230130134306.862721518@linuxfoundation.org>
References: <20230130134306.862721518@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <70b0fdac-299c-4356-81df-ce3d16503536@rnnvmail201.nvidia.com>
Date:   Tue, 31 Jan 2023 05:41:17 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 0265bdc3-fe87-4d85-dc55-08db0390d88f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UT7VBOpsc6opSXgBX8MHmQPNg+N20XV3o69c29Ape6aGtFWTT8Ywd3hOIomalfm86gcHDU8u78EE4YpM0dp5Li9FPE3SErvv3k3t72T+ne+KrqJQrK+XbReob4vIIUp/IR3WHn86x3copBDrjBFcMrHWD3/anwfgHR9vOQoTuUbsZ/3nFHfodMVyHiHzPbcX/3cbcX8dRV9yR2tL5bdjFoYCisOLflIdgnkXOVDqDdZKycoUY1mZNdip37Fr9tBspi/F2P+7/HumSMs32yxg7/pE/3eda9PMg0dSF8HRYEt8PRUBctukBlUl9W8ZbashKx9jZPJDzUmJQuIPqlEKLs92TI11qE9ypam5lUCdb+khLfxM8drjrftzSHY3suCh9zvlakLfGE4nV63mx/We7kS1qdjoT/KAdea8yjl+MyVsUeMuvLnuzA+rVLQDLJ7BWQDqMc1GKlfH/NARzMwebX1WlLhBu1X9pZVBXC/pgaM2Lxfwviz9DjB6vax51Z5LCJHYZdTXXoDr62lOyDOqBYH13OXjEmM4SIH8s6sLVlyUo5Wmwnsh6B0MfagN78TEEXuqUceDLQVrb5IGkuVPStOLd0RV8Qk5xbxbdFMy8HsPRwGSutxAZMqzllDpUvAwvaanRGSX1qjijgFZnK+rWrkemDxPin+BCp88fFJUL6VTM8M3HtEsOgw2fNnrl6G30C/fBJDeP+Qxjx5mdtwJiYYSYSAB0g5njclUr1Fy3mAPGt4oJv9fwySwWgTTHLxzZx1jrQyCN5EVgGBGQ0ESA6Q8METSUMd6/Az5bmhu1Gc=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199018)(36840700001)(46966006)(40470700004)(31686004)(41300700001)(6916009)(70206006)(316002)(54906003)(82310400005)(8676002)(4326008)(5660300002)(7416002)(8936002)(70586007)(86362001)(356005)(31696002)(7636003)(82740400003)(36860700001)(186003)(966005)(26005)(336012)(426003)(40480700001)(2906002)(40460700003)(47076005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 13:41:24.5444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0265bdc3-fe87-4d85-dc55-08db0390d88f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 14:50:57 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.166 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 01 Feb 2023 13:42:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.166-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    75 tests:	75 pass, 0 fail

Linux version:	5.10.166-rc1-g930bc29c79c4
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
