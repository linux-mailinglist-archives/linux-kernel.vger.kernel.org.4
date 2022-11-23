Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3E636367
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbiKWPZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbiKWPZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:25:28 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9B3655F;
        Wed, 23 Nov 2022 07:25:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfNKRL1YZ0eAnvfVTf0CaJk3fkOHICEPYLcXlw7K3GIT2BuRp8Kcl5QU48emc29viTdHAjhtlgtVVN5947O49C7niEfKiaQewHR1KtATiQzfHaS890fR38gLWxeJ9q4utTC3CzdO3X6j71VK5Jq1nxqVWDTJgzZjxDEV4qmCDSLxhugHPz7jzYdR3+tdbn5Er5CNwRMYLdRV2gEDSrsGXihsywmBIXhzBy5gnZS/moA05X5I8Y2Tm8XIoMss7OnP8hjsGi42AXlprMeUH2fiqs3ENCZPTT4gRAhuv+AV7hF1GIXC2vrS3vtaDsiOmXdFnqg6C0kyLCE2pAZd2h/hEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQ8D/dyFEIetMFyHlTio+YsLsQWNimeodssFh/YpUPw=;
 b=JNhGAvcpQG0XqabkLd+XAYSNmRPTnbRNyj5vpztEUGALCizMaMdxCUGgx01KAcgId+dZE0svkOmhk6Zts22yd/9XyuEoFIRBHaZF5zCAWoNKRStEHYygLtthxGoKI0BffIIu2LxRlCVR7sJxaQhw7U/cJVgZRrInkzljCTKwvkMjd1gpYScedrfQ4xXMfuD4hzzhogn2/jN6qadh7VzqGoxc7gcN62dsNG0IVncJ6sIpm6xYgKVNQBiZuVRFVIPklOzMu/cEOJvJSmaIfiDbFKmugcv79KtxGCV9Rv7QwRbV+07ghpKXi2DpPxOXwxdmusaRQX6r3K/U/mcBGO4shw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQ8D/dyFEIetMFyHlTio+YsLsQWNimeodssFh/YpUPw=;
 b=p13483hnuCDrvh8YCz40fGZW2yEM2mz6MnIU2WMJNqWI23NChNnUK4GBTql/ozgrJxjdgloKgVaugY7AHwUcRBxSZq0z32SpXnyOq+I9pXzzeQJMDj2Myx6ER3sIlqwUpY8TBofvBcDApRIIq0BbiGUO27blvHwbhMED6WN43IzlVjA3XgFGprbLKjG34DXR0ghDEjzUEvd0xJ6Sc2kcmAxGNFyUL+AA5na1G195uoIwqAZe8w/8uqSTbIK38GAqRZJRK1PN7sPyLT88s3rA7dj6xSbGuY7fP1Jkv/NavLyQ6zU6suFqIOWsUvzCo5FtbfCVrEQIsSAgiufjPdfehQ==
Received: from DM6PR02CA0078.namprd02.prod.outlook.com (2603:10b6:5:1f4::19)
 by BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 15:25:26 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::2d) by DM6PR02CA0078.outlook.office365.com
 (2603:10b6:5:1f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17 via Frontend
 Transport; Wed, 23 Nov 2022 15:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.18 via Frontend Transport; Wed, 23 Nov 2022 15:25:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 23 Nov
 2022 07:25:14 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 23 Nov
 2022 07:25:14 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 23 Nov 2022 07:25:13 -0800
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
Subject: Re: [PATCH 4.14 00/88] 4.14.300-rc1 review
In-Reply-To: <20221123084548.535439312@linuxfoundation.org>
References: <20221123084548.535439312@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <e6d93047-172c-44a7-a9ef-f56bb55c6edc@rnnvmail204.nvidia.com>
Date:   Wed, 23 Nov 2022 07:25:13 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|BL1PR12MB5062:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2685c0-719a-4ac1-237a-08dacd66f223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DftbF4hZgUZdGv0Ium+tXqYCUTbTD7EkoYPH/iS+uHN6D5T+JUGidu4Klt2f4T5rJg8uNeue7WQg8P6IiCpE1irI/Qp1hND4STuM5Y5r07g+XSSFgNy7qVKe3iG62Xj/mOwOHcegwF6iGEj3kLHcuOQVAWrh8nnJbtc5UwqwBl3X3puazaZE4Gmf3/izFFzoegF828POIcp/qcvsnCM2NPxNKXM0RZEwr2ufi8N9kq8U8joV/ZqaaYAlgkFMtoFgrpvO4LOFuzWFAgyQUNUu0W5jM7qS64tQUjE1ZYwkCbNhTQ/RG9Dx8jbcRX/RcyEQpDXATUU70TAo4ebvozlzlNlBvUa1CqLT3rKUVQdidojfmGrU3oyqF5b2YB26mgIeLOgihfxKNrh/SPFnwVGVFd2LuNkoQMRCZokWdL9GJ2zMYfvtKsucv6vHiZO0Da2L/G6Zts33Fu9w9sRdQm0jCT6MgPuQIfmWxrzWRJi3TRETat0GKhQoav8Hi7tGux7Eo+11FRaqcASe1a4CygsCp5q4XuRQswcTT17uybFFPm2DiNHAMUli9yNfvP8GP1Xq9gAaAoa9Yvu10jwFbomo9c0cwDhenM6zia/NT2p5fa4EUDQ/na0RwpVdT8W/SsQLEHGzMnL7Xkz6duvrC8BJesqcPZGsJZwSVMnjrUp6kfU1W8SO1iSX2s6mze6WG2Sxacj54ti7Rqp4sh7frDRALM44HC86II3VdcDpEMTZAQ+PZMttr+nlIU6jySOB5+rSwajws+cEOXdB5F4g5PAj5FA7QlUWdC+tUjfgajHrIiQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(31686004)(31696002)(86362001)(47076005)(82740400003)(7416002)(26005)(5660300002)(336012)(40480700001)(2906002)(186003)(426003)(7636003)(40460700003)(356005)(6916009)(82310400005)(966005)(70586007)(4326008)(70206006)(41300700001)(54906003)(8936002)(8676002)(316002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:25:25.7531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2685c0-719a-4ac1-237a-08dacd66f223
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5062
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 09:49:57 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.300 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Nov 2022 08:45:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.300-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.300-rc1-g7e961be09da0
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
