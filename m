Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5265E729FF6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbjFIQSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241993AbjFIQR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:17:59 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC073A81;
        Fri,  9 Jun 2023 09:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOLFi17YCEUE8so5jrjrcaWJW3MqDVXcBTQCMivJ36YhmkrYhJMsySKckH6NdptnTuiMm4SA3zlwFnE6d7c67ocTNhbXykUgkQF0pf8IgOOEPK54OJJQEq9Ggvvt5sAmJG+gJ3WrNr8V+y1vybwvwa4V10ZGrbHIkNIIfFkKtGCatoB989G+QIccwWbItVzDqZtmhwtIfDwQv3B5fxp3G8KCZ3Q9sAWYT95OvvSnC2v92uNFh3VQMcSWZRucDq4qDMgDvoiptMzXHcb2tYFpPJSzR/PNoGcG6wf4UazB9z6Mz1SJY0fhFgy+gwJB3ZGlIGBdhJzzJdnzfsd7jwPSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yR5dwFT2WTRqncezpboOJ6U9nVY0RZm0sEZXtgQxHE=;
 b=Qd2pqbLmdl3wNQ9fdvXXyXNTRvKyoshlzP4O+ciAl5YnCiHFVLxT87acuLrRqbcDZ9vFxGDlzeDnSq3uHuTp+jU7QdeRHLP+4jegL7kskAlzbS5Eg3J/64V42lB3yPmxpy5Xa5NvxR5MOtSkCvjyMC3CDx7d+P9aJw9BYp2v9C0bJVijV3Vb2whWXYdORyx0XKLLfNPztjvRsSachsHo9/mN8btXpU7rfUaD0cmdDcQ587mOQIkgU8iAeQsJ7nlEcBvQfbowDl5vyGgxBNfXb5QCtmuu54EYWPP9+2zssPEOCZshQcxu1kNKHrLxrENtUez4Yg/yu4vJszVn2kZ+lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yR5dwFT2WTRqncezpboOJ6U9nVY0RZm0sEZXtgQxHE=;
 b=Q64AyinEvbr8DI/HTf8ka/wYKkA58U5UaLkf0OZkmKHDTX7sjL/MD90SYp65nE/NAAoA3pA0HXDueUFAmtPA6KABhutLq4/d4xH7TEI7Vm35myA1Rc5+4Ugvh9FzH9REc1qE/w+lhBvsVdjZxfgtPCsPGGEVldVbO075CBB72uYhrWtJXv61Yblb0aUF0Yb5rgUvhBumL7PnSQN1y5BXv0GSMc4xzMJC5UAZA7D6ckHKIAJ9FWkk3D+lDsCw02ZcSPkdtF80bJqOZUjAaQoVM8Fh6pkd6ruOgXoxAH3B2dKSGyuGNautvu7a4E3op+BjsdzfF2GoPdRl9iOA+wUrGg==
Received: from CY8PR10CA0012.namprd10.prod.outlook.com (2603:10b6:930:4f::28)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Fri, 9 Jun
 2023 16:17:51 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:4f:cafe::c9) by CY8PR10CA0012.outlook.office365.com
 (2603:10b6:930:4f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 16:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Fri, 9 Jun 2023 16:17:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 9 Jun 2023
 09:17:37 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 9 Jun 2023 09:17:36 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 9 Jun 2023 09:17:36 -0700
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
Subject: Re: [PATCH 4.19 00/88] 4.19.285-rc1 review
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
References: <20230607200854.030202132@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <63fbf00d-a7b9-4644-a2ab-999891ef1cef@drhqmail202.nvidia.com>
Date:   Fri, 9 Jun 2023 09:17:36 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 847539f6-3f99-4207-c0b8-08db690512cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWO3O9379CneIsD+E/rZYl/PsxeO3Lf3K7rNXJZ06e8n9yOY9oBdx2plzf++5UcSCd59kmIF6QXk0tme2ZFtU1vteJU2V17mZgWKOvlE6ow4n3BFJ/W1b2qBXzmJfHpT0Skg+REGtRs8l/xPTu3hZjeFbnJDjdjG9OdLvA213O5MvGUtS2nSPyuEjRiqHsf7/k4nDs2ic+6Wgpw+TJeAfY/M7LqIMH5B2zRXd/GV1QgraZQaIn/V8vvziXwgx0xOKGuCxpg9vW/v2XYVsTk289xHvrls4J+d34OOeiBoNrc2IdM2UoZ0ZZNKzDdHHKw17nk7aGLbAHnJ+FvNfOjAGD3c8YxfluqpiGlev8KGSx6FIWb6YZoi+Rx9hBXGTtZAEWVKl1kaamO1NUey295N2AyTOnRrgLOtkvTDPCvXMx6NllELwBt7TYVuYlAuSBSbkWbHaQXY2RgoMzgj+0btlUjqFm1wShH49MTVANODgcTyW8q3SS40oDuyD32avtvMlISieBWyhufkUWlYQNGHeoIxSbsz2STD6bJfpBjNGrMXq9UzByXU+mgLMy+QTbvP1EDjmovJ7MPu8m4BRBcnKcPKP5RfoL5zVQeppZrEvU3lpoU06ANwCDlO6YPZCs/3AzgwXyYNX/1xWmKqMGzG10HxvfnDXrfnb1SQ5MmQSQNYto4mI7xHGf9So+nW1p8G3EKjwhlo6unMdbWe5Ep2Nq8/+Blm/pTiAiYX1SV4DCZqGx8vPuhF+mZcDc5A5QaNSOSnzt/sA7YubG8/hLp29ZC6wlS9SNSz6yg0dQBfThY=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(41300700001)(478600001)(966005)(6916009)(7416002)(316002)(31686004)(36860700001)(70206006)(70586007)(2906002)(82740400003)(31696002)(86362001)(7636003)(356005)(47076005)(54906003)(8676002)(8936002)(5660300002)(4326008)(336012)(40460700003)(26005)(82310400005)(426003)(186003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 16:17:51.3321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 847539f6-3f99-4207-c0b8-08db690512cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794
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

On Wed, 07 Jun 2023 22:15:17 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.285 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.285-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    22 boots:	22 pass, 0 fail
    40 tests:	40 pass, 0 fail

Linux version:	4.19.285-rc1-ga1cebe658474
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
