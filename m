Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E656659E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjAKLSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjAKLSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:18:01 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF66B878;
        Wed, 11 Jan 2023 03:18:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBKQh7y3p3VU6XiSscgJETtqzWgB/7Dhat4BBVldmOUTutnFrbcseiDNci8hzN1iCumaQeOK2s5dPOpXSBV8ZlL6cWiCiw/lZ7D5FxPCZvcyULkM+OU53BcWUSsHxXZC+eQdywxiqL/zq3sQcu4OTjtAqyyww31b6SQ/bKd4JgOF7aTbWOIo425almeTKMvNFC7Evq2Yy1douc5D6yONp96GizS1aNGZ0Ii6IVYNnIIbkxx1d1FrYW6l3EXpc6usKMt+eBATEL7ynwasTzIlkpBp7au7LIn5pBGHhIxBYl+UHk7vd9QSJqV7AII3b8MJcHftna0BLq2jEewsBhvRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3TTVA7mIYpLXF6KIc9xLIwmZxRnUEhIMuDRAI41yrY=;
 b=nSEpv0hDyDsdlL426kk9XfHq0MCSQYsLNL3lpqOZ74E7wjUR1rI2Ne6vRugCrw9L0xCXRNoz82QvSe+feVx+aW4oZFZHJ3RVqPD3MNKIlbo/KsPnwzLsws0RQuvCym+zJoWToXjfjkeu/2hRlHLQQXUUYTqOGlogg/WqoWActbg4hfOEOoCbCy7nuWxzl7AzCjWDDKRQ0NMe9scTGSGlsyBrdNcc5tFMAQBnkj3sy2I3BNWzLdUEWfTGEmzyEeWEYsBc3G8hERXgZ36ZaPw6600X06mfTbs3lEuQB22bt48GEpaVzSaf6qyj96r0ayKOBhiymbSiNXbVYXEwN/+ZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3TTVA7mIYpLXF6KIc9xLIwmZxRnUEhIMuDRAI41yrY=;
 b=EAsYwPwEEHutbqs8DGrBkh8h+B7gbdp8ySGkawXW/oJrz4Xobwm64LkRs7/8M23Yse48j7/U2VKpxf+dx/CWB1DbkPbbV5331e8iZ33eQOVmgPz5x8HBBMa18BNFrjPVjhhriwzE4b4s0n9TzNrv0vHou9IZmGfzkCBSRJ2r1142sP1xWIeq9sMJBu6hSJRs6Pb8njKwr1s+vfA0pmnSk3EYbmoY7xy0CBcKbLh2S7j0UK70xBPE3Dj/DQ6yCwwNwA541Hb8YFytRZ/8WplBqJ2cCFmB/rxqX/sBw+95zSeZBE4ZnWiYZ0T8EXe/SKnB7JagKE+97vAhiLLDcsmQOw==
Received: from BN9PR03CA0195.namprd03.prod.outlook.com (2603:10b6:408:f9::20)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 11:17:58 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::63) by BN9PR03CA0195.outlook.office365.com
 (2603:10b6:408:f9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 11:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Wed, 11 Jan 2023 11:17:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 03:17:44 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 11 Jan 2023 03:17:43 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 11 Jan 2023 03:17:43 -0800
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
Subject: Re: [PATCH 5.15 000/290] 5.15.87-rc1 review
In-Reply-To: <20230110180031.620810905@linuxfoundation.org>
References: <20230110180031.620810905@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <5c54e399-91e5-4024-8122-7f2e343f5720@drhqmail203.nvidia.com>
Date:   Wed, 11 Jan 2023 03:17:43 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|DM6PR12MB4943:EE_
X-MS-Office365-Filtering-Correlation-Id: 3408960c-30da-400a-71af-08daf3c57eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWF8K3zhD6j58lJOGQyT5KG0Apt0tJKPcwGsUOLky1wMoP9evhzfYmbSyPCRn2229V77zxM3wWbie1hPrduHhOIjhjOaXxD3DzyXAT8l/Jc4NP+TR80Va1Dl3TVq2jpIIz30iDWZ2xB4c/Qosa/uk3mdXC9zh+Jq/75gDepD0aBZ92iTlcmVLVY1opgt7Mf75rkjWoI9+Uac5Xl1OPsqzqdWUFRCg0ap15J3NgbWwo1jV7fq5zvy97kwU63YZLWb5AZXHzSf0eBRHq6fMc7xzhXrog9p9kP/v2d8+dNV135cXTDAXWQzmEqTWcpBYu/FOWUxD8gaMA/b5ni/sFI/kA2cWID19hC/fYwUzjpnSWOxLjmC74KEG+qkQA33SHu5OTVTT9PelurG+tZGtlMxjiXV1P/3zRZQgHSbr5VdcVpjEcbH1TQ1/byXOsrNEGw22idSqekjQONzOAbjIkCmEjI6blEWDB9ZDOhSdq4+SL69QjH33j2f2M1GoLq0FBpuro52HVBdbQWmtmjwf2Ek7O+tsrtGbz2cnexq32RTnC8cwC4ik2kL62pHb5g5qibdQNuyaENCCGnHMKbSqdfJE0g4ivu3bcYCluedEJ+qF3BrbX3vGuZMjgptk1ehke0fGXs9ABMcb7ydHExzhw/+kQlqOLniaqmIEz95z1xrxEP1S7ld1DVbqwAEZmi5pKfjOJDpBC/MHWpOafjd7GNumkHdU8SNoJNs2MHoXKVd8yPxk4Zoo7wIyVsbKIpcSd6Sa9YzM7Rv7ouxukVrCHfjzQoeYYk14o8h6mXoN1KkmJA=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(356005)(40460700003)(54906003)(186003)(40480700001)(86362001)(316002)(31696002)(478600001)(966005)(8936002)(5660300002)(2906002)(70586007)(4326008)(6916009)(70206006)(36860700001)(8676002)(41300700001)(7416002)(82310400005)(82740400003)(7636003)(26005)(47076005)(426003)(31686004)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 11:17:58.3652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3408960c-30da-400a-71af-08daf3c57eac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 19:01:32 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.87 release.
> There are 290 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Jan 2023 17:59:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.87-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.87-rc1-g5e4a8f5e829f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
