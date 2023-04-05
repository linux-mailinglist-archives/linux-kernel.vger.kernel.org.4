Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E031C6D7FA1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbjDEOfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238601AbjDEOfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:35:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ED85FDC;
        Wed,  5 Apr 2023 07:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BK7KlJzUFH+EM4SHuhVeNFn5yPJ4A1CgETrCMTFh5/2jIunSkEbImT5kn5kJnwJqqkIV9eEx2K4D0cCt7Apw2VxYqcm6fBrcAKFjmCSvqNq05W18yXPOneNt5cN3Uzk2SbK0WYuZ65MGoPaK7jK/WDHAYKjGoo1QFDhO+EXkfdxKS7bRULvkWhn3HuYZsV0vlEcN1wo3ZI0DbmZzwNfcwVMMamk9ZtdYiTX4IzaHx6IpKkNTiyAnWg5kW7BwUum48jBsBuX4pdR0uJqzQIAJUpInwc1u3NBDyggn4q2l07LX0nVEZFScX8vmypZouVFyxfPzjeW8L+tBQt/72dLisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91FpW4cKSG9c49Y1AwbTXZ+mJCn0uWbvQLME/GAwchc=;
 b=d6wjBMi0HsLf15R1JmGMzQjEtQsqBOLoI/0lz/i9OrNSM1jCNfzYGPben4j6DuWpezKuTljKRH7wsTWrsjsusbG4JPvMec32LsBE2isUcWzROmpPNnuxe7U7iaKDVxSTxENPg6WAFasO1ctAHuVNdoMUqSj8ikOa+CiAZURWQ3rOWwr7UREYRGesVo3JGIcYB3cHyoAZk2TPeTQ4NK49oVJCYwDI/Q/7NDWYygL1Am20B3gia0tkZ9fsQ1tnqlZ48a4ZJym+eaCT1MxiDl2uqv7a0CJo7l2FszDI1lyxyAkpoEy7jOX+D9Si+mF2HrThejxbC+Was4Le2cJPwWBGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91FpW4cKSG9c49Y1AwbTXZ+mJCn0uWbvQLME/GAwchc=;
 b=aB0TZEIFkcxsCYMrlREAElXE6zosJuZUdYFGEs8F3igq0GwcTK4hofKL+3ZRWeBaoTYDhs2+LuFJpdltUHKu8dUHKDnLxGkLziolpMcdUrYPNpiEwsw3jJvLpOZA86lxUmcV/9Papq2deMczEfkmxs5S8kJ0sQPkvmY1XQSU/c65PolfZC4FRp+Fk4YHIUhbZUfOsYOhhH81+KbkKHBjbaU2N3ZPZ45r8eitUOncr1VDHPCo7ssprko2Y/ck69p+X1QMQHbFKwQLUAw0YjKLn9J61mH6O3TjJXOtgr0GtZoL8Cstjkn4uIBge5v3AxvpxYAI3HNIEi2FPUYiAfmIIg==
Received: from BN9PR03CA0896.namprd03.prod.outlook.com (2603:10b6:408:13c::31)
 by PH7PR12MB8156.namprd12.prod.outlook.com (2603:10b6:510:2b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Wed, 5 Apr
 2023 14:35:05 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::e9) by BN9PR03CA0896.outlook.office365.com
 (2603:10b6:408:13c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30 via Frontend
 Transport; Wed, 5 Apr 2023 14:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.28 via Frontend Transport; Wed, 5 Apr 2023 14:35:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 5 Apr 2023
 07:34:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 5 Apr 2023 07:34:52 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 5 Apr 2023 07:34:52 -0700
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
Subject: Re: [PATCH 6.2 000/185] 6.2.10-rc2 review
In-Reply-To: <20230405100309.298748790@linuxfoundation.org>
References: <20230405100309.298748790@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <f2f5a737-27ba-4cf3-86a1-82b67c9be2bd@drhqmail201.nvidia.com>
Date:   Wed, 5 Apr 2023 07:34:52 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|PH7PR12MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1d89ee-aead-46d2-89c3-08db35e2f2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbBX5u+8Hw/PWQ06YhOvPMZ6XcSZWcmX0VOZHKBdOBsg6Zt3wFOqws4BoQKj5WY3STPLr6WRISURKBs9Gvv+ExPPd5qMh57DWPwZbQSOiWql+Y9MUODgP+LSjRuVGjhQgZeVVOVhIAP0I7YFW9nlUg0hQETGzag8f6jmBtYvXkNq5iVQYM1Rk8VXDwm1Prnp5N37keh4V+FQAf4SIqG/xTOMtFTBAvQIkCEIrCMGBkowClZNvYPwLBUQQU/tqYna6pWNJDvSSpErFPQTs8WU4E7toMJu29WRHMEFZ9L+TR6BAn10CkS92J/+utUJxkvHJYJbgLsjYwTZFd2PczqiM7hTBCxZdaxPxPMycxT3IBS8szwllLhwghusG2XyH++L2TN9MsiFPvfNRLVeSbC60/eiNeJ5md0LODrKwlNQMOVRC9nitUPHSQaIn3dkJo2yT9tstSPoMMZe1U8uyu3lmBpkeJUUklXT4TR5oVvF0SZFQJadX/PQm3fFFCpvsoMttGIAJZkGBpH4P9gklzte3Hh/Sgo4R9s4vnBYHIkpHDRGXUbKrV7XMOoXPUFTTKb1jY1lgFxXXljh0G/TGAAytuuViz+X5PL735ykcEo4kwNSBl1W1BUO8iY0NNut0Lq09pvTPoIF/37wC0hAKXECe1kxdN17SRVHhOtCvHcHNRNa6MSZmHOKni3e4m8ovP6weftT8Ijkx+hOvXI4YW3wKQl3CjsQx3cY1VlHCy7c+rdc+K0eV3+GQkMQgyo6fkkGzNZPWgIbfuBkft/wFuNuNbFAAewvgsbL08WdkaBB35o=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(41300700001)(70206006)(426003)(186003)(31686004)(70586007)(8676002)(47076005)(6916009)(4326008)(8936002)(82740400003)(966005)(7636003)(336012)(7416002)(82310400005)(5660300002)(54906003)(356005)(40460700003)(316002)(478600001)(26005)(2906002)(86362001)(31696002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 14:35:05.3488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1d89ee-aead-46d2-89c3-08db35e2f2cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8156
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023 12:03:46 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.10 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Apr 2023 10:02:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.10-rc2.gz
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

Linux version:	6.2.10-rc2-g572b6e9e4ebc
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
