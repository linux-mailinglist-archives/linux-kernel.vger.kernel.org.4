Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6487773691F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjFTKXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjFTKWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:22:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A141732;
        Tue, 20 Jun 2023 03:22:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hpfmm6gjTKnaYOmByXzUK9ucTwwycbg8rpTyS4u0pRo4538jmUS+nr8qqC8EqMmpaC6daDwD5piilerybRXszc2ITSWuXLS7FfSz0gHvfqz9+dnbLeiEwyywscmacJv6k+KLtLYR4Hzg2FHrIQoKG9MtlLomweQAMHAjN3nvEZItVWjFKhtSAuWTziLB5cAqBf+WbqbXpXw/BxdERomLGwpTKWHsrVNQsQz6mAWyseESj24G1inXGd/Mu8KWAORrK+ldsH65cfajxf4qqV5aVtCVGRroFRyO4dd2t+US2hXXfGAHad/JbPzSJUnIkR9TiC4PqT26GPkFzeMzh62Z/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZI1MLPrUkO8HH4wO1WIjrPJqOg95VlzTBeYIhFWVqo=;
 b=An4NE5gVaLSj5Ij+IHdA+tqGP01QefLV5XWiScghEEIGXvYzU8SxZm1hUymsf99HqThFhqoZZMH9uDcioYe8e8VsJvbdJr1V7q1SZwxnZ7q1aeFVien7ADtLociwbEZJmK40L/hz81xdxQZbd8m8A2s2i0VbedzMcTUWxyePrjXq+4hzR0ALhBcxd+ilP/EDppCILRk2g8EbXmQPMzhvvi/hhMIPO/D/QwhAodZ/Fh271eGzsbsGb1h3L0ZendBcIDy20eoR0X229FuwOKdFvGsUMWdC1F2SEYO3QlV1HAP7Rk+1iYlYFUx/Qgvu1nTEUeOEix9OoGPCmWssoOenOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZI1MLPrUkO8HH4wO1WIjrPJqOg95VlzTBeYIhFWVqo=;
 b=Sq7lxQsAZr+XKeqqmRue/gbi8hRB0RwK/wLLUl6b8zRrRWkFcM/KcUDD6Ly8pUZ4JaxQV5Obhmmk+0Vy92udYQkQ4Vv2jBjuSSF/8BcvXmw1wxyZHQnXRnEKWt8ERg5NydFOCQwYuzEjINneIfriR6INIbFgwhICnMF4dJg6Akjbv8dQUq8aBwTb2yJYataduCyaMUuaT0lbfL2dUo0mPJiYlKQwq5PhENemWMq2+i5dg41g7qXjkgyC+enBeUxp96zvasPZRCAwiOTZtHWgAwU9cA7kucIXAbtciE6hL8Vah80dL5S1+wQ2Lg+wB/ozokLIzBEf7Y1QT6TeQIVIRg==
Received: from SJ0PR03CA0153.namprd03.prod.outlook.com (2603:10b6:a03:338::8)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 10:22:12 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::27) by SJ0PR03CA0153.outlook.office365.com
 (2603:10b6:a03:338::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 10:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.19 via Frontend Transport; Tue, 20 Jun 2023 10:22:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 20 Jun 2023
 03:21:59 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 20 Jun
 2023 03:21:59 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 20 Jun 2023 03:21:59 -0700
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
Subject: Re: [PATCH 5.4 00/64] 5.4.248-rc1 review
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
References: <20230619102132.808972458@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <4971273d-f3ad-4d43-838a-f0ca6176daa2@rnnvmail205.nvidia.com>
Date:   Tue, 20 Jun 2023 03:21:59 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 8711f67b-f30d-4843-6979-08db71783658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h4I6kG33MNo5RoJa8JGxusIM4Q3m1vj6obS0Nd8OALTDNchZJ8/jnfDLoJttwgcM7XmWN37jpo9NanGdBqeKDwlcmFt0/6cj+hXgoB3fXfed+Krap643jUhQ9drNcFtBoHWekwVz8ARlyuoq+CqZFcqxQbaf+onH8gyofB34gReIDdpSskdBqoS3Qi1s+OOlxscnA3KAfDilBOEZRFP2kWbhyOMvImCHCfhPSpeZ+GveXRsP2zFhbhQlhwtuqNXoTdSeSBc/H4YMiJBfl/3zJdoRPzWkYJRoNnKfkNw9TL0OjyDWl4XQ4IHFw06S8kSyJWhhTHaHHL4Lf+TVeAbykS07/KwjfIEz0wkr3a100M8Dm3RaPqleAO3yurdTrqvJvIxM4aliY14vaooKuPCPOIXg11WqJacu1bC03THO6UGTxAliAxMbvYT58uP3NjkW603T73Plsqn2dWnd0z92yjXHukdHpiSk8yNI54Y6iV9mSjvQnpGONzqQqvRBjZMfnXWVvXr5pLX+lJzuWqXa0fXAe5M7vhFrigrYJnt9W5Piqw/SJV2hdainXKSLLZk5BWUNsaq1mdsmBuh6C7F5AwsuD1e1D6EUmRYfjX0A3wpk+qxvYLSDPp/UrsUhUU1pK3sWRAL8gxxRqQ/TNQs+rgx/Jv2Rxr4JQIDEIlDdvyYjnM59sCnv7kUvr6PJZ6L5W4Ehemtw9h3jJiruHc7SGsfzSkNn56c9ZzJQzbCN5gJACBUvZ51czdYhsWeF8H4iHG4eF01ov96akkv4ivbNnmwFxgLx8rfd0rHOLNrc5LA=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(4326008)(478600001)(54906003)(40460700003)(26005)(186003)(40480700001)(966005)(2906002)(41300700001)(8676002)(8936002)(70586007)(70206006)(6916009)(316002)(5660300002)(7416002)(31696002)(82310400005)(86362001)(47076005)(426003)(336012)(31686004)(7636003)(356005)(36860700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 10:22:12.3116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8711f67b-f30d-4843-6979-08db71783658
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114
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

On Mon, 19 Jun 2023 12:29:56 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.248 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.248-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    59 tests:	59 pass, 0 fail

Linux version:	5.4.248-rc1-gd4a1c8c10fcd
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
