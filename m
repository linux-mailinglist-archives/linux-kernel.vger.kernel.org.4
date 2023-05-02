Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D8F6F4824
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjEBQRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjEBQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:17:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD41199C;
        Tue,  2 May 2023 09:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOfdr52qn7dYUM0Z9/P9eBUEygzqg7c2LC714ntUMUcYKHokTVP3jaie06agu8YvAoGdpry0f/XW9EK043d8GHVRQ5Ofvnzr1or/BpjJgsvBaOdcSIySnATKdsJb/jIb1xMS8npepzzqi3cnhHjIUYx1r4HZr/RO0LWJlAS3N+/jEX6uQjG0jbIXGsUhEpc+Xyuv2tTxp8h/YdRVqhCGhsm/TcUdYrosNFIljR4f3DyQRG6KCd0+P50NMlzecJZ37u5YCyeIwBjZmKDN4lyfCdQ9W0YwDGiXjQezqLwlUGdEQLSTE3E21CG1nC9g3Vg0DQnUiG6dYVjIyUjRQgqezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjLTx8OKNVmRP9xLLA8rCh182eQLl7Bw0Y5+BDtEihU=;
 b=cwbj/pwL098QuhR4Pifx77/l4xzAckpXDGKI09bUrNrMucrWOLZ0edLH89kW0JVNLRODaPcPy1gwVLTXs7JQ5+Rn2I1RXcAZuJlqmjQqtWUbd+RNECqVA9nJUjm+qvDwFX6mRNcAc9e/d0SMKHq05+8yh85B52y04jSUUV4bhJyvkCMmg3RNWuhJLB/yxejNzogZh7uGq3yXLr877MNEhOvkqyKjx8j0wssd7VHEaau6Mv7xbHWnYSkH43Io9uQOSCq+nD+k/zxjxlAZDkGFieyG+w4JEDoz4Wc1Vvuep53hO2+MVuZ+SE7HyS3h+TrorjtGUNBvjfoZbmxBVrNpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjLTx8OKNVmRP9xLLA8rCh182eQLl7Bw0Y5+BDtEihU=;
 b=R9QOuMazv3Avob+mNJO0vSqXQgTb88Il+tWn8J/RfNeIdXJK06d5uchv4fV4O3XsEkx0cp2Dy9hNXLHeVQhmci1poxwUV8KzYtUKHwtsaApM2xmmmtQvb55giC7p3at6LFaxo2em23e5tJYgkZ57B+aS02MPrDWd/xqIJslLKfsRcMiBRnfVY2T2pkyfjeoXHzpcajnCJ1SQhrdY23asPyMmjhp1R2nWPaGh7lPsPuQXJg2YsNqjyLlUQSUGEFuNJL4GHZotYmhd6X+gt5NVhVQE66bxlcve/MtlpXLvCISEveXqVTnutLnKuZvcCH7XMauYzNOGL44CF9xkpL2VYQ==
Received: from DS7PR03CA0207.namprd03.prod.outlook.com (2603:10b6:5:3b6::32)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 16:17:37 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::5a) by DS7PR03CA0207.outlook.office365.com
 (2603:10b6:5:3b6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 16:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 16:17:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 2 May 2023
 09:17:24 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 2 May 2023
 09:17:23 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 2 May 2023 09:17:23 -0700
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
Subject: Re: [PATCH 5.15 00/13] 5.15.110-rc1 review
In-Reply-To: <20230428112039.133978540@linuxfoundation.org>
References: <20230428112039.133978540@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <83fca0ee-538b-4ad4-8780-b20728bb4059@rnnvmail203.nvidia.com>
Date:   Tue, 2 May 2023 09:17:23 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 170f3cf4-c4e2-419f-5ca3-08db4b28becb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Acrt8tYqgCK7nw/VG14+2g+6PhflLE2HOTEAjVjFVCGF566wo04CRbH+D4YufiqMnSIVbmTT/13I9eLmwtkC1ViANKrx8pwXYP7qkTVgVUf48+9m5I7SuVT0UDOCMfzuRFipPhLJQyZZCsmgWBHDP/xfgy7HMomT3hCN1OCf99MzejGnE/l36wiZHVyBHL7zg1rvB25Qec5Wu31G4tpkqjOSbQYnvQuaGUAfKUuE06EHS2lHiJ/6Lg2PK3m/9NvF9jtVurMWVRYgPdZ2+aEK218c2CNaoxLs4wHuf0xA2fGnaFlz967KyqrOF7OPW8GWYpj+TgMZJD27iP0D9D+02JBGHl7wIAsRirJvIj/FG4+2OMIgnk7UDwqpu9gDD58mezCQ008AGBDaAXwtKyyGd9JZqIDDgLpYzcSkCN00Da9z9BDp4D8NM/Wy4zXA+2rwK7rV2GYPSctHv36Va/oSv8awONjwpN8HDscBZsWMuZT9ecD6rUJbTAKNOMhyVzWTlS+pP7ZDUMV98W1BKaBOtCqr+XD8f7ur6VSGi2ib9k4Td3/xx+d98yrN96mYC3x+CoRfT7lD8MUU9U5bpsF1WpsGF4//G/RNRJF5kGx4d/M4JN+mHCsjOLYOfCnjIfzxxm6UNnPItPlqhyI71k0cDlVOx2qbKoBT1wpPNGyeETJ08wV8TGhdYpVktSP6XUqHVF/w58iWa2bBnW1ytHLyGulK2wfdyRLiBnX4UTPPrujou07MSX43tQ8HCHTcHMHTnFEc56poGuS0iOVpGGfFH68hSDpaQOefwzlRsdx/LRo=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(82740400003)(7636003)(356005)(26005)(186003)(966005)(336012)(47076005)(426003)(478600001)(8936002)(5660300002)(7416002)(82310400005)(41300700001)(8676002)(40460700003)(54906003)(2906002)(40480700001)(31696002)(316002)(4326008)(70206006)(70586007)(86362001)(6916009)(36860700001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 16:17:37.3424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 170f3cf4-c4e2-419f-5ca3-08db4b28becb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 13:28:04 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.110 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.110-rc1.gz
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

Linux version:	5.15.110-rc1-g64fb7ad7e758
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
