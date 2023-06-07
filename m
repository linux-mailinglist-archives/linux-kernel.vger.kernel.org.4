Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C20F725CE4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240319AbjFGLTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbjFGLSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:18:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5A61BD7;
        Wed,  7 Jun 2023 04:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffbczs0wTUGf07wsA338zqzaSHW9AlyjoDe+E3mskC/VWYHO+N/NIzedobUrJEr2RtynvjbJB74wRcQ/TlIUMGeWuEBU2ampdHm8/J8dSh+iwP4CWYLims0IdVHu2MBoQp1dG3/rCthlwao8KrYogdmiqlNmazrYdQr1xiuPoTxf+hxshChdBZuGQ/1GAl4QH806R+wji6TQ4u6r/oTIzScDdv5oB3fQwS+Prwp0QfPsVHUhIwjFubaYxz4L9NHPDj23tbwSmjN+E8Iwz+a58mAG3FoPhgAdsHaDMQuu7YjXaU8EQoT23McAxfCJQjFE/ZYZHJiAy6pZQR5B+2xe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaxQLIM45ldH/w8gtvqHNaPPaezz38FjH0YezDf+Hew=;
 b=Y+ZwCyrALuEqQGvfLLqykGIhL1LRiwBKIh6+jJ5mYAeS+dVa7GLuYc7SgVkdjk2av6nDXVKAMS9UvjQZFDdv86+LYvMHVvJsO/e3RFddJfyYuex+pzDXWTH0mJmJKqX16Rf8/3rQi2L10u3W8beq2/LsnTkQQGmKXU+Bb1IDVBDuLr0z9KJ7O0etsa0bTW7p3sehupRIhNGItjFjpiF0Mdv1lEqxSMT6l8D0+x7KmUHFt2kmzufZvaycT/Xd+Zb2ruKjGwyyymv1TYi1Yp/ZK/sJRh/jy+BYY3MvNY3yScOT3a4Rj2xsrwjQZ7KP3tGBWX+GnZlRE+gXUvDHaJl77g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaxQLIM45ldH/w8gtvqHNaPPaezz38FjH0YezDf+Hew=;
 b=3B1Y5fmhSzjRWT/SBV/aEAfCpBYQFo+hOIR+VDIj0VGm46TWMdoVP1yMb70zVoJrT2V2HMdibQc6wxSw5wlXJfq4VO6rlIaNQ1KS03M7fJzuSik5g/aCj9MSu54Om24KA7jfon0OhN/TC9aUJQz7avPi7AG/GLVIHndTLwiCalo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 11:18:31 +0000
