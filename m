Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6044D6228F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKIKso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiKIKsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:48:09 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B4C275E0;
        Wed,  9 Nov 2022 02:48:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMcZ+zWZenwuVnDLLd22PkfEMu0qKiOwNbql4FrKZ03h2j3f3tuDzTPuCewMtdCMxAB2+urmyw1Uoc01WLiWGtx0SqxYj4rgsss2uJkT74is+8Y0MkL3XA0KVttr6rRxX4iRKls5LnfXTQ1iV0Ckcnnd0q7hmLMtwjsm6GQRyckDbQpqcg4Y+8Pm3kOYfc/vYhHf/QZ0JS7NjJoJjz0+jXfwhsRm7xFUv5wV6PKTORV3i/IiZ5I52X2QJHwzAceEM6vLt6bbCs/B43VywhWwQSXr5VWFg+7psZj/Icu6o9eSl/7CQvZDgGFi5DmzsVWvLXlzR5u8K3JxjYX8Qw2d4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFLtB5z68nO31ZkKhImJH5CIMaBmo0kB1ACfUp056bw=;
 b=QKF9bsHjW/1LgvKp/xRDFRgcHYK9R/XZliTEKjM+/eDXvU+39b1+9o/InYPQV7YOxpuqUvTh1SNzqm3kmA5RY/wDL4dHHUYgphcHpaZoRZUM0L9CUuokID4jaZb2GhCY+tdt2fEhPW904TSXckd1gJLuaovJqV+drUYw9HGoT3PZI8w+0F26WRP6DMlOlpkotJ/YM0a19IdtkuUsQKslU6roc7Ru4M0wcmH2MuLgR8nAtBTpsACagVZ2jvdFQj7YENPJ97/8I0VRtKwbq9DPWRaKlzG8+jCEj1G0typVCqdvo000CAnsB+mIRzH9KjQXlDxKw1IaxXQhq4T6xgrm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFLtB5z68nO31ZkKhImJH5CIMaBmo0kB1ACfUp056bw=;
 b=RqIPaET5nGkTld3aZW8LkyRvDKWgLLQc7QHpJndQ1hfLdLbA4JaPNux7IXVBoTdP1uWxrMG6mmrCxG1Kft4F1SiL/UBaOZ/BBwuSRo76q4OnGnFlGYoi0jJD29sw+BQSYk9zS/zZdtI98mlGKaJ1b4Yq1s8x8Azo5dJFhDQt06pBywBOu1FfKKklPsxMBbmXJmbyR/pTE1RtYIN6DzeUrq5KY8NWfLdpdJTaH6vjr8NZ/w/wlyoGAAzKw88dl/Y2JmGmR9E14W8gXDKaJWOGLSwoEneOKEfkE+tPPdtKKw+3SwbZLPTxexiMOKYhTMSSX+WMBU0j0Djh+BxKdZ9A3w==
Received: from DS7PR03CA0120.namprd03.prod.outlook.com (2603:10b6:5:3b7::35)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Wed, 9 Nov
 2022 10:48:06 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::ed) by DS7PR03CA0120.outlook.office365.com
 (2603:10b6:5:3b7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 10:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 10:48:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 9 Nov 2022
 02:48:04 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 9 Nov 2022
 02:48:04 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 9 Nov 2022 02:48:03 -0800
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
Subject: Re: [PATCH 5.10 000/117] 5.10.154-rc2 review
In-Reply-To: <20221109082223.141145957@linuxfoundation.org>
References: <20221109082223.141145957@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <76f77a7f-333a-490b-a35f-07ee443a3d3d@rnnvmail201.nvidia.com>
Date:   Wed, 9 Nov 2022 02:48:03 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 83490df8-7f4e-4322-d402-08dac23fe2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1tRLO3AhiPtapneHf1Zt1flUiopBL9gHmXYImOyqnICX9CVcLTVfrCschfVeRd+TdpHPFItA+nJMIarfnXpBwqfmtsn4SVQWy5kc2odNqYwBxEZ6/Q8zR11ssSs3JSbJe0lZM2zl9mtNHn8sQLI7r2eY8B71owMpxDJZFP93z8dX5KKcKISPyH3MmxXXqSTSPae7ETRjD7sqRf4QRS/3PO9y2XKYqwp+R8VdFAMtRv4W9EWJS8aFeQF5fq2e/tS4xN0rpsotvLAgLwjpaAEKB3sE//Y2rThcDs9gxV9HnbGZ2Wl/bOirrJYlNPNVeU5byiiCqHvaebdF7CTs3ObA0ZXKjbEbd3SyowAzQVhiBEZXA+HeUmvf0vYZGTe3a13Qb9qq1YByu9I0eHlCSSBF13W3Vq+rXtSGrN+tA8Csc0NO4vr8/DfcL1EO5WPc35lRkHpx05koGkg/mjpbk7JHWkI5g/Yqu6xaWftx2ApQTPQqb4ISZdO2DTnfi1rtJNmOJy8x3QIVXNWRX+jHWTGeKBXowHF1EaKSc41z1J9CIKxqAtjfGzqF/ce46JgQyDBL2SdpVhdMYGVY0fq+TGZ+NSJ5k/hYJBvWlLAjN7vRXTQTyO+5wfrk6yIfjtKUDcrf1RKlYXTNv5UN94VkgOUPwgC1rKuRmKv3k3DWgqxIhsyB5dLUUCFzTwJht1APNJIA91eW3hzzaXAB9lVAbZ+/zEkQ5ReFk/kf0KTTVH2QFwDmP24N/Wg4tqQkKLXMFuZBBaCsDVoravZI5fKV0CFPTx6PIR4am1lUJkQJQcVHWo9bYV+gg9x3wS7zHMjzoQ61Xu7eMk2pyd2RMq0wqKt3Bx98dzS22Lz2XLvq8GpFJiU=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(316002)(41300700001)(31686004)(4326008)(8676002)(8936002)(5660300002)(7416002)(478600001)(26005)(82740400003)(40460700003)(47076005)(966005)(2906002)(186003)(426003)(336012)(36860700001)(70586007)(82310400005)(40480700001)(70206006)(6916009)(86362001)(54906003)(7636003)(31696002)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:48:06.5768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83490df8-7f4e-4322-d402-08dac23fe2a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Nov 2022 09:26:53 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.154 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Nov 2022 08:21:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.154-rc2.gz
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

Linux version:	5.10.154-rc2-g69a0227f6bd6
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
