Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961C064EBCC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiLPNFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLPNFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:05:06 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76CDCE17;
        Fri, 16 Dec 2022 05:05:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJ9wCzadBUNJFnAcVolqwNIKJfXAl6zEikVZ5EzsE5RJoqte9aDZ1/h/rsW2RV0ZBA/j+Oj7ID43g9Ln3qqYMnS4MDD0g3Z2oXqZfV0vtMW3YS26VSwyDhWp3R9RPx+Zhxf4c/Zjs5iV7WQPsrdLy1d0K/oRB8IWY3ZyKZrYtWjrqvCucXAmKBQ1aBBC5o+UHo7icsxUY5UddRCS/xQRQF4SFtRNPmYzvq3Fhz06DmbxEUInyJXCVi0/N+2moJ/Hi6Edjj5ITQce+0RAPE/jDgVLgDvhtVzc9fT6EtewhEiN5b6XxUGc00rfvYyCYGsdwtC68v8Q2YYTVUQ7qT3pkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etfeHSxgnH91KVYh/E3ZdEFGw9QndVAMvAd2P4v3658=;
 b=A4YXVdAVhQvHoShS7KcPVuJFxnYx44gq2E1RLJmcUVk7EL0W+KZEAGrXSMNGQOzEyYcqmW6j30ixLgn4XnPTWs5Bhz84BqCwztlo9WkcsbHvPURTff2B246xRi6sSzIYP7Zaw/+LfPxaeeSBHGLZJ9X6cN0MOvL033NGU+gSwWiebdIZsGSBoWwpYmYlTVaCNbHabMs6jHnbpL5p/oz4P6ZKEBea+znXCWEV0fk5tWgPsl4bFUPYOPo/ZyccVjOOkjVF4ds264ctcJExO4jhIBsOumO0s2cmjP8fLSamjxZ995mjxQJCeM2WyEIZDfzQ4p9qoELPu2/ObGxeO1+abg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etfeHSxgnH91KVYh/E3ZdEFGw9QndVAMvAd2P4v3658=;
 b=e+koOBCm00Lg478dbOJdFyJtrqiapcsgromJu2lozWDKRbwIPlgwTXRc4crmUbGvefqXxKB2vBgStarBGrIm1mVBRRZHi3Rz5JWsK9VeM+FPlUcojXrr5KmXXBToLC6ebKsRMRoe+ASFVl/izBnI7RXS7QnojDw386sVj9XyL7avkpm6adG8mh0jYExDO8+LU/EtZV3cpz/J2NN3VFbIMsCmiL08dqajpx42NS43RvxdMgShJTwFL9utT6AApqekdLHLF4IH2Wwk6gNVD+TJc8OHmrp7P1N4qVgamH1tK1SkCRwl9RRsOIlgKvqxCFznZOKUy3P5UwKMhf1Anum/Kw==
Received: from BN9PR03CA0849.namprd03.prod.outlook.com (2603:10b6:408:13d::14)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 13:05:01 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::2a) by BN9PR03CA0849.outlook.office365.com
 (2603:10b6:408:13d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16 via Frontend
 Transport; Fri, 16 Dec 2022 13:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Fri, 16 Dec 2022 13:05:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 16 Dec
 2022 05:04:53 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 16 Dec 2022 05:04:53 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Fri, 16 Dec 2022 05:04:53 -0800
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
Subject: Re: [PATCH 5.4 0/9] 5.4.228-rc1 review
In-Reply-To: <20221215172905.468656378@linuxfoundation.org>
References: <20221215172905.468656378@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <f8b21811-2d1b-4267-a0bb-afcc5c09ab7c@drhqmail203.nvidia.com>
Date:   Fri, 16 Dec 2022 05:04:53 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4ad71a-6b55-4835-f350-08dadf662444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7HhfvouV4mbJR3i6TkQjAV76iRTRQY6s9Lg/wYxL1r0/ELcOtkM8QuUwcK/tv5/NfAj8oSa1AJ2gy0mjY7HcF+FA5j6p/5eU2A61b7VW7pqck3TUmERSGlxsyGKNQFZfj8UImAhuVW1Q8aNjnROH8YXoUmq4M+8Xgi2oireyBQwpIre4scvP+lzKiIQSWHt4Iv1cAvIi5y7qom3LIeKwqo8wMQ17Be1z0VyZn25YhJk1zHrr9HqDWfWouRAxPlrgw/+2kUNP9haWq7jOLZHFVj67RfQfWRxZ06/q8PvGP6MvQ7i45zgUzkao7Z4dkhoPeSPRx1VhlzE37fvZMBJD3G0/213k+dvagJmXKHA7DGUd37nMbgYdCrdqm+z/eICB9BJl71fBQ6a7Z0OiU56ZI1H9jcHtRhIq+4DxEXJ3yzi5Z5uz3w+OIcaTdzwTfrJgovMn3KZgElApKpAfyN6Et3hIz8n7xWAJa6ghCcuzOiZkjoaDzqmZPb2LVYfvhOvAJoFLuQc6NNyE5pL9gP/x9QDmgTb0//qNKfQfCUYrc3Mhw+cfzNiojhdiRKyGdU6bwqoHqw8xf0QGoqAbanHuEjJRCZ03fKLygCXhb8cMtCbepuVJ1Ea5M8SOSfdWNqH7AYVqrOs0bFJgZQyeQHJ9dXPAsW00H1gqA6yGaOqnNgsn5/8Hxp2DKd+8BU+HkwSunCQ24/0Oh4IVf6AA+HE9bcii71071LyGeOhZHoR8vZHw3P6+is2QYMWlVw8v+2DmKv0De9LFrmkkgMhBbD9W4nKs/br7joRgIszQ9hmsm8=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(70586007)(2906002)(31696002)(86362001)(40460700003)(336012)(6916009)(426003)(47076005)(478600001)(54906003)(966005)(26005)(186003)(82310400005)(7636003)(82740400003)(7416002)(41300700001)(5660300002)(8936002)(356005)(40480700001)(316002)(4326008)(36860700001)(8676002)(70206006)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 13:05:01.2626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4ad71a-6b55-4835-f350-08dadf662444
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 19:10:27 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.228 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Dec 2022 17:28:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.228-rc1.gz
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

Linux version:	5.4.228-rc1-ge538d4b64ed3
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
