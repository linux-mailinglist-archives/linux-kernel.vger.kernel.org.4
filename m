Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3CF70DDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbjEWNkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbjEWNkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:40:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAE818C;
        Tue, 23 May 2023 06:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U++096uKNySWhC7McKSrpKRHDIHElb2ecbioNzeIKzFamAFzFW0WOpGVh6/U9NkBwE04XS7nGgGbO7N3LxbEtX+iFGibw3v7Tbxv5Ew+YOnRkmTd+W3O1XwD8voFWR99gwDRRCzObOEFG07It+eYrqQJ0DpLdtU1lGPOaPdESLA797+jLBHOXoACLcYUmS2HTnuCntMD4DCXaTIBpF7kJOFMRlZsIllpRwqP3nk9cATlT/w9f/6l8A0PGETl2wnjLDiutzcqlXrgHxYrWFiGEnSL5dwUj+USZTvVJBxLukzb+Blxc75SSx//TD2kxUcrgD1crDjatrudiEOshZO37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ1V7LOq15l08JpV8EHt/CrVVSEyBvr65FTTso1htqs=;
 b=OKaTgueCVYORUS16sI+IKd1RLqS2cxBrmYGouseNxd21tlNffsdSfvnJ+fSXh5BMfNBM4OC6A6N9Z9kC5NrbnJZdOIIVtw+5CaS9TPiF+3miQtMzHFmJrmt5ySXvebueDwccEg/KuwpSxCvY3pM8smLvKxMCZ3ir5KusTTtFRjD26A5cycAJ0KsazVEUXpbBKC3m7LHEL/vyI80Ntkx/nEn9KSDZiavvQPuZ0K1nAUBZf84GLuEo8Gb0KKCzOHg4PificFyUPRcQ5Jwa/e4S8iFc4RckUrPDKYfcgEKw2RTNO1fZ/tscgNbWAp1YIG1XbhbigsTqH00Cl/Qu5KseVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ1V7LOq15l08JpV8EHt/CrVVSEyBvr65FTTso1htqs=;
 b=N7cDha0QJNF8mLcnsJgHjLscifArWp3asVebs5i5rNsT1JUYzarRAD85SuHFBC4QIvZ+/Aab920ZnojGhuXJYYi+Hzig6aB06oQIA/KTqaMmECdaC7QNHG1uBM7LTVuJc1TYD9bNidjt0Pq0L+/cUH5nVXGP2Q5GGzim3d4uWrZvJVCXzA7qL+zTvfCx4tGyUokXdiWH7UBDrl/Pf05KCLz7HbtjegnFDFJbeFQyEaUaAOEiqWGsfrHIn5UwSoR8kICquDQxreGe+fEO1QzP+Kwu+1dLqBRGkQzUahDxuE12+CxR++OEGx7zTsOxCTfHgv+mv3ENKtLH/nobCa1Tgw==
Received: from MW4PR03CA0061.namprd03.prod.outlook.com (2603:10b6:303:b6::6)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 13:40:33 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::d4) by MW4PR03CA0061.outlook.office365.com
 (2603:10b6:303:b6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 13:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 13:40:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 23 May 2023
 06:40:21 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 23 May 2023 06:40:20 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 23 May 2023 06:40:20 -0700
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
Subject: Re: [PATCH 6.3 000/364] 6.3.4-rc1 review
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <c83a2629-2765-4192-8582-23a6da26ed88@drhqmail202.nvidia.com>
Date:   Tue, 23 May 2023 06:40:20 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|BN9PR12MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c0c49e-e767-40f0-e48a-08db5b9346fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WhxxjkWIdpvlo6s2bRyVDKKwi4gwa53E7a59BS/wRPRqlfoAzxi/gCCH0AYBZBFnJ2RIhcjO3rM7xBFmK/2HI1+4ZlMC93w6o8xxHYzW1pE4BHKOG1YBzvxKcCh8Ce/h1av39POBhO3psy5KugwYhjvv/vodqR2ceULFafw90APOIOR8jC3DKNpbwLZ4ksWH79JgOm4vIU6k/W3r00QjOMO2TTjQSjV6JRfvznCO0CkaG7GvXVsvEORw/VdTPP2l0DuaBuG9mUeuol33JLRfmVrPMXF0WDCqbAgEP9TYjsRBt4rxU3rsTnOMo/4Z7F2p7rTvHKrf6GPR5v2FhZvbaE3/EP2HCl4CFs0m3JKDU1m24kOFX8nuULxWAEPgwHQnh1Bo6AP74gvN+P0gPHMjNv8eAG65xVkzFxHIhToDbArNGLLvT6/FGSVe6GTTnihLNxmsrlmDRzkYwHdzXLJHerqGS8D888M14MsiCvctSMZ1twbWTvA0tLBPs/sFwhkKVv9D7xC/PLYkKZ1LGFZtKdL3ynBI2AkPf4nS1RiVaYuVI9ZCbi6Pn3hPwPjvC2OHMsuB3h8yYr0mvDpE9lO2Z5GKvjoilMBoh2hRuFxNAB5NOtYSIXipp5Q0o3vd304LEr5jzDI59q3rH6YF/W8Zqoz4cItw7YvQdm/vCyZcLLejl6djVkbBO73DdWXRGY526uyMGzN9rX68eCD3QlkKRWvhlnrx/TmK7m5BTYO7HhXcWKp3nJ2b9HYnNWExHGkbpJ9gsIko7ZaG4Cn4RkxfngXWqgloCpTZOwAF/0+EfDU=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(31686004)(82310400005)(70586007)(70206006)(6916009)(478600001)(31696002)(41300700001)(966005)(54906003)(316002)(4326008)(86362001)(8936002)(8676002)(5660300002)(356005)(26005)(7636003)(186003)(82740400003)(40460700003)(7416002)(426003)(2906002)(40480700001)(336012)(36860700001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 13:40:31.1287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c0c49e-e767-40f0-e48a-08db5b9346fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
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

On Mon, 22 May 2023 20:05:05 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.4 release.
> There are 364 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.3:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.3.4-rc1-g20efcce0526d
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
