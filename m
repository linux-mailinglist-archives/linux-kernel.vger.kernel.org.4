Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD341611035
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiJ1L6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ1L6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:58:43 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2065.outbound.protection.outlook.com [40.107.212.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108781D2F6A;
        Fri, 28 Oct 2022 04:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0+99VnBCO5zUYNF7w8dLHbOisLUs7S/YswOJLK7tZHdSzqYrI96Z5rBvVYCWl2zsjsM3BcER7lprAWX2AtucDeZE0Mz4ZnkB5/68NvyNDsqRAsohmZdDS9Doe2xqY4VAzBEIxN/QLbw6L9HWIaIv5HuLfxW0n0rmteGCD96cNl9R6ZFdLsgy6j/ZPPVc+uXxm0X3cIoZOOfu2PuhEHBVWKoHwJM1VqUpTrHYiyM/DqGhNhTg4vebKVM4FubO7CQqT1K0JotL8Q2fo15nTxMURWHsr6KB1TmvUMjbiAfEHGc6nvxtk5OkxMRawPLbuwN4AMbXzzIX912VxaO0Wring==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDXN3snq1UMXq/WGhIBBNNNj/aMuQwM1Wq9ZXRFgFnc=;
 b=m/q+2/g+mgMpeY23xZSBCvSDMDiuIIOdIWN6SxQACZW/1XdFQCJry6uIU1aOXPbvRBlMe7qC/KdUF89b1p6nC7wXRQQOdaaFe+VD+FvifVIQ5nQpHWjMkCcxVQBi5tnc3uu3zZF37XjmJEM9yUmWFXYvrMyvpzH7Mtor333T+NwQ7TffjjSmqM8FXRmd7g/ryIWfSnTbBtslYnn+ZS8a9wMlppDwhjSjqjyNkhbizfnbUCtEaX+EnNBWkjicIvdRkxh3LLR0cQsC9FpabduuppnA7K6ln5vr1G1pYnewxbHVmysDtc7Y8plCgVGD1PIGuLkLU6st+C1IANtU3hZ1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDXN3snq1UMXq/WGhIBBNNNj/aMuQwM1Wq9ZXRFgFnc=;
 b=uWnjrCeS3Lpl/4nJNMMeqwsVlKxhDatsXdS8OFtzy3jC20N3PGy2A35aykxvnePvzUXJdSs4jXzbMAzQWrbJcJOwQEOMcUdLiueQfyAycYEXeLkw5UmHJMgEggXXx0Im/WI8euXVTiiiw0MsLFyP6WSRffh5OITY5aGn4YLZSQJI66rfg8pK16xicpadCPPhvYllwSFos7jLwX/VkrYd9liAQV8W2mlaH+Ntj/FoHMH7Vv6/MIa1lmchTxquEzrGP+9Mm2TX4Ts8cqU0ntMJBzmTHjJo8O0e+xllqmrUFWlEP8JvJvg2bux5CWg9DcBVJAetoAXe86wBO3WMqrZs7Q==
Received: from BN0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:408:e6::21)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 11:58:40 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::cb) by BN0PR03CA0016.outlook.office365.com
 (2603:10b6:408:e6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Fri, 28 Oct 2022 11:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 11:58:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 28 Oct
 2022 04:58:38 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 28 Oct 2022 04:58:38 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Fri, 28 Oct 2022 04:58:38 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.10 00/79] 5.10.151-rc1 review
In-Reply-To: <20221027165054.270676357@linuxfoundation.org>
References: <20221027165054.270676357@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <be0bc713-2d30-4e1b-9ca9-c79385c5bbb8@drhqmail202.nvidia.com>
Date:   Fri, 28 Oct 2022 04:58:38 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT052:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bfdad5-cb8d-409d-245f-08dab8dbc097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPuR0GzPTzURvoScSUqY6Y4cYcEq4bibpoOCSEZI+55njdDJoYSUQf8zkptcKDY+CJBGxiuE5h6Iu6t0UuPpwCcgp9lDj5cv7zYG7YJnD2LAALzj20eACpugvDVXD7l3KB1WLc60sRn7MuKLzR0twBH44ua0XZJFEV42ivSajJKq53JAt62Zs0k5I3zPoyaaBJdQaS3biWnnloNgRcMgF5NmonohgYrjpOjSr+RdBUiYu7D2jznNvlWPuhNlTNr0uBf1hz38XxzhJdjWnlgF70THvn3jDqF3my+n32GR9zlL91wbVxcQ/dYEC9eYBimOdHkpA2gdFr8eNiWQOlFM7TCMqrLiTXciKqq3uVSsQ35A7D6g2TdEgBoLY85jprCc9shbJmEUb9dP5VGBnt45FFwPlRNcRb/Q9ifW25bGBQGK76H9Qo5/2up5EPTfjzM70KGSeofE2ZzuTltQS9F7AvqK/LpVLtxghTElSbrIznKbxbwPdAHp4dXJauwfCYakb85TwATu0cyQY61dJvUQi9ZGfopzkkSY8daSvwLIrBbFziPK6ugIbtA7eMLxlno63c4R6Y8vd7MnOP5ilydSV9tkESg+GzHqta0UB39uPtn6sFYsszYtDY5Uww3ZFQatW8KuFBGMhbeyRoyfM7EVZvK7lR0kjfTd0FqAHlRo4y/Kb1cdei1NcSYhTnHxMvdO2KPVs+9qkjAVV1jiKL7LALZebbVF+rtrkZmk6535VYhGpGaF9gmfwo/EJfMTNYR3af1Fn8eF+7dusZfStbtiuuspMrOTNroNpNo9dpbsQ5PG6eozEFGefDkQu7Frz7+e2FHVma0G7fwyGsB8gdjsNduCjvyT0HBQVCztunHOv4A=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(356005)(316002)(7636003)(478600001)(70206006)(6916009)(8676002)(40460700003)(7416002)(70586007)(31696002)(40480700001)(5660300002)(54906003)(966005)(41300700001)(2906002)(4326008)(8936002)(336012)(82740400003)(426003)(36860700001)(31686004)(47076005)(186003)(26005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 11:58:39.2950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bfdad5-cb8d-409d-245f-08dab8dbc097
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2022 18:55:10 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.151 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Oct 2022 16:50:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.151-rc1.gz
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

Linux version:	5.10.151-rc1-gaa25703d0a7c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
