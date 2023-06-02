Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8240471FC6C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjFBIqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbjFBIpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:45:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F0010C0;
        Fri,  2 Jun 2023 01:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iyhu2zETnY7JwSMiSfyHE2ldJipTqNOz5pj1PoijVrAq6WD2ywu5/qW6zdQPWLpeGy88jASjqciP2zgFxIa/HqW3SnAYJvR7IAkyZob6NFwN7APN37EQqzDMD5pF99Td0SWrOrZQklZIP+uCeD6CvP8JtVlYToGYh3LYGGVT1M7bA+QqWkzxN25utUqkWgdWPQjVFnECyQ3hREgTxSQN3Xh4Y6N4WTqlI5Lak/mzm7jOE6+MXCf83UT4MuYo6BXl2h2QuBjBUn25pnczdXqq2/wJe33SqWOEjqOirajkAJr5r8OanYsygrqxTobkMkK/99vXxq9oCgsMWMBlld06RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDwW5vTyArGAegOtKNtgy3fdOGlgrhBK6zx9dN4Lqeg=;
 b=SmDYJ3zbyOpn3hJ+rXRZxSuPsg0yruBWDvmi200Xske9FnuZoUbFpTpGaSfB6gaztOFSOJQ7jlEfDbzGA1tT8LNDgBXTxn8N7iGxFgV57SUVII52hqZ8+Rux+T9w1KgNIsSTBMjBYkqK+LeX+YT8ULT11WDkQ6CMOOjdlaOIwUENCoheDOfI3ka7UXIPXK99qWnqV6KzleLiEL7j5wrvgq7mkcw6VIcPcYorqYtWkFDp5ux0sSR9a2A79OFYPZ1nnAwYZKfJt6wt1IxgfQWs0FvEotwxviOuzcs7G4KqoDAl8WUm2mb+lAv/IwqoQxkFEJdVgDMuIqZTzcqAyRakRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDwW5vTyArGAegOtKNtgy3fdOGlgrhBK6zx9dN4Lqeg=;
 b=kpWjx1X83O1Ai+Jd7rLmpnHMWJRzPBJk3en9uSVAJ7SGe/l96XcKQjtbocFz+3c1Ma9C1VCx9A4eJTLgjwG6CFjqO1tMoftYjJnKiwNxyOR5jfcs0SYVSeTdY7KRrSajOUKWpvGRt408/6auMRagGpbYHPpQLkENF0aW6vKNGIAZ/uyiHixD+VeYSWvhhf92xb+tIKqr0OLX+d/TEhrxvdXayo2NSBRZ2xGbOmoAzHXw6pE46UXdrsOXy318dcmpZDXqC3EeU8TuqLTMFBiEUZkYuCJT550uXhTQSq+CUrMxq8xTlAXJwlWMmY+9spBw57s5elNH36vQfC2cXuQtIA==
Received: from DM6PR18CA0017.namprd18.prod.outlook.com (2603:10b6:5:15b::30)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 08:45:30 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::1e) by DM6PR18CA0017.outlook.office365.com
 (2603:10b6:5:15b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24 via Frontend
 Transport; Fri, 2 Jun 2023 08:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.26 via Frontend Transport; Fri, 2 Jun 2023 08:45:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 01:45:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 01:45:16 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 2 Jun 2023 01:45:15 -0700
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
Subject: Re: [PATCH 5.10 00/22] 5.10.182-rc1 review
In-Reply-To: <20230601131933.727832920@linuxfoundation.org>
References: <20230601131933.727832920@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <33c9ab9c-608c-42cd-b921-cf65ad453548@rnnvmail204.nvidia.com>
Date:   Fri, 2 Jun 2023 01:45:15 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce93b01-13ca-44f6-709f-08db6345b8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1cO1rR7JmyjDzBPEGLWamOKhfbqGAI4TQrlighnrNpFq1d9YIeg891u52jZ7vcFLroNGyUPcxTGjD7x7JwS83YtSZZedR1JzY15rsOHwE1ymhf5Sq4qECat3XDadULWkESe/3wWUlfSnB0jyY5s9BV3QP0zz9jG3j9jegg+U7MdRoiYY0YoHs+ZyIF1JJeW2HgGAHYQNxYE1DHUCP05Gf/5LBO9QwMgd6zXjZhzW/1ZiqiByHjZbIil4ZQQtTYd9pgSrhPJmpGBXcz41K5zUT8gR4Jv3Oh3cBaTSDHzj7GGSZTqELeiz9+qzRQ+TRQxuyupzFX1NXe6DTGgYYHnbRqalHJKNxSo3TeHPhTuXUC3sOx0WwzfW+dziiqwlt4lzxW0lp1HTyanGT9+AMH+8JktIiHEGOi37bL/RiPLbcVTIkI0ZuKs6FPC1EutjNixNaAgZWpgkZ6Ss1dol8rMcWKpOA5tO34erx2IYVSi0RVAw5wah/xOuVYNRwSz3py08OrzZLMnl50onxa+MG+AuX8//sjH05gO7pVCnHD2TsIrPOlmA4TKVLPMR8ozrt2uaQStqrR1gALH+fCHHx1UuGSjy4Qr3HdpEtDL5CBgxZkicfGXs0AFMM8jLVina59YIY68Vlng4DXPOjQw2tOS9gZc3lRQpmVa/yv4Hoc33vQN9W436SwocDIjmsqAo8/mtq9RPpbuB/lZ1qMW2l1CqPWC2+mfxBDrmi28s6SXshLUvGRSeyQmAEXP9sIiMQur69R9IKdtngsukB26XxYiuQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(4326008)(6916009)(40460700003)(316002)(336012)(356005)(426003)(7636003)(70586007)(70206006)(82740400003)(8676002)(8936002)(7416002)(2906002)(82310400005)(40480700001)(47076005)(5660300002)(41300700001)(86362001)(36860700001)(478600001)(186003)(31696002)(54906003)(26005)(966005)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 08:45:30.5491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce93b01-13ca-44f6-709f-08db6345b8c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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

On Thu, 01 Jun 2023 14:20:58 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.182 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.182-rc1.gz
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

Linux version:	5.10.182-rc1-gf2a19702506c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
