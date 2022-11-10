Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25181623A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKJDMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiKJDL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:11:59 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660ED1EEE8;
        Wed,  9 Nov 2022 19:11:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsAYW5lttMqwgeah3kP+J6wpbs8qRw9/DiFbUqGIfFWszkOK8pXwnnZd8aoobzBGNr1C/0/+Q1LilW0zUr9wylu30AVTqWo9gXX/g4TdJU7qXPbIb8HITNHoBEBLPh1iec3vPK91Gbz0oVy8gNne5azFs6BFK6eFFE9pyiIC9l++RYTD+EzT+zfT+24uWgiR4Tr/HMSMooXOB4Q0SNcRGZILIybgV357lyOwz7CPfPe1eiXICNn7NgWKj12dXzBE7O83+Qkr0UEuJQn3Jr6g5PZLhnhZAymVOZBlpahf4YVA6jhclFGHCS4uEzQcXYHdsczBAJt4NU2bihBQrRvzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXzAEfmEaPZ3di6DkyMxuCVVmgB5/K/C1yYMKOMzxvc=;
 b=lojzf9BN66FXGlqUcEt4w6BkSq1nYgvwW1nQph6mrp8Nr84sidJwugcXreoQC+q1rr8g9HW04S15jAdQG9wrtyYT5dIk639rJBQsgeQhwE9llzZHYUSKUMK3GKKC60oeEH7qntdS3cT37CeY72AtFaHg81HuLDgMgqAJcpUCv6UNtGpzMeGnXU5SsMA3CiUK8orQL4PNlE843E58KIQ/MR0g9f+qVpFM7LV4Gg95BK6CipzZvnfp6qhQz4dRo5BGbD4gxiFbIpg55tyUgvBSvU8CoW+aVyhKt/gDofGIWq7hlmi/yicwQurvC8pEZMRIBqO6UyNzuA0e2lI8wxZs6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=bytedance.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXzAEfmEaPZ3di6DkyMxuCVVmgB5/K/C1yYMKOMzxvc=;
 b=gxpq9cOvR1kxvMstNZ0y+QK9qUZA/gp3jO2amB8bIjoORCKY3usZ8SxEsiIYCvnkRXzs9uv4KIwq8FPpKwZt/mbooud0xaf9g2uHzIFuabnHwybn74KabD/ptjL2tfzCaNXhNMUGJgzHxETQPYKU15A6dYvBRFeUBMUUSN6wMyBDWrYH8nqAd3YtOu0wwO/F6r9wBDqI2+oSwH178bFJR0PRFG8pyaTOIx8kVSG9J6FoMP6vQEihdoFgJAR88S54xv2ODnbzjUsBYIdEQUIjLsSuLy2kelvt2aNxexJhU1LYt5ICbBH+B6QYcko3XsKg2D9b9VkngqoREPj3x2TB9w==
Received: from BN9PR03CA0696.namprd03.prod.outlook.com (2603:10b6:408:ef::11)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 03:11:57 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::d1) by BN9PR03CA0696.outlook.office365.com
 (2603:10b6:408:ef::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13 via Frontend
 Transport; Thu, 10 Nov 2022 03:11:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 03:11:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 9 Nov 2022
 19:11:43 -0800
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 9 Nov 2022
 19:11:42 -0800
Message-ID: <49ed07b1-e167-7f94-9986-8e86fb60bb09@nvidia.com>
Date:   Wed, 9 Nov 2022 19:11:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/2] sched/numa: add per-process numa_balancing
Content-Language: en-US
To:     Gang Li <ligang.bdlg@bytedance.com>
CC:     <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221027025302.45766-1-ligang.bdlg@bytedance.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221027025302.45766-1-ligang.bdlg@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|BL1PR12MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: d018ca13-2b54-4190-86c5-08dac2c95363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpXO6wASvvg7EWekUq7BE4t7OcCNWQneZNACOk73oQLeaD9Oxou9omTh/VnDV7mfBYZtsC5WUje129GmukBu3a2A73F+Z1KCVgmhDq4oGYtqY7GPGx/uKp0s8jqzk1WRl5qMCqhUW4n7bBmmcOix3szO+tV2f8wDKbp+VYISGmiE6qahUsKIW+berN37+14lTZAnlqCfQ0n/kCo/IASYB2F4QyoYMicrNjSzBgBhFh9LJMdKXGBZaiUMNc6W6ZMsnBg6rOSzuN74JgVIr9Dbyj/I+wNuX+Gb0l7VAqF/sWBQB8lcP0zwfqsfU+5UL6g4fHYFcC9k4VRqWXQjwrLrCZ8r7oAALQ6iJyal57N6DK5jXZE4IDL+30v5OoRnuOIICVW5RZeWsWR90cmlW7GKLecADu9VlCxNCGkP05hXpRPRdtkGR/zYk0zp/yYJzWcLvbx7lC67J7bW/JjwyuPfz6KfDlqolWAwEw70TXPOGjgfi5EoSl2of0afZjQJSJfE0OLxjD/jOO63yIHTFQvtyXi1UQG5nZzla2Icclfev271PPfu+s+iAJxpI2j2RWgSygnBY7Fp+QO0TI7no74fXRyB185WKqZI3GXVnpeNpZjxxbDpFxlajjl1GWnEpwOgf58ZuDnjnSbK8u0iGVwWxaqd2wbTHrnD3U7COAjd79hPNpWP9xfAPaj1iTXhSm8SAfDc3tL8HhzjKXcZtR+uszTBDbXhKM899HLEZGXgu7uxikjoHVnv4cppdeoUWsQwGjHQqNGpiNpHMEx65D5wTIjjWeu88Byc4WXtPqn1Tc0mGcIYzA2CZQeMY6o8lgYm
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(4326008)(31696002)(8676002)(70206006)(70586007)(53546011)(16576012)(316002)(82740400003)(40480700001)(336012)(36860700001)(83380400001)(47076005)(2906002)(40460700003)(426003)(41300700001)(186003)(86362001)(5660300002)(26005)(2616005)(8936002)(36756003)(16526019)(82310400005)(478600001)(31686004)(7636003)(54906003)(6916009)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 03:11:56.7561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d018ca13-2b54-4190-86c5-08dac2c95363
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/22 19:53, Gang Li wrote:
> # Introduce
> Add PR_NUMA_BALANCING in prctl.
> 
> A large number of page faults will cause performance loss when numa
> balancing is performing. Thus those processes which care about worst-case
> performance need numa balancing disabled. Others, on the contrary, allow a
> temporary performance loss in exchange for higher average performance, so
> enable numa balancing is better for them.
> 
> Numa balancing can only be controlled globally by
> /proc/sys/kernel/numa_balancing. Due to the above case, we want to
> disable/enable numa_balancing per-process instead.

