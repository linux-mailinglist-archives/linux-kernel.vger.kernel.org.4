Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7B35B9706
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIOJIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiIOJId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:08:33 -0400
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2047.outbound.protection.outlook.com [40.107.116.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A261296777
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egT22XzSjO83iV+nZy3HxITkf7mK4dG8kYLKYfHesFm7ocN7pGCWsSuc/xq+B2ljbOOF5mC3vPmm2VQ5N1AM2nC4SaI1TvVeui0OcM3birRgSUv3LYGUZiWgddr4XzyNoqeubPfZQvmXEuSxn8qX5lUClwJ80FjcO0txzhvO7bGqpSkWe71R3R4o9oFA3dMr+7Oif/tI7zvpeMRYPCglqpIvltwccG/6FLFtTmr1F94tQNauQNaCRS7etJsaG70x9+Lq6QNIsBCaDqqQDjh5Y5y9h+KDX8orBwvCKBd/91ZRmq8+Y5YlA+AafDeOMYORSSHQgDjFPxQvSRnZ2PM20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NYs6gURKFj/Fcb+9dKtFR76AOnoeGIXLwjJWMOPi7E=;
 b=h9hI6egxQKsEtF3PSocoR/hjsW4N2uJYCHZ6kxxE6fLaYTWexnNVWX3L/EeYEhdaf9NxUsXu26BzImmbYKc+Os8H58U9jkVmtx+PPsh0+rNuwIYy8ytqR7TyBf0wz2xfRt8C9X8A8euVDCSkFxdrCUp4riOAgzv7X9AvAqlC4dfF2YOUnYA5tpG4D2qHEe8xS75dy5FiOPcoi/hGaix433oJvswbc2kwSpNJpq0Ig61JiWewnvZ2JozMkhhLTqA8tpoQEh726rybkAMbk2mUXLOEfr3YZk/RlShyZGVdPRDrki7WNUZAntH1k9diwV1HxpinjjlalcpMqcx5rnc8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NYs6gURKFj/Fcb+9dKtFR76AOnoeGIXLwjJWMOPi7E=;
 b=fBj9AwBv3Ob0HLHJ/jdYZbc9gyQ0nMKbcOuaw3JOIUVXgbEBHsF30wgCCoU1iUh8CL/dt1yMEL9mA85zf/vk8xxvntLH+YcFJKDl6U2zl1zPkCCQk/EoPyKQQapDBI361gDW8gTCqkp5PZZqalhXc1GMR8pOsndiBNzTqmiZce/Rajc5D3w0+DlDCLpgWvD6wgS2oUjYlJnkBgAC+m/49xoQ3hfe4qT+fCXo90soBAo2DdtVeETRIZp0RTqjApqTSxp5YHJweVLY8fHtoX6eKRatxqZvykPbfmyxiDkxtW3q49AFHDmSA4YElWwrl6LeZbC4p0zOQxw/006AmdL9zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8470.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 09:08:26 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bc70:d4be:bdc3:4607]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bc70:d4be:bdc3:4607%3]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 09:08:26 +0000
Message-ID: <258e00dc-6074-e7ff-576a-b3aca25c2db4@efficios.com>
Date:   Thu, 15 Sep 2022 10:09:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH] arm: i.MX6 Cortex-A9: Fix memory ordering
 inconsistency by disabling prefetch instructions
