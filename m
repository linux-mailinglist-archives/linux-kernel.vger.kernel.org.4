Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3656D5CB9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjDDKLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjDDKLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:11:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B132D69;
        Tue,  4 Apr 2023 03:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1DL6mQjqQvs7BU1dEzzpJstqtvZE2iJDc7mLazK8Tg8S2AoOHdiplReb94ahejZjn521Nxc6SH5aHxPEmrX6TL3UchzcMqfIVEV9Qq56UsBODmpie4zGjW0WfeTffZMfK8dptLT6zyBUDs1S0S0LYVrXXJKqRUpEQFBN7PPlpSyj/QJ8yrTGVp4vVlimDT5Mu+7JJfnnAQ/VGviRGJpEQMX/V52C6nhepgaOL42kItftBvVXLeMaT2d01oWg6ZDqPzHlxRp+TtEmfNPSmhwAHaPFsGqpIf3QANtnSdkI3ZK55ClFF/rAFLfTOAilY1gffZ81jLYLb+PegmGY/XPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O15livDw9qY1zowlKWAxFbTQvv1Z8GPQKGTriuHPKE=;
 b=Ls+wCFQeSYgWwKc1SYmxuskAF88VlxbW0XY7alh2kVSc9ytJ4/Q4kvoZrtGvRi23HECpzco4AEDYE9J6AXBpMvciVZp2nem1+QYbC8UtUGIbWA6x1lLn/AJNWyRV+jgxuhm1LNSEFHSeKSH8gU6ezyzkZG/F8hWjJNGb1z1mfmPwOpjvNnRMj9dbjlKZJeu+bOBUrjAwEdpJDUOmFY9kh4r0he8xJ/04jWQWtO80Is3llYs2dnoPovE0vfukGLoJeTAgqp+125SaCsaUzaNvENekvMC1FYYEc4k+LYsMGdfSdzL5jicTDIF4EPUlJFk7UuaGZu6CUprAfU5HfVUDEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O15livDw9qY1zowlKWAxFbTQvv1Z8GPQKGTriuHPKE=;
 b=ZFv5AVuey51yK58hqwHPhx678lq9Gr1BGNaGXlLJ8Ah3gDozVsQSpQ+/RaUZsLCUnJ87/mLAjt/juTTVrUUddzLe0/t5j8PYk387ryE8W5Bm+BmTuizisfWR/avcFopQzFVp98iMClzjSaYKu4MF+QovfkLpJSbpdWk0NCPz9d3XTvgogwN5MP9d9ErdDChbnXTNrVqpwogfWlOQDlxul0kKI6fTjIoNB0yzFtTUUqIzdVr40NYbExkkQDPXDEyxPzoXzuiNZ259dYoOmXxYag9DpeXdcPStrQfwnzKWvBw6f712JDbxS0IjI0uvkllyNEa3Nu+zqzRIkug4qd5blg==
Received: from DM6PR18CA0007.namprd18.prod.outlook.com (2603:10b6:5:15b::20)
 by DS0PR12MB7680.namprd12.prod.outlook.com (2603:10b6:8:136::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Tue, 4 Apr
 2023 10:10:56 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::5d) by DM6PR18CA0007.outlook.office365.com
 (2603:10b6:5:15b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.28 via Frontend
 Transport; Tue, 4 Apr 2023 10:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.28 via Frontend Transport; Tue, 4 Apr 2023 10:10:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 4 Apr 2023
 03:10:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 4 Apr 2023
 03:10:42 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 4 Apr 2023 03:10:41 -0700
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
Subject: Re: [PATCH 6.1 000/181] 6.1.23-rc1 review
In-Reply-To: <20230403140415.090615502@linuxfoundation.org>
References: <20230403140415.090615502@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <40fdc1e5-4163-405c-9642-02bd37ce3ea1@rnnvmail205.nvidia.com>
Date:   Tue, 4 Apr 2023 03:10:41 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|DS0PR12MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e302d5-6cae-48ba-939a-08db34f4e1b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JtoZ6R/Nf3yHstYhBgaXCDT7ZTl3iaXR46hnIwTcft9fods83jTvB4JIfPU1k4wU5CmO33VW4lOme+PaOyp7m5TT92atJ1BVpjiOR1KzXHJyhyb9cPpXV5uys1x8WruvDdNIjqvpoIHjNqpybClNn6njmGR9dgplw36yFtcuTBJVus+OMJAdpgCT1K4lYSoIkiIFre/r4rcsNhMLxjOshCTweuyFpkJmLZ2sD/XnRcnyhs6jIfLCq7ibcuAH11oxCTkMF0syVGG0b5Oc0OC6uKKS/8GYSDJmAik3+EcHe64XhfHDKIg0NKsqv4GlL5FPsDeEGtQI6dzf1sFxSyPu3oYav7OVJHLw+hecwlyPFMgpJdYsAZZjNYL+iJWKSs0zt9bX61IiIwEBsV1ZLWGzD73z2eiYawpUasEYrKA5uzy4OovGg9ddRPg663ZLEUwivxlDqlLngGY18uuDohAqtUek7foYkO9B3hePhtXajltNWs1UNXVVjWlmW7ijQ/SIX7kU52zWh2hrDfidvEhawuHWFFdM3mBaWV/FOBf0SDkXal9E3aKiID95Um2EDgE/vK3vLgaahbSfEAl2oFKi+Z7JVEEZTiUePp6VbBxOKrU/2y/mRIjB9P6dOa4eERZY8ayz5z7CpKoAYR1CM+Luj6iaKPRYuwYRmeoI+CokjtzOc/jD2moWm95YJN1sX2vIIRUeTgfj/u5fAnXKfKN7v2XJ9+yXe8C7Mr3wrd+QrUeV3ptD8ZukiVuVdKmJu1pqjdv7+caVbPELcZnYYDOr8ZcAVhfKtqMBqEiL9ryPg8k=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(31696002)(86362001)(2906002)(82310400005)(31686004)(40460700003)(40480700001)(966005)(47076005)(336012)(186003)(26005)(478600001)(70206006)(70586007)(6916009)(36860700001)(4326008)(41300700001)(82740400003)(7416002)(5660300002)(7636003)(356005)(8676002)(316002)(54906003)(426003)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 10:10:56.4998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e302d5-6cae-48ba-939a-08db34f4e1b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7680
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 16:07:15 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.23 release.
> There are 181 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Apr 2023 14:03:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.23-rc1.gz
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

Linux version:	6.1.23-rc1-g01cd0041b7a5
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
