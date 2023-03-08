Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE0E6B09D6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjCHNvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjCHNvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:51:04 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600A68480F;
        Wed,  8 Mar 2023 05:51:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3av39NsaOf+7kvL7ukPEGCFCDyNlGoabkxMHCpF6D93ZxFrjE+hKLZvuvw1Kvkx11o7vSHTkIKUXpG8dREY8pNuOMtKeM0DBo0/5YxKOHAwytLl2vNBy5Ee11hrLWHV/mvc9apEZ0NUkN2jNPz0ygG6U5wI0sQe40zb45EFHu25zZsi9ds25Mkhhf4q1X6+Vn2KZzJv4pUDNE+wGCVjtS0c6flLuQaL2uRpHio6yCI0k+lBwUTCjT06/xMvYI69o+dJm9TltNdSU8JJepg7Of346rXdFbEsdH5emg0PY4pgIEGWhdNRHRJuUeCXqfqZ0YdLF8HgpWsVWFZC/XzFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRT78eCslYw2dN5ankU9xOeF9iU7popG5lrJCmqoZYI=;
 b=AunWvWB4ftIfe8F5EHIBW+E4UIqrssioG4qzVcYEkbUOiwW/HQgmWrlaA79GZ1b4zS82o3JP4N1CZueW6NC6z46dFbUyT5imuKP7PEKgMFXo6tPOGX7hcR18A92uUP2TGRWYGplImAL8L7qZXsyfHpPg1WLSPCg2iiND5NeeeXM1VgIk3Rw+f3kv5YdVMaFVJ6V60LCG148C7sdCiofyrlHObZU6rW2E+nF9QaZQ2DLgn0xBDkEPeWWGsdRY/jc1O24Qgi9m93bSz41odxRWFm345nJt9ZTG5OpWl3qLDQ7Ou+YPVOoBBB/Bsp8wI3+ed5/QtAKMbe/fpxJgeFdYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRT78eCslYw2dN5ankU9xOeF9iU7popG5lrJCmqoZYI=;
 b=hxtYNEgHf3cxdQLJ9wj89KssgB6VWZHIw04MJlx2E71YabFFGinZRXQ8bUKKUSX7z/Z+YRPMwsAfStpZ3hsxO34LeiAN4EoMHuToJJS3cKBi2viBLDA1YcoP5nbZWsaCb56ThHLM5ho5SXHzWC4n/0tEbRWMI04gtYU5I1+0PMHPGo+g1pAi9NYj000JsIYzmg61PTkhJAZJIouIyzCgQ96s0amYb7zg/XtJbDuSjUiJkGn5yNa0tMdp06wOFgeYFAtUjMkRoMfpcD25TnZrtOf5wa4lXPxnxxyQHvDZBsaS0iOC2lx092aGacvUC++RCICyEE75/WbwJnVgZCf5Lg==
Received: from MW4PR03CA0168.namprd03.prod.outlook.com (2603:10b6:303:8d::23)
 by BY5PR12MB4903.namprd12.prod.outlook.com (2603:10b6:a03:1d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 13:51:00 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::56) by MW4PR03CA0168.outlook.office365.com
 (2603:10b6:303:8d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 13:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.14 via Frontend Transport; Wed, 8 Mar 2023 13:51:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 8 Mar 2023
 05:50:58 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 8 Mar 2023 05:50:57 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 8 Mar 2023 05:50:57 -0800
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
Subject: Re: [PATCH 5.15 000/570] 5.15.99-rc2 review
In-Reply-To: <20230308091759.112425121@linuxfoundation.org>
References: <20230308091759.112425121@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <15b950df-3922-4c8f-aee4-fc1932c638a8@drhqmail201.nvidia.com>
Date:   Wed, 8 Mar 2023 05:50:57 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|BY5PR12MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: c503e66e-e36b-485a-79d3-08db1fdc26b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wS478jhrlUCnqJeM2ywYNBuZvm7gKQV/4a6QlczRCnyg3R1lkSavzqXf17dCniZblMyIeK3eCjRWO61AMVKBndXQmaX6oC3UrjL5go1mFl7Tzc9Zahrnf63BFbVc9enhARsjwIN7cCrq5m1VJbsoFMlLbu/BuBtUywThqqlXty34K5TPK0ruqGrTIzZby0fzp+WTWUW7JHc5/m0+nbKGvsLEaimj3JjPn3MsZi85L6Sj/ZAVJ4H6BvSx0/MEawQOxnL8oAgxHEkYda2HmUotVfuv62/HUjoTMG4JjT3Ae49j5sYdX7DoW9mgkqWEBDSj0+9pP7ESWF5tEG6czfgS6KxwXYOzO96rpU7dn6inIYK+3lDqt+HVKUDufB7wfdPD+RF6xNCzN0jv+t+CpqQ8LgkKNNjkoC5fWRL4s89YWt3m0XrBLeIIlsjpjs4Vk9uPgvbsu2RQPt/3DvJvM+bdhmJZZ1S2dxUgIONS9VVbJvVzqdFARlKre7L8qBSKYO3L5U/jzRsGOqKnSZmbfG9NrVtHN4RcEkXTeQ88ZftFzCH20r1oDh73ZVEdIl50AhL+qVwHinWwPEZGQQ2b2s45ebT0p6pjKvyaDpPKsZBUO4AljF8ndLmzLYvZZF888tNFBoJq3lUur0QZeuzi3JvLwcuvXExmMpzhrlTu8bHRobXPxmjFFMiPuqYchX1tDenr9Mk2DFISdS590Of98eCaZw==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199018)(46966006)(36840700001)(54906003)(4326008)(70206006)(6916009)(70586007)(8676002)(186003)(336012)(82310400005)(31696002)(40480700001)(86362001)(7636003)(356005)(36860700001)(26005)(47076005)(82740400003)(316002)(426003)(478600001)(966005)(2906002)(8936002)(7416002)(5660300002)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 13:51:00.4969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c503e66e-e36b-485a-79d3-08db1fdc26b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4903
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Mar 2023 10:29:40 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.99 release.
> There are 570 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Mar 2023 09:16:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.99-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.99-rc2-g455812798518
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
