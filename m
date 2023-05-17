Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3AA7061D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjEQHzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjEQHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:55:29 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF4010F5;
        Wed, 17 May 2023 00:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSdFrytpEBy9Q1L0wrwdnLiouPhYpzx42AHScxXPax30GMzR22xYz7wxDyhuOXXqiPoM9jySD+v1cWIJS3opbunGspy0W7WmvRqEx02ptMiuZboXebgu4DN+n5oQ5aNPw1f0X6s4PNxbeRaHlrByuctGFo7WoKqMoiZ2ihuQxgMcP5Za8ktK0bkiwR14zUFGU63Aoke6vPv2CDusfYb2DDa1mqtYyF+I10cMaFRbgf/za6dHBWeSvpS2a+vefhpIU5hyqdIZLkroDCj/TMVjja/EAaV4viqJOQdJTr37v8m9gARfCO4Ew0IQWjgfMf7KqhE4+m9U6Jb+80iy1R6Oaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOY4sd9tBVEG5AMLOJJGtK/6N2AShD7cEM4804RGL1k=;
 b=aBcrLtYpSH4UqMZyY5iowTKbvkIXxdwKEsUGuSnT1S3Ip+ocshDO/dvYk8clg8s9WbQRLGN7RZjj/rnXZQo8Ucrp38S6QiQSdKmUCoJN9anJGYvncLDxZCFch86br5wHHelzs/sf5rseRuDa2veVlM0e/RpNbjPdIqQNDRJ202ISNguaHduXnuu5gxUWzxmEFLNfogNfb/SeJf2mbG5U2FmBsmSdGj1X3pO2yLX7Fwf10exH6VnUfdOr8t27hnd8LgG0dqxaH6dSlVGlKbSCT4YY12ePRGtdWPyab1n47b16eUuBLABesaJoGwl7t0p5RehYRHMtKr3ksFAGGn8KAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOY4sd9tBVEG5AMLOJJGtK/6N2AShD7cEM4804RGL1k=;
 b=U1fneoTayeS4JPKCMdqCYtCBowDsLpLdESjycfaLC78rEpspZu1HYIeS7eyPUZq7088Yg9QOTInikrlTc0uzw96PGwM+3o1jjfU1mmptxYhCzrY9wIzNJZM91vQYact8ZDeLmkPgZwH30Q5mOebXFPt1dmfTK2462tYTotZ0WmCgWiy1R33lY76R2XZkFe5ec5XdVDN6yVW/3jgzBZiTugrOAsHLCuyuqokVFiX7cQtVvPlLHZZAdqsIPTm6YV+buPr87Pofco3SUsVt8bYUxOTJm4qTYNKeQOaBaE4RVBXAFnAhuopWf+JqOe3OH3HYbijgEyMt13sa5UvcZZu12w==
Received: from BN9PR03CA0539.namprd03.prod.outlook.com (2603:10b6:408:131::34)
 by PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 07:55:26 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::74) by BN9PR03CA0539.outlook.office365.com
 (2603:10b6:408:131::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 07:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 07:55:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 00:55:13 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 17 May 2023 00:55:13 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 17 May 2023 00:55:13 -0700
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
Subject: Re: [PATCH 6.2 000/242] 6.2.16-rc1 review
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <c9e738cf-3e17-4639-addb-1b6b73ae556c@drhqmail201.nvidia.com>
Date:   Wed, 17 May 2023 00:55:13 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|PH7PR12MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: c36891a4-d684-420a-7ac1-08db56ac1323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHsCW7TDAg2oWep9qf1s3tZY019MQoBfG7lSMFkB3zaXNtOfxsyUMNQFmwlqdSsVpg8e2kjEJleEYZB5e5iB0wfUhS1IQGSmkkxgIhfLVyCFBR8fFjQCjGqw37TbZR25G/y7naMiNlR3TgEvdHvbLOHHZ1b9K4KKgUlheOaX/DcjwP3lQqPr6Aw4ui+f4YBXPscQTXqjj3iO+6pOSZJiXWWSbUkQF+x76Lqjd72R4AV2gTBBHnqrl7rJvb2yozHw5343clc53wVD86CE5y+apZMMxUhowXAs18E9tcEntsd0rOZ2P8+TZqvDFKgFw14ZLY8povTx+/Ak118yWVLBUd6ho28GyrZrT1PMeRSsFw+Xf9dl7dnx9WUneoXZGu7/ri463DsC3FkFpelawV3prXuorRgol0uS7OifZQkQwrHUay7slYksVGZ1U1G64V9USXbLen30tipkaEyUnX0OXNyn+1bD9mTQEEBosVovYkJLEh/pWKhxGd5X9iUEPzkMLH8KCZpouILfOuqvnv4Ko1IG9+bUhIxxfvn+S2tkox6TwEpUtgzVbUTI6H/KwRFkRtz8i+WW7VTlDe+i5PolQy4l07TqxD6+0RhEcWYUkhAPPDjP7S8ctBoNYWfbVTb2B25T1PhxA+iZdXzSpd5G5xkurgLqaoXzO3PmOPCxi0bXj1rXctdMTWbYRqsvhcbwG1xBIne/aqiNxvJDPcdEn7xv/KTSVooceqPZqRwaTfmqOcDq+LXUgukHG2VqvlDVDGVOZU69yl1Wlj72R9xXzi1WctYzh95+d2NtcdKjTsY=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(966005)(40480700001)(36860700001)(47076005)(426003)(336012)(7636003)(26005)(40460700003)(356005)(82740400003)(86362001)(54906003)(31696002)(7416002)(2906002)(41300700001)(8676002)(31686004)(5660300002)(8936002)(70586007)(316002)(4326008)(6916009)(186003)(70206006)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:55:25.6481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c36891a4-d684-420a-7ac1-08db56ac1323
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737
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

On Mon, 15 May 2023 18:25:26 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.16 release.
> There are 242 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.2:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.2.16-rc1-g704eace42a14
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
