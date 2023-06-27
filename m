Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911CB73F817
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjF0JEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjF0JEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:04:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE42F7;
        Tue, 27 Jun 2023 02:04:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB5zpfA8glo+ynGVbwCMQ+WhF7hyv23f7R8csRaTspYsI/ND2Swrv2dfVm41/XYqB5eHEV6cA7h7g9ciDODkZv8ohRip5uzOsWp95vVYQX9MHtzsp8gS9JWwp2zCDv68m2RP72ptrAzoZ4dIDk+bAXw9z6e7isjDCSv42Zb0H+fialJl6uaCOM8liRi2nsn5hXrQPSwbVdoWc+jgnXnoHc/qOlR7ahEaGWMMv6KQRpPk6p8CEjLxfj/hEUaVbKRFe/AQRQlfw9sU19K9lycLYIGSGIpug6PJt7obSUf8IeZtVxrdHfIikchDX4pWO8Shh+GtLIMe0hOalXhKQoNlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9b89EzISxBwXVsONoEtkzV8jayTk4gyfGPaU/Wbsrk=;
 b=flntUZsTioGBZaWB8nl32Ko6O+AdO+Iuk9jygVb4Cbl4q1cmx98prFTx9/j92IZXmwMv5NC9Oh0KPVPhI5Q9wsh7i+UTjjhuBmoConnazmk4+us//FwNp1WzR5hmoh1hF5W+E7mbnYryiQcTBAb1zU9WVxwX9sdckMbKxf70zlWMIHCvYFdZLtv13Rn2wHw3h/y2NxCZoeVSvnA9rT3jKpZRJ9P1izQBSyidzw5G5iYu6lVMVACLMSmJvrYidqSK6lHsL52K0goBaRHhCsniINM3ZNx4PgPRFJQZI8F119QQ2sjU2FaCEnrm3910btriiBfMUWfPCIQLLa95lCcQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9b89EzISxBwXVsONoEtkzV8jayTk4gyfGPaU/Wbsrk=;
 b=OBL0H/BhFn8a9BzOh8YdmZaGeqhKurH8HX/A+/NHcbTs0ZcwwlLoZ7y5wQll70IAQgJGJdsZN9FXE8DzSR+pPd+iLt82jYjrD/pycUmFjm/1w8kqEv39F2m0Mej9upy+4inehanADpmTm49Lgj1b1f9wPuXHOe6rf/myorf7p6elELOWj0aUHNc3ILxo83V7hzGQrdjOHJLbZ2NrJzzgvX+nueClDKkwfTbzs4DpANKYs+E5sEvlxd/XflHtCjFAXdASPBpB5YKA+uU0QScLF2FNja8EXLafhO2iUbbFq/VexrHaelJKXi9+JqBKCwGmfLsEQs0ctY74gABmObwMVA==
Received: from BN0PR04CA0161.namprd04.prod.outlook.com (2603:10b6:408:eb::16)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Tue, 27 Jun 2023 09:04:36 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::af) by BN0PR04CA0161.outlook.office365.com
 (2603:10b6:408:eb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Tue, 27 Jun 2023 09:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 09:04:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 27 Jun 2023
 02:04:26 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 27 Jun 2023 02:04:25 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 27 Jun 2023 02:04:25 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 4.14 00/26] 4.14.320-rc1 review
In-Reply-To: <20230626180733.699092073@linuxfoundation.org>
References: <20230626180733.699092073@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <608095a8-ded0-4b3b-8c71-22227d24b01e@drhqmail202.nvidia.com>
Date:   Tue, 27 Jun 2023 02:04:25 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: c7062adf-d543-4823-b50b-08db76ed87cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygtqByerMDUfa+XoYrTVgcPkzvnDVv4p8ZARIpEM1FcUxAq+7cXMD0IevrtYDuFwDyleilP/GTST+AwdiRav6q23cM7bWK0mbKEZoGX+jZMR9Bj8h5pDWM+VK8Fg81Hr+CJFRCALsp+W7JPqsZzvpoQl1QaG2HipQVACULtu1+2ojr9gYLOiAFxnECFsCbCKm2T2EQXh1z+7YLjmL/BWI5E2RYXp3yAietk9qHFt2KZ3TsJh7FyqGrxnBKVV0kpzuHpKQIx1U19y5ZaEpeLkcV/zsg/Dmlf+ffmE4TGTkE36s0SCUqsWNbt6dbWnOYAQzJ/YYWgt3PnlO24TFx4gTH6mrt5ADi9SRzqDIseO5HBmmDy8TJmjyGG1r2PJVZE9Y5rArjPNZbhJl6Vav3RxFkOnYMBw/LrWGh+S66uZeJXc6X8ibwKypiAFmxXszieNVuM6fADpANH2gl8Iqw2w0VvOWzQdnOjcQwgNhiJBDoqLPNbji0ncyZz2zTPNYiIzgCrSJTqXChtOuMJ1oT4v131AOvCsVqq3ap4IK4eG1nzMOO+cgRJpoPUeXxr/RE7mmlKoJRhbnPlSDGNe9y5Nm06h8OxfFQGbZhzMgx1k2j6zerDKQbi1XbbhGNqkdnMowpU2qLvbAIDpxBw60LY2Q/33l7iP3Qd76oIozfWzK1IyO/6T6PN7TL6HHUi8CnQapCw++ZsjgUdU2kfxz8BPxaWFELjGPfpStVht5/BGWSd5rPKcp4roP2TdZ75XnNTQR5EsnxgHhD1vEl2KaW3giZRLZS4F6TXrnKI206wxHe0=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(2906002)(186003)(82310400005)(82740400003)(7636003)(47076005)(336012)(426003)(26005)(356005)(36860700001)(40460700003)(966005)(40480700001)(31696002)(41300700001)(54906003)(86362001)(70206006)(316002)(478600001)(4326008)(6916009)(70586007)(31686004)(7416002)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 09:04:35.8758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7062adf-d543-4823-b50b-08db76ed87cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
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

On Mon, 26 Jun 2023 20:11:02 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.320 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.320-rc1.gz
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

Linux version:	4.14.320-rc1-g11aa1c2697f5
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