Content-Language: en-US
To:     James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Jeanson <mjeanson@efficios.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220718145150.3344778-1-mathieu.desnoyers@efficios.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20220718145150.3344778-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0051.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::20) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: b2edc245-47b1-41d8-e307-08da96f9d952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/tbMEvTycTVtx+8TXM4N1zv7ZL5YnOFg+U2ng754tFuYvvb3AkLiU+wILxuvq3heSkghKHGg9lFKPDZ20Zqoh0tDINsMxL7kSrlS7aHN07pd8YIUDHoI1ZuqQE56AUT9d/1amOp7psaMLSf9g3cbZPwdVHux3i7Aqnp4t8emtVdnyOoCseCQGNJFgn3+Byp3BZgfqi/LErsDJbnkqwysd5HoDHIYTDzs2rYpPM3RCzCfX34ThOfA4HSa89pLmzTGxyRBx3VQ50H+/0g6T94Rm9sGSMFdQSz/8UlpaRxhgafSM+S+AC51dBNLqOmVtUzqi4cW1selglLBU7HJTa8hGztWPXJagW9uE4qIpQl74BCCIgM6QIZvDu4517sShpNXHtANsgYYxCwGrq8RHBZ3dSh8yubhwPc0bQIROtav3Rw+Qhe2iSasOC+0lXz3bMnVi29VBZhR1+B2w6JFRu3OjOGBS4AXC7TAQfSF6tL5KR+qqTpf0ZmCBagjB3PQvDhA0Osx4cZCjYRXExLYwIHMQl6WCkwBoBnIBmG6J7o3VQMxch4Qf9apVdtOfWXzU/UfPTZsbJjgZLeYo/dzLoiZGJZ+bdFs+xeUf8VptnUIBMigN/khmIlmi+w3Jf5ypmEph+U3LRLSGhnTP43cp13M4SwitfPbg2MRzaKtloG6VS6xzKPOD9b3qI0TIfmrX5u1+FFeNOMrDIry9nYqepKM3NuV6LpnITkY4JaMZQQZi9MVh0StHxw+Ki2aIt+eIDq8y1eST0GaedvG2qpV5bJEra4CgCEn2ymZywa8PiAqc6Q9kD9P6mgV0BKK7UnfyhbqCLc2/1/iKEAA4CJQR/HH014PWow8u6gw7C7ELfP/bIwSctH4asArUrIZIlYMS9U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(34036004)(34096005)(366004)(39830400003)(346002)(451199015)(8676002)(41320700001)(86362001)(6506007)(41300700001)(4326008)(31696002)(8936002)(53546011)(5660300002)(6666004)(498600001)(966005)(66476007)(6486002)(586005)(66946007)(66556008)(2616005)(38610400001)(83380400001)(110136005)(2906002)(186003)(54906003)(26005)(6512007)(30864003)(36756003)(38100700002)(44832011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2FZd3RoeGJjVVMxZ3AvMlJDSis4eGlnZEhBTmk0NVNsWTVrRnhyZEEvTUEy?=
 =?utf-8?B?VmhrVUJuTDNnU2RSa1RmNTEySlNtMERBU3BKcUIwMUxhMk92cjZkLzg5WXVn?=
 =?utf-8?B?cEg1R1NwT0NIVGVaaDVMY1BNZytVOHBnREFUbnAvR3dobkxDNWtjYitoNWk3?=
 =?utf-8?B?QXZXQU04QnJObTdLcVJUYm1IQ1hKU2tTcjJTcUNSQnNGZU5WbHNYY2RzcUFB?=
 =?utf-8?B?cTIva3MwVUw5blZuNlhJY1NnbU9TbSsxTm1abmpMWUN4bm9RdnExZXQ0SndY?=
 =?utf-8?B?VzN0bzRYYWgrTkZwL1daSXB2MEtZemhsUTU2ckNGcjBBU0RKSkJjOWY2NExK?=
 =?utf-8?B?QzVoREJxN2pWdkIwWlNXem1KaVRIN0VLeVM0VU1IazZqNFpzcDdQd0Y4TXlo?=
 =?utf-8?B?RVo1K2t4NDhWVENhR09iV3gwMnlCbm9aK1IxeFNlakl2OUhnUnV5R3BDQ1p1?=
 =?utf-8?B?c0E1K1Z5dXpVRHN3a2N0MXFWOEE2QmhVNEpMeWxXQVdKRXRFbHpSRk5UYndH?=
 =?utf-8?B?R245c2k0Q3haSUlMTVlTdVNLc2FEajJsckVTaEkrWkR5d2JRWWR5akNMTXZl?=
 =?utf-8?B?TWluU0RRY05pRVpJZzZYR09HL2syWHpHSnl1U1JQV3lOMjFsVjhwMTQrV3ZR?=
 =?utf-8?B?S1g2WmFtTldqZm1UamFVMHFNR0I3SlB2TUdyL3R1aGc1MnZMZ0FVUEljL3gz?=
 =?utf-8?B?ekk3UzBEdTJzeTRTUUJ1dFlDZHRzUWdXaVM3RndGcmd3TFlmQnJ3T2JnU1VP?=
 =?utf-8?B?QnpLd0kvZTlXQjNZdlNnYU13Q0t0MHNPZnJuOHRDY0VvdFFiMHRhYmxvVHVs?=
 =?utf-8?B?U09sWUxKQXRaUkF0ZjlaVURhRU16S1hCSmJybGt5bHhERVNCTmo1dHVKMXpD?=
 =?utf-8?B?RGdLNER4SmVEc2RaMGFydUdrWXhSYkZOUHNORUU2SGZTYStCNWxDenJUYWhn?=
 =?utf-8?B?MEpyeVRYYld4RFAxNVVSb0tNaTFhaXo3TFE0OFRpQlN1MHJJaXhxajhhK0Rz?=
 =?utf-8?B?d1RtTTVsQ3dCOTZjaWFMb2FYL2toOTY0LzZ4TzFmNkJBUEtmcmw1RU1Ccnhv?=
 =?utf-8?B?Y24vZUE3c29hSXhEYVVhQkU5RjNhM25QbHNuL3hTSUdueDRwc3pXdlBUaXEr?=
 =?utf-8?B?T1FHSGJSZnh5SVhFTmlYVEZ3STVveE16Q0lrRWJCZlJ4dUtRTG1hVEFZQlZ2?=
 =?utf-8?B?UU9NL1I3V215SWRqYTlSV3BkRWZoemxycC9PQU1NdzkvMDEvbjBkcUZuYTdl?=
 =?utf-8?B?V0ZDRHVXR1IwMkRGVHNlTFdBeGpOUWVJalFFWmZWcjRZOVNJT3IyMUczRzZq?=
 =?utf-8?B?YUVjVStZNldFajYwb2VmM3NYaUN5bUtqRm50dWoxdk9xZ2ovQXRJWjQ0WEZJ?=
 =?utf-8?B?ME1lMDNkTzdDR3hiTnpFeWFrb0xraVoyUGJyRCttd0tpdEtZNE9UcHR1NzZ5?=
 =?utf-8?B?R3JOaTcxT3IreXVBTHU4NzdhTXpnMk9FdlNWRHFPUHByeXM0OUhIT3MwYkls?=
 =?utf-8?B?SzRoN1hMR3ZOYVF5WTY4MXFCdkw3N09pTXlRT3A4V0psM1kzZ2ptTXM0Y1Jy?=
 =?utf-8?B?SFVodVhyenZoclFaeGZTQ2lGd3phMTNqWDNDeDFpdVI0U2xvNkV0ZysxdEcy?=
 =?utf-8?B?QjN6S1BNL1JydHQwcFo1bC9mdk1OV0lYZlBkS01TMjZRWVI5bkhKWkFPQTFu?=
 =?utf-8?B?ejJTSzdlVitaNnlYRmxRbjYwdjJzMXNib0lseDJDRFp4SW5JajBmMVAyenhM?=
 =?utf-8?B?N0lCcDRpblBaTFN3U3hsVWRudzFHb1JCckk5L1JsOTFCMWFvejdFaDROUDdj?=
 =?utf-8?B?Z05DQlFyeElYUWd2NnBrMnBTbGtBZmpqS0JIendsN1kyb3FYUEhqQlJWOFRK?=
 =?utf-8?B?Q3ZXdHN3bXMrRnlUWmR5MHkweTJ4ZU5Yc2JQSml6YkdGa1FEcm1WdktBQVgy?=
 =?utf-8?B?eUZOVG5VS244Z3Z4SlVVTHF5cEIrWXNZRGtiLzFYWUl1aUJnRWNtWjB3TnFj?=
 =?utf-8?B?cVJIQlFrb2svYVV3T21JcHpmV3JJOU11RCs5NjJqRFg2aEZqeTBDUDFDT2cx?=
 =?utf-8?B?WDR5UmhzY1ZvTmtjZmtjalJ6Sm0yOFlDL1krY3VaVWlqVzJ5YlRkTG51ejN4?=
 =?utf-8?B?SThMdmwvNGJjOGFCVzYvSVVxN05JTU42by9CQWM0Mkx0SXVxaklyU3dOeW82?=
 =?utf-8?Q?q990sn6TBHSE+7LmV60he3M=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2edc245-47b1-41d8-e307-08da96f9d952
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:08:26.5332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqNYqAkZ1FOuSYwm7mNHbMeEd56vTPw7fYhVhffZTgzUHwqpRM0dHwUsKNqsmtRp2hVAw9OUPf+/U4/OGuw5elaBkQdkLCfItRpSxYTv9BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8470
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-18 10:51, Mathieu Desnoyers wrote:
> Observed issue
> ==============
> 
> On a Wandboard i.MX6 Quad Board revD1 (Cortex-A9 r2p10), spurious hangs
> have been experienced in sys_futex in a few scenarios with liburcu
> rwlock stress-tests [1]. The test run in a loop is:

I had a good discussion with Mark Rutland about this in the hallway 
track at LPC2022. I'll write down the follow up testing steps we 
identified here so we don't forget.

A first goal that Mark has is of course to try to reproduce on another 
Cortex-A9 test board himself.

Another thing he wishes to validate is whether the issue is caused 
specifically by the PLDW, or if it can be reproduced when replacing PLDW 
with simple loads and stores.

He came up with a change to test: whether turning the prefetchw() (PLDW) 
into a load instruction makes the problem disappear or not.

Following that discussion, I also thought of an other thing to try:

struct futex_hash_bucket {
         atomic_t waiters;
         -> add a dummy integer field here on the same cache line as the
            waiters count
         spinlock_t lock;
         struct plist_head chain;
} ____cacheline_aligned_in_smp;

and store to the dummy integer field rather than using PLDW on waiters. 
AFAIU this should bring the cache line locally with intent to write as 
well. So it would basically be using false-sharing for the purpose of 
prefetching the cache line.

Hopefully we'll be able to proceed with those tests when this round of 
conference is over.

Thanks,

Mathieu


> 
> for a in $(seq 1 100000); do echo $a; tests/benchmark/.libs/test_rwlock 2 2 1 || exit 1; done
> 
> This runs a 1 second test with 2 reader and 2 writer threads.
> 
> The hangs show up in the following scenarios:
> 
> - glibc nptl rwlock,
> - glibc nptl pthread_join.
> 
> Another simpler test-case that reproduces the pthread join hang is as follows:
> 
> /*
>   * Build with:
>   *   gcc -O2 -pthread -o test-pthread-join test-pthread-join.c
>   * Run in a loop:
>   *   for a in $(seq 500000); do echo $a; ./test-pthread-join || exit 1; done
>   */
> 
> void *testmemthread(void *arg)
> {
>          printf("thread id : %lu, pid %lu\n", pthread_self(), getpid());
>          return ((void*)0);
> }
> 
> int main()
> {
>          int err, i;
>          pthread_t testmemid[NR_THREADS];
>          void *tret;
> 
>          for (i = 0; i < NR_THREADS; i++) {
>                  err = pthread_create(&testmemid[i], NULL, testmemthread,
>                          (void *)(long)i);
>                  if (err != 0)
>                          exit(1);
>          }
>          for (i = 0; i < NR_THREADS; i++) {
>                  err = pthread_join(testmemid[i], &tret);
>                  if (err != 0)
>                          exit(1);
>          }
>          return 0;
> }
> 
> In all cases a FUTEX_WAIT is stuck waiting for a state change that can
> be validated to be present in user memory by inspecting the hung process
> with a debugger.
> 
> This can be reproduced with a Debian bullseye config-5.18.0-0.bpo.1-armmp
> configuration. The config-5.18.0-0.bpo.1-armmp configuration applied to
> a vanilla 5.18.2 kernel tree reproduces this issue when compiled with
> gcc version 10.2.1 20210110 (Debian 10.2.1-6). The U-Boot version is
> 2021.01+dfsg-4.
> 
> Note that this either does not appear to reproduce or takes longer to
> reproduce as soon as the configuration varies significantly enough to
> change the kernel code generated for futex wait.
> 
> - It takes longer to hit the hang when running on a 5.18.2 kernel
>    compiled with gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04).
> 
> - The issue is not reproduced with a kernel built from a
>    imx_v6_v7_defconfig configuration with gcc 10.2.1.
>    One important effect of this configuration change is that it targets
>    __LINUX_ARM_ARCH__ = 6 rather than __LINUX_ARM_ARCH__ = 7.
> 
> Root Cause Analysis
> ===================
> 
> Instrumentation of the futex system call FUTEX_WAKE and FUTEX_WAIT code
> with tracepoints, and tracing with LTTng [2] in "snapshot" flight
> recorder mode allows a better understanding of what is going on when the
> hang reproduces.
> 
> First, a bit of context about sys_futex: it relies on a Dekker [3]
> two-variables memory barrier scenario:
> 
>   * CPU 0                                 CPU 1
>   * val = *futex;
>   * sys_futex(WAIT, futex, val);
>   *   futex_wait(futex, val);
>   *
>   *   waiters++; (a)
>   *   smp_mb(); (A) <-- paired with -.
>   *                                  |
>   *   lock(hash_bucket(futex));      |
>   *                                  |
>   *   uval = *futex;                 |
>   *                                  |        *futex = newval;
>   *                                  |        sys_futex(WAKE, futex);
>   *                                  |          futex_wake(futex);
>   *                                  |
>   *                                  `--------> smp_mb(); (B)
>   *   if (uval == val)
>   *     queue();
>   *     unlock(hash_bucket(futex));
>   *     schedule();                         if (waiters)
>   *                                           lock(hash_bucket(futex));
>   *   else                                    wake_waiters(futex);
>   *     waiters--; (b)                        unlock(hash_bucket(futex));
>   *
>   * Where (A) orders the waiters increment and the futex value read through
>   * atomic operations (see futex_hb_waiters_inc) and where (B) orders the write
>   * to futex and the waiters read (see futex_hb_waiters_pending()).
>   *
>   * This yields the following case (where X:=waiters, Y:=futex):
>   *
>   *      X = Y = 0
>   *
>   *      w[X]=1          w[Y]=1
>   *      MB              MB
>   *      r[Y]=y          r[X]=x
>   *
>   * Which guarantees that x==0 && y==0 is impossible; which translates back into
>   * the guarantee that we cannot both miss the futex variable change and the
>   * enqueue.
> 
> When reproducing the hang, we observe the following in the userspace
> stacks and in the execution trace:
> 
>    (gdb) thread apply all bt
> 
>    Thread 5 (Thread 0xb5693450 (LWP 2404) "test_rwlock"):
>    #0  __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-syscall.S:46
>    #1  0xb6fa105c in futex_abstimed_wait (private=0, abstime=0x0, clockid=0, expected=3, futex_word=<optimized out>) at ../sysdeps/nptl/futex-internal.h:287
>    #2  __pthread_rwlock_wrlock_full (abstime=0x0, clockid=0, rwlock=0x4420d8 <lock>) at pthread_rwlock_common.c:731
>    #3  __GI___pthread_rwlock_wrlock (rwlock=rwlock@entry=0x4420d8 <lock>) at pthread_rwlock_wrlock.c:27
>    #4  0x00430fe0 in thr_writer (_count=0x96e1d0) at test_rwlock.c:205
>    #5  0xb6f9c98e in start_thread (arg=0x4d5aa9ac) at pthread_create.c:477
>    #6  0xb6f37bec in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:73 from /lib/arm-linux-gnueabihf/libc.so.6
>    Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> 
>    Thread 4 (Thread 0xb5e94450 (LWP 2403) "test_rwlock"):
>    #0  __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-syscall.S:46
>    #1  0xb6fa0ea4 in futex_abstimed_wait (private=0, abstime=0x0, clockid=0, expected=2, futex_word=<optimized out>) at ../sysdeps/nptl/futex-internal.h:287
>    #2  __pthread_rwlock_wrlock_full (abstime=0x0, clockid=0, rwlock=0x4420d8 <lock>) at pthread_rwlock_common.c:830
>    #3  __GI___pthread_rwlock_wrlock (rwlock=rwlock@entry=0x4420d8 <lock>) at pthread_rwlock_wrlock.c:27
>    #4  0x00430fe0 in thr_writer (_count=0x96e1c8) at test_rwlock.c:205
>    #5  0xb6f9c98e in start_thread (arg=0x4d5aa9ac) at pthread_create.c:477
>    #6  0xb6f37bec in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:73 from /lib/arm-linux-gnueabihf/libc.so.6
>    Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> 
>    Thread 3 (Thread 0xb6695450 (LWP 2402) "test_rwlock"):
>    #0  __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-syscall.S:46
>    #1  0xb6fa07be in futex_abstimed_wait (private=<optimized out>, abstime=0x0, clockid=0, expected=3, futex_word=<optimized out>) at ../sysdeps/nptl/futex-internal.h:287
>    #2  __pthread_rwlock_rdlock_full (abstime=0x0, clockid=0, rwlock=0x4420d8 <lock>) at pthread_rwlock_common.c:460
>    #3  __GI___pthread_rwlock_rdlock (rwlock=rwlock@entry=0x4420d8 <lock>) at pthread_rwlock_rdlock.c:27
>    #4  0x004311ba in thr_reader (_count=0x96e1b8) at test_rwlock.c:157
>    #5  0xb6f9c98e in start_thread (arg=0x4d5aa9ac) at pthread_create.c:477
>    #6  0xb6f37bec in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:73 from /lib/arm-linux-gnueabihf/libc.so.6
>    Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> 
>    Thread 2 (Thread 0xb6e96450 (LWP 2401) "test_rwlock"):
>    #0  __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-syscall.S:46
>    #1  0xb6fa07be in futex_abstimed_wait (private=<optimized out>, abstime=0x0, clockid=0, expected=3, futex_word=<optimized out>) at ../sysdeps/nptl/futex-internal.h:287
>    #2  __pthread_rwlock_rdlock_full (abstime=0x0, clockid=0, rwlock=0x4420d8 <lock>) at pthread_rwlock_common.c:460
>    #3  __GI___pthread_rwlock_rdlock (rwlock=rwlock@entry=0x4420d8 <lock>) at pthread_rwlock_rdlock.c:27
>    #4  0x004311ba in thr_reader (_count=0x96e1b0) at test_rwlock.c:157
>    #5  0xb6f9c98e in start_thread (arg=0x4d5aa9ac) at pthread_create.c:477
>    #6  0xb6f37bec in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:73 from /lib/arm-linux-gnueabihf/libc.so.6
>    Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> 
>    Thread 1 (Thread 0xb6fe3d60 (LWP 2400) "test_rwlock"):
>    #0  __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-syscall.S:46
>    #1  0xb6f9dafc in __pthread_clockjoin_ex (threadid=3068748880, thread_return=thread_return@entry=0xbeb80a8c, clockid=clockid@entry=0, abstime=abstime@entry=0x0, block=block@entry=true) at pthread_join_common.c:145
>    #2  0xb6f9d8ec in __pthread_join (threadid=<optimized out>, thread_return=thread_return@entry=0xbeb80a8c) at pthread_join.c:24
>    #3  0x00430b20 in main (argc=<optimized out>, argv=0xbeb80c14) at test_rwlock.c:367
> 
>    (gdb) print *rwlock
>    $1 = {__data = {__readers = 19, __writers = 0, __wrphase_futex = 3, __writers_futex = 3, __pad3 = 0, __pad4 = 0, __flags = 0 '\000',
>        __shared = 0 '\000', __pad1 = 0 '\000', __pad2 = 0 '\000', __cur_writer = 0},
>      __size = "\023\000\000\000\000\000\000\000\003\000\000\000\003", '\000' <repeats 18 times>, __align = 19}
> 
> Thread 4 (tid=2403) should either have been awakened when the
> __wrphase_futex state changed from 2 to 3, or should have observed a
> __wrphase_futex==3 and thus never have blocked.
> 
> Here is the relevant instrumentation. Note that the instrumentation
> added aims at minimizing the impact on the fast-path timings to make
> sure the issue can be reproduced under tracing. Indeed, adding too much
> instrumentation either hides the problem or makes it take much longer to
> reproduce.
> 
> futex_wait_end:              At each location where the function futex_wait_setup() returns.
> futex_wait_get_value_locked: Conditional if uval != val so the timing of the fast-path is not changed too much.
> futex_wait_get_user:         After futex_wait_setup issues get_user() (slow path for page faults).
> futex_wake_end:              At each location where the function futex_wake() returns.
> 
> Let's look at the relevant portion of the trace just before the hang:
> 
> [...]
>          [16:27:34.437683527] (+0.000004666) futex_wait_end: { cpu_id = 2 }, { tid = 2403, pid = 2400 }, { uaddr = 0x4420E0, val = 2, ret = 0, msg = "" }
>          [16:27:34.437700528] (+0.000017001) futex_wait_end: { cpu_id = 0 }, { tid = 2402, pid = 2400 }, { uaddr = 0x4420E0, val = 3, ret = 0, msg = "" }
>          [16:27:34.437703195] (+0.000002667) futex_wake_end: { cpu_id = 1 }, { tid = 2401, pid = 2400 }, { uaddr = 0x4420E0, ret = 1, msg = "" }
>          [16:27:34.437704862] (+0.000001667) futex_wait_end: { cpu_id = 3 }, { tid = 2404, pid = 2400 }, { uaddr = 0x4420E4, val = 3, ret = 0, msg = "" }
>          [16:27:34.437708195] (+0.000003333) futex_wait_end: { cpu_id = 1 }, { tid = 2401, pid = 2400 }, { uaddr = 0x4420E0, val = 3, ret = 0, msg = "" }
>          [16:27:34.437735863] (+0.000027668) futex_wake_end: { cpu_id = 2 }, { tid = 2403, pid = 2400 }, { uaddr = 0x4420E0, ret = 2, msg = "" }
>          [16:27:34.437741863] (+0.000006000) futex_wake_end: { cpu_id = 2 }, { tid = 2403, pid = 2400 }, { uaddr = 0x4420E4, ret = 1, msg = "" }
>          [16:27:34.437745863] (+0.000004000) futex_wait_end: { cpu_id = 2 }, { tid = 2403, pid = 2400 }, { uaddr = 0x4420E0, val = 2, ret = 0, msg = "" }
>          [16:27:34.437762531] (+0.000016668) futex_wait_end: { cpu_id = 1 }, { tid = 2401, pid = 2400 }, { uaddr = 0x4420E0, val = 3, ret = 0, msg = "" }
>          [16:27:34.437765531] (+0.000003000) futex_wake_end: { cpu_id = 0 }, { tid = 2402, pid = 2400 }, { uaddr = 0x4420E0, ret = 1, msg = "" }
>          [16:27:34.437767864] (+0.000002333) futex_wait_end: { cpu_id = 3 }, { tid = 2404, pid = 2400 }, { uaddr = 0x4420E4, val = 3, ret = 0, msg = "" }
>          [16:27:34.437770198] (+0.000002334) futex_wait_end: { cpu_id = 0 }, { tid = 2402, pid = 2400 }, { uaddr = 0x4420E0, val = 3, ret = 0, msg = "" }
>          [16:27:34.437797865] (+0.000027667) futex_wake_end: { cpu_id = 2 }, { tid = 2403, pid = 2400 }, { uaddr = 0x4420E0, ret = 2, msg = "" }
>          [16:27:34.437803866] (+0.000006001) futex_wake_end: { cpu_id = 2 }, { tid = 2403, pid = 2400 }, { uaddr = 0x4420E4, ret = 1, msg = "" }
>          [16:27:34.437807866] (+0.000004000) futex_wait_end: { cpu_id = 2 }, { tid = 2403, pid = 2400 }, { uaddr = 0x4420E0, val = 2, ret = 0, msg = "" }
>          [16:27:34.437824866] (+0.000017000) futex_wait_end: { cpu_id = 0 }, { tid = 2402, pid = 2400 }, { uaddr = 0x4420E0, val = 3, ret = 0, msg = "" }
>          [16:27:34.437826866] (+0.000002000) futex_wake_end: { cpu_id = 1 }, { tid = 2401, pid = 2400 }, { uaddr = 0x4420E0, ret = 1, msg = "" }
>          [16:27:34.437830200] (+0.000003334) futex_wait_end: { cpu_id = 3 }, { tid = 2404, pid = 2400 }, { uaddr = 0x4420E4, val = 3, ret = 0, msg = "" }
>          [16:27:34.437831533] (+0.000001333) futex_wait_end: { cpu_id = 1 }, { tid = 2401, pid = 2400 }, { uaddr = 0x4420E0, val = 3, ret = 0, msg = "" }
>          [16:27:34.437852868] (+0.000021335) futex_wake_end: { cpu_id = 2 }, { tid = 2403, pid = 2400 }, { uaddr = 0x4420E0, ret = 2, msg = "" }
>          [16:27:34.437858534] (+0.000005666) futex_wake_end: { cpu_id = 2 }, { tid = 2403, pid = 2400 }, { uaddr = 0x4420E4, ret = 1, msg = "" }
> (b)     [16:27:34.437862868] (+0.000004334) futex_wait_end: { cpu_id = 2 }, { tid = 2403, pid = 2400 }, { uaddr = 0x4420E0, val = 2, ret = 0, msg = "" }
> (a)     [16:27:34.437879202] (+0.000016334) futex_wake_end: { cpu_id = 0 }, { tid = 2402, pid = 2400 }, { uaddr = 0x4420E0, ret = 0, msg = "!futex_hb_waiters_pending" }
>          [16:27:34.437879535] (+0.000000333) futex_wait_end: { cpu_id = 1 }, { tid = 2401, pid = 2400 }, { uaddr = 0x4420E0, val = 3, ret = 0, msg = "" }
>          [16:27:34.437884535] (+0.000005000) futex_wait_end: { cpu_id = 0 }, { tid = 2402, pid = 2400 }, { uaddr = 0x4420E0, val = 3, ret = 0, msg = "" }
>          [16:27:34.437884535] (+0.000000000) futex_wait_end: { cpu_id = 3 }, { tid = 2404, pid = 2400 }, { uaddr = 0x4420E4, val = 3, ret = 0, msg = "" }
>          [16:27:35.241824878] (+0.803940343) futex_wait_end: { cpu_id = 2 }, { tid = 2400, pid = 2400 }, { uaddr = 0xB6E964B8, val = 2401, ret = 0, msg = "" }
> 
> At (a), tid=2402 observes waiters_pending==0, and therefore skips
> awakening any other threads on futex uaddr=0x4420E0.
> 
> However, at (b), tid=2403 returns from futex_wait_setup() on futex
> uaddr=0x4420E0 with ret=0, which will cause it to block. It was called
> with a val=2 as input argument. Considering that no
> futex_wait_get_value_locked is traced, this means the observed uval
> loaded by futex_get_value_locked() matches the expected val (==2).
> 
> Considering that tid=2402 observes waiters_pending==0, we have the
> following ordering:
> 
> Waker                  Waiter
> tid=2402               tid=2403
> -------------------------------
> *futex=3
> dmb
>                         load *futex
>                         sys_futex
> load waiters_pending
>    (observe 0)
>                           atomic_inc waiters_pending
>                           dmb
>                           load *futex
>                             (observe 2, impossible!)
> 
> The fact that the waiter thread observes the futex=2 when the waker
> observed waiters_pending=0 is a contradiction of the Dekker 2-variables
> memory barrier scenario.
> 
> Looking more specifically at the operations involved in the loads and
> stores of the futex and waiters_pending variables, we notice two things:
> 
> 1) atomic_inc has a prefetchw() (PLDW) instruction, which is compiled
>     out for __LINUX_ARM_ARCH__ = 6, which could explain why imx_v6_v7_defconfig
>     does not reproduce the hang.
> 
> 2) the waiter thread has a pattern of load *futex; dmb; load *futex,
>     which are two loads of the same variable. I have attempted to modify
>     the get_user used for the second load to replace LDR by LDREX in
>     case some variation of errata 761319 would be at play here, but
>     the hang persists.
> 
> Solution
> ========
> 
> The hang does not reproduce with the code that implements the arm
> prefetchw() static inline function commented out.
> 
> Note that it is not the same as commenting out the entire arch-specific
> prefetchw implementation (leaving ARCH_HAS_PREFETCHW undefined), which
> then relies on the __builtin_prefetch() builtin.
> 
> Known Drawbacks
> ===============
> 
> Removing prefetch instructions can affect the performance of some
> microbenchmarks, especially for streaming use-cases.
> 
> Unfortunately, the Cortex-A9 does not appear to have a documented
> Coprocessor Access Control Register bit for disabling the PLD and PLDW
> instructions, which prevents fixing it at boot-time from U-Boot.
> Removing the prefetch instruction from the kernel code does not fix
> similar issues that may arise in user-space.
> 
> Request for Feedback
> ====================
> 
> This fix targets all i.MX configurations, but it is likely too broad (or
> too narrow). It would be great if people with access to different
> Freescale i.MX test boards, and test boards from other vendors, could try
> to reproduce the issue to figure out what would be the right scope for
> this fix.
> 
> It would also be great if people with knowledge of the ARM CPU internals
> could help understanding whether this fix really fixes an issue between
> prefetch and memory barriers, or just happens to hide the issue. It
> would be good to understand whether this issue only affects PLDW or if
> it also affects the PLD instruction.
> 
> Link: https://liburcu.org [1]
> Link: https://lttng.org [2]
> Link: https://lwn.net/Articles/573436/ [3]
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: "Mark Rutland" <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: "Shawn Guo" <shawnguo@kernel.org>
> Cc: "Sascha Hauer" <s.hauer@pengutronix.de>
> Cc: Michael Jeanson <mjeanson@efficios.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>   arch/arm/Kconfig                 | 3 +++
>   arch/arm/include/asm/processor.h | 2 ++
>   arch/arm/mach-imx/Kconfig        | 1 +
>   3 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2e8091e2d8a8..ffcc0363e171 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -239,6 +239,9 @@ config GENERIC_ISA_DMA
>   config FIQ
>   	bool
>   
> +config ARM_DISABLE_PREFETCHW
> +	bool
> +
>   config ARCH_MTD_XIP
>   	bool
>   
> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> index bdc35c0e8dfb..8a3e0c566d1f 100644
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -121,6 +121,7 @@ static inline void prefetch(const void *ptr)
>   #define ARCH_HAS_PREFETCHW
>   static inline void prefetchw(const void *ptr)
>   {
> +#if !defined(CONFIG_ARM_DISABLE_PREFETCHW)
>   	__asm__ __volatile__(
>   		".arch_extension	mp\n"
>   		__ALT_SMP_ASM(
> @@ -128,6 +129,7 @@ static inline void prefetchw(const void *ptr)
>   			"pld\t%a0"
>   		)
>   		:: "p" (ptr));
> +#endif
>   }
>   #endif
>   #endif
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index c5a59158722b..1bbc6d63b6ec 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -10,6 +10,7 @@ menuconfig ARCH_MXC
>   	select PM_OPP if PM
>   	select SOC_BUS
>   	select SRAM
> +	select ARM_DISABLE_PREFETCHW
>   	help
>   	  Support for Freescale MXC/iMX-based family of processors
>   


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
