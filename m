Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA04682E36
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjAaNma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjAaNmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:42:19 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0341A518FF;
        Tue, 31 Jan 2023 05:42:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQN5AkhTMqmxmQHwtrRtod1qRH7GOa/xNWy6VLN2rCtcet+RMK97bG92lq4bfywOP8QM2Zi7NpCFE8RC0Iu6YR7lB4UpXwrxET6NALaZcWYdcsBip4qpVB5lvzEr9Cm4MeC4XV4Od2mVXOUgpLE1Q52RuNEGpmoLqmkbAE+Y/b5uAgzt0VQmPf+SoZv8Xcej3MELTxKMI5O0CoetVgpHw62v3kwRfxaiBe9WpqPN0c8uJM19YvvOHzMtO1jL5oaMopVhn3hd3LtTrF5VFTyGeVe/ZvibvOABH3cQwqPEGunwLMSwI6kRVcy0SE/6rapQOV4V5e/Vcox5AFt7m7f2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcczXbPX/sfW+0JsDBNzLz1IE4wxkuRfg553UPQXouw=;
 b=fUJf+Hj8wZMa05O5jQx3Ru/7DLGCeRku4WEcAlJKr2Ai/5+69blLPXs2XBp8VdK9P7160eE2e3hhoOsiPeCuToGTtrNc7oHsN+8l5+aad5EdFchDhBegTFlZMR0T88ngTg8WIpVubW0/YNJJG/WS9mWWxORjaThP849GTKtLb0IsvAqZxBoPvcRLnszPB985b1T4wmHBfUeC1/gVJAdMcRuMlA8l+DAB6Yfzxr63VhI9H42kyBEoEEosViaZZ6We0u2HwLHVN8JmOcZRZ/4HyUEdLdT0c2laS3I8vy4o7RcUKQ6a3qNEcVb4QD7OzcgcGnZgw4VL4VU8PW7TCv7lrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcczXbPX/sfW+0JsDBNzLz1IE4wxkuRfg553UPQXouw=;
 b=ZnVhS8jJlGYJKHy+kjNIn4yYdM1MQM65k/47iosvYimA7pQk1Fqfu8oWtnTvHUoc7QjqcGSXAuDhK9GcxVVBAuYc7KUpZ3vT1LU67Q/3SjajEWTUW/oO5NErMfZae81WSaRF41sIt6r/5szGbyxakRF/l22UpTLJdG9dKTCg4hwuYlN8O52K8aG1P7CXmnW9KecnYqiXFh2bHmXA21qwFtAgEHmSgt3nq/W/ezwFIB0TCYzKmnbwe69/UH+jrTA/X3bm0XwT6vo5oSb+2vg+H6Cc65e8PBR+yXVNcG+S1r9Igx9SKqGexr47tsjELlcwl8GIm2JUz7UQ7TWQLy0spg==
Received: from BN8PR15CA0027.namprd15.prod.outlook.com (2603:10b6:408:c0::40)
 by IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 13:42:13 +0000
Received: from BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::65) by BN8PR15CA0027.outlook.office365.com
 (2603:10b6:408:c0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 13:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT104.mail.protection.outlook.com (10.13.177.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36 via Frontend Transport; Tue, 31 Jan 2023 13:42:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 05:42:02 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 05:42:01 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 31 Jan 2023 05:42:01 -0800
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
Subject: Re: [PATCH 6.1 000/306] 6.1.9-rc3 review
In-Reply-To: <20230131072621.746783417@linuxfoundation.org>
References: <20230131072621.746783417@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <ef6cc50f-948e-4fdb-b03c-986d7eb927b7@rnnvmail204.nvidia.com>
Date:   Tue, 31 Jan 2023 05:42:01 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT104:EE_|IA0PR12MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f353e3-0984-41b5-1b59-08db0390f58f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzvRAOzBnWqUyPnjwDpUSViwRnxlIGjtKQUh2JxrweROzIDcW6tWOh/wdd47xcyMfD/TgXh01dRN4T9PyxEL8PhzgdU0lTeePk3R0d1CNqBmeJVi5xF4dzCtdDDko32NfJL6b/cN8Qv8sPtsXQg2ke2pSIM9Suk+H1OgW5ipAQZyCF/5h4flkWOqTMba3UWxY+67CUGRKwI3YAg4g8eQ1Vmmus+oZUoKXZDOOE2NXTHqLkK7VhuJOWrIEXf9U43K0wcHD97tGELC5vMtmqOE76J8dxeGbYZTapXRezMQ7vdqGmNMKuNcA24UIS2pUZIcWKoqVedhFy2w9uBmPcoasGppiv7wfuCqtvteALJ02iuDuKN3XJhbizc9eBZne8rR7RyyVK4bGOJ1klkFTnrSPPupv0rcNVFE4W5U3T11POK9aXT9gK62lprtpEkOdfwlnzVWrsk8jUt4cN5zeJpEPItOIrDDkCmJ7pg+DvEJ7d+/q5Rim1Qu3GwKlLJBwCC5pZQZBKogb0spERJ1BckHWyiU3mcLuFCN2rXAGKC1M0NOTJyhXojHkciI3/KP2x+DUjEejLVx/CrXyh21QneYRID9vUY1CY/Yj6uTTOj5p3qL6pvEhh1R0ZWA80/tueDwjiUfmFy059gvdsKzyxmBkO4YGwpGtmIYyElTY2nAq5hx74ofYeJ3MFXQ0jLDyb2mAEn33pyO4xCi+lpnlutLysB60nH2RsH40yZ+ozO7ovj+RAFCCPaqAmQVIVaL9BtvZGwxsJxBmgxKUz7ASqj9n16hzfMj1M2nCtx1QIFtT5o=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199018)(36840700001)(46966006)(40470700004)(70586007)(70206006)(82310400005)(8676002)(4326008)(82740400003)(6916009)(86362001)(36860700001)(7636003)(41300700001)(47076005)(426003)(31686004)(8936002)(316002)(356005)(336012)(5660300002)(54906003)(186003)(7416002)(26005)(31696002)(40460700003)(966005)(478600001)(2906002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 13:42:13.0996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f353e3-0984-41b5-1b59-08db0390f58f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 08:34:09 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.9 release.
> There are 306 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Feb 2023 07:25:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.9-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.1.9-rc3-gabbe4e7b6342
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
