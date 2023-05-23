Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7023270DDB0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbjEWNko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbjEWNkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:40:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B6C18D;
        Tue, 23 May 2023 06:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEWKtUNADzG1v52tj3BBHzu2P3xaXLCViSaDGFl6zntvj0hxr2L5v6J2VKPq4G8REvFMlSTdy5p9edRGJuPxn54r1yiQuVWZbuRD8FT1cirOT73cfAbnqpKYZSlmE/9WmKFXUznjuVin+hPBj31qWmH5FFgdD10bckLZgJij9XKnhIseKxQwq4VreG+/YxvPsKbnlrZk4P5Bt0eVgYKxtMaPN4lLIKn/6wkodwz6yI+7Z+23DuJXiYuhEYyJVcoVwyTLOYPjCrl7fxrPjSkUOGcRpIEADG87KRNbKBVmHLSBXV6Ki72EBQHGejeRV8PvIXVf3wGN7C/VP8VMvQ/Crw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4zA0XRJU/yF1w44T46B2smr1dTTg49I+IPGIxEQXTM=;
 b=Lu+/nP6cE5iQz/1L3iyLpz0MWBpEymEPO2x9f0sjxj97jWhiDS0yGcnsUuNK47ADJmWFzNEpqMd1yuflAm3uP7JDLGg2c623RvEEotIGRsfKtu/0YJzn9e5C3bI2mih2FJPFkCl9OjVG7T/Yh5eWY9m8wb5NRZeQymo0eoYbHUfu5/dMqVccY1sGGIT04T1KkKIJDbefZ9S2WfxzYlPjoWwo1liY17LE12gLoodET6vu+du/5RX3h4Z2/QDP12BfmunyV992U3iuTWCB4G9dx9MX0v4sTM8MK5ST0Eaacz3uM0XEMx+07XfxdqXsPy/1aRLHfYrY9lSXGZKdH4ajYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4zA0XRJU/yF1w44T46B2smr1dTTg49I+IPGIxEQXTM=;
 b=ia0N61n7yK+v7E0i+fA9XxNDly++K6eqfXfguaN7jPfB/GtBLXKGbir+UmRhLxaPNl6Ujcd9M9U/mGfsWaJm0ZgreBuhqIcbyhwt8RqaPjc9ikpOGtucAblFv47N7OgTQfFJ1ic5aPnDxGV2b7q809dV2sIbsOdl0IJ/GSwjvnmzc4BASYo1SGVcUOgtBgfzTkWaiEXvdYEdYnmMyHvc6//cf4kznP+JFaZrd7G8inwoiCcfqYXEdysgKJQkdJa1LVWhXJWHrGaPV0PuYwBPW9IgW6xo7ihXc6CulHfEXAkgoG2EKzzX8bKKsS+KBj+BoRr8RHKtbJBEV7fggpQ3IQ==
Received: from DS7PR03CA0262.namprd03.prod.outlook.com (2603:10b6:5:3b3::27)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 13:40:33 +0000
Received: from DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::28) by DS7PR03CA0262.outlook.office365.com
 (2603:10b6:5:3b3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 13:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT106.mail.protection.outlook.com (10.13.172.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 13:40:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 23 May 2023
 06:40:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 23 May
 2023 06:40:19 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 23 May 2023 06:40:19 -0700
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
Subject: Re: [PATCH 5.15 000/203] 5.15.113-rc1 review
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <992e375d-e699-417b-b9ad-d3a6e4ca8406@rnnvmail203.nvidia.com>
Date:   Tue, 23 May 2023 06:40:19 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT106:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 99323e7c-7810-4f2a-8cff-08db5b934879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYTWfHqWKooreUpkB3Dd7tpTBsLbIn70h7mXRdG8l0Ak7xykxOrFM4Bxx1RpdNjq8ZwkfEp51pshKWYmEjQA+KO3Oz9uTWDb0IzcxcZdMOZw8pVAYapQr3FMpW6QVW6FusbY/8+eVNFpd/Gv8hyflo57TYVSccufBmuvVkdsiHwkicMQcGQEfPyTndWM164sQWIhlLu4gQ+Y+8uNOU/F6SO2X1y7KZHa44se7pt6Vi05oUxRfcCa59b9JYyu2LJFEZ7IFWIrHT2Ln+gYB5M/NG7ej+ixB0+IOsk+Z2Fgg8bSW1jThlkvRL8Lmg9lxHDctqUuUmq3HEnW/TDb7JUTri6Og9gBlIPwqHaQrhOfcAjLs8AuHdvueWMFu/qAbOYlTmCMLdFzmVsFHEAhrXQd6jlUq3w9yCQJpoGx1uIs2QhfRw1MsNs5ocr5R2ELaHTigJOj3+O54pjMIa4QBkBMN0rOxZcHOubuvOa1s7h3T7DQ2CduWjN5d6zOP2LKr8soQy3G6HSZL+WB3CnnkO0kYsLejzOrtE22ab1u3hsXd+2EDn1I8dF74fpSLmftm6j/NvGaAy9/cPkY6U4U2xMYnBCV56Jjd2UM61gacVmSPJN9HRkSERXY8sywYXVaj98pJ2O2FYoLqII+TTk9iRRT4vH7sJUW93Cv0dc0U6geMZTX53F906IBrA1JAtMV9Br/dX3Mdw4INV4yjg8VFBNxOtCmn2EOAPVhpgLCSkzP6zy57Dq+xhIVvnRK0fkO7Z4jRpX0TsWp6pLkI/n4zouIK+Ao9apv772sHfg8TFM0jMI=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(7636003)(356005)(186003)(40460700003)(26005)(82740400003)(7416002)(47076005)(36860700001)(336012)(426003)(2906002)(40480700001)(54906003)(31696002)(316002)(41300700001)(966005)(82310400005)(31686004)(478600001)(86362001)(6916009)(4326008)(70586007)(70206006)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 13:40:33.5740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99323e7c-7810-4f2a-8cff-08db5b934879
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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

On Mon, 22 May 2023 20:07:04 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.113 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.113-rc1.gz
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

Linux version:	5.15.113-rc1-g30213a86a6fe
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
