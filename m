Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9642E63A531
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiK1JhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiK1Jg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:36:59 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F4B12AA9;
        Mon, 28 Nov 2022 01:36:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi8rY+L2pqa920HzlSAB5pK35RgfdJq+ui9utCqmmt4dxhbh7zev30dUaUO36PGGxPObc49P9jJH5Fo7Gjrc6l+sZUmQVpl/Qe7BTwnjVGC/Iihztg2rycOWI9nvzgAaCLIQVey9whP4scPpyChHdu7qNJ1Vpfxj6PyWpd/ki/guM4fyGZFZsnsYiqlIkYzyuBBGwDbQQf5aQ+Q1QWMCYYQ6SHk1EfJoRzFLN9Y9tKuufU3v4LYmj7exCWc8Ysd2tfQG68uuqZu70zZWbhrk17IHI7flTMSRjGuoAroKFYotIGDN8yFKbQ9AH0aOAnwLIGGg6/q97YsiObS4EDdl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+3nff5AGsEXoJVAb1Gkjsqc6oiGpUZ+i/xbPc+iEqc=;
 b=anobaWnlKzoW4y9IsrRHt+eD/OM8zZIpzRZGNrRLeyLIAqBJMSqBXJ34nJacWOcEnSgxCYWjDMLyapwWRN9ol2JKKkHSTkSg7wEMhzux11mF1gxkn8PV2OXkEcXU/1hH3orcWexdlLGeVa5NWZWLNMDaGQd75BjzK1gGeOjMHHQGYrPNjRUVYy4UwGDjWtCtJpc70EPYPIPfeV6WHrLCGezLwhpTBRCL7jhpGhZkoShw43dq+cFLX/GxjxFvSPrugIFo/P8GB6OGd8q3j2PXBvwCNcTos50+iLau+gnNOT/fhyqS6Ft8pVsFT7HZAHh3BRjpV+PAwlEbqv7iDjeKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+3nff5AGsEXoJVAb1Gkjsqc6oiGpUZ+i/xbPc+iEqc=;
 b=YsAfH94PuI10qe4AEspAf90+AGz/+z1h+n9UHYUB80L1H94L40d84mxxbmNFID+QxAZ8nmteXI9bTenQMyKXPiU2+Vbad6MI22Z7nAPUKf7xzCeQ7t7pVQtwzpyjVTidBEfbqaFjmaH8KM6v+kpiSILPFUYxBB9i0IinU1BtzoAUw5rIOD7EqIJ5iuFHYJmeT7VzL2RIL7xd4P22hS6DrOkAW/u0+bs0m9N24MvWHxw7ObdzhOi6wV65Ei4FDTtrJdLbTAgfVavDRNTtEzSaue2gQTru9KrY78yfUwPXunWlL6qqffMQJHvK02LGr0X03ehT2YmZdMz66/mowO7A6A==
Received: from DM6PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:333::30)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 09:36:56 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::b) by DM6PR03CA0097.outlook.office365.com
 (2603:10b6:5:333::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Mon, 28 Nov 2022 09:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Mon, 28 Nov 2022 09:36:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 28 Nov
 2022 01:36:49 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 28 Nov
 2022 01:36:49 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 28 Nov 2022 01:36:48 -0800
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
Subject: Re: [PATCH 6.0 000/313] 6.0.10-rc2 review
In-Reply-To: <20221125075804.064161337@linuxfoundation.org>
References: <20221125075804.064161337@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <49e84476-b19d-48f5-932f-4f2393a7a4c9@rnnvmail205.nvidia.com>
Date:   Mon, 28 Nov 2022 01:36:48 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2c0ca9-f34b-403c-4d1f-08dad12416d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DXEyUmlvFv1xJNL1Wdl/EKalKCzVvkt0YMfyIKr03tbxXoN9DEWUKJFXOBNsfAGnA2+pLtl2mOTYb2SdS/3F3EV6ontnVUaB/vjRIGVUnjzcVmKiCy/Q2Z+bKd3Bi5qIGp2kxy6+8Xe7U0ArMTNZg6NHwG28lxRaWXGCIJER3ZeGPRKV2AcCu8lHxBwzrrSIyxkV5wLz8bvz7pmFVXmpDUxRtIYi2Ul0ND7dW1spd/+IamYWs5h46jAbDPpR9ewfODHzKu39pvjCe1kv++zSQ3O8zwc7564QsrbHtENUvt1xdtzfC7aUnNfJtZPBgmRvpbwuFtGEnRK4yeY6nNy2U8LyiNnqvpdc1As9OAQ6k+sT6D84bMHygeyec8CDf4pmrfKtD+2bT8Q4Qk4gje+SJGMoWtL4MumyEAClGeras2BFCB+wDSV6JqiqDulxsubpS+KY1aftjcnXzPpKQINjnoxEWqTNZWOj5/VaHIN6yGVIs5FaVkHq4wnd2+vDMPWS5eZHki9XwDDYAQcSS4whevj2YVOqG4238BB0ZDWzaaiiO7sLMIAJTOukMDIphtNYHFjsJc5xM+PI0UWR4hU0BKPJPtEZrT1AFrS7Qxepm6S9F5KXlXb/RTowO+MgeZCUgdLPcEw70lcO8H/xkskuAdXg0v8wpOeLdVzvgG4lV/jhGqepFwSmjiJNl+pFcSQ1fDg3yHMCTLklAfQKQ6PGaQlAju5ly83pziocM7HiQ2METneIhKuvPoLlGRdUgqKXE7tU5bmq7igXh/6/Xh2vRN3uqDSPvrJ4OjvdA3x5bRM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(70206006)(478600001)(70586007)(316002)(2906002)(54906003)(6916009)(966005)(40460700003)(7636003)(356005)(426003)(47076005)(82310400005)(36860700001)(82740400003)(40480700001)(26005)(86362001)(31696002)(336012)(186003)(5660300002)(7416002)(8936002)(41300700001)(31686004)(4326008)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 09:36:55.6561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2c0ca9-f34b-403c-4d1f-08dad12416d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 08:58:38 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.10 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 27 Nov 2022 07:57:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.10-rc2.gz
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

Linux version:	6.0.10-rc2-ge0b681e38dd4
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
