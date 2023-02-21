Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FB069E22B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjBUOUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbjBUOUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:20:21 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12hn2227.outbound.protection.outlook.com [52.100.167.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D2E1E5C4;
        Tue, 21 Feb 2023 06:20:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn4ub+27rfagKLqUD6GvbzJDpQv1MGm6xei/mZ4FUUYC4Pr0i1i/PzGUCpAm4N0cjhqTqwIsxh4CT/3q3vFPzcyiwprJsp3/NyHQdo1mqq8ep0eLXTwIAXtwDL7LcAFC1C2YbKHzdtd+Xc/K5r63Bm6uL1oYH4VclwLkFoiIk3oMdQ16Via2Cjs69WemzZ2zpMXJtFf7tSZKxYN1x/mPOxBILUGlFryww3EBObChrWV/c8LoOvGQhKfHaekY0x+UBe16mN+oTz2V2m6ujeBfZ4lMuGu1aE51TgV1fCwwNpBp18eh6WVvbSTn4Dqble9zcXooy6Da5ga/TrFYAICcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikm3ndJSc7mhe1FNwfqsCY/kB9lW5boWuKAmkTzFpG8=;
 b=aMbISPD703ENxe21qiDxbT/0cQKVTSukyqlPa55BAQwCdMVwjGkE36i6LTLv5tLZyqF4V5I3+fxiWmAFJOKKhI7XTarXTN4GzIIGe8FAtHtrC8OgT2JasQjL1J3NPS0529ZGJ0nBi+20EFILcsqTvycIZGRsOhA5lChAQVDcscqJl97qct5fpW2DEzJUb+1oVrWSmxUvzEerX9eaYbVM2V4gKydRStyZohSTHl0mM99S+K1Gp8/YP3XA2dyFnSphLp8pDCHHQ+Zi0cBgpAHcSm0DjRhPL/xYWq/XIrzhM/HPyo9WEkDde/P1qTrXTa55OhICcBeh9wfstJeANhQrig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikm3ndJSc7mhe1FNwfqsCY/kB9lW5boWuKAmkTzFpG8=;
 b=LKY2QdgkWqlSw/uUmHisQHuOhoGSSzJ0YPX/eIuHznJ4m7A14zIFDPh0+BNWS/UImKpM1qMJJ6QddXgUePPby+90SOlf//fozgpSfPgYTTJ0ATUHIsUl4lqLJtJRPkgEXW+9HrH3FhIBBv51BWsz5EMEXvnTBja9k4siQRGTXrvpf1mVvl0XW4+0+AdWn9xrVY/9neWsmuwT+HiVZEKtpTSFkzNe7/yJ/IKPwacVWJ7PZFACVEOR3glTou+ou4jwpyB+Tw5xgR+V/Er6BpA8iAVZ36PF8SWli08s5ojjdkxi0A4Lqttzz3SiijWvY+A5Lfk7ORdSxK4JFm9iTIrVuw==
Received: from BN9PR03CA0617.namprd03.prod.outlook.com (2603:10b6:408:106::22)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 14:20:18 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::e9) by BN9PR03CA0617.outlook.office365.com
 (2603:10b6:408:106::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Tue, 21 Feb 2023 14:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.20 via Frontend Transport; Tue, 21 Feb 2023 14:20:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 21 Feb
 2023 06:20:05 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 21 Feb
 2023 06:20:05 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 21 Feb 2023 06:20:05 -0800
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
Subject: Re: [PATCH 4.14 00/53] 4.14.306-rc1 review
In-Reply-To: <20230220133548.158615609@linuxfoundation.org>
References: <20230220133548.158615609@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <8ff9bac8-8bdd-4a09-a6cb-61dc10a13d2d@rnnvmail203.nvidia.com>
Date:   Tue, 21 Feb 2023 06:20:05 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|DM6PR12MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a81252-10fb-44e0-4341-08db1416c279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NHeij7yj7NYOb4WnfMZYqXHq6p2I4y0YQlHBYNhHsqhipYajDTOrzIxKtL69JmHNQAG5/oWNddi4FtZy6OhSagNEvrQmm3dckMp2IHiKW79DCFssPSSO7fHYeq9bHoTeTC27YsX1mtpnH4d7hy1sL2pEnkOmLdd/ly35+WkbHdihqx7thQQ5xFGR5cLtDrSRLvBJfwtLtAK22WqTshQUKhnryFHvgn+DpsUhrf05CItO87BMAojBKUVwr/ip82fYme22J8kzeY0If4lYPEi429pcykHetrOwH0jq48GDf9KAALziOGNd64Ik/RVoGSNecXMMM4oWO3CDEW30jnZZ2+GQMa46i+KP4yToIvgZlIP0KGpC1i9BWMfpoYdBJHN8Nl7E3c28l2O2SyvKXWTvRZ7rQDMaBjPN5juTnMWrkk4wvpceh3WiOD9ff2YxIMVpuSYus8GD/KjvvZLcIHbxi/fitqfe2T+8H4i4t/hSg0EHfX0VMfH8Nrn0agKRKM9iiJepU7ZcO3Ee+aYDUAhpRp3dLm7ajUo/XZx0s2jBJ3DR3DzrCW3NRTYQYMNII+tBimhyfji8t3JBPJMi35LzkvL9nQs6fEkP9mEs/Vz8S0OuV0Y2Dy+9v+G8j//ccAcfZxD1Cy3Rjk8RPsESYMQ8pg89oSivhdR06FbGAxatHq0sfUXX5k29v77FlqLWPtbTw14QJ/TXVIUFOHCiqhR6izHqNlEewfYDGXRqZFsPWFtmzCFcIS8DjmL46P1faUztZbVmXGmsIupACOXZHwaPkA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(376002)(346002)(5400799012)(451199018)(36840700001)(46966006)(336012)(31686004)(966005)(5660300002)(36860700001)(34070700002)(7416002)(26005)(186003)(426003)(47076005)(478600001)(316002)(356005)(8676002)(6916009)(41300700001)(8936002)(40480700001)(4326008)(70206006)(70586007)(7636003)(54906003)(82310400005)(86362001)(31696002)(82740400003)(2906002)(12100799015);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 14:20:18.5589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a81252-10fb-44e0-4341-08db1416c279
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023 14:35:26 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.306 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Feb 2023 13:35:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.306-rc1.gz
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

Linux version:	4.14.306-rc1-g2fbaf74fe657
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
