Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E626FC800
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjEINgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbjEINgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:36:00 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6303C12;
        Tue,  9 May 2023 06:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaIx8TUpFVYppAIz+xc2cgpcc/sPoelfSB3W+c3EB7307xUwooBH6imc0KoEYlrltWQ+DtG4bCoux+a3EQWPlE0iDeJDOFaEhK9yVNbS4SIeaMGmD+DZVKPmYxJu3fdH5K5+AiQ+3pBDU5m/hiLggUBpJ250cac4TJUr4gLSZKLT0/245k1Bply7zdyTXHaMK6xL4BxNb9ifygBOCIWLsnPFjRcoMgQBEQuLBK9JoJczczO5TQlDbOhuIFAlTWtLPwwpFx8t7lxsgYF+XGBJUeeI13wF/vKTCI4chi2m3twzhbpP89nuUdK2jeXn5/oek8CtOL2vOgyPdTMgki1GUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08hmKj2PrL5AmYBiLKOR2vjvYc56un3808AhVtAsu08=;
 b=P/1TjQz+wfs39vLZNYJD7f9o5WkT3BlSKIMwbyUqeLXzh+gP1xZ/ZoyZsRLQuGDyaptX2kYH0UPLny1Hd6sL4C5OYp1u3OUDOCqAY9odwxhExxq2uUNz7op9JskR09/sqkASYGNujsmN4aAlejPPwLSRwU0pwSEkzdNFZERevZ73g+7YhDle8Ix1gUPpjitB9UHbzee/HtZFGELNf8rZrUaeJ3HwgRVGeaBYh7SVhQKIxSZ1qdi02AU8tM+/PLfj8k4oXC/7q3reQowaN5vR4O9/jgs9YZBRwI4zCpGvi1NnIdeLvTa2lr/A413uqzL7vw1I+JB+uFs+SPXcc65aNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08hmKj2PrL5AmYBiLKOR2vjvYc56un3808AhVtAsu08=;
 b=YATRnpeVFgGcNorkJoN9Wws38E4pRn3Wnev14VptND7I6ohQeJF0ktviGFCnqx7DKT23QgBvnXyG6iuq/upkFAJbuVQwAME3GfdoFIP8HNtKsHO8CDy4mNq0agrHn7l6yD1sSTbwZEzjg14Jl3ejCceS2XNxuQON2RXRhgJ4bErzwTmmkwJNe5JL8CssQ0/Lh7WGmCc+mnXM3swk73Kr84jSt11BIda17TJFgd2AjVe27u5piFhjjNW31a+EkbwHSXfA3qLYhR+OxdojsV2bD337kC2xUdaz64qGIghwQ8S3A2QCkmaiz+uUg/BzB037jQ/v7vts+P1A5yEDqAYJsQ==
Received: from BN1PR10CA0016.namprd10.prod.outlook.com (2603:10b6:408:e0::21)
 by CH2PR12MB4923.namprd12.prod.outlook.com (2603:10b6:610:6a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 13:35:57 +0000
Received: from BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::9) by BN1PR10CA0016.outlook.office365.com
 (2603:10b6:408:e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 13:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT108.mail.protection.outlook.com (10.13.176.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 13:35:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 9 May 2023
 06:35:44 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 9 May 2023
 06:35:44 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 9 May 2023 06:35:44 -0700
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
Subject: Re: [PATCH 6.1 000/610] 6.1.28-rc2 review
In-Reply-To: <20230509030653.039732630@linuxfoundation.org>
References: <20230509030653.039732630@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <ba56c452-7d67-4381-8537-71b77d82a94f@rnnvmail202.nvidia.com>
Date:   Tue, 9 May 2023 06:35:44 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT108:EE_|CH2PR12MB4923:EE_
X-MS-Office365-Filtering-Correlation-Id: aadbe29e-ec31-4aae-c8f9-08db509251bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /i48akRW09FUPlpzkwumHmff4sWXki66ARAqenMvGzPbkERjQG6ENJKJlSE5E9zq+gpKpHRVyDZF5gzRLvo2bD3aVyZLH9n9cX/XcAJwOPctIiENOry3GJ/3fK7BZY8txAsTeamd2Iepza2mh19jkSy6cJIsDkqYiTge1ER1xj/mA/mC0KMx6HDWG8wQTW93QBRiMQ85SNGxYQWQDCioXQZ8pAciDyJRbqcCnrAy5+d3Z2Z5gUYp7dUiEo6D+BwDzoVYrhKP1Fy2JvRjc7JEDtt7wBR97R2vRPOGJcm8Kelmnui5no6GecvyQ24lAhi6yiGhWPzaOxyKTsKNiFHS1vtLhW5mqc7B2bCAKZj7gdVQVJMViXYXaEVTA+Iy+7EDbNoHHQs5NMDJ9PpPu3FuGrVlRum09DcXjUL6HmJCiVapu0rUh38rGwbXyZhM9gb+HO54LPW1ywdiFtEvkDkuo4iJZl0v2P2Q+xQewTHDjh9mrvlSnn/wBAyjalOTRC+b19P9bUVOPS60ZGTMOzxyET4v31XHdfzm7kADgPI/R0Tbhe49RckoiaryVIXNcMFHm4J3uFlvF/Fr3bSjNdyZ0ibMjBQLuTNOvShK819P8Zq4qKYo7GkosGR2PuUXitAzanNeQCNO1U3lImUJzwTkp0KKXaxsnobcwBm3Tmwa39zdNSvk4iK/eRjd3JSbVcK2h46XHBwKsHpyFl42E/4FkZ7smiBR71XdSr2k07/yx/rHTSH4+Y+iY1WURswRRpqZ
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(31686004)(36860700001)(966005)(40460700003)(426003)(6916009)(2906002)(7416002)(316002)(5660300002)(40480700001)(8936002)(86362001)(8676002)(70586007)(70206006)(356005)(41300700001)(7636003)(31696002)(82740400003)(336012)(47076005)(186003)(26005)(478600001)(54906003)(4326008)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 13:35:56.8152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aadbe29e-ec31-4aae-c8f9-08db509251bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4923
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 May 2023 05:26:31 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.28 release.
> There are 610 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.28-rc2.gz
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

Linux version:	6.1.28-rc2-g2b7e1f92aa55
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
