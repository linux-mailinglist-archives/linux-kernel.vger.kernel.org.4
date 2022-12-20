Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912676525C7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbiLTRvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiLTRvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:51:12 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB851009;
        Tue, 20 Dec 2022 09:51:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gfr3PrA8himQPCsEXwJITO87tIXl+U5a9XwrfHcz2LQzeL0CxMkr3kzswsoVRVJ0oUZlPLvSJH64zEDdztKr5hZg0LpNmC0v0veOUG4tCcpv8LekDE3U+vW5PwG0gMGtWZ05CSZoR8kIb/jnVj4bIUB6h8+PjFPhrgmfzFtiLxDEgETaaSPTKUuY2VL6rtknTRIZxIs40RX4FsoHWwTS7gadmyMxP1vEYYGvA7Y4TFa4qjoCiYS+f8j5kVscmY+ovvF3nHH5FgOF5ltZbDg0wu93gd00K3kKDIe9w1ZGiQbhsIU1Mq9K4mmxwRqmfM4QFkYNxTJ1AxHFL41UnOSsrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6hdL+gw19Rizjs7FEE9DrCVAnhLDleiFeNfobflQCc=;
 b=mAjpomfSzTGVJo8Kwgk9zXL9PERGpLyBjlpx9MnM92atgPTA0XFtgzxRIDPCEZjyzQ6HBGL4fawmUYuJ6qFeGszjZ+2ubqT0wf0Gs+A6/v4o++1gSiEsh7IsdEuC3D+AIz6b1wl+feZHubcWeuZ34mrq+f9lZDRbbacHK9XfncEfcRT+vlCnOOY5b9U3gmAUcFmotZlPXfxdPqKpDUlCCLjyR5tqpn2BZDvSjoFW1LQvcUYM5VNZopAYLrqJHE+PpnLvWE6Kl56LbK7SSfqIkJfRyUBdlSTqPj5OoEepRv4qtrJBrHwAog95lwjTeIF715/uLW+X8wcKywaIoAAvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6hdL+gw19Rizjs7FEE9DrCVAnhLDleiFeNfobflQCc=;
 b=nCokLBhvb8sfhAdGsTivVmPS+gcCS2kvLScrA3tRByjooC58u426QxeAhp7gGAbseuoWRTXMWce6xWgK/FR61R9LAtD/VRD8XdD99sB6bfMZrJhnqyZf6Mu2xySe9RBoVqEWLA3P/shE8ukCHWt3i9f0xxMogk481OAH1J2j5Qks63hhWLYMduvEzJLtenxR7XHEN5LrBRLAkxWeCRkgVGHY+skSsE80wWLqJYcTEqk5UdaKNlyhFIiAxbfRYZkItSnQIoLq2vSb2sphe5GHv8HprbR/2P8LSU3JfgZlBfaqp9MlCcILvRFCvZ8KtmWv11/a/nJpb0ZseM0OzCAPkQ==
Received: from CY5PR15CA0194.namprd15.prod.outlook.com (2603:10b6:930:82::12)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 17:51:05 +0000
Received: from CY4PEPF0000C971.namprd02.prod.outlook.com
 (2603:10b6:930:82:cafe::ed) by CY5PR15CA0194.outlook.office365.com
 (2603:10b6:930:82::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 17:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000C971.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.10 via Frontend Transport; Tue, 20 Dec 2022 17:51:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 09:50:52 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 09:50:52 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 20 Dec 2022 09:50:51 -0800
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
Subject: Re: [PATCH 5.10 00/18] 5.10.161-rc1 review
In-Reply-To: <20221219182940.701087296@linuxfoundation.org>
References: <20221219182940.701087296@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <3caa3b99-78ab-44ff-a2ff-8c8ea18a36d5@rnnvmail205.nvidia.com>
Date:   Tue, 20 Dec 2022 09:50:51 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C971:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 5010ed57-c7f6-4dc1-57f8-08dae2b2c421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tfduKpVrVxCrFq6Fe8nTkysLeNSwTxhz8U3kGjjKdeZAjBo40cvIiUldJpcain1p2eKbsKW5sunqgysGOoP/fSmvGFyWdPesEmUWrRYsaIepjHTw43wZ07TyHymzFH1vKAW6skYg9pLkQe6aegwIrw8e/NMjZoZZXjMF4bDmcU8/56MVukjCbc/RIAGQSar4OrkUIxefECwgwwy0Bv8MGcJWqgdrm9YfQuGdKePctanz2r/Fdvfxuec6YuwTl/fmmOou61EJfH9zbxvJNYiALe7hGgXngs8UoxklGR+KIqIy8phxLka7C3hPIjPZZ28GdX4hlaGzezhTgD30f1QG7IaToUURBz1r2MXc+4jpjx+J+umaaUogkexc61oDyefcJPpx16VpH2pm0QaMvykrvwgLOOEmm/fXSGApaGmRchbngFIdkz1IUj8C3eZsigm6JQjqcWH8lGF/LdqcgUMftwqm3zrI0kdFSaLY6usOmfcAN3uDdLI9iOMlMzVKCh322MUdK990SVCruUtVvLCjkB5F+i1sFdy1gjhvJvu0hPuhlR3WCyySi7cKLiOyVC80V7GDp6kU/ElHIn3ut8JTkG9rdCLfl9rPV/NzJ6wNFi6PHJIIy/A5cik4iY1Qy48+0/7eoLGSXg/leuTFpskLyvQHhGm3fy79Ggz6ju86KGsSP2ePR6xSIpwit5wI8UYu/SdNnb92Gf0vik3Rf2Ygwu4A59rQN5h5aCIeFEFdy9WmT1ewQxaxchiPMSc5kUD6WeFyxDzmc2LlpbxdKMUDXtO84zty9z+WnDz1OzWuaA=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(8676002)(31696002)(86362001)(2906002)(336012)(4326008)(70206006)(26005)(186003)(41300700001)(478600001)(6916009)(54906003)(316002)(40460700003)(36860700001)(356005)(82740400003)(7416002)(7636003)(8936002)(426003)(5660300002)(47076005)(70586007)(966005)(31686004)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 17:51:04.7515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5010ed57-c7f6-4dc1-57f8-08dae2b2c421
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C971.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2022 20:24:53 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.161 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Dec 2022 18:29:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.161-rc1.gz
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

Linux version:	5.10.161-rc1-gbc32b2c55e20
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
