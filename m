Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF045640726
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbiLBMtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiLBMtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:49:05 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBE2A5546;
        Fri,  2 Dec 2022 04:49:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIFfCto08oO3pN4qw4Fuj08r4njMNNGNFzOECRBBcTQiIl5KvQnBXecXndbs+rC/OCBTnNzDP/nnoacAWyAdw9zpTrJM+RF6akU2nRNChcGSuPjzydK/uZ/HBIxCMCeLkgxsKpFcsbPFgwq92UUq6vcl4MSMGDPCxDyv8L5qya3iggZnVk9uqzXU2LzfKaiQUbvC9PNRj0H1BkTcIysTRmKbedfQ7S5fjPd7/dX+s45aUqNWyxORX64/P8wTWocOe70FcV8CTITxl6O1epHyGeolnVhnxx16G6DjL2VBiS5RfjgTg8GnvtCZ8+r6Wf4l5vYaT+ZHYMjJo3kVHwuAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBuQDotrn4MCzg8Qu22M7BnMSSHdOq5ZOWLrqnB21Aw=;
 b=XZTNu3a+jRrk/KFXzxeoKjmGEM3n8ZTL0LzSGDWdp2V/Yz4MxGvLtL+ZlY6KKMVWWi7Gpza8e1vMWix68FXF2BmXtCgY4OuRcbP4jgzORNvsAAFSB8/XzNp02j0qBBPqacj/gBd8TMZASiJ2JpYp0I0/DT2fn+JHHRBFFLI3MKDiZ+Njbwtidpxtq7d0VUEmwfq1SeAwj389UTVnoRXkIgbvCSA2a0beseRbybJyyxnMg0tfDauvon8pjWO55WZH2bfX0rc8e+jqunghXPluAyhCp1qHHEPT9XBtNJFuv5n0BM7QWFnpAPHeNo8FrZKnYwgc/iCe5YGwPbCXYXwoFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBuQDotrn4MCzg8Qu22M7BnMSSHdOq5ZOWLrqnB21Aw=;
 b=P1Ti4q9TTJalba2JcQ6B4Y0fsWY0CeVL8s2AFEPsjvTE7XOAkNs/9Ai9WxXaKETSbVlJFL6gNrFKmBTYoHFI2tsLcsDMSt010RPuqCpGuQTY6JzirJEflSee7jJJV4EEYznbGJW2lkI2ms6tXlvU4j0qJ0top0bT9GdCVpE9S/90Ili1EKh9Z3x8/fg0sDbdSfcviDDMtlKzXIV5zbHmoPknQIVUuxl2sAvnGetT9WDZrTfIsJBs+tlkmRFC1qFySd8EgFi8YOIPSiaOxd6x21uwiirkzp8rVshmWZAQI4PIIceE8wBf0maBs2IOyfuJoNNK5nQj5ZX9S9Co046C9w==
Received: from BN9P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::26)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 12:49:02 +0000
Received: from BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::2) by BN9P223CA0021.outlook.office365.com
 (2603:10b6:408:10b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10 via Frontend
 Transport; Fri, 2 Dec 2022 12:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT069.mail.protection.outlook.com (10.13.176.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Fri, 2 Dec 2022 12:49:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 2 Dec 2022
 04:48:51 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 2 Dec 2022 04:48:50 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Fri, 2 Dec 2022 04:48:50 -0800
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
Subject: Re: [PATCH 5.15 000/206] 5.15.81-rc1 review
In-Reply-To: <20221130180532.974348590@linuxfoundation.org>
References: <20221130180532.974348590@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <c51d36b9-bf00-4850-bbd6-8b0ab3a2c2bc@drhqmail202.nvidia.com>
Date:   Fri, 2 Dec 2022 04:48:50 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT069:EE_|BL1PR12MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: 8504959b-a0a2-43f9-6263-08dad463969f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WAtLooIeiSnP1ZPca99m2h+Mr942QBJyk/uAHd0jcIxOFJ22QJBdTMbW2/qSpgGl5Boe2EMPJw9sn45F8IaRJckb5EkLT6P8TpcdIQ68KRKldGTw1zk9rqf+FIBVpuKHQWaG7EPH9IRftMNSX6ZY6/bR3gljyamrkC5mJOnOPaQWLLn0TwWLRJN6pYgiOh19P7jpz66omxgqtek80IJ7Kb6Khm6JnGXjW6Ilb1YqAe2Lg6jlB1DRXk999uhe2r8REgxvpogHE11pM9R7DzW0fIAEAGwTzBEABe8N7Vicc5+ejRZ59TJQ14GBhXoPKMmr+Fhn/1JbvKVKjI3Dxrcv/MscJeKkQPso4t4bT/LyhcCFGEP8OTQuuHJUUQ4wnBV1dJCSbUZkwbWlOirQViZvEKUYPHvaRmwaIbSQeX9LN7t1R2V3Msw7mOH9QwGovG3z5ydeC4Cd52y/24dxyccmS8/1Gb2HJBdRUPuTbdDKP9PCT/p/nIPc93QIBWbgJ44fthIT853SqaDaE3EzysDk7SKMx5/dvI10U5W2KpJik4zDI1v69II58hQJ6WVSz9fYw1VMYCwQ1eODa6RjK5Lsdc4ApieAtGQdSrPBHL5Tq2fl2ndORWk4c3qPmqy8UU4r08bwjTXUy8v8IuPAd2SvNCKhJIfbkKDtocF4Q2p8YH44WXupqCCUSd8I55eoscO39WpTULP7Q0g9rv8wu16qD8Y5bEHSGB/Y8NjbTyoJ6jYyUlNtyq0Lw8ByuaQ5ik4AroZv4HNlsGTNw3iBd+xe1Gfe2edLKJOiQFPwFIcFF/E=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(426003)(47076005)(31686004)(40460700003)(86362001)(31696002)(478600001)(966005)(40480700001)(7636003)(356005)(186003)(82740400003)(82310400005)(336012)(36860700001)(5660300002)(7416002)(41300700001)(26005)(8676002)(70586007)(6916009)(4326008)(316002)(8936002)(54906003)(70206006)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 12:49:01.8193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8504959b-a0a2-43f9-6263-08dad463969f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 19:20:52 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.81 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Dec 2022 18:05:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.81-rc1.gz
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

Linux version:	5.15.81-rc1-g516c2740a2a1
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
