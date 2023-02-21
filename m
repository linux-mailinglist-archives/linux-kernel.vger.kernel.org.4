Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5446969E22D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbjBUOUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbjBUOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:20:26 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12hn2218.outbound.protection.outlook.com [52.100.166.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE6C2B2B0;
        Tue, 21 Feb 2023 06:20:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpiU3+e6pf8eQ1k4K4tn+d5Hoo++Pc5HZEIQEHszq51CPwmLa7sZicOQ8KaXB/e+EWPdXO6fgwPkfZfqKFvGK6nfi1V4l5hH9/zYbsDChfsemxqlvB/0PHYzeNrmvftGy25jV47GjxAoxp/lOGexi6PMo2WoNIKWbyZHlzo82BlhLFblCiEV57jfoFItW4s4ZNeXnUf8160vv0uZ+LIuWWlvo2zaJ+BiwXtOU43Q1nEVs5hxEaq97QFyGt5U2isI6h/VeUnPwfMs1XJ5TqRr9aSDDFXSeeE3U2qvjevnVSxf7orzQKgaz33Y6vEEGiQ0vOOwUETZmXy2AxBR3BsYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2CIhDLi+an2wg0PhdJ9YLQUct6kssamUSSuejycI5A=;
 b=bmAoNE1iTkAPDZfBm7HLasD94yfHsssDRkQZfEtle6zt102Ln36aqkX51d2j2EwSV4N56vUpwMsIw8NNaeRaBo2FUZzCMm7hdvOKFSK9C8UImBVHgz3LxdJLVgdkNBmPbEhayP92fOiktxXYFkxr8MGRwL8q2AiwoPkxF/oG5K6EFq8RyKGmltXN6g0xrioePG/rfhGrqYDppbnA1FU7G9P4AtCPUCaLJ49tdXt5OHgovGHUFK6ru+FN5pcgWBImxA7xosrtC6NUZURHFf4WR+xmt0cUFhxqOX33yRYKQZfcr7Q04g0L6ll47eauD+1EGk/jE5ypd1+i8ygQNZo2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2CIhDLi+an2wg0PhdJ9YLQUct6kssamUSSuejycI5A=;
 b=ZTGhDk7/dmw6aK0MiE9rHm93YZ8/2RskTUFZDkrea9fF1Yrp6DHsQQzYXlqTGsSAGt3voGYtHsbOncFnf1Tdxl3fJkncvKhNq16zUmqm5FDQgJdKpNNI7lPQAvru7C1DjNoXWAjVPom8lXhZpt8to+L4W2SquvwZSJcr/KQJbBmP2wrcU3M7GVFMsb/Ap5oLjwWpdFWoW87ZzZnObnybArqT89cdHVnnSZHnDLTstwFGlSargANTxPrjVCSgRXxiMMQl0KNg0ZOk7B+UUJ7x/fM2hNlBZZYv3DGoUA7eM2k6JP+e26g1H1sLMh17/8HEWQb5ElhIDZEBVKs6Xadw0w==
Received: from BN9PR03CA0608.namprd03.prod.outlook.com (2603:10b6:408:106::13)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 14:20:22 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::3b) by BN9PR03CA0608.outlook.office365.com
 (2603:10b6:408:106::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Tue, 21 Feb 2023 14:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.20 via Frontend Transport; Tue, 21 Feb 2023 14:20:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 21 Feb
 2023 06:20:08 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 21 Feb
 2023 06:20:08 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 21 Feb 2023 06:20:07 -0800
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
Subject: Re: [PATCH 5.10 00/57] 5.10.169-rc1 review
In-Reply-To: <20230220133549.360169435@linuxfoundation.org>
References: <20230220133549.360169435@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <f20dc025-3830-43f9-af82-b71e132ff126@rnnvmail202.nvidia.com>
Date:   Tue, 21 Feb 2023 06:20:07 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 85627c2f-0589-4f10-2f34-08db1416c4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3r0oDNKbwC8ybOL9qIXq4XoWb7zNC2xzp/9nAYxuDju7c9idftVy5PU1cBPJsHFIFA99GE6kAaiT/0Fe9PzohxB3KZCMPPbUkdbv2XmpaLv+TmBF/480WdF2rZMEWqAI5YzBR5YH0HonQqLp7kZP6N9yXRquNVh3B03dDl8rsROx2JuknXdVFPuGwqM7ysnNy0xCrffGxgZcPeESNBURv8ejpWt1XwAqVG6JG4c5gDL8m46KYDt87YnNXQYoW2o2rQFW1wEempO4illJRYj6O2Fpnz3ic1q+K0Mi7qPUn9vFR+y1PWuEBzenVnSSGttYNNfSEbqMYvBJtV+ASfLO3zBxRFxzo/KXrDsKIp3HFKnNSZDhE7OYN065NTG9KYw6CfuiA9gQRqT5RgTYqcr2JfCnh6zg/+rSmsMeq/OTPXDgeRdtIlV+xVCQnDnOS+FAYKBiQ/uhCpqfZ/XCAZbfKeIb2at4L7f+Z93nwFG8wJM3Rc2PYXmUhCN6jWDeRNjiZSDcCpFHSbBk3Iw2vUh9DkLZUNDkK2P1NJB9SQNojWTN2xwroZiUyGyA/Q8V8efWZcT7M+8JiLo6FNJTTk/GNqPhUIK/5SXxetWvPaFaHIkfr5dkOol9ZOs/9sAa0maSmOTH4vb0N2fadN7c9bqjONWINXFZaZh8oIP2Lr2gDHzT6eG7V81GFbesz/GX0poz8eEpMzR8WS2Z1U+veowUlYZsPU1hjCWvPe+H9uKtsE1aWxc8iYcNO7Ui0GQyF+xNC5W13iKcMEUXDXOqMf/BDg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(5400799012)(451199018)(36840700001)(46966006)(316002)(54906003)(40480700001)(34070700002)(336012)(426003)(47076005)(31696002)(86362001)(36860700001)(356005)(82310400005)(7636003)(82740400003)(478600001)(966005)(186003)(26005)(2906002)(41300700001)(8936002)(31686004)(5660300002)(4326008)(7416002)(6916009)(8676002)(70206006)(70586007)(12100799015);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 14:20:22.7461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85627c2f-0589-4f10-2f34-08db1416c4f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023 14:36:08 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.169 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Feb 2023 13:35:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.169-rc1.gz
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

Linux version:	5.10.169-rc1-g7d11e4c4fc56
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
