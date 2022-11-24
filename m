Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985AC637161
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 05:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiKXEIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 23:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKXEIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 23:08:37 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F0191C0D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 20:08:35 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id a1-20020a17090abe0100b00218a7df7789so4002915pjs.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 20:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZXCAJ/JYKKLb4gRFoa/4DqOD2SpedPyt+jDZS8Ji30=;
        b=S66XJi71V+urQt+CEyEpO1/RY6RU2FZ8K1b1T6rzSCbISqkyrXfjxhqRpl4WmgsSA2
         13h1soaAaRCCB3bz2fmiwYXwyBq+iBunJisvtVeF9s6f1WewKHX/nwZyM3yMTGM/u5zq
         H4i8g+v1JMcr+0HrwFZdGXjSdZMaf7jJmGNqXNLn5PMlfOhyg7E5zv4YtqsBKXRKE84L
         yZVFi3toMw6TJcR2CkpgZuW0KVASVZjdEsC+w6XBJgAGOQM4noYGqTPUvFeMdGHsuc+u
         /Cxjo+m4/YLLzs0RahE0T7Lsrl29JgPJyR6ws62/UaFul2ut02ozUnQ/uN49FzaRX+Cs
         tjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZXCAJ/JYKKLb4gRFoa/4DqOD2SpedPyt+jDZS8Ji30=;
        b=BgQlQeUA8aUPoQi6VSF1xmIqJ7eP7pullwPKsf6kyQWj9FoDoLJpxAeYtlzKEPNHze
         Euq1Tl7Yf6ciQGBfnP5eZ9/d/bei9CBnKRh43qS04/0RN4ChCkwltEVD5Z6FuvtRCFg0
         o4+JRc6PbVc/c8UN/3oQZ6cfWMPIEMqlfrajEtEa80WiUqQT9c6X+ki70Kff4P/UIIXi
         nC0UIc2x7p1oDsWJIqW6tSxyCrPF9hA8U+QJBRDGnUgANMauubrlq/wp0eenonKHaKDu
         sStABb3CSWc3I33FpUhaTgst+jB2WxBK3+Dw+mA0ckHQExXwTCZ9ZhJxhp5hFTtJjK/W
         xIqw==
X-Gm-Message-State: ANoB5pk2R7aYpM443yKoJFFFJZAZDRl6DHYdgBGoM52OEuJVndZsmY8L
        PGX6SgCuTn1shOBQNC1eEV8ZzS7kHnv2nQ==
X-Google-Smtp-Source: AA0mqf5UEVf+8uX+ZB2M6uPnaKC76ZkFwCFwajPrKbaySNAG32nP+Wzivz1pd4HtmtGdZ3BVbhrK4Q==
X-Received: by 2002:a17:90a:460b:b0:218:8a84:aeca with SMTP id w11-20020a17090a460b00b002188a84aecamr27732429pjg.63.1669262914817;
        Wed, 23 Nov 2022 20:08:34 -0800 (PST)
