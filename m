Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A273768DC8F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjBGPIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjBGPI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:08:28 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085AD2F7B9;
        Tue,  7 Feb 2023 07:08:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFFma4vJiTm54RISCyDzJzUVEfhI3uPMMVyHidv9TZXff7SEpg6/xWVoqudoTd5CVWAdoPEugNzxz3Qumc3DO/YNUxhyd9tNmNj/V8tbrnb6oag7WMUgLEEyHBo5UxtKw8BfgmYEJoS6kQt1Gmr83sub24301vGKV+i+sl3KapOJL77hP6FZ+w4wySyV42xehQQw0fpdWPgxVV1/nwjIbTaHAJJC9WROm5qWCfsy40izLDvzyJnAjcHYPuMZ/FNDBDGTBg/+SKVyl0X+fv4nlGGeTdvF1e1Qh9TpgP2F7st5OlCzb9ilpGTsGJ91vwCebdygTe9P+0+SmgKGwtiyEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B1VyWzjcf5HhZyZt4z5ccNoAqFvujFXI8YD1F8LpE0=;
 b=dBR+jFgEbdgioimEMwFGzV6yuX6h5bBDLKrMTsDf9CwjA8Pd3je3et/ULHu6Hx9kuXsG+vpqszu8C1z/n0KCedxCxpZHSy0fcnKFFuNQzW4aO/l1aPj10b8tzW8liOqUlsGZzyGfdPGCIjNf6NwRyhsomT1qWPOjCHr182KEB5IaOt+XvK3kqwGbNl5uL9PTItNnJky1x6rSJtLN/951XUJ3nf0a130xVcfYVcxSlloG4tl8kJ708hukjG/w8SG5qQAlCO2Dw7qEQc1gsALYut6dmGmVxJR0krPy2q3KTMHn52RBJU21RsTFlqHt0YdwB2yOkbW8wDhCIDJo4Dmmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3B1VyWzjcf5HhZyZt4z5ccNoAqFvujFXI8YD1F8LpE0=;
 b=E3u4Xo5rLE/Y9R8rRuOFimab+msj8cQoNVd2HNMy4+wUS+pbgsXuTeRYvlls47H15hJFpk2mfg6KQ3G1Hk/gPggHkEbzugcFlRjx5h1M/lHTAgIe6A+GOyzOeoNnLlULvD0xEp3QNs0CfevKT2LfTj+NacECJGCDBvUiXzNpdCu7x5D2O2hfL1UgeiVV+UmyEDcl3rCXXW8tS8XBtJ4Kql0i3AtruDJcs8nTB5WIowtYSRBKwp/N3WLQRGgkAjmV75xg9PqJXTVhCqrytNxDp+qc/AYwCaLymmwtmNEuPuKBL276SUTOT44hbcxRyAhNzlW7d3bQ7nGVy7r3/lZBmQ==
Received: from BN9PR03CA0637.namprd03.prod.outlook.com (2603:10b6:408:13b::12)
 by DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 15:08:20 +0000
Received: from BL02EPF000108E9.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::14) by BN9PR03CA0637.outlook.office365.com
 (2603:10b6:408:13b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35 via Frontend
 Transport; Tue, 7 Feb 2023 15:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000108E9.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.16 via Frontend Transport; Tue, 7 Feb 2023 15:08:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 07:08:08 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 07:08:08 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 7 Feb 2023 07:08:07 -0800
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
Subject: Re: [PATCH 6.1 000/208] 6.1.11-rc1 review
In-Reply-To: <20230207125634.292109991@linuxfoundation.org>
References: <20230207125634.292109991@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <39b1a1f5-9c2e-4cc4-824d-a787ecc8315a@rnnvmail202.nvidia.com>
Date:   Tue, 7 Feb 2023 07:08:07 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E9:EE_|DS7PR12MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e09b0da-f470-49df-5920-08db091d2636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9QNWbqLyuT/yrOeO71QFOxwAHMjrL8OTIr+j6gXLmQ4M5hW8qs203qwIbR9+bCKcg66W47tOxIMhUsxbciAiBfcwxdQclWbBs+Z7cPad57sBfwKXDrfPXTWLR0l9Iwq5sMnIbx+eL8IsgtPaMRW5O4zgu+2TESupDeVqIk5HnZhmsTvS9a0Bk0KbvmvsoOzb1eB1MK9zgNMNormArIQ7cWKF2XXEotNAWRk0o0fEi+vAT65JKOfqxjrXjCPQifnViHVlG+jTqgNu8HNHRrCqidqN0bfS1XPLpwFZlmItJYYpIUT6vFQ4ZZgNgxIstUn3lAP+IipEyjjandr6i3Y7c9mHEtvHJwYBk1RAb1r2lPRSTZYsIRD0Hh++j1PnKCC7AHofLBvXRlDphqflCxv1FVsmKRZF4J9x8HHLVXiweyUFudJYvW3QhYB/q7pGcHeNHAaRap5ojJHoKgbD11hBTp4old1hs2es2Yg3ey2z10FV5h/aEKLLdJIPBMNvWtcabsPKSlTqSWP1dtTggu0bPWlRmZ9wY+n2FX05DUSpF3LpmXzRTHo+epatjCqY/nR210QeJ3P0/q3cBpY4R8aNSUzTQeej6MS38cPQVjM5+pyhNvUwzoCROa8qIz2f2rj5jO00xddQt/4XMGnxnWyyqypBHODSfJt1tP9AnhRYVMYiReUEsE7CoWVeIu0CNFx/LzEwYh6Av+gjncawGS91kTDvxyy9Y/LQe6EIUnxg9h+kPu9ixmTTWXjcUXR798hSPZDq7Gr4VZD1/Y0XsrITcGqBO5PpM2bzRcS08BiqpA=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199018)(46966006)(40470700004)(36840700001)(36860700001)(31696002)(40460700003)(86362001)(356005)(82740400003)(7636003)(7416002)(41300700001)(8936002)(4326008)(8676002)(316002)(5660300002)(70586007)(54906003)(478600001)(40480700001)(426003)(47076005)(336012)(966005)(82310400005)(186003)(26005)(2906002)(6916009)(70206006)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 15:08:20.0823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e09b0da-f470-49df-5920-08db091d2636
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Feb 2023 13:54:14 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.11 release.
> There are 208 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Feb 2023 12:55:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.11-rc1.gz
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

Linux version:	6.1.11-rc1-g78e134c7117c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
