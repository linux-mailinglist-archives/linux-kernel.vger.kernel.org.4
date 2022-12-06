Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33036449AB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbiLFQrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbiLFQq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:46:57 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14402C7E;
        Tue,  6 Dec 2022 08:46:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XApR5zZXVyfqgMDKs9JkPfW2txN3DNFifAO3mhaM6s01Qt64j+N9Z7Dxw1C4/9N5X3r3n1U2TtY0zvwVyI1K+isZ6suAoEi3Vn9I/u2iRtgyEfcv7xj9wAm5T1k2u4xwQMs7SV3ghpzP2eOD1Ic0e8To727jNVtfyNYbo7b/viJA+Zdd1nTCD2P681z5+9BiUfJmJw0+PEQTbXNpH403oCX31HwZJk2dmMCSqe40Pccg9lECberqc2bQ2LlvIsIv+b43CGbfumITLVA73HdiD6Kp93obpU4ljsvInHbquiyxsj1W+/lJWJAlxmDCl0PWOYf8rlL82jvlMwIsV0n/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QJ+4mtqYCJdJdgS4FFsyUuqAuPl9cMp6oSE2JJ2k4c=;
 b=lSGBEkMgNiFpAnJDCubkJMilJS1x3UrHEWBqhutqfjsVk9+76GC98QW/X0+MQbP7SADb/eUOrmcaw7Q96Mix3PDvMaln8d4f3iYs5X90BEyy3V0EoMB8+qMIqogp/cT050SGkdk5Ok3c2R+APHa/Lu2tdAqdacXyi5AHxy3O1NDNKvxqrNZ4iFymUY5RSlStoq/eBDPj0n77V8LKMK9qHVCvUmTDXzHJyQnZk6s/QOWhlhaUwsXMoz18DM1TMkKKvb6YxCRT9jJ46oeRIEJ8FSwbApI0nRaON6OJ9fS68wnP0kt31JzcfWguJuszdLP3JobTLwTwkC33GgmT1TQZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QJ+4mtqYCJdJdgS4FFsyUuqAuPl9cMp6oSE2JJ2k4c=;
 b=T+qXqolWUw1BAYidZX8MBBszLaQwMbRPpdjLRB/8RTI1f5IO/wP2Eo7obhSNIHdqy+36IYZOEuS0bkfN0bnVEE7ls1ZWCRhg1DFnXOk6xLbSi04bGee8vh+fFGqtWJlYGcA8CW1KufEf/ocQBUY08wc9ILavpto5KhYdi1tXNCObuhLUHFY9CkM1jp7Jp5Z9p8N0WZ52ZGeUIhJ86IiloDjMRGZaPi3di3p8Zfh3s6apQXNxmD3lLHzuBXL/WT2cDfQ06ybN2/TR0ON/8uVWHi5TCPYKD6RI7siJMa62o2zbIvXL0jTCvPh6wUG6QUN4JWNQnOvIUhWW7BddQgem7Q==
Received: from MW4PR03CA0162.namprd03.prod.outlook.com (2603:10b6:303:8d::17)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 16:46:55 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::41) by MW4PR03CA0162.outlook.office365.com
 (2603:10b6:303:8d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 16:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.14 via Frontend Transport; Tue, 6 Dec 2022 16:46:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 08:46:44 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 6 Dec 2022 08:46:43 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 6 Dec 2022 08:46:43 -0800
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
Subject: Re: [PATCH 5.4 000/157] 5.4.226-rc2 review
In-Reply-To: <20221206124054.310184563@linuxfoundation.org>
References: <20221206124054.310184563@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <2a329f82-2903-4100-a7d2-d91ec95aaafa@drhqmail203.nvidia.com>
Date:   Tue, 6 Dec 2022 08:46:43 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f914bc-f12e-4bf7-7643-08dad7a97be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xi+Xr3y32j/r2N8ClQUyCu0Adjl79qjcZnnGf9Io9LcH42uoId9E+BRU4pbfrzhP/OQ442UOT8/E3qu26HgXWHHh2Q+E7OXMiTpWVSkaWyfHOEx9JLg2e1GOeGFbyhBXEzqvKcRgzss8vpM5IViYLGfvhDbHTckMeaAr1q0IE+c5YNjPeCIHtdu+1pHI0PY9U1JTGOGEuJiN+yCGW59REgSQN62xNe70NdNoSw7uS9E74Hnapo8XPLZ/4kb/FCwHUlAVk+4lVgimTTkI1wS1+N4IzppWIzgVuUQU6hQ6uvkp/n0019D3gbueOCqq5qpTDI7Jm6OzECW6ovDCJJKGK0UPf+dyUd6VuvR24RLBg+qeztk6XqnO6dRyDl99YKxsBXObfUSFPaSHo+rC24fYjufB4uO45+EDCeEplfK+6YyAknIu5uU9cvyL+WG4BXDn67xumKR4T1+DY4ZH/m726yKnW8YrT+Yj0giJ803NsFqR+qQXy/YuIjzM1xT5s+d/1mHC/3DH35KOOtv8itYYAnO7pNgOP7U3hr5CIjvjx18+u7BzK0kdE4O6qWLnOyV2y71Vd+/CWbdNaWqewc7fH/LvLtooA3FZ8O4DrMQPPFejKmBMODBUztxmhaRLxlZQdG8zoGhfQt0af/5QKdA2t99nEuX0fzteKmkXQOA/SaSVOz0QHyNHUsLWCwaSrvV/4gRIiOPwizjY7PtjZ4n3v69an68qiEQ99/9I+0zQBUmFrQsNBuD5WVq5NBztS8iV0Zsy7ax7q0neVG5NiH2ykVMvr+pfTEbc2v061eczJg4=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(31696002)(41300700001)(7636003)(31686004)(40460700003)(86362001)(4326008)(8936002)(2906002)(5660300002)(82740400003)(36860700001)(356005)(966005)(70206006)(478600001)(70586007)(6916009)(54906003)(40480700001)(316002)(7416002)(8676002)(82310400005)(426003)(47076005)(336012)(186003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 16:46:55.3751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f914bc-f12e-4bf7-7643-08dad7a97be9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2022 13:42:06 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.226 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 08 Dec 2022 12:40:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.226-rc2.gz
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

Linux version:	5.4.226-rc2-gb5f84e63b272
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
