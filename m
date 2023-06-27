Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40E773F829
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjF0JFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjF0JEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:04:48 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFD8173C;
        Tue, 27 Jun 2023 02:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caqTea0MZbWISdLZ/HkJonaFXAh3ceUYnCFO7o7DtUe4cY9HAw2r8MBo/42cZ3F3pHCCmlKcSAzOUylz1FlZ0HcD7+sRUHQtVuC1oqhF2Y6t4NLUvwaKjd4jEb7SHHXytxNDsKwECK9MvElgjh/+OD6Nj+Z3ZkmPbqzx24NgMhTgtAZe3snEg9l3svkJS/xDV25BY/gFjgg6FVZRamr1dL/l3vJcfKkRO9/RLd/roMg34dfEE5X/HLbKnE1fHGvrWYJYR22cJnP9gI1fmNXm7ni0aO3T2Jc3dMukpWk5ske1QeNbsvGO9O7ihpvpTj1OzNb7AUs3tevBX5qlWmN+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vJqfGUpr1M5rn5IQCLJVZROrfoHuMb6ulR+oGp2RwU=;
 b=lvYJ0q3cVyWjTYEugnbVUSu+7+RXiTVHWPyK15dow3Buds9zvAllOwdtVR27jFFH/oQHje64CqujSFF8RjQuMZ/atzXTwaSp2S93L8/X4m+2jtWpX1i/d7v4+plTo+R3eIyLVaLVdU7G4IVhTReYfv8tXAnRv6Akd87UZs2/6fgDAzEPTT1ogizdW/TEB3WcTTed5j6SmV2iIAI/GyNb89Kq/nSoAZ9ua91Z7kmfFRREHQYniaDSqrNwaB+fMsYzwyOxVhN2z/41dRHhqUMxle5TLg008V7opE3YA9syjyQAjHoDaO5gbhPVz4prq+i50qK2MO672572Pi/NuQ/teQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vJqfGUpr1M5rn5IQCLJVZROrfoHuMb6ulR+oGp2RwU=;
 b=XhOTb1KWLw7uVJFsLbjRtWHI2hm0pyTggSlC4QK1vINykzi+TI/bq/GONqSBK1hmmiHL89KG1ntxRW5nKwqdcT00DBWOVk5hGiZs3lGHXosnV4lLRSBqvJWzohF29j89nOx1y3Sr4g8gxtbG2d9FrrtnQ3QimyqwJSPXc+OxU52r9CmG2m/eryawBMk2QUAL+4QFBMzM8POKtGFELGh3xKGW85YKTPigDlArOEvyDDqhMbLqb32GEwfW4+nP7+0WkMDkVRcUpRccGiJeh1L7UL+mBs7X2P8kKSG7I0GT+lPw2gF3LRtIY7Tbg6AHi+Ate/UY4M1OShFCYCqnRcu5Dw==
Received: from DM6PR13CA0008.namprd13.prod.outlook.com (2603:10b6:5:bc::21) by
 DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Tue, 27 Jun 2023 09:04:42 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::ec) by DM6PR13CA0008.outlook.office365.com
 (2603:10b6:5:bc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.16 via Frontend
 Transport; Tue, 27 Jun 2023 09:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 09:04:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 27 Jun 2023
 02:04:28 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 27 Jun
 2023 02:04:28 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 27 Jun 2023 02:04:28 -0700
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
Subject: Re: [PATCH 4.19 00/41] 4.19.288-rc1 review
In-Reply-To: <20230626180736.243379844@linuxfoundation.org>
References: <20230626180736.243379844@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <c6867cbe-0b93-469f-8588-73bf14e2e684@rnnvmail204.nvidia.com>
Date:   Tue, 27 Jun 2023 02:04:28 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: b946a91b-7d05-4e9e-eb85-08db76ed8bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yar/Xzko5QrM4WOxaxchhKx1IrXx1/XXQehFZCblPAewe+foaGngQ34oFmBknQGQYfT+vLX8tyPeI4RMQNbIGkfrJNJ2IAD+hUJv2zXEB2PlyXLv5m+BXEFealSjW6JxN8szjJU3RMO3UpIRI4zjXrp0sqz+hUtiZb7uR84B8JGa85AkOnQulqXmhOGYnk05gcpLfTL79T0KG+3ug7ys1gxbSgDZKGlfm0MaPbA2kP4VSX6dIQ1BngXZJiXW81tO+9GMJymX4UQKsWKP9bKvCGrYN4P0rssV7puGjGKp9lfZ9XjlYtZRkoGfxAF62mFVjgmkKSDdg0rDOS4HmqJJuBo7IoyNM1waeP+Zf6H7OFNwoK/47XZuC4xX3hDy01cn7btkBd7i+tvAKy2KYU9KKNJet0e2vIfx/9CiXPzdiAcODAkcsQQ/CKnMbiSE6GlPyNJQAmnHKNR58H8mPmwDhg3kfGmfJJkbLvWbXZL8aqdm2a/qztEzyWmAbJcs9sTEoYN5jYv2B9CqvasQwQcn5jRT5+c9PXOsyLvrV8JJQQPN7IGuPm3EtMVUlT1swkYRq4ERSNIZxsXOERSlZF2WhHJk+scCzWgHgphOp5S77EL8GFmqBG6EsxojMsut3HEu5UCtZJlW+oO6HWPCAiVw5dpp3Cq7RGY5GQb/psSye/1GlPmj5UicgaxPiFIn9pLoOUk8zP+wCE/sliasnJavnxrhvb2UWagTsXwE7/2A0nyGw+616JnOHMv6jSbsqKH8oqfnteVRhoEoygyxq7J93TOY23zP8kW5aj14puPDCJQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(36860700001)(8676002)(7416002)(8936002)(5660300002)(7636003)(82740400003)(356005)(2906002)(186003)(31696002)(40480700001)(54906003)(86362001)(31686004)(26005)(6916009)(478600001)(966005)(336012)(426003)(4326008)(316002)(41300700001)(70586007)(47076005)(82310400005)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 09:04:42.5719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b946a91b-7d05-4e9e-eb85-08db76ed8bc1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418
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

On Mon, 26 Jun 2023 20:11:23 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.288 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.288-rc1.gz
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

Linux version:	4.19.288-rc1-gd46c55c4b242
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
