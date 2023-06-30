Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED86743BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjF3MKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjF3MJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:09:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97961FE8;
        Fri, 30 Jun 2023 05:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8F+EoCrbS2hAPhOziZMe5RpOZknZL6Ir2mXjjuYQSaRsE8QIpH9ar6/yn/OcBC8r5S/ctNPUZGeY0Yb5qZsAXX0AMf5xJazzC04rO6Voujw8l0G97IuB2Dyanh+LhhodNLDQsfnk9LYDrbd/tqSEpCTOW/SmShfA4Pd6fiu4rSGOFJcnHs5yqjAPyahMp9K2jMHM9aIXWLNDju1NwOfkDjRDkcAKRKCuYQ48YW/DTdQS2unicgFmd8y0uGmlFDTj10OY43ruZjlNmriiSTS/aJRRrC1wz5XCPBJK/6aCSP2hCTfDKAETDB7wjz1+KV02UpOG0D7QDU+B2P8z7Ra2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azT+jArFXsBqPQ5ivHoPGLMOv6RqHngNnYxhDm0YOLA=;
 b=jV3TkeXtb6pp2Gag0wTj1A+teLt18/CIhrM9jEswGEAJZRWR7xbNHaWTkkXuTe7eR1PWrM1WZqWYmW10Swbl2YsEJmLU8KKr+6ochzUrHb0+yxq3epXktbYDZg+ylojSbDO1twSJsJllK1TFfzBm5xYtnrM32fSwuRtczQV9p7ZTs3+2GLedDMtVaJUkK+KXMaPneRPd2MPbK3/esC1YqxZQ7BLjvHEOuR5SspKkNfXa7+lEPArMTcL0c0vnAqsa2vFvC9sI4SnatpBrpYgiJ8HyOOVFmcL4F+Z9jPIf9NWGwBhJeY+/jRLc0CSrbV7MkYyn0lpmhWKADorkYhacsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azT+jArFXsBqPQ5ivHoPGLMOv6RqHngNnYxhDm0YOLA=;
 b=h/pWDWg71v/ttSYqnRhw3ZxJvS3rqKXL4bbeOJbT5yd1qpS+vzPGGONGl8eZIfF8ut9Y8qhNZhax2I4nzz22Y/OkqSvDAEKLE+bfJM/e4N1KCV+h7Ul0ZjagRPN7lAlbhGoK0sGN5aoK5cIPb+lZ2xHjpvgGA6OF7dpIL5OAS4hZzN0vbbYfiiWzUg6BLNTAOqiV5LWErk539lzwkyx1kSw0CI3E9HMOOGSHWTyCgGqfbuFEP27O4wCQo5xl4VCZFL7Qmzi085hB8cBCAzZqm/S2xfsCKg4NASaKyUkozGEueYXSIH3+8DOkomoCayORrBVdjeiYYLY7ugBmJrnieA==
Received: from DS7PR05CA0021.namprd05.prod.outlook.com (2603:10b6:5:3b9::26)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Fri, 30 Jun 2023 12:08:49 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::1d) by DS7PR05CA0021.outlook.office365.com
 (2603:10b6:5:3b9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.10 via Frontend
 Transport; Fri, 30 Jun 2023 12:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 12:08:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 30 Jun 2023
 05:08:36 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 30 Jun
 2023 05:08:36 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 30 Jun 2023 05:08:36 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6.4 00/31] 6.4.1-rc3 review
In-Reply-To: <20230630072101.040486316@linuxfoundation.org>
References: <20230630072101.040486316@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <0d278483-e016-4b21-9fd9-993da76d88f8@rnnvmail202.nvidia.com>
Date:   Fri, 30 Jun 2023 05:08:36 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: f2bd894c-9712-43d5-e0e0-08db7962c38d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UQznNbLLfWylWCaAFIGDff/1VtZqJRGVNb9xbVgvmmorakS/1BHApiCQPCXIySBvkAZrBAQueiuxOvqT2rZ73zaziRAYd3KM6mmkz2UFocCqLEQqv0HxF/nmLR255lGaUbuXdFyQQ0HA6m3O73pKj2/hjT6eVHi48k8q0u7BKiD4zucwGQl04MY86DT++vRDQGQi9XtHpPZJkO9lxs5CUWb53q4m7M/Mi4xY9XoRe5ntS/vwg3kRAgRJLPQrU//ganCZnEVUB1jJirZ19y7qyqnwoOHlvBe4MSPK9GczPAtDh2zrsBidLA3LECv6UHeR3TIHFi8rri7/yjDDi2x7AriH0FNlT3q1F5muDCO+q3gjovMt8VewitIJF6rGhRdne0hZO6YD++s9Ym6BsXq2/R8nJzFqEaWMO0ujvjSsMA5dvOMjCW9DmPGJtW9r/59nPXVlpH7krcfgvens2FSiBnGLDeVm1lycEX+kYBpYLvk0rjO8v5gKnqi7liu5oc501juyfhSWh7WgSwAFQPGJogJX2xatxIX3TSoOurK3qXxUBJd6rG53VWy7bOlQZ1yGDNFd2RYdB9wABKgfttj5WiweJbJT0asCDsHGYd+ZBy63wk4hIACFVlGsgqFNYur6gWPels9UHXq7HO9PQK/ALsnmLPYcPAvvpi/nTFSHz9tyhz/uOSjmoYx8NZ2zArvT9QjTio5ZUx4e250ScKV51KA+QrF/5rb+HkEF8ONqxq7wmO9Dzv9am7e0s4GfxQQANNnWAczyiYJXcP4w0kJrVlYFYRk9TzfCPFBH/u/Y5M=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(31686004)(7416002)(316002)(70586007)(6916009)(4326008)(478600001)(70206006)(8936002)(5660300002)(8676002)(2906002)(40460700003)(26005)(54906003)(86362001)(966005)(36860700001)(40480700001)(31696002)(41300700001)(82310400005)(426003)(47076005)(336012)(186003)(356005)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 12:08:49.6262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bd894c-9712-43d5-e0e0-08db7962c38d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
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

On Fri, 30 Jun 2023 09:33:31 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.1 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Jul 2023 07:20:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.1-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.4:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.4.1-rc3-g94976aa9d87c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
