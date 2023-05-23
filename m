Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3CC70DDB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbjEWNlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjEWNlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:41:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61A3FD;
        Tue, 23 May 2023 06:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuipYWbJvPay3cQYkBvGZ2Dv4bTTa9k7RFJT0rg+idmEOGJQTgsXrAx5XUUskfwCck6EqOVk9PLxmWJoreBCyyVHTQY9J0Fgbj8UFZan6lLzYhzL2nJ3bds7zN0e0Kg8m/i1sej40iKIUNRdc0+5pZc1F6TL4LkJkaGRWYtYiNokEsrW22hVYTLxuceTJxEyoguIne8aNLDTt2xv6qP3acP88ptPtYwVbVZp3l8n7Yh8ZBvOyLoaTDmhna9cVSsOI8HCBywEGT68LwJiaIc0CaJ7uRxO/uqZMbsb3Jqwc9tLz5lKsl5ANkHw8vWkWVFUoC9GWvXk8YUEFHezokxtiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lL/+39sSL0eLKPssELX2RPSAM65AoU+TIF1TBawxIHs=;
 b=jwWp8p3K7vp0bP65A16Zfcr5aYLBvhqe2m+xY3z0LkVJeKUgsL7r9o4iUTHXAvnTubyS6aprSQXp/buTIJ7fcmp+lBVZhKpXveWF42tAYDdAqL7SywUKkWA2abPXdzQ0zz32CC0/P6pwbAwnCIbWbSd36M5/lnUNQlNe4oWpJrAblrEtk1n+v8Ncyfj2KAgiZLZHqYyAwZfZEHbbjqgYU0d+YoJ+TO4kQb+WvX31grNYVpGQ8g4cGrNFSjXbFSwejYdj2CNRrIuGs/FWuGFneUbPocayaPWf+9eACVRXPNZMW9O+orm7YdaCF6B+R1zUMIwG0W6dPaneYrggDo10FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lL/+39sSL0eLKPssELX2RPSAM65AoU+TIF1TBawxIHs=;
 b=hQ77EQTgp37QRCanAP1xqfcJCel/YRNrfYRlPmX4bjF2/gvZlFecSwJm26FmWMOB8oY0IWlLvf2gmLyVIEAwfj6hSosA7Xif6EW055Ob7frPn1W40IAgj96pY0Buvn5ypFIYgb6svUcoP/gDPWJ0JWPgdhoaqHDtAYzc6G+AXwlFwxYDL+Jvkuwb6UY/HFs9Ky8VBKC+XSYiVYLlPemO9thh/Zx4ATUBQIijmDHLYCXeYtlF7LYt6qxdjeEZS9ZSdooL75cHuSksaJ4qfgn96gDX00lJDHqPXY2IFteg8Bt1iIpjlsP9nGlxgwd9yw+kjlHhMGrWRrXEP9YXHox/mA==
Received: from DS7PR03CA0321.namprd03.prod.outlook.com (2603:10b6:8:2b::6) by
 MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Tue, 23 May
 2023 13:41:04 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::bf) by DS7PR03CA0321.outlook.office365.com
 (2603:10b6:8:2b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 13:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 13:41:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 23 May 2023
 06:40:53 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 23 May
 2023 06:40:52 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 23 May 2023 06:40:52 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <linux-tegra@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 6.1 000/292] 6.1.30-rc1 review
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <2a7f7329-a5bb-4bc0-8eb1-c4f0348659d4@rnnvmail202.nvidia.com>
Date:   Tue, 23 May 2023 06:40:52 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ea8b19-6dbe-435d-33d5-08db5b935a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NqfpePHQc0hmb4u/bTTbFp7vyYMad7v1goqX+gOVNd/QElr8SVX2veunH1IWgCyotB/1lwk0wr4hbWdatt/bJj7d5h2F7swso6yebkLnHxdLFo0dro37G+AmxnpT3eeeWQ+15bdeZ4ihwiwoZxbDszDbWrJ3lKv3uTbc6Lo67PiESCw8GrMA6VQZl6g5YVnlfgOSKPTI5gipNP2Uybh6n09yWFXHQN+y3srjCyT5u2kch8nK6Z46tJx9s2fpJli4IDw3hzHPhc4Y3AkLfLi7sRcuc9RtGmFZ4u2Fa5ssbBqHNqXhLr4cDy61v3ZQQE0Cj4jETaFtm7yuAwLbvJeZZv/R61kjdA0TmOFL8aSGz7BEb40x0IVUcvYPlGC2QwVgVfDISXTLmiSEZU5hdjKGyILi8mUPxO8J14zytB0GJPl14Uu2OG5s3RG9lcqvobihJdI9QU55VlBPA5UZGkLW+4QU0WYIX2ZJ4MH69HJeN3KJ97p16Wm0STT/jrd3trbQn6mmb3wKWatDMxf/VpdxtG4KHPiQ+/xzoJ35Vao6dIhiAFU/r8A2ir9rMUva2CdBNh3mnRseWhia3hIRbkKnpkhCcwQq4iO2oMM0jrdbwW2m9zSXVEDEFpOZUvmoDZv4RF06SwiUhbQassHwb3+KT0hpOMYxmlbF5EmXPcy9siaIP68BAWPzxOxh7gnfsX2Ck1VhbZ27+Zz7yD7zfO7H0ZruyplFXdmeFFpr+aR/wRaIRd6Ot6b3il7DDl+tePy4OIfzfD0vO6GKkU0BVPeg8j4XpkRv8225cQ7rkrC9OmA=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(31686004)(316002)(70586007)(966005)(4326008)(478600001)(70206006)(54906003)(6916009)(41300700001)(31696002)(426003)(47076005)(186003)(26005)(36860700001)(86362001)(8936002)(82310400005)(40480700001)(8676002)(7416002)(7636003)(336012)(356005)(82740400003)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 13:41:03.6815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ea8b19-6dbe-435d-33d5-08db5b935a69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999
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

On Mon, 22 May 2023 20:05:57 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.30 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.30-rc1.gz
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

Linux version:	6.1.30-rc1-ge00a3d96f756
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
