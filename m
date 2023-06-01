Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A19719AC6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjFALOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjFALO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:14:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AFD132;
        Thu,  1 Jun 2023 04:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aulWs+aRprVf6NXPeLarb/zdaXps30z2s7BHALc0ozJfLOvegQf5jJvXCVX/B3Hnsc0mhz9KHuOCwEIgEbk7+EDvyEFfxyAjOLxZZFrqMO38tTfXPfpHK8M/r1YfGe8QDS/KIniqCGa4MWNuqKAhUazdHGZWBKrCKfC7SuyTQuwTTRFtj9fIdzYaKM/p1ux/G8gXRZXyfDY5cg5bQpiw8cXULGwwt8/Eqw6cpDYumGIYGBcMCjpPlNDH6P4B9nDeg4mGoPs10/F8/kq+hqzZV5G+7rHUOYBKNOf/ziwTyJIpmsxX4KcTTxBUIPnMf/8PuDSVZqLnOv8WiDG3/q6SDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJc5qHCwJf4NzCOF5Jj3BuEXZ6l7gW6DbFtY0x5WhqM=;
 b=inxM+z/4Fg7IhSkVU5KlaZQUCsDkWKlOHOCQdWapJIbXjku5vmZjvnRloEpKXKggvkGx12mBKJ2CQj0DMuX3ARcg0ab//apCJ/i6+cWIci7GoSQMI1MGlGf0B1gEYVuYxooz1Gho5Gujd3PuEdhDRIILoPl+4SfPVt01Zz7SRYC8Vwb/tsyDPWSJ0bB8/p5bmO6jqC6SOWoN8prkxBHp1yx+Co6G/UWYcXupkyTFWHtKffHPgzgWxJYnKIZ2vKmnNc1OeTqDlWq0XTFpt7dgMfB+/3Spqd+Ji5MbMeGmc/E8t/aMVWAzFI2xkiKO1uyJ1iMdsJCehy140tbb/iTm1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJc5qHCwJf4NzCOF5Jj3BuEXZ6l7gW6DbFtY0x5WhqM=;
 b=nm2eUQKpLXs9XJ1tOktnUn/PvRvGeHNVgnCQ9WVZhhiG20KQzmnbdfN4x9ckMSQik+OWjTq/QNr6YQWja7URWNvq2PdHJlksUkfP06q3oqTwydJGlvzCWSS+a5Rvblq/g258bTfze1TurQlezbiICXRLxjNQhYwYr4Q0pYDw/j5X8PqZ5+G7amvhIs30kJ71DfOhRNim4NyJzBpl45ZDMHufCQLqkJDiGRzPo8EoZX9oIdbbTBgSYWRj46r7iZt8ED9at8zvrUzZSckWWjv7uQqC4Pr/7Re6I2ZS7IaZVHRjK4wbx4iGTOx6T2mS70Cs9ozZ/Pi6fdv3mP8njjtQbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.24; Thu, 1 Jun 2023 11:14:18 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8%4]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 11:14:18 +0000
