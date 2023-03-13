Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20A86B7922
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCMNiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjCMNiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:38:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E167AB45D;
        Mon, 13 Mar 2023 06:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEwUsTXxeqvyCC9RuIuv/64aKYeyZ748QsdrPkJo0JkSUPI9cfvmE8anw7fR9jnwqO+F6h3lBSiG5w3X6ouwVc5RnSSQUtHj5pxFcxzHqgje0k68bYiEVYcQtAvQdjpT9Ca92YEN4LjktvIyNY+jxR06dV6T8jyIBXXBrvAiBglSeyLdWAC/5Cnx8WhGlKnNQR9K3kCfY/5ujF9FHp9Z+q5+xbuBKJMz3+OMk2qDlrfDeUbCbfc8DEkpFeNXcHEc4C7TQTG0Hz9QWOuNg1kRXdBzU6VE1xvV/msDzAq1f8XfvFldCOJXyhuN6S3g1x3taWd07ruOmorbfmAUiz2/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QW5nTR7M9PGNTBC39yRlfTMvWv1JwHqi2v93FkLjuqI=;
 b=Qo8/VJOZnhS/R/2i0dOQrLrCM19JioSurAzc32QZw2wwTkDEm4+BFcXpjgUC5t/N+xrRNMqSwSTvV3En/IqreiJ37Ipv24+WYL323cCnVOWiJqACrH1nyVRfwjH9C/ipCg5asZsk/l9uaeA3KUwqm0dVBf+1/f2j3VLveetUjPkkHOt4dQLavHNCWIQjc9J9PxecNXV9BHjTC5jXlz7t8LF8r7N5QM4aghtrrRufx7XLmgalr0rbmVMnCNmPgMHZYP5mzCdJ6gIbkRI16gzjV1bJDVMTtVlYsprdjQvZCtPuawtCFoK1sbpGbi0wuNzqa8Wy6nGhsanJJE3hDwQedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QW5nTR7M9PGNTBC39yRlfTMvWv1JwHqi2v93FkLjuqI=;
 b=c5ag/i+Z2Ym8xz68FiRInBxRYPGeR3zJaT9NYtabPvClB4HiGvMCZqum9sr0ufwiiYX58Ps78rzGC7Hhqxk41mno8kTEOA5FPfaThm+7Xo9B1ZZltz3uHfFfPJQJhDm+qv1MOzrj6v9naEfzOcK75Xp5AOJZ7gLKP3wnAmzUr66mMUO+AA69Jq/Qzf38SnLAM/QFvwV288WWnmbj+VomVJzaEbLT4l/pPaFNEYPCFvwnOiIVWoRYMNpqL90o3zqpq7R7cNC7bbNSlS1WO2bT0rmfw0XJijVFUjN56GQc74YdT+6VDI9WuOPy92aMh8tmkM6pxzfsFVCm6jdSKke+EA==
Received: from BN0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:408:e6::11)
 by DM6PR12MB4976.namprd12.prod.outlook.com (2603:10b6:5:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 13:38:01 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::63) by BN0PR03CA0006.outlook.office365.com
 (2603:10b6:408:e6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 13:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.12 via Frontend Transport; Mon, 13 Mar 2023 13:38:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 13 Mar 2023
 06:37:49 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 13 Mar 2023 06:37:48 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 13 Mar 2023 06:37:48 -0700
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
Subject: Re: [PATCH 5.10 000/528] 5.10.173-rc2 review
In-Reply-To: <20230311091908.975813595@linuxfoundation.org>
References: <20230311091908.975813595@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <e10260a7-cc39-4d75-9756-630039883f81@drhqmail201.nvidia.com>
Date:   Mon, 13 Mar 2023 06:37:48 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|DM6PR12MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f97190f-8a02-490a-ed8b-08db23c829f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rgb2RJXa59z3MkfkXhY7kN3riZewdpZ5k2/hugOlKryiSmGG5rzMF1bSgRAPd7ID7vRbMWMZmFLnpuV1o/Z9kXXLH0vQ0/zKWwJI9pKa6uaiM0dVrAM46/Vuyp6TapH32pzVMPMnQ3AqwMS1sR0r+HcG40oC43qWNVwrqyljoiK7gIPdbwZ6LAI0Oo55bTwSCpVZp7fzYb72Z8u8tX7tfxHAi6+tOymT/XeHdg0Gyz977q6SeaMPtMN6MsB3Y6bXa+vhh4zNSHWgXqWgVMRMz2zu2f9U9GLdv8njnEL5DZRFsYdOL0cDjHO/FrXO/AAz6PinkESd1r1RPk5+wP4wh+pdGFrxM3RY92iPjQ5nI5B1QjdyVelagX40gIG0MSIwFOZDQrdLCO+wW2OE9N9zROzM19VKbDWYcMpNIlXNtJHbVQSWhOKzYSIGcl74S1B80nedO9bmNV/tDr2h8dnTFXxDaFGoYXQkHF8nr/PwbTu6Wb8JkUZ8y/rK7Y7Xcebu3fyQB/pm3rWe3UgqoAr6yYLU8lTYOYEU1aofnQcXP7iWfsXtItnWi4EilBKRG5lYoYG13zDf7ZCT+nJQVMZj3wkr+hN0VB5Nyox3MHM4v8Ifu341Gv7+q23QEHq0ID0AQrgxyZsw/1OrgwJiflPparxzaoDStfefFrv3elVuRoQUqrZkIh6AVuSGhdaXbagKelgzvat9doBW0pXpI2tt2gHtge//BCyMc7B213NodL34K3JkMxqOeliAJOWrizhmWGhTPYbqyuyA3urWl4PxnCtD1gfxUKgXx/CoFNGveu0=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199018)(46966006)(36840700001)(40470700004)(40460700003)(966005)(41300700001)(47076005)(8676002)(4326008)(70586007)(5660300002)(7416002)(70206006)(6916009)(8936002)(186003)(26005)(426003)(316002)(54906003)(336012)(478600001)(356005)(40480700001)(86362001)(31696002)(2906002)(82310400005)(82740400003)(36860700001)(7636003)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 13:38:00.5727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f97190f-8a02-490a-ed8b-08db23c829f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4976
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 10:20:47 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.173 release.
> There are 528 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 13 Mar 2023 09:17:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.173-rc2.gz
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

Linux version:	5.10.173-rc2-g79ef18039d49
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