Received: from IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::5f70:8e17:f854:91ed]) by IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::5f70:8e17:f854:91ed%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 11:18:31 +0000
Message-ID: <b8311fdc-2e71-f74f-159e-db7a86f27b9a@amd.com>
Date:   Wed, 7 Jun 2023 16:48:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US
To:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        sfr@canb.auug.org.au
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org
From:   "Jain, Ayush" <ayush.jain3@amd.com>
Subject: Null pointer dereference during rcutorture test on linux-next from
 next-20230602
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::13) To IA1PR12MB6137.namprd12.prod.outlook.com
 (2603:10b6:208:3eb::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6137:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 244babf8-d76b-4d33-5d36-08db6748ece4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3gORhNx0IbySkn+PlR4kW3VNKpL/p0BvE7C7ADtXX0WFzs0IxNeBEGtyv0720ZlFuvKSho46e3R/rK5RzBfCl+qM+9grbaySg4ZO3jAvUDbKBLz/gjpIHwvntKWZq4E10Ktl7SQ5f9+oxlsloQmDrvZyCUXdRTYmawZ1IPDrq76vdT1ynCfqFAbQfsW6YHJRWaAbjWQQMt6oOG9a4FiP8SfY64vVqkAyF1hoF009UOuMvq9nr8GUSg29v5Wr/rpfjKo+gbqbUyc1ffXoA0WDsmc478A0skOOm1uVZ6v7Uh7oOtHFBX/lynjAMcbQV2Ahq96KMlgVk9tAifU8iCfdkQ1+9ZR/v1pfo2YY8VXAp/vXDiB9iYWVyiKtdpRq3kgMxH0FU/gnPG7/eg8kplsxVsqerTKQXr7k2svm98sWpr7cazzva1BK9OwSTAM7wOiOTbZxqXl2tCSyWgFI1KDR5K0izmv8daj/Gjy22Xq6AKnjHUx9q4vHoPz8fVoSYIKVq6yak6/E/kthyPBsiUdKyIJaQyqheHfQgcw0OdwE0p3oCzbb11f35WlQTd4xpDzYqU5CvSqz1fP3N75SxXK8p4sN0ZAqoQIHZ4b0R19XO2cdgDIjupwsb78qoi57mhZo88GHuTUsazkF/SWHeUxMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6137.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(31696002)(86362001)(5660300002)(2616005)(83380400001)(8676002)(8936002)(38100700002)(26005)(316002)(186003)(66476007)(66556008)(66946007)(4326008)(36756003)(6512007)(6506007)(31686004)(6486002)(2906002)(41300700001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXpMR2NpQVNISlNiY0oyMGlmd3BuZjVWb2ZCUXNUZEUzeERGNUREY2VOby8z?=
 =?utf-8?B?YzVLSW1WQjF4TDJOT2xVQk01b2YrMDNjeEN5NFVkcXVCUXU0Mm9qKzk4MEJS?=
 =?utf-8?B?Z2EyaG4rUTVHSk1RazU4VjdCOURTYmwzNFNUaStNSU1sWjJmRUJqOWxzTnNM?=
 =?utf-8?B?OHNZL1NuV0Q5NGNZR2JSLzhxTmNjWEY1VVkybEN1UnhWY1NaZC9VVkxHTzFB?=
 =?utf-8?B?N2srek1aM3dkRG13VUJRb2dBVzVOMEE3VWxZaXh4QXpUUUZRU1VUWWlJWWNq?=
 =?utf-8?B?YUdaVzNESHB2VWg5U0hVa0dvcHFBUkJ3RWhOai9ZSEVYT2N5Z2pZSDBFYWZ2?=
 =?utf-8?B?aDdnb2U1RDhMM0tHTVZwbm44c05oOEhoRHg2cG9CNEdWUnFUaWd5U3F4bHZH?=
 =?utf-8?B?UzVKbmhqR2xLaXYxQzhCT1cyMW1MM1FEalIvSkhmbEVZT2ppaTlGWmlrNmVp?=
 =?utf-8?B?T2NRWjRGcURrVHQ5Mmw2SkpXL3ozdHEzeFRQdHFucGw3Y2NyTGNEVnFMUFhi?=
 =?utf-8?B?dWZJTnlMSDIyV2wxWmxDOGkxQ2ZQL1cvcmZMMWhtQS96WDZ6N3h2a3JsTFZt?=
 =?utf-8?B?Zjc3V0xkN3BhNk1WYVpEUWlDRXNpc1hrZEtOYXpmVlFqbGJ4ZkFsQVRma1hx?=
 =?utf-8?B?V1dzbmx4Nk5uSEVEUldoSnB3djBoMjI3bWtvK1EvNDRQRXA3dGlxNEwweGk5?=
 =?utf-8?B?dDJJQXo4M1MwRTlCTi9tbFBiK1RzOGFlajhZcEN4RkVPOWVFRTJTaDlxb1Q0?=
 =?utf-8?B?ODVxbElEaHh6YTFpZjk4TjFxaGcvMVJWNytsNWlwNGluZDZVa29jNEIrZU81?=
 =?utf-8?B?cnJZQ2xsc2d2NTRNOXRScE8zQkw3Nmc5S3RpVnFYakhOc0hQNUNlcGhCamNp?=
 =?utf-8?B?REV0d3lueWNUVGVXN2dIbEdwWmNqQktEMDNhWEVCdFFPakJkaEpKYms4ZWth?=
 =?utf-8?B?V3JDaXJCdlhIRHRqelYrNldoUUZKbktMSjhGZmhOZGhNSkl0enlId3dMQmhp?=
 =?utf-8?B?aWFtYWJyU3c1WHFwOTN4RVdlVzdnUHN1VjlCQlkxS2pkOGtHUE1uRmUyck96?=
 =?utf-8?B?Mkd0QjNNbXo3QVJkZTlDLzIzN0xCVGtpdmxHV0ppMUxLT1JwdjNQdmd6Y2tt?=
 =?utf-8?B?eVVNYS9EZzRSazIxNVVldXZ3dmJCUXp5RnFxZ1FFakN6MjlvZWdBdk5HL1hE?=
 =?utf-8?B?aFVveDJDYTRtSlArcmxJYk4rZkZzSFVObnlISFExdGlUQ04rYTUyeFp4amdI?=
 =?utf-8?B?ZS9qZDlEeDhiTjlSb2FFUGd2bi9sRGtGeDVyREQ4Qnp2VUl6U1lNY294dXJE?=
 =?utf-8?B?d3VkOVIvbWVVR0FSK2hRaVFRZXA1MTdpQzBmMWx1dnZ2WExkLzZZK3llTGwr?=
 =?utf-8?B?ZURMaTNSMmZpSzB6Z1BjcWVDQ1VrMVRjZ2hpbEhmQXlhc0ZJQ2lyZDVMbTFX?=
 =?utf-8?B?cnIyMmp1cHFaSXBNSWROZjhOUmtaR1hSVlRRYWJrNDFDS3VKK1VsUkRCWk5j?=
 =?utf-8?B?dFJTNVBJa251bWZFTFNBeEswaHl2OG1BL1F4MzZqTDJ3eCtId2JySXBaZmc3?=
 =?utf-8?B?VkJMT050NlFobW9Ydlo0NGlBY3dEY05qQ0l4eUpibHpaOHJvb252N2RKQUJx?=
 =?utf-8?B?eEJJK1RNUVlKNElnNlZrSEVUeU9oSFRZdktlaDJpd1JxbCtzZ3V2QzZ1ZkE4?=
 =?utf-8?B?c3FnSlBkQ2NDRUpMVmVERjczcW5IbWtxVGFJc2ovaUFPWmF6RUhXenJ1VjRW?=
 =?utf-8?B?VE5ONzl4TTlSRi9OdyszVCtkYTI1QXFFSTNBUnlQVDVLODk3U1BWS3ozMzc3?=
 =?utf-8?B?eWR0S3RQdHMxVGVaNDIyTE9hWnA4enI1N0ZYOXJUVlNQaXdYZHFLL0UveU5y?=
 =?utf-8?B?QWtMeDBGeGhnQXo2bGFScjZiRkVLMmxqL0VkK2o3MldUR1l6RkNwUWppQnAv?=
 =?utf-8?B?U2M4ZC9LM2xJbGo4NERLc3J1V2Z4eHlMSzZiSlZQb1UvQlJYQk9RWnBNSldp?=
 =?utf-8?B?SGpuQVBDbzFjZ3BjS0xCUFpuZGE1dm9zUVk0RU1aQjBpR28xTTFwWnFBTC9j?=
 =?utf-8?B?U2tHNk5XWXlJOFQyemVoNmxNL1Rsd1VlZ2VxM2xIRVNDczZ1UHdqMDlKNlg3?=
 =?utf-8?Q?NsB7jqAYgggjCIw0CgGnVZxjc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244babf8-d76b-4d33-5d36-08db6748ece4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6137.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 11:18:31.3751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/YNjHtzEGIIz5AIBHNDFQz/X/+rxYJH5m/LL0S3G+C2d+yGp2/NAs4waF8aNEPxT0ndDLBCAlz6F3Kbsa37Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Observed null pointer dereference during rcutorture test on linux-next tree
from next-20230602.

Commit ID: commit bc708bbd8260ee4eb3428b0109f5f3be661fae46 (HEAD, tag: next-20230602)

Here I am attaching log trace

[12133.344278] rcu-torture: rcu_torture_read_exit: Start of test
[12133.344282] rcu-torture: rcu_torture_read_exit: Start of episode
[12138.350637] rcu-torture: rcu_torture_read_exit: End of episode
[12143.419412] smpboot: CPU 1 is now offline
[12143.427996] BUG: kernel NULL pointer dereference, address: 0000000000000128
[12143.435777] #PF: supervisor read access in kernel mode
[12143.441517] #PF: error_code(0x0000) - not-present page
[12143.447256] PGD 0 P4D 0
[12143.450087] Oops: 0000 [#1] PREEMPT SMP NOPTI
[12143.454955] CPU: 68 PID: 978653 Comm: rcu_torture_rea Kdump: loaded Not tainted 6.4.0-rc5-next-20230606-1686061107994 #1
[12143.467095] Hardware name: AMD Corporation Speedway/Speedway, BIOS RSW1009C 07/27/2018
[12143.475934] RIP: 0010:__bitmap_and+0x18/0x70
[12143.480713] Code: 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 89 cb 49 89 f9 41 c1 eb 06 74 51 45 89 da 31 c0 45 31 c0 <48> 8b 3c c6 48 23 3c c2 49 89 3c c1 48 83 c0 01 49 09 f8 49 39 c2
[12143.501675] RSP: 0018:ffffa3a90db70d90 EFLAGS: 00010046
[12143.507510] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000080
[12143.515468] RDX: ffff8a1ec17a1d68 RSI: 0000000000000128 RDI: ffff8a1e800429c0
[12143.523425] RBP: ffff8a1ec17a1980 R08: 0000000000000000 R09: ffff8a1e800429c0
[12143.531385] R10: 0000000000000002 R11: 0000000000000002 R12: ffff8a1e800429c0
[12143.539352] R13: 0000000000000000 R14: 0000000000032580 R15: 0000000000000000
[12143.547320] FS:  0000000000000000(0000) GS:ffff8a2dbf100000(0000) knlGS:0000000000000000
[12143.556354] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[12143.562770] CR2: 0000000000000128 CR3: 0000003089e50000 CR4: 00000000003506e0
[12143.570729] Call Trace:
[12143.573463]  <IRQ>
[12143.575714]  ? __die+0x24/0x70
[12143.579130]  ? page_fault_oops+0x82/0x150
[12143.583615]  ? exc_page_fault+0x69/0x150
[12143.588001]  ? asm_exc_page_fault+0x26/0x30
[12143.592678]  ? __bitmap_and+0x18/0x70
[12143.596768]  select_idle_cpu+0x84/0x3d0
[12143.601059]  select_idle_sibling+0x1b7/0x500
[12143.605831]  select_task_rq_fair+0x1b2/0x2e0
[12143.610603]  select_task_rq+0x7a/0xc0
[12143.614696]  try_to_wake_up+0xe8/0x550
[12143.618885]  ? update_process_times+0x83/0x90
[12143.623747]  ? __pfx_hrtimer_wakeup+0x10/0x10
[12143.628615]  hrtimer_wakeup+0x22/0x30
[12143.632706]  __hrtimer_run_queues+0x112/0x2b0
[12143.637574]  hrtimer_interrupt+0x100/0x240
[12143.642152]  __sysvec_apic_timer_interrupt+0x63/0x130
[12143.647796]  sysvec_apic_timer_interrupt+0x71/0x90
[12143.653149]  </IRQ>
[12143.655493]  <TASK>
[12143.657834]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[12143.663573] RIP: 0010:rcu_torture_read_lock+0x4/0x20 [rcutorture]
[12143.670389] Code: 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 e9 12 5a f6 d7 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <0f> 1f 44 00 00 e8 b2 12 f6 d7 31 c0 e9 7b 9c a0 d8 66 66 2e 0f 1f
[12143.691351] RSP: 0018:ffffa3a90e3ebc40 EFLAGS: 00000202
[12143.697187] RAX: ffffffffc1dff0b0 RBX: 00000000ffffffff RCX: 0000000000000008
[12143.705155] RDX: 0000000000000060 RSI: 0000000000000060 RDI: ffffa3a90e3ebccc
[12143.713124] RBP: 0000000000000060 R08: 0000000000000060 R09: 0000000000000000
[12143.721091] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000060
[12143.729057] R13: 0000000000000008 R14: 0000000000000000 R15: ffffa3a90e3ebe20
[12143.737027]  ? __pfx_rcu_torture_read_lock+0x10/0x10 [rcutorture]
[12143.743845]  rcutorture_one_extend+0xc2/0x3a0 [rcutorture]
[12143.749980]  rcu_torture_one_read+0x192/0x550 [rcutorture]
[12143.756115]  ? update_load_avg+0x7e/0x740
[12143.760593]  ? raw_spin_rq_lock_nested+0x15/0x30
[12143.765749]  ? newidle_balance+0x26e/0x400
[12143.770330]  ? __pfx_rcu_torture_reader+0x10/0x10 [rcutorture]
[12143.776854]  rcu_torture_reader+0xcd/0x280 [rcutorture]
[12143.782698]  ? __pfx_rcu_torture_timer+0x10/0x10 [rcutorture]
[12143.789124]  kthread+0xe6/0x120
[12143.792636]  ? __pfx_kthread+0x10/0x10
[12143.796823]  ret_from_fork+0x2c/0x50
[12143.800824]  </TASK>

Please let me know if any extra information is required.

Thanks & Regards
Ayush Jain
