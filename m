Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB3864A87E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiLLUMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiLLUL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:11:58 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF703178BE;
        Mon, 12 Dec 2022 12:11:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB/SBmin4V/+mIim07cm+kzWRz/2QFZG8VE+IwRVxAFluRFC0TcNlaYJIT31LVX89RmVrPvaaxKUVWZ8DHCpPi1MC/acRJ4Rd4+OoPeGW+fVdT5DmmQOUOwnTeb8k6aiCIYXhdgYjmM+GlbltcbiP1/VMiZfFn9DsVBgctPKQ1V4gywz9p0V7/ZYo3KF9xEhQYPDf34bSts2fj0zbnI6u3FOH8GDMMD1hTwoR07GTd+T/a6sPdAVzyqRr3gsrMPq7ESe3BKjer5h1CP7zuxyypCw/rMAJDeU9FUF3J7/tqi7FSRSUNq8t4QYuQKu4p2buTmwFlxpctHflozUWbFmyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I//logkfwCQMKXXUbEjUhUedv7l7+1/d9U4N5Tguq2c=;
 b=e/NK7FIVk+AW1Aph7p2tm3lzHtO2lka41aiwBpBhnMR/xztmfi4owC2TFA4f1vVUjynGYZbIyO67GfWpRCbf1nhmb5prJAzP5a35pSGtXQ6jRW8b1BiJawRa/VeQKRTfkImucZPxH5f/7shi/T5u7O3zvRq1sko26mhVTsTagAsGhxuYkE+Ig5TO6sVY6PQUORS/6ydwhOTqNWQYUaioGnNpwyMvbnshdXQLRlE+ZoTySXDz1fYE8Of01gKyTgmVA5uGIZiXXRKuNo3OSXoL8olbhM6vTIbX7aeCVVYp5ZqD3crTGnAhZJSrJKaQ+UuDZj9zTgrAAxAdaxetzTyMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I//logkfwCQMKXXUbEjUhUedv7l7+1/d9U4N5Tguq2c=;
 b=nSmdbfM0nZMi4ougsYuf/f2RZdJ7jdQeuvqh65kFvw1FSw8IL0Y7nzI6dIift2dPsUbiWCdyqAedlID7e6aELDeYb3jCSynjfsBzpHJ8z8/TBhvYLia8nNFAnxtrvjXG6KDZ1leS36grukcM7OLepCG0dCnmEt96+s7icI57VOdFeWigJrkSbI8kMFNX9pxX6n6x68xvA5Q4ovBVNduNW2MWK9Tnr0Lja0UJeZsj/Fh+x76R2uCdZy67Ag6H26l/WyRqg8xhIVJ+nXbKN4rsPN5Ojy9SCKAHrBatDl7R2iWP6vEaC6eZHaqDr3/OYhWbW8c1HX8ymWZvl0UWwYCezA==
Received: from BN9PR03CA0668.namprd03.prod.outlook.com (2603:10b6:408:10e::13)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Mon, 12 Dec 2022 20:11:54 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::5a) by BN9PR03CA0668.outlook.office365.com
 (2603:10b6:408:10e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 20:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.7 via Frontend Transport; Mon, 12 Dec 2022 20:11:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 12 Dec
 2022 12:11:39 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 12 Dec 2022 12:11:39 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 12 Dec 2022 12:11:39 -0800
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
Subject: Re: [PATCH 4.9 00/31] 4.9.336-rc1 review
In-Reply-To: <20221212130909.943483205@linuxfoundation.org>
References: <20221212130909.943483205@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <e9768511-16a8-499e-b905-fd8bd3b07ae6@drhqmail202.nvidia.com>
Date:   Mon, 12 Dec 2022 12:11:39 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: cc748c63-0f89-49ed-30bb-08dadc7d1c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VGkbhx2PpM0+nBjJnQ9ShxQuYo/D0qjmO0uqHQZcZZIi0V9uRdlgnylw6nGcqKexm5wn1fuSBrML2qFai6+8BSH09KfGAPL2VbNQd+h2cZq6nc8Ba1cJSH+Fanxf9vMCaWsAxK7LswT/LVfGyaV4WRGtSKOkCEu8k82mF8dDG4KBhpZJoesjJwiKzyCJDVmGLuJJroEfnQ9GIK188W4NdIRwg81vcs/jH190XGTDXCi9228Edac1s6vEaN9FsdD9kVy1QuzoWM47YKX6TZOIrRwOqiJ5ephZQ50p4ILw7VKgUj+nvhU/YSA2pzoQqzY4q8pQ+tjRgnOjg0IpXoIqsX7kjlQfhkcLcdzWZq0l/uz4qwo8OHplaxd2TIGwt9aQSlT5j3+gMH/WLSkGU+ixmfjG+7c+98y141sQx/ZQ+uCWaG1ZhFvqrZK8IYiIUMuGMRF315DF1M8T4VkFPbmfIrgUTTQ4plJ8JnlMQourY7yZoSHAPclryEbk9u7VYU7Km0BLTv7LosxbCZpC6xSAvwLBEJkSsJ4nf0y3s6YDxNPiFZ3SnQbBPT6rrsGm0WbOPc+uPPo9mx+FGas6dorIA7ficgS7KETOfHaG46HxrJVWWxREYCxPIe7DI/fDNhURRuO0qPY9UxX4Iwf+ACYe0jLtcP6TOpXtOZ/enzFrPHU+i1dzCS1vH9gHv6bC9Jy5N2EH0iOlInp5gNEyntzi/N/ricWYtAQKyemRxcDdgFLx+omxCzV0a+fYLup4fxyp5zlsP6SA4nY5bDBuR8D7k5vN7sB0DztgUq0ySmilXrU=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(966005)(478600001)(31686004)(26005)(82310400005)(186003)(316002)(6916009)(2906002)(5660300002)(54906003)(7416002)(70206006)(70586007)(36860700001)(40480700001)(4326008)(336012)(426003)(47076005)(8676002)(7636003)(356005)(8936002)(31696002)(40460700003)(86362001)(41300700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 20:11:52.4252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc748c63-0f89-49ed-30bb-08dadc7d1c0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2022 14:19:18 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.336 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Dec 2022 13:08:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.336-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.9:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.9.336-rc1-gc4da25efd82f
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