Received: from DougS18 (s173-180-45-4.bc.hsia.telus.net. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902c94b00b001754fa42065sm3528pla.143.2022.11.23.20.08.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Nov 2022 20:08:33 -0800 (PST)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Kajetan Puchalski'" <kajetan.puchalski@arm.com>,
        <rafael@kernel.org>, "'Zhang Rui'" <rui.zhang@intel.com>
Cc:     <daniel.lezcano@linaro.org>, <lukasz.luba@arm.com>,
        <Dietmar.Eggemann@arm.com>, <yu.chen.surf@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <20221102152808.2978590-1-kajetan.puchalski@arm.com> <Y3ttlCCezC+SvFDH@e126311.manchester.arm.com>
In-Reply-To: <Y3ttlCCezC+SvFDH@e126311.manchester.arm.com>
Subject: RE: [RFC PATCH v4 0/2] cpuidle: teo: Introduce util-awareness
Date:   Wed, 23 Nov 2022 20:08:35 -0800
Message-ID: <00a801d8ffba$6cd72a70$46857f50$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHHOljlUm50YLRjgI6z6kjqb0X0CQFCgUFLrmbozeA=
Content-Language: en-ca
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022.11.21 04:23 Kajetan Puchalski wrote:

> Hi Rafael,
>
> On Wed, Nov 02, 2022 at 03:28:06PM +0000, Kajetan Puchalski wrote:
>
> [...]
>
>> v3 -> v4:
>> - remove the chunk of code skipping metrics updates when the CPU was utilized
>> - include new test results and more benchmarks in the cover letter
>
> [...]
>
> It's been some time so I just wanted to bump this, what do you think
> about this v4? Doug has already tested it, resuls for his machine are
> attached to the v3 thread.

Hi All,

I continued to test this and included the proposed ladder idle governor in my continued testing.
(Which is why I added Rui as an addressee)
However, I ran out of time. Here is what I have:

Kernel: 6.1-rc3 and with patch sets
Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
CPU scaling driver: intel_cpufreq
HWP disabled.
Unless otherwsie stated, performance CPU scaling govenor.

Legend:
teo: the current teo idle governor
util-v4: the RFC utilization teo patch set version 4.
menu: the menu idle governor
ladder-old: the current ladder idle governor
ladder: the RFC ladder patchset.

Workflow: shell-intensive serialized workloads.
Variable: PIDs per second.
Note: Single threaded.
Master reference: forced CPU affinity to 1 CPU.
Performance Results:
http://smythies.com/~doug/linux/idle/teo-util/graphs/pids-perf.png
Schedutil Results:
http://smythies.com/~doug/linux/idle/teo-util/graphs/pids-su.png

Workflow: sleeping ebizzy 128 threads.
Variable: interval (uSecs).
Performance Results:
http://smythies.com/~doug/linux/idle/teo-util/graphs/ebizzy-128-perf.png
Performance power and idle data:
http://smythies.com/~doug/linux/idle/teo-util/ebizzy/perf/
Schedutil Results:
http://smythies.com/~doug/linux/idle/teo-util/graphs/pids-su.png
Schedutil power and idle data:
http://smythies.com/~doug/linux/idle/teo-util/ebizzy/su/

Workflow: 6 core ping-pong.
Variable: amount of work packet per token transfer
Forced CPU affinity, 16.67% load per core (6 CPUs idle, 6 busy).
Overview:
http://smythies.com/~doug/linux/idle/teo-util/graphs/6-core-ping-pong-sweep.png
short loop times detail:
http://smythies.com/~doug/linux/idle/teo-util/graphs/6-core-ping-pong-sweep-detail-a.png
Power and idle data:
http://smythies.com/~doug/linux/idle/teo-util/ping-sweep/6-4/
The transition between 35 and 40 minutes will be some future investigation.

Workflow: periodic 73, 113, 211, 347, 401 work/sleep frequency.
Summary: Nothing interesting.
Variable: work packet (load), ramps up and then down.
Single threaded.
Power and idle data:
http://smythies.com/~doug/linux/idle/teo-util/consume/idle-3/
Higher resolution power data:
http://smythies.com/~doug/linux/idle/teo-util/consume/ps73/
http://smythies.com/~doug/linux/idle/teo-util/consume/ps113/
http://smythies.com/~doug/linux/idle/teo-util/consume/ps211/
http://smythies.com/~doug/linux/idle/teo-util/consume/ps347/
http://smythies.com/~doug/linux/idle/teo-util/consume/ps401/

Workflow: fast speed 2 pair, 4 threads ping-pong.
Variable: none, this is a dwell test.
Results:
http://smythies.com/~doug/linux/idle/teo-util/many-0-400000000-2/times.txt
Performance power and idle data:
http://smythies.com/~doug/linux/idle/teo-util/many-0-400000000-2/perf/
Schedutil power and idle data:
http://smythies.com/~doug/linux/idle/teo-util/many-0-400000000-2/su/

Workflow: medium speed 2 pair, 4 threads ping-pong.
Variable: none, this is a dwell test.
Results:
http://smythies.com/~doug/linux/idle/teo-util/many-3000-100000000-2/times.txt
Performance power and idle data:
http://smythies.com/~doug/linux/idle/teo-util/many-3000-100000000-2/perf/
Schedutil power and idle data:
http://smythies.com/~doug/linux/idle/teo-util/many-3000-100000000-2/su/

Workflow: slow speed 2 pair, 4 threads ping-pong.
Variable: none, this is a dwell test.
Results:
http://smythies.com/~doug/linux/idle/teo-util/many-1000000-342000-2/times.txt
Performance power and idle data:
http://smythies.com/~doug/linux/idle/teo-util/many-1000000-342000-2/perf/
Schedutil power and idle data:
http://smythies.com/~doug/linux/idle/teo-util/many-1000000-342000-2/su/

Results summary:

Results are uSeconds per loop.
Less is better.

Slow ping pong - 2 pairs, 4 threads.

Performance:
ladder_old:	Average: 2583 (-0.56%)
ladder:		Average: 2617 (+0.81%)
menu:		Average: 2596 Reference Time.
teo:		Average: 2689 (+3.6%)
util-v4		Average: 2665 (+2.7%)

Schedutil:
ladder-old:	Average: 4490 (+44%)
ladder:		Average: 3296 (+5.9%)
menu:		Average: 3113 Reference Time.
teo:		Average: 4005 (+29%)
util-v4:		Average: 3527 (+13%)

Medium ping pong - 2 pairs, 4 threads.

Performance:
ladder-old:	Average: 11.8214 (+4.6%)
ladder:		Average: 11.7730 (+4.2%)
menu:		Average: 11.2971 Reference Time.
teo:		Average: 11.355 (+5.1%)
util-v4:		Average: 11.3364 (+3.4%)

Schedutil:
ladder-old:	Average: 15.6813 (+30%)
ladder:		Average: 15.4338 (+28%)
menu:		Average: 12.0868 Reference Time.
teo:		Average: 11.7367 (-2.9%)
util-v4:		Average: 11.6352 (-3.7%)

Fast ping pong - 2 pairs, 4 threads.

Performance:
ladder-old:	Average: 4.009 (+39%)
ladder:		Average: 3.844 (+33%)
menu:		Average: 2.891 Reference Time.
teo:		Average: 3.053 (+5.6%)
util-v4:		Average: 2.985 (+3.2%)

Schedutil:
ladder-old:	Average: 5.053 (+64%)
ladder:		Average: 5.278 (+71%)
menu:		Average: 3.078 Reference Time.
teo:		Average: 3.106 (+0.91%)
util-v4:		Average: 3.15 (+2.35%)
 
... Doug


