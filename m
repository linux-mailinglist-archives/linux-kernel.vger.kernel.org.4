Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81153671B92
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjARMKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjARMHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:07:44 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96413D913;
        Wed, 18 Jan 2023 03:27:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoXTLztBgrtLEnOScJKVfNyFZg6aT3va+210UYD0WFYMIxQ4PeH8sd6Y3h93+1GBnRMmz7Jc0lK6YIHoufjj8zPv5UGUdIc1RDam7C5gh5V09sP7RmKZNNjZSU3UG+SgZLy4v+Y0GG/UW253ThYQW5Dk20mRJ2EFdK4TfV7x1bYmouz88+0VR0Q5ccRs2swlawjlJ5/QoxOBEzuq9QLvO2jmf0khwWQeyjiS2+iNnat48akVSkE5JHYRxyhMwCgGYjTCpoIpqo0GIzG5PwH7bus6Uul29CTfJVm6B82anNjsF5WybxO3UQXsqhPCrOZSC5gyXp/tMjrRR2muE2+2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nNE5ng9sHIvCt0rOwLBmEZMPxjvUKUjnyNq4ff1w5E=;
 b=TP6cb20OYP7NfOhhrCwLFIG4+UUTsPsC4kSf3PLnGUwho+uY2mH7JIuywqNocEnIhkedRzbhJv4pMHayx0l19tEWdTOxE1QFWNXMZ9kPCPadYyE630u4HuXXdxB+9zdooDkAb06BcTOsqUJ33deBKVjMVHaRwbFi8fz5AbS1A6yfERvfjzEsy2b6uacqPBd9F7r245+kUvaeQaNFJNrv9U4PtjFzJbAbOnW1jDENfNWjbhuztfzILcLejsbO1TxN12Lybpcl9pgocD/gjLBXaSJ7Q4P96s6iIXhhxu9HSoiKE3N/N+48CUyT2smkyg62Zf10af4/IOOJZQHTl6Dmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nNE5ng9sHIvCt0rOwLBmEZMPxjvUKUjnyNq4ff1w5E=;
 b=iK35JPL9pSIAZ3RzTuATPo1bYO1blQLw/IIeRlHANwyQ60tNf35fh5QQQl3qhoiw1FyRLRammwzYgmLlM4VSVMg7aHFWHA/uOWQ+d1Pz5mtDFcAyQt1nTWavSQwbDOjWX8cWjkK3Y//6/ijz6NKQW9vdE1eTQYh08mjEVNOFNKIY+EWquSyvJziy7QyeSxRcpYALh3faY3hkR0qE0mIG1g2QjGNqoHYi4Y5aU74Y/KLpd7AauHZ5b0ZYnPNI8Wrmi4CsvouOfKXyCdYr32VwwPq5/OMUiOhEfy9IyY9ANIcEqHguEirp85ChA/fguiSB2SBYF3usLX4OKt7N+k+h0g==
Received: from MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::26)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 11:27:22 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::37) by MW4P222CA0021.outlook.office365.com
 (2603:10b6:303:114::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 11:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.24 via Frontend Transport; Wed, 18 Jan 2023 11:27:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 18 Jan
 2023 03:27:09 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 18 Jan
 2023 03:27:08 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 18 Jan 2023 03:27:08 -0800
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
Subject: Re: [PATCH 5.4 000/622] 5.4.229-rc2 review
In-Reply-To: <20230117124648.308618956@linuxfoundation.org>
References: <20230117124648.308618956@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <6e068120-fba1-42c4-bbf5-34b61a8337b2@rnnvmail201.nvidia.com>
Date:   Wed, 18 Jan 2023 03:27:08 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d39097e-ce40-4b82-1311-08daf946f724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DlSnlxhQENtKMXtMtqERcIS1d7aR3VPAJh8pzL8gwlFL6CXDEIU2y+q2uy9J2fbwnQYjbbjfGrZbAPofJNAByPItGCk55QdhhTB4GJy3vv6tAxO1zWdTB7sMkX0PQ88jlfi6Yst03s0ogdm6kjjojE3dpJTVPviek2UTjr8YPUAjbkiiab0mT4aJGFRmeUMcZ9fNbcbZVu0WKoiUxISRMtFREW8lszOW+zuLXv597GNhsqls1O+Olcm1nhjB3fthcTCbFEvx9/2mgOwuk0jS+jdCiELfbJ3SJVSHRiW7RTAhBHF5fhRGW3Ms3gw3Ru+tzetv3yFdYHRq3pJ8LObAAiu9iHsZswggh+Hh8JAnb8BoXydu9E3OCTwa6bLCKESWT+OLNwjEOYEcvwVV8AskU6apwC7KYxuCtTixiON7Vp8jpRtr59bxE1hp2J9h7HqxXPwPQYTFEb4hNNcf1K9wmb6pWgzNPzG4JyHeGX+HALC3pdZr2tXkY5PWxhWUbYY9HpCujGtM2uzwgrGgNf0XVJUp6bTOVAJ6aasFKpNQwHktcpJYAT0HzFOU0UCZl0pBXKd5K+Xaa9eHz+yOL804NWmyHoRY9EaJKykc67LB8Q7wv7YwFMjU4p6hCCTZteFLEDwTNMeF3l14/NW1PmkQ1CU3GP+GXsha5AByhX0FWiItRYG/WILy090ShJ3e52YT5mQoDt4wvLouwzUsiCDhTSadNcUEzG6kEufvuS4sxwULeWaz3PKzdC76Vpo4nsHv
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(46966006)(36840700001)(31686004)(2906002)(356005)(86362001)(70586007)(8676002)(31696002)(4326008)(70206006)(8936002)(5660300002)(7416002)(6916009)(7636003)(82740400003)(36860700001)(966005)(316002)(426003)(478600001)(54906003)(40480700001)(82310400005)(41300700001)(336012)(47076005)(26005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 11:27:21.4616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d39097e-ce40-4b82-1311-08daf946f724
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 13:48:21 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.229 release.
> There are 622 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Jan 2023 12:45:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.229-rc2.gz
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

Linux version:	5.4.229-rc2-g11f7238df0b4
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
