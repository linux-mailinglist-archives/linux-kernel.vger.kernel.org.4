Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B3D710938
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbjEYJvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjEYJvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:51:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2C0E7;
        Thu, 25 May 2023 02:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvsnXH1HdfhWnpnM+ctRu1gyAkDALJ/bY287DAHwRrQwTquxX4BhRX8/EPMycZ71G82v/ZbxXvxuLftQWW67ex7bddM7GpbKY4JWLyqHMj9Z8VS021I4GEtep8zkjs5ohrJWk0SnIvKKkK8wFkuDJYxn7FBtMaVngME97E+L+W4iM1iOYyS4ABNlZ286tt3usDaCdFSYzpymgSdeGpiWbj/l9eopZDDanT4XLgyhCdKUJWobNuaAxiWpqzSpaUhn7W9xSPfhiOXifAHe3Q52ZI5O80DQzg/iO+M33ATf+vSgjzkXkC1lpCmU0KU4WnD/qzOMcVUcv5EcHpkLJ5x2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CRYoUZd9oqQ/r81zFcgdKwbMuV3X2wxIdvGxKTikfA=;
 b=W8crbOaZxpkdGu2M8dC2FKFIAAFqiEubdI22ro2UyS+Bnz8NX+qWdL8u0jFoSkxvJ54eN2ARG907Z7jbo7u7zdQv4aMcIeGn//EqyKm0dsSBCY1ku4CUbfbahG1nHQUeFUR2tn2G0mOt+ATaW1PqA6Z1VddaQZMHvas3lTBN4asX66UI3oONlo1+QnQHt5yL+C7pneywSpGn2QDOH5ZLc5eKB3ocw+KymVSCNApno5DxJXOXIDFoU9UspYtGhF2L2Kl/9C+4/diRQ2DQbviYNC3Xj57eJufxBYymNOCQ5tZc22XlS/oqYcvKAGjVb2HKJyT7wCWhh1P/o5dfFf8Qow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CRYoUZd9oqQ/r81zFcgdKwbMuV3X2wxIdvGxKTikfA=;
 b=gMyfG2d1YD3rgguTBx2cvH7oKTRuTiZaaIr20vOyD023QTNoX7ZGAo7Kw16bzEjjYS7Kuok4SdbXIFictbWiRytwzTNSznEaVCRijtpL508QSbepUfeWRE4DsRIkqIvQAPlYIUN2X2MLYaz95Xz5HdlT+QJZRs+MzEF6uvmZw9MRoMUp2MUu5tJB8KyCMVXiBYbjSp55TQqGQVgL81/MiZvJnHiuaY+F+44+d/pAtc5SSxEbfniteHzE84Psqcb8k0jwUlDpLKBBBG9npcDRS3fz6bGPenrf/YGv26iA5k09Z+V8VJocY7hGsyehClAvXm4YFLQkkPZG2TKYlM1fQg==
Received: from BN1PR13CA0011.namprd13.prod.outlook.com (2603:10b6:408:e2::16)
 by PH0PR12MB8052.namprd12.prod.outlook.com (2603:10b6:510:28b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 09:51:45 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::7b) by BN1PR13CA0011.outlook.office365.com
 (2603:10b6:408:e2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16 via Frontend
 Transport; Thu, 25 May 2023 09:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.17 via Frontend Transport; Thu, 25 May 2023 09:51:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 25 May 2023
 02:51:35 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 25 May 2023 02:51:35 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 25 May 2023 02:51:35 -0700
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
Subject: Re: [PATCH 6.3 000/363] 6.3.4-rc2 review
In-Reply-To: <20230523164950.435226211@linuxfoundation.org>
References: <20230523164950.435226211@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b340114d-286e-4043-8fe6-8ed288c24bb5@drhqmail202.nvidia.com>
Date:   Thu, 25 May 2023 02:51:35 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|PH0PR12MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: 97da9f67-67b0-4a5c-9817-08db5d05a666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8o+xuq7Ar5jmXveNiTZqxIymnWFSUaPPgRi9fvUeq4+CDmUjZOcfPCExG/RQAtcO9klsFwtgDNZlENtXyerisbGX2t87tBIlwenFovs172IeRs6lCuyHMs0y0O1Sr6hmzfLKOizMGR18jSzsJeX/5A9D55T/BBb2U50guXiLPerE/9zs6GDQkbT7pr7BYdCdhM9GyjBPXlXtVygP0FW03GE+T45AW5/xpj+PuDaofkOEqzwxi6HOczTtDuXcIODVWOqYw/+grlT5g5mbQKfYjCAsTwCAQUMDacb3uy5W+rsQI8M5FsEWPWG0GfjhlwI/jXkmox5KjwFd1qyiq8jXq5toN1cDJUAgQIu1OshSEYK+cu1NhVrxF32HA5AuZUcmKiI9CFgpYiWohrGRJ6laZbKC+728e0I8UsUUoP+gmDa10a45VgpimQvcJlXA555vJWqipVxywhZtOuzVWTnBmpFUNq2m6B22uzkP0Ryl8DPnfs/ivTunps2NKSmi2OYFltMDKTxcVGdFBzl1woaRQykk2Lj7WjAyRniRx+FtxA2VxBEk+rfYt3dhVh01UVzcTwE3KFoxpsAiEZ64qi81lj7rikLalGaqSFL21GMtt+i5ghhQe0PFNnbYuQQUjgbVNQpC1y2h/Zytzb4g7zE85p7gzO0XWp7iFK2Fn6K5tS/yDEtjzwXzITDfE7FStv6YI8rW24939zKOUYjfa8EsugY0ViG5cHTd3fkJA7I8HGcAf4JT4y1P/HQqUeaHgzZ4OtAcWxJcTfmw4AV1R/2gU2GVmLI94DHpz/rRY8YzmZg=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(31686004)(966005)(54906003)(26005)(186003)(70206006)(70586007)(6916009)(4326008)(82740400003)(5660300002)(356005)(82310400005)(426003)(336012)(41300700001)(36860700001)(40480700001)(86362001)(2906002)(8676002)(31696002)(8936002)(7636003)(7416002)(316002)(47076005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 09:51:44.9143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97da9f67-67b0-4a5c-9817-08db5d05a666
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8052
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

On Tue, 23 May 2023 18:01:23 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.4 release.
> There are 363 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 May 2023 16:48:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.4-rc2.gz
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

Linux version:	6.3.4-rc2-ga37c304c022d
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
