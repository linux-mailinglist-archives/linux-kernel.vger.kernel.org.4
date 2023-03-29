Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DA36CD848
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjC2LSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2LSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:18:10 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02hn2211.outbound.protection.outlook.com [52.100.160.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDEA133;
        Wed, 29 Mar 2023 04:18:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJq8/kzuqbKYXHyxD/3WeaFVPkedosHGMWHytrVv86lpznQdHgNxSPmmedE+3DzRQ04KBSKOFHSJuMEahvR2aqEjiPcUzxY+hSZPKyx4z3XiOeiOfplernBZRc1Ppzmk46ro7fTti+rSyuDBzus7a9iokmLxV8uoNP2MfdYtCQL6Cet2BannPizFYROX2HLAfxtt/so8oNNG7hjjZrR/thA1Y0dLy/QQdeO2ZUayV9rbTHZtpjPwL5GJL85KnCJPbqqZTsM6+xmP0OU/BNUD6AjpJR/8JEh8kzhp8BRyd30hwhYelICVo/YVWOTT+WPl3eUDDBWsNu6ySpfPzsmE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9o/qhnxaEYB4TJgqBmXQfV4ZclDAjoMSit057Bfxu8=;
 b=FDC6IZS96CwV0wkkUu0ec4qaXZ6DuAbnOwilYmwdtIdpItSnHScZ3E9K+NmiXb+6OarFV6cU6pFizcY6jVSqf3NPl0OZ5l3+stZdFCnBpnW2n//NalJeE7vuDQFH0h/XD3zpJ2bkeQFy6iJPCQBcgp3BX1rUoj4aiOpIgCCn9NTZnBTEex7WHDnz/m6CokffWZN7fz0mlkQCCqD8PouPB9COdxEbv6fe09ea1eYsIt257nBoZY1rtc0hjM972nqqqoNsKr4+lNWJGi9nG6WHyJn2sKs0GPPV/O+O+7knikW0L3/lcMjhZdkgM5TRZxxGS1IFlaCijP5U+NbOYjgnGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9o/qhnxaEYB4TJgqBmXQfV4ZclDAjoMSit057Bfxu8=;
 b=eUxcUrPzQ3V+pj/TKLmjgJsov0I7JAzNSdlKbbOllxJqDBYShzB3VLTAlQKnQqfLAyIwAeSMipxhpnnjw8tXJdDzJNl3wXsmqj5FUhG2ZFORTbhxKm0GOH1suiy7LD/FFL20a0F232he0WMogGlQpCN95O2iLfMh6BvtE5JNljpASkMuP4WKZi6uVKc7ByaWe4Tosvh2QFP9fICv8dlEIMyijqsEw7S5Me6aDPYBHwyRDJkbtlPEr4DeHqohbJOPbWP/GG1D3Re95C0VlBEeb60hm0gD/L3JXeFcbaTW7z1U14CSzKLNLD5DhZnvH0QNRK1i5Dk62No20Si+COjYjw==
Received: from DS7PR07CA0011.namprd07.prod.outlook.com (2603:10b6:5:3af::22)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 11:18:00 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::4a) by DS7PR07CA0011.outlook.office365.com
 (2603:10b6:5:3af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 11:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 11:18:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 04:17:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 29 Mar 2023 04:17:53 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Wed, 29 Mar 2023 04:17:53 -0700
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
Subject: Re: [PATCH 6.1 000/224] 6.1.22-rc1 review
In-Reply-To: <20230328142617.205414124@linuxfoundation.org>
References: <20230328142617.205414124@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <0c992d95-449a-4017-bcf7-eb7d4b263036@drhqmail203.nvidia.com>
Date:   Wed, 29 Mar 2023 04:17:53 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 036c2974-b18e-487f-32a7-08db304741d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ni223cJUp79Bar7K2Q5dXmMcHKGz4KLSsz0A6ylqp/+/+fSPiRKGK757oj8kKP6vGmh1vDotuQjXzS3bAot1VeQwlVzHAR5aEyWi9ST+CUCQ/gIUpugNyXZEb7b3lwMtim+S7Mq8hx68Dfh4ujED5F3JIUsdc+JU+LSXi+ehAXxjXkdkePcnFzOyTXHAUv0nWZ8zMM5+oX9JGWrR7ZLUeOQlkvrB7PrvE8CaPkakiOiW9RFau+AXpuAlzOOzpnCdTEKxKanivTovDm8keFTAnSn5sK55bCaOhid9Zw2bt4mdBJmq5JJsDoSG0uXN1MFhwzKJKUuMxlZr71xkMg9lbESV/KcBIMa5SuITeW3y7gXFDNMAAbwHQ4h59S0nXYgA0vLJLSt7lpWy+O1zZagSq0sl+CXGWVhJdPyaGyLrKcRyTkSAZK2R2WI0dfzb7poLMvp6lh1bmdDzki20c9maWhhMe2nHlGxuwYCXF1cs8Sy0P72n00r76H5vK1Z5IYX84PqF4dD7yWUukGeFnQzXEw3cD+X4tBwZR+Xt7qad1vtZocRlzMLDs+hr2kd9CwN45HGLnQUzWEGS58V2A1HOeVQmB9MNfBC+DavXM9+Ev0UWdesc/0OW35gTqdbAcze269uvxdlj4+wPSOtE0ZgfLSv6h2asgx3hyyyha0ivKp0TRf8SteuaXZl+xmBKC0Te4g+MP0Xx6nWwHHom55XMYaYqPIgwWCbIT3SMbGqI5DRfxKdXGH+B5PvP8iJ+kmveUTVM88NP2nQ+v4T6oG30tphpG+wGmbeo0HJQdXYe+6UnQCrdLWS57NooOYVtYfP2WG4c9gpij3jjoPX0y+Fk6BqgMFhxl6Ryq+zp/YvNsQY=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(5400799015)(451199021)(40470700004)(46966006)(36840700001)(336012)(47076005)(31686004)(426003)(186003)(966005)(82310400005)(31696002)(478600001)(86362001)(316002)(54906003)(34020700004)(36860700001)(26005)(6916009)(41300700001)(4326008)(40480700001)(40460700003)(356005)(82740400003)(7636003)(70586007)(8676002)(70206006)(8936002)(2906002)(7416002)(5660300002)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 11:18:00.6953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 036c2974-b18e-487f-32a7-08db304741d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 16:39:56 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.22 release.
> There are 224 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Mar 2023 14:25:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.22-rc1.gz
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

Linux version:	6.1.22-rc1-ge6bbee2ba76f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
