Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F4972DCBC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbjFMIjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbjFMIi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:38:57 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811951701;
        Tue, 13 Jun 2023 01:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGckMwMs+eNIoDOK3mmo63xeeXTCqLz4eDmJE2HrsDHzZtoBltIby15IlqVbqOl0g87ibtbYq98Xn3CW0E378qHgxNbG9pOwkQbfFPgHAHnnPsOW8RNrEEdJu3i/Ya5hqeo5nr604BGo0weaszW7Z+U2nntCea3Zo/aoHNOTF5Bz4ZtQ+zf2YjmsGICsG/zNs/Zm9jHXcvSJGgJjVCyrX2QpWS3rpslAB2Uu27yNFobY1rkXYPK5KOzAS7gtLHemLMVegdT4dgP+qOYV2Io2uFdaDTjOJAi2zSlD4H8jtlDTrWg+tQS73r0OibgBVetPcT2LCxgp192hTpvKBzBnvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMY0j+vHvpJy7/rXBa95z1BLjNBLImUV69uM5G/svuI=;
 b=ExFkTKs51vCOLNJJseKzs6zSaifGUiuNkV317ydFBdmZd7Ff23M5gQEKptds3ZTXQQU4vs9peyoj4u62ewYeKty9GBXuDMSZxsWIJwNsGy/6IaGoPThroFeHyWOQ9HHsZzJLOq1oNEGNxadqCZLw8CtcTmGD+dGwM7k3Fki+Jyc+caoYg+TdJ1rrVFAxI8HMkIXWceYQy9j93BVnZTPyUCa6WoN92hmKB1WrmAWOnBpSuH6r2kqWzRzOaF00Il+dl8xj3/zjjg2ZuqU9kl+VQNx3lOzDvytOKleyE8USM5EXCdSjVBJZCWlWSchlan3NiPBN7PhZhV8irYpYk2edkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMY0j+vHvpJy7/rXBa95z1BLjNBLImUV69uM5G/svuI=;
 b=OOEvmJKJHmsL7briDauX1zbQZgE18VWb7f0xuwiFahS1J6BiY6gN7EFZrRDhwV+WXcjOP0i1aUnoIfwifPXH8i8SouyVN/m/vbQLLJsR/hiwvmlNlbCVVD1eVuVeWj4Zn1ktZ0nBGvv0JeFrYaLRhJZvXdvZQ07lCvlINziysFdl5w37V/7PEUm4/y6iq7DIFt6ClOt9EW24gy9tBd7zEzBjnNwYTbvJeCbGFQ/I06VIGxmUCEmni9FyaCWg6BYRSS5D7C6XEtPauRpu9rlVyGww028FG8qKZ/zELPKM5zf8gFORUapNgb2U73z4/gU4Dwq0tsf7DaDzMz25fUJ4SA==
Received: from CY5PR15CA0101.namprd15.prod.outlook.com (2603:10b6:930:7::22)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 08:38:54 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::d1) by CY5PR15CA0101.outlook.office365.com
 (2603:10b6:930:7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 08:38:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 08:38:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 13 Jun 2023
 01:38:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 13 Jun
 2023 01:38:35 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 13 Jun 2023 01:38:35 -0700
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
Subject: Re: [PATCH 5.4 00/45] 5.4.247-rc1 review
In-Reply-To: <20230612101654.644983109@linuxfoundation.org>
References: <20230612101654.644983109@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <50bec82c-e348-4ad0-93fa-8e91b218eb34@rnnvmail204.nvidia.com>
Date:   Tue, 13 Jun 2023 01:38:35 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b0877e-b4f6-40f9-e12f-08db6be99ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Sk97PfjHRUPUbCRBSnAISE1OQUCFqqD9ytiWIYUcVwbrIklq0djMzryjZ7Q9+4tC4b9qM7DyDhqXOCLYUiVhnNX17b6+ejWjf4I1laA2zEBAHJnUwdoEC+XPfL1E+tXeLYug468C27aSJDS+mJX1r+89jZtxy9qvVLQlre0Wo/fFKwNeUqK5KizAPrcNpXU42tJ5fq9vfRzO4DQfbJ5rTvNL1+HaRsi31h6jzyRlpaRVmSecgFb+nGYj4RembaAHpwni7DE8qelC7Ws9izWxNTZHRdTLIj3beiJkjDp4H/4smgWEvdWYbN/8uYd4p34QaEbtjtdyDS8Ojr6HNEt3P5HZtKNOOUmFpmHiKbRa2hGVkT4WDQXACbpSe1ykSI43HUYJU1BxKHwLp6D7JlAimiQP4f+wWW9nBMIvRz/q2+mNRVmdN0wIVD24rsfT/JySUgr+SqvdUbdxrpXhQN2SBf4oMg5N91ZkllxrMa1DRAZNp/81P3rFJaP4xFFH5SDh7yX5rH65G0XYE064/ke6E39CTnbfu7kmL7uq8XL/UXWRHJeAB1FuCeilZ+hsSDrPr/9wOicdbjw1fltADOqSOZ76ssQS0+nXrgx4lhhQsrxYmDHTAuXQV4akgGTRZ6fkys6mbc8hQTnZnuQ/8ibCPoP1EAGGIl6DbrmO3E387aax/ESPumMAugqNCpDdzQmEOjfhEl9bdt8BXgOWuheuUXprgBBLu8dIpdROU60NgrqpRUU5cEMbMlPKnScCLuvyNlzR3XkzLBmZXcQuYzKae/UJop8xu2nvFVmRpRSbSM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(70206006)(70586007)(54906003)(478600001)(5660300002)(8936002)(6916009)(31686004)(4326008)(8676002)(40460700003)(426003)(336012)(41300700001)(966005)(316002)(82310400005)(82740400003)(356005)(7636003)(186003)(26005)(2906002)(47076005)(7416002)(40480700001)(31696002)(86362001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 08:38:53.5211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b0877e-b4f6-40f9-e12f-08db6be99ea3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
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

On Mon, 12 Jun 2023 12:25:54 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.247 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.247-rc1.gz
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

Linux version:	5.4.247-rc1-g6385fa103774
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
