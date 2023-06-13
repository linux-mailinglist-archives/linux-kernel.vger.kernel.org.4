Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A0E72DCC5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241582AbjFMIjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241633AbjFMIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:39:25 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294FD199C;
        Tue, 13 Jun 2023 01:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eevdScZ3oWPnn7xFrWFGeZfrc/thRHXH38oKyZaJ1wv5TrUK86GeyvseC/XxMVm9dLn5U5iQSU6RlgUxOlAoqcO3UnpLgzZDDUpzqFMbeICClheFAgcR9l4iWg+QS14UnqKnZt4B3YkvXd43U4iNpriCT9ce0uAQNi+gH9TYsWdXpWSO/jWxfauPzb9Kb1v/4NLo537KtPSlFeG/Ya7+WVmNa3c7V8WVbgTU04n+UgvtBiZd5DN/1ktR+WeAr9CqCDm4dd6Sw5DcOVGQGWdQYx7loDXGcCCfJ0JIYWgvwPe+fhvIWRDcgIvkvpCcoAD5QedquhO1ghxI6TZK9qW93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOaAoosQPvy/89DQzVD/Wv/5Vhec+rgcEocBWvLrdgE=;
 b=lqhWOOadRr3dD/i2uX7w7oDhfbS6/6v7KfZLmI3jvzV4ReFUzxaApnUCvE34qa2GV+9VJ61fc+NScQF7jFtCLGdXuG/Xda/OPNLtO1cz4CJe6NF6e2DqfBGJOtKYjKNgkr7X2LZoH6jlm3Z96vjVlecuJZY1xHyb6t5/L3dh8aHsu+OziESS755DnWpUDaP3/XW1Ro04dt5WPTE2Z9dluvuNGAF/KUC8oBEngop+aEjUM86kZB2eGkJKuxqOb9j7cNQe39Qswru3+C8Tb88/00MrR9xdxO6sppd/Phz8GPUNvNT3IkdUJSeCeNP9HrT9c+uebIJc7mNmGyMF2VustA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOaAoosQPvy/89DQzVD/Wv/5Vhec+rgcEocBWvLrdgE=;
 b=gW5fhyyyO0G4axEqsabHncyiLp23IOHXKcVlUpe+aPUqD3knt1Ob+xzG1ebF5SbrSguyODp4vxfuXj2oCr3E41tSrciJEbT464DIf495K4V9f1OjN9sGyLjU6W2xtL3rnC7t++d8UmbfgsMUkjTiLq69jfVgSevpKR3UqoKBB/KvJqfmlGMjTxg85OiF7tOPNur/yfWTaTtcgBga9gLZnJZOtXWud2yHVu2m9ov5znWakSclyBgqoTShsJHbB8dn3980rco3lIcIva8HqkBmKk1Is1jL67s0v24wxYjHZJMpWl//C82gK4qpz3Ght18kxd3pTGGuVxwz95056NPBow==
Received: from BN9PR03CA0438.namprd03.prod.outlook.com (2603:10b6:408:113::23)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 08:39:21 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::97) by BN9PR03CA0438.outlook.office365.com
 (2603:10b6:408:113::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Tue, 13 Jun 2023 08:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.22 via Frontend Transport; Tue, 13 Jun 2023 08:39:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 13 Jun 2023
 01:39:10 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 13 Jun 2023 01:39:09 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 13 Jun 2023 01:39:09 -0700
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
Subject: Re: [PATCH 6.1 000/132] 6.1.34-rc1 review
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <65d2bad3-dfd6-4625-9cef-62b9865b8fbc@drhqmail201.nvidia.com>
Date:   Tue, 13 Jun 2023 01:39:09 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: caabe74d-ff6b-4924-6cff-08db6be9aecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYZ22wphszJdPF3sYLv1D1lBU2KoPkLQtoAqMtjuaU8ldYaR9NZvOG1HKEcXl3uGybKrG6VC8mSDg6oqjULcITFoqR0DdDLQ+7PgRMUIPpmSLLejaCCHI/ICU9DLcxX9iXQ7PqX/WgtcVLFbtebdD/xwKixck+ErS2w/gMKq5dFR31thzpfBa4s9W8MDOms+kf5YI564NYDqVn45QR4Mg6mZLtM/bsom59uUN0rV2ltCRrb6cTjKGdiEfle7MExKcEjCOzEGuCyhOrSq8x7VX8onRH7ZejPdgtyJ+71diQdK8AkjsC/ldl7Ni7v6ZCOhM1dwuoA/gqx3mFuTatrEjWGSxDh3BbWQd7HRhvjQWtbEeas+4UgPLI95es/lzTGIkpU1Sx4QqWn3/rehyWdXFlCZqKel0y26UktC+BExEVGLy40FgpRpLDNz29zZh8NU0PM8g46KqUmhvKAykz5pmc2RU591wi56HNZgipaHK13eNo9ZAnn065rXh6BFxYaS0hYRUX5QVrSJf8cqKRq5R78a1zgf9OpMvTgL3PitEBjT4Im5XdWACWOX12ZnojhPYTM6FjDG322bQXoxFiuwOreoBs9NcdZV4wFkeptwCWD/MHushuhOSh3xjyK4SICOv4gbtEu+3HjHyjXe0gnq+orLHSgFfKZ45oWozq/jfS96yaUie4QjJdq8diA6Pr7OtN8EAZRVKjz04HyZHtQTkCwToDu72+OhX7fvwGFalrXcU7WugJqXV/Y5GtHO0jIq0Rikvs3rQWq/cUheXfy+oi+m0O24agb9urwbVP/21T4=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(426003)(336012)(47076005)(36860700001)(356005)(82740400003)(7636003)(40480700001)(86362001)(31696002)(82310400005)(40460700003)(478600001)(54906003)(4326008)(966005)(8936002)(8676002)(2906002)(5660300002)(7416002)(70206006)(31686004)(70586007)(41300700001)(6916009)(316002)(186003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 08:39:20.5367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caabe74d-ff6b-4924-6cff-08db6be9aecc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
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

On Mon, 12 Jun 2023 12:25:34 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.34 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.34-rc1.gz
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

Linux version:	6.1.34-rc1-g08f336c8c68d
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
