Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC19696457
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjBNNLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjBNNLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:11:01 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF99279B5;
        Tue, 14 Feb 2023 05:10:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2kxhBlq4/rFMGx0c1sks76ZVEMV32pZTYDpRonWGAU0KVde9O3nZxomDkgBzW6T/rZJJgaBGZHu1PfmKMtZXFnuXuHYdRWapKIK47/F1myi2elcgTdisTn2uDZDJ6cJEPA3e+6VJAuE/S/RSAH5EnYv4+aD6S99IEOfJbFQbf9jI7VT1AsiOu5oqBdsObARekU5jdxxl1ZyREVPhRCl8WOR0Pk8BsGzD/cM0pxdkeD5zBcGIjwgOEGqJYdBnN9E2bFdcjYvvLTE/Qx1Q7ZDD/R+3/0RxEujdSh4WABOjtfHrkQBzcErpRNHmLSQiu/MVr7SK7qu4geXAKclnjRV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEx9I0QcQiKeODQ+B8Mf4GPopoEJ4UuwsH6sOpg5oKg=;
 b=Xfq37CngZOTtT+Rky6lZhO9ZH4E58iiSH0OV7+5MmVjZYl90/zW9dhv/EgbZqsJRjrvub2wb0LVYG03UEZycF8ryMDyxMlVCtV3pO9Ze34iZUj3IeY44l8NJOeFF7objxQlFgmwI6vFEukKjCsswAMir06YnBLa/Mt4GDD1T7ymkF6nYmu3ag4v4infaP10JTqCdt9sLqyOX+f9nhb/Udi0k/anMwXVF5iwrcPr4h7az5guKuch/fG3Bdf661E9hNPsJmGEM9vBeInsON+4+3Zx51KdaAHUtKVROqj4oJ6K9ND3hlidBJsDLly/QbKUQ68lGmU59qjXRZOcAlqQBfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEx9I0QcQiKeODQ+B8Mf4GPopoEJ4UuwsH6sOpg5oKg=;
 b=cWjodXib8SM59HzdqhhBnvOkGTY9pJ41npo/80ZuzijEFqGt67zOyoDHn00DcNzQLNjPZpgj8rKtuvFeX0yII/yXMmw5/zpn74JDLQeXWlOAY40SVh864hfrTsnOKNxXshI846g4iTeGfFSGAOQBSZV6p2WzOYAJMcBOqDKYYxzD6Wy1U9llMc8bBHyF2/9IfWH9/QGD4XAPhMYdq02aQTeF+MAd4vM1587rUQyPRwP5oDYaryqxhOrutdDK7kn8NkTkv8aiJ7eld3VmjYdyka8Gz2gUhNwnyL2x5zEmff++7/cDIAzvCLQEu5AwYY7q+OThwr87Oq9M0Rh0Uubj9Q==
Received: from MW4PR04CA0305.namprd04.prod.outlook.com (2603:10b6:303:82::10)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 13:10:55 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::77) by MW4PR04CA0305.outlook.office365.com
 (2603:10b6:303:82::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Tue, 14 Feb 2023 13:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 13:10:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 05:10:51 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 05:10:50 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 05:10:50 -0800
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
Subject: Re: [PATCH 6.1 000/114] 6.1.12-rc1 review
In-Reply-To: <20230213144742.219399167@linuxfoundation.org>
References: <20230213144742.219399167@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <ddd3bbe2-2cfc-4f4a-abba-984ac48dc7f8@drhqmail201.nvidia.com>
Date:   Tue, 14 Feb 2023 05:10:50 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dcae835-ae80-4ca7-bfbf-08db0e8ce7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ndd4FCM30yZ6WbIxeC81OnfuMAjm2tPcR/TbJZSEBOQGbvBGTrckwMkbOiCjMy6N+8SoljnB4dV4vyYtPJqd/SZOYNErzi6w5rheHR9xj44QJAxgg8wjPzPpjAdDCC6jjVNthF4D9r+gSY1XzRs3OeH8u6MplkLWFSVRtkiH1pA08l+9npxSzdMCh4MsdRjbpY2tDLjpV0IXgSmHI/To1C4xyPAnVQNEWQKFjx/oNMvhYzVmX7ea0qvEIMaWWTFBHU3aypC+aGToitpqStF7oJni9gA6bG1VNPivC8V8cTSwsRE5l3Hr72Lwk0Pwjd8k/jRAFS5NA09Dz6X2IPHbPatAp7nuSwNKt38KtsOEFbKvOyBq9v+BYOj3OI0YVkErTfN3CHiP6RpZWLNUz/OGD47o+U5AJAU3yHbJhRmcI1jaBIq5m4DZfwrgVK8p2jA98dhWTE6J8GGgxOfodbCIl7POi/XZBP5zX9pA0mBAkPiFKJrMSrzXxm3vsRerTjKqRTV1b4PaHgYBDOJu9zkObnWNsrgSTHBJh5FCAyeYItrbUuoH2APlA0amh4CPkgaJuUt2Dx2qn08ACGz+YKexoQkTsBvjtfC43Q/Eettmbyl0FogvR29Vi1FgDiA09xdUnAvy9+EXpn/u5BKHdnvDCTHKImSKfGzG0J6WbgghVsKDjyUA+DGyyX60R5zjZ7t/YlR779xrDCMqU4IHj8FVU6h7owXA58T9nT8FRTfuO4iwkqtfJk844zp1luiV5wLk
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199018)(36840700001)(46966006)(40470700004)(54906003)(41300700001)(7636003)(5660300002)(7416002)(356005)(40460700003)(8936002)(478600001)(31696002)(2906002)(40480700001)(186003)(26005)(966005)(86362001)(82740400003)(82310400005)(336012)(426003)(47076005)(70206006)(70586007)(6916009)(36860700001)(8676002)(4326008)(316002)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 13:10:54.7268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcae835-ae80-4ca7-bfbf-08db0e8ce7b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023 15:47:15 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.12 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Feb 2023 14:46:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.12-rc1.gz
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

Linux version:	6.1.12-rc1-g9012d1ebd323
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
