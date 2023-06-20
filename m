Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060B87365E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjFTIPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFTIPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:15:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02F8B1;
        Tue, 20 Jun 2023 01:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3wkf44LPpLWUNKCHHZMDpJZhfIa/icQKmC5mTUhMtlJqP5Y3uCXj0HgZhxrO1u1Pu2DTooUS+OOgOQaVVoTitOWxdP7vQ8/6wm3bWWbJedH3IRIYIjUg2KsFkTGOTk44SJMuQ9Cr/JnKuYPjCZzf95qUsqe5pJUigJsOFXvGttEQN1YcZmyLmgJJW3kGkmhhVa5T7CgETOhacAKojuoSBx2ZWYEm2H1gf2xqKMeOWKiJIjNaHDapzNx/gkuWscqqyTLJatmVrOZh8o9RgAqSGqcweOHIMMgZ8NnoSjXA1R1WVHXMC4QEmlXuafpPNPuZIZPZtME+aa1hwved0hAXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Svei3EUtu2zN4BKvLYM5MTr0r5CFZAhDzM4GVfce8r0=;
 b=g248+G6gBuhflrdT5spTWugs1oa5K9F3CNwdt+qr3SNDMuYxzQbdZJWpDRAxYn5/hHJrebYJ/ZHuqzBXaHBWtL8A1JB7S/THiEaQx4CbTebd9e+c2kGibUv+6Ad0Rm8Eltw2Ez2pJ6/Vt+5OkX6mY6Jf+IekKjRyNIeUL1HbA3Y2rN0BPSBGyEV2YsztG80eEylQr0cvC4uhfOY+xtDD0fknIbtFH0zLYCDlbp80UfeGonUklbbSYew8Va4V4LqosvKtprP1kBAYRpdQxPFIaIzPuH/41VC47z9059P48lV/7Pq07lE3RktMDpkEZTXhUM1EbzJ86A6R5Xk1B7zHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Svei3EUtu2zN4BKvLYM5MTr0r5CFZAhDzM4GVfce8r0=;
 b=jm9ewA/aUioZagzI+zi7cVPFhRml7h+33woyEx5oEqhWuq1xbWqOYXl1Xina8BdBJGFiv8/EA/eRhn57dtLOtDc5ncx9tNlkrszpdxurnWzjdfcpOwV8GZ+VPuUJpmKs17icXiaV17PDnl+ab2YoQy0RhYgMe3H2VPxaB2VM9V4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 PH0PR12MB7861.namprd12.prod.outlook.com (2603:10b6:510:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 08:15:01 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::714c:3289:2d9e:954e]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::714c:3289:2d9e:954e%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 08:15:01 +0000
