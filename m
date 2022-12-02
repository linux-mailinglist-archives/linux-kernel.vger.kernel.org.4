Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55F6640723
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiLBMtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiLBMtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:49:09 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E770DCBED;
        Fri,  2 Dec 2022 04:49:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/cakv0FxfQZlEFRu1wYIyuTT0fWdxrOcFHpOhlwky0lm8ZY2pN84Qe1GWWmrzRA2Dn6X3w7pTP5vxTBr85ZLx/87b/lWSiWZGBfRm/U0/l8pU7BNt3VD+29ig0XPryNDx5hXzOvsMC/Yw93y+geMhSp1rCdE7qPXsubxcKYYz81tcbc7JZVFqY+H6CmX/arW1y/yc11m/RhsNy5/8YeT1vbTtSw4thJq2WNaiDmY8jwRFamS6yKBXMKvpQb0S8qC5HcCakTiHQdKNt+zM0wygzzaP5IEcyqjKQ4WoWoU+yTNolGsh76QyWCmCeYsZ254vrg36Bpikm/BAW3YlUlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiNE68eer1Tjp2CURt2hPGF4K4NVM1dxRqUmmuL6gKg=;
 b=hTbgy6n99SHaJDbsHlKSU64qC36FrfK4iFDgMthBVJlvUpLvouEgHkRkFaX0XPcDBSUsnx1EjmnYPTqSIIl4LZqPzUKC3j+Phg5NqsofK3fbZOwyErhG7Ina/I1piobWOymDC/0LecdQwaVnsL6naSpTiODtBvPjiuvVkxaorfHvnHKSXB2eTjgJk15Fx0w+WBkfyunfPXIXVy9ZKRH79OmKmawWhjTbOtSMxwMjFSRMuRpcta1QTNdMkQbG0m1zzi2+zAUOVPGgp8BbjZzHQfT/zN8ylEpbFv5z99qSiQyfsPrGckwhRCckZznpc888hGm396s88EJllrDPYAFo/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiNE68eer1Tjp2CURt2hPGF4K4NVM1dxRqUmmuL6gKg=;
 b=GZOoS7v7XfjzIMWmnRpZL1BcaCHJ7l5/K514wUdN1Rkwx0Xu33OB+UmWa8TqaEE8Fxb8FJrrlzuUafKBgcXZY7l5s6lY+qBD3Tir3wfI9q6dro6zKlrvCnHpDYKzB9Vy9rFiwIydQksSRxCjfZd0aFkgvgDtyYr8hE2zVEOw4En2Bpo6jCch3ShB9IBWtFiPYi+EMSOPDfFnQv5jaadh/a9o9nx+g5zE892rmHLZvkAxD7+egb5s1LegZjzwMj5FIhfGyPHKOIHgvDXEJ7YdSSo3+EcvPCvmEU8Tb/+X2lsV5iZutVAVRUALtmzlM6HIVT9Pdx7u29eodsQeYWlyWw==
Received: from BN9PR03CA0406.namprd03.prod.outlook.com (2603:10b6:408:111::21)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 12:49:01 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::9d) by BN9PR03CA0406.outlook.office365.com
 (2603:10b6:408:111::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Fri, 2 Dec 2022 12:49:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Fri, 2 Dec 2022 12:49:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 2 Dec 2022
 04:48:58 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 2 Dec 2022
 04:48:58 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Fri, 2 Dec 2022 04:48:58 -0800
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
Subject: Re: [PATCH 5.10 000/162] 5.10.157-rc1 review
In-Reply-To: <20221130180528.466039523@linuxfoundation.org>
References: <20221130180528.466039523@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <66ccb6fe-d64e-45de-84fc-3ad664a1f74b@rnnvmail204.nvidia.com>
Date:   Fri, 2 Dec 2022 04:48:58 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: be1380ff-37dd-4afd-b888-08dad463961d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idpFTXq82ygJMnJtJdbLisDECS1IhqTru7JQ4UOTPpqaDjncWycziiDkzT2Jzbkd+2/QUtVYhd27WEZW0U88aq27pXys6cTtLHO8GeCUUNgJB2+I/yJfnmHgLtX+M2yrZ+oziHumFgZX/ORcIaXS6x+ZFUFHPgbenqPQXNJ385tX7AzAoiW+hKj4fYOFjAanXoOUvpNeDwwI9IAKNmJ3wiPMP6uSN0pbo4QIQNbIbkRTAQCUubKyPEkQh7a8fuIRal0Ll4i6eYTWMhkF7gl+HXkuDZfqjVQYAbxTEWZSJ3YnAz6OXIWdXZmsn1JAfkoZGdqLC4SPrHamliZWftl3IvkeTpUuaEyd+jt5wHiU6AEEuln3xMEdlqHGZwetLWrH5vCQBg3m2hDly5lTGujJnfMmbkkp0NwZPjyd0j31P06DfyEs3rG3mG/EHbg2KeNMZlWEsvlEpkRIYFHNo7uqaatjKhqAIYpbQllu8c5aibgbfhPRZ8KibeEMY9pM2mRe6ZOSWie3MUEg3/RlQwAmG6AkKmBEUUTP68Od98Thygit9Upnyhwao9O12OY7jwub1l01T/BbsD4MY5eESlZK30PkVF65CdVeaE/rRGYAqlUNfyz1p6nmUdfakjJZ5lnoPwDT4rMK5S0WagIvYt4OQNnGIB3EbYHhPM/ie0S+bx0S4ixlBd+MoQVaRr4SNv8iYCG9s1Ue+HAsSyZfwdgucAMIfS95O7EcqRxphjviLWlTu0CcjywVxZn6pLZ3zrhGX4FRMvN0bx5PZ9zCmaj/5phGDZeQM5RVjZOinTRkQTk=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(86362001)(356005)(31696002)(7636003)(2906002)(5660300002)(7416002)(82740400003)(8936002)(4326008)(41300700001)(40460700003)(82310400005)(40480700001)(8676002)(26005)(426003)(47076005)(186003)(336012)(316002)(6916009)(54906003)(70586007)(70206006)(478600001)(966005)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 12:49:00.9540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be1380ff-37dd-4afd-b888-08dad463961d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 19:21:21 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.157 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Dec 2022 18:05:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.157-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    75 tests:	75 pass, 0 fail

Linux version:	5.10.157-rc1-g64cb1fe918e7
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
