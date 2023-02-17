Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0E869AE2E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjBQOjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBQOjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:39:09 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847546606E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 06:39:08 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id l11so730804vst.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 06:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676644747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JbhiIfKoe54VJ/wxl88EPsQAzayy9Z6bnY/eSqPcRPw=;
        b=V3t5JXtPp99qogXl2V+0ip58XjbCgL56ryrANhCpXfNNyqYpwol4U4zttF/CoLybH/
         4Ie7TLJQSSmkSNsJZW0cu+GMNEm3LQuhnkeSUPUvK05X4jxIAn7hwlHVNApTeW1ZqKyK
         qqo6Xu5UyqRvW1kW8RxIDFHgGuw71HW90fgAOKiyKV0QtfAHzCoAaia+jm5LY+OQzr38
         Osbj7mQ2LfNnU/Vemw1Pv8h8sN7kuGU/oHnm/1Kyca+fmEQ8y3sie3jOhfbyURFJ1vUW
         pxrxRvvMJxbLpHDFFrR0pp3qXjI2JdxwCNbohM5hWWI2sajwduW9IRcNU7fpP7gazhVP
         e58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676644747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbhiIfKoe54VJ/wxl88EPsQAzayy9Z6bnY/eSqPcRPw=;
        b=C8XsJf5FCVVBkS4lrJwm9cRdPSu3qKCFBFltTDcGPgVHb0DB58hYVV/pmFqjl5eYJB
         lmhBCLg01U05HV5mmR/PhsWXyfZBcD3zGn5UADNNWHXL9R996PLY3Blci6u5Za94w1Ud
         ggBxgp6bu9Mnsm8l0ZsexqJjKxMKjd/BeI5N25Rm3XZdeufRwuZY3JAzox9YBZF7GLwf
         635Bm35L67IKTgv4uWdwf71ZYl2cZq1bQBCg/n+pUaqS44xqDz32F7C5nPqU44hZ1PCD
         98w8FPK5R0uhncU0qXpf4owot2MEFJMxPjq3txnaEW0VShu3Wo66u7BDcdPjUyPxFrpW
         d0Ug==
X-Gm-Message-State: AO0yUKXZ7rH1Yc67iW4u9i+R8MqrnN0P0bpwYrFh4+t/DUuCOpYejA98
        gEtiG3Z1+uO6OMVk0IqYiKYP5D0rmw+FrseJthAaJA==
X-Google-Smtp-Source: AK7set/OLhsXmpgKnpybiNHICvSqF3hsuaf2et6m3BEwwhTpH7yOqja8zNQdh7qfwkeCtlHFlQXnBGSPtWY0/a23gPI=
X-Received: by 2002:a67:6242:0:b0:412:6a3:3e1d with SMTP id
 w63-20020a676242000000b0041206a33e1dmr21523vsb.25.1676644747414; Fri, 17 Feb
 2023 06:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20230217100606.1234-1-nbd@nbd.name> <CANn89iJXjEWJcFbSMwKOXuupCVr4b-y4Gh+LwOQg+TQwJPQ=eg@mail.gmail.com>
 <acaf1607-412d-3142-1465-8d8439520228@nbd.name> <CANn89iLQa-FruxSUQycawQAHY=wCFP_Q3LHEQfusL1pUbNVxyg@mail.gmail.com>
 <e317d5bc-cc26-8b1b-ca4b-66b5328683c4@nbd.name>
