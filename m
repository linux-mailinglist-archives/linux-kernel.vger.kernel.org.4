Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A80071FC66
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbjFBIqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjFBIpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:45:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F998E75;
        Fri,  2 Jun 2023 01:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBRqOqLfO7DWurqSJ5E6vpUsQJGcOWfOpKfATIP+nQXSU9nsHoEVQ3OZesQSIq1R1OxzE8eHcNjU4QMbOP8AoYUbjomxmY9BO0jiSPnMdMRnsKt6XebhrKmjDJDLYQZsITOa4Wwhgubg5iXk4+utQR03DWizsthh9BRETCw37A+O730uaCEjsoS511ehRgCOaG4K2Qdy3JucCo84MmSsSsHbaNgrLnWpT4Sk3PDjl7nAILDd+qtAG1nFua+rYqvEstcz73DV8akCQpYp2XDJK7mQfFPf/KY0hj0msRd7kRmJsOs+esxJfvSq36ALDS8KjlPSILRUrQYLf/ebcc19qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyQYj+piAg04DM++0itPIpj3WYtRRcTBMn7J+Grq4gA=;
 b=nkk2hHaFnoWRKtE0Fw0LI1dkR0WScGN1b+QiENYIPO3ELmU1KRus3JkSBxX9sphqd8twsHCCId2ZeWoL8gbb2mDnCWqHJOXyC2GDbYQ22U88d/Iu6kdnGN6SMBBmAICd0iRh3IJNpw9BQpcrMSG+p+X2e1ARCDgojmYMk7bn/IpcRnPcZhX9994MNN2O2L2FazxvDk7FIGaRZ8CX3RadK+NnSjKo+0P375BBID70izPyso9cc3IrX/Vg8B7L2QK7cdUjhIA0fLmPrOsgHY12igUeOdsQkngE27rkpPp1K6ngwxSfZvtzYwK69nY4yN3+dxICaByJ9wzIHupaZ+OdrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyQYj+piAg04DM++0itPIpj3WYtRRcTBMn7J+Grq4gA=;
 b=Uw76oHJzfklUlsjnPCemK+55J1uSjZ9mtDlYAB/QDqKIogwMjWbJs2wcD/sKvfx9ZP0g6XzxWh9yv2qXuKc0G9pmi3gldu5wI0bKo3aG2nnSlJxqjVKpUReZz3iM1JJ0L0nzJI4LBsDG6tNPMgJ25zrtlNJqaXjEk9glxVXnIPgtHQxaabbylz+YPcDjp/ycvR3K6FxE0giuRQAiIIIySJ5lGeslKLTZ1+VEbq7autYsmgAr827f2jy5egNEXQFuo9Hk0jq7RPhA1X1cQtJV8Y9K+tlyfEpvYABXgTPCcvVCeFsvHffFRQNJ7fxJ0D9R3Oz77CNj+7fYOzlg/rKWZQ==
Received: from SJ0PR13CA0232.namprd13.prod.outlook.com (2603:10b6:a03:2c1::27)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 08:45:22 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c1:cafe::b6) by SJ0PR13CA0232.outlook.office365.com
 (2603:10b6:a03:2c1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.7 via Frontend
 Transport; Fri, 2 Jun 2023 08:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Fri, 2 Jun 2023 08:45:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 01:45:12 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 2 Jun 2023 01:45:12 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 2 Jun 2023 01:45:12 -0700
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
Subject: Re: [PATCH 6.1 00/39] 6.1.32-rc2 review
In-Reply-To: <20230601143327.479886832@linuxfoundation.org>
References: <20230601143327.479886832@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <3e9659d2-3799-43fb-bf64-618dc7feb0f3@drhqmail203.nvidia.com>
Date:   Fri, 2 Jun 2023 01:45:12 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: f97780e1-bfbd-4db3-811a-08db6345b36a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnhKtwLqhi9ef8HlbwWWrtELPOZXbHgauPNXs9/WRa8+8z08H4Q8QQ3MqUtPHjXmfL/HoCPRumL57edh54djWVSrK4HW5ueiR6sSWf8wVWP57YupeFzZfqd5tOH5rHR7+hhPvAbQyoLusXIeIW0VeD4BA1h3ywdc/Uun3yqqqlzOIcKI4uxP3c2e09E8IC0uza84viWem2BSH2qnUHe3PSyxJJajOuhba/WkQ4v5vIIdXpDbqTq5Bz3v2bZQutsfIIywkUc/IxgtRd4azfR5GMsKFonSHYxMEaGk22zOvsWwUGZSha68m3n5A0gcYelyFlceGFcZNH3N1tFI4mSuYqEPV7o/sgKGFJ5yLhxqf0oaI/C3tmlpUXNUdiuxmqjaMEyFY3mw8V0f4SwGPh13XiKwDUPfiE8MzXjLGacph1T/u27fo8YngPVDS9R+uuDN3xZpSHw5NRhJxqZxZhA01dtEWULqJ7vZNTBgz1gxcC4DZU2mbZ6IxWCyNbEWp2A8ALVBDcpJFsZ+0r2hJXWlLbyw6ra12TfVSLPzYR2EBnqR5Wvi7Iu0tsK8ol2cF9hSN8Q1cw/dkL4E2PMrAoScXsEVqrX6r0OfHP5yMHBL+zdMR0gVWMWgHNpufyjTqNzhbQf/xE6l+6QPVeoPfvgYFNpHGxHoj91ZLdIGCO0QQbUDwdXqg0paQyzWIIdX4frc5L7L+1Ddf+Nw0VQr5DOo9Sk/EihXbEVSAriZUG2vuU8lorv4RE81MQnODvd9JUgqBMz6HGYAywvP1O6vsM4RuQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(186003)(26005)(966005)(47076005)(426003)(36860700001)(41300700001)(336012)(316002)(2906002)(5660300002)(7416002)(8936002)(8676002)(478600001)(70586007)(6916009)(70206006)(40480700001)(54906003)(4326008)(86362001)(356005)(7636003)(31696002)(82740400003)(82310400005)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 08:45:21.6114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f97780e1-bfbd-4db3-811a-08db6345b36a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 15:35:57 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.32 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 14:33:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.32-rc2.gz
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

Linux version:	6.1.32-rc2-g7d0a9678d276
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
