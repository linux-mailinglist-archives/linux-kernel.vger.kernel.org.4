Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37761607A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiKBKHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiKBKHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:07:16 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F32024087;
        Wed,  2 Nov 2022 03:07:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeVRN6VD3DeR004IRtAghayLtzyGlWnSYdpg+JZ467UV+ON6EcoQYXG30NiUM/TdCfYFIV0JaPIwmXS5ekTHCl+B2AT3rtpvwG1yfnsk1K/77RfednPOcmhIp326dsnrx49LFg2abpjFCNeL4S5mTE9xsLr6evmhEsSV3mS1gCnx4QwIdepvCmzLDCo1iExGiO/oXP4yDbWKaoMD9YCiFh1nEmqapFwVkYS8yA93sWsk2R7Fo/HAtdAg3bF55yMdeAmp76EzdNUyvDMByGbyUJUYRZp3unSe3H9V5kIGC/p5rA2i+W4jKMUYWKpd5zLAhBQfX9mn6TVTS1KJjTukyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Emf5xHFLK+zQE7eN2G8DK7kVKWibZUpue03WWBAEYjI=;
 b=Zc3cmCA6ZPXNPiWri4HDD1ZzzBDwTZ1f0oYzlPvas5P0ZTxCnDcL8rPl6ii3CRBveKE32qMqGPfLrA9C0CeZ6xbPLmgWBaUeF5tHQ5I1ggJw+npzlUamk4RPp1Cya8BAe36Zq71ECgsExa9/LkzSWC6gAMpDyWLakI7v+K9qz5fVmt7cDoXL1gGdrzdfJCDMcnDiRmfrcB9w26EqRyLMnqpmcCHuW9JwwqEW+e3Ryy4n6BxWXU00rCR0RZvj7RrQ/dtpHE+0pn/b3S0FxOAhOYYQ21zq3l762a/cgVhDOVF/K3osbo9VAd7Tgp+8MAc5GmeJXqGBWNjxUBtg/ydPdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Emf5xHFLK+zQE7eN2G8DK7kVKWibZUpue03WWBAEYjI=;
 b=Ws1uB/YzWI7UyyauB+nzRrPDxGCxbmBoFdW/PXyTCSGhacplU6t0yrZHCdHg2B/HwWaxubrMjJ1+gtSvOvWkqzoAYizrHZzw0QkDX7K2yL1dMWZprv2GwzxzRHkYRUSuBUVirEw3M56Ybiex8wiE3WIfXvq1m/mu8Ie+X1NBTSrQcT+zoOgJLGM5Ol5Xg+vTXrjVWx7uSyXc+HO1vfbeoBXZMsJ5B8wU4lwsS3X7Fbc0xCnyLpx3RYJIP2/codCwaWbtyw/uNtahv8I85oHT0ozr11uIYHmshkjRETvOYFYwdGVJANf8PxO/59g21UCofqSoCwlV3wLfBqdbP83xyQ==
Received: from DS7PR03CA0217.namprd03.prod.outlook.com (2603:10b6:5:3ba::12)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Wed, 2 Nov
 2022 10:07:13 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::f0) by DS7PR03CA0217.outlook.office365.com
 (2603:10b6:5:3ba::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Wed, 2 Nov 2022 10:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 10:07:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 2 Nov 2022
 03:07:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 2 Nov 2022
 03:07:02 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Wed, 2 Nov 2022 03:07:02 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.19 00/78] 4.19.264-rc1 review
In-Reply-To: <20221102022052.895556444@linuxfoundation.org>
References: <20221102022052.895556444@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <9f115124-342f-4718-985b-d304609ccd2e@rnnvmail205.nvidia.com>
Date:   Wed, 2 Nov 2022 03:07:02 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 27381310-b823-4fbc-09c8-08dabcba0352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aX0fC7ohcXsUJVRwD3FaZifGGGlusJPG/coGrR7XKDWAJvH+p0GcDxikA1//1jD+RPo8LFdrFP+4AgTiuiiheXX6dK6U0iiuhDYLx1kxKUYA3SDsuIqzuicYqqcU1qUv1Lwpud+xC+/vrDk5lJTRGV3kZUG118uOVz7apDPEbCLLpiXuwsftVrQ7rsnFg/UNGRDIKvPnX4N0LaiX/bdI0T7VCutpih6I7d6QAAbH6HFx3qFWHlRsZIFMHYaayTCSYXV6/UrfRiuI7e0Ps33QLcV4196xOjcmOp5KUrZi2AV/yrRU8eFTPtX8CRLImLtCUGND1bKIkRH5ddT6tcIJnc8VkIedhDdcernUPuUp6iuuafpsTSSLFb8i9RhWZVxVZNjPoE3UQjjJU97EVULarf2Rbw4gFa7/une8SQuph0wsCNZ+sNqEi5zeENUgBMS/WkJIPqHwKYnrdBdgcRXkJ4EwnQF/WLeAidfgQd1R2EzNmx3VCXOFs6f+drVj9Hvmsr5luoev2gtKGeCiNOG3oo7XsjJCRTIVnY4hdxkzoWCRki5RfmgJ9K5nMQ0vQ4TbYB1ACs6GAVxdLZI+a6efymS3ulNUC2xd/VBZj+dThBH5RrmrhNByZeo7YK+VMgrgCY4dpx2+SYL6yCSj5NpdBo+0TIQmgBTvgq1Y63CXk5vEOdeZ1LrDhgQP11SVnJ/nBJjbqFngfMx1Cr/NbMSnoazdqHkDal7PNsHCeSrrtB57EZ+6Ee55SUgqBwoQI1Xc/xx9bJYj2GHjxrfT+v3lrn/4iYTSdbaQRalNLuHGEnTfgDqb5RhDxnFvKsUiWHuA8V0z3uzefABdb2YkMtPKpfzpcRK/p8U9w8jid9YlHZI=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(40460700003)(82310400005)(40480700001)(41300700001)(31696002)(6916009)(54906003)(47076005)(316002)(356005)(8936002)(31686004)(82740400003)(426003)(70586007)(7636003)(5660300002)(8676002)(4326008)(336012)(70206006)(26005)(966005)(36860700001)(2906002)(478600001)(86362001)(186003)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 10:07:13.0431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27381310-b823-4fbc-09c8-08dabcba0352
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Nov 2022 03:33:45 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.264 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Nov 2022 02:20:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.264-rc1.gz
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

Linux version:	4.19.264-rc1-g0b4109336122
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
