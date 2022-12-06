Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E366449AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbiLFQr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiLFQq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:46:59 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55315BB0;
        Tue,  6 Dec 2022 08:46:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emwaKE/18Lk3IFyRFTiJBNQELBQLxLsnu2A/V6kO8Vuf7U97sWG1xgzs6wrmkqSo/SCMUlYi3nYawsSC2qrq3Mwun+OupFFV/8YAjb9T6b6WHIWKAvZ3PwldsnWVQcNjtOglDiUX7QD/9L/o4fFH5f7mphlOeeGSKZPxQbQMxqtvEhsOqDCD7x+nWN8I2TLJyTkNIqtIZuqQyjUc3aMM+ApNbbL7SCRtdpuf8aVKH3j4ji4e+8EEblK2HOWnkiqCF1kSkyp5oHceFeHNTQO26SSwYSdr2pmLvIsOOlhylzqNp7baUAKkOoV6HHaRxXjo7IT+teYYLJSRSSw8TpSXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFbZnMORQ+mFDcPLWFHvTwlGlURGmSdbTDqF7hSLjpw=;
 b=hfOxWAoVmZgDHaBZV5LDek0IGyBq2GzYBZtSs1T6N8oED2AQyujSri4CA6+mbQAAcyDwG/F7V7x52M2q/lY2qZTfV2OeUZ0YT36ApNrjvWs3ecATigtZc8Mqu7LDUl0G/9mys6sUIBf8/DcR2f+koPaLuB8jyMhhQh7HDhRtk34kr+er2SERE7+rH6fz946viFHA9VX6V+eAaP8TiP6FbAg7d2KPqtoJGCQkPvzwADSkTgjHYEsBJ4s1MV5rXYpfk/gwM59Frwwm5di004zUuyGHly8STwoCYq1q0XZFJwgawuogZeKdXfLkXI4Rg1x1Tj/hR4sEPFopduSZzjVK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFbZnMORQ+mFDcPLWFHvTwlGlURGmSdbTDqF7hSLjpw=;
 b=RQB2OPf+W6Am1IGk9rd303TuOvb37IiyfuRv5b7Qkwbic1rPJdYWn+SuN2So366Mzt8F9FXSokTKcJd5OxvnA5tMJzv1nok3/OIhIPkqtIjNc502UEtd+mbJNcYmlECi1ogla/QZB/v+yD4MIff+2Pij4appnbavY/Rwge09PQQpeEcEbTdDzy8qjAhprsRCx0UEpyz6FKhC3RZnHK057yIcIUmG0YRU2Ta6Ck0Any+vuFv4YGjbEtbkyvPzk6U76g8k40U2XPva8zvFw6wZbGtsvrZA+HxMdEn1Cg/QyqVYNSUFBYYL0IH+/HCtd1ghPSph7XrO2IrqCaJhocszFA==
Received: from BN0PR04CA0204.namprd04.prod.outlook.com (2603:10b6:408:e9::29)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 16:46:57 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::a7) by BN0PR04CA0204.outlook.office365.com
 (2603:10b6:408:e9::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 16:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.14 via Frontend Transport; Tue, 6 Dec 2022 16:46:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 08:46:43 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 08:46:42 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 6 Dec 2022 08:46:42 -0800
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
Subject: Re: [PATCH 4.19 000/110] 4.19.268-rc2 review
In-Reply-To: <20221206124049.108349681@linuxfoundation.org>
References: <20221206124049.108349681@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <90b07aa0-fdd0-4bf2-80a5-59c941650d55@rnnvmail202.nvidia.com>
Date:   Tue, 6 Dec 2022 08:46:42 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7be44b-c3e7-4cce-ee01-08dad7a97d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVneEjcCx/PS9jjJh0C/IZ0rC+iFOKTswAYnUPyoypevB3CUEZjgfqcAYAl3TvfRXofBjcdi6ZXKbZxIWSacjBsIUfFYB7OvJnQDUgkWtr3upExlZ8wbLxKjzVMWxdUuPzCx8Mo/QuaUvMsIrkhs9afPjdm79SZqvDyihs1Ep7Zs2s5LnRoIKl3FdTJ4aTcwIUczrvin6cXGWqSw6g+BAtSBvJwAZegK0xD7mVYooLNBkboLjgUHIp8RQLJexaRLF1JP8v0HKH4SDklVE6uzHEP6Rk0aNV5Z8VqlWruXh/Gs+q2wuz/saFv6YKUJsVNJAmcKrdNt21UrNRB4g0ujkYU5GFIEU1DPQI+V+oHRWSDmgsQw7h6dJteKkXa3PWQcw3p94xaAsh3IxrDoXW0VxtRmxXLuw+KnISLqkFutmjnEbSch/uV6oO4uzFb7zmQ70UJ+y8xYMhCGV4Pr2U/bJYMC0xlHwziyge8jmeaQGlcrEgVc+us8uxLGUc1BuJUaoQDGztDSdFqgzLBO0PQyZlcCE11OFCQ2RbYAha0xT8cQqnBAaoIPfbymyWxv5nkssjecYfW/POvXvkZGmQAdMBNbkiKnj/4YHdVqA3HiiQu7BhwyNMZN+EeprzBQYE4P8FHJx47J9yd9nnM2LcAkXWhWRrl8VCERhdkrlp0nJ9bk8c5r+BkBu9k9O6jo06Hz/s6omAipuCrpvzYM82Mop14dT1/x3w43rqVeZAzzBZZowWkDH2RjZZMh2woT0ZFd729x6GG6/Z05mme6VKXQYJk9CcHAewFJQ1JvmVQACgo=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(7636003)(31696002)(86362001)(8936002)(356005)(82740400003)(5660300002)(7416002)(41300700001)(4326008)(2906002)(40460700003)(82310400005)(478600001)(8676002)(40480700001)(186003)(26005)(336012)(426003)(47076005)(6916009)(54906003)(966005)(316002)(70206006)(70586007)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 16:46:57.4945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7be44b-c3e7-4cce-ee01-08dad7a97d3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2022 13:42:00 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.268 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 08 Dec 2022 12:40:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.268-rc2.gz
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

Linux version:	4.19.268-rc2-g4ab1b9441157
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
