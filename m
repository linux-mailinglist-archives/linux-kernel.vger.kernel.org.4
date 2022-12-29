Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D87658A18
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiL2HsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2HsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:48:06 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13465558B;
        Wed, 28 Dec 2022 23:48:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEyv1aYQPwIpiIiD09eS4KQZDhu4t2nCRNGXZOM6t6lWcbRwtmmKw0bFS7S93XUNcFDL55PnspRy+JzD+QM/N0XgbOFFdVp9fIe1iHQ0iwX84Cax1JnS/kriAHsMD5f8BeWXdIyYAKYW+xC8uYrkLig9Gw+UeLPqAM2LYtJMiKSeTr90smgLRXG4+wy+Ye7YM86YZ/sLPBXR7/euJbwtCGAayBBmgMwiahzy880+KbjJDLPV1D48X50Yq35uVkLKOYe/C3Wlaw+p8CFZ9ydRKs9nQjMGBkjBUMSILIDgYpGS5H9w0XGf7qB2frsDfoKrb1yXpfOUFyrFwlOyS/tdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Me+7IgeKX3o4hsZ1AIS0CUU7HK0LshJAxvSCiqIxJTg=;
 b=N0x1l9tsukUqa1kaDk17sI1R4/dJaHwp+5JuP+pt02edd/do1Hg7+k7AuRYbbO5oqzZFAQpTDI2ANmR6eZc/50UhJSYw3zgsNxTuowMXXwYMR2E1DJbTUJ/MZs7XxBBK2w/xZ18s/8DFgt0+HZAQ38S8t5lHwI3nY5G41hA/macL2E1k4dNc3qYoEVvhw3C1rmtv70ldK3yDewKFzw/gH7HhJK3y/tM7lDxh870sCnDaNjvgaMvNcFcNX47ZZvcWCxbVQP09eg+wkKxxqM6ADUjD0SLy2Rpauc2nG64pyUvAGRbOoL0kuk5jyL9pDTg39xbhjoq0cN240bXb8TWSYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me+7IgeKX3o4hsZ1AIS0CUU7HK0LshJAxvSCiqIxJTg=;
 b=hZfpkG7sXb5cm9k3JIDegFvigAtU+Tm4YVk+5/h9887pDRNkfQhIxgztt2OmIQPh/CyCwqIihmux8mxXlkILoMsN3AR4yvjMTpIx1UFijIZJkpHl2YDO98GdWO0URIjq/9nYG1KvlZ9KrAXowTtQQPCbFIhC9Jyig/sIHV2j4cjOruUh7E1ETatO7h4896Nc99o/rFgeGZEolh1Fk9Sm4j+HDxlPjJdO4VpedCOgFqpNQiZuDtwjeyk1m+lVbf8ajED56QezojJmN8hw6BKFZl7sq5nsbrz2+QShygm/JcvNw6melZl9RrarNv1l87cylfcuo9lY9kDeC43b5JaSYw==
Received: from MW4PR04CA0053.namprd04.prod.outlook.com (2603:10b6:303:6a::28)
 by CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 07:48:03 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::1f) by MW4PR04CA0053.outlook.office365.com
 (2603:10b6:303:6a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.17 via Frontend
 Transport; Thu, 29 Dec 2022 07:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.6 via Frontend Transport; Thu, 29 Dec 2022 07:48:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 28 Dec
 2022 23:47:51 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 28 Dec 2022 23:47:50 -0800
Received: from orome.fritz.box (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 28 Dec 2022 23:47:47 -0800
From:   Thierry Reding <treding@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 6.1 0000/1146] 6.1.2-rc1 review
In-Reply-To: <20221228144330.180012208@linuxfoundation.org>
References: <20221228144330.180012208@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <ad7b1e41-9ac8-40b8-a91f-2e66763a5d7a@drhqmail202.nvidia.com>
Date:   Wed, 28 Dec 2022 23:47:47 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|CO6PR12MB5458:EE_
X-MS-Office365-Filtering-Correlation-Id: 647113fa-e007-42fc-ace3-08dae97103ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMUAzbU8gmTZ/x1PxrPAzWa1UL5NVLiraq60Wb7EkkcknKjBDg3OEiNMUHY/MmboTrP2GEj/+v8XpBUDv5+50yVp0S4Hs0viFyoc6HHXLPuh2WpwNWyZqSUta/I7/lVhW+DPsHKuDvEUj0efSuQ5hHIdTmT9FzFunBOBUz+j3nUcZWmJpDPRAXgsXGCNxU431oaCqGieJfIb4WnxHriQseoQgCvBygIkSrmtHUY2kQYQ5wy1vMH43DtLi4EHmL2MZWuoJRbkzBX8sODO3ZKP9iTInSGPVnaA+Vku+JpqD+n9iPW5eJa6r+Ft5dL8ujumiYKlHMY9A+WTcx1pSOydpEm0gp5gc9Z47XrwQfDdOQzzzq3yrneLuBRayf+fBkaOfqECrlyu70ZotGLkSbeqaB5RL0cObUiLmT8J5Yh0URGpKEac2n2wRvSQMjqjBdL8anoUtAgRa5sR9TyXv5Cgj2dI/nYFlm9SLxr+VOzUTAIezwbcHhU21dy+Qjo1Zs0z/icPtbT1dFG9vqvjIzd2mPaBHPyFcZSnInUx/ctdlBpsuK0VxekQ5LgZIqG/c6xu/QQIHcV7HCO0htlnj7GTTGze80cuRezKa3Lo/zda5dX7WxfD2VrNHRAintdDA81Hri+4ctxkEDThIVslkIjpnaH6X/wLnWzmNVODL7JrQ9p+Fmmig73B8aW1/QekR40XUJuOx+Fsj7ud550RKCvj1h2/eN49ztxnicQnu9nhTcCh4c8mkAyuNnNrFrSDzcznmPrOsc5G4URXDsOd7sU2+vM1grbsUxiFWvUDuj5n77s=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(7416002)(8936002)(4326008)(70206006)(70586007)(8676002)(41300700001)(316002)(54906003)(6916009)(26005)(478600001)(356005)(82310400005)(40480700001)(426003)(47076005)(966005)(336012)(186003)(5660300002)(82740400003)(7636003)(31686004)(86362001)(31696002)(40460700003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 07:48:03.2024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647113fa-e007-42fc-ace3-08dae97103ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 15:25:39 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.2 release.
> There are 1146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 30 Dec 2022 14:41:29 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.2-rc1=
.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git l=
inux-6.1.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.1.2-rc1-gaa2ec258c437
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

