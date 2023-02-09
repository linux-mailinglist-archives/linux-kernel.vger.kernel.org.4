Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D16690988
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBINIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBINIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:08:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7982955BE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675948047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8EEBbTl5DSdai1GXja8PYnBc+VIARZRgWJaoZVrjVYg=;
        b=G/mG+NqepCuMkNNNzoot1GEqGWBBONotZ/gv9shoLMuspdttjYwrAitpd3K+hoj5VdP9DZ
        AF5KZ/n9vyAsD4G7mq06gBSw3Lz3hXylP+FnGhE8QZ0EEMOsvRnMwLG+Fo1fCfX/NQn8NK
        K1d0FoHik1m8X/Hhh8xMg8Zwj2RUHjk=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-395-jCkIbH3APtiQnnqJTl9jcA-1; Thu, 09 Feb 2023 08:07:26 -0500
X-MC-Unique: jCkIbH3APtiQnnqJTl9jcA-1
Received: by mail-oo1-f69.google.com with SMTP id i10-20020a4a900a000000b004f1f4aa7f3bso803197oog.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EEBbTl5DSdai1GXja8PYnBc+VIARZRgWJaoZVrjVYg=;
        b=uUn6IyRr6quHyJQwDpfeA+1HNa3PUe61UdEVQwvUQL8siwxhTGbNw4hhf6nq29ggGF
         sT1tSqJ0EtI2BYnNehvwA7L+7C3KbS3rAr3TrRx2203IUrCcUKJ8BYBvRB1M4S800xgZ
         bIyi0wH8CXlRzuELuRG/j6rFWUVv4+mGoWkK/SLNx2QgzJnEebb5Eu+iefKRziu9CMuN
         ScRebyIwSrV/NT8mBsu8Iig8uHLFyJkBkVj8ny3SNvwpoVkyYigA8cHjWnPorsXS+sz5
         CMo0iO+V5UT1Thqchd7YaqW5uvasT5qIPPZefqPVMIrxqjwhqSSHdreJ0qDm66vnKn4d
         5kdw==
X-Gm-Message-State: AO0yUKUbLdaxtMXsuyq+ujswU769EnCp5c4rzprR7EqtGI7xNS5dOwy6
        KayMU9dcEZyiZ95PMfM1Wbp5MqjAWRpbKlO1URV7PLP+S8fekjnPLIA1fnnWiUjuVpv2yJOOivg
        X26k/N89xuoJ/pmpyJDQYvG4M
X-Received: by 2002:a9d:5c17:0:b0:670:9f81:245a with SMTP id o23-20020a9d5c17000000b006709f81245amr5262681otk.12.1675948045983;
        Thu, 09 Feb 2023 05:07:25 -0800 (PST)
X-Google-Smtp-Source: AK7set9lkIwXDuE8s1rW4NIOS4zP+VFoarVOvWuRT4hVkE1a4cTpgGE0zcO8K8j7iirfWGvFawTUaw==
X-Received: by 2002:a9d:5c17:0:b0:670:9f81:245a with SMTP id o23-20020a9d5c17000000b006709f81245amr5262670otk.12.1675948045753;
        Thu, 09 Feb 2023 05:07:25 -0800 (PST)
Received: from [192.168.0.198] ([177.137.113.72])
        by smtp.gmail.com with ESMTPSA id k13-20020a0568301bed00b0068bdd78f763sm633876otb.29.2023.02.09.05.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 05:07:25 -0800 (PST)
Message-ID: <82dc25d8-1df3-87c7-0397-3fedd6f262fc@redhat.com>
Date:   Thu, 9 Feb 2023 14:07:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH v2] sched/deadline: Add more reschedule cases to
 prio_changed_dl()
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Eder Zulian <ezulian@redhat.com>
References: <20230206140612.701871-1-vschneid@redhat.com>
 <Y+I86kr73LlKVmW/@localhost.localdomain>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <Y+I86kr73LlKVmW/@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/23 12:58, Juri Lelli wrote:
> Hi,
> 
> On 06/02/23 14:06, Valentin Schneider wrote:
>> I've been tracking down an issue on a ~5.17ish kernel where:
>>
>>   CPUx                           CPUy
>>
>>   <DL task p0 owns an rtmutex M>
>>   <p0 depletes its runtime, gets throttled>
>>   <rq switches to the idle task>
>> 				 <DL task p1 blocks on M, boost/replenish p0>
>> 				 <No call to resched_curr() happens here>
>>
>>   [idle task keeps running here until *something*
>>    accidentally sets TIF_NEED_RESCHED]
>>
>> On that kernel, it is quite easy to trigger using rt-tests's deadline_test
>> [1] with the test running on isolated CPUs (this reduces the chance of
>> something unrelated setting TIF_NEED_RESCHED on the idle tasks, making the
>> issue even more obvious as the hung task detector chimes in).
>>
>> I haven't been able to reproduce this using a mainline kernel, even if I
>> revert
>>
>>   2972e3050e35 ("tracing: Make trace_marker{,_raw} stream-like")
>>
>> which gets rid of the lock involved in the above test, *but* I cannot
>> convince myself the issue isn't there from looking at the code.
>>
>> Make prio_changed_dl() issue a reschedule if the current task isn't a
>> deadline one. While at it, ensure a reschedule is emitted when a
>> queued-but-not-current task gets boosted with an earlier deadline that
>> current's.
>>
>> [1]: https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
> This looks now good to me, thanks!
> 
> Acked-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

-- Daniel

