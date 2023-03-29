Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8069B6CD846
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjC2LRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2LRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:17:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6135B40C4;
        Wed, 29 Mar 2023 04:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6xei/chGRmbbPjo8kg2x1xLPnJjAYqVc0CSsH2zbFsUyy7FRA2olZcT248n4da1vj2mXesDR8RnCxrhuT5/hCozpyEbXUnFWydSxZV0oq8kX7kA8QViR1GU4b1OPNcqWqrPU4ZDLgP5m8/8HyyBk8eZSQRq5SbnEdolmq38dfNMb0wENcH9tLITtE57CpXLoP/Sn4ePgg+nWw5n/5WRcAmgjwqomrjeTaSeWRGxuVjUH4QBuq49SvOEdRwz+NsvEmeCzD5Ypf4O49xITRrBkjjILPhh+pvlucxaMbNp/8dX2Y5sINS8fVdr/tx/gFtzq0nqieNtRs6eMZAav9oQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQj/ijxN/gUdMvQXEgXZ2b3TIauF5H+VQuT0pKIUAh4=;
 b=VZuIc3w2xl4TrEpjtlFks1af1pb4qyeCPpWCblo14KiTOZnziYtLtftbEq7NgmWNfKUCSI21VmvzTeQR1Er3fFTwgIgx1/iTOqisHRm0ruSM5pFras0RP2D8Lnp0VaLo3d83+HzJQODhwnawtSA2cvhQH42Zd3VxLMNE0WYnL3oAaOOO0SCxBdlo00LQPJCO9yhUj7zldbadE13T33yO7ZvRed7EafyPFayRm6oEkUSKJjKWxS15jagz1pfGi9TT1cp9bTWYcXP44utxN0W4FIm/cnaJF5Q57hL7libBJ0ahG++bUyqzLhre+v5VYI4Qn1dRzC6QniLsZW6VDfIz4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQj/ijxN/gUdMvQXEgXZ2b3TIauF5H+VQuT0pKIUAh4=;
 b=XLkgNmE+KqS/9ZCglWPSfWhnUnSHPM+gfItSRBFzLf6uVBIA1x/+t2g/sJfEZXdn4hYFS/1tiX86JxReZgziho9qkTtPjiajNa4/XY4glWuCPdDoyarfvvEMRvJlQN3UT7vvqruWYoq0vS5E79+RfBdildFA3DQR/LAWkwfWFtIjzoztYkJbOXlOBZf0CH3JfCZwsbsTet1K+/ZqUTjXtvjtejjml4YkKwaOg5JkeEY+F6lIX8cVhz9e8mZMEFy4Dzpx8Dq/aQSMesp8iPkCb9DayzA0qfDMmB9U3jaTJ3X/Y8fZ6Kms3cZ/jRcrSS0FPBPZCimaAAjMJo9pItMq3Q==
Received: from MW4PR03CA0113.namprd03.prod.outlook.com (2603:10b6:303:b7::28)
 by PH7PR12MB7185.namprd12.prod.outlook.com (2603:10b6:510:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 11:17:42 +0000
Received: from CO1PEPF00001A5E.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::57) by MW4PR03CA0113.outlook.office365.com
 (2603:10b6:303:b7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 11:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00001A5E.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 11:17:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 04:17:25 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 04:17:25 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 29 Mar 2023 04:17:25 -0700
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
Subject: Re: [PATCH 5.15 000/146] 5.15.105-rc1 review
In-Reply-To: <20230328142602.660084725@linuxfoundation.org>
References: <20230328142602.660084725@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <6ea2a4d4-6c7b-4add-b196-3a4f778e6b7a@rnnvmail202.nvidia.com>
Date:   Wed, 29 Mar 2023 04:17:25 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5E:EE_|PH7PR12MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: c1cdb9e7-17be-4d6e-2b85-08db304736bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: inoFP3Ikf80KpAQzvqd0KqrWIQ3evZOgLYJPeN0iOUQB/UisRETRrLXy1OBTvWO84Bdy8OEthFDROoS/HIBmPF3tPtLe0QTy0UzNL1c71inlO94X+QEFWqfUCV0CdG3HFuqpjou0sHC/3YbhGYW0o8AsrKYUEbN/xQTjLd50cEFzP0XuVu/3InLTliI2f9aTjwT3h0oJ1MbTH49pHx7IWGRPHTSJIpACiN7s0s4AADrDY5l9OIMc75Ahzrwo5mgv+w5iO0jO56EE1epK+tiLEZiWFdIvl0xvYI9IOe3oX9e5IJeNRWyYZlh9zcP5u904TTlA5Ta2l8LRURAABQ2jpM5rf4aYthOWI2hx34pMAjuruSriAPLQdewu1dIjXQYYiw9FYNcKJdv/ZkHGX3Kl1ue/fU3/duSGIhoFHqXW3cRuh6lY79vQpsJcixmCpiGaqFuO6SQ15t/QNpIzgDcn+KrxisbA1XpM1fDHZDVJf1cmUIpOtoPXYGaplgtF+yQuoawdpoXg7x5ldOPP+e8LQOfzvsuuUfTwD5s/wBOadc9dSQ6UmNXaEGn1sI/EPET1ElU04owxDmT7iucECqwtgt8lsbRiOpf58KFY3hMd1bwdbAC24EVNgUUaHpQJ9DsOhUN4+K86J+9iXJfZYJxjkl5jBdihqrGbV6yze2NfP0NNJng32tWW2luNBIx5YLOZyZqt0Kk1B17BW9ZZTvSggsasEfKLWLfmH9P4h36BCLZ4Dvzuv7PFRssu/+535MpzWzRqzq9SV+JuVUZCDM5Nca56j1Lrlhg+0rkzdrUgNtQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(7416002)(8936002)(5660300002)(82310400005)(40460700003)(47076005)(31696002)(186003)(426003)(336012)(7636003)(41300700001)(70206006)(36860700001)(26005)(82740400003)(356005)(86362001)(4326008)(8676002)(70586007)(40480700001)(6916009)(966005)(316002)(54906003)(478600001)(31686004)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 11:17:42.0804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cdb9e7-17be-4d6e-2b85-08db304736bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7185
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 16:41:29 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.105 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Mar 2023 14:25:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.105-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.105-rc1-gea115396267e
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
