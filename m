Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B28E73690C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjFTKVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjFTKV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:21:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC2A2;
        Tue, 20 Jun 2023 03:21:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKNEjJK3VxH22RL7zUsexl5RPWnx+AWYSWrA+/v96dhPavG/XGsnBQnfotgxnbMHKBLSEF8Niy1WMJ8hJSI4PZrDs73bvZh8/LtFcCVIxPxJ69TwULV3tsLdH6C6GaRyIlPe3LJ66TjLFI20f1Nots8k6/J3kIEiuqDOjNLciVYdEAkwTGRYB9VJS5k8q56PRUF0WNouP8RrwwTVnK1kGweLJL2p4x/+QCATdWqOpft6+R54EMHWMg2BgTcv5XK0incrDQqmr2ZF4ZT3DFy6L8u65Ls6e0tjCtJnVSCE5uX2R2erHigb7E4WHUkvL3wFl4X8jcHHarLNVDZ2aJtjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcEuivbMhioD0NrWvEDeBMi9GwsRNugzZJNOalSk9jA=;
 b=ife0z2HgbRN9qWeN8lOuMV37bq7KjuuKycQdB7N+dmfs0fsgrrcQSGgPYoaU7tGB4MyMpbHiZMT++i2eIIlRbuLofK2xTOqcK9g3Cb89HBDKhMrC5MsIgtM0CFr2kNYpCWuwxITKNvIjsPTaSr1vX7ybVkWCvg8IS5Wc6chpgz6LwFi503gF37J9Gu/1rMT+pVcvA+rfa2lBUkwP9+sa9x+nMJZlMA0uJRHr5tIuXps9koSZVOw/QHsVHK9wehaTqty/24a9bWZlMe47TAtvrQN+TqMdMi9FL7BpF1N+sZM2kLUnrlJzxgTu9QfO5PafIPvYwndcRST0H5S9+b9zrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcEuivbMhioD0NrWvEDeBMi9GwsRNugzZJNOalSk9jA=;
 b=teNgj4SzBEHdW16YjP4H260lCViU0sKesWB7qscFCySozp/mC9f0vjO8cAaGGYtn8SLQksh/LrpD9amIN7GXGWJmQRCaaotVjYQn+O9sLXxg45LEGZPhmPGkPTozmhxxvw2dUV8gyzWUjIzzBHqVRkImsZADGKiPKZzWqm+2zYIxfJ15cXwK9tEN7ZkKKdc6BbR8YWkzs9l8I3m0PjEP+rtsxLjN9ovKNcNKg6mC2YmrIRQmToQaE/O9zSYJdpKbGVCibOdQtuhxyAiatlIFIkAxh7+orq5m06+9wXJcUC+GKm2+7/U+qq/OWy6mmsdo55zDSiy/HO4sOPt29BEl5w==
Received: from MW4PR03CA0331.namprd03.prod.outlook.com (2603:10b6:303:dc::6)
 by PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 10:21:25 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::da) by MW4PR03CA0331.outlook.office365.com
 (2603:10b6:303:dc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 10:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.27 via Frontend Transport; Tue, 20 Jun 2023 10:21:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 20 Jun 2023
 03:21:15 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 20 Jun
 2023 03:21:14 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 20 Jun 2023 03:21:14 -0700
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
Subject: Re: [PATCH 4.14 00/32] 4.14.319-rc1 review
In-Reply-To: <20230619102127.461443957@linuxfoundation.org>
References: <20230619102127.461443957@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <15eaf141-6acd-4d41-a4de-ad4cac173abb@rnnvmail204.nvidia.com>
Date:   Tue, 20 Jun 2023 03:21:14 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|PH0PR12MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fdcd5b4-37be-46b5-f9ae-08db71781a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvy7m0qFsRPauvCS06dVTD1cfpnXZzesa5tJJAGe42nZqVAJS/gRxtWqRx3dUm9aGXUP0+/vTyD9kC3Z1Dox7JKJhN85bB9pDRuEsuPLwW3tzBsAziTjWuV3eKQsnJE+3VZwGwHHMR+twQ3+GnpBvL2wbeDTja7TfP8U+KJFQDljOWNaLiMn3Y5QVih/w9UKRtJDQYQV8hbzrtjz8YCjmPtEKd203pD2Vc5NG//Yie2xuYWl6b7P0/m43w6Z1ZwuDNcdRaMMvjRPho4fnCnw3ITVr/h+0ddRmmGCPJcrKF0u0OaFsi4N0tCvl9Ebx69lvaKo7rZKGgXsG1FHLqrYxAgTSurCfPZujnrkyJ+sU7ttG2kwZLJkrkSh3w4CsVkMnbn/z3bkSLra+iQuE0pfymtxv4XLPzOHSw3duH1LdLHuLvKMfYeA5EmT8K58Sf6H83JPI3GEcXHsu3O+yYohejPmzYIg39ya85z//3QKtyhop8PPQxYp61Hq42Qr7+VUkucveRkG8QMgf+RRb+TDNQ6YHxqPbxze3evYBr37bFxXJQCJtIqGwhCruratyz9SVOlx6x9T440+HyAXbanXeKznkWUIopATtwSVwsSFWc9vpuXLGZoVz1hnWqDypd6HFgbsH2kr5PeZZ4biZUTr04YxWrq07mU7DXTQQ14NQdzyZG02OqYMN7h0TEkgj6vL2LFve3krwFnHTGxJujhXoNmxaxA2lizz7diDWQlQ5Mm2StoSzowlqX1KT/MLfpjOr48p9g8Qv1dAtrqZqv90iSkwKcJ82kZ0TQgGJ3FCyKE=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(5660300002)(7416002)(2906002)(40480700001)(82310400005)(8676002)(8936002)(7636003)(356005)(426003)(47076005)(36860700001)(31696002)(86362001)(82740400003)(31686004)(6916009)(4326008)(966005)(70586007)(478600001)(70206006)(54906003)(186003)(26005)(336012)(41300700001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 10:21:25.0729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdcd5b4-37be-46b5-f9ae-08db71781a2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485
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

On Mon, 19 Jun 2023 12:28:48 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.319 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.319-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.319-rc1-g30c57b30b667
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
