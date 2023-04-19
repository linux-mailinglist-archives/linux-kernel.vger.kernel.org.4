Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D80C6E82AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjDSU2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjDSU2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:28:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5839031;
        Wed, 19 Apr 2023 13:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfykV0+rRjV3WJUjSojwpAfDK7wRX/4oVsvIbAXw4XIgXT7FEw3vrivtFAeCCgG5gY0E2Y3HAM1goyKx2KIba1gpX5SVk3crdEDb6Ne1fa6tKTaO4gk5jPhX8ZbT+Sd/ImuppnUafL6n+4nbn6zFhRS9GVRpIADxzM5diP6DkSwyQIoqT1Nx+1cgCKuX435NVMSO2rRPs813BS0pMjNeVrgKxJKAwFbpd8BzRxJIWkzbGLWGCsLfW+CeaiXa8x150+h4GQYW8qr1uLkht+nVPt8aTuw9f2atwt0wtvY9N6la+A29ND8oWQaK1QUOO/wMLHHFaq0WBV5HmXzVcKbWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtqOXyMZlNMC2oEpno+zyXh68TyFQQVI0s7+jrrwx3s=;
 b=eT92Krkir78tKpLl+B58cieD+CVYWT1hnmLKtmQrAIyAKhxEeDoD5OZVFOCV3L3QuQf6ShxVDAGExcKVouCDaMGA0fwmaLxkiugUERVrUUj1E9Q4fe53nDSkKT8F8ntdzo+F7AsIS8TJMHnlaK7U0U2jmdyFjZVmz6OMAUmFA8O0LjpbbgYjFIlcLIn/qbHxWYkkFzrnVJ7puHFOTKxEfDZ3GhYJzvTM7c1YsfRPRi7zhfzli6vDQ3WLCdntJiiTtA0q+c/OCCDTWIW0niecox1Wdl0vIaelJH4RABrShgzthVSa/r5fCCnytsGlLroHTEdQnyfT86XlibFh0DdAhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtqOXyMZlNMC2oEpno+zyXh68TyFQQVI0s7+jrrwx3s=;
 b=OG0K9h7Uhh0iL+p8Z2D1oo6Sn9xeIHyOgZWf9iyh8sBw7PetDVfvxa8MLo7HtXhvmocRJh3im5HwvXTEYBA32H6yKATHBqBJ16v9O4v9T2weI3XofI0ci+IZu1VUCNNw65C4lEzZOO/aiFFg4mxePAlTnvkOR2qD56UbAk0GqXaBZCg0v26pDtmddcdJ1K8nU/b2Na73fU9LU4CLecaHLwY6rir5CT05hJiMqVwspX29zz78upa8Fq6jvzPjWr+JrPfLoJTbUvL2Q6kzuAVNm/PIhrwekHXoGQSEcPJNo2p9jJMGhgB0uyqOrpLUimNc8SQd3reJ1FryWnWR+U8T8Q==
Received: from MN2PR19CA0054.namprd19.prod.outlook.com (2603:10b6:208:19b::31)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 20:28:16 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:19b:cafe::27) by MN2PR19CA0054.outlook.office365.com
 (2603:10b6:208:19b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Wed, 19 Apr 2023 20:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.16 via Frontend Transport; Wed, 19 Apr 2023 20:28:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Apr 2023
 13:28:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 19 Apr 2023 13:28:07 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 19 Apr 2023 13:28:07 -0700
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
Subject: Re: [PATCH 6.2 000/135] 6.2.12-rc3 review
In-Reply-To: <20230419132054.228391649@linuxfoundation.org>
References: <20230419132054.228391649@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <1b3d8953-f0a2-474f-b864-75002a356512@drhqmail201.nvidia.com>
Date:   Wed, 19 Apr 2023 13:28:07 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9d6420-9e49-4657-20b7-08db41149b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cb4lNuooNzJSmExeHHNAGF4G/84eTm+P5Nehkf1JHuLVnAkDna4VfbB6+25zNSxuFQDJGiRAm5zSO/TToBlFVNYYbvQ5OmEiN/51Oz52PnnGzI5gy3p59EYBkLO+O/qjghL0RQXbKdtgdTM/7LNPdvHxBRo3ngjFakZaBLaPOKZXH7QvLLGndShr8XlFIeJirnwfbXpUkks4RHA61qlayO3ukuceazsjNOtJY73ptqtafeA6qpQgfa0lcH9xpEtRTaYWDgTrHr+BuKf/rYOYdgJsffUW9MQUgp+0pFEpKib3orOXF0XOGzgOQOGMFdneLJZulp/0z4Si9IycjOsXFvQWd8UVERM0T0nvfuT9gKCUD2ATkdKN3O2LWbxCw2Gg7jVb3T13U6woH+mKDXFO/y7kK3B3GlnvoRsNTf+YPYThJ3PivhZNCl6pTf7YWm73RUa6D2dpMd4u18cZ8U07oAvSLaqA+nXD4Rk1RoBUSLvP9TbDw644egGzzyQ2UFvrPySs3BLRP0+KA0UPA9UTiSJsaHrrlT9zDirQ+2V4vvYtVei/Pu1dEIohTdLjlL3SE8MarQLylxnyn2CmtdPLNDivb3dFPyeHzTPCl6tXHGRh3xGgWVd7uO8PqEGYGCbkLShj63ZiSUpZmTtQmyBhYDyLeGeREnGqsqUrN16B2GAf6e2SSW1hhzUDb1nIFPdxi0zEvbNc85t7nusaiQ7h4V5oBjZLQdk98qmfD8xoopHs/qhpXEsz58jYKV+Q3UJpnwlgBtUBVyIewlPXpE6Ti7X33y7bgnZ7L19VmGIZJ+4=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(26005)(186003)(40460700003)(82310400005)(41300700001)(54906003)(426003)(40480700001)(86362001)(336012)(47076005)(4326008)(6916009)(31696002)(316002)(70586007)(70206006)(36860700001)(8936002)(7416002)(8676002)(2906002)(966005)(7636003)(31686004)(356005)(82740400003)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 20:28:16.0177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9d6420-9e49-4657-20b7-08db41149b31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173
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

On Wed, 19 Apr 2023 15:22:02 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.12 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Apr 2023 13:20:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.12-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.2:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.2.12-rc3-g7507bdf58f79
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
