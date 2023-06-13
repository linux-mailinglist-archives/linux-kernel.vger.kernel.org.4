Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A36E72DCB8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241563AbjFMIjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbjFMIiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:38:55 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8E5170C;
        Tue, 13 Jun 2023 01:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwzex7isxelyFShqx7Gj8SQY32eYtwOW68EfwnrW9q0JzqSjtXDO6dJmsv/SLow0EQJ4ad37WlIsAaV5FJ/UEkFHGopf50CRVCKUZQNzLE7HY1lioYhDAlWi3uT7adg0efNFYNtcAHnCr4uNS7DKERk8zu3VMnIjAtoyeN71smVp1bhogTbI5f5enCEYa5dcXa8FOOfRfSk+seA3jx012BwGnx6s3flS2Zj/KgxTxR/H7Ot6Z/YzDUPlBwR0r/ERWGud4OnjY1NIFS0sQSh3qFz66iPi9ZkDlM2ck4W6QvE6fkmXDnGDAZT0K3YbgOG0Wb91yHmMDoLalQpK2UnIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPfpHQDksT7GM6m3oC8BGXydePphdjm5uBabxFpNFUI=;
 b=EvQZSjNsBdvQIocp2ic8EbifRthYUj29Cwyxe/ij4OeE5AyjYvGk5rovcleOQ5wSzn8m0WzFtnBO8kfSrx4Pz8Y9P/nHa7Ldc71AJJCeMx+/oU86o1KiluD00WIDXSZSqFKWozhguhjOqG5jpqpOSVm1Z801WPQ79hrC5nY3JQa6tB8z3AOwRXwV+jkY2OrHMY/KvJMaA6fszINj6xqa3ZC5glK2ZeTD/Xc5Oup7zMgZuhEzGHPAxPTIQBnu+md0oUVXZV3x0Q+GjLU1ODF6xyAntRX6/JnQx01xH5o3JGhZVrnJjZhyQtyBt87JQNgd4wFHghml8fnR+C6w2auLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPfpHQDksT7GM6m3oC8BGXydePphdjm5uBabxFpNFUI=;
 b=nxCYvISH2BeaYNTjw9+qU4f11hfG2/fB4Ob7wUJU/a8sAP0X6osLa15azaAHvQndaYs3KaHP6LnhV17dGyeFPt/xpfzHfXdM5IfSgCGcXlVcIqDpmbajdq4RnV+InQ4gWgfv3ODmDhDKO/2iSh0GHalbf0yOhQ1I42t0HKXZ7/ixsE728XJcFCOWIHdTpdCr7uUCzqohjv9eK7zzFwzcmIqlFl7abwhs/dqHkS/cPPEN3htRmun/YIF3fnqzmhZQqhCG8drQ4aTmaGoN2pTOcNzYB2oOyk5cDpKt9oDOyZPvvxFkQ3nwFzZjkUOgXKd04ZZyfDTVebQ/2QUjNVNbqQ==
Received: from BN7PR06CA0071.namprd06.prod.outlook.com (2603:10b6:408:34::48)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 08:38:52 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::2) by BN7PR06CA0071.outlook.office365.com
 (2603:10b6:408:34::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Tue, 13 Jun 2023 08:38:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 08:38:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 13 Jun 2023
 01:38:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 13 Jun 2023 01:38:40 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 13 Jun 2023 01:38:40 -0700
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
Subject: Re: [PATCH 5.10 00/68] 5.10.184-rc1 review
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
References: <20230612101658.437327280@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <300b79c4-8713-4c50-a468-302ee75a2518@drhqmail203.nvidia.com>
Date:   Tue, 13 Jun 2023 01:38:40 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6dd222-2b55-4456-7796-08db6be99e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqolu8pz7hbew5cPj3Yrz1mqQnqJvA8pulDyWt1myhwgKBYbsLMXV4DV5fjIvHi5+yrjkxXrjO+NRDIdERMj9JBQ8iJZnqrEHXmSNRrcPDXAB5nQezqBDTZjqXLF/UbptnATZbbXU7luXTHD28ZuQYmXPmA43Taet1F17eyEupAkZlK0WxYg8FdKSJvBRTI8BAg+bUEuhmpiioCZKvf441dR8KEYCKP+PF1MVrF2E0mb/29R8D4ogZPrAFCtKEaQE+HJWYvx1DibBnW6t3ksc+YkgdQZU99+fuZT+Mv1sERKnFBXSCJRH1xmmbB2aSskuV7tErsYIH4yZ6bpYzjDTWxA9G6xVIIjwdQuCGRiCW2JFlWGkIqrtykuQO6YNnG80g5BX7YWwoJfJw+pE3zBJ0eCQJ9ixDtgsk4h40kAvu2uzjwznmbQ7WaK0Vd5qgQZzlfmnpr75T3dlG7qgOWc3Fn4pvIgDJ4+3ieiIk04F1QXVxunTwnBldx4L75m41PUxvjl5ifFJXlWx5XOV9I+nO7PLj3c38PTFM7UHnr6dAsCtdqluLAO60La4U6aa1EwFw6IQaPx4ugdl01nKqs6KVfndsekJHnkMIN2VV1oMgzJsBlw7gfLjJLjDoWkpDIAeIzsL+/65xTSbap4Y6wS3I3xLyPD6AcsnaeMevvjSJlq64ubcjU3LX6IemMlpbf5ZH7JmVCliTRgWmUKt4wFkMpC3BtC6FwRv8wlfBKT9BaQQosne55cGIfxZ/KuDYV5Zsc6rn5td0KeG3LJXFaiSOyugaFgf73NTOfKo03oUes=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(966005)(40480700001)(47076005)(426003)(336012)(31696002)(82310400005)(86362001)(7636003)(82740400003)(26005)(356005)(36860700001)(186003)(2906002)(5660300002)(54906003)(8936002)(7416002)(8676002)(316002)(41300700001)(31686004)(6916009)(4326008)(70206006)(70586007)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 08:38:52.5758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6dd222-2b55-4456-7796-08db6be99e2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
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

On Mon, 12 Jun 2023 12:25:52 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.184 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.184-rc1.gz
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

Linux version:	5.10.184-rc1-g32cae866b182
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
