Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4927159C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjE3JTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjE3JTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:19:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD18CD;
        Tue, 30 May 2023 02:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJO45P9kemF2ypCl5WEBbJ6bPtZ8hxyqLfTcbjccLRr0HtGz62qDbenwnhcg0BKleClwJcebSyvLrsHu250RxQx+jFQPg92/31JCV5VP8Suz9xb1oSemzvQHVdeE6X/c5gPp/ALsqebiLGQeb7N1WfCpRxT27ytkyK57/n8QMT58EYEBoRPoVxdFY/q3ALpDyqPMfEEWmHlm9qXYJOgP3Ri2TUkW66mi3XKctotILryk0L5EVUz/n1DORzeEYciFP2MHbOKaewOB2f7wlVAN6AWQC8GkZYW4nL4hjkMaDfR6q7qs4ZG2UhaVeBGw9qSkGQFqmel0A0VgxlrBQ6LZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4R8akzGxsYKxPOUuz4GNWTOyIG0ICic2pr0gOj5DLA=;
 b=iaE+GGnkv0QqarIJn31fk6hdhq0X4NF3xQJ5wO+IItyBUBFwgM+6rQVIMqSYKEnp9rm2gtEdsF2M1Aex8G+k0RD2SGzrrQ2MVODQ2iBpRecL6y+v1XX1i4p7UaCSTr5rjcL79WvJE3c//dMZSyJxA/drW74MKqTlxFe2R7lB9WCwtm96RtVF7v3ieqjF1EV+f/QbRmvbvkG87B3fP2C0tXdY0l5ZDcmp2WWWHfQkFIfHIc8oqMJeL+xOe3S3wosEiaQ+sOZ8ibcLhYsZnRr058ZkF+XE7iGs/cyFd4D55rD4jc4rNjzJ/7h1brUOvKpvfopf7KJzfE34reKzfXC00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4R8akzGxsYKxPOUuz4GNWTOyIG0ICic2pr0gOj5DLA=;
 b=oihR05cL01CFko4zGJkLvCg6KHxJNT/ytNmbONbohtLanuqa1Cp/6a1/DBm0xMMmrBJ10KhRzQtzlisi7gVj8tZPjspxf3bgtss3dlZvHZp3mmqH7ZsDRFgd3oqFhru0dkmXT5H9rTtAqu6svpLTaIg6BJvmBB84Hm3puq4YP0hRlNlPgifUCXQm0ovP84yqzT5yKeW7w+7qPgNmZB7Pm0deSsb4yrVLC+1sc7bDAhEU9xfGBIUhIOmbnF0la6gA3F5UKvUB9WZ1q1gGLxfCCTTIkRB/CSO0zuLAqgi36mGTjLDbS2SBXjPhR9of8X+yJKEXuiB/GJffPyj7u1ieLg==
Received: from DM6PR03CA0004.namprd03.prod.outlook.com (2603:10b6:5:40::17) by
 SN7PR12MB7179.namprd12.prod.outlook.com (2603:10b6:806:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 09:19:11 +0000
Received: from DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::d6) by DM6PR03CA0004.outlook.office365.com
 (2603:10b6:5:40::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 09:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT077.mail.protection.outlook.com (10.13.173.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 09:19:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 30 May 2023
 02:19:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 30 May
 2023 02:19:02 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 30 May 2023 02:19:02 -0700
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
Subject: Re: [PATCH 4.14 00/86] 4.14.316-rc1 review
In-Reply-To: <20230528190828.564682883@linuxfoundation.org>
References: <20230528190828.564682883@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <f3147d7d-4654-4af7-8b3b-47bc4f1fd23d@rnnvmail204.nvidia.com>
Date:   Tue, 30 May 2023 02:19:02 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT077:EE_|SN7PR12MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5c23d3-63ea-4ad4-6d11-08db60eeede2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBfcHK24hUb/04NKuAhauyLUDfezblzlQl443SgusbCqzNtZ22v8vf9a2g/kZHovnmkHxXkMUOr1yGx3Am0Racy2IKCtzzZ0WuWBSChLZgaGpGn0kGiBjbFKIW5t0s8wo4cjHmUpUy1LILnWBOiGcXniMN6wph0hQDLcflZdXuSjrjuj40TKhCkYA9Ux/qpxgFx6ccwpYU6PEN4ED4soPvb/UKe4h03ggMykA5eo1CIqHuJqTobYG5hh52thtvkU5wRNI1w7gMu5lnvhNZWkVEEhF3Ew37EuFDEHnP6w6U4EpduPqESgtDrej4zUGe82tvAOreDg4LAcUlN9wzRpi9m4AsfaKkENGi5Gj1PW2g3aVBsTJ1HYTA/sMrGKwvW0grIa2dp6E45q2jN7nqYpwzVRHjoqBq8AaChnYAM6f91gvmwZu6dHWfLbhHafI1Whli2XLUda8tCWZzDkKQ3fubXf+8i663CSEC/szNHUc27GH9oMBBpnOtr4eqV5Kj1d8FJdPN0Ui7xAcy5xbwLfxr5G+ijlR+OqhBHog2Q0yLWyKL18tQbRwB6CEEVosOKoxqm4WuiYjOaVDmKUgOdGHZ5Ova/V/EqQx/Pvoi0EuH6uu7UAAmVPqAcHi5ZbiNmI8PE35TLXlvPphy6vHe5PhX/eTrgVjUrD9ebouVsl9aECjRRmgVeS2VdHu9Lpdbdst2uyQTa3ZU7F0tVmh7NA/XWs6jkyMkC/7T6fV8Kj9jdCg0O+TqgLdLiCo4X3i7Uh0fc7bzdqUxOA+zadFmBWIkJhC47LTB/dVyeLFnLYeYk=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(2906002)(186003)(26005)(31686004)(36860700001)(5660300002)(8676002)(8936002)(54906003)(7636003)(82740400003)(356005)(47076005)(426003)(336012)(966005)(86362001)(478600001)(82310400005)(31696002)(41300700001)(316002)(4326008)(70206006)(70586007)(7416002)(6916009)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 09:19:11.1016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5c23d3-63ea-4ad4-6d11-08db60eeede2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7179
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

On Sun, 28 May 2023 20:09:34 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.316 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.316-rc1.gz
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

Linux version:	4.14.316-rc1-g102232d7564c
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
