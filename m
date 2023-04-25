Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965986EE091
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjDYKpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbjDYKo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:44:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10hn2235.outbound.protection.outlook.com [52.100.156.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B95D328;
        Tue, 25 Apr 2023 03:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzXZSaf/ruHOI3S4eRgNi+eQ5Q/uN+euTbrOaPyASISF2bMENXOSyse5h7i5KTDBWiZWb1Hb8NzGRFD4KAP3QbMOmzW1a63KxyrouLrQeqaQbM9ptH0Nf2YQUuPtHFI/870cnX0RsuWTa+Yxv+nMvO7j6kETJdn1RxMr9CViIJqEE6UpGamPFxzU5WawgVjDTx+35EJ8ih+aLfQs0d+N15u//n86OjrPg0ikqOrSzhVv4cbn3gCmjyM+M+kCrwQFV9JrS/0GXU1iWX2PITWI+6j6fzNo6x9DjELYLLg8+IdlJAUZzYSup/uIFsT9H/MPfXvL4iSV7B2OmMfvbYFbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duAfK4Uj6h8axMtCdo4Iq/syVGWTN8OZ3f1NZvaazYU=;
 b=a+FbSROtX5XuQ6M7z9dr9wvVOtr4mc4+EJH/KRDmyJrIHZsaoFd4AzzL+DApZrSXvoMOKt4QYD2apgYLWWZco9f7fxHjmv6qB2hw7aSd6e3nf8rhzzuMfDRDnGdwrkZRbACVytGGlPI1A7+Nz7LRePsHMTRQCictKlWfgvxH82CHP1tgQsL75HI1+s2rwY7CrQlujB1g8W6BcvRoD3raMhdIAwhSlAE0LX4qX9fTZZhaj/jQFdfoLnd9Dcai3yW74jqg+sWyEnxYnWdO6rQSoNXGKZK0tBRQSDYSV+HS4FzqdM2FtASDRPOCFyLParctRtZ3f0UI0zSBaC0GUy0uFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duAfK4Uj6h8axMtCdo4Iq/syVGWTN8OZ3f1NZvaazYU=;
 b=s3Q+drJniD0pBN+4Ld6KSevx+/Ygw1RR5qW00zpjJV997JL+Mu6dha/sz6VTk9uD5pIia2h+KRBawlxrJ1fxzJR0kTxI8zYx8+V0po9WnBeyhp3vTjZr9q8z0KAn0s8UL1VpBF7kW0APUAR/NNuTv0+vKOIbSfGmIwsdlE7sHnxRWp2f814TesX9ymLXYGeDjHc9W7DmZ8BqOOuwiKttth4TzGUDYqEk8LSu7FmxLx1TrU4G07zkjopsLRETyJveEa9openjgIsrULtsj62Pd8BVky/1mgs/XICEzVOFwJ6tNmZDkz3AwzWA3De8m3qqlsuCwN/hnRKoto4g5CXMyA==
Received: from DS7PR03CA0225.namprd03.prod.outlook.com (2603:10b6:5:3ba::20)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 10:44:51 +0000
Received: from DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::1d) by DS7PR03CA0225.outlook.office365.com
 (2603:10b6:5:3ba::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Tue, 25 Apr 2023 10:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT088.mail.protection.outlook.com (10.13.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 10:44:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Apr 2023
 03:44:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 25 Apr 2023 03:44:40 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 25 Apr 2023 03:44:40 -0700
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
Subject: Re: [PATCH 5.15 00/73] 5.15.109-rc1 review
In-Reply-To: <20230424131129.040707961@linuxfoundation.org>
References: <20230424131129.040707961@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <adbc6626-8a0d-4e90-a28e-e85e299c5f0b@drhqmail201.nvidia.com>
Date:   Tue, 25 Apr 2023 03:44:40 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: f53bf5aa-ac46-4438-a716-08db457a18da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDBjAWhn6llwoET/6gwC8ck4SZWEmR13kdFdjRFXBp0GQ5TO/MOi8QJcYBZ18B8zcRJ+4JY+7cbXOvNfCKgYnPBQz4Z1Oy3VGRTIP5i6RBu2x7UmlcaDj+duqcVYAUft3pGlR2otAmXZy+qEE1DfiLiXYqvQffb4aw5mIC5lAzBqD8vBp68Qo9RHpAuNvajwOPO3z/QrJkBnoNBl7TkTa4rxyJ+rTBnYaAhRShzAaYR7p05Jda2igAxr6GgFjp4mNeQhBu8QQUZXfw4o2ex4y645i7DrvObwsg8SpcAKfjZDDb8cIbg92K7YQ2WUBVYQnlO/oN/brfDxxnMSGPlUpZ8ZRKDzEBMjNkxXK103oUz4e1r6Yu9ZKNvwJYC0BQwzSRGhYNfwL5XZjmG1YH5FSk1nkf5VzDxmJf+lkAZ3MBL3h20WG/GmqB6pBfyaZGpDod2kRy18WZCGdh+1pjD7fKp64P7jbU1XyWTTOHMrfHMsaUkNpM7kZReL7gp2C8ctAvr359k4EoOaB774PQk27d1uHAVqa8EdwHLbbiki6KDZiH7jllE3DxvHww8IoNTikvfhsLbEII8zuFcILV3auOaJGTa5lOeE42Jr/rUjKweKi5T4wP60XmqpzAG4Ta6O1SQ0WZDQxWDzqodIBjqMVbC7fG5nLURQd7KW2FoXkwxPHR5QJVn67kr93FW3902Rpd+dYSV3TgM6isXlEV3yPd+vcL6DfO8k8++EcVsLOlfT5qQ6f/pfvVW98zrtdx3N0PckrBQcc9okHRzuUXoi3s/yG/MAmP3gfS4sEvlkOkanu/ZaJ0CnzLBZpulExgeN
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(5400799015)(40470700004)(46966006)(36840700001)(8676002)(31686004)(54906003)(7416002)(8936002)(478600001)(31696002)(70206006)(6916009)(86362001)(70586007)(82310400005)(41300700001)(2906002)(316002)(4326008)(5660300002)(966005)(26005)(186003)(47076005)(82740400003)(7636003)(356005)(40460700003)(336012)(426003)(40480700001)(34020700004)(36860700001)(12100799030);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 10:44:50.6960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f53bf5aa-ac46-4438-a716-08db457a18da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799
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

On Mon, 24 Apr 2023 15:16:14 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.109 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Apr 2023 13:11:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.109-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.109-rc1-g579deb859f24
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
