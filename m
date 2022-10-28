Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB83611039
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJ1L6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiJ1L6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:58:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3397B1D2F62;
        Fri, 28 Oct 2022 04:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFU+iecoO+zog+rdllf7U2yUmTLhFu8kFjlSE2HzwHQkMh8qE1Q4Gw37vPFfGBE9KM97KaEdu5nndoaKZz6Qa2HeXKUCVffPEUubWdglc68L5nU+v4qwUvsg/i3JP4sbQEvwAyeDMkxZSsuAISt33FXZA+tbV87ZFWvL8a1+S99/VmrwlWQ2nbaMdzpS5v/X7QzYAiBQAT3aYPrr7pImNBLMXrtGRsPKUpaAk8RhvDpq4ciSUroLu1cV0DySjDU+63jih5739WyehTBaMp/I/lIKwHrw60uzxX9cJ3iJqSbcxoyf20MjKAzFTsGZtcUEgeNGwnf+1lKaQKANydBj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP66M3LYjbivWP5GUUnpM2WqRExZHtrbsXQ6kdQkDBw=;
 b=ZPUZ/8auRE2Y9eXgbNH3s5QEemhCVbF0IHw2eUkswM1jissG1HPj+0BumQoev34QNyhYFcpLggeMSa3636xwTFQlkiR6yuHG3eFMYY2OLtMUaV8H0+eLwgKiKmI9TwUm0YZEPMjlRzjO7ldid7+g8ItA6lLkkRvjN6UyLsAZ71vMjjfCcZeFo+9O3KwDaMTwgErvRHgUhdZUWzFIHsg8woujAV2/xM4Stnt1iI1VretdjF+/GUIzM1hnmzMZhF05SnH5vfpOg5IAgwHKfPZhloKCZJlXLsQFhCzsnD6AEBHtwL9CJd3YiQfSz1SMybwLvIZHs3VCFU6DaGTYDvopeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP66M3LYjbivWP5GUUnpM2WqRExZHtrbsXQ6kdQkDBw=;
 b=VNI+W/lCCkjmIZJ3+f/kaAPJcQtXmV5GTxN8xboF/1VLEuNsSQiQNydiJrXWeh0W9o29P3Gse74y56W7+/eged3Q6/BltYdbl76dgZLiC99b1PfBVVa+vs4xZcfdG50Rli/8LJP8tYVFgR1SRlEb9cTi83JV8b7JxfFZ1rm1Q7FQ992rJXR0f8zpvQ4fYdliTkZrQ34m+rErGRI8Zu+e7/JBUsAvpFt/4vUrxj3UzpYepaZeXaVamxg1qVqzAyXtiyhzPd03DSDUISxH5npElD4fTrGK/GB4xFfJ3Y5YHgSWyGP5TGjEo+k7H+/u09bYzEGldiddtnYfQ1Q3VBz2+A==
Received: from DS7PR03CA0202.namprd03.prod.outlook.com (2603:10b6:5:3b6::27)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 11:58:43 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::bd) by DS7PR03CA0202.outlook.office365.com
 (2603:10b6:5:3b6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Fri, 28 Oct 2022 11:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 11:58:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 28 Oct
 2022 04:58:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 28 Oct
 2022 04:58:36 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Fri, 28 Oct 2022 04:58:35 -0700
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
Subject: Re: [PATCH 5.4 00/53] 5.4.221-rc1 review
In-Reply-To: <20221027165049.817124510@linuxfoundation.org>
References: <20221027165049.817124510@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <2f70a651-d573-4740-a7f4-9ef5dfead7b1@rnnvmail203.nvidia.com>
Date:   Fri, 28 Oct 2022 04:58:35 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT060:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: af89ad22-1c8f-4476-b4ce-08dab8dbc2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNxa87AvCYILGeAA2YNCvLHbCXN+vz0NzmpxpEx4Od17p+jTp1+qmP33tmeoWtsA1UTCVls7Nal7ivjftX4YiQs8JiNXRAi9+U7wg1+Dys3FvCBBktg60CsuSr2aF+v+ErnNFLTrXN1HSf4omWRL3k769ensk8PF37uEVeMQG7Hcoi4heFCnPG32jyHO/ltLT8XgSs6FLqfTIgBc8CMDpmqwZeS5sRqKl0ux4qfYkDHm1FboktXaKLayxawbqjzj+s5ot8BiSIYEBnG7FYAetlQv2dXPdrE4PHdcXDZg5jeOxcAizUmE/XtsC36TU9CdWr8qlVasz3f3+Glrth6bpFpl1L0/JDkQ064Yrmf32GoyJzaHV5kpRDQ1RYhSPrgicuCORGVdHBCYNvsVA6AS8favEhF1bZ+YBoD0ilJ9km024mFbqxMboWDpLcydEL0ec+Hg5smTJBVoC4bTeQl/8o0EYFX0vNQVDl7djrpWFJu4jdulSfRvrxAxx0lg/JIDaaEdLfjjqSy6nGpyZ10NjWFC1qaQrgAKnpcl4vPAi/A3Vsq14BwmTOFZ+k1Kg/1EP0g+OYLHvKvFvyZlRe0Ierp2rhNFozgX/sJ8aTSL+qd5wtygIDNu/2/3qiqynIscY2vvPB8pXnJKJF7stM2FHqnNYYcaWpdzIek76KjS2bFGxPRg0xYBHWucXNbKjyz5vuLz1Jl3fkTRKa0/8NE44jI9SfHnATzb/h18jctsm1ekgCToTgGDpBg5lGfMnYHyAGkM18Cwxyeh2vTh6Rl9ii6QAnj9iiHpgS0H4VKcfmVXlzDnrRlSzfhWcSkXFl44w8qYY5T2mp9Qi2BH1k3GFpSjcPWSmZklZHKY0HiWYgw=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(426003)(47076005)(7636003)(86362001)(31696002)(356005)(36860700001)(82740400003)(5660300002)(7416002)(2906002)(8676002)(4326008)(70206006)(41300700001)(8936002)(82310400005)(70586007)(40460700003)(26005)(336012)(186003)(316002)(966005)(6916009)(54906003)(478600001)(40480700001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 11:58:42.8861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af89ad22-1c8f-4476-b4ce-08dab8dbc2b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2022 18:55:48 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.221 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Oct 2022 16:50:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.221-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    59 tests:	59 pass, 0 fail

Linux version:	5.4.221-rc1-gf98a212520a5
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
