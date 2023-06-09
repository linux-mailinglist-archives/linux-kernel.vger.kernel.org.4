Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6386729D87
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbjFIO5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241761AbjFIO5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:57:05 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726533C26
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:56:41 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-19f2fb9b1cdso608589fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1686322600; x=1688914600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNjEF1zb+JpJdY0weZ4OdAOu0yke/I9t8R3uYm6sLTw=;
        b=yqu1Gt/I72W8rGCMTbNxP4nxyhxODNNERehop1YFjTuhAXJzp3uvoX/x6Zqn80ZPsP
         qPNKqE0PRLSNo9svzye/a1X7FjDNhWzOUX+2yPywDUpNtdZd/TITx3Ce2a77ghBWrL9U
         EmSNrEfZYGTeblSWGgITvKbFQLgD9LROEfaw65vEhd231ogFe7GnM79ShBz8kCsPyZaH
         cdkBTFk7A522ggTbqdCnOhpuWmX4QnN7G4NRlIwBcPXt41WPTGi7ZtUuiGXlFu6e5sm+
         Rb3YsG0S3J8oSiUu0dFlFvTTfDMUk5BkxDdgpUI1gDHvHUXH96EzUxGV6KBzx01Lb3Nt
         SjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322600; x=1688914600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNjEF1zb+JpJdY0weZ4OdAOu0yke/I9t8R3uYm6sLTw=;
        b=cJF+mWZnSntF1FYV0ZqHPbk7UMnKAiM20DD6IozoFq2r6hERD/iY+64uXlhNPS1ibH
         1pKt+mvBBl+qwtkFIqH/1XNire/dNhEPaht9n2plp/FLgKUKvT1m7xrL3gYaeKEn2Dtf
         orM0OvEzwFBvGpOS1YH/2w88NmXqbtwHZlI+VftQOWL/yGkqZUpHmPz1SQW5uCDuYiva
         XdwrYIWXEE6rIOynDUG5+S7AXAvQ97ZELlvNo/2n75CfofkZg5VBaMQO4HSoufzIu/cn
         QEE+3/tEOwAarg3Wx4WtT12NbtsQ7eUS7xXXnbKSPetc4proWDjbb4aNs21mMMMxg/6H
         j+pg==
X-Gm-Message-State: AC+VfDyDwzrBEDHOZFL5RgoAD3fwYwfmRS4IdO2g5HpgBkLX5k5dH5nf
        c7ZbAWAUgJ+lCeJxxujydd+MfQ==
X-Google-Smtp-Source: ACHHUZ5lyjIg3/k8ishXP5lVr7SzW3xDk6gDIW+APpNABj3FGwxCpQmA/zWxRkbdHKZaShP8U7SZcw==
X-Received: by 2002:a05:6870:fc84:b0:19f:7c4c:38b4 with SMTP id ly4-20020a056870fc8400b0019f7c4c38b4mr1554940oab.15.1686322600226;
        Fri, 09 Jun 2023 07:56:40 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c0:9e83:b7c7:f418:cfcf:f0dd? ([2804:7f1:e2c0:9e83:b7c7:f418:cfcf:f0dd])
        by smtp.gmail.com with ESMTPSA id a21-20020a056870d19500b001a3093ec23fsm2236633oac.32.2023.06.09.07.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 07:56:39 -0700 (PDT)
Message-ID: <facdfceb-fe2e-795b-ea89-1b67478eb533@mojatatu.com>
Date:   Fri, 9 Jun 2023 11:56:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RESEND net-next 5/5] net/sched: taprio: dump class stats
 for the actual q->qdiscs[]
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>
References: <20230602103750.2290132-1-vladimir.oltean@nxp.com>
 <20230602103750.2290132-6-vladimir.oltean@nxp.com>
 <CAM0EoM=P9+wNnNQ=ky96rwCx1z20fR21EWEdx+Na39NCqqG=3A@mail.gmail.com>
 <20230609121043.ekfvbgjiko7644t7@skbuf>
