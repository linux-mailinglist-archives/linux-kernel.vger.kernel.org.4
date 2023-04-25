Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDAD6EE09C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjDYKrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDYKrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:47:18 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02hn2030d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::30d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82082CC15;
        Tue, 25 Apr 2023 03:46:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nltG9UufkUYigJ14ti7fLxDkkmtZLEdZ4BnLuXh2JRAEJL3fuS/psU/7TOsic2L0I2EtqSejEbC0rTiXyyQ4clkRTESO7OdIUt4zNX1CWmnuSfvHNF3M9NBa9l8Nj3lmr/6KVyEt4Ts3eUIEKDAoyuVrXSkHeSPiUx+ZBEPbabMSPzYe5effs7xT3lsJGBuf17lyMPYt38tXEVllZ1AnmDJM/2JWjimiwWTkYjSXOXc4aYtODz3k88/ZuvosiW5z6tShdydOvKbsPnt9uRH9ZPXkShC/7dlbevOkCzmbuc3YeXDxMJk3O01sUue3K+q/KyplOFWTbMrLJiRevotsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXbmmLYU9/RG4+uaGDG8Iuw05onnEm/pyS7/viwAhqI=;
 b=WRi/S2Fx6wqydtuUq7occf7+tFc2/nblrAfyQXYrAXgVS5NmYPSxxpmHXabCnpu+1cE6ideg0vjnDE9K+lPHmCIAl2uP/k7wAEhkg2uOYmiYMEpHRhmKyznFW98SCKtt8Q0KzwFrxxH3d/YLJ09VmOdsHFvVDfH1al/CXbvQjDzry2KDSxLOmQ10yPmd+lOvmkBr1kGu6QXb/dhzjS3VV3yCvtzTopiDKnjFz31tI3FR/jfKRnlZWHVdJL19qFdVV5jGf9ntjLN75qBIWA6aecqoSZkzMHzgUdbn+6GYY7HNNE+k4PoFnp2FBeTQBx8Fk8nnyxJvjcB0J5t9/kgOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXbmmLYU9/RG4+uaGDG8Iuw05onnEm/pyS7/viwAhqI=;
 b=ESGBV1TD7dZOJrCD41Nv/z92ueOTN/s4OyBIjM4lby87UvtpYgcyf10oFXT+JhRGQFSmVl95fTshDaovX/r0KlvZnpQC4OxYVBCAeiBsjykTiktmPo0JJez4OkaVeQhZmgwaIAKdXVliNBRRbuTB9fghLNH2vFoYzarlvk9m7JNwmMDiu/z47/y8S4K1neQwxLr8nDG3/Wrr+d4UDwwNOcFYTfTlWB9GbNqRUvXJIzF0oQTxLOiEM0JEf5fsMNczEkwqORbuP6I5KZWx1P3vCbqDmFymb+n8En+nWx2clVh1fEAqk3zQJ6j8AB1WmZ5sfcBhw15GdB8QSzqAvpRfTw==
Received: from DM6PR11CA0020.namprd11.prod.outlook.com (2603:10b6:5:190::33)
 by SJ2PR12MB8061.namprd12.prod.outlook.com (2603:10b6:a03:4cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Tue, 25 Apr
 2023 10:45:45 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::13) by DM6PR11CA0020.outlook.office365.com
 (2603:10b6:5:190::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
 Transport; Tue, 25 Apr 2023 10:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 10:45:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Apr 2023
 03:45:33 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 25 Apr 2023 03:45:33 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 25 Apr 2023 03:45:33 -0700
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
Message-ID: <3f50f4a4-2c33-468f-8703-b84e539bfca4@drhqmail202.nvidia.com>
Date:   Tue, 25 Apr 2023 03:45:33 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|SJ2PR12MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b43022-1587-4b85-a720-08db457a3965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Yz4h6v4SEY2E0FW4KBCoTDme8GQSic29t9DtWPipEveDsMcZ7TFYTnsF7L1BJBYdQ920UvxGgzuEnFLhl8QA6cX/GrjGODImAEOduQ05s47x2dsW8iHltggytccr4T0/Hc2z6qMq1bd7HsVGGeUoUlj1XvX13CaEJ+azmqVHxsKbw1WDu3honYVUwmlFuYWWmVmslhR+plxuuxPC3rS9gLGoHyu6v/FsvwbnU804J2HOvz39umiLdAnihRzOcw3KFfbp/MXR4h7L8w6GMEUec5deVDFdWbqyWJYCKBUw/PzxGzcL7eTC/pkBARdEWFL/0V4TbrSpeNY9q9A6KVtwk9aXvUMipUWXGWvKpF4nHwwe7q4f58QB6srpXs4Z+aPJfoz66EpEz0LdFVgghVA2n318iXG6nu32BupB7h1b748rOy2ljhKvFFxTDKIu4iJtVvwqLGL7XHFJ8ekZI7uOYR/hvCZqFfAnOxpya1KjTOHA3N5AVO4B0kkOiCDNgiSDJtn3nkelaXBDM5nc+NTKRY8iRO3lojEm5irD35AV9ZiJ/484WyJyQk2tz4kWbMCF2eACAG7IM53WH18TDcn07It8ww0liYg3UgAqTNFBINidhUdCOeOab3icyfZceanajXE+DASO8bS+piQk0egtJM7lRtPb02N9/kLiHQXUvR5TFI8ktlY5EeTGkD2XVim3LrDoV3zUHlKocLp7Nc95Sw9dagQq6ZDayNE/Q6AcGTxLjj+lUJAleqX96DF+M+r/C7IV0HnJ+yZKojuyj6cG1DXfGj4dKXh+OILmlTEW8xJqmqZCTURi21sf76FHkBF
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(5400799015)(451199021)(40470700004)(36840700001)(46966006)(34020700004)(54906003)(478600001)(47076005)(31686004)(36860700001)(31696002)(40480700001)(966005)(26005)(336012)(70586007)(6916009)(70206006)(7636003)(41300700001)(356005)(4326008)(426003)(316002)(82740400003)(186003)(7416002)(5660300002)(8676002)(40460700003)(8936002)(2906002)(86362001)(82310400005)(12100799030);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 10:45:45.3097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b43022-1587-4b85-a720-08db457a3965
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8061
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
