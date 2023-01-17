Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AAD66DC05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbjAQLOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbjAQLN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:13:27 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A262412E;
        Tue, 17 Jan 2023 03:13:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eG6CfsfU+xpzjFMGAlLhLL2dJWUsGcWyWLC1G02WK9c3scoZtB4PFaskVSfm1Dh+k5nBbQmfisJat04dlas3+F542gfXYLCVjDLjo8d8+Y0Jq1YTbpMwrxNLHzmRlLyk+MKfCZVMavgV8wlU5z0lQUqpHjpYSI3GyEf5VRp9k+RbXqqCGjhEECHfxwKuwq3ff7GbeA4JZG1TFm89ewMi3yE4mT1zQt8WEnfcb0OlA/pPSVfPGDSrqp5XIlYqsh4pRG3RzKNDQ37rkJCIPNS7aspFEjtd9mTMUrTLq2aNBRNdbec9jZzQqu6b2zBxV0gkR04Wi0Hn8PeOfHRz3npNKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amH3WGN+OQ05Z7Dcjj6whuOH/VW5PpwMTc8hL1prGvg=;
 b=Yl1WPrdmX6C7uJk15/RGCZSFM1sZHRHGlS1Sg8OuHrF+YF1eZAtOxyEWdY2O9C4Glot1dPPtCwR267pyYXfcngiD3cHeRYryrgZiasPniu+0/ATMYYBsEKhxyJIhyFL9+sm9KKRyZoEjs+5cq2Isiw9+9nJNkYs/uT9VSt1aML05Q30t+VJCNwes4j9sNsJqzoTTvTbqQBeGzASPiUKSjMawxStc1UlofJIoO7/cDM2cC8mUoCWKmBT9+vyeJ81ra+OFayEEYtjnUoNSYuQxxFT7VcS3tKPS+MxoDLXQtL73BAyuDIBVTEv48BiGHmj+j8KhxIf/mIRWsoXy8Qu+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amH3WGN+OQ05Z7Dcjj6whuOH/VW5PpwMTc8hL1prGvg=;
 b=jQXp2tpolUxrdWtVlkMYRY2W+tuiQfDl1i1AxgkVxFVNyUgT2Yld/jEoZM1JZ/Pngv6ysLvbivr+oAZ0WLkaD92knw0CbSVTMduzscsNu4OrEzQGxOTQ9O9vR3TlRTIg0misfL6Q4iFZ77DujJM8zKo7lttXtkap9Mpb5yH4jUxVmSR/PddDgNZjMe2+W/G46xDrdBqFwN6kgFvQKg0j7YGuJ2spONhjMk3fjPR09Gl9zQFskBStAth3IiV//bsdbLidFYbcqqWDkbTNovfU1GbvePYw1yEa3WqsXlgo3y2r01AYWF3SgrhkqCw+Gwzqt6gT1S9vDsOaFq0yHlnRDw==
Received: from CY5PR22CA0039.namprd22.prod.outlook.com (2603:10b6:930:1d::13)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Tue, 17 Jan
 2023 11:13:19 +0000
Received: from CY4PEPF0000B8EA.namprd05.prod.outlook.com
 (2603:10b6:930:1d:cafe::37) by CY5PR22CA0039.outlook.office365.com
 (2603:10b6:930:1d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 11:13:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000B8EA.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.4 via Frontend Transport; Tue, 17 Jan 2023 11:13:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 03:13:05 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 03:13:05 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 17 Jan 2023 03:13:04 -0800
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
Subject: Re: [PATCH 5.15 00/86] 5.15.89-rc1 review
In-Reply-To: <20230116154747.036911298@linuxfoundation.org>
References: <20230116154747.036911298@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <3b129fbe-895f-4d86-b334-7c9ea69b3bda@rnnvmail202.nvidia.com>
Date:   Tue, 17 Jan 2023 03:13:04 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EA:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 89280bf7-aa3a-4dff-5291-08daf87bd67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fLrgUReSrpMPRS4KTLnKT+enrfCdbUQJivkWw1rDx29rKf8YToKLvYTSur4Sn0I+A3wj1uM5iEy2QLUoMg3Iuh7GGgTebG2dJGbfwJT40Y+bHVZa8OwKrh0jx+wNuamGhAKBu3VVGxvx/B4C/f0Ns2xwyTixx97FH3ejpFtg6D21cxQT8GjBN4UxFs3hAwpJsuOldE/kH843WM2AIjSp07JfqZ+JnH8DdbhxY+gpucoqATL5nWbyEtFcLddOarbY45QVLbZ7ibS9GP1UiSo0+Np34ofSSUxg4gLbbxdkmoIg3fdPVuNECbjGrJlPPJje2uTb76JtDAYp7dBx9wPmzcHJ8o4CvAmndZLuRulHLcNdRyG9Dvzj9aYHB3l4EQfEJc5wQSKqpfn3JpMqGHi19p4OqvRe/YFRXDepGKAsq2wuYAnbxBy1ld/00r3PMaA9J2nlRq3jdX7izbGIZlLHzE89ofspRpWk+AcNdAF+lcgqfuFeuNIzTZx09+UC3RVSTkk7HO18sFTYuiR6Z+x66eXnHcdxtduhkWx0nQfQlDln4BKoMdh5OFCI6MQXr7Smzx6yp/o7DVPuHraivCUdfI3jwQLVSBJVWjCJutHhRLkiUygKSkvIAM5kMZoa0FFEC9zxKequaW1RSq0zORFgTuggOCL7fYfVs3be18EdBcfLwohcrxf9ujfdqAyjCQ0Ot+2X4DM67+xqbagNQoPkqX79DwYKlQrllhVVZdgzLztuAF+UxkNfHeT7Gsuvc7gXTMiojzjmYIqGK8V931HM+c+47y8/QjF8mLL3dJXk0U=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(26005)(31686004)(186003)(966005)(478600001)(316002)(70586007)(70206006)(54906003)(8676002)(4326008)(6916009)(336012)(7636003)(426003)(47076005)(8936002)(5660300002)(7416002)(41300700001)(31696002)(40480700001)(86362001)(2906002)(82310400005)(82740400003)(356005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 11:13:18.8299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89280bf7-aa3a-4dff-5291-08daf87bd67d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 16:50:34 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.89 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Jan 2023 15:47:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.89-rc1.gz
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

Linux version:	5.15.89-rc1-g5bcc318cb4cd
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
