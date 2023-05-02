Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBDB6F482B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjEBQS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjEBQSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:18:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C8E2729;
        Tue,  2 May 2023 09:18:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbCG42J4wJBDWoG2jt3OUDMSUcLFnZ4Vz6yVn/C9AsYKrrrVzlI+6vlP41Izr2GJ2gtMmDLRkQ0Ume8HQ9Gj3hbt5dpeUwfAKyxxPtyZgiyDJJ55N+YB+b+s+2sthsy/ESxuuVWQLn5CYgAs7delJUHlybnzbtued1UZiHU3Gls86sRpOlLP2VJI7LnQ041aHzPWrDxqayZ1RglODs9NWoRyXdApQNTLcRnfcF1EF7+Tf5TBGVll8+0icCnYApa/Cv0TKPsszWWfwGYbBFUqi4ejDJEcRlMyOUuaMLRl+MaH1YnTv1z8LEhFftANzkNSTpIK7N7L3FUe9BqX/Pv0ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmN+O/MMxnIPRREcZP1DshVr4Mf/RyAyABZGRu7hras=;
 b=nxkeQDRC/Z8mZrfqXrlvvspVdncm1+/5gVsjOeVNZVDB0hcfxYI5GQwCgeY4qdyZjQnDF1pR6V1SWOmZUNn2APJM1XNgz4KerPF8bIN6Tp4NauT1koBapyXNc7BBzD1DlDaMMR0DocyschLprHiLATfHDKWQUGSBWGn9mClQlUSlJX7hDfcm8HKZCxtyaNCNCsDPxSgpCgQnkB6deG3IYTv9e5w9vqkUmuDWsAqzdq67HOBscc57RW6ofHZ6+PGb39L04zdv/HCoN28anla3lWW8A9BPP98RJAZKSZy0O1F8GcweZC0wd9rxmBuxvplptY8Vs5Tur+SwzrvI7BRB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmN+O/MMxnIPRREcZP1DshVr4Mf/RyAyABZGRu7hras=;
 b=kWNC14wmDiIU1hgJfB56fdc3FnSvohhfuMgOMG9k/dn24dfgWDZtb/YQv0dOwFPk+BYvUkvtuBh6zk71fGA+3AShWlZkYGhQbkk8+8Mp7G/rM7+NeW9JhNOBVkxFmfRbebwuu90xGvD+X7+c81OM9snk0QnlUs1iXDKUUzO0VOpMS3aZ5x3P9hviDDaiN7NuAcwgnIibDRw6i4rSVi6uqNr0Gte3oyhz3xKX26cQi1bh4IUMGAeLCj7sTAcs6rary8fRm+7ykdEZz6pH9N4LUNmvT9nUhKKIdmG2kY2WmkwOULkWrj/49+EdRQi2BdCOdsifM84uGMBnkczQbaRSjA==
Received: from DS7PR03CA0120.namprd03.prod.outlook.com (2603:10b6:5:3b7::35)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 16:18:38 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::83) by DS7PR03CA0120.outlook.office365.com
 (2603:10b6:5:3b7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 16:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 16:18:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 2 May 2023
 09:18:28 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 2 May 2023
 09:18:27 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 2 May 2023 09:18:27 -0700
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
Subject: Re: [PATCH 6.3 00/11] 6.3.1-rc1 review
In-Reply-To: <20230428112039.886496777@linuxfoundation.org>
References: <20230428112039.886496777@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <801db81f-0bdf-48fa-91eb-ced63f922352@rnnvmail205.nvidia.com>
Date:   Tue, 2 May 2023 09:18:27 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: bc964329-af43-4108-ecc2-08db4b28e33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+jSsEALe2UADJLxCMjxOePaXmqBD1nmhf7QQrRQWL4oGi5Q217nmkX46mInYyS2JproGLA+5+WmPgd98DPT706QmTWBRq3A3rtM6r+X2o0PG2Wqjq/Ad8rXSvMIayTiIytBSqFO+4L3NX9ZzQjidLXTOjHJrw9aJMZl5NvFy5qM3Q1geKBwqLaMGfCCwO6Stz2VfkuYhB4fw+zoAqlXCLRRsE9GNtA/9L0qeKsmjaW5Ul8LBNK+658v497ARS7zX5ye57tvSQVeInsyfWmv/1oEf+pjoN2zw/T4s07ayWCqsHbuccd9ggTDwIPbbtNqE9h/bvqhUNBQXuNfMmp6W9BhQIKj8ORbSIUqV5zA0B26DEPNvJgR9uEAU/0WU1z7XeFE0R7uSOOrYHL/zHC1Fb2Gb+PLA1w73g9ViGdiI9YZRvuqwmoHiTZj+on3sgtvXjXr06jFJFb7/wAlZE2tnO8QPfVf/yxDCNKvua1eP550RjjIw12dMDH76V3ybrjRAlxVi0ZrnNkSap2K4ob+CS6fsycgRySk1mZhyxvZpfDRAPIRdWrHVOap9fGeCI1z4KniRvvxtajd1M2lyQ8kopzxrCvoRkU0N5zlBXEMbD252ZPKCdXVCQfcGNdhbs/frNc/GCSIpnLRPA7SRJWq3qQQyOr2EH2jlPQS03pu6phPJec0woaGub4vk/j+hkrI3u6GFJEFU2GGoFJM3lsvYSaIGks1w8ADxnjLQyuvzmi2555sChqG+qOHDJlr2IU0
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(316002)(6916009)(4326008)(2906002)(31686004)(41300700001)(54906003)(70586007)(966005)(70206006)(336012)(426003)(8936002)(40460700003)(8676002)(36860700001)(7636003)(5660300002)(86362001)(47076005)(7416002)(40480700001)(82310400005)(186003)(478600001)(31696002)(356005)(82740400003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 16:18:38.4690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc964329-af43-4108-ecc2-08db4b28e33c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 13:27:35 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.1 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.3:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.3.1-rc1-gf45bb34ed520
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
