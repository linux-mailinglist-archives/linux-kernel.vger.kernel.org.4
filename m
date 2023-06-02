Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8F771FC60
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjFBIpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbjFBIpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:45:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B9E10C4;
        Fri,  2 Jun 2023 01:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaKaOWkstxsivdCDn93SuP+gwVyCc7Urw6bntckiXTciFo25lzIR3jX2AvetE9NwDVKCHaVX3JLFFGu/dYPSWjkNixYVJ+Ummk8ZibbJGquVXk13H1p6Cw/J37sJX5Ey5R0zN1fx6sNeDqbVF9mtppLEdeSn3e4Yad0F9tZeUIOZkPv0tvdstwdJRD8iUdLvJcPSz4OyoC+/oCmfQ83PRBUDOB3HeK8TyVUrNsDOGmyb++9EU/VxFCf9nSFsPN8AhjTA7RAGJfHgJ41XchX0sdLatPZTKplsRvFzD528fVig5wR7q5nPchOkUSYdbHd5d40cEsK28bE3A+CqcEp0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TqFZS3yQNof6f+FN7PEq9aI9iW/OmOkG1Rz+IVjSts=;
 b=Uybx+lCP+4AWvsk6CDVdxzzECS0CrFAMUVjAm3DTITIdCG5jXgTtoI08H40gGXPt8fFrcV5OP7TgvOVmD0x4Q7BzAaGyzN1xLcUcqRW/Cqn6GcowgJfHozhWLYuV1eQJsPD/th3TIgOWXVGNFzkifIgDo4zt0LMogrWDOIil46JD4EwAhNJ18wE3DUfD/KUd5MfDOklc98odcQQv1SwAJUA6NPESVsF9eRlZeYxC06UmrO8TVuQtVmJnZWieWFQUezyoBEKVsFaYoYnTiFvuhGdINjaeV4cASeWNq2VnSLu6tWRiX6zPL4iZH7ATQFwGTjjQUvdkjcXBIgM6ZV1eKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TqFZS3yQNof6f+FN7PEq9aI9iW/OmOkG1Rz+IVjSts=;
 b=k+RPrUyPqi+L/O4Qxc4Js9PAPlL1pAFahEuyHbUwbD1kGGRNOatpivySTWRKpW/tj6PsaIZDOxiJ8dKCg2S2Rhc1mPLOWyDj14Pagv5HMDh0lpLmn8M9SAtlYo6rWJTfrby6kMaifPpkWaw3s40MAxKtE7gADw+exuEuqkkIVTeBBaJFQtNF+oKKHZQUol0epw9Newq7e8ci4w6SwEpA6ftZfdMiSUKlqIPEfyBKGOTlAfeH6M4pgttLGJMlwuxq5V+FQS32PoggvcJ2xNIImjGTD9D+4oj478+fwb/DXQd6as8nDovK07I86BxyoqOAh7wqUGmNirtAAT3c0ImdLg==
Received: from BN9PR03CA0463.namprd03.prod.outlook.com (2603:10b6:408:139::18)
 by PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 08:45:22 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::6d) by BN9PR03CA0463.outlook.office365.com
 (2603:10b6:408:139::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 08:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.26 via Frontend Transport; Fri, 2 Jun 2023 08:45:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 01:45:11 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 2 Jun 2023 01:45:11 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 2 Jun 2023 01:45:11 -0700
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
Subject: Re: [PATCH 5.15 00/37] 5.15.115-rc2 review
In-Reply-To: <20230601143331.405588582@linuxfoundation.org>
References: <20230601143331.405588582@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <92ebade5-4efd-4105-8049-9a7d9cc98da0@drhqmail203.nvidia.com>
Date:   Fri, 2 Jun 2023 01:45:11 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT061:EE_|PH8PR12MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d70d44-7a71-4be9-e098-08db6345b342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yycZkC40KRjf2ZBWv9xdIHcjIYR2j0sVbEScaDKqDOA9ncwdHevvjMy6OWFynD+eWyoVE6JDfD6++iqIkAZVnpzVdnNG/UE4ulkuVUdWqTPB6zcpGxGayxpo+JR+QhGivZnZNDnyF4XQFb97gfpnnQR/bm1aceZHndBJzjPKpBb+9V+s//DFsH8J5K93hi6h22m3H2FVTXjiin4q2ovIWVvId7GOrYEnZUcSnawxnhekom6RitZLG3ZBkvhxFxbdwK2uOvstmKHCfM8PF+ranGkDqE6d8TnEwrcxUk7AhOTOeCAqHlB1dKJlDvGkGoMlWv1PsHRMTuXGmn45zbZi8ffsr8O5DezcLj29+Zy9Ae/D4cM69BSp91HG7RXSvviPTmGPiZwdoJm9aduhkyZU5VAekPLgDihm9J2zangUNXdoW/est1l8nti0Xu9XHJ50l9uHP41wvu0+mTlin9/feUh6GzmiSm3e6QccMaTqCa4Tkal11ES28nrw0X1J+Kf07rAzU85laGfv7Zt3Qi9kI1fNO92MGje6NF9bqySksibM/AHqRw6iOE727lep/GvP/W65Sh5mba5JLUA5FyvRNypdonwN2jcAQ8FZpllTbt5PVg2+aQYZyZ5yAh66Xe3yilpk6yWMs8nTwyZa0zu+3mECYhjaWYItWZQkFkpNSPv3xc0O3AtE+hnhtjbPtjCxU6a07w4rG8jkhULDLesg64xmRF8qipU92jBliguWvpbezuBeNfKQFZYuYWLL3S8Fze57PYVoyC3YsKUMV8unzw==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(966005)(186003)(41300700001)(31686004)(426003)(336012)(26005)(47076005)(36860700001)(478600001)(54906003)(40460700003)(86362001)(40480700001)(6916009)(4326008)(82740400003)(7636003)(70206006)(356005)(316002)(70586007)(7416002)(5660300002)(8676002)(8936002)(31696002)(2906002)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 08:45:21.2580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d70d44-7a71-4be9-e098-08db6345b342
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 15:36:06 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.115 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 14:33:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.115-rc2.gz
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

Linux version:	5.15.115-rc2-g31e35d9f1b8d
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
