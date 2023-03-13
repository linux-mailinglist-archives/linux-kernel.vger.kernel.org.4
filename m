Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242096B7924
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjCMNiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjCMNiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:38:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1749B475;
        Mon, 13 Mar 2023 06:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYF4Q4zV/H6uSUYNoR/Xse4OiqbGlyKe9L6SA2425rE+wFqFCP3BsbczswA2qziUeCRt2tcK/AD0SuT54vYO8IKspjMgLkND5AAeNlAEwYFeJffHxCnDxksH7c+XpFWWIaNGOxrz6KvpqZLhmKK4zLDTu1gCZ/NwTdXOSIaS0TJXykmttHN2GFe/Hf94b9J3C50Ny9JsWRiCIZ778l1BLGWyyEGHaGAF5OcWNAQ3EDY8roRVyU2U8jijuecTuXgYULQx51UKx6uWm9OWl1jUpA8VJCrZ+Wgoktqw3seT0y6qZPwb3nNfG4Kyhf2b1UTKl3qaLqsCtA2/Maf0HeTzBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pO+e1HoQOAy2GX+qapAD4ry+kM2fqvzu9pnvwOP6s4=;
 b=LC8uf039tSoF0eas6ESnLqX5+fQMbPs+8/8lSutZ/ITBl06woVHwM7gmqjJI8FcsKy3sh74qZPefDGbtbQ6PSMBe7LfGrPRGSKbur/FzJ3xX6EsTSQPCFYW6hlItftRW4lkfFTVcYaatns0uU/Wt0Qt01rtw2FycwkGA4BjYLAOnTEz6/Zn3WtMUT/6C6vl7BjpNpQ3GWl79ksifswJsyrrwDjHk/aQKPN3Pv+ppKWIWJ3XGVzIGO2h9LwRC/smkv+/hskT3r7Z9H0aLVB3YWE+mBxndykn4QY23ZrOZScmapPOBlysSj2ChgXSx3eMWlP/yp/1vIS01FTrMreCKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pO+e1HoQOAy2GX+qapAD4ry+kM2fqvzu9pnvwOP6s4=;
 b=W+rS9eMidqenaA5iXHYgAnfXXz2d+a4AQv4r8Y9EbMznA7vC/Z/W+8YLhVNSZGBZJr4JhR5z9l4ESyev9kT6jG4sSDmt4UVLwwRh408TibuCUwoDKnMN8cFezjyufYnqpRHIU/tzpVsxga4W/nektqAnbMKTAvio12xYZr3y53o3qUh0Qftt5uI2kPfg48Y++DSHU/7gmZOU1QYkgEOKc6aCfjSFTZmfikvtswLd+E8hJ1xKwtvulR6KoFaa5zyddbhqGrGe+aqAWMlaExyRhsqjFBoc+q3TI/ObnUpAPWYCm/WS1D2ZaHXtqdHQpSWPY53HjYDV5Oz7CSxaLzfSTQ==
Received: from BN0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:408:e6::16)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 13:38:01 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::de) by BN0PR03CA0011.outlook.office365.com
 (2603:10b6:408:e6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 13:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.12 via Frontend Transport; Mon, 13 Mar 2023 13:38:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 13 Mar 2023
 06:37:50 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 13 Mar 2023 06:37:50 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Mon, 13 Mar 2023 06:37:50 -0700
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
Subject: Re: [PATCH 4.14 000/192] 4.14.308-rc2 review
In-Reply-To: <20230311092102.206109890@linuxfoundation.org>
References: <20230311092102.206109890@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <c475fc1b-bd9a-449f-b294-129c586495bb@drhqmail202.nvidia.com>
Date:   Mon, 13 Mar 2023 06:37:50 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: b99a93a9-ac7f-458a-4df9-08db23c82a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDLv8fKpjUrzj0gGkGWcVz9sIOvJXDALbDImpmXAFbnu4E1l9INeQDrgi3WXITnVvfgKjWWQ40kzzCUgRU0D5Qy7t4eh2j1TW1TTVEwrOSayaCvPSjRVjkJmafQJAzaoKEP+/y06pAE8009Gpbof7gnW3qmqa1GIL/r8daqHjUyGrZxmQhWfnWNZasj5bziOeb+0hAGO4CBLm4C52j9Glti+HM6gKU1ZgJ0QiJmXMZ2cZSyBD5LD3i262B33ktPt2GY+KGxu4vHlHinuzTcSOf5gZVJdqnwiN5sAuhkn6gFf/fYb15TUH5GPTwUeAV821Z1zQvYPtP1779D0UstjyBsRZnGDhAKk81qCScR16O32FhQRAjp9lroF1K1CJXh9Ha+fQm0b19MGkaQHCdJEAwCn/awwfmQHG2eL/oMMaHz2ulB4TpbcPzfq0KrYRBdTMMluPyaXSetqh5oR5gsWTbqkjqyCjomrGQQlQZdIaLTZ/mj/BkcDOKqRPmPzGvnEXFJoiiN1oHVXIK/DjV3CMMzdlWoAvi18Y1q7aelBDsuOHbx1pDGHhv8Y/pvQbk548ecZHuQfzlTJ3kXjM169VHPwCuhay6k/epWgkgohTA48pNi30rD/4nBQor5DncW8YqAWTZ06F8N13I/648TvJC01rCS8gUGDkuNAG4MNHQMU7dagHvOGVesXypa1BUx30lT+YVRxsdRxtwJMHsLo+oLgextUacU/AW1WfckIAxDPS+fkcfPfFFO2Lw7JRDgo0ibtpt2l3koeeShnEHNYm5EnfLjQUtnGs2uGCgHKxCA=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199018)(40470700004)(36840700001)(46966006)(82310400005)(356005)(316002)(86362001)(31696002)(40480700001)(7636003)(82740400003)(36860700001)(40460700003)(70586007)(6916009)(70206006)(4326008)(8676002)(41300700001)(54906003)(478600001)(8936002)(5660300002)(186003)(7416002)(2906002)(47076005)(426003)(336012)(966005)(26005)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 13:38:00.9789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b99a93a9-ac7f-458a-4df9-08db23c82a38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 10:40:14 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.308 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 13 Mar 2023 09:20:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.308-rc2.gz
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

Linux version:	4.14.308-rc2-g2326e906147b
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
