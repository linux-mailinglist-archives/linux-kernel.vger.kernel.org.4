Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345F3736911
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjFTKVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjFTKVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:21:32 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6649A2;
        Tue, 20 Jun 2023 03:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF2dbCU8dUuQLVdgfgLASi5be/1DULs+IidYQ5uzhA/J8y9eAh+vfa64ZIDUYLuM+k22ImZSGXWDa+x3CFSSlDKXCiuU44NeDJUM1GHvOMl7f3UdGQHc1L65fifQ7sc75Hy/Lou+7FpUNRfAqF3qONiPnqXxaHjnciUcNSM7aNpHtmPYNaxyqvlzMQF1iyUoPZP0P9WxJ+hxysCmicVSYGBI2LdmokODI/aBNUN7zqdARyFDPHJNt9wFNgpGgDFW6VTt915OeCMwoQXRDXOw/M4HQNZT+XeIBWK7+iKwNtViuP2ktJlx8mYaZdbrkZDRNr//9cRibv+ZLedFM5UVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQovieMnchCxzlkF9NilQcZI+cmHULQ8/U4iezPECD8=;
 b=TbEaxFbjwlkXE/R80uAgibxGD0a2o5uT67KS/1k8cB9lH+j3t2NJ5qQln8E/ETmpA1QAjUEymsagcG2r6Boz++qrSxpbv8xjvLcOcPYVTj7kBf5cU79bOmZ+KdFZXiYCxsQnrYKlomktW2B6c3L6m+Zri2g1xSaZoapD99sl6vz1PQPygNOdX3Pq5a9ZUOAig89V72Sq9mOcxfJtJ158O1znbbzuNmLp004kA2/CJOf16uUPrJLhW5oyqQDb7moFkeiDxh0tV9XnSbZhC5aBz61ig+yHz/Zeh95xPOiVN0eTU5l5yOltyXgNKOjAmqL9y4DAi3+gasZMut/6uEjqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQovieMnchCxzlkF9NilQcZI+cmHULQ8/U4iezPECD8=;
 b=i2oiAl6e3eBpvx4ZO3W1uPctUzYRLkW8l4L7Dq+DbY3QLsJsUujVde8EWDK8xR4WzzGbNYz6EbZIfZvdlQzRIe9H0PKTsBlMwrBg1iDveqHhDQSChrokAHKF67ufoAJz8fFVT2L6HQZHly0ve69KfJISXhxCIC5jw+4p0gdFfNI625ujvO3OuP5Kt2dnsG8apdqzdRAeabEs4aw2ZBX/jE/KzrXRoJ8zG0gOEbtODtPvUXHsYiAGVkbAT0AKUXJWcpjIwVbQ4+riYJ8Z+8AG+S3wz+coBj2OK6eZRdTi9m7euviONfIENO/aKDTh/q2mP56Xj6koq4l6RP98qk4xkw==
Received: from MW4PR03CA0196.namprd03.prod.outlook.com (2603:10b6:303:b8::21)
 by BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 10:21:29 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::a5) by MW4PR03CA0196.outlook.office365.com
 (2603:10b6:303:b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 10:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 10:21:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 20 Jun 2023
 03:21:17 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 20 Jun
 2023 03:21:17 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 20 Jun 2023 03:21:17 -0700
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
Subject: Re: [PATCH 5.10 00/89] 5.10.185-rc1 review
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <4206e514-3a83-473f-987a-e5a7b8ab22d4@rnnvmail201.nvidia.com>
Date:   Tue, 20 Jun 2023 03:21:17 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|BL1PR12MB5032:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eefd1b5-8eb2-454e-1366-08db71781c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pG1oFIOLe2mp3Wowv5YXrw7SMCk8AG+oVC55MqrL0OT/TB1R/GsfydyIcwXb3/w5kz+Jx9q1w423j8rz2yww4+O6a0ZdaAjK/vOGGdErazkIxZc8AJwKVUe+VIs2kBwE6RgdMI/RniazoxjF+hZzRCq6SJZcI3zjWYNH6EB5twvq+CF1L3/qUFMwN+ooc04hM7WucP8tw65MijJ0ELo63mYgDyK8/2MybCqX0tBtmMVtuGoCiUspq8+LwonWErav8q7GRlwHVULk/eBIXg/kr3QI900B5nbnpvuON/hf+isrVdImbCB0S0kxfp5w07D0168bQKgmSvHFWrXdLJ0HFbny9EVkPRdG3cRYb7gCqW/3eHKWTTWFz2MHgiF1LWr/EhUtRu53qTd7jSpIFpIeAgljwO66qEFKWnS5zIqgZ1vD8ZPQQmONd6p0WQI3qABS0JXTS2XFRjHhLuAgz4gQ8r8rwGidfzQ0Ts/19f3mUpxgjzK7PLngynopLnWhTb6d8XUSYhK0i+XC4Z+YU2hYJxGjgkffBiG2tDAMf+UvpYhZMDwSDc+DHP155rtT0UK96mY+PH5Jptb355ckLnJw82pGsTtUlwvZ4gX120v9GfrQ8bnTILbDsv8PU1wPIYGIV7bmjvM3MGYEv5FQh5nSSFmnRff6k6PFaEb/qZ4d2LHjyg8ncwEF56OyXJOqpq4Qn0mZuuqh4ei5b6huoktu2s3HzWuSCxIZE17CKBNr0rzn6dze6GuXQO/BpuKlOtcSrAZ1HtYevyvyPa73llvW2vuB7crH9LsrkWSEvNpXT1k=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(5660300002)(7416002)(2906002)(40480700001)(82310400005)(8676002)(8936002)(7636003)(356005)(426003)(47076005)(36860700001)(31696002)(86362001)(82740400003)(31686004)(6916009)(4326008)(966005)(70586007)(478600001)(70206006)(54906003)(186003)(26005)(336012)(41300700001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 10:21:28.8550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eefd1b5-8eb2-454e-1366-08db71781c6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5032
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

On Mon, 19 Jun 2023 12:29:48 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.185 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.185-rc1.gz
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
    67 tests:	67 pass, 0 fail

Linux version:	5.10.185-rc1-g8ce687c6d277
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