Message-ID: <09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com>
Date:   Tue, 20 Jun 2023 13:44:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [tip: sched/core] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
References: <168214940343.404.10896712987516429042.tip-bot2@tip-bot2>
From:   Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <168214940343.404.10896712987516429042.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|PH0PR12MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e82dbec-29ae-4060-54d3-08db7166713c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2NSQoevadkIdP+xJnHQL0hgp8/q5aWwmNGPhYA74XdN9AbQEdnBMCzyhCemKbnZqX8LcHoFVyvrGjkUe/9obxQuyJKvivsidgZwsXMCLloKs93cuOzprcosJFyp3nD4JoUSFaJFSsCNFaDL4sPEHCSdRNu0LkPdSjFS+4q/V6AXTpA9oVhosWUIFrK8ETFxaclsgFCSk73YJ4/Ez8mypHHJWhDNT6nW9cz8nmQSrEZTXBT96ko9Oc4hgN173ZoqyJSwcG6/NBf3U2q+mZ+fjWsoqgtcbzy64rN0PsGmfUge6Lnrx2yR9Ur4tNe2caqrLIDul5IIQN8eNTuygFSclrQWwqlwwdMU/4Jcy47XkA3F9mhqPxTEyzmmzA6ivifM/8vvS8HhWbMV4tivTxzGy+pJi/sE1D5fuPRyETxd2h4qkbfT1XViuyUquBRzIy0yCCuQq6l3TL4wj6HaGGhZRToJ0ifuZjitiu9X2UZrzbJzVs3zTXrl8o0C4OuKJlZ38J8mi9FNU4OJ+IvXqI2lk/fB380815yANSuT1RFq2IbQgvjzP0MspvVXp879ahYn64+xUXmvIsuRIOFsFVXdNeqUsjpieNLVBlrctcG0RVmYFdLTy+uaI6Uiku68mmQLxLLSvuXubor2+TTUbTzJznDCSkOSa1foOCx/+xWngH+7W61p38srW221Jwk5QSsv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(31686004)(36756003)(5660300002)(8936002)(8676002)(41300700001)(66556008)(66476007)(86362001)(4326008)(38100700002)(31696002)(316002)(66946007)(6486002)(966005)(26005)(6506007)(6512007)(53546011)(30864003)(2906002)(186003)(478600001)(2616005)(83380400001)(54906003)(6666004)(43740500002)(45980500001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTJEOG9aUkk5ckFtSVh5SFJta2gwOWE3dzk2Zk5zcC9GMDEyaHZpdjlDbGVJ?=
 =?utf-8?B?UjN6RlF2SlNJR0g3N2x0MUI1dWxyM1QrQnN5UnpZc1FmdXRIWldlL3JXRnNP?=
 =?utf-8?B?Y1lxYXpYZGtvV25ISmxOSmFMNDlOYVE2VTA1b1h3NlJCdlpEOCtNUG1laGFo?=
 =?utf-8?B?N2FPaERIMnRoWldYL25LbG5XN1I4K3NINXExQjlXTEpTekgxb1AwS3ZaaEpx?=
 =?utf-8?B?cG5iWUk0WjdNbFlxZGl0SWRsb3FUdlZ1REpMM2tCeEJLekt4QnBFZGVvbUdO?=
 =?utf-8?B?MENHTTRmVUs2OWdnT1JFd1FwS25qMEdTWDJDV2diTG9nV2Z5aXRSZ3ZabzM5?=
 =?utf-8?B?ZnlKZXlvenhTK01tdHcwR0plUGxoL3NabWdFSE1XTDl4bTdyMVVFcW5IMWlH?=
 =?utf-8?B?Y3VHQmxuYnJ1amVIbUJrYXlMeHZZR2h3eDdPci9FcXczQ3pDQTgrUXlodER5?=
 =?utf-8?B?V1FUV2xOWFE1NWlJb0swWkxKUDdLY2VKdlhQcjdrMU1JTHZmbElOVGd6Q3JH?=
 =?utf-8?B?MjZ0OE5EWEVNNkpmRHRXbnVGSXJ1ZVlUakNlc01QSTYrVkkveW82ZW0xWVhO?=
 =?utf-8?B?NDEwMDhnUUMrZEtWKzhBOFBNbUhvYjFtbnV4K0pRblhzMWRPbXN1YTJJeTkw?=
 =?utf-8?B?Q1VrTVpuSFp4WGZvVFRnbTdHWlBQaUo3bXY4T0luazNDbzNrbndCQU4wUjE2?=
 =?utf-8?B?ZThLUjlvbzJXQkFxaEtobHB2c0VjMzNycjlHYjBaeVZhVkhxemQyZHB0c2ov?=
 =?utf-8?B?RnozalFXRGFIcXpyejBlSkNLYjA3dUp0Mnc0aGd2NldOQWlpbzUyTm1nbTZ3?=
 =?utf-8?B?elBwOTFaRFFISWhCYlFuRlhSdXNUSTRlRlZZRUw1WS91YnJmV252NUxDbEJs?=
 =?utf-8?B?Uy9QVS92RGVCTTlzOUxOSnJ6ZVhsTzRHcDlQZk50VmZyKzl2c0dKQUZEQ25o?=
 =?utf-8?B?dTVLMnRSUXJCQkJlbTFrWS8rYXNZSC9YZy90MC9GdHRQVTdMN3NpaGZSbWZN?=
 =?utf-8?B?dktmbUJKNnlCR3UxM0x2aHVCQmxKd1dSVkR5eEJud08yZFhBYkdpb21rcy9o?=
 =?utf-8?B?MXc4Zmg3Smsza3NnS21ZaWFGdnJIb3U2SmJidDJ6V1R0NWJtYm1VVkhabW5n?=
 =?utf-8?B?Vmt1R1l2ZndxZ2haT292QWVXaE1nc0tjNThxbllDV0ZVbS9kOUpqSUs2VDkv?=
 =?utf-8?B?V2VOaVF0OXdmUVE0ajZhdUtJQmRoVWQ0V05rbkFvdkx0VWtLYUVrTHQ5bmZF?=
 =?utf-8?B?NUIxL1RWQlpRTjRRM0wvWjl0ZUdkdWdqSnJQQmNtVjBCNFpZRDhIV3FwbzJx?=
 =?utf-8?B?THM1Q2JVQS9XSi85SGJqQ003amNKNmJibWh4YjlRQ2Q3VXFvOEVxeXlCRWR3?=
 =?utf-8?B?Qk5Cc2txbEJEVEtlSjg4S2VVU0xaSWxVRGREdTFmTUh0RGpteU55VEQ0bUhs?=
 =?utf-8?B?THUxRU1VTGxGWUUwVFJSRzV4WlpmSVQrcVQ0TDBXcDlMbENDaE5WaEFHZ2RM?=
 =?utf-8?B?UHdhcjAzTk92cWVNMmNJdXJFZ1lVYVdLRFdoejJSUnZUV29mSXZ4ZkRDd3ZQ?=
 =?utf-8?B?YURyYlEzbjBLSUd6K2FSa2JudEoxTzVWQkM0WDhLSitDTitFTXJ1OUViZkkw?=
 =?utf-8?B?b2lmMXJkYTRqaC8wK0lrd2dENkFvM2k4ckZFWER1UzluaHhLUitJNngydFBM?=
 =?utf-8?B?Vlk1VGFrdXdwTVBXT01tdzhpbVFOc1ZDK3V6aTFDWERXLytWdHNEQk15NnNQ?=
 =?utf-8?B?KzlVY29mRGEvTUlmU2lEN2xSeTFWem1aMG5PZHZWTnh3WUxXQXVjK3hvWGxD?=
 =?utf-8?B?TTVrK25NQkd2amNaR0xaTnFBWm5hR3hkeFNRZHFwR0lkdHloQzc5ZUM5bGlJ?=
 =?utf-8?B?YnZVekd0V2o4K0tReFlDSG5uZ2lvVElkc3pUWE5aRmwxaW1rK1FVRElSNWVM?=
 =?utf-8?B?L2o3bEdKS251TFN2RFF4MGZnb01mMUJkMlF5Tlg2dnJzSUVxTURMVFJac25N?=
 =?utf-8?B?U0Zza1RONU54eGkvMmR6R0pHWWU1QzRWK1NubjBsaEIrdWhxNXJkMGtXQ0Nt?=
 =?utf-8?B?VkpVN3M2S1NOWHBTa0VMSFJ0SHBJRnpENlBIT3ViREt0cEZvTnIwTlYyb041?=
 =?utf-8?Q?J3o9tcMx1WyCgmf9orMajznuo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e82dbec-29ae-4060-54d3-08db7166713c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 08:15:01.1220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEh1Pa7RYAfPBwimbzKdpnueHE6mkXe0VgUi5H5TfwHEYhqpj0xmheJXYL6WWo/ulQdDlrR8nMFm3PsLbbj3zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7861
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mathieu,

On 4/22/2023 1:13 PM, tip-bot2 for Mathieu Desnoyers wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     223baf9d17f25e2608dbdff7232c095c1e612268
> Gitweb:        https://git.kernel.org/tip/223baf9d17f25e2608dbdff7232c095c1e612268
> Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> AuthorDate:    Thu, 20 Apr 2023 10:55:48 -04:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Fri, 21 Apr 2023 13:24:20 +02:00
> 
> sched: Fix performance regression introduced by mm_cid
> 
> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
> sysbench regression reported by Aaron Lu.
> 
> Keep track of the currently allocated mm_cid for each mm/cpu rather than
> freeing them immediately on context switch. This eliminates most atomic
> operations when context switching back and forth between threads
> belonging to different memory spaces in multi-threaded scenarios (many
> processes, each with many threads). The per-mm/per-cpu mm_cid values are
> serialized by their respective runqueue locks.
> 
> Thread migration is handled by introducing invocation to
> sched_mm_cid_migrate_to() (with destination runqueue lock held) in
> activate_task() for migrating tasks. If the destination cpu's mm_cid is
> unset, and if the source runqueue is not actively using its mm_cid, then
> the source cpu's mm_cid is moved to the destination cpu on migration.
> 
> Introduce a task-work executed periodically, similarly to NUMA work,
> which delays reclaim of cid values when they are unused for a period of
> time.
> 
> Keep track of the allocation time for each per-cpu cid, and let the task
> work clear them when they are observed to be older than
> SCHED_MM_CID_PERIOD_NS and unused. This task work also clears all
> mm_cids which are greater or equal to the Hamming weight of the mm
> cidmask to keep concurrency ids compact.
> 
> Because we want to ensure the mm_cid converges towards the smaller
> values as migrations happen, the prior optimization that was done when
> context switching between threads belonging to the same mm is removed,
> because it could delay the lazy release of the destination runqueue
> mm_cid after it has been replaced by a migration. Removing this prior
> optimization is not an issue performance-wise because the introduced
> per-mm/per-cpu mm_cid tracking also covers this more specific case.
> 
> Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
> Reported-by: Aaron Lu <aaron.lu@intel.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Aaron Lu <aaron.lu@intel.com>
> Link: https://lore.kernel.org/lkml/20230327080502.GA570847@ziqianlu-desk2/

I run standard benchmarks as a part of kernel performance regression
testing. When I run these benchmarks against v6.3.0 to v6.4-rc1,
I have seen performance regression in hackbench running with threads. When I did
git bisect it pointed to this commit and reverting this commit helps regains
the performance. This regression is not seen with hackbench processes.
Following are the results from 1 Socket 4th generation EPYC
Processor(1 X 96C/192T) configured in NPS1 mode. This regression
becomes more severe as the number of core count increases.

The numbers on a 1 Socket Bergamo (1 X 128 cores/256 threads) is significantly worse.

Threads:

Test:             With-mmcid-patch        Without-mmcid-patch
  1-groups:         5.23 (0.00 pct)         4.61 (+11.85 pct)
  2-groups:         4.99 (0.00 pct)         4.72 (+5.41 pct)
  4-groups:         5.96 (0.00 pct)         4.87 (+18.28 pct)
  8-groups:         6.58 (0.00 pct)         5.44 (+17.32 pct)
16-groups:        11.48 (0.00 pct)         8.07 (+29.70 pct)

Processes:

Test:             With-mmcid-patch        Without-mmcid-patch
  1-groups:         5.19 (0.00 pct)         4.90 (+5.58 pct)
  2-groups:         5.44 (0.00 pct)         5.39 (+0.91 pct)
  4-groups:         5.69 (0.00 pct)         5.64 (+0.87 pct)
  8-groups:         6.08 (0.00 pct)         6.01 (+1.15 pct)
16-groups:        10.87 (0.00 pct)        10.83 (+0.36 pct)

When I did IBS profiling for kernel with this patch, it shows most of
the time is spent in finish_task_switch() and __switch_to_asm().

IBS profiling report with this patch:

# hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100

# Overhead  Command          Shared Object         Symbol
# ........  ...............  ....................  ..............................................
#
      9.41%  hackbench        [kernel.vmlinux]      [k] finish_task_switch.isra.0
      7.09%  hackbench        [kernel.vmlinux]      [k] __switch_to_asm
      4.97%  hackbench        [kernel.vmlinux]      [k] try_to_wake_up
      4.67%  hackbench        [kernel.vmlinux]      [k] native_queued_spin_lock_slowpath
      4.41%  hackbench        [kernel.vmlinux]      [k] finish_wait
      4.38%  hackbench        [kernel.vmlinux]      [k] __schedule
      4.06%  hackbench        [kernel.vmlinux]      [k] copyin
      4.00%  hackbench        [kernel.vmlinux]      [k] copyout
      3.46%  hackbench        [kernel.vmlinux]      [k] apparmor_file_permission
      2.58%  hackbench        [kernel.vmlinux]      [k] pipe_write
      2.56%  hackbench        [kernel.vmlinux]      [k] reweight_entity

Please let me know if you need any other data.

--
Thanks and Regards,
Swapnil

> ---
>   include/linux/mm_types.h |  82 +++++-
>   include/linux/sched.h    |   3 +-
>   include/linux/sched/mm.h |   5 +-
>   kernel/fork.c            |   9 +-
>   kernel/sched/core.c      | 523 ++++++++++++++++++++++++++++++++++++--
>   kernel/sched/sched.h     | 239 ++++++++++++++---
>   6 files changed, 804 insertions(+), 57 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index a57e6ae..5eab611 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -550,6 +550,13 @@ struct vm_area_struct {
>   	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
>   } __randomize_layout;
>   
> +#ifdef CONFIG_SCHED_MM_CID
> +struct mm_cid {
> +	u64 time;
> +	int cid;
> +};
> +#endif
> +
>   struct kioctx_table;
>   struct mm_struct {
>   	struct {
> @@ -600,15 +607,19 @@ struct mm_struct {
>   		atomic_t mm_count;
>   #ifdef CONFIG_SCHED_MM_CID
>   		/**
> -		 * @cid_lock: Protect cid bitmap updates vs lookups.
> +		 * @pcpu_cid: Per-cpu current cid.
>   		 *
> -		 * Prevent situations where updates to the cid bitmap happen
> -		 * concurrently with lookups. Those can lead to situations
> -		 * where a lookup cannot find a free bit simply because it was
> -		 * unlucky enough to load, non-atomically, bitmap words as they
> -		 * were being concurrently updated by the updaters.
> +		 * Keep track of the currently allocated mm_cid for each cpu.
> +		 * The per-cpu mm_cid values are serialized by their respective
> +		 * runqueue locks.
>   		 */
> -		raw_spinlock_t cid_lock;
> +		struct mm_cid __percpu *pcpu_cid;
> +		/*
> +		 * @mm_cid_next_scan: Next mm_cid scan (in jiffies).
> +		 *
> +		 * When the next mm_cid scan is due (in jiffies).
> +		 */
> +		unsigned long mm_cid_next_scan;
>   #endif
>   #ifdef CONFIG_MMU
>   		atomic_long_t pgtables_bytes;	/* size of all page tables */
> @@ -873,6 +884,37 @@ static inline void vma_iter_init(struct vma_iterator *vmi,
>   }
>   
>   #ifdef CONFIG_SCHED_MM_CID
> +
> +enum mm_cid_state {
> +	MM_CID_UNSET = -1U,		/* Unset state has lazy_put flag set. */
> +	MM_CID_LAZY_PUT = (1U << 31),
> +};
> +
> +static inline bool mm_cid_is_unset(int cid)
> +{
> +	return cid == MM_CID_UNSET;
> +}
> +
> +static inline bool mm_cid_is_lazy_put(int cid)
> +{
> +	return !mm_cid_is_unset(cid) && (cid & MM_CID_LAZY_PUT);
> +}
> +
> +static inline bool mm_cid_is_valid(int cid)
> +{
> +	return !(cid & MM_CID_LAZY_PUT);
> +}
> +
> +static inline int mm_cid_set_lazy_put(int cid)
> +{
> +	return cid | MM_CID_LAZY_PUT;
> +}
> +
> +static inline int mm_cid_clear_lazy_put(int cid)
> +{
> +	return cid & ~MM_CID_LAZY_PUT;
> +}
> +
>   /* Accessor for struct mm_struct's cidmask. */
>   static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
>   {
> @@ -886,16 +928,40 @@ static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
>   
>   static inline void mm_init_cid(struct mm_struct *mm)
>   {
> -	raw_spin_lock_init(&mm->cid_lock);
> +	int i;
> +
> +	for_each_possible_cpu(i) {
> +		struct mm_cid *pcpu_cid = per_cpu_ptr(mm->pcpu_cid, i);
> +
> +		pcpu_cid->cid = MM_CID_UNSET;
> +		pcpu_cid->time = 0;
> +	}
>   	cpumask_clear(mm_cidmask(mm));
>   }
>   
> +static inline int mm_alloc_cid(struct mm_struct *mm)
> +{
> +	mm->pcpu_cid = alloc_percpu(struct mm_cid);
> +	if (!mm->pcpu_cid)
> +		return -ENOMEM;
> +	mm_init_cid(mm);
> +	return 0;
> +}
> +
> +static inline void mm_destroy_cid(struct mm_struct *mm)
> +{
> +	free_percpu(mm->pcpu_cid);
> +	mm->pcpu_cid = NULL;
> +}
> +
>   static inline unsigned int mm_cid_size(void)
>   {
>   	return cpumask_size();
>   }
>   #else /* CONFIG_SCHED_MM_CID */
>   static inline void mm_init_cid(struct mm_struct *mm) { }
> +static inline int mm_alloc_cid(struct mm_struct *mm) { return 0; }
> +static inline void mm_destroy_cid(struct mm_struct *mm) { }
>   static inline unsigned int mm_cid_size(void)
>   {
>   	return 0;
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 6d654eb..675298d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1314,7 +1314,10 @@ struct task_struct {
>   
>   #ifdef CONFIG_SCHED_MM_CID
>   	int				mm_cid;		/* Current cid in mm */
> +	int				last_mm_cid;	/* Most recent cid in mm */
> +	int				migrate_from_cpu;
>   	int				mm_cid_active;	/* Whether cid bitmap is active */
> +	struct callback_head		cid_work;
>   #endif
>   
>   	struct tlbflush_unmap_batch	tlb_ubc;
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 2a24361..f20fc06 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -37,6 +37,11 @@ static inline void mmgrab(struct mm_struct *mm)
>   	atomic_inc(&mm->mm_count);
>   }
>   
> +static inline void smp_mb__after_mmgrab(void)
> +{
> +	smp_mb__after_atomic();
> +}
> +
>   extern void __mmdrop(struct mm_struct *mm);
>   
>   static inline void mmdrop(struct mm_struct *mm)
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 0c92f22..ad2ee22 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -793,6 +793,7 @@ void __mmdrop(struct mm_struct *mm)
>   	check_mm(mm);
>   	put_user_ns(mm->user_ns);
>   	mm_pasid_drop(mm);
> +	mm_destroy_cid(mm);
>   
>   	for (i = 0; i < NR_MM_COUNTERS; i++)
>   		percpu_counter_destroy(&mm->rss_stat[i]);
> @@ -1057,7 +1058,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>   
>   #ifdef CONFIG_SCHED_MM_CID
>   	tsk->mm_cid = -1;
> +	tsk->last_mm_cid = -1;
>   	tsk->mm_cid_active = 0;
> +	tsk->migrate_from_cpu = -1;
>   #endif
>   	return tsk;
>   
> @@ -1162,18 +1165,22 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>   	if (init_new_context(p, mm))
>   		goto fail_nocontext;
>   
> +	if (mm_alloc_cid(mm))
> +		goto fail_cid;
> +
>   	for (i = 0; i < NR_MM_COUNTERS; i++)
>   		if (percpu_counter_init(&mm->rss_stat[i], 0, GFP_KERNEL_ACCOUNT))
>   			goto fail_pcpu;
>   
>   	mm->user_ns = get_user_ns(user_ns);
>   	lru_gen_init_mm(mm);
> -	mm_init_cid(mm);
>   	return mm;
>   
>   fail_pcpu:
>   	while (i > 0)
>   		percpu_counter_destroy(&mm->rss_stat[--i]);
> +	mm_destroy_cid(mm);
> +fail_cid:
>   fail_nocontext:
>   	mm_free_pgd(mm);
>   fail_nopgd:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5a97ceb..898fa3b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2101,6 +2101,8 @@ void activate_task(struct rq *rq, struct task_struct *p, int flags)
>   {
>   	if (task_on_rq_migrating(p))
>   		flags |= ENQUEUE_MIGRATED;
> +	if (flags & ENQUEUE_MIGRATED)
> +		sched_mm_cid_migrate_to(rq, p);
>   
>   	enqueue_task(rq, p, flags);
>   
> @@ -3210,6 +3212,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>   			p->sched_class->migrate_task_rq(p, new_cpu);
>   		p->se.nr_migrations++;
>   		rseq_migrate(p);
> +		sched_mm_cid_migrate_from(p);
>   		perf_event_task_migrate(p);
>   	}
>   
> @@ -4483,6 +4486,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>   	p->wake_entry.u_flags = CSD_TYPE_TTWU;
>   	p->migration_pending = NULL;
>   #endif
> +	init_sched_mm_cid(p);
>   }
>   
>   DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
> @@ -5129,7 +5133,6 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
>   	sched_info_switch(rq, prev, next);
>   	perf_event_task_sched_out(prev, next);
>   	rseq_preempt(prev);
> -	switch_mm_cid(prev, next);
>   	fire_sched_out_preempt_notifiers(prev, next);
>   	kmap_local_sched_out();
>   	prepare_task(next);
> @@ -5285,6 +5288,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
>   	 *
>   	 * kernel ->   user   switch + mmdrop() active
>   	 *   user ->   user   switch
> +	 *
> +	 * switch_mm_cid() needs to be updated if the barriers provided
> +	 * by context_switch() are modified.
>   	 */
>   	if (!next->mm) {                                // to kernel
>   		enter_lazy_tlb(prev->active_mm, next);
> @@ -5314,6 +5320,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
>   		}
>   	}
>   
> +	/* switch_mm_cid() requires the memory barriers above. */
> +	switch_mm_cid(rq, prev, next);
> +
>   	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
>   
>   	prepare_lock_switch(rq, next, rf);
> @@ -5602,6 +5611,7 @@ void scheduler_tick(void)
>   		resched_latency = cpu_resched_latency(rq);
>   	calc_global_load_tick(rq);
>   	sched_core_tick(rq);
> +	task_tick_mm_cid(rq, curr);
>   
>   	rq_unlock(rq, &rf);
>   
> @@ -11469,45 +11479,524 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
>   }
>   
>   #ifdef CONFIG_SCHED_MM_CID
> -void sched_mm_cid_exit_signals(struct task_struct *t)
> +
> +/**
> + * @cid_lock: Guarantee forward-progress of cid allocation.
> + *
> + * Concurrency ID allocation within a bitmap is mostly lock-free. The cid_lock
> + * is only used when contention is detected by the lock-free allocation so
> + * forward progress can be guaranteed.
> + */
> +DEFINE_RAW_SPINLOCK(cid_lock);
> +
> +/**
> + * @use_cid_lock: Select cid allocation behavior: lock-free vs spinlock.
> + *
> + * When @use_cid_lock is 0, the cid allocation is lock-free. When contention is
> + * detected, it is set to 1 to ensure that all newly coming allocations are
> + * serialized by @cid_lock until the allocation which detected contention
> + * completes and sets @use_cid_lock back to 0. This guarantees forward progress
> + * of a cid allocation.
> + */
> +int use_cid_lock;
> +
> +/*
> + * mm_cid remote-clear implements a lock-free algorithm to clear per-mm/cpu cid
> + * concurrently with respect to the execution of the source runqueue context
> + * switch.
> + *
> + * There is one basic properties we want to guarantee here:
> + *
> + * (1) Remote-clear should _never_ mark a per-cpu cid UNSET when it is actively
> + * used by a task. That would lead to concurrent allocation of the cid and
> + * userspace corruption.
> + *
> + * Provide this guarantee by introducing a Dekker memory ordering to guarantee
> + * that a pair of loads observe at least one of a pair of stores, which can be
> + * shown as:
> + *
> + *      X = Y = 0
> + *
> + *      w[X]=1          w[Y]=1
> + *      MB              MB
> + *      r[Y]=y          r[X]=x
> + *
> + * Which guarantees that x==0 && y==0 is impossible. But rather than using
> + * values 0 and 1, this algorithm cares about specific state transitions of the
> + * runqueue current task (as updated by the scheduler context switch), and the
> + * per-mm/cpu cid value.
> + *
> + * Let's introduce task (Y) which has task->mm == mm and task (N) which has
> + * task->mm != mm for the rest of the discussion. There are two scheduler state
> + * transitions on context switch we care about:
> + *
> + * (TSA) Store to rq->curr with transition from (N) to (Y)
> + *
> + * (TSB) Store to rq->curr with transition from (Y) to (N)
> + *
> + * On the remote-clear side, there is one transition we care about:
> + *
> + * (TMA) cmpxchg to *pcpu_cid to set the LAZY flag
> + *
> + * There is also a transition to UNSET state which can be performed from all
> + * sides (scheduler, remote-clear). It is always performed with a cmpxchg which
> + * guarantees that only a single thread will succeed:
> + *
> + * (TMB) cmpxchg to *pcpu_cid to mark UNSET
> + *
> + * Just to be clear, what we do _not_ want to happen is a transition to UNSET
> + * when a thread is actively using the cid (property (1)).
> + *
> + * Let's looks at the relevant combinations of TSA/TSB, and TMA transitions.
> + *
> + * Scenario A) (TSA)+(TMA) (from next task perspective)
> + *
> + * CPU0                                      CPU1
> + *
> + * Context switch CS-1                       Remote-clear
> + *   - store to rq->curr: (N)->(Y) (TSA)     - cmpxchg to *pcpu_id to LAZY (TMA)
> + *                                             (implied barrier after cmpxchg)
> + *   - switch_mm_cid()
> + *     - memory barrier (see switch_mm_cid()
> + *       comment explaining how this barrier
> + *       is combined with other scheduler
> + *       barriers)
> + *     - mm_cid_get (next)
> + *       - READ_ONCE(*pcpu_cid)              - rcu_dereference(src_rq->curr)
> + *
> + * This Dekker ensures that either task (Y) is observed by the
> + * rcu_dereference() or the LAZY flag is observed by READ_ONCE(), or both are
> + * observed.
> + *
> + * If task (Y) store is observed by rcu_dereference(), it means that there is
> + * still an active task on the cpu. Remote-clear will therefore not transition
> + * to UNSET, which fulfills property (1).
> + *
> + * If task (Y) is not observed, but the lazy flag is observed by READ_ONCE(),
> + * it will move its state to UNSET, which clears the percpu cid perhaps
> + * uselessly (which is not an issue for correctness). Because task (Y) is not
> + * observed, CPU1 can move ahead to set the state to UNSET. Because moving
> + * state to UNSET is done with a cmpxchg expecting that the old state has the
> + * LAZY flag set, only one thread will successfully UNSET.
> + *
> + * If both states (LAZY flag and task (Y)) are observed, the thread on CPU0
> + * will observe the LAZY flag and transition to UNSET (perhaps uselessly), and
> + * CPU1 will observe task (Y) and do nothing more, which is fine.
> + *
> + * What we are effectively preventing with this Dekker is a scenario where
> + * neither LAZY flag nor store (Y) are observed, which would fail property (1)
> + * because this would UNSET a cid which is actively used.
> + */
> +
> +void sched_mm_cid_migrate_from(struct task_struct *t)
> +{
> +	t->migrate_from_cpu = task_cpu(t);
> +}
> +
> +static
> +int __sched_mm_cid_migrate_from_fetch_cid(struct rq *src_rq,
> +					  struct task_struct *t,
> +					  struct mm_cid *src_pcpu_cid)
>   {
>   	struct mm_struct *mm = t->mm;
> -	unsigned long flags;
> +	struct task_struct *src_task;
> +	int src_cid, last_mm_cid;
>   
>   	if (!mm)
> +		return -1;
> +
> +	last_mm_cid = t->last_mm_cid;
> +	/*
> +	 * If the migrated task has no last cid, or if the current
> +	 * task on src rq uses the cid, it means the source cid does not need
> +	 * to be moved to the destination cpu.
> +	 */
> +	if (last_mm_cid == -1)
> +		return -1;
> +	src_cid = READ_ONCE(src_pcpu_cid->cid);
> +	if (!mm_cid_is_valid(src_cid) || last_mm_cid != src_cid)
> +		return -1;
> +
> +	/*
> +	 * If we observe an active task using the mm on this rq, it means we
> +	 * are not the last task to be migrated from this cpu for this mm, so
> +	 * there is no need to move src_cid to the destination cpu.
> +	 */
> +	rcu_read_lock();
> +	src_task = rcu_dereference(src_rq->curr);
> +	if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
> +		rcu_read_unlock();
> +		t->last_mm_cid = -1;
> +		return -1;
> +	}
> +	rcu_read_unlock();
> +
> +	return src_cid;
> +}
> +
> +static
> +int __sched_mm_cid_migrate_from_try_steal_cid(struct rq *src_rq,
> +					      struct task_struct *t,
> +					      struct mm_cid *src_pcpu_cid,
> +					      int src_cid)
> +{
> +	struct task_struct *src_task;
> +	struct mm_struct *mm = t->mm;
> +	int lazy_cid;
> +
> +	if (src_cid == -1)
> +		return -1;
> +
> +	/*
> +	 * Attempt to clear the source cpu cid to move it to the destination
> +	 * cpu.
> +	 */
> +	lazy_cid = mm_cid_set_lazy_put(src_cid);
> +	if (!try_cmpxchg(&src_pcpu_cid->cid, &src_cid, lazy_cid))
> +		return -1;
> +
> +	/*
> +	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
> +	 * rq->curr->mm matches the scheduler barrier in context_switch()
> +	 * between store to rq->curr and load of prev and next task's
> +	 * per-mm/cpu cid.
> +	 *
> +	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
> +	 * rq->curr->mm_cid_active matches the barrier in
> +	 * sched_mm_cid_exit_signals(), sched_mm_cid_before_execve(), and
> +	 * sched_mm_cid_after_execve() between store to t->mm_cid_active and
> +	 * load of per-mm/cpu cid.
> +	 */
> +
> +	/*
> +	 * If we observe an active task using the mm on this rq after setting
> +	 * the lazy-put flag, this task will be responsible for transitioning
> +	 * from lazy-put flag set to MM_CID_UNSET.
> +	 */
> +	rcu_read_lock();
> +	src_task = rcu_dereference(src_rq->curr);
> +	if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
> +		rcu_read_unlock();
> +		/*
> +		 * We observed an active task for this mm, there is therefore
> +		 * no point in moving this cid to the destination cpu.
> +		 */
> +		t->last_mm_cid = -1;
> +		return -1;
> +	}
> +	rcu_read_unlock();
> +
> +	/*
> +	 * The src_cid is unused, so it can be unset.
> +	 */
> +	if (!try_cmpxchg(&src_pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
> +		return -1;
> +	return src_cid;
> +}
> +
> +/*
> + * Migration to dst cpu. Called with dst_rq lock held.
> + * Interrupts are disabled, which keeps the window of cid ownership without the
> + * source rq lock held small.
> + */
> +void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
> +{
> +	struct mm_cid *src_pcpu_cid, *dst_pcpu_cid;
> +	struct mm_struct *mm = t->mm;
> +	int src_cid, dst_cid, src_cpu;
> +	struct rq *src_rq;
> +
> +	lockdep_assert_rq_held(dst_rq);
> +
> +	if (!mm)
> +		return;
> +	src_cpu = t->migrate_from_cpu;
> +	if (src_cpu == -1) {
> +		t->last_mm_cid = -1;
> +		return;
> +	}
> +	/*
> +	 * Move the src cid if the dst cid is unset. This keeps id
> +	 * allocation closest to 0 in cases where few threads migrate around
> +	 * many cpus.
> +	 *
> +	 * If destination cid is already set, we may have to just clear
> +	 * the src cid to ensure compactness in frequent migrations
> +	 * scenarios.
> +	 *
> +	 * It is not useful to clear the src cid when the number of threads is
> +	 * greater or equal to the number of allowed cpus, because user-space
> +	 * can expect that the number of allowed cids can reach the number of
> +	 * allowed cpus.
> +	 */
> +	dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
> +	dst_cid = READ_ONCE(dst_pcpu_cid->cid);
> +	if (!mm_cid_is_unset(dst_cid) &&
> +	    atomic_read(&mm->mm_users) >= t->nr_cpus_allowed)
> +		return;
> +	src_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, src_cpu);
> +	src_rq = cpu_rq(src_cpu);
> +	src_cid = __sched_mm_cid_migrate_from_fetch_cid(src_rq, t, src_pcpu_cid);
> +	if (src_cid == -1)
> +		return;
> +	src_cid = __sched_mm_cid_migrate_from_try_steal_cid(src_rq, t, src_pcpu_cid,
> +							    src_cid);
> +	if (src_cid == -1)
> +		return;
> +	if (!mm_cid_is_unset(dst_cid)) {
> +		__mm_cid_put(mm, src_cid);
> +		return;
> +	}
> +	/* Move src_cid to dst cpu. */
> +	mm_cid_snapshot_time(dst_rq, mm);
> +	WRITE_ONCE(dst_pcpu_cid->cid, src_cid);
> +}
> +
> +static void sched_mm_cid_remote_clear(struct mm_struct *mm, struct mm_cid *pcpu_cid,
> +				      int cpu)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +	struct task_struct *t;
> +	unsigned long flags;
> +	int cid, lazy_cid;
> +
> +	cid = READ_ONCE(pcpu_cid->cid);
> +	if (!mm_cid_is_valid(cid))
>   		return;
> +
> +	/*
> +	 * Clear the cpu cid if it is set to keep cid allocation compact.  If
> +	 * there happens to be other tasks left on the source cpu using this
> +	 * mm, the next task using this mm will reallocate its cid on context
> +	 * switch.
> +	 */
> +	lazy_cid = mm_cid_set_lazy_put(cid);
> +	if (!try_cmpxchg(&pcpu_cid->cid, &cid, lazy_cid))
> +		return;
> +
> +	/*
> +	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
> +	 * rq->curr->mm matches the scheduler barrier in context_switch()
> +	 * between store to rq->curr and load of prev and next task's
> +	 * per-mm/cpu cid.
> +	 *
> +	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
> +	 * rq->curr->mm_cid_active matches the barrier in
> +	 * sched_mm_cid_exit_signals(), sched_mm_cid_before_execve(), and
> +	 * sched_mm_cid_after_execve() between store to t->mm_cid_active and
> +	 * load of per-mm/cpu cid.
> +	 */
> +
> +	/*
> +	 * If we observe an active task using the mm on this rq after setting
> +	 * the lazy-put flag, that task will be responsible for transitioning
> +	 * from lazy-put flag set to MM_CID_UNSET.
> +	 */
> +	rcu_read_lock();
> +	t = rcu_dereference(rq->curr);
> +	if (READ_ONCE(t->mm_cid_active) && t->mm == mm) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +	rcu_read_unlock();
> +
> +	/*
> +	 * The cid is unused, so it can be unset.
> +	 * Disable interrupts to keep the window of cid ownership without rq
> +	 * lock small.
> +	 */
>   	local_irq_save(flags);
> -	mm_cid_put(mm, t->mm_cid);
> -	t->mm_cid = -1;
> -	t->mm_cid_active = 0;
> +	if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
> +		__mm_cid_put(mm, cid);
>   	local_irq_restore(flags);
>   }
>   
> +static void sched_mm_cid_remote_clear_old(struct mm_struct *mm, int cpu)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +	struct mm_cid *pcpu_cid;
> +	struct task_struct *curr;
> +	u64 rq_clock;
> +
> +	/*
> +	 * rq->clock load is racy on 32-bit but one spurious clear once in a
> +	 * while is irrelevant.
> +	 */
> +	rq_clock = READ_ONCE(rq->clock);
> +	pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu);
> +
> +	/*
> +	 * In order to take care of infrequently scheduled tasks, bump the time
> +	 * snapshot associated with this cid if an active task using the mm is
> +	 * observed on this rq.
> +	 */
> +	rcu_read_lock();
> +	curr = rcu_dereference(rq->curr);
> +	if (READ_ONCE(curr->mm_cid_active) && curr->mm == mm) {
> +		WRITE_ONCE(pcpu_cid->time, rq_clock);
> +		rcu_read_unlock();
> +		return;
> +	}
> +	rcu_read_unlock();
> +
> +	if (rq_clock < pcpu_cid->time + SCHED_MM_CID_PERIOD_NS)
> +		return;
> +	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
> +}
> +
> +static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
> +					     int weight)
> +{
> +	struct mm_cid *pcpu_cid;
> +	int cid;
> +
> +	pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu);
> +	cid = READ_ONCE(pcpu_cid->cid);
> +	if (!mm_cid_is_valid(cid) || cid < weight)
> +		return;
> +	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
> +}
> +
> +static void task_mm_cid_work(struct callback_head *work)
> +{
> +	unsigned long now = jiffies, old_scan, next_scan;
> +	struct task_struct *t = current;
> +	struct cpumask *cidmask;
> +	struct mm_struct *mm;
> +	int weight, cpu;
> +
> +	SCHED_WARN_ON(t != container_of(work, struct task_struct, cid_work));
> +
> +	work->next = work;	/* Prevent double-add */
> +	if (t->flags & PF_EXITING)
> +		return;
> +	mm = t->mm;
> +	if (!mm)
> +		return;
> +	old_scan = READ_ONCE(mm->mm_cid_next_scan);
> +	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
> +	if (!old_scan) {
> +		unsigned long res;
> +
> +		res = cmpxchg(&mm->mm_cid_next_scan, old_scan, next_scan);
> +		if (res != old_scan)
> +			old_scan = res;
> +		else
> +			old_scan = next_scan;
> +	}
> +	if (time_before(now, old_scan))
> +		return;
> +	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
> +		return;
> +	cidmask = mm_cidmask(mm);
> +	/* Clear cids that were not recently used. */
> +	for_each_possible_cpu(cpu)
> +		sched_mm_cid_remote_clear_old(mm, cpu);
> +	weight = cpumask_weight(cidmask);
> +	/*
> +	 * Clear cids that are greater or equal to the cidmask weight to
> +	 * recompact it.
> +	 */
> +	for_each_possible_cpu(cpu)
> +		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
> +}
> +
> +void init_sched_mm_cid(struct task_struct *t)
> +{
> +	struct mm_struct *mm = t->mm;
> +	int mm_users = 0;
> +
> +	if (mm) {
> +		mm_users = atomic_read(&mm->mm_users);
> +		if (mm_users == 1)
> +			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
> +	}
> +	t->cid_work.next = &t->cid_work;	/* Protect against double add */
> +	init_task_work(&t->cid_work, task_mm_cid_work);
> +}
> +
> +void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
> +{
> +	struct callback_head *work = &curr->cid_work;
> +	unsigned long now = jiffies;
> +
> +	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
> +	    work->next != work)
> +		return;
> +	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
> +		return;
> +	task_work_add(curr, work, TWA_RESUME);
> +}
> +
> +void sched_mm_cid_exit_signals(struct task_struct *t)
> +{
> +	struct mm_struct *mm = t->mm;
> +	struct rq_flags rf;
> +	struct rq *rq;
> +
> +	if (!mm)
> +		return;
> +
> +	preempt_disable();
> +	rq = this_rq();
> +	rq_lock_irqsave(rq, &rf);
> +	preempt_enable_no_resched();	/* holding spinlock */
> +	WRITE_ONCE(t->mm_cid_active, 0);
> +	/*
> +	 * Store t->mm_cid_active before loading per-mm/cpu cid.
> +	 * Matches barrier in sched_mm_cid_remote_clear_old().
> +	 */
> +	smp_mb();
> +	mm_cid_put(mm);
> +	t->last_mm_cid = t->mm_cid = -1;
> +	rq_unlock_irqrestore(rq, &rf);
> +}
> +
>   void sched_mm_cid_before_execve(struct task_struct *t)
>   {
>   	struct mm_struct *mm = t->mm;
> -	unsigned long flags;
> +	struct rq_flags rf;
> +	struct rq *rq;
>   
>   	if (!mm)
>   		return;
> -	local_irq_save(flags);
> -	mm_cid_put(mm, t->mm_cid);
> -	t->mm_cid = -1;
> -	t->mm_cid_active = 0;
> -	local_irq_restore(flags);
> +
> +	preempt_disable();
> +	rq = this_rq();
> +	rq_lock_irqsave(rq, &rf);
> +	preempt_enable_no_resched();	/* holding spinlock */
> +	WRITE_ONCE(t->mm_cid_active, 0);
> +	/*
> +	 * Store t->mm_cid_active before loading per-mm/cpu cid.
> +	 * Matches barrier in sched_mm_cid_remote_clear_old().
> +	 */
> +	smp_mb();
> +	mm_cid_put(mm);
> +	t->last_mm_cid = t->mm_cid = -1;
> +	rq_unlock_irqrestore(rq, &rf);
>   }
>   
>   void sched_mm_cid_after_execve(struct task_struct *t)
>   {
>   	struct mm_struct *mm = t->mm;
> -	unsigned long flags;
> +	struct rq_flags rf;
> +	struct rq *rq;
>   
>   	if (!mm)
>   		return;
> -	local_irq_save(flags);
> -	t->mm_cid = mm_cid_get(mm);
> -	t->mm_cid_active = 1;
> -	local_irq_restore(flags);
> +
> +	preempt_disable();
> +	rq = this_rq();
> +	rq_lock_irqsave(rq, &rf);
> +	preempt_enable_no_resched();	/* holding spinlock */
> +	WRITE_ONCE(t->mm_cid_active, 1);
> +	/*
> +	 * Store t->mm_cid_active before loading per-mm/cpu cid.
> +	 * Matches barrier in sched_mm_cid_remote_clear_old().
> +	 */
> +	smp_mb();
> +	t->last_mm_cid = t->mm_cid = mm_cid_get(rq, mm);
> +	rq_unlock_irqrestore(rq, &rf);
>   	rseq_set_notify_resume(t);
>   }
>   
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 0606169..ec7b3e0 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3253,61 +3253,238 @@ static inline void update_current_exec_runtime(struct task_struct *curr,
>   }
>   
>   #ifdef CONFIG_SCHED_MM_CID
> -static inline int __mm_cid_get(struct mm_struct *mm)
> +
> +#define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
> +#define MM_CID_SCAN_DELAY	100			/* 100ms */
> +
> +extern raw_spinlock_t cid_lock;
> +extern int use_cid_lock;
> +
> +extern void sched_mm_cid_migrate_from(struct task_struct *t);
> +extern void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t);
> +extern void task_tick_mm_cid(struct rq *rq, struct task_struct *curr);
> +extern void init_sched_mm_cid(struct task_struct *t);
> +
> +static inline void __mm_cid_put(struct mm_struct *mm, int cid)
> +{
> +	if (cid < 0)
> +		return;
> +	cpumask_clear_cpu(cid, mm_cidmask(mm));
> +}
> +
> +/*
> + * The per-mm/cpu cid can have the MM_CID_LAZY_PUT flag set or transition to
> + * the MM_CID_UNSET state without holding the rq lock, but the rq lock needs to
> + * be held to transition to other states.
> + *
> + * State transitions synchronized with cmpxchg or try_cmpxchg need to be
> + * consistent across cpus, which prevents use of this_cpu_cmpxchg.
> + */
> +static inline void mm_cid_put_lazy(struct task_struct *t)
> +{
> +	struct mm_struct *mm = t->mm;
> +	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
> +	int cid;
> +
> +	lockdep_assert_irqs_disabled();
> +	cid = __this_cpu_read(pcpu_cid->cid);
> +	if (!mm_cid_is_lazy_put(cid) ||
> +	    !try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
> +		return;
> +	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
> +}
> +
> +static inline int mm_cid_pcpu_unset(struct mm_struct *mm)
> +{
> +	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
> +	int cid, res;
> +
> +	lockdep_assert_irqs_disabled();
> +	cid = __this_cpu_read(pcpu_cid->cid);
> +	for (;;) {
> +		if (mm_cid_is_unset(cid))
> +			return MM_CID_UNSET;
> +		/*
> +		 * Attempt transition from valid or lazy-put to unset.
> +		 */
> +		res = cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, cid, MM_CID_UNSET);
> +		if (res == cid)
> +			break;
> +		cid = res;
> +	}
> +	return cid;
> +}
> +
> +static inline void mm_cid_put(struct mm_struct *mm)
> +{
> +	int cid;
> +
> +	lockdep_assert_irqs_disabled();
> +	cid = mm_cid_pcpu_unset(mm);
> +	if (cid == MM_CID_UNSET)
> +		return;
> +	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
> +}
> +
> +static inline int __mm_cid_try_get(struct mm_struct *mm)
>   {
>   	struct cpumask *cpumask;
>   	int cid;
>   
>   	cpumask = mm_cidmask(mm);
> -	cid = cpumask_first_zero(cpumask);
> -	if (cid >= nr_cpu_ids)
> +	/*
> +	 * Retry finding first zero bit if the mask is temporarily
> +	 * filled. This only happens during concurrent remote-clear
> +	 * which owns a cid without holding a rq lock.
> +	 */
> +	for (;;) {
> +		cid = cpumask_first_zero(cpumask);
> +		if (cid < nr_cpu_ids)
> +			break;
> +		cpu_relax();
> +	}
> +	if (cpumask_test_and_set_cpu(cid, cpumask))
>   		return -1;
> -	__cpumask_set_cpu(cid, cpumask);
>   	return cid;
>   }
>   
> -static inline void mm_cid_put(struct mm_struct *mm, int cid)
> +/*
> + * Save a snapshot of the current runqueue time of this cpu
> + * with the per-cpu cid value, allowing to estimate how recently it was used.
> + */
> +static inline void mm_cid_snapshot_time(struct rq *rq, struct mm_struct *mm)
>   {
> -	lockdep_assert_irqs_disabled();
> -	if (cid < 0)
> -		return;
> -	raw_spin_lock(&mm->cid_lock);
> -	__cpumask_clear_cpu(cid, mm_cidmask(mm));
> -	raw_spin_unlock(&mm->cid_lock);
> +	struct mm_cid *pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(rq));
> +
> +	lockdep_assert_rq_held(rq);
> +	WRITE_ONCE(pcpu_cid->time, rq->clock);
>   }
>   
> -static inline int mm_cid_get(struct mm_struct *mm)
> +static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
>   {
> -	int ret;
> +	int cid;
>   
> -	lockdep_assert_irqs_disabled();
> -	raw_spin_lock(&mm->cid_lock);
> -	ret = __mm_cid_get(mm);
> -	raw_spin_unlock(&mm->cid_lock);
> -	return ret;
> +	/*
> +	 * All allocations (even those using the cid_lock) are lock-free. If
> +	 * use_cid_lock is set, hold the cid_lock to perform cid allocation to
> +	 * guarantee forward progress.
> +	 */
> +	if (!READ_ONCE(use_cid_lock)) {
> +		cid = __mm_cid_try_get(mm);
> +		if (cid >= 0)
> +			goto end;
> +		raw_spin_lock(&cid_lock);
> +	} else {
> +		raw_spin_lock(&cid_lock);
> +		cid = __mm_cid_try_get(mm);
> +		if (cid >= 0)
> +			goto unlock;
> +	}
> +
> +	/*
> +	 * cid concurrently allocated. Retry while forcing following
> +	 * allocations to use the cid_lock to ensure forward progress.
> +	 */
> +	WRITE_ONCE(use_cid_lock, 1);
> +	/*
> +	 * Set use_cid_lock before allocation. Only care about program order
> +	 * because this is only required for forward progress.
> +	 */
> +	barrier();
> +	/*
> +	 * Retry until it succeeds. It is guaranteed to eventually succeed once
> +	 * all newcoming allocations observe the use_cid_lock flag set.
> +	 */
> +	do {
> +		cid = __mm_cid_try_get(mm);
> +		cpu_relax();
> +	} while (cid < 0);
> +	/*
> +	 * Allocate before clearing use_cid_lock. Only care about
> +	 * program order because this is for forward progress.
> +	 */
> +	barrier();
> +	WRITE_ONCE(use_cid_lock, 0);
> +unlock:
> +	raw_spin_unlock(&cid_lock);
> +end:
> +	mm_cid_snapshot_time(rq, mm);
> +	return cid;
>   }
>   
> -static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next)
> +static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
>   {
> +	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
> +	struct cpumask *cpumask;
> +	int cid;
> +
> +	lockdep_assert_rq_held(rq);
> +	cpumask = mm_cidmask(mm);
> +	cid = __this_cpu_read(pcpu_cid->cid);
> +	if (mm_cid_is_valid(cid)) {
> +		mm_cid_snapshot_time(rq, mm);
> +		return cid;
> +	}
> +	if (mm_cid_is_lazy_put(cid)) {
> +		if (try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
> +			__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
> +	}
> +	cid = __mm_cid_get(rq, mm);
> +	__this_cpu_write(pcpu_cid->cid, cid);
> +	return cid;
> +}
> +
> +static inline void switch_mm_cid(struct rq *rq,
> +				 struct task_struct *prev,
> +				 struct task_struct *next)
> +{
> +	/*
> +	 * Provide a memory barrier between rq->curr store and load of
> +	 * {prev,next}->mm->pcpu_cid[cpu] on rq->curr->mm transition.
> +	 *
> +	 * Should be adapted if context_switch() is modified.
> +	 */
> +	if (!next->mm) {                                // to kernel
> +		/*
> +		 * user -> kernel transition does not guarantee a barrier, but
> +		 * we can use the fact that it performs an atomic operation in
> +		 * mmgrab().
> +		 */
> +		if (prev->mm)                           // from user
> +			smp_mb__after_mmgrab();
> +		/*
> +		 * kernel -> kernel transition does not change rq->curr->mm
> +		 * state. It stays NULL.
> +		 */
> +	} else {                                        // to user
> +		/*
> +		 * kernel -> user transition does not provide a barrier
> +		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
> +		 * Provide it here.
> +		 */
> +		if (!prev->mm)                          // from kernel
> +			smp_mb();
> +		/*
> +		 * user -> user transition guarantees a memory barrier through
> +		 * switch_mm() when current->mm changes. If current->mm is
> +		 * unchanged, no barrier is needed.
> +		 */
> +	}
>   	if (prev->mm_cid_active) {
> -		if (next->mm_cid_active && next->mm == prev->mm) {
> -			/*
> -			 * Context switch between threads in same mm, hand over
> -			 * the mm_cid from prev to next.
> -			 */
> -			next->mm_cid = prev->mm_cid;
> -			prev->mm_cid = -1;
> -			return;
> -		}
> -		mm_cid_put(prev->mm, prev->mm_cid);
> +		mm_cid_snapshot_time(rq, prev->mm);
> +		mm_cid_put_lazy(prev);
>   		prev->mm_cid = -1;
>   	}
>   	if (next->mm_cid_active)
> -		next->mm_cid = mm_cid_get(next->mm);
> +		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next->mm);
>   }
>   
>   #else
> -static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next) { }
> +static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev, struct task_struct *next) { }
> +static inline void sched_mm_cid_migrate_from(struct task_struct *t) { }
> +static inline void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t) { }
> +static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
> +static inline void init_sched_mm_cid(struct task_struct *t) { }
>   #endif
>   
>   #endif /* _KERNEL_SCHED_SCHED_H */
