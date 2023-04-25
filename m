Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044406EE09E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjDYKr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjDYKrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:47:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D70A13C38;
        Tue, 25 Apr 2023 03:47:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmUmUODAmVcn3t+h4GiOkcVaJ4oXpsvYzvgzhTiTtkKF9x8i6Z3B9m7Ht0nrU+4dt1dND/KPIPo3XfhsjOoRTxifFeuoHDOG/4rXTL46HZBxJkr3CLXBrBi/HopTJG0BHYgifI9YH/FRV3mq+8k0+T57xHxeHGlxlW2YwytjVjWNG7aHF+SoXx/fzRyI6ju3ed5esxGNZg6+5Bi0I58OMucuE0j94F24ojQqrJueMdcmGsW6oSmTnMY4VgLvYRu/uQLP1vT1U5tgKW/E1Ulhhm+mBZEeif5JDP7daljcU48fqs8oLNwJlwVJCy1DokWtqhcYiLdFyxHq773xnbzsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vB4y/WKTJACB506PGnFVQhsKMeVamHJjveYfJLv0GDc=;
 b=hYvEd0jZ4xcELNcJtSG7wqnxWvhVNfsHl/pmGQOeoJ8aWvtBpUE0mK+vbIFkYtfNMoRgifdjnK+WhkOhTBJ2xH/mf9xeR7CUhd3QBJmv77fXQi/yjppT7ejc7VIgzLNYXoYVAgVKvp/KU5I02eE3pGPv277TrpzWuGAxBWDrq5pVHve1xCfnVmueTJofYwy+Y/EcTqAOwii6YMI1DJIYz1aX74WkxfzPjSkyyotNzUXqP3U4mioAlsAYTdmV4tM+mjRfJQhUTOv56sMijAX3Djayw44TO05MQOvj3/BZE+96APKWbd3FWkXw46CuH+TPxa+BwSZe5Wp9n9Gp+1PxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vB4y/WKTJACB506PGnFVQhsKMeVamHJjveYfJLv0GDc=;
 b=SC2w0KcYwyq3tTm8E5mG2VdYXmjXvPbRmx4oUBllZ+iUmLiigPmSj+vL99ZFmnMMmpTNnJo+B2030VurpcxE4IaBlIAedZ2SExA5VJ/3MbwpXit4bwhkvwVF55you6ZrG1OFzRe8yGnfSJMpI5WEB66cFieN8Evre1J4qJNoypYLKlVcCMIhrNfY+CbTpekk72Y+ngOcNciT6y7gT3ocVKWX7xKTQva1NmW4+dQIrJ/QTfgwo92/AZxLsyKuJAUPdMJZoPEqgpX77lcN5537Z/EQcZ0ioaZBoAuVwlqu6KThU4yiyrFBpO6C0XhdCE2raETmTGg076MmgE4Z951NXw==
Received: from BN9PR03CA0775.namprd03.prod.outlook.com (2603:10b6:408:13a::30)
 by CH2PR12MB5003.namprd12.prod.outlook.com (2603:10b6:610:68::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 10:46:01 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::80) by BN9PR03CA0775.outlook.office365.com
 (2603:10b6:408:13a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Tue, 25 Apr 2023 10:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.15 via Frontend Transport; Tue, 25 Apr 2023 10:46:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Apr 2023
 03:45:40 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 25 Apr
 2023 03:45:40 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 25 Apr 2023 03:45:40 -0700
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
Subject: Re: [PATCH 6.1 00/98] 6.1.26-rc1 review
In-Reply-To: <20230424131133.829259077@linuxfoundation.org>
References: <20230424131133.829259077@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <ba53ed52-7fb7-4c17-aa00-e1e6a4c5bb9d@rnnvmail205.nvidia.com>
Date:   Tue, 25 Apr 2023 03:45:40 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|CH2PR12MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: 8197b990-5cd1-422d-7c0f-08db457a42a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfIoTKinRmeJU8yey1J454NrGKF3lME5pK9pmxE/ofZDMIdmJM8pj377cYFu1TtR1/ypyREqDmB8dWXoYBs1xIxGc7rA0oKtgOS59/2XEJQzwhto6fX2SZNQOoKK3wgGn1X/GdOUCMsd8FVoVFBmMCfqPo2BR71qSsts+W74m5wrgIZresixoD+/mcJJzVhS0AUeGYzmlcIWytu8ocerUFx/U4qTxk8JaDV2CO1yWRx4lDpglUGA4DKg7pC1hPc2XZvicgVaVcNPRF8fJa0cybZFnppJ6oZ4p7ZbMJj8hxJ/nFHwSVcxOl02bhZb6VMy+AW0OafDoCANSe8dN/MAZU8C0+0XoBwSt/bZ4zrwRud6xBCUQAPOXbSsatyFGkblNeBKc1lqCHncJ6uJD43gzVI4jpaGtmKmi9gFXW2S9MMQrcEVc4l0XMnQ8iyceo0HiVzyj2mMAGmevSMXsJTusD8Q2b/PPM7ryJUacJY6bfHV13/8s2Ad4ENE2SzDQWS6kHGZXg2NCowdtIgOkunJmcXTFu1WBVJMbu6hkmOWHaYV8zT707dpEIITI9NIjBQQrl1jWczhg/XnPzs2/W0c4/v6vA62SXUdIOXrGLghqRA+goYYMCFcy2Kdvgjzf+uKCPWvXwfdDQ4Bs6GY/dyUUvldbKHPlh3jjynX2IOFPWpMLjvG0sNTnZc/VYESeqLCj8oA+biT/00jzulV4AgpTLDsprcp902NFT3R7KMKA2IaHckpzXWy7Yc2FGWJBifP
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(8676002)(31686004)(54906003)(7416002)(8936002)(478600001)(31696002)(70206006)(6916009)(86362001)(70586007)(82310400005)(41300700001)(2906002)(316002)(4326008)(5660300002)(966005)(26005)(186003)(47076005)(82740400003)(7636003)(356005)(40460700003)(336012)(426003)(40480700001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 10:46:00.7690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8197b990-5cd1-422d-7c0f-08db457a42a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5003
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

On Mon, 24 Apr 2023 15:16:23 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.26 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Apr 2023 13:11:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.26-rc1.gz
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

Linux version:	6.1.26-rc1-ge4ff6ff54dea
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
