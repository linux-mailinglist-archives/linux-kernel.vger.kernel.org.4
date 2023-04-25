Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE3C6EE093
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjDYKpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbjDYKo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:44:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11hn2229.outbound.protection.outlook.com [52.100.172.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2A7CC1C;
        Tue, 25 Apr 2023 03:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2XBGsWIa7NuOq3IDpApmbHqN77v3p3fgUHYUHZwhxvnP3Hpo6EM0rwl5fPr4bM/gD+Xu9fEaFM0LIug7lV+DF1Hlb4z9JZj9p1pROBJJpDWE81zf/vpBl+8L5Do17OaNwAq3PPxYVFDK91bWAhOtFzERpijEhZAuqszI3XR2cP38/2kCQBBwAFyn1YRdzkylYxm0jK+h/5+wFCSg3mhYlasXGSt2Ld/TYnElHbAcS8pCX0+LDRMEA7wsTdhWf6QMGAnJVPgBRdHObhEHZMpKx4LDFhTimaBfPnkx0wlsACISclSSzRMCGvLBYb4diXZRKG2eyt84SjhcnPQd6zdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXbmmLYU9/RG4+uaGDG8Iuw05onnEm/pyS7/viwAhqI=;
 b=bzZIXYFG+Ozw492n4g0BIfsv9SmXuOhlAv5nY/q/P+9qHygXdN3L1Zq+/aUL1+MuWGCbCnqAawcqqH0y+rRgFibDYDcdXbU7SGlYSB8y0oaC4hOe34QZ2yFkrrGdmVOlGxTbLYxQ9A/aD67X7o8aqdcLMesmfpjYcmAY2N/3m8HwL5olGlOLq+h+uobYWfiF8jccQT3uuVjuPMCWlXkRR+sVjWmUGChZvw0FsbL30q2Gh0dL8CBrNaFjx8qVAWiR/MGc8ksyhfi9jt/b8wCPdUPf2iCm4+3jnB3iWN9DnHNPdzzVdT1ZGNGUZ2Cjtba+h1mGXd9Qa7XNP8rn30rUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXbmmLYU9/RG4+uaGDG8Iuw05onnEm/pyS7/viwAhqI=;
 b=laUiUbmbT1pM1UxSjiqtlTnP0eZS25+MYQKz7WkDA5lSIWx9JQB662GGd456QnuE6F2Au0VqzlP5T2Rg8yIsJgiKf8aZxw0CPDtKgkEdfdiNTnkTclF3GYGNZmHvkRe9/PaZd7ptOTFJjGCtH1yh6WeRGwwMd6qlbA0B/ytu/iENwhcyUghp552aJDk4Dt6I2AiHraV1VP969NdYNbGr0bW+l3kyM/mfzN7IWWa1OlJkYHHDhHdYviMnrAVaupf+3tWXvuZQ1GJkIjgo+9FEGJzVFJRrlQ58WOGYKrl2Y7N77zNhDuJn/m7KA5FHWrwAJP0AgrAQe5++8E1NiJgivg==
Received: from DS7PR03CA0229.namprd03.prod.outlook.com (2603:10b6:5:3ba::24)
 by SA0PR12MB4527.namprd12.prod.outlook.com (2603:10b6:806:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 10:44:56 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::18) by DS7PR03CA0229.outlook.office365.com
 (2603:10b6:5:3ba::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
 Transport; Tue, 25 Apr 2023 10:44:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 10:44:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Apr 2023
 03:44:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 25 Apr 2023 03:44:44 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 25 Apr 2023 03:44:44 -0700
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
Subject: Re: [PATCH 6.2 000/110] 6.2.13-rc1 review
In-Reply-To: <20230424131136.142490414@linuxfoundation.org>
References: <20230424131136.142490414@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <12719e06-c983-458c-b9db-ed87336c7c39@drhqmail203.nvidia.com>
Date:   Tue, 25 Apr 2023 03:44:44 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|SA0PR12MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: ee19cc09-6128-49fd-4ec0-08db457a1bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIh5pCdKHZFo8BKfSPu8SpllDJfC6kfdf1EXTLBH6V0oa5OBpIJmGBlY5XefWqJ3zC2roOCmG82lEGMy21Gj6ip+ADtzl6k9csLLgDxJajYuMrL+cRXdseC5KVA6cD7ixP0cE82PLEjGk84dQTl0RzvNX0RcpUyQuAVpZ/9MAwAyK+/v3KquHJ54w5yLvtdWDjBzIvfKs4ticg4NOui1E9MUhSXZ71bKxZXvhB9WJcXkjJa8919Cg00opqrpDbxHedT0BQkyK2Grm5Q7NBtJNQMl2b+C5r/XR6AptJsjkhzKNv3pFz68kKG6c5OHsPPKgvySPnsqohpCTQh5qEUaj3Zjm6ULXqj9UX6xE/XBTPUySA5xpr/EkUWM0DRwfnqxa4muR4pm/fGh4BYooFa3s4igX8YryhWfjzTWYZlGy0cCRq7E0GGWhMJRzb1jiuXGaR1i7sUoWqW56I34UMkSyVcUaPQcPnepj2rzOMLHa8OEl4R8pbcnXASoCI0RafVqKvMG2JsRclKeHeghPWYso675QT3UqD5nq6LLDWGZpJf0a0Qa6uCWx4qLlsia9ELFWMLNkRHACnK1LVQSRHA6zye9z6tvtbm2Trj51a7xci4v8zp+DhtH3fbmHi+6tXp8GRouHpTKVw8VBYfY9lsAaiIVgY0XJ/h3FXbjwGLqSavhjpdxPdBmQASqfbp6zSZg6eSqNzFoI8l/uqzaOfvCahrCVMG4DyBAECITh7OgSuTpV5lcvhGnoj4mU2IpeLDyR267YWD5X76QmGSccrPb7RZ7vF+ogCbLJwBvbUP9Kl/DUSjjs+d94/f15Zwer0ox
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(5400799015)(40470700004)(36840700001)(46966006)(70206006)(70586007)(82740400003)(2906002)(36860700001)(40480700001)(26005)(82310400005)(316002)(4326008)(6916009)(7416002)(47076005)(7636003)(426003)(356005)(336012)(8676002)(41300700001)(5660300002)(8936002)(31686004)(54906003)(86362001)(40460700003)(478600001)(31696002)(186003)(34020700004)(966005)(12100799030);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 10:44:55.7032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee19cc09-6128-49fd-4ec0-08db457a1bd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4527
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 15:16:22 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.13 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Apr 2023 13:11:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.13-rc1.gz
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

Linux version:	6.2.13-rc1-g9e5d20c13940
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
