Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552286B5075
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCJS76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCJS7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:59:53 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E1C12C70C;
        Fri, 10 Mar 2023 10:59:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEq8m/VoyiR0Prgfd6NL4MuAD0HKhHzGf+vSPsEzPFs6iOQefFHtDkskTCdK9VkNRIkHSyA3LxrYtbTvHEDKE/saF4uIxBzBPoijX1F61oMtmgLBIBJ02ihoGJJmtVPyIzH9aSAnhJyUZ4j6O68wviCAYM3pYB5WWY9Pnpz4SDWDzAVA8HTcImY3Wfm+WaYE4xPupqnz+z86s6mpyWMZk3vylQutCzjIqWXUrWNCgGTn5wEgdXcoJM2YW0om9FfhI3gWpQFl2hjFzkK4lLl4n5RlhN6wp9XS5XrpkQdzK8LVOKLtItC06KYkF8Rlc/CrMP2PYPgUKeUnAHcFk4Y02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Zol/V7eAeGa8SL43/HlHhv/jVQhMQQxTqXxH9lPqE8=;
 b=RrLNI+0ZsxAlCZNVHlcq8Iyv5kjljgrbKDjHdtDUK4q3MjVTMdLUA3Nrv81tamgUkzlyjRev/EVV6SGbF/vknsHtvzUgtXpbhUSRISYTGMj6HPOmr0dqkg5g4KlcmpPkIfb0AamDY6JNlHqnLmZPvdogO1zM7z5cSOYQBBZM7j/0sTTutxGhWrV/Od2jM/D5cUXl94+M69ETUPqWV+/Y1yJS8T3IGRt0kOvY6VV/+MRKxs/RNRvo3XkDJG/MqNfhqWJ+Wub4yAsaNopGwhVT1X9Y1kEwKRLls8LyH145xQ7C9UNxp1t1HDqcTAjhrhoe1Ba7h257iR9Hykqdl0zCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Zol/V7eAeGa8SL43/HlHhv/jVQhMQQxTqXxH9lPqE8=;
 b=DGwcGdaJQ+SkuWIYMWoSaAqGRigcpMRvQnFhJLU5H3cK4sCWGBUEUCf4mtiVy3HbkRmQPGmHyLSzQk1B9wSDRUhw+sJzuaobc8UycYmyeQp8zKEYuY1NcCWbfZGl7lV6kqRyRUOgFbJ/USCnA9eMdoYKUWHCpdvysjytJPFiAUe6cwexrjP2IY3p9CZX4oSPtThW/QfZOUayWnqvjp1MeI/dRX8O8M7eVESb3OJykQIvtAqlLXMQ83Ll4sVoOngyZ4KrvRDemwTnIovxUKGle+BWpNrmKQlP4hizbT11NKKjvJG9Bteh8gpV85O/WfC8PbuDGB2+fzhcE6Ir2lWv9Q==
Received: from MN2PR05CA0019.namprd05.prod.outlook.com (2603:10b6:208:c0::32)
 by MW4PR12MB6681.namprd12.prod.outlook.com (2603:10b6:303:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 18:58:58 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com (2603:10b6:208:c0::4)
 by MN2PR05CA0019.outlook.office365.com (2603:10b6:208:c0::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19 via Frontend Transport; Fri, 10 Mar 2023 18:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 18:58:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 10:58:44 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 10 Mar 2023 10:58:43 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 10 Mar 2023 10:58:43 -0800
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
Subject: Re: [PATCH 6.1 000/200] 6.1.17-rc1 review
In-Reply-To: <20230310133717.050159289@linuxfoundation.org>
References: <20230310133717.050159289@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <99fae8f8-d84b-4446-886d-785b9f69592c@drhqmail201.nvidia.com>
Date:   Fri, 10 Mar 2023 10:58:43 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|MW4PR12MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 3313d5b9-6be1-49d5-196b-08db219980ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yljeekez0jGBOLJgMrwjx3zFDBmSZNNljDNhuGEfeb3P48sU0foFvVDo2R4JSOchrP0ZLoOh8GSRi02NfN4oKqyC3lXtpURalw4dctDmiTRr72SDGN1wzzl8ruTWLh2caM1fFnzScXEK7CocJVU4EqIZE7Whrc+cdAyn00Rx5QPGIqy0xsIRRmPrhqlaoFZVSohN0avDqtp1R46ZOr0V29j8qUZr6ZoJn7iRpkUGOTXVlfICB6Lgtn+s9qBGzLeebxusojemEauBexihQEweWqAK52wzc+1UzfOp0U2LfTuZxgNN4iWeS1mOBnceVB26RJR8mvHWk8+7GeGDo/ggNXdnewyJPnV3d7dqCU7xkHpdLnDcdcB1Icg6LLAGPFMgEIT9M7M3jPYHVtcsD6iqkP0kyhRKEhEAytT9WHi1WacKx/9gk6JEBRTuk28u/nugWiMkslduDr7yGMs/C1NunVbvUtDzr63T/Ka2nsCIEQcJbJqGaWYOjhQVLTLk1a45bYggrW8Js4BlflSl++z7V+um1K1/F0McJm/6h+CcHxjD5EChwu+6w5wWRhzH7QcnyOdWZAzGIZQskH/qvOVvijlAIyDLhUkBNghuG6PygcfW/+yV1OCGrQnW+TbbdiGPxr5B/1qHfwd6J/S+MlmeLBftA/B7Z+Vk/F28OIFFJESrHIXxMPq5HyEUHrOkuI/qsH5+CoSetbSGW+OsCmGCAF+NZO5UQa0XRCE72Q32B9XaOXIf8bZTK2CF3PGWsTNYmXrHZu6fwMcrjUBflDIZdMTn914imDbzJzzn0vzqbaI=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199018)(36840700001)(40470700004)(46966006)(426003)(47076005)(336012)(31686004)(82310400005)(478600001)(54906003)(40460700003)(356005)(40480700001)(86362001)(31696002)(26005)(36860700001)(82740400003)(7636003)(186003)(316002)(4326008)(966005)(8936002)(5660300002)(6916009)(41300700001)(7416002)(2906002)(70206006)(70586007)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 18:58:57.5729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3313d5b9-6be1-49d5-196b-08db219980ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6681
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 14:36:47 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.17 release.
> There are 200 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Mar 2023 13:36:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.17-rc1.gz
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

Linux version:	6.1.17-rc1-gf345f456043c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
