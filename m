Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F53645836
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiLGKxR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Dec 2022 05:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiLGKxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:53:06 -0500
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F4111442;
        Wed,  7 Dec 2022 02:53:04 -0800 (PST)
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpuidle-haltpoll: Disable kvm guest polling when
 mwait_idle is used
Thread-Topic: [PATCH] cpuidle-haltpoll: Disable kvm guest polling when
 mwait_idle is used
Thread-Index: AQHZCWttIym3Q6GeZEeVWIMC3IQoba5hyAuwgABojSA=
Date:   Wed, 7 Dec 2022 10:49:10 +0000
Message-ID: <59bf331606fc4d68a8aa866c50c902be@baidu.com>
References: <1670308998-12313-1-git-send-email-lirongqing@baidu.com>
 <CAJZ5v0gG93BXZWOcRVpng_EN-h4+sOyUqTc1XRt4xZkqMnaZZw@mail.gmail.com>
 <87mt80g2fp.ffs@tglx> 
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.206.14]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.53
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Before change, "sockperf ping-pong -i 127.0.0.1 -p 20001  --tcp " latency is:
> sockperf: Summary: Latency is 6.245 usec
> 
> this patch, disable cpuidle-haltpoll
> sockperf: Summary: Latency is 4.671 usec
> 
> 
> using arch_cpu_idle() in default_enter_idle()
> sockperf: Summary: Latency is 4.285 usec
> 

When I did upper tests, I taskset sockperf server and client to different cpus, so using arch_cpu_idle() in default_enter_idle() gets better result.

I test unixbench also, find that Don't loading cpuidle-haltholl can get more performance on 8 cores (2 threads per core) intel cpu which cstate is disabled in host

Don't load cpuidle-haltpoll:

System Benchmarks Index Values               BASELINE       RESULT    INDEX
Dhrystone 2 using register variables         116700.0   45665777.0   3913.1
Double-Precision Whetstone                       55.0       6808.3   1237.9
Execl Throughput                                 43.0       4498.0   1046.1
File Copy 1024 bufsize 2000 maxblocks          3960.0    1285429.0   3246.0
File Copy 256 bufsize 500 maxblocks            1655.0     343057.0   2072.9
File Copy 4096 bufsize 8000 maxblocks          5800.0    3750374.0   6466.2
Pipe Throughput                               12440.0    2271618.8   1826.1
Pipe-based Context Switching                   4000.0     166393.6    416.0
Process Creation                                126.0      12845.8   1019.5
Shell Scripts (1 concurrent)                     42.4       9470.2   2233.5
Shell Scripts (8 concurrent)                      6.0       4526.6   7544.4
System Call Overhead                          15000.0    2082221.1   1388.1
                                                                   ========
System Benchmarks Index Score                                        1995.8

System Benchmarks Index Values               BASELINE       RESULT    INDEX
Dhrystone 2 using register variables         116700.0  388552307.2  33295.0
Double-Precision Whetstone                       55.0      98968.4  17994.2
Execl Throughput                                 43.0      42346.5   9848.0
File Copy 1024 bufsize 2000 maxblocks          3960.0     945510.0   2387.7
File Copy 256 bufsize 500 maxblocks            1655.0     246909.0   1491.9
File Copy 4096 bufsize 8000 maxblocks          5800.0    3394311.0   5852.3
Pipe Throughput                               12440.0   21325271.3  17142.5
Pipe-based Context Switching                   4000.0    2746301.9   6865.8
Process Creation                                126.0      94459.6   7496.8
Shell Scripts (1 concurrent)                     42.4      62378.6  14711.9
Shell Scripts (8 concurrent)                      6.0       8841.4  14735.7
System Call Overhead                          15000.0    8850338.7   5900.2
                                                                   ========
System Benchmarks Index Score                                        8482.8



Replace default_idle with arch_cpu_idle, and load cpuidle-haltpoll, code like below:

@@ -32,7 +33,7 @@ static int default_enter_idle(struct cpuidle_device *dev,
                local_irq_enable();
                return index;
        }
-       default_idle();
+       arch_cpu_idle();
        return index;
 }
Result is below:
System Benchmarks Index Values               BASELINE       RESULT    INDEX
Dhrystone 2 using register variables         116700.0   42647356.0   3654.4
Double-Precision Whetstone                       55.0       6812.9   1238.7
Execl Throughput                                 43.0       4424.4   1028.9
File Copy 1024 bufsize 2000 maxblocks          3960.0    1297513.0   3276.5
File Copy 256 bufsize 500 maxblocks            1655.0     346228.0   2092.0
File Copy 4096 bufsize 8000 maxblocks          5800.0    3902320.0   6728.1
Pipe Throughput                               12440.0    2292292.4   1842.7
Pipe-based Context Switching                   4000.0     163775.9    409.4
Process Creation                                126.0      12216.8    969.6
Shell Scripts (1 concurrent)                     42.4       9375.4   2211.2
Shell Scripts (8 concurrent)                      6.0       4395.2   7325.3
System Call Overhead                          15000.0    2030942.7   1354.0
                                                                   ========
System Benchmarks Index Score                                        1971.4

System Benchmarks Index Values               BASELINE       RESULT    INDEX
Dhrystone 2 using register variables         116700.0  390316671.8  33446.2
Double-Precision Whetstone                       55.0      98945.1  17990.0
Execl Throughput                                 43.0      39600.0   9209.3
File Copy 1024 bufsize 2000 maxblocks          3960.0     939526.0   2372.5
File Copy 256 bufsize 500 maxblocks            1655.0     256813.0   1551.7
File Copy 4096 bufsize 8000 maxblocks          5800.0    3431020.0   5915.6
Pipe Throughput                               12440.0   21320118.9  17138.4
Pipe-based Context Switching                   4000.0    2743588.5   6859.0
Process Creation                                126.0      94142.2   7471.6
Shell Scripts (1 concurrent)                     42.4      62425.0  14722.9
Shell Scripts (8 concurrent)                      6.0       8841.3  14735.5
System Call Overhead                          15000.0    8864145.2   5909.4
                                                                   ========
System Benchmarks Index Score                                        8467.7


So I think we should not load cpuidle-haltpoll driver when guest has mwait

What's your suggestion

Thanks

-Li