Content-Language: en-US
From:   Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20230609121043.ekfvbgjiko7644t7@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 09:10, Vladimir Oltean wrote:
> On Thu, Jun 08, 2023 at 02:44:46PM -0400, Jamal Hadi Salim wrote:
>> Other than the refcount issue i think the approach looks reasonable to
>> me. The stats before/after you are showing below though are
>> interesting; are you showing a transient phase where packets are
>> temporarily in the backlog. Typically the backlog is a transient phase
>> which lasts a very short period. Maybe it works differently for
>> taprio? I took a quick look at the code and do see to decrement the
>> backlog in the dequeue, so if it is not transient then some code path
>> is not being hit.
> 
> It's a fair concern. The thing is that I put very aggressive time slots
> in the schedule that I'm testing with, and my kernel has a lot of
> debugging stuff which bogs it down (kasan, kmemleak, lockdep, DMA API
> debug etc). Not to mention that the CPU isn't the fastest to begin with.
> 
> The way taprio works is that there's a hrtimer which fires at the
> expiration time of the current schedule entry and sets up the gates for
> the next one. Each schedule entry has a gate for each traffic class
> which determines what traffic classes are eligible for dequeue() and
> which ones aren't.
> 
> The dequeue() procedure, though also invoked by the advance_schedule()
> hrtimer -> __netif_schedule(), is also time-sensitive. By the time
> taprio_dequeue() runs, taprio_entry_allows_tx() function might return
> false when the system is so bogged down that it wasn't able to make
> enough progress to dequeue() an skb in time. When that happens, there is
> no mechanism, currently, to age out packets that stood too much in the
> TX queues (what does "too much" mean?).
> 
> Whereas enqueue() is technically not time-sensitive, i.e. you can
> enqueue whenever you want and the Qdisc will dequeue whenever it can.
> Though in practice, to make this scheduling technique useful, the user
> space enqueue should also be time-aware (though you can't capture this
> with ping).
> 
> If I increase all my sched-entry intervals by a factor of 100, the
> backlog issue goes away and the system can make forward progress.
> 
> So yeah, sorry, I didn't pay too much attention to the data I was
> presenting for illustrative purposes.
> 
>> Aside: I realize you are busy - but if you get time and provide some
>> sample tc command lines for testing we could help create the tests for
>> you, at least the first time. The advantage of putting these tests in
>> tools/testing/selftests/tc-testing/ is that there are test tools out
>> there that run these tests and so regressions are easier to catch
>> sooner.
> 
> Yeah, ok. The script posted in a reply on the cover letter is still what
> I'm working with. The things it intends to capture are:
> - attaching a custom Qdisc to one of taprio's classes doesn't fail
> - attaching taprio to one of taprio's classes fails
> - sending packets through one queue increases the counters (any counters)
>    of just that queue
> 
> All the above, replicated once for the software scheduling case and once
> for the offload case. Currently netdevsim doesn't attempt to emulate
> taprio offload.
> 
> Is there a way to skip tests? I may look into tdc, but I honestly don't
> have time for unrelated stuff such as figuring out why my kernel isn't
> configured for the other tests to pass - and it seems that once one test
> fails, the others are completely skipped, see below.

You can tell tdc to run a specific test file by providing the "-f" option.
For example, if you want to run only taprio tests, you can issue the
following command:

./tdc.py -f tc-tests/qdiscs/taprio.json

This is also described in tdc's README.

> Also, by which rule are the test IDs created?

When creating a test case in tdc, you must have an ID field.
What we do to generate the IDs is leave the "id" field as an
empty string on the test case description, for example:


{
     "id": "",
     "name": "My dummy test case",
     ...
}

and run the following:

./tdc.py -i

This will automatically fill up the "id" field in the JSON
with an appropriate ID.

> root@debian:~# cd selftests/tc-testing/
> root@debian:~/selftests/tc-testing# ./tdc.sh
> considering category qdisc
>   -- ns/SubPlugin.__init__
> Test 0582: Create QFQ with default setting
> Test c9a3: Create QFQ with class weight setting
> Test d364: Test QFQ with max class weight setting
> Test 8452: Create QFQ with class maxpkt setting
> Test 22df: Test QFQ class maxpkt setting lower bound
> Test 92ee: Test QFQ class maxpkt setting upper bound
> Test d920: Create QFQ with multiple class setting
> Test 0548: Delete QFQ with handle
> Test 5901: Show QFQ class
> Test 0385: Create DRR with default setting
> Test 2375: Delete DRR with handle
> Test 3092: Show DRR class
> Test 3460: Create CBQ with default setting
> exit: 2
> exit: 0
> Error: Specified qdisc kind is unknown.

As you stated, this likely means you are missing a config option.
However you can just ask tdc to run a specific test file to avoid this.

> (...)

cheers,
Victor
