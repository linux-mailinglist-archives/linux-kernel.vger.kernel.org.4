Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E125628786
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbiKNRwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237705AbiKNRwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:52:13 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6291A2611F;
        Mon, 14 Nov 2022 09:52:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfTlPWHLTGg4qX4gp87JHihvmbehfoHjb/VBGOZ8G+kASDNooaIKzfUvzsrNdyml+sUt9LZtSejBP5ZdCJUi6OLJxnrXaaUD8RzsY+Z8MwZMl17oVXQ/adVzKJz5ol3SoWmlpauU+v0h4ReqYmSolaRH33t5Y3Fi0NI9VPdu384rPwhZ2TddAua96Fdedj2AUOC814prbd58QrM4lCQ2YhbqkaR7kyFLSOGhAYBBRAh2PNPyJzYvvPe6JzGdDW5GAYyyOhtRmBifJgrbjApFuB0IriN99wVjtYdju1N1oUO2Po47gKtxjU8jlCs5BBDGtOsn3czKyQJ8wiQraoY7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCtfFrLdAXJMckP+kxETXzWDZ0x6XYPEv31V7paozGI=;
 b=C+2dUi54IeWVTczy23fFb+72clRhR95+J4ptBHBjDjZk0m4BdC3KT0vSG3q0LDJ/j2kya+hXVC2dlqgxjwmJzWuSd29j4M4qazEcdk1tnVLN0DKJEJJ7Bu0u3eENobjJE9zovMxNzvKNjwsagH8C+jOYGOopD0fxGLXZmKRAyu0glDz/sK1OAkcmswbVzYB/biVNr+i1B2QBGkfUpK8oyriJB+VU4Mp5Lc+ry5s8Ly/CeAiWCmgIvj3HhoW/XRPHgK5O8bMejvf78X687rTBiJjwN5clYAHUPrJdUSiOvomp5m+Dg/BaWsYUXSlcl3jlg2p1xgZQtR7HoBnCfIBZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCtfFrLdAXJMckP+kxETXzWDZ0x6XYPEv31V7paozGI=;
 b=PwKCE7UgWtjEJ47OhcVUT+C4ysHxLDGCOMertceKWfh342QGJxUJpUrKKwuNNp+tdJeoPGOlrE4BsA3t89nsJ1VCFF5VUFRj04QW434IMEIL2HCHPB7uCxH7LAYOd3FXPsrbGApAZNxx/3if6JiMJj12XdyOL2I8aPP5gd70pc8lF/1hqvyVey5v+mqyp9cVL2EJmOHA1tqzaGkGRaFuMtGGCFt90N3ngSzjurOFyvgzeyHo9Hff2mCiyreHqPkUpOYH3YP3L5C1eaNBw4eld9m59WdOt0c/uU5InKFyUU7wc7SA1DmoaabHzl8qsG9Gh6abyS1AmSV6xqQ+XyrN0Q==
Received: from BN0PR08CA0021.namprd08.prod.outlook.com (2603:10b6:408:142::16)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 17:52:09 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::a0) by BN0PR08CA0021.outlook.office365.com
 (2603:10b6:408:142::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 17:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 17:52:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 09:52:06 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 14 Nov 2022 09:52:06 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 09:52:06 -0800
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
Subject: Re: [PATCH 5.15 000/131] 5.15.79-rc1 review
In-Reply-To: <20221114124448.729235104@linuxfoundation.org>
References: <20221114124448.729235104@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b1507add-636c-48c5-8485-7d668055290a@drhqmail203.nvidia.com>
Date:   Mon, 14 Nov 2022 09:52:06 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|MW3PR12MB4508:EE_
X-MS-Office365-Filtering-Correlation-Id: d8817ec0-4655-470d-cf63-08dac668f3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSXQxLCF53fSArAoNWKojloXxpd6qR//98rxt3i1KrCN/qUL5ef5zCncimC8GsHA4GMnM8C7KkPfAxhG3WeLV3uFPHHwdaPzBx8ttkoS6DQE+yPHaAt96rc/JEc1kfMvchcBqBDWvfIKDIx6k2Uu47upz1+JpyZzy/NTIfL0LUC2tN5EivZX9vsl8nCHfqx2nvlPF482aPox43yiJmTLt3A5S/UuMJavx590hzZu/VB4nhpYFieOJ2V2X3Ew2bcH7WrLq1+lZudOHtS2Nq23s5yw8CEk9Ajm6FoZjtjANubrmH2mwSK4QngWpEO24JEJ5gYmBMeKNHP+6WqWR+qZ66gaz377W5TKUR9jSDKPIUQQzKgLl3dy5XFbamOpg9As7/CeS4Y0Jlr+redLS8Q04K3oyyDpqb133pKfbDHRFr+qVU1lLmNi8AqQLKUYCLv3R/TcP/NyKExBaIE8UoPRH+tVaZ5a6wNBxdVCsbQl3IbF1jhE+ZsaLB+01RxPuhITqRPc+8QbhllqhxOdOeX/awyWws13eNWrmZqpZZFZjd8T/JT86DEv1sDgAwDuCEhuvjrVMcZaj33D1Splg3fbYRscHXT3CBKyWrgzml/4wXZShKKR2WbTuAUGCZErMSyQ9E7LpZ+GCxfhaRYGmVoh7dcQamml9g0HUzGiSTHVn4MDZ5KFvwWlnyDSJ2wdfOIjIOHDCCyr1vlh8TZQj3Gx6l0Xe4Bk3SrTW4P5FjCDCzbCudxBg362dDhqqlmiURj4kAnNnwet1odgov8DfWpGLz7G6qm4l2mBJdPQWyyfuLeG1lWXwRqoST0//iQol7nVmEN9UNIUOkX7udfs+TJCpYYOUMQweVJfMobEykzBJkI=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(478600001)(36860700001)(54906003)(40480700001)(6916009)(966005)(31686004)(5660300002)(186003)(426003)(8936002)(7416002)(336012)(41300700001)(2906002)(26005)(70586007)(47076005)(316002)(4326008)(70206006)(8676002)(40460700003)(86362001)(82740400003)(31696002)(356005)(7636003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 17:52:09.4351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8817ec0-4655-470d-cf63-08dac668f3d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 13:44:29 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.79 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Nov 2022 12:44:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.79-rc1.gz
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

Linux version:	5.15.79-rc1-gb6ea7e152210
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
