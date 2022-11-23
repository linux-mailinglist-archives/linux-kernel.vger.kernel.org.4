Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6781F63639F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbiKWP3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbiKWP2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:28:39 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A342D75A;
        Wed, 23 Nov 2022 07:27:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGBdZ8Wcvfc9Zc22vcu3h33qrDhZyxaRLGWkid1ZSiW7pR3jg5ZoifZ2+QzoYCJCXmtnCZ+PQDHjPttuzsjzUBxAyaIQqeSFqhywK15H+z3WeMVCeFEd7nhd+Sv79747PrRnririHZK4Uo8b+7CexLb131Z8Tqf6UWoDkIIEgoMs7DP2gt9+0D8C+WBDQtocY66JBhmTGw+8th9q7LlmrPtPtq9jexp7olar1b2SJpj0qniIrWIye6jrOJmBNFjqaf4hH+8WB7g5fGLJXg5ywod4Dlhxs1+Yz78wCG/narM1Zb4BGdD/9YqWScf8pMOkS6fj343Z8zdhjNk0iaf7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxJAmdxGkh5fEubJqwOqZpNuoq9Nzg7MXUaj/vrtRNI=;
 b=hbQ2Q3d1MArhWL4kHw5eaIAbTaisf46KA8wsMDlJpbxGlx0Rw6hnQJf9a+AhYvQhZPIDT5G6bjbZ9Rt6FNHwBxKUeXhMzsc8bmMWPN8n3JwDyzLR0t4u6jRR/R0Jn17zkMq/gloJ3zZUszqgTjnlw6iLOVbkr7JjwD40X6CJNE9WN/BmiuZ79Jcl+9Q8w1QgjM4DykkFEWXyO8lFmPz/ialXxwL5oso+T6I92h2tmAvuTednAC1TSVdVkgPmpATRYOcvu1wbtKyCJZTiTFIe9qq80c7XzmnZv1XsYD/TpnjTf/Sccf3PlsUJwSKAV3TnZq7x9LdOnWIZ3WPH/1XNLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxJAmdxGkh5fEubJqwOqZpNuoq9Nzg7MXUaj/vrtRNI=;
 b=DeYJTkXKoW6zj55BJYPYBrrByWOiA5oF48TFhqNzlh+7YKNVWH69MnBFZpcEw7yQyDGRdhrchMMcBe8W93sYWIe15mWasFU5yJZJqDHdMMoHqyGsKfYsegcaQ8xqc70drbnKTD5w32RDodj/z/ayzyxC/5699q+Z9wT8PLdeu0Oceyiuv4RMLjAYffVcgi/4v2j4OFFKGe43ZXFLG5NeTnX+JppPhyc6duHsR/VfVZFLZ8QLhpZRDjrhIXcSw+U6LUWwhcdKrqvHoqOHEoCk1n5uPdHFKR6TMgU1BJwIGfO8yhm/ojdjJebm28a8ibsLefPxvb7Gw7kfcefHxyGKxA==
Received: from MW4PR04CA0199.namprd04.prod.outlook.com (2603:10b6:303:86::24)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 15:27:33 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::d6) by MW4PR04CA0199.outlook.office365.com
 (2603:10b6:303:86::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17 via Frontend
 Transport; Wed, 23 Nov 2022 15:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Wed, 23 Nov 2022 15:27:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 23 Nov
 2022 07:27:23 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 23 Nov
 2022 07:27:23 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 23 Nov 2022 07:27:22 -0800
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
Subject: Re: [PATCH 6.0 000/314] 6.0.10-rc1 review
In-Reply-To: <20221123084625.457073469@linuxfoundation.org>
References: <20221123084625.457073469@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <00c3b0db-9cc2-47aa-85d3-e7c4f5a03ca1@rnnvmail205.nvidia.com>
Date:   Wed, 23 Nov 2022 07:27:22 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: e7188952-bde1-4a07-4866-08dacd673e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fO9wNwzUs94eKHeqyFwxAHSxowkDNG/XnwnWXPC+0IcQABOLWVbpNsh/cKj6jYgMedR7lwDnFBLkvG9fUUgl9ubF9Fyd+8JubcIZ7SPI+3RgRgePUCx8PWOWbbPkNYbE09Ol/lEg/hHU22XnYJpG19TfvWN6Fs7rrXTdbGcFAOfuXV15lLAEaLt2j1xXYmu2rAmBBasZUbSmvBoPCOtzbiCRaaA2nyASNP6w6F2nWec/M96dhokqlg5G5C6rJvV7JUFkWSdY3h9Gj7qAfPvGXGEalXJLOnQUtiWe0PVcUXooCIgs6NWcOQ3cMpLSemHY9U8xsFSI00S8zNOguT6/65RgikKVAYKyS3Oh1bvzV2/Y1/Smg6PTiau8hmE2IkYGeqaAgwXmuJz2HJVzKjUWzFuFBCLcApkHFQDu9MIMXYWw5AuM3kGT0rnh+FFkjl5nO3GsIogwVq0XNbbgejSSrNThQ4NRHnQaTavMneA96aG1oHydI0ZCiAmkSA7X1csfRteb3QWbZGhpL8NMUvuROCLlw1PctFBqmOJ8K0BGgJtisMYAeuADH9MKUUUcI472xYeEK/PzTFCKuwmA6F0pUc5U2sgWYSYYkUAxxPfcpGi1mT9Ja+0vtdxkasltB0XKlpXNJPoS7NUqYMigfYe+OKOlR7yj7taSpZV92QXskcrlaK2Tc0oBvCx4EiIAsz3GBVQIPo3GZTLTMny+LQ42gOHpKO4gnkiCrayc031uGKv4GoL0CvSBu9wK+cN3ZsFvBRNdxDiwRKO7v/ejHlBLJUfHfn0li8nImZiVJsnrZZg=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(7636003)(2906002)(356005)(336012)(186003)(426003)(47076005)(36860700001)(31686004)(82740400003)(26005)(966005)(478600001)(54906003)(6916009)(40480700001)(316002)(4326008)(41300700001)(70586007)(5660300002)(82310400005)(8676002)(7416002)(70206006)(40460700003)(8936002)(31696002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:27:33.2513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7188952-bde1-4a07-4866-08dacd673e18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 09:47:25 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.10 release.
> There are 314 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Nov 2022 08:45:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.10-rc1.gz
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

Linux version:	6.0.10-rc1-gdcf677c9377c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