Message-ID: <6549da46-dddc-67ac-73c4-966965addad7@nvidia.com>
Date:   Thu, 1 Jun 2023 12:14:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH rcu 11/20] srcu: Move grace-period fields from srcu_struct
 to srcu_usage
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
 <20230330224726.662344-11-paulmck@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230330224726.662344-11-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::18) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 2528ceb6-ff7c-4444-a605-08db6291579e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4NTcFzpiBJyAfaDxnm4vizPL6+ex3hxAm9PSTT5WczywLJGCelLN0wpKApwap5f4U+2nA8Fww0AhwFqf5DouIvBkP/DTerSIBBpLiPBgTJ5bUWzB0qV3ICrAAKm6pIFzUQqhsUc5VsE452cd92Lht7cpyEiUul7PTFu/ZFQLfH8n6nyrUWmAF+ObASATFD836B1F9uKafZRr1rrQCSPK+UoE/K+F+larh603GHCHpA0REwwuhyzYAwOl4ZWbyXegikP14tRIQWySRGotoL5jNQHoPLfGagwZhflwRFfYNC1JgmokNOA+V/RXB4ACzvMXhMYHgSnm00BvXYqfkdV7XGphY65ujqZCxJWIQVqUzyYUuECA1MHmLc88FkSMTJgHE2kYCRRFXHC5zkXyUAnd3CTHgyRQuO6Zw5S60yqPcobhU8u3G96I9C7sZLk3mTd3rzh/hao/c4A2U9N2sf3aznA1GHbPr07B28b6MaOcz3eMsqNL2Wd0kTBTzqdzTbDU8koV3b6BBRhHcUr5osCPgnnrJd5+NgGo34rxCZzjbpAciCmcz2S1xaQ2u4OUMMfQUMCoR91Dp6HWi4EFHSley6K58MI48dkbOFoN7dvMHtsGWPqUCj8R8ylZGgTdEHeozJuGawqlWOS3s+7aV8whw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199021)(86362001)(4326008)(66946007)(66476007)(31696002)(66556008)(8936002)(316002)(41300700001)(54906003)(5660300002)(31686004)(8676002)(2906002)(45080400002)(38100700002)(6666004)(478600001)(6486002)(83380400001)(2616005)(26005)(53546011)(186003)(55236004)(6506007)(6512007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEREK0k0elkxbmx2WlY4UjNaRUlLYnBGc0MxR1ZLczNOOC81eFZKMkJWSUZm?=
 =?utf-8?B?RTZtNnZBZnRNYkFmWUcvbENsMDlPOVEyeW82MkQySEpCRUZhL0N5Y295Nklh?=
 =?utf-8?B?d0J3MGlPbXNiaUZnWFJTcU9yNW1hMHBadENhYnNqdm45VkdZK09ZUVhqaWZt?=
 =?utf-8?B?bDZEd2h0ekV3NWMyRG9xdVhZTEpTOEUyYU5VMExxU1BZc0gxQW44dzd6Rm1M?=
 =?utf-8?B?NWdOcm9kYm9GNmdPT0JGS2tlbmhuTGhkbU43NWRURFNZcFV5S2c0ZUVQL08w?=
 =?utf-8?B?RHpZamMyNXRiZ21GUU1vQ2hZNHFjVmdzTEdkSlVjR00reEN2NW9LYWM3UlQ4?=
 =?utf-8?B?ZE9sdVhsQm5OOFh3RWZTWmZUMEVDdzNSZHRrN2tHR3RMS2tTNzErSDRFaCtz?=
 =?utf-8?B?aWRLMW0rQ1RnaGMxZ0RKaS9rMmdmTFpRbnlwb0lzSWVYNVRldGx4V2JDSjdU?=
 =?utf-8?B?RGRQRW9SN1VSczVGanc2d3FmQndXbjFFMW8zS0xxdTFFNDIvN1pscXFxWUN2?=
 =?utf-8?B?Qk9vdzRhN2hhY2dHZE9YcDQ0dVN6RkRNOUkybklEZ3A5STBiMWVpZncwbnNG?=
 =?utf-8?B?VTdpbFY1VUJJZDMrby83S2NPandZM3VjN09ORVU5eHF6WFdqdFR2MjdzSGNi?=
 =?utf-8?B?TktGL2ZpanpocHRuMENDeTZMOWFIdkRmaHpZdk9EOGVXOGNDVExlUWoyS1NJ?=
 =?utf-8?B?bnlUaVFvNXRKd29HMUNOTHBNQVVqZ2JMb3g5NE84K0hYbVdBSk5kVTlwMjdJ?=
 =?utf-8?B?UEVCSTIxTjZiOXRxYU1lc0YvSmN2bGVXc2NTNlZFZEdQd084ZmtnREdsZnRt?=
 =?utf-8?B?a1pmK0k5dFZpem5iVktHR1VPSmdTZExZQVBaN3FITHMwTmRFUTdsRXdhZmVL?=
 =?utf-8?B?ZHVlTUJyaHZoSmtkb29oVDI5RTlLQjYyVEdkNnpKTVk2OHFZMnRyeUU5ZnR1?=
 =?utf-8?B?b21PZUNkRTdoZDBBeUMvaWpTYS9HUUM2VVRRVUVCb1crZXB5em52WjRQT3VI?=
 =?utf-8?B?NVBXeWRqL1RVOXhpUm93Q1hiRVRvdTJFR3JvL1V3MHV2YnFBM0pxamNPR3Ft?=
 =?utf-8?B?enJSak1TMEtCZ2RqV1Z5NTNSdlNYOTlMUTF0UXhwTjVEUHRXcWx0RUdmQWVE?=
 =?utf-8?B?R2RwcWptSGU5bURxNDIwbnFkOXpvVXA1WDNCaXp1YmxiRXpJS3VSZW1rWUNn?=
 =?utf-8?B?VFZMN2R4U1dqR3ZXVkFPVFN3R0QzazVtVmlxQ2xUY0NWZkY3Y0VKUnlyTXBW?=
 =?utf-8?B?aFRsRFNxQU95bDRzNUtuM3EyZWtTUUYyOGlyK203NDlsdHQ4d3BMU21HaTNk?=
 =?utf-8?B?cmR6bWtGT2ZPRno5bERZdThEc2lHVnZjQ0pYUkIwZ01zdVE2MTBhTHVDNDJN?=
 =?utf-8?B?ZlZZRlFIb09XSXg5N3JTczZIYVlBWlZzSUNBYmtvSmxBb2FOYTZrU1FYQXpE?=
 =?utf-8?B?ZStuZ0FMNnJMWjBjeHVEakJPNWQ3NXBwSkVRaHg0U0I3UEJrVUl0cHI1ZU93?=
 =?utf-8?B?akRWWHlnL1djQlRBSXFlQUkrdFlpZ1dwZ2o2K0M5UE9NR0Z4UElJRTljUXpF?=
 =?utf-8?B?c3FUWGthQWJXMW1LVUVXbWhNTk9hbEN1cHk5ZWcvQWpwRmdKMmtSQjdmZUVG?=
 =?utf-8?B?bVZ3TXdrMmZtQkVobGt0VUpwVDQ2WVNUSGZwVmI2WmNCejVOdnQvNTYxREJO?=
 =?utf-8?B?THYyV0RzRUVndlRzYnUxMnIzbTkxQ25BQlhhNjg2aml2eWhBa2hYRjdaOGlJ?=
 =?utf-8?B?S2tEMEhHN3d5cW9LQW1FRlhadUdnRXoyK2k5dDZJY2dMQ3F5NGtCZVluaXhK?=
 =?utf-8?B?K29nMmRyaEFuTkloL2pTaENrVDU3ZVl2NUh1N1dZTEJZMWZRZW9Iai9mSHdS?=
 =?utf-8?B?UUdrZ2FnNzJBdlN6dzlCWUxBbmpiOU5uZ0IzdGs2RlE3VEs3Qyt0eFpmb1hj?=
 =?utf-8?B?UC85dEV0RVR0UHYrTTBMSE9rczZOTi9na2N3Ykw0SXMrTUY4bWtUUGhJYk54?=
 =?utf-8?B?VmJkUElqVTBJVDhGUmxTSDFJQjBOWWN3dWNPcm5UOVoydm9FRGNabE5heXZ6?=
 =?utf-8?B?K25BbUdzSFF2cU5kdDhqWUkzeUt1RTV1TlV5b2o0UVBzYzJhM0x3dkVyd0NW?=
 =?utf-8?B?Qnc0QytJc0QwZXBBcTBLbDBvSENFTXZHaW1mZnFDeW9LNnIyZnFsZG0xcVF5?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2528ceb6-ff7c-4444-a605-08db6291579e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 11:14:18.4692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bW0dvNp3XXggKHOubti2pfpsdgtQ98VxLMRMPVSgk2L3QWpBTrdY+kx0M55F/CbnV+Onp11agtiBvT6eWdfCaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 30/03/2023 23:47, Paul E. McKenney wrote:
> This commit moves the ->srcu_gp_seq, ->srcu_gp_seq_needed,
> ->srcu_gp_seq_needed_exp, ->srcu_gp_start, and ->srcu_last_gp_end fields
> from the srcu_struct structure to the srcu_usage structure to reduce
> the size of the former in order to improve cache locality.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Sachin Sant <sachinp@linux.ibm.com>
> Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>


I have noticed a suspend regression on some of our Tegra boards recently with v6.4-rc and interestingly bisect is pointing to this commit. I was unable revert this on top of the latest mainline but if I checkout this commit suspend fails and if I checkout the previous commit is passes.

Enabling more debug I was able to capture the following crash log I see on one of the boards ...

[   57.327645] PM: suspend entry (deep)
[   57.331660] Filesystems sync: 0.000 seconds
[   57.340147] Freezing user space processes
[   57.347470] Freezing user space processes completed (elapsed 0.007 seconds)
[   57.347501] OOM killer disabled.
[   57.347508] Freezing remaining freezable tasks
[   57.348834] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   57.349932] 8<--- cut here ---
[   57.349943] Unable to handle kernel NULL pointer dereference at virtual address 00000000 when write
[   57.349960] [00000000] *pgd=00000000
[   57.349986] Internal error: Oops: 805 [#1] PREEMPT SMP ARM
[   57.350007] Modules linked in: tegra30_tsensor
[   57.350033] CPU: 0 PID: 589 Comm: rtcwake Not tainted 6.3.0-rc1-00011-g03200b5ca3b4-dirty #3
[   57.350057] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   57.350067] PC is at rcu_segcblist_enqueue+0x2c/0x38
[   57.350120] LR is at srcu_gp_start_if_needed+0xe4/0x544
[   57.350169] pc : [<c01a5120>]    lr : [<c0198b5c>]    psr: a0070093
[   57.350183] sp : f0b2dd20  ip : 3b5870ef  fp : 00000000
[   57.350194] r10: ef787d84  r9 : 00000000  r8 : ef787d80
[   57.350205] r7 : 80070013  r6 : c131ec30  r5 : ef787d40  r4 : f0b2dd64
[   57.350217] r3 : 00000000  r2 : 00000000  r1 : f0b2dd64  r0 : ef787d84
[   57.350230] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   57.350251] Control: 10c5387d  Table: 81d8004a  DAC: 00000051
[   57.350261] Register r0 information: non-slab/vmalloc memory
[   57.350283] Register r1 information: 2-page vmalloc region starting at 0xf0b2c000 allocated at kernel_clone+0xb4/0x3e4
[   57.350322] Register r2 information: NULL pointer
[   57.350337] Register r3 information: NULL pointer
[   57.350350] Register r4 information: 2-page vmalloc region starting at 0xf0b2c000 allocated at kernel_clone+0xb4/0x3e4
[   57.350379] Register r5 information: non-slab/vmalloc memory
[   57.350394] Register r6 information: non-slab/vmalloc memory
[   57.350408] Register r7 information: non-paged memory
[   57.350422] Register r8 information: non-slab/vmalloc memory
[   57.350436] Register r9 information: NULL pointer
[   57.350449] Register r10 information: non-slab/vmalloc memory
[   57.350463] Register r11 information: NULL pointer
[   57.350477] Register r12 information: non-paged memory
[   57.350491] Process rtcwake (pid: 589, stack limit = 0x410bb531)
[   57.350510] Stack: (0xf0b2dd20 to 0xf0b2e000)
[   57.350534] dd20: 00000000 c1ee4a40 f0b2dd7c c0184f24 ef781495 3b5870ef c1ee4a40 c1ee4a40
[   57.350555] dd40: c131ec30 00000000 00000002 c0f3d1fc c3542ac0 c2abbb10 c1ee4a40 c0199044
[   57.350574] dd60: 60070013 00000000 c0195924 00000000 00000000 f0b2dd74 f0b2dd74 3b5870ef
[   57.350592] dd80: 00000000 c131ebc0 c120ab28 c0146d9c c2785b94 c2785b40 c0fee9f4 c0872590
[   57.350611] dda0: c2785b40 c08c39cc c2785b40 c08c3a3c c2788c00 c08c40b0 c0f3d1fc c066f028
[   57.350630] ddc0: f0b2de14 c2788c00 c1325ef4 c08c1d40 c2788c00 c1325ef4 c0fee9f4 c08c31cc
[   57.350648] dde0: c13708a0 0000000d 00000000 c0681c10 c16afe84 00000002 56508788 0000000d
[   57.350665] de00: 00000002 c13708a0 10624dd3 56409580 0000000d 00000000 00000002 c0f3d1fc
[   57.350685] de20: c3542ac0 c2abbb10 c1ee4a40 c06824e4 00000000 ffffa900 00000000 c1386510
[   57.350703] de40: 00000003 00000003 c1204f75 c017e8a8 c3542ac0 c2abbb10 00428228 c0171574
[   57.350721] de60: 00000000 00000000 00000003 3b5870ef c1204f75 00000000 00000003 c137aeb4
[   57.350739] de80: c1204f75 c0f3d1fc c3542ac0 c2abbb10 00428228 c017f380 00000003 c0f38a54
[   57.350757] dea0: 00000003 c1386524 00000004 c017d708 00000004 c2abbb00 00000000 00000000
[   57.350775] dec0: c3542ac0 f0b2df28 c2abbb10 c03305b4 00000000 00000000 c2953c00 c1ee4a40
[   57.350794] dee0: 00429438 00000004 c0d18488 00004004 00000000 c02b1094 00000a55 c1d80010
[   57.350812] df00: c1d80010 00000000 00000000 f0b2df78 01010006 00000004 00000000 00429438
[   57.350830] df20: 00000000 00000000 c2953c00 00000000 00000000 00000000 00000000 00000000
[   57.350848] df40: 00000000 00004004 00000000 00000000 0000006c 3b5870ef c2953c00 c2953c00
[   57.350866] df60: 00000000 00000000 c1ee4a40 00429438 00000004 c02b12c8 00000000 00000000
[   57.350885] df80: 00001008 3b5870ef 0000006c 00429438 00428228 00000004 c0100324 c1ee4a40
[   57.350902] dfa0: 00000004 c01000c0 0000006c 00429438 00000004 00429438 00000004 00000000
[   57.350920] dfc0: 0000006c 00429438 00428228 00000004 00000004 00000004 0041578c 00428228
[   57.350938] dfe0: 00000004 becda9a8 b6e9bc0b b6e26206 600f0030 00000004 00000000 00000000
[   57.350960]  rcu_segcblist_enqueue from srcu_gp_start_if_needed+0xe4/0x544
[   57.351023]  srcu_gp_start_if_needed from __synchronize_srcu.part.6+0x70/0x98
[   57.351084]  __synchronize_srcu.part.6 from srcu_notifier_chain_unregister+0x6c/0xdc
[   57.351155]  srcu_notifier_chain_unregister from cpufreq_unregister_notifier+0x60/0xbc
[   57.351215]  cpufreq_unregister_notifier from tegra_actmon_pause.part.0+0x1c/0x54
[   57.351277]  tegra_actmon_pause.part.0 from tegra_actmon_stop+0x38/0x3c
[   57.351324]  tegra_actmon_stop from tegra_governor_event_handler+0x100/0x11c
[   57.351373]  tegra_governor_event_handler from devfreq_suspend_device+0x64/0xac
[   57.351423]  devfreq_suspend_device from devfreq_suspend+0x30/0x64
[   57.351467]  devfreq_suspend from dpm_suspend+0x34/0x33c
[   57.351506]  dpm_suspend from dpm_suspend_start+0x90/0x98
[   57.351528]  dpm_suspend_start from suspend_devices_and_enter+0xe4/0x93c
[   57.351573]  suspend_devices_and_enter from pm_suspend+0x280/0x3ac
[   57.351614]  pm_suspend from state_store+0x6c/0xc8
[   57.351654]  state_store from kernfs_fop_write_iter+0x118/0x1b4
[   57.351696]  kernfs_fop_write_iter from vfs_write+0x314/0x3d4
[   57.351733]  vfs_write from ksys_write+0xa0/0xd0
[   57.351760]  ksys_write from ret_fast_syscall+0x0/0x54
[   57.351788] Exception stack(0xf0b2dfa8 to 0xf0b2dff0)
[   57.351809] dfa0:                   0000006c 00429438 00000004 00429438 00000004 00000000
[   57.351828] dfc0: 0000006c 00429438 00428228 00000004 00000004 00000004 0041578c 00428228
[   57.351843] dfe0: 00000004 becda9a8 b6e9bc0b b6e26206
[   57.351863] Code: e2833001 e5803034 e5812000 e5903010 (e5831000)
[   57.351875] ---[ end trace 0000000000000000 ]---


I have not dug into this yet and so wanted to see if you have any thoughts on this?

Thanks!
Jon

-- 
nvpublic
