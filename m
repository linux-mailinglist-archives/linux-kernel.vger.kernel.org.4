Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6366525CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiLTRva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiLTRvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:51:12 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CBD64CF;
        Tue, 20 Dec 2022 09:51:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYx62i+047t40O6rNnr/4astcuJIvGfK2xuNnhZrc1GkbuhMOZieGoaPW4XeA4laGt9RuubdZ3fbirV8dnV6g/OeYQK881l/2ysxPTchyNMaDavWt9hNYWYqRzcp3KJ+PsM3b6RulPDbzJp2X3wEP/JbI8PP7TtUY237U3e++2Vipl0Mw2KmAqiFU9CZ56z7QSu1w2nGcjXstsdp1/k2qvWGrBRqc+/43EQmLGG7oMB7oK2lPcSEzYFRk55DgORsrR7WchatOdc00iCtpBsKSeis+loEZitI8QiJjzJm7zKxIXPUWGHoT9w42YZLkjWjCxyKS4o/+RGGfqukJPGpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lI4ojYqH/pAMKos19YYHFgEZJkOalH4uXA5aesUaanE=;
 b=FPmVq+ZrRMz+YPsM5Ha1UGGnux9e66c3FWD5YGaI2pCTXHBHx8UZf7e5DzsDhtbX3EAQXsYec+ep/otBVhkhkjy+qpp/TkjCI5EoMS/TQ9l/eNaJZO6mwCV8F0yooG6ZTSkeGbZblP4vaVVbdblhEgf/8gk518dzPLPfDIxqx+y3hU3683XWyIBMAlGzYJWvXfs/jwZXg4dkE/4OK4BR7DBocxEqq6ZtAf4RPKT9Cle/KCLKPSr600Y5vFbRWA69aKLgfC4+/cxn8QLBlQ4dDoxBFpCbDyXroBNyw2X/duXVjl6+lrEYwruRGaBUU75wjbVIe/zSJsaynsSe2IoTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI4ojYqH/pAMKos19YYHFgEZJkOalH4uXA5aesUaanE=;
 b=XPGksfRIaGAGmuwEg2O+5396fi5YeJXYrn0720PQbafbmnRyeC5f+pP9zrVfcJN2yBd420KtCnJfXcLQOg0Zlj1H7qRTKT9QkCkDexEn5c0G7AGWdsLHCC3mS5PHQkMSmpvLvO9hPrN1IvVC1HR5O6S4fdrWeD4hMLtF5OhVmebgRQLoQoo2afXDtyzBSICt3HqmW9RemiFboyv9Eer1UMbsPPl+KeN8TC2L8B+kYMH3Hi35YNhTS9/hlkf2Wo85FQZQFeqwsEsmdHafDD6iZieySwVKJXYvJGpBQFM2L8L3EY1enI9jhNIkQuCx1s8GB1t88hOoLvbcla0Drnd4aA==
Received: from CY5PR15CA0197.namprd15.prod.outlook.com (2603:10b6:930:82::24)
 by IA1PR12MB7614.namprd12.prod.outlook.com (2603:10b6:208:429::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 17:51:08 +0000
Received: from CY4PEPF0000C971.namprd02.prod.outlook.com
 (2603:10b6:930:82:cafe::e6) by CY5PR15CA0197.outlook.office365.com
 (2603:10b6:930:82::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 17:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000C971.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.10 via Frontend Transport; Tue, 20 Dec 2022 17:51:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 09:50:54 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 09:50:54 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 20 Dec 2022 09:50:54 -0800
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
Subject: Re: [PATCH 5.15 00/17] 5.15.85-rc1 review
In-Reply-To: <20221219182940.739981110@linuxfoundation.org>
References: <20221219182940.739981110@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <21481827-5ef7-4842-aeda-8f92c7211e9b@rnnvmail201.nvidia.com>
Date:   Tue, 20 Dec 2022 09:50:54 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C971:EE_|IA1PR12MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c87acf0-1b05-444d-32b8-08dae2b2c5c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UyEy9t2+fJ3ePC8b+/bGR9ZXG3iXv4xEbhnSeHHeieY9hBUDUjaIHe7OhqS/nIYx9vpJ4vv0KtE21/nO1W9W/MH0KYzlO2RlhX0dUwet7suFf9uXiIbW90zDlU5L4ET5mymXFspfw5pa9mceGOVr9N3oUafXHy0sC2+gDAQWr/NA6Q43WJRGqbqhPn7JanD14y+BOcMjnCPJpDDBledUCqBvCMlJMhOaheIVXe4O71U93JpfhroiVSMOQpaWIxBcCZ3QEwaBUQj05jXF4LKtaJ0oMXjwN5XAyjGtbQ7GAH393QcY/1c07xZsuNmw/ESy2LUUlHfAJwKpFQ0Hra8Cz0qvkibY5ZX+uz8ucKQhPjyMJQaPkmXzrk5SamfvUUjZRwf6FnpO8Xcc4meEp/r6l6JCKMIqueLYWu1DOEzdZ5CJcfBq2LlDtfO6TItArZbp2q62Xo2o/R0xZRcw8VbzqvZgVyXbFW0KGZybPzrVzEyETyDwBO3j9MEcQUaGZe94vLYd9XUwufhEHnxKYjKpUBwGvhpDoe3tlyWoIDl/7vD/NBWNB81iL97+Jvg20ML3SRGdB13ei2CbdhuJNIdNHppuLgDz4IK3IJQ7EkV8BJCEX72uDiHP40us9pMJMaiM5PnFhkkpQRoDxSgUJFLADNQ5894WUwSItsuRHBJJZtE4dDIGHJ3SatZb/GDnzaoZXaRiqAXOdSzkkTah+G/TK+gzv2IkGJE/yZDsIBOSp1q1uH6LXEaU+NJgRLTNnCOoIWlRxipYSTg4BZJGV7FE8Gj9/KNcw/x13hjNgmlVTWg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(336012)(426003)(31696002)(86362001)(36860700001)(26005)(186003)(31686004)(47076005)(40480700001)(40460700003)(82740400003)(356005)(7636003)(2906002)(5660300002)(8936002)(70206006)(7416002)(41300700001)(316002)(70586007)(4326008)(82310400005)(8676002)(6916009)(966005)(478600001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 17:51:07.4703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c87acf0-1b05-444d-32b8-08dae2b2c5c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C971.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7614
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2022 20:24:46 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.85 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Dec 2022 18:29:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.85-rc1.gz
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

Linux version:	5.15.85-rc1-gbef75c6188c7
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
