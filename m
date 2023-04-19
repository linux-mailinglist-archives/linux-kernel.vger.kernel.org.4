Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CF36E77C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjDSKwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjDSKv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:51:57 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12hn2202.outbound.protection.outlook.com [52.100.167.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E9C83D0;
        Wed, 19 Apr 2023 03:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4hkL5bgKH2VepU2evS7+0VFR3rHGq0bD6AXu8+x3D2e2gac+No9JlAIvgV1zgL15eOG6AdxZ3jeZrE9n56rlHvoswT/TLK68GhCH+ivBN1QAuljG9xiNl4p7kezylzNs0XUU3SgtCAJFvCzs9bmakQnHArFgb78P/VcLcG0vcWomz2UatmrNIqRnwmEfL5idCe5zRqC4MV3d30BqEVCr9/dvAMZ+xV3NPCu6bYyk7qBWoWMB0PHGOFZN2E/2i+5w5U0/11G8Dm5nhjidDqB9waWPxTKxG99Gf0PqB+W4eWjDeM3a0/GXANE2i3beg+eeA18rB/Cs/eRJ2Hbm7KhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qb3sByKe9ECk/jYWILB/IZShMp/sknnXgAyVRiKMfH4=;
 b=dQ08bufnXGrCXm0ZVTpufP4EXu6VE3cnn40gZRkqw8XKCRD6g7aW+1Rn4vSOf9Ex/oLRTXrkth8mAIGFXv3sg3IWy5nhgdyB/4MUkhZ8wY5UgfpmQxdQKUFgSosVk7A6DUr+3zMZcZO5o8Y+5XrhqHbrzBY4IKRgp8ncn31lqU8kSBIzw+HzACjgjp7EEjLFovne5nWvntNI2nuDubZMDdjbBwAD6baGSnzsPWsHr0Qn4e6vtjOAxdEzoNCh1nYOA1y6qdw9Cc83aqGRSIAu3jPMgR6txtSUO8UFvO2b51ayFt1SGmCvwhzJ2WnTpfqCBkHL2j65tHBPAYI2wHTA4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qb3sByKe9ECk/jYWILB/IZShMp/sknnXgAyVRiKMfH4=;
 b=t+kED2hd5R74Qdkz/YKP90rkLviJhu60AxuN89UoYjBV4JtIapiOqE3QXY5YmDBp7UM+g3TaQsK7Z/Gajrw3ehM+KIBn9SuD7NFZE9MVee0lzoe4cz4rE70/jV7RhCu0qde6v0QvVXW6FkS6weCDhfLwjIntCi/mjUyZlm5MEb7BT9HtYOH3oXK9mAyB9J2Z7J9GhL0FUl3ZV9fJsBJ2lbLRRlTC3iFBTa+rAp30WAXM1Zz34fwBgnh3WjwVniGVLUk/JA7Y67YWXLYU+inUl/zj4lb1RhBe4QDkCUo+OXrFW5k6h+m6NQb+trQwn66ZGfgJc8FZ9gaK5IM5aXzHyw==
Received: from DM6PR06CA0055.namprd06.prod.outlook.com (2603:10b6:5:54::32) by
 SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 19 Apr
 2023 10:51:53 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::ee) by DM6PR06CA0055.outlook.office365.com
 (2603:10b6:5:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Wed, 19 Apr 2023 10:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22 via Frontend Transport; Wed, 19 Apr 2023 10:51:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Apr 2023
 03:51:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 19 Apr 2023 03:51:46 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 19 Apr 2023 03:51:46 -0700
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
Subject: Re: [PATCH 4.14 00/37] 4.14.313-rc1 review
In-Reply-To: <20230418120254.687480980@linuxfoundation.org>
References: <20230418120254.687480980@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <54e5443c-1c32-45ef-aa82-60b592c80526@drhqmail202.nvidia.com>
Date:   Wed, 19 Apr 2023 03:51:46 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|SA3PR12MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2c1a31-a3a5-450a-7b2f-08db40c415d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19djeIFK81NFHaKYTOlAnuOm3CKe2lO+5VqCidARf0c8T40KIvylIbo2NSudTTmsz4qn11ZDg4v3+HWKnQ2kiDNk0kjS+LuBlqYJaRDLwXQwgvAdCTO7Gs2wcxdmzqp3g6T2qbFaonpKmWlYDpnDMRPVTyNl58VWlPfnT7PzmyiZJk3hxB1dgNZlrxT/OjxBh2PJ6WOKHLt8ww9Hukx2h85aRxKNTHD6ayLmnAaGw9+i0uUADckzJh2ciPRPtrmVca6zTeDGFd13Eo9qddV8NgUcvwXcdqj67Isw/j0gcgqMxoxmGec6kzXGlN43yVdBcpA1Tk7SMm37ut0SVg+YLhU0vUao5oC0CEcpKQ8Ad2q4pWLRkZP+BJ0fF2oThXwySy+czpb+yhwukyt/FmzzA2KIZXJNjmwXuC9zw8wchpG7zT9LWz1WakQED798qR+sT7b6jbzEDFl+yOJV2vyMKpJuEKJFByfFYYZLMYLdxoF5toFXZCn9F+PMDaDNb+NnKy9bcOWuhEgRVq3lc+MuJ7Pdg3jwK/IvxHXP0MzcMG/aXXXhCZlpUhNtlMz8v3tqgNyF8t/9lrJUtMpbL08cGOwDdfIZM8eywvm8gdN5Ce8W+mce6pEGmhjzDrW1nyncCBmbRYxtFifofq40eVEq5WLlvOhavYAr6vWky3z4cALN8usE7GdwD6hXMTALRHl9kg51/11MvVswDB82Yfc+6DycRhs8pxe61XTsQ8MYppE+pBprln+E5ERV7CnIowNYUL9k6AYMjvxP1ltugJhjxyHRgC7WbnDnwByN6LCAh00JYH4B1P4fAv4N21WWF2FCo6hZBOCty0YILnRdkNPHxjnVf2grIDTpp452kgFFWOU=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(5400799015)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(966005)(40460700003)(478600001)(2906002)(4326008)(70206006)(6916009)(70586007)(7416002)(86362001)(8936002)(41300700001)(34070700002)(82740400003)(7636003)(316002)(356005)(82310400005)(8676002)(31696002)(40480700001)(54906003)(26005)(31686004)(336012)(426003)(36860700001)(47076005)(186003)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 10:51:52.5615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2c1a31-a3a5-450a-7b2f-08db40c415d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437
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

On Tue, 18 Apr 2023 14:21:10 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.313 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 20 Apr 2023 12:02:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.313-rc1.gz
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

Linux version:	4.14.313-rc1-gcdc53f89dfa8
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
