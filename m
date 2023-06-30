Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE30743B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjF3MKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjF3MJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:09:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2178249E9;
        Fri, 30 Jun 2023 05:08:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UviX6xJS6L34PUPrW9yhmEV6gvNf0yEyewjUhmHDy8eTAXI/hFC4vAuQg8K1+MGAmzxZ/vcHGoTF+LCB/IJLxbfKaMW6bJ7k/CGOGBWOcH5y1Zza3+gMD6trwsqddC9cnES0p1r0Kpu922jOQeJrZ0M23iMKY/QM1r2rOuCWdLlvqUf0gZTkYPn7meHHFZ51AizKhQB29gCv0gO2dIYuhcP/9yaTmpt9SNw9ci5pLcI8wN5IkO0mmYO/uc8gwjnLm5UwKaHv5ApKzAgNO63E51j1klsU6gMXLwdaxQZOlt54U+kGiVvWpLwAvMwceIMP6XTuaM4VoJuWZ99b6f7D5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFjBh44Fatv71WfoJc2LsAnfGfJKygyb77kgmlgPEPY=;
 b=NFH9NBBSfT1kYFY8Ev24NUxw/NDBx16SNrlft0rPaQk/CP3MXP2dxzpoUHYBSlS3tx9+aeb560Rhu5yrTqK4iufyvwJxfk620DUlPNHGNHkE3073SQeyjTRR+pUMKO8C1Uk9HCTQfaGKqLYtdrUWD7o0K9A0taKBAtrV5w2C15K7q6Cj137gMucJ1KDLR2WsYaNUtPHIpx30l32AoO1bnPsP9WJRVoMApKxIQnYlJRyLvlYWX8KLGz+Q5dXF86tdSDCfWIxZNNyNGOtutyBa3yFFtWrCmn56pIMqevs9rlxF9ejpAarOEaXtQmPnFVjIgqu9jrpTKEMBp4UTUVOfXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFjBh44Fatv71WfoJc2LsAnfGfJKygyb77kgmlgPEPY=;
 b=gWed+vYtfPDpNWEeBLRvqGU6PF00UnkSzKT9435UmSYJRkFD4qOk/mQzj5clDM0WibieqAUsabLJuhxcDwsWn5g1TFn0Q4Gwi7AGuZ+DU+3Eb7Z9KHRpYnr7f2dGH/zYK1bzgjN3nVCNwj2ATV6aigilNxYA8I4mPc5//JG9eEXhXjwx6siukWkMiN8PHO1Yh/EH8oaxKtPyw8B2takulCZR14F2tJYVJ2Az5USCQreJgoqgp1GVNquqRqsuSHggX8Nrv6zsrCKtPD49EGllqnKKZSBgd75lNJuHVKBkCiFKTMNXD3d/T6l/tCmHP3vwWH/Pbyezo0f1QH49l+Cnwg==
Received: from BN8PR03CA0028.namprd03.prod.outlook.com (2603:10b6:408:94::41)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 12:08:24 +0000
Received: from BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::37) by BN8PR03CA0028.outlook.office365.com
 (2603:10b6:408:94::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 12:08:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT104.mail.protection.outlook.com (10.13.177.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 12:08:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 30 Jun 2023
 05:08:20 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 30 Jun 2023 05:08:19 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 30 Jun 2023 05:08:19 -0700
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
Subject: Re: [PATCH 6.1 00/33] 6.1.37-rc3 review
In-Reply-To: <20230630072124.944461414@linuxfoundation.org>
References: <20230630072124.944461414@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <f445ed10-2113-4eb4-ad7d-1a59b87485bb@drhqmail202.nvidia.com>
Date:   Fri, 30 Jun 2023 05:08:19 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT104:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: f22ea541-96dd-4c59-113b-08db7962b3f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZOIYftclc2QjQ8+pBV4O/prCEbvK7l8ObV9yO3KaSEHO4Aup9GtyEVM4I4bAfVeoWYosCDEZ5uLgyQOEuaSnyIyHuUBb/MNPks5pjQ69TUyx7lCigG5UbvQvwK42621OrbgFNpwHR+rZtBD4BouVL1RFfkGsJenlj8RoDj11BMviiiYVaYa70iktZkRX5X1FcLZWr18T1PruNhKJQk8b6Kn502wR8jmFD2v483jP5/gZkjekxUrallvoTEi+9Wjos/B01sPkkyriuLO9mBj98gO8bPVHhVR3KUBXsM7wY19iie9q5koO7AgchWKqtfJH4Iav3rMZhlQZWUY5FOiDLgwPCzMrdC22G3oXuOyOuwOivCUXYRVkMd108tE4/Q0ItvFE0y8Y01sFN+L+OKsE7xUN6Ad3WJl46UsQJo+OBfRVbkdR/ISXh0YBy6AP39P+/nAVx/WXZcPb6oed0k0jPRKdRWzowt4gE10Dyjm77x9pdCmapcvvT6EL/z0PcIfgMmqMb/f6ohtDa/LN8MEQMRV57JTsc8XRIAhS7hnipJrwHotSPvGK520Xr3GF/YbnLibRO2/IHMKcMdiqR8LdHea5BMDhtBO0lnIxR4TrK+WTUTPI/HmwE9HUibs83K7DOzsCTDXa4G4JeUWlyg7X3SQ6XBwGswUg8ocuUIiGt+V6NJiCO4ScIp2KvtO7fpSIZj42v4By4GgiFDzt64I7NnCX5dNiu4Y4bVtOBcLoPbkITRsCN0SBgIL/zOdB17A
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(36840700001)(336012)(426003)(47076005)(2906002)(7636003)(356005)(82740400003)(36860700001)(40480700001)(8936002)(8676002)(82310400005)(5660300002)(86362001)(31686004)(54906003)(966005)(41300700001)(6916009)(4326008)(70206006)(70586007)(316002)(478600001)(186003)(31696002)(7416002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 12:08:23.4120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f22ea541-96dd-4c59-113b-08db7962b3f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
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

On Fri, 30 Jun 2023 09:32:49 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.37 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Jul 2023 07:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.37-rc3.gz
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

Linux version:	6.1.37-rc3-gbb9014bd0a31
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
