Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD85167B3C2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjAYN7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbjAYN73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:59:29 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57E646167;
        Wed, 25 Jan 2023 05:59:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnBejNmxhmaKoDMZQNOPVEZbHsVwfu3zfmeGhruGuny7VgeUKT/6EW0PBbINyuspLMD0eGscFYzQBp6cPwvRXTQRsiXZCi/AfNYQWS+hu9FsQ6uOhwACVrmQQ0Lr7fn90amu5eg6sC/j9/Wd1GByG/Y2owQXUyVoqhQe8aKeYtPntE32y0xyJi3R0UAC5PWFo+Bkmr9Az8+hpLRbAABlKU4Gei9rrS5QR5pfvnkauTHQQOqYMerVPlV246Fv1z0cRh+bX8ydUNYJeLr5qRJ6S7S2mWIFSA4ptzuaxSThXJovTmy1YD9Td2VspGxWgXt35N7C/+2F3pSxJbO71QnbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0C92cg69NYaHSmZk+tOYWVfykMcPe+MU6akvrHPjmA=;
 b=X6xMaYeSCpZqSalGGqY31B65V3m3gngNOOnFNdM9rEdSGEFfB9bQXPFMdPmAeFA/M9r34mlunFkXjIkVcIi6WdgPexyFWEERteck4u/LRhRbxatxkWAEhlVGUVm8sb10Mhm5OxUpENcFbngCWIrb87+d1xqBgsasqbFAnAMM/aDEPjBjfEgf+MW3cnDWI+kRqMxIan3MMiwWfP6ETRB5ykl+c7A9NojDPXLz80N7iRHh99ze7wpDysqCtJe70ixcxTMKuZwPEsbI3VRltqraHU9eylXtX8AvbcwP+y9S5H3FfX8naL9zOORJFMTdWuuQtLC4gHYvO5ZnYvyFigZWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0C92cg69NYaHSmZk+tOYWVfykMcPe+MU6akvrHPjmA=;
 b=iuZ4jafiUdM7SZXP8h3dZvHc+TeAG9QYn2CjcaDYWrjYbjIIxwTteJ9m85rCOsgucbFe5KiwmEg9xPtBTR3RoASB0iS1lmZSo+5QLjdce/Qpd1GJSk8v1yJEzPryUbDQgHnS272AdH5XYDxRfqGtuwfohmOMSVgxYFtk4NrtxxlYeMjw3v/5LBMkwWFrX87gG7eZpWYDNo9joeD/4AmGdUKySJfNbdgu7XE9XnhMYRvLfvhQHCF4PWppa0onPyNCD7hnrVL0sDBjv+SMdLR80ct1ctdusR13zn+hngOxkMC4R7xrJAsujpzeREsWHpiSyhwmPGX3lXZ1+EniLNosSg==
Received: from DM6PR21CA0014.namprd21.prod.outlook.com (2603:10b6:5:174::24)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 13:59:26 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::d7) by DM6PR21CA0014.outlook.office365.com
 (2603:10b6:5:174::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.3 via Frontend
 Transport; Wed, 25 Jan 2023 13:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Wed, 25 Jan 2023 13:59:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 05:59:20 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 05:59:20 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 25 Jan 2023 05:59:19 -0800
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
Subject: Re: [PATCH 4.14 00/25] 4.14.304-rc1 review
In-Reply-To: <20230122150217.788215473@linuxfoundation.org>
References: <20230122150217.788215473@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <7b8da7ec-9016-4918-ac8e-53bd3385c457@rnnvmail202.nvidia.com>
Date:   Wed, 25 Jan 2023 05:59:19 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 39341fd1-ed0e-4214-579d-08dafedc5eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4vWh2TS/gX4XvMKUfoeDqx1TmkRYmbpMkuHyuEEEkivdZAb4bejYOVw8H28572wbxEacO+RHxZusvL0l0NAF2FT/B9z5Ee5PlMTu05ZShCC54RhXhiWRW3sQhwKuGX8vXsh1r4XOByvy4PdErXoZIh32f8b1Q9yy+LkxG4nnXsAyzm1qpXH2i/j7G44H7zwi2FgqWC+57OTy2A2/tLOZkLzo7IG+QdSbkqPwmEhDmD9+M8kol7yCg9k0TJ5Nh/71oTuJHoL7mZOG7VWSbQZGGGnQ8DRq719ZqpZj97aoU7VNuXqVcUMIgHotkdWA6NGWuNtmQtyPcUrinLCFxUAe4nE/o01sTuMbb1qJ7X98Vor+vONhavZxBwQmM/SR9FYGPUDOamIhxUgr3y+hVFey1GhXabAOaJbRvNx0DjMJDaYWiejSoT0oUqEiDYYqQHD+AuQyH+K2uIjk9NNz+fTaaiudJwcgFZMJn53ocYlph3I3l4jCxoXfqHOkG1PYVBxUJtFJsl15lmSzLOVl6boNs0qmb66nyAs+KZpfV5uFuV270ruSy9sbh1x5UhBON5N2AJwUtXa3EfylpItfye88N1uRRaksy42epCrnBQHCfx3W7zXQ/2nPiLNzuCNft6rvpUwPuJ+seQGLznaXmBD8X00tB/7ID9HMKIRzV1s+jDzgz16dQ2Jo9P9hOdefWg/37KQ12/FIfcr5SEzjA/izaDMfwfJUtLRBuBmjvZSP8wUyamm6ep9RqENH+1k0VwgCwiaD17vi8gI+G7dWyRB8s7LCWK0cdKKZIhFDOLNBjoY=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(336012)(54906003)(316002)(4326008)(426003)(8676002)(70206006)(47076005)(70586007)(6916009)(5660300002)(7416002)(41300700001)(2906002)(356005)(31686004)(26005)(966005)(478600001)(186003)(36860700001)(7636003)(40460700003)(31696002)(8936002)(82310400005)(40480700001)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 13:59:26.3788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39341fd1-ed0e-4214-579d-08dafedc5eef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2023 16:04:00 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.304 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 24 Jan 2023 15:02:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.304-rc1.gz
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

Linux version:	4.14.304-rc1-ged199ef62346
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