In-Reply-To: <e317d5bc-cc26-8b1b-ca4b-66b5328683c4@nbd.name>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 17 Feb 2023 15:38:56 +0100
Message-ID: <CANn89i+j6==4S4Oyn+NVgm+qRQO_P5dMjxGSEjntPVp=v-HA1A@mail.gmail.com>
Subject: Re: [RFC v2] net/core: add optional threading for rps backlog processing
To:     Felix Fietkau <nbd@nbd.name>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 2:40 PM Felix Fietkau <nbd@nbd.name> wrote:
>
> On 17.02.23 13:57, Eric Dumazet wrote:
> > On Fri, Feb 17, 2023 at 1:35 PM Felix Fietkau <nbd@nbd.name> wrote:
> >>
> >> On 17.02.23 13:23, Eric Dumazet wrote:
> >> > On Fri, Feb 17, 2023 at 11:06 AM Felix Fietkau <nbd@nbd.name> wrote:
> >> >>
> >> >> When dealing with few flows or an imbalance on CPU utilization, static RPS
> >> >> CPU assignment can be too inflexible. Add support for enabling threaded NAPI
> >> >> for RPS backlog processing in order to allow the scheduler to better balance
> >> >> processing. This helps better spread the load across idle CPUs.
> >> >>
> >> >> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> >> >> ---
> >> >>
> >> >> RFC v2:
> >> >>  - fix rebase error in rps locking
> >> >
> >> > Why only deal with RPS ?
> >> >
> >> > It seems you propose the sofnet_data backlog be processed by a thread,
> >> > instead than from softirq ?
> >> Right. I originally wanted to mainly improve RPS, but my patch does
> >> cover backlog in general. I will update the description in the next
> >> version. Does the approach in general make sense to you?
> >>
> >
> > I do not know, this seems to lack some (perf) numbers, and
> > descriptions of added max latencies and stuff like that :)
> I just ran some test where I used a MT7621 device (dual-core 800 MHz
> MIPS, 4 threads) as a router doing NAT without flow offloading.
>
> Using the flent RRUL test between 2 PCs connected through the router,
> I get these results:
>
> rps_threaded=0: (combined CPU idle time around 27%)
>                               avg       median       99th %          # data pts
>   Ping (ms) ICMP   :        26.08        28.70        54.74 ms              199
>   Ping (ms) UDP BE :         1.96        24.12        37.28 ms              200
>   Ping (ms) UDP BK :         1.88        15.86        27.30 ms              200
>   Ping (ms) UDP EF :         1.98        31.77        54.10 ms              200
>   Ping (ms) avg    :         1.94          N/A          N/A ms              200
>   TCP download BE  :        69.25        70.20       139.55 Mbits/s         200
>   TCP download BK  :        95.15        92.51       163.93 Mbits/s         200
>   TCP download CS5 :       133.64       129.10       292.46 Mbits/s         200
>   TCP download EF  :       129.86       127.70       254.47 Mbits/s         200
>   TCP download avg :       106.97          N/A          N/A Mbits/s         200
>   TCP download sum :       427.90          N/A          N/A Mbits/s         200
>   TCP totals       :       864.43          N/A          N/A Mbits/s         200
>   TCP upload BE    :        97.54        96.67       163.99 Mbits/s         200
>   TCP upload BK    :       139.76       143.88       190.37 Mbits/s         200
>   TCP upload CS5   :        97.52        94.70       206.60 Mbits/s         200
>   TCP upload EF    :       101.71       106.72       147.88 Mbits/s         200
>   TCP upload avg   :       109.13          N/A          N/A Mbits/s         200
>   TCP upload sum   :       436.53          N/A          N/A Mbits/s         200
>
> rps_threaded=1: (combined CPU idle time around 16%)
>                               avg       median       99th %          # data pts
>   Ping (ms) ICMP   :        13.70        16.10        27.60 ms              199
>   Ping (ms) UDP BE :         2.03        18.35        24.16 ms              200
>   Ping (ms) UDP BK :         2.03        18.36        29.13 ms              200
>   Ping (ms) UDP EF :         2.36        25.20        41.50 ms              200
>   Ping (ms) avg    :         2.14          N/A          N/A ms              200
>   TCP download BE  :       118.69       120.94       160.12 Mbits/s         200
>   TCP download BK  :       134.67       137.81       177.14 Mbits/s         200
>   TCP download CS5 :       126.15       127.81       174.84 Mbits/s         200
>   TCP download EF  :        78.36        79.41       143.31 Mbits/s         200
>   TCP download avg :       114.47          N/A          N/A Mbits/s         200
>   TCP download sum :       457.87          N/A          N/A Mbits/s         200
>   TCP totals       :       918.19          N/A          N/A Mbits/s         200
>   TCP upload BE    :       112.20       111.55       164.38 Mbits/s         200
>   TCP upload BK    :       144.99       139.24       205.12 Mbits/s         200
>   TCP upload CS5   :        93.09        95.50       132.39 Mbits/s         200
>   TCP upload EF    :       110.04       108.21       207.00 Mbits/s         200
>   TCP upload avg   :       115.08          N/A          N/A Mbits/s         200
>   TCP upload sum   :       460.32          N/A          N/A Mbits/s         200
>
> As you can see, both throughput and latency improve because load can be
> better distributed across CPU cores.
>

What happens if user threads are competing with your kthreads ?

It seems you are adding another variant of ksoftirqd.

More threads might look better in some cases, if we accept to be at
the mercy of process scheduling decisions.

NUMA affinities matter, I do not see how you are dealing with this.

Your patch assumes all cpus can participate in network processing,
but rps is fine grained:
Boxes with 128 or 256 cpus usually have different rps_mask per receive
queue, with 2 or 4 bits set in the per-rx-queue rps_mask.

Then, process_backlog() has been designed to run only from the cpu
tied to the per-cpu data (softnet_data)
There are multiple comments about this assumption, and various things
that would need to be changed
(eg sd_has_rps_ipi_waiting() would be wrong in its current implementation)
