Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A8E6D7F9C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbjDEOfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238222AbjDEOes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:34:48 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91EE2681;
        Wed,  5 Apr 2023 07:34:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQsgI+Df0mR9z1G93c0X/SVS7B3QA4DDx+APn2cgZUoWsk577SZHTvihk8Du6PiBnH6vjAKbYcvOUma0XQLF1IgA90gZkSAeoPiGEvUD1FkYoUjrAMgFBd421+aIAbgOyvB3XzYUeYx4jORoCUvaxOG8YBpCs4QB5CQuB6C9jVHzI0KOFt4qU7+SSzfqrBG/iGT4fCqoEZZAxioynJwpThu9UsWaK07ZY98i7HznsVtu0Rb07yINMNyCH5Sgo6MrjEqe56RPwoh1oqBiwQSpaN6mmULuWuMc23k2Ye3dceORahiFGBNZNAr6/06bBTm5MKRAFX8bfrrpklCoL4MWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHL8+ZoGtrEuTAbzk3JM6dO1aPac/YTPWFT5J4aE+Qg=;
 b=ZFEBoLoaUY009iEKblUilcrRZQ+9PopA3dPUfvWXy1J65+WQu3ipgoOvOfu0VrlNNe5+OOHqrATvjnwyN5cHR0QSef6CdQZgUnNoAUb67jDCuL00TbGJl7+p6iTPMvW6/DnLQ7U+ofLZg+do6FdI9fOjCe3YXtRakZzNowKRkf1Y5Aped+5KVqI82+BcEnGIM8FGZ+0tKIodP097EbbRK+nL+sVlJMgO2t4JYxjtwkOX6k9h+qHsiB4PRbPYeRepLHASXEBPO2MmuL9ze5uXR1PwTv36AvLN0V6Pg+Lv06oZm8NZiFXRJyDwC+QxvAGd8BYWTuLV7DOPp4DCZlvvYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHL8+ZoGtrEuTAbzk3JM6dO1aPac/YTPWFT5J4aE+Qg=;
 b=Z63BfneSp8aiKxXOy7i9MLYo5S9eZ+UJLWm5fvKYwXieVGbcKf9/fFg5BXwnub8IWhAaQ3oJVc2DqFWqv+ZwXpRXtI8QlXR0fIET7pGWTgYFg7oz+ls5ZKV9Xr05wxK8a+DCUi+rpUE9b2XxhC8KacEg0Kh8gm3Uk9beKhjbx87gW45nMTg+xyDAJZVGeKSbAN9smpamxMx403xCwLwlblN/JyQorK1JBls218Ly+kluAe9ErlcN+0EeD9XyuJBuPK3/ccT1Vg/W5Ka+TNoRFH/ebbtF94v6ihiFeV5jxVEZxo7dHGXeEDa7lZfzbvVu2CwQT33QZESA8m2g9sjbmw==
Received: from BN0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:408:e6::26)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 14:34:40 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::13) by BN0PR03CA0021.outlook.office365.com
 (2603:10b6:408:e6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.44 via Frontend
 Transport; Wed, 5 Apr 2023 14:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.30 via Frontend Transport; Wed, 5 Apr 2023 14:34:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 5 Apr 2023
 07:34:23 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 5 Apr 2023
 07:34:23 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 5 Apr 2023 07:34:23 -0700
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
Subject: Re: [PATCH 6.2 000/187] 6.2.10-rc1 review
In-Reply-To: <20230403140416.015323160@linuxfoundation.org>
References: <20230403140416.015323160@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <faacc09b-f907-42d8-b798-0ac75ab849aa@rnnvmail202.nvidia.com>
Date:   Wed, 5 Apr 2023 07:34:23 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 24652d1f-d7a1-4043-a602-08db35e2e356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPMOVtNJ8T06YcqZYvnE0dG3NvVtTlfom0Zl9cn+ZY60KUzB3hE1tQQyZSVSUWhARe+dC7sHY/BGA8aNmizXO5Zt7Yw/M/UWIrcC1NF03JPw5SgUHy82QdGGeH/2d+J0VF588IIwsdsAqnm/6SSOfCIa755M/MIuMDj9mLJCXNc8eBLfjvauEKXAfpyk3k8mH2uv0+nXFeeX48QMWvfzzXPKSnxXnppLUiylRIdEo6zQwPO/2j/obCFzcrt9fYbDlTHLtGe2A7TbNtSDJ1lqL48Hn6Q7Ycpne4D8TOtbU0YMcPmdwtt1sap2sg/61ggm//ZIuFmQxivgcIARixZ/u928Naox0AUz/6NJef+r/asxZaVhSx9tvhSE73EaP9GFLxSoLwxvsaQyLWzlP5VkPOrTUkx2Jm/tECMnnTVVcdCXyvs4JCquOGJJFLFpAYLReGSUGlGwkAy/bMm0tgl/SnxHgfxs4CT0vCcRRjaEbIXeRgwbFTEvxg2dij2ta8O+eOIRKilrJxxwDLo2MkPxihTR+0DOiDmgTRLoxm1v9MdP84Cvx0/NcV4AYi2SjSHvCjI9+XjeCUuvjtniRQWajjh2qgQVaiuyQWvlFzI5m6m5RxLTtM/+XIObiugB1D4IWIQOaSexLvFLhw0J5AZfQuDw50E+I3LSvdKWvpm5Ym6Agu6miv88xLg8d8iYuXZv9f4EuZJCQn/ocrCf9eHYkCCVQNEL77u+2jegf9cv8pLEfKJaVxoz+9OXas9pjlv3liC9e3VsgVLJok+eeekT+pDZFUfqbx5sxCZk+22z6Kc=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(86362001)(31696002)(82310400005)(2906002)(31686004)(966005)(40480700001)(7636003)(47076005)(336012)(426003)(186003)(26005)(8676002)(70586007)(316002)(70206006)(82740400003)(36860700001)(478600001)(4326008)(6916009)(40460700003)(7416002)(5660300002)(356005)(54906003)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 14:34:39.4013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24652d1f-d7a1-4043-a602-08db35e2e356
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 16:07:25 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.10 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Apr 2023 14:03:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.2:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.2.10-rc1-g6e4466c69e20
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
