Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5100272DCB1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241409AbjFMIis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237969AbjFMIii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:38:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C9C10E6;
        Tue, 13 Jun 2023 01:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHKC+61dUoBo2bYVzoaCS2uVexGVspRlKhN+hYV83R5E5lwIvZhIzttas4WbFM0mFSw1VK5rOH/bEeKhzKpRDvJhCOH8fK/qw4JHcxB1kqtQ1iC53NWkaofk9pqI2oBW7aD662U7s49xuzynZ1Ak7XIVcHKEZ6P5fY/hHBmk5kJaTZ/wHXPRye2qkCK1Ep4lr4sSNTccatlmaWbVuzChs00X1JBtDsHyz+S4S3uuW/9YrjkafQnnI0/0LbUefcnjLMJjhR91dHvk4bkP2pmLDIjQmtDjjY6+culb2yEJqTAXHhhzGZxJ9euSgUVLjA7xc0DIlGQgbkH6m/SDnYjEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JgDJxKBa94pzp4LHZvP3Dcx4wnV7AAXXZocwPPH2Ag=;
 b=KEkrIy1jHg009+WaF+mFHJqmrjt2T0Eyp8iQkJE/kg8fdbcc3DmADZmg88FC+N4QOyaLcrsN9A9XQKnixwM/UXKA6ROyAUJj/YSre8dh/E9x4GXgfPBmfUzuKMBC3dh1kuBySVP8q4Fe6a72aVrtSeg1H/hkkTLtSppIxHcpcimFVF/HA96yDsMdJS2lHBJzLlnts1frwpmi77z/5IU21pF0p7NS1RiM7XBcqD37P/J8f4QzKqn+ece9/361RFpwCvFLfmIMY8SR3nz8lvUvCl0K3x0N06KH/yPfnTRYcdGLikonVgImA2wTCuBknI0YJNlsqFiLX+ibTtzZ27wS1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JgDJxKBa94pzp4LHZvP3Dcx4wnV7AAXXZocwPPH2Ag=;
 b=PXOVotgRRkqywQQji/rCs/KDcymZXl4+lv3sDibwjouEe6+tljzxoDkhT3VCxC6uoBPFrOL79b9BwyBXjI7n6wIqlT4kb+RAkpaIgnLDvzN57cGCVwqQO+r2kowhnJ1HNxC8fJj6/VFg1bc+lx8bb4SdlPo2UnNhWXY9J3PxVHnW7y8OJkZmL0kJN7b8QNzqqrFEPLlZmS7xhOQgpssIw/Rs++w3DcGMeuPGURdnqVTF+ReZx25GnPfM1rf4etxGK9FEjoeUQc5i/UpMJzmzZGmRapCMxYvWcqRBcigYKGhIEWVQ6zG7clVkKMnIqkkWASOG/Sr/cCjXPIg8PyP4Ew==
Received: from CY5PR19CA0108.namprd19.prod.outlook.com (2603:10b6:930:83::27)
 by MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 08:38:30 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:83:cafe::a3) by CY5PR19CA0108.outlook.office365.com
 (2603:10b6:930:83::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 08:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 08:38:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 13 Jun 2023
 01:38:21 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 13 Jun
 2023 01:38:21 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 13 Jun 2023 01:38:20 -0700
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
Subject: Re: [PATCH 4.14 00/21] 4.14.318-rc1 review
In-Reply-To: <20230612101651.048240731@linuxfoundation.org>
References: <20230612101651.048240731@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <d566df81-a477-4794-9c2c-bde9f43e335b@rnnvmail201.nvidia.com>
Date:   Tue, 13 Jun 2023 01:38:20 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: acc2eb56-87c8-49a0-94e7-08db6be99064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pbvDuvUvA39Vd5RGBOMNQTkGYPvBwp8KqbFrcyGOos9+vrTyj7RPuv6CMN1xw2KlwvRDI1tCssxZTtbDl+NRcvIDpWI1+JiI0m7hUAD1Oou2mv/Ez4DTkp5MpGdNmW0Yxl7xijx5xeft4a3huhTAkJle8lxidP/X8shNxLCY27xXiGX7m7c56/4y8YkzUzDhcU7owu75deiGM3naO5WjARgO3P1jTeRJ5k+LIHOCjXXW+6AiD0MGpM4xHo0dWFk9WCHQ/+wsjrYTy1w6RleTtWveFKlMERQIbwpxNCf7uT1EwjqPOTs8JTUW69xPBSFwIapC90SiRX/KAwpYPq8YQ/DmlHFMfVV/relYieW9HuBPoFxHjnYcJPSPG7KaAdxcPMAlnvRw94cteewgkpr+oIK7goYgrFlXpC4LjI+2QvqK4O1v1k9xTV8kt4Pr7ikHDROghvDcaOdgzsLlOLfOxxgtcyLW2S97ubK+yAAOgZv7CfjJnmmY2Jl2nIWdN9sooUCl+RHHNtnhYjySO548mK4jJOBTntkILqvXWEc6+qxe4LqDQ/5Sq/rWhkM10pGrNzl2Ne5/AxQLbdcxDy8/64Ct+3wk8QU6wOjRplN6l4Gx10+ZGKseHITKfR/+5C/So4iYoQeEcUFRKgQiNfNqhbqhbxmeiCwJmIboetM7Hjwe/B4RQ6evbU+N13wWp0rz6gd2aSPXtJma4pVBMd6Mhb39PLq9W5RVXvXJZ7U1lJbun+uZwJwoI0h2iETIwH0RjmS3KplE25FF4yKtqgT5DQhaXdEZYQrA7AsZHB3Ih4=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(6916009)(4326008)(316002)(7416002)(41300700001)(31686004)(70206006)(70586007)(186003)(54906003)(2906002)(478600001)(8676002)(8936002)(5660300002)(966005)(40460700003)(356005)(7636003)(82740400003)(36860700001)(26005)(40480700001)(426003)(336012)(47076005)(86362001)(82310400005)(31696002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 08:38:29.5870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acc2eb56-87c8-49a0-94e7-08db6be99064
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924
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

On Mon, 12 Jun 2023 12:25:55 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.318 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.318-rc1.gz
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

Linux version:	4.14.318-rc1-g6958cbc0ef5c
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
