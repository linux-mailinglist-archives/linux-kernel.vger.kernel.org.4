Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FC372A005
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242148AbjFIQUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242245AbjFIQT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:19:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B9A3A8B;
        Fri,  9 Jun 2023 09:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkkyTq+o1re///MYPRR9LyR5O9MfCth84UU0TsSvef+SyBFNHAJmenMRvcsd47QgEIOZ2RA0fV/3movuXYQydYMMiC9fiiUPQ996kVpmjmc+NUAwvac51AKdXB0juTmgSo2T5ILlT1S/Sy9JMDSuOQMY65p+zbJGdtA9XGdDxCAmdDgz+h558nc13O6oAG/KLI5fbuDRX6znCmKYqGDpxbMG503hogt0EydTHpaSucJwx+Wgj+C9bPYtelVGvaZnPMT5QniucB8PaMOyq07fQkbLK4NTPaK1klvtotFxyvveHyzV7ZrLVDuAyrNGzcM77O9+UlAyycIIyHD7KleSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3GMzWxMBc278OD9+dRqvtuJ33agKiMFVw4P/cV5Gms=;
 b=cGXxulrS6TiGLgBHwpl0ek61SEtu5DV/41DtzQwRZ896/gtua4JPZwlYQLyPKdbSmnXenqFRx3Jt7B8mfwcAvTRzaVz4/4Umn90Xrk5UrOhJY+v+uXTrZgsYnYbCDjGGHBhiU2pQTaoJOcE2LG5eUHotRI0MVCHVYHPAFLrCqtwy0rSECYTaeHR4Vfg09zIJWHoiyLy2Lj6XYZ/b3ivs9fSDr+lQuV5pmSEEqkkRcJ7+qVqWcLJDayCDe9dhF1hpt8oxri9TKE+yvM6ToMu4lMM9NPWLjAxTQYbkVfAlq+Pt7E7cEgobq5BNeZk76SRzQoWfcFyGbP/LWOdEBS5FVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3GMzWxMBc278OD9+dRqvtuJ33agKiMFVw4P/cV5Gms=;
 b=FGSHNJwb/wrZWyclpdnVnY6U+yyj8otLuhG35rSH8dAqUQry9+cjInKsA4eo4shqxUvZc0otX7B9qiBe72PGRzUTyJkbqdkaXBg/LYOsRT+kLgyyXOx8ttsudJLrhGN1wOkvVXHMHUVLovCLO2eyD6pFOQhj1/ZP3HFVR7pcQ9Vlyfr+eUL1sZL6Yh0NhkeZ1IKc26R8fRuboXPvD8KbYehCZ3jYQ+U7QMNyvpM5NjPXonnQ1aeOZQ1NiOO0Y5FTaKPUPedXdqSapI4bbSb+roOnet2dcDjbJdbW8JjdihX3xznNH6uQLXcap98JGZmPxLvbfyrPyzB0RY8VKb5R0w==
Received: from SN6PR08CA0005.namprd08.prod.outlook.com (2603:10b6:805:66::18)
 by SJ0PR12MB5486.namprd12.prod.outlook.com (2603:10b6:a03:3bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 16:19:18 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:805:66:cafe::e3) by SN6PR08CA0005.outlook.office365.com
 (2603:10b6:805:66::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 16:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.24 via Frontend Transport; Fri, 9 Jun 2023 16:19:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 9 Jun 2023
 09:19:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 9 Jun 2023
 09:19:08 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 9 Jun 2023 09:19:07 -0700
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
Subject: Re: [PATCH 6.3 000/285] 6.3.7-rc2 review
In-Reply-To: <20230608175722.489602717@linuxfoundation.org>
References: <20230608175722.489602717@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <bcd00fbe-995f-401b-86c6-b490c4c483ca@rnnvmail204.nvidia.com>
Date:   Fri, 9 Jun 2023 09:19:07 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SJ0PR12MB5486:EE_
X-MS-Office365-Filtering-Correlation-Id: c08f11f8-a6a7-4c1b-4096-08db69054661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBBHCA0d29V9r0BM+m30V64xcoU0/YZLiYrasAjXZF80lshcIzA+Qp/b6k3m9WQUA4ZYsSJ/wbyRzm4EQGY1059GqRl7n6oJNfCbUZSfT0E2wJ9R20HK9QCvuyOwh3N+hj/GQDMyvHbDEbVFqbWpx9G8KbzHN0+MrSHcwsBwTUWbNlbu6PDI9k/ZgyRyom7fregjtce6XCv6utsJmxlg0yS3j8/61r9BSuBaBobk/2S+6fB+9tlKRqi71XA9WabLRNmdX6myUsUuUuMpg2hu5RpcyNcDBmUCEJSSIZMTucXiye3YL4iXpCLkK77c8ynoOYQ96Izh1Le/BJVIGV2VTuPhCRZw+LO7jXLMsBv9Ugo8YjZz3/JP+iDH4YXLLgJ4+P4dVxt0r+ahGcdFu4C81PJsPQnbZ2DygIy5B1Ruua1CdrxXTzDvz+qbCEsA9UoNYQD6BKkGwn912ToeVsQbziVtSa/4/3FCATdss6SjbrGE2gxAEolqxMJ/ACkq8NETNksr8PR9kBHzbPXghn4X2enqmrNIasRh55KO2fb4tAtQmUOiE52b5iejkGENTIMzMf5UGeknkv/S3kSF7ZrBZcS7pc+bx7BWFVlXHL5WnxGcpmVjZJ+El8I0IXU7nITzzFNh1E0Nvkmwxzw4omR6D8woxmWIyuxhIwsJOi4JPRPnMgifkpVJtq0mPqz5A4M2zH0eP6SeIQ0XxGcNrPzSW9ICTSln5pC9z0BwFP62L0cFCrc15dv7s6hQ6YWBau3qdUVbWpa14hHMuQxpx0GvAQ8tp9HWdChrqMANoUJH0JY=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(82310400005)(40460700003)(966005)(26005)(47076005)(426003)(336012)(36860700001)(186003)(31696002)(86362001)(7636003)(356005)(7416002)(82740400003)(41300700001)(54906003)(5660300002)(316002)(8936002)(4326008)(70586007)(6916009)(31686004)(478600001)(70206006)(8676002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 16:19:17.8182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c08f11f8-a6a7-4c1b-4096-08db69054661
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5486
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

On Thu, 08 Jun 2023 20:00:53 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.7 release.
> There are 285 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 10 Jun 2023 17:56:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.7-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.3:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.3.7-rc2-g6f9b6a83bd08
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
