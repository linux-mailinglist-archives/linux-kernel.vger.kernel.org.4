Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDC972DCB4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241536AbjFMIiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241548AbjFMIim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:38:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71264D2;
        Tue, 13 Jun 2023 01:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzwVEeLcfkuOzk9AZAdAv+kBpuMQEPvt0fS9yBth9rZSWnvAKxT1w9zXgw5Gp+Xpgj3eqJb7vz14Wlx2UaRFYW29ZOepB915RbvUsJD9s7vsHy+R5RE/B1AlwUkhDjN6cIlmQhG7PSTxbn6eAYpbNadPM1VRHbVXBtHjUsUkaPcO32KO6jqOs5fw2wloxX78DckYNcipsdapOG7mFe6na09uVvACZKpyeF7n7MFKl9B2irU4IsD8WRHym49z1FwufXNQ6Rcq+tV1V4RW9lTobixuX1FXoK3CCuu89WJArt5V/mjbCFOAeXs8fqFP6S2laP9wkIFZLvUPcSvBDKPh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdQHOqsdmME/QQJcrJTQrd/WxGTxLz49mMms5Smy3Qg=;
 b=YmF6TXqgS+IxjMH5hawUZQsZzFT6L5lk25OZ2xCfalOsaWiLwqPui3M1bp3yUtSjNR0pwbJCHdJcW+I6/Z6Zl4bV2RShKWrXToZEYYoLLBkoLLFfl9tCXYRgaA9XIUepsjrMdbkecGpxXhw168+MPIZE8UFKUb9ynY2c3nhWS2mG/0Lclewcay1UStKGEpdBg6timdj4Tbzo2KCBAetDuVQKF8AsF9YvhZv6gM7LklIcgtM0LSqt5PDc/n4oZxO4dsbLHF8wTSkQaWVG6AqO89ApJ57USuEWQ3+5FFZ8bU/hqMfRwzfIA4pajiHo+wTF+dC7gnjdEwaC/Brj/B66/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdQHOqsdmME/QQJcrJTQrd/WxGTxLz49mMms5Smy3Qg=;
 b=syIQPnbFtuoJOJygq5Ys3G/w5iUmlIDBGl5LGGhcc0gaEUsT1KDW6E+1Pkr+qpOtBrnBbv5cIl2kQsXPTbJ9Wu7NwTiqC3sHkNfY0gzZ8CqKYtKU8RZBSPh8rEqXW1wWVQoY3Yc4iBCvRxa2egxbWbc4Tq3QnSoSNk4HDaF45MZSDE3INV83VUJeVBxsiqg9wUts5MprwawPBRjcdrmhC0hlum68li85UNlTCJU4i25CqkoSrBor27gptLukJcFEftzfOQRwImOBJnV7TuCRviTI2min6YF+iskfdf7Y2ye0WHNgd5z9zLARzfnKCZNPpa54ccltvoByxpuTU49G2w==
Received: from BN9PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:fb::31)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 08:38:36 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::59) by BN9PR03CA0056.outlook.office365.com
 (2603:10b6:408:fb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 08:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.22 via Frontend Transport; Tue, 13 Jun 2023 08:38:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 13 Jun 2023
 01:38:28 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 13 Jun 2023 01:38:28 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 13 Jun 2023 01:38:28 -0700
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
Subject: Re: [PATCH 4.19 00/23] 4.19.286-rc1 review
In-Reply-To: <20230612101651.138592130@linuxfoundation.org>
References: <20230612101651.138592130@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <ca8ccdb5-8475-488b-8f32-ba7a703f08bf@drhqmail202.nvidia.com>
Date:   Tue, 13 Jun 2023 01:38:28 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT037:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: bcfec190-6d86-4613-4c00-08db6be9942a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SB/UHKO3dkamJPajxitQFlfDTVGhgyobZL4U/LRO+AatCCoVN0LpuBjBj3/HOGpHuuq5BY7Is6DM6w8p8BByRvIf/z1oHQKQJhj5EryMQNH7QzspOs3vn6DiVyKFuEYzu/MD3ND0Niswz0tUtn+La18rEt2gVD0X9b+8uLsPquTXtjNjQU7pX7BZ6brSqLc8S36HteEL0mhkbd8DOVd7VkzeNXI6HeD2dxH29y6jAk/rAR/q1JheT2I+GHkCjcNLG9GVWv15dF060qYIV8Zp503JBZm7/tkKzUTn7pHpbFitOuib0zIUhGP9QuQ3GlURZAQmlQ87rHZngkG9y6/WYvsElKpRHMMlKW4uakD3nVT8LV7AlJ/ow2b3D1v9WtnTAIyjgvmDUtH8By9jOzuHCDSpzC0bze9+oxz2/4NnbsveZ4oBWZwk+3zIj+BTpzNPy0u47++23/Tjb4ErKE6kO1phfCDfr+GH/nUsT18obbvVGyKyFlzs9oGJnZFbpTT5PI7fRj0Ev6lZEZU0MDaXZibX1xnc5T5k1uyB8dZ1yONJ/tfEFeoDFPA9+XYtUsELIkQfwGkvBlAd0vdv+5D0aIq0BSanLijAiHTkOBv4VXqbCYnjTqzhnbZmQeHj8Kt+g1YFkBHDFzMxnMWSQstApIDQ2iyYzlMEzdj+n6DE1fnIdZ5+ObmUBpo5jRG3EJcWL0OSzWMzp+UmlbhBspmpUxkEXguVbtv1ShNJYfJy58PyQcLJ+tskA761QZ0xSs6hnNT3jNZeick67N+UixDIjc0nbFZyollwrNicA/OY3yk=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(4326008)(70206006)(31686004)(2906002)(70586007)(40480700001)(82740400003)(186003)(316002)(26005)(40460700003)(86362001)(5660300002)(8676002)(6916009)(8936002)(7416002)(41300700001)(31696002)(356005)(54906003)(966005)(478600001)(36860700001)(426003)(82310400005)(7636003)(47076005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 08:38:35.8221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfec190-6d86-4613-4c00-08db6be9942a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252
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

On Mon, 12 Jun 2023 12:26:01 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.286 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.286-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    22 boots:	22 pass, 0 fail
    40 tests:	40 pass, 0 fail

Linux version:	4.19.286-rc1-g0312c44fe575
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
