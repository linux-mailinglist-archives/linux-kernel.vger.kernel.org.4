Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625716814C4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbjA3PVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbjA3PVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:21:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD03DBF1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675092010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YbPF+B9UdQDAcpxcdEjKJHBXASjEEtz4ilZ8HjXPzZo=;
        b=Jrb8NNm/jLO9caotFCqz9jtzN0jyIIN57uhiWp33hgy91+vVS/FuJGe+nHr7bnloB+alEc
        c/92NealKqmjdX6bR+8aUUwP0bV/ghgjeEW6TqdFKU2ZG16b1sq1SPjLqOcFBRFOHNrEw+
        q0eETeXtuwlrNjwG+EyA5WRkopmZSUw=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-jeooUYkWO56uaDt3PDa9gA-1; Mon, 30 Jan 2023 10:20:09 -0500
X-MC-Unique: jeooUYkWO56uaDt3PDa9gA-1
Received: by mail-vs1-f70.google.com with SMTP id bk38-20020a05610254a600b003f3633a1a04so738053vsb.20
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbPF+B9UdQDAcpxcdEjKJHBXASjEEtz4ilZ8HjXPzZo=;
        b=DQzBbPLnyeJAVDThJxyoositKRzALAelHIyiWd2X2zRVuDI6gRhcEwQbpyu9pJAHaa
         QS2KFZ9VmiMxeAWZOx3QqEFyfl7QfqmBssYm32q6MKh9F3avrXHBhCMp7Qj74LqQdPng
         Pd2/a3I+fo3PWRKRJYxvOPoWz+dXL73MjFnBIFkVppwwXQ4cVZEYa3QmqIbqr4CVdtHy
         Ew9tDyzyc+mBBJN84uU460IOshVXDV+R05vtHBZU8mmlI6Y2x+DBzKY0wEx0Hn/7Kjel
         F1ktkaiXL9MMFQODWf8GElc+SCAahF/MzcydwJsZeVkGJzikSPNYgvdSpxJKbO6sLvBW
         vXRA==
X-Gm-Message-State: AFqh2kqdSZoQmQd4qnm2kbOrazERRbicTFkYx0YrmRLXg8kcXeLsr36Y
        qvGwS4YuGWOjuOgl/lOcJdDDRoXuq7CKmKgjgApyD1/+f7cj3I6pqESMKhusBaFyOyUDQH8TaLP
        Emh+qnnqKp5NdK3rYUXrPcG+5
X-Received: by 2002:ac5:c3c4:0:b0:3bd:3a31:d74e with SMTP id t4-20020ac5c3c4000000b003bd3a31d74emr26374827vkk.1.1675092008844;
        Mon, 30 Jan 2023 07:20:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtA5CkaZ8xkSRqGrinvggECPXfGZXkGeswqo5+q/GT7CTiCjbx71rJlHNUftEzQkw/3OXQGGA==
X-Received: by 2002:ac5:c3c4:0:b0:3bd:3a31:d74e with SMTP id t4-20020ac5c3c4000000b003bd3a31d74emr26374808vkk.1.1675092008580;
        Mon, 30 Jan 2023 07:20:08 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id op52-20020a05620a537400b007186c9e167esm6632382qkn.52.2023.01.30.07.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:20:07 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/4] sched/task: Add the put_task_struct_atomic_safe
 function
In-Reply-To: <CAAq0SUkATfafSdoKK+u4MYwtJpYjp7jY_f5t+fvp69x-iP=CXg@mail.gmail.com>
References: <20230120150246.20797-1-wander@redhat.com>
 <20230120150246.20797-2-wander@redhat.com>
 <20230123163002.GB6268@redhat.com>
 <CAAq0SUk1vfNDuzGbXNftgW4wq4PC_EzMhpq4E=RBQNkOB3f4YQ@mail.gmail.com>
 <xhsmhbkmkdla4.mognet@vschneid.remote.csb>
 <CAAq0SUnUH6DEjwEs2RxRCtkTU121JXpdsV_rZky1d0Bo04=fiQ@mail.gmail.com>
 <xhsmh357sdqqp.mognet@vschneid.remote.csb>
 <CAAq0SUkATfafSdoKK+u4MYwtJpYjp7jY_f5t+fvp69x-iP=CXg@mail.gmail.com>
Date:   Mon, 30 Jan 2023 15:20:03 +0000
Message-ID: <xhsmhzga0can0.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/23 11:58, Wander Lairson Costa wrote:
> On Mon, Jan 30, 2023 at 11:47 AM Valentin Schneider <vschneid@redhat.com> wrote:
>>
>> On 30/01/23 08:49, Wander Lairson Costa wrote:
>> > On Fri, Jan 27, 2023 at 12:55 PM Valentin Schneider <vschneid@redhat.com> wrote:
>> >>
>> >> On 23/01/23 14:24, Wander Lairson Costa wrote:
>> >> > Therefore (if I am correct in my assumption), it would make sense for
>> >> > only some call sites to pay the overhead price for it. But this is
>> >> > just a guess, and I have no evidence to support my claim.
>> >>
>> >> My worry here is that it's easy to miss problematic callgraphs, and it's
>> >> potentially easy for new ones to creep in. Having a solution within
>> >> put_task_struct() itself would prevent that.
>> >>
>> >
>> > We could add a WARN_ON statement in put_task_struct() to detect such cases.
>> >
>>
>> Anyone running their kernel with DEBUG_ATOMIC_SLEEP should be able to
>> detect misuse, but it doesn't change that some callgraphs will only
>> materialize under certain hardware/configuration combos.
>>
>
> If we put a WARN_ON in put_task_struct(), we catch cases where the
> reference count didn't reach zero.
>

True, that'd be an improvement.

>> >> Another thing, if you look at release_task_stack(), it either caches the
>> >> outgoing stack for later use, or frees it via RCU (regardless of
>> >> PREEMPT_RT). Perhaps we could follow that and just always punt the freeing
>> >> of the task struct to RCU?
>> >>
>> >
>> > That's a point. Do you mean doing that even for !PREEMPT_RT?
>>
>> Could be worth a try?
>
> Sure. But I would do it only for PREEMPT_RT.
>
>> I think because of the cache thing the task stack is
>> a bit less aggressive wrt RCU callback processing, but at a quick glance I
>> don't see any fundamental reason why the task_struct itself can't be given
>> the same treatment.
>>
>
> Any idea about tests to catch performance regressions?
>

I would wager anything fork-heavy with short-lived tasks, say loops of
short hackbench runs, I belive stress-ng also has a fork test case.

