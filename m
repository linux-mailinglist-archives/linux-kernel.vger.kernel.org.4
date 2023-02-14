Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1A3696D78
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBNTAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBNTAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:00:48 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964072594B;
        Tue, 14 Feb 2023 11:00:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYLhEHofNuLRvnzYw6lFp0W2Q37V+QstfZnmEMQegEBRXOQbp/MLj6S+YKVYN5ICFxK99Juxf2vVHxEy1OaFD2NCt3SFAlKG5+TpBLrO8Kwhi2w5j7J5SyuI+n92U/VAUXZpqtjN7AoYovvMZB4WC3m1KVJP+NkbUWv6/F9ar37WUDlwh6BPj7oqTpFmrFWiC0+K5ePG8ULkThu66D4bQTPBC3hBMCLJzoL9ceG/imYDhQwvZdOjhXvVAPpaeQy3RGjLZIdVun24GeYXjDiD3n7L/wonpve6gnQhPel/kvqT9kQdI6xqzIw9inbaQaewwvkT8daR66C9z5qeD3/GsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhsUD0t+N0+O7YX29oeOUKSZzpnmzjfbvcefCFHE7fY=;
 b=SJshqJck+43z9D7We4MHsEtAro3UfC74/ufUYgZ0TEzvJ2GEY4EP1utB4o4Ij/EyZB6hNWO5EBAlrECi15a67AmZhYK9FHyJQbqJHFn4GWoTlov+05wpW2q429uSENaIP6gG668Cgd8E1thh2tGiVQiqFCBVwTnCIgSrUfdPkNQ7ymMbGQbK1QPdYoiawxKnTYJeGeDd9KeCJdpqTwDzuqDfzPdhlMzZ4qTo5AEoDMd8cp6UXjZJ5MiavtADyfyew/ZhSTWdMS4sgyRpGf2bLzJX6tL5YkjK7Jn8oyjv2g1Ex39a8pLZsQSnhxnJ2Eq4Q3TxcfWCVLy88UamD7iiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhsUD0t+N0+O7YX29oeOUKSZzpnmzjfbvcefCFHE7fY=;
 b=hnxnT7DhB9nP0wHiwpJxpeRuwJL92uB1lksvEfV5XQuGn8P6IsuZ8BRsAb1A/+Gke8T6l50I1ZrEG2ikNhEHO+5Xv9ilmv4T/URy6mAvwlHT8WvzVrBicttJ0xvb30H9gE+zGzpAPHPzLN6k0v16RJIdPz+UbZhjYTQB45VUBQyOudXRPuzse/JIsxcILH+2qi+fGOQBeNnTXUCFLLm1FV9+xxvqMIpsKWwHjVYwCwD2rKJdsBNHrLxVfR1SZBD0i8KNBKzh5R8CqRFRgJPginjPxUHXxplN4/yrHXD3bBcEGlqZfQy5gscSIsf+2zPvvn2Xv/STZZfbjJ9QWQChMw==
Received: from BN9PR03CA0125.namprd03.prod.outlook.com (2603:10b6:408:fe::10)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 19:00:45 +0000
Received: from BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::b5) by BN9PR03CA0125.outlook.office365.com
 (2603:10b6:408:fe::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Tue, 14 Feb 2023 19:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT104.mail.protection.outlook.com (10.13.177.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.10 via Frontend Transport; Tue, 14 Feb 2023 19:00:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 11:00:24 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 11:00:24 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 11:00:23 -0800
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
Subject: Re: [PATCH 5.10 000/134] 5.10.168-rc2 review
In-Reply-To: <20230214172549.450713187@linuxfoundation.org>
References: <20230214172549.450713187@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <8fe8d132-834a-4a09-a8b7-ee3b8c56d8b1@rnnvmail201.nvidia.com>
Date:   Tue, 14 Feb 2023 11:00:23 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT104:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd12347-c1b1-44e5-e715-08db0ebdc6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJtWDEL/uNwpTAOFeHkmVzoAaxoS68knlz3d8bKVl/1YsGwSdCqwJajuH2nN0XkFrpx4iiL1az9lmVE8AzLC7/iX02O6AppcmUjIxBokY0nY62/ix4P4S35z3AjE8T8Arti+CODadoUwlOi0lrtyTMS7j89eytmbFSLoPwdFaXutT1MK/aE3rwBJ947GLWN5CJmaBtZaVfwTucSFb3XYwDeN9VzMgnvcJIDYLq7lTogF85w1eHJVBijSHSkFmelC/M7kaPETw/VZyLgPk7Pv1AGdl7xKWmDBPQ0KqJ2dYAiGdWoDvoGqN9sEOnwtVHRdtzKCJKEEG0/pjEZrcuO009bSLS+0+pR1UsIVZV8xL8M/Qq6DpI+Etpr4b2isQvsiWrJNiCftWI+7dlSdGSzkSMt8tIoJXJAeVYjF2ENFVFs054Cxve/seA5YXLQ8LX93uZtxt3VGc58U3bY16HVHRs8dL5dao+sDt5HMsGcTNXqMYj5h0f8H+LYoNl3pIrG+uCHhs6noY+ODatuGPe/yAkWXWe4Ew5T2JD0bwCrGPwvGSElMlmoFFvz6z6vWX3ZW3OPpAAYYQPBDUs2PM0TBd68h3kfap8VbQjB5ndRP01CxRYWsxva3S2dgP8e3/f1QeeSkVKx/zQoTFrcSvzf8VNZnvvOkKTBu4rryIZdab1tLhTAWIeT86atlV5pnyepO638+iIHUQPohWsRKhBab6Hxfiilp9qe4ZAKd7Zcd30tR8SkwCJJ266maY2OiL386
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199018)(46966006)(40470700004)(36840700001)(82310400005)(40460700003)(40480700001)(478600001)(26005)(186003)(54906003)(316002)(966005)(36860700001)(426003)(336012)(47076005)(356005)(31696002)(7416002)(8936002)(86362001)(2906002)(70586007)(7636003)(82740400003)(5660300002)(31686004)(6916009)(70206006)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 19:00:44.9065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd12347-c1b1-44e5-e715-08db0ebdc6dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 18:41:06 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.168 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 Feb 2023 17:25:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.168-rc2.gz
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

Linux version:	5.10.168-rc2-gd76a8be7803e
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
