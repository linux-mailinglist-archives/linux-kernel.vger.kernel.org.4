Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688F26B506B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjCJS6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCJS6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:58:04 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C9FFF1E;
        Fri, 10 Mar 2023 10:57:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9wdDWa3eLWT+QWcKe0E7nwxpbD6QtuL1tjrlkM2MOqzJ7PGl2c6RxuRvoQwAbRR9dQiczqlppZpduLN4bFHg6A4Umv1tFEt46T5ryAhJ9DBDRUhf1R+dzWJDYfSbHeRw4q/9n4CYMFUrcZ89GgGJwlEF1TkjU/cSe7BJ2SzUUto2Rw/PixA+uLqWNJy1vaHUHFOOnFBtWCE5fFVFe08j9GGl1iypWjCSl/yHb9DTiptXvkouiEEcjlsspgf/vffFsxNiLVSGtprXU8O/guYM8LEV17ISqLqitZiDxwfJmmg66nDaibDIFQMKk3j/Tmf9WvCAeWB3mJPZStzFkEGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eSKQXXsuO4BsiBWbmbMjU9V6KmH4POtqOJVvP/do6g=;
 b=EIOeL+R/YDuW4h5FpqFiArxL8W1MSNc63ceKSy6gzvJbKUrjRUIGfbQLXHgypUwXSkz0AqkjUiE8je1uW+MIu4mQ6a/UbcJQJC+Q2dWjRsIFg2c5jm5oJ5KUOWdWFwGiyZXTMfDi29Zu0KUQXoCV5tVsoy3x+YVxkzcDxk0gFQO8Dz1spMMEGmErGvN8/4UT0mi2em/Z9e06Ct/Qim48GnmnTMIuWY0Oy0yyGCEAhEyjWsKjBoDG2hn0ZbXgSlUeL8Pox2nfIUyCnooJAG+a/YuMxrx36AFPnFIfhXhls+1gYPGJBq3cNVG4OGwUl50QM/69jF4UNw3bcA1VeBI2ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eSKQXXsuO4BsiBWbmbMjU9V6KmH4POtqOJVvP/do6g=;
 b=IcdDnxVcxJfRwerHkIAyeIIDcxOVPsQWjlwlcNzsb1iLhNPAQp2XWHvWfvxLQp6ceeDpNqVh+kQj93TWZlvWRWYNCi+qIa+dM31I4Tv05IloLYhgGygSDus2abXfmEY9UibUWyag2km1roI2oIc53etXDIdgAS0RsFZ8AZ3ZgPJmkQW+feRXVc6y72ASw1jcle2fBpdFDOpOUi3dMg+asVypXZr3w3qP1xIiVGho/pqk/1HdwKPPVH0xc9jNVjet/ZoBon967jdkM08SPzowIkKnzQIOoKv6CpIRuCggqDLrQDseTfuJIW38Bq5ORZlFh+vPolE135ZckhAhGMNgTw==
Received: from CYZPR05CA0043.namprd05.prod.outlook.com (2603:10b6:930:a3::25)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 18:57:55 +0000
Received: from CY4PEPF0000C978.namprd02.prod.outlook.com
 (2603:10b6:930:a3:cafe::7) by CYZPR05CA0043.outlook.office365.com
 (2603:10b6:930:a3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 18:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000C978.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.12 via Frontend Transport; Fri, 10 Mar 2023 18:57:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 10:57:46 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 10 Mar 2023 10:57:46 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 10:57:46 -0800
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
Subject: Re: [PATCH 4.14 000/193] 4.14.308-rc1 review
In-Reply-To: <20230310133710.926811681@linuxfoundation.org>
References: <20230310133710.926811681@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <34edc6d7-3cbe-4e5c-b2d7-665ea33f2efd@drhqmail202.nvidia.com>
Date:   Fri, 10 Mar 2023 10:57:46 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C978:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b6ab8f-1ed1-42db-33f6-08db21995baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Sj6WmUHHaEdTFeCcpr1Tialdoqm/JJE24KJJgwYgLYFyK2UY5agP+bT5oV7lMeiGZvidECtcfpMzmjBDSBhw/Tl+5RU2rrW4d/x9pvseRJBauD23uAWVPq2yRkx/SFuwMKoVp5Bqo3PpVyIfQ4aS4+axbvxiC7RMJUDwPk4Nvz6Wgf0xhKMK55j44AtB1NmjIJDkbJiYJMPy65FEsJL/YiR9Je1TUPfHgIEG+4b5CUva/ob1N3zcx5LoMwBg06dufueZ5At6qiHE+/PdZUyiH11DsAXAFVxwaEvjd/osM/UoIK8nZlbYk9ByvEz//owwfWRtqn3wG114kbWVLObthxrph7whfZHWOYBhgToiXNZfDcG8fPU8nA/ttE5P9A2RbvV5PyToFY5Q3JcZp4EYlBjZMv2hhl0JHdggxjz29wzkZqieVQbcyatZTH9wcSaB/k++JOFM9obQru1oW+ES4pJ//EB8onthhPv3woigOVpD3Ls0RAv4DQ7tmhgSvSH1Hs0CbKNcfCW0/RUzSe4oYjI3M98eCJB+35RgW4T3YWKrcav8qYpsIyMQckHIjFPBfebHxlVa43R/JNqeZweDq6EXjObuzYxhue/wK1K0VqD1k8MEXB8xlLpdChfjONrzgYKZU6Xn1179DgaYWw5/Y+wBUI5iqkAuN60rqrX02yoi9ezCa/TdPOsZ53PdB7elUqRXA39c4uilCj+0ONyoVIYJkd5+42Y0kast5x83ERRwZ4I666BPqbDF2WuOldp+rXt1WZIvWYfw2PnBhI4/A==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199018)(46966006)(36840700001)(70206006)(31686004)(2906002)(5660300002)(7416002)(26005)(356005)(8936002)(4326008)(31696002)(41300700001)(6916009)(8676002)(70586007)(86362001)(316002)(54906003)(40480700001)(478600001)(966005)(36860700001)(82740400003)(7636003)(82310400005)(336012)(186003)(426003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 18:57:55.3713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b6ab8f-1ed1-42db-33f6-08db21995baa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C978.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 14:36:22 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.308 release.
> There are 193 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Mar 2023 13:36:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.308-rc1.gz
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

Linux version:	4.14.308-rc1-g6eaf98b65d62
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