Hi Gang Li,

Wow, it feels like I'm getting a Christmas present early, this is great
news!

This feature is something we've always wanted for GPUs and Compute
Accelerators, too. Because what happens there is: we might have GPUs in
the system that have mapped CPU memory into their page tables. When
autonuma unmaps the CPU ptes, this triggers (via mmu invalidate
callbacks) an unmapping on each GPU. But GPU mapping and unmapping is
far heavier weight than the corresponding CPU operations.

And so for things such as OpenCL apps that run on a GPU, the only viable
approach is to somehow disable autonuma balancing. And until your series
here, that was a system wide setting, which leads to not being able to
ever have things set up "right", without constantly intervening at the
sysadmin level.

So for the series, please feel free to add:

Acked-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> Set per-process numa balancing:
> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING_DISABLE); //disable
> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING_ENABLE);  //enable
> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING_DEFAULT); //follow global
> Get numa_balancing state:
> 	prctl(PR_NUMA_BALANCING, PR_GET_NUMA_BALANCING, &ret);
> 	cat /proc/<pid>/status | grep NumaB_mode
> 
> # Unixbench multithread result
> I ran benchmark 20 times, but still have measurement error. I will run
> benchmark more precisely on the next version of this patchset.
> +-------------------+----------+
> |       NAME        | OVERHEAD |
> +-------------------+----------+
> | Dhrystone2        | -0.27%   |
> | Whetstone         | -0.17%   |
> | Execl             | -0.92%   |
> | File_Copy_1024    | 0.31%    |
> | File_Copy_256     | -1.96%   |
> | File_Copy_4096    | 0.40%    |
> | Pipe_Throughput   | -3.08%   |
> | Context_Switching | -1.11%   |
> | Process_Creation  | 3.24%    |
> | Shell_Scripts_1   | 0.26%    |
> | Shell_Scripts_8   | 0.32%    |
> | System_Call       | 0.10%    |
> +-------------------+----------+
> | Total             | -0.21%   |
> +-------------------+----------+
> 
> # Changes
> Changes in v5:
> - replace numab_enabled with numa_balancing_mode (Peter Zijlstra)
> - make numa_balancing_enabled and numa_balancing_mode inline (Peter Zijlstra)
> - use static_branch_inc/dec instead of static_branch_enable/disable (Peter Zijlstra)
> - delete CONFIG_NUMA_BALANCING in task_tick_fair (Peter Zijlstra)
> - reword commit, use imperative mood (Bagas Sanjaya)
> - Unixbench overhead result
> 
> Changes in v4:
> - code clean: add wrapper function `numa_balancing_enabled`
> 
> Changes in v3:
> - Fix compile error.
> 
> Changes in v2:
> - Now PR_NUMA_BALANCING support three states: enabled, disabled, default.
>    enabled and disabled will ignore global setting, and default will follow
>    global setting.
> 
> Gang Li (2):
>    sched/numa: use static_branch_inc/dec for sched_numa_balancing
>    sched/numa: add per-process numa_balancing
> 
>   Documentation/filesystems/proc.rst   |  2 ++
>   fs/proc/task_mmu.c                   | 20 ++++++++++++
>   include/linux/mm_types.h             |  3 ++
>   include/linux/sched/numa_balancing.h | 45 ++++++++++++++++++++++++++
>   include/uapi/linux/prctl.h           |  7 +++++
>   kernel/fork.c                        |  4 +++
>   kernel/sched/core.c                  | 26 +++++++--------
>   kernel/sched/fair.c                  |  9 +++---
>   kernel/sys.c                         | 47 ++++++++++++++++++++++++++++
>   mm/mprotect.c                        |  6 ++--
>   10 files changed, 150 insertions(+), 19 deletions(-)
> 

