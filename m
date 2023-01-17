Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CDF66DD5B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbjAQMS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbjAQMSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:18:18 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285A435279;
        Tue, 17 Jan 2023 04:18:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPXwsB9fKmhQIJnXwa/yX/u46lckWeRM/rQ/VwW2NaWHwmEGs2sSmJJLPxId5puV2w0Icgt6xqAMpkKXog3rDkPkA7fgLti+rJHT3/OGRFwCtHrRx1cLfiIRHfq3rgFTrMU4TNGMrnc4gfwzVf0O0Mf6vW53mVR7/t47yTSn3fwDk5LDSY0ZCjCD58ZOWDPEdKtu2TAj7Vaib6TtfG2EMcz0FhM+e99lZuYcqpcS9L5q6g7H8q7BWudKXdCXr+EIcdJtSZ1qp9kFi9+pOOMIVMbR3acgfHTvL0cGzuoK6myoNsLo9zpvaLcRf5jpX+L4ByKMiXpE4uOBYxpXymv07w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EU6rmAaSNTPVYl/91CGi1/LHhQSlJ0V6VIWEdcioRE=;
 b=GOjsIiKE4vZyOGQa2TRQk1+FoUuUIg0ybl1JYyeclO8JBY7MTA6zCSsTz0QOyjKR5z679xFcWtMq879Z2kTLIdHscJumSPcm/i+t8z+S/30UUYQPuIifNnnxzB+3ikwNwT8A6FvZrr8YG06YepSWP/X/OVKvcTAA2bOqKcqHns0yuFPjqBnOKARagJ9pUDmxAoB85TpYLnBjcrbA7AXavlr6Fz22tNB4VKFG+k5LoYsQG1m3UU4kLClw0nKOQtvQmIYH5tcUgXxCOTNZgqbwVoVUirJbX0umtCl/kJ8XrpLuivjJgz2cAXOebjZsSR/jaeUfExyZZ6zdvIDAUaJUQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EU6rmAaSNTPVYl/91CGi1/LHhQSlJ0V6VIWEdcioRE=;
 b=D0MYSoRzJ4PBtB5hgyUt4z8Afpnkl0lokOLr5t2GrvdbNWbT9qGYhF2ZVmBway2N9kmzFlK20rZD1Y/iagHEjrkqIrbvKXqMWaO2JfKQL1lboqLcYcug1IXCubIr6wfDDEF3axlGzMuii8MjbdfOvSS5GFzEEmRfzVIGdJAvADNj5+nyVklCJzBbwxjB1J7lTk4LTXsQhitmbrSqCpCDLnbxV57g55mTvz2Stxko7Rcnz7cLx4huHgrCBnOzoRBnU5O7Yyl3eub4qJbRItjxtDyK+5UACYW12c8P+IzQDuzapW1bkHUYO4YmpCMRG15ZSRzRD+VPvBfx6YdYp/YvKQ==
Received: from CY5PR19CA0084.namprd19.prod.outlook.com (2603:10b6:930:69::20)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 12:18:15 +0000
Received: from CY4PEPF0000C980.namprd02.prod.outlook.com
 (2603:10b6:930:69:cafe::3a) by CY5PR19CA0084.outlook.office365.com
 (2603:10b6:930:69::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 12:18:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000C980.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Tue, 17 Jan 2023 12:18:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 04:18:03 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 04:18:03 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 17 Jan 2023 04:18:02 -0800
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
Subject: Re: [PATCH 6.1 000/183] 6.1.7-rc1 review
In-Reply-To: <20230116154803.321528435@linuxfoundation.org>
References: <20230116154803.321528435@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <c19f8283-d2ea-46bb-a00e-132cc938d07e@rnnvmail204.nvidia.com>
Date:   Tue, 17 Jan 2023 04:18:02 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C980:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 950246a1-3fe1-4226-2659-08daf884e8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NHYAbJQxRdTbcjpXN1tb3HUDIr+Uig0jDki2OGcW9LS9JpxUJrZzwbgPI84csSouY8qEySXRyxgr5nJKxnFMrgnSmEz0pZJOQwd5tSkiZkHRQ6iq4aPjfnubny612i+86k+2YF6vJY5PMQixFjwA73CDrDmkBPb6vE4vNznfKwIAmPrYo5xzpG0pM4sYpqueDw32Rg+XU3iuGQY+t3TyXrfeKvjU/ZxJ/+/XdyJaLkpFBqEkS83DGLXB7/l5r08DaEDKRLMf7cnvrg3dwHmD/TOp33jpN1dEsoFu8zxJqZIXpjveH8UlTLm6ypFwABcLMt/OajG5fhkK1xMklmdppm/91sxpOQ/RKvoe+Ugb24icjzjD63O1SMQ2o3eWmyUMMt6bKHQbSsW/Lb0ZBpaczH3AGeudkCv2HnZKcTjGiwlQn+L3wrqn2g5+lwSUxH/3v+/BrWi4cLue5ClsYSOsyGgvrXelryXCPGIh1OIbS3sYRZY3pRCLbVu+GzdCIaMWmWV2lUTM1UXMoqaT6/D+J/fCShk2a2KvtUtiv5/C/P2HCnRdP2xts+yQ5iPeGC7P2hpRk6G8HLIbKx82uopac6ftJrDAzImMO1Zgvo4Hti5/2PLcdQebTROwcuiaOIA3jXjgWOBolEBm3JH+S+zS00tumITmCorD9/C/tI0c3NGWGKlIxVvDaSkEROh9kMPy1G0ZBi4NAvSz2hyMdNyAp7YCtG9rHek1aVFtRK142sBWWFks3FqLiAsiZYW1qudB73oBQ3TqcRA3zXa4RlcrnXQZMfGyHhq0H4UGOJYWavk=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(7636003)(356005)(4326008)(70206006)(31696002)(7416002)(2906002)(5660300002)(8676002)(6916009)(8936002)(70586007)(82310400005)(41300700001)(40480700001)(82740400003)(26005)(186003)(47076005)(336012)(316002)(426003)(40460700003)(966005)(54906003)(86362001)(478600001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 12:18:15.1627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 950246a1-3fe1-4226-2659-08daf884e8e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C980.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 16:48:43 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.7 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Jan 2023 15:47:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.7-rc1.gz
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

Linux version:	6.1.7-rc1-gffb1fddbd4d0
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
