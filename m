Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35146B506F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjCJS6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjCJS6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:58:18 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC60650F97;
        Fri, 10 Mar 2023 10:58:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFksC6Mq2Pe/tDrgGPXQGal4q0qHOo5WgrqIU0RuVl0wx8r4h4m5h4YLYop/7DYOApVq76RRr2MuNKTsCxzZZA0OVsWPsOxpLhaKLfunEd0RkbvfQ9Sc7xYd5sbSudB8m0oB8S9an6hcmTsX1hWvy39Gh/MS9xVnjZJQOzsAOlSHoyPvm0qHRxXiF+5x5pNqk0eubBEip5PR4qn9xymzhDFuP0+NRnO2XqzZS2J6fUaOk1irAQQth/1WjgbFnk6vQhS+gENGtiewG1Id0f7u4xEV+5IMy3TeZcOYh/rVzUycwn3NvDwF2Ej1jeWPG7AsplImJu3hqx1HeStjHAqo8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpZ3st1h+VgJ7KQtQFwcfcNP4Fy7wCibsK3lwkw/L8k=;
 b=YoE2FxYd8kY6ADGA8DRZGzcAymc0WiIQPkyVTK1v5jKxad9b0XvULjuDU7a4QEqGT9qJ8FCONGBu2ldH8LM4h51LAXiD5SNM8IWt23YI2PMMcpf8l5EVKcbxJYnL3oAmGTvQ9+LJqEO8HCbm6ubDXAGcOe0JNG69KwRiTMI01aRCm8kwb8ys7cx8BzzuVMVKqMAbUMUopkBbY0lKMI4Pi0E6QB6LZcFB+1yQHTLBxN4FBwFyWTOveLdyQdAnGO2X+d0gcGtjICZRU3ymVv91uqYj5MvKhzMmVuTUveQJKCMrGPKW55/Uzh6ZzZnT5y3FI2gWTiSaqr+TNZZsZLvRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpZ3st1h+VgJ7KQtQFwcfcNP4Fy7wCibsK3lwkw/L8k=;
 b=lsslemZ4fAcj+VmMtnOdIN8t0Vt1wgjrflg9xQ0+zNLkw6JFpvlC/O/msIH8roVW+BNcHSFJY2fhCemR50ULya+905mwnGM2q9+nnhhhVLkE/llg9qvdMECf165rRYLgHegpxIQ5p986Nv/GWPe0lGOwjr4saWfpq0U/cP8TV7RpPhWECYsGAPEgDCSmbDGaB7yJu0gP4muoUvsts93a1jorzWTIomlyNyy3IIWIWDvGGH5HEsaUh0OwMNuTDqC7E/8rV++bNcLZVHgqvVtWP5KpXk/U/h6OVJP7zuwxLOgew9VctQeIxJXSB1B7lz9yV1dC95s5qVUtMnqUMSvr8A==
Received: from BN9PR03CA0875.namprd03.prod.outlook.com (2603:10b6:408:13c::10)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 18:58:03 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::ad) by BN9PR03CA0875.outlook.office365.com
 (2603:10b6:408:13c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 18:58:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 18:58:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 10:57:51 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 10 Mar
 2023 10:57:51 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 10:57:51 -0800
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
Subject: Re: [PATCH 4.19 000/252] 4.19.276-rc1 review
In-Reply-To: <20230310133718.803482157@linuxfoundation.org>
References: <20230310133718.803482157@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <d2de4883-b2b1-4010-86db-965ce7494180@rnnvmail202.nvidia.com>
Date:   Fri, 10 Mar 2023 10:57:51 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|MW6PR12MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 603df7a9-2e03-4e63-6c7f-08db21996031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j7xNDc7yN0bRiRDY6dh1JcunwyX0lC3VG8HDEfjgSUq4hDcXCJywKkpXGtXpbdRJla0Pc++9fWZCHxVDK2A/zZXDHYBSgZ1i+gCrJ5S3RBU0f74WAuTDN6lUFLRyaxnyQfasqZozK4F57xKZ9Wu/uDgexhuw+DiVWZ5g0mZT9jKte8LuHtwBUvbO5gJgVjmK1LeUWeDXsJWnSEEewb64uvbbyvV1oeBQcAqpdCBaNN+Fe2f11fnVj7G83V7EN6gXR0wPnx6AeDrNmK3JwVIg7qh9Fq3jF+Yt+yl5LLssrzwg4QK2x7DqQf338PeeUhH9OSQ/OTSLlSCRdtVtrNkhD7E8D4mf2SxoWtT+LZXOJT/cnAhaq67kOst/WcpE4lhz7zpt46CWqFGvd5UjQR4+kp6gW3G9fQYhtmMhSt0/Iusz8WPGgFU+TAi0fTQRkCoWhuJhUlWVDmcYEmhdHRG+zOZ4aAOBGejjwZOtupEANB6Naz2TQ5MMBTEmuPbItmkar40jDpS0jpT4a/YEEEOYxSyk+X4L3JFA1ipMdBth2sQ+NRN2UuX3eUAkACD/I6S++DAiPBtxVW6jitZ4p2sCrOxIMtkCS+nbOzeMMX2AxwzML9zCTGKMnPqFMIki2obIShdh+lQ4XFFvKDlrBJRzS3Z9JjqcnpRrcWG55SSSKZHdNUcHkpdSkjiHlZwYOWBzChSBc9ESzavO6kYgHqp50wQ5UBvpae/X+ZV/GfVDkcLVPjxF0WKvDMPUD5DTGmtqx7mJ/xhmbMdqFynN7IwjMEMZIokid6InliSCzhz6eMQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(46966006)(40470700004)(36840700001)(47076005)(426003)(31696002)(31686004)(336012)(54906003)(40460700003)(2906002)(40480700001)(356005)(86362001)(36860700001)(186003)(7636003)(26005)(82740400003)(82310400005)(7416002)(5660300002)(316002)(478600001)(966005)(4326008)(8936002)(6916009)(41300700001)(70586007)(70206006)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 18:58:02.8590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 603df7a9-2e03-4e63-6c7f-08db21996031
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 14:36:10 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.276 release.
> There are 252 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Mar 2023 13:36:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.276-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    22 boots:	22 pass, 0 fail
    40 tests:	40 pass, 0 fail

Linux version:	4.19.276-rc1-g70b2ca70b378
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
