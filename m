Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9AF7061D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjEQHzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjEQHz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:55:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE14A10F5;
        Wed, 17 May 2023 00:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Md8JihDH422T+NkODJaIlm1EefCsfMzpbrt4br9XbLqXGDGKjZCc193/s0/3rY4pI5WBsZc66OdGEp8Y8Lqf9PspAxSEfFNl9RLeNrhp5aGZq3WxJ/fWiSykUO8esm9ELPe+p/rQhWWhtzy6cXx9/shrdtoaHc0WWOx+sfCIVOQLCaNrVjFAynvn1iWHJ4IzDAvk+tBRH5LPuFq+Vuh7F5bCcVJ03Brpdx8AQaqBughhxdRS60J6mYExTKjVFsrl9LybSHDarLiJgsIh29GNjKgnGBDlEYuHHDIzFCZEQvSUHUWU+WtqyoPEsTYV6Fr7PPTW4qQPVBIafdzNuWjeaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75jJOIKNY95HXjwtv2yceEXQlG2ErCkDvsjA/ZT70Rs=;
 b=dvoXcRK5sJEopeCg9IfIaY8LSo3L318m6n5G4fFR0nEalEM5McGzTI88RtKQjY4VcyRMKH932BTZfO2lO0vayMHWe7FHsFJ0aN+Vt/4t+OiiCcX5VM2ZREGFODyCu4zKtPshLIFmw1x/HjaE25ZP5Bns6dFda5LgExMcoTYiFqV9TOW8tYLFe3n7gyRSZc4WJ5u9nZ1MfansCqor2Xu1d0mzLoawa3xE3Gqfs91XRi9wsDzSBCqAI6279jQXP1RdupkHVaTWEtHU1cApIT5fCKSCsnYMadEy3jTazarepPbKeOxFwrQwlyECLYQJEox6/3tDGmmAKsJXLcpaxYQ3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75jJOIKNY95HXjwtv2yceEXQlG2ErCkDvsjA/ZT70Rs=;
 b=h94O3KHFmXe0b8v7IZ6tgYno/RydyCpKnwx/OhsNQN/GK3qMRmo6JPdvSgX/6oah7YRA+ZHeu3FDJXLREVBYxdibjaaxHlzANDJUxByk8yUDPq19CJJuBgfpzLGml+WbxCUi7tsad0g8yKvc22mg+7TIhT/l9HiqKR0cwb+p9g8l4mEfsCpj/al2nGVziT3UT/BB1u8/y0gf/wpdK+v9abM7/M4883zgWcQn4cE9AkKTz2ad9mmGLxAhW1dGPvJC9ZfKDNNYn28D3+OFiMb5gYjuqN0R5KY9NvGpp/4w5o16upMVp0ZMoemGINJqK9axBySd45GIsRIvAnNZKW1XFQ==
Received: from BN9PR03CA0302.namprd03.prod.outlook.com (2603:10b6:408:112::7)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 07:55:24 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::57) by BN9PR03CA0302.outlook.office365.com
 (2603:10b6:408:112::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.16 via Frontend
 Transport; Wed, 17 May 2023 07:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 07:55:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 00:55:11 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 17 May 2023 00:55:11 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 17 May 2023 00:55:11 -0700
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
Subject: Re: [PATCH 5.10 000/381] 5.10.180-rc1 review
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <03391535-dd51-4e0d-9731-a6a321e66f4f@drhqmail203.nvidia.com>
Date:   Wed, 17 May 2023 00:55:11 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd7ca8b-5b3e-4660-df94-08db56ac1216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9v7kW9p5B8UOjNiVVwf4Is28t5XRexMooeaZlM/JWtULwiDn0yKqi760Sxh2/2GDIe1UTz6nZWG44omSqbLW7R/fTy5T0j4n9TE8iFh5AxwsFvcKYx6oSMEDLnC+1qtYuK0DTMJHXQd3FF6Zk+i7wpvqjWj9k1oYPLssTmkU8+5+Z5YC7xCAPxLI8hahFKwhWiXGzD/y17VN+T1hS2Vl1y70ksqsDd4xJjgGnRgqEIxBF0fHiMUSTJsADQ2SKbJbzRmHNDhU3vxCdpVb8dOmZ9aGMLbxhnpEkrWpGqvnzhbXI943ZwLRij4gw2L5PdhhZrvVkwe1NWiHV14aRk+P026MfQFFF6SJ7U7lNnxnAPCggG4Hdpu5Dwd+w/q+s3AI2fgyr4q1y+P5XalhI0eZcINc3m6ja0Wx4ULVLz4oOOnMY/2AW3qWA9ZTEE0rB5AGm2O41pfhhvZHJCChVhJNpjXjES1TEDdULxHhNIu0/avmJYK51cCiSVVKB0VJUxOXiIk4N4Uj5Vv0cXDIu+Vm5rwW9Yv8FKOmigPUKD6VjHjMoh5i6mBEaRoeFh8ywjMxPritV93MzfL/efChcf7cqs7b+mVuuB+NUBAvvGDLauZzAcJsr5tHjXb+U61mRj35WM4nSGq/6yZh10jnj5W10XQKsUW5adLGUlFlRPDGOnJYTx/6lgoG/ZkWczftahpwonHhRS3ber8HvDnkdrGob1itufkm5Yq3Q7gv8lVQYBT1UwWYU1kOjOGeZqjk1G7nFDlUwNVZXJ+tOeM1z24mj19VyvHcp8r0khMUMd4dZiw=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(47076005)(54906003)(966005)(336012)(426003)(478600001)(26005)(186003)(356005)(7416002)(82310400005)(2906002)(40460700003)(4326008)(6916009)(70586007)(7636003)(41300700001)(82740400003)(31696002)(70206006)(5660300002)(8676002)(8936002)(316002)(40480700001)(86362001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:55:23.8878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd7ca8b-5b3e-4660-df94-08db56ac1216
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165
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

On Mon, 15 May 2023 18:24:11 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.180 release.
> There are 381 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.180-rc1.gz
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

Linux version:	5.10.180-rc1-g065b6901e6da
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
