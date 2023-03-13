Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1956B7923
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjCMNiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjCMNiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:38:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FEE9021;
        Mon, 13 Mar 2023 06:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ye9OiXMRNNJKXEPufdXRZ3nLxerodOs5vj2g4VYHnKVekADT7q5dJ/7Rr97VccIlNL+A334kCXBp3MbiiN+CSaTQ6SA4KSeSLpc2/x2icEMoLWes/IR3V+cgOICvkaBODEWHjrmzE7CKwBDAPq+j0MVsXkgi8BzmEwDORM0HIGXLCjoOibdDYN7BQO2SLSEtSOwzH8fBIYaul9kWXk9ofkcvali3llWfI5SzuGBQU/2psBsp28GDh6pBjuman1M5U3fDNwnwfvz3uJn5BHAgZ+/4xq/ceouqe1CWb9EC4pptJCK+hgmckKv2/C+sCCVsywNRuXFJrhHuHEYzSI4A9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIb7Jszuv6bw3LKTu1u2ysRnF5fbOYFAb2Byb8TE+zM=;
 b=bPKGNYslNJIE3c9XL9Ug45TKDFiIhVx61nnP2SR4Onmc2yP9VL61Id1j3ySgH0HJkrfOY4mUx0L9Re8veYb7wKE5vGKaAGoyINuQHt0R0ewCXKMdmXQfDoLW1PpHjO2Oe0om4D4BP2cq73GzhKjq7f1uTyhrjxcF+7cfcEsR7uQ1YGu8xYIS3ThKAlO3iLfJiqMYdaZunJwMPjcCMx7/qIGKESnNriP2dMJzXC0gIWXblIEGS96ElbuiaCDKkEBsZCeStnKhpsdOts3K5IRhRcXpnZ8D3LGxKUwJjjwSdAlWyEDj4Mi2o7jIynRbIIJ9xKXkkzLKYEQeBHsRGOzweg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIb7Jszuv6bw3LKTu1u2ysRnF5fbOYFAb2Byb8TE+zM=;
 b=OX2KZDsI3lKwAOQY90TEMc2tzDPyfr8IkRUl+j7iN/ArEySbr7xxoE/hYKkeYS5qXKys9zz2ZKM2fE8tb41a4KPfvgyjKc1E27XZu2MqOWTyo/M8mx+thMPFkG7T4PjPSZ35LF833Rw+QPJSDraxNa6YHbYH6gKNootK5+nAqX8M4RePlFn5vkoDT7tn1uc9kjj0FksTvP+x1CUdZ+Fra4eunzuqJ+4uRXfQqoiahnPLNgN+vqL1XVq8NYGijntUr103FMQUdHV5ZsFWGj7pBN+0LMBzNXFF5fJ79BO85s4T/jFdS6usFecSGxfZZGCAavM3VNdy6Kc+wUnnDJvC2Q==
Received: from BN9PR03CA0436.namprd03.prod.outlook.com (2603:10b6:408:113::21)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 13:38:04 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::ca) by BN9PR03CA0436.outlook.office365.com
 (2603:10b6:408:113::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 13:38:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24 via Frontend Transport; Mon, 13 Mar 2023 13:38:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 13 Mar 2023
 06:37:51 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 13 Mar
 2023 06:37:51 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Mon, 13 Mar 2023 06:37:51 -0700
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
Subject: Re: [PATCH 5.4 000/356] 5.4.235-rc2 review
In-Reply-To: <20230311091806.500513126@linuxfoundation.org>
References: <20230311091806.500513126@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <0d8649fe-0c30-430c-8104-97dd1ccc0e20@rnnvmail203.nvidia.com>
Date:   Mon, 13 Mar 2023 06:37:51 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a825568-0995-4a82-bdb9-08db23c82bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qDNz0nYbTlXguhZr82sqGUGsx1MNh06UjS2QMi/691dFsMWLgP7uF51C+G22AEEo6JXdTp7SUwOyowvSWMfrWiI0d6lWptVMlPVcHFmgkJ7GixODeefz9aTQfq+VV1Z41XeI+no4T/Rdvhff2R3IEILmJHDFD8pautSrQG5lrvGq5M6H5jMBLvPcsEIbQsqi4v8P29x7hPMUn3FXtDZOUhrhIQY/cDwpqD54YXvlVY2DR+5qDso9uE6DKLcm33EM/r39vF9sP7DBJ0YCY+TiQvrnon98zORW4lfqgGhyRicesmLPmcsI4vfkLZiVZltE+kURvY8cr0Da9W5B7lb0HRbeDZRQlqCUcj64nUic+QVXmvPUP4DENGsGLU7y5GW+LkrBsddVK+RkSAH67rBnIqN7Nvwc1fHHOpuFEOqdwOFh2zy+xdWg19JoDlvQezD7F/HpH4Pum7hVILFdJbkVTduYvARmLsF++qAax83jMSDMzEIL97ijsmq36VLfFjjjo1DqcrbvU4CYEH5CBteuT1d4bqqqBVzXECU54zCJ+pf6eHjImGPGIeOJQzwfd5gb/RFGski0/s75OAPMXq8av2PDSX0PXk2a7hWG6fWCZPwUczkx+bH/whKOwJOUZG0vSjRZJOuiJ1XF1Hy/3wBIlPsNnFpnGc5RnI3BezogVJnOyUWqB7UTKV5DSvvwgF44pGGYGeXrNi4QfKI3FF2lbWx3QH1FEUN8TURT6lMos79CwleQS6498APVS2eEL/G+2T2TdxbRhWZ812o0TCgP/bZtAPZsP9rfmsib2ndslh8=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199018)(36840700001)(40470700004)(46966006)(2906002)(7636003)(82740400003)(31686004)(41300700001)(40460700003)(7416002)(5660300002)(8676002)(70586007)(8936002)(356005)(4326008)(6916009)(70206006)(316002)(40480700001)(36860700001)(54906003)(86362001)(31696002)(82310400005)(478600001)(426003)(47076005)(186003)(336012)(26005)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 13:38:03.7540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a825568-0995-4a82-bdb9-08db23c82bdf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 10:20:37 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.235 release.
> There are 356 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 13 Mar 2023 09:17:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.235-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    59 tests:	59 pass, 0 fail

Linux version:	5.4.235-rc2-gca95bdb3ada0
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
