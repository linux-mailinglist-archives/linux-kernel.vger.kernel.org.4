Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0AD6813F8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjA3O7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237938AbjA3O7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:59:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D1D18B05
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675090746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u2OgoRB81leYsEKgu80yYA2Ig7jubyK4YZJYH/lM6s4=;
        b=W/oywkq4Hqpy4+he6EUTTek7Pj2NHvBN/Plpjr2FSp/lK04aq92S9MQVqFCsaIJI28tZDB
        RyDIDZzwO1FeFZuWgkJkqS4uIYifcJjVNKfkuv81cz9j5xCgUG13vAsBqIJoBr+48JdSva
        0wsuXiIz8yxkr0hnycBGr8mlPVjbyyE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-113-S0_yXG9jNqquyIShbKZJWw-1; Mon, 30 Jan 2023 09:59:04 -0500
X-MC-Unique: S0_yXG9jNqquyIShbKZJWw-1
Received: by mail-pj1-f70.google.com with SMTP id c8-20020a17090a674800b0022cb9c81fb0so875559pjm.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2OgoRB81leYsEKgu80yYA2Ig7jubyK4YZJYH/lM6s4=;
        b=y/hhVIpcoI+cNWqs41SvvSqJVRp961tLq5X58VdFrAWxF+cyQ9HEZT4i6AGLFCAyeX
         DE1eMLRmAHjBRrio82uazxzMFwTL4A4OUQJlosxeNoE1mMvOUuiQa2T2LmciuFl6xW2p
         hMMfvuPT38UfTOlL74qxYCkf1dH6DeespmdUkcn5dJh9zQY/1vQXQryjmt6D7RwCyewX
         1VVRiZuUsZpbn3hTzao2XDNhql1ZiKXblpVZa9dBRYo4a806bJo4nURvAf+wHrNzLNRe
         mKXbHyLyVH6PPF6eNmiuIVLm9lzOaXBAeOXvbs4Ip9ifcKK+eoKD1cNnibJsZrVfYUTF
         rfwA==
X-Gm-Message-State: AO0yUKXfoCXhF2pt3xZZqMoFY2WhGO83p10XZI8bK+fNiV7yarRTb3R4
        zzZt8gtCqgGnQ6V4hiDWlKJoOmsUs+Z6zkv1FHUj/gcXbty20+y2glkU9k4vA+DkKOkroiPAaGC
        swBZ2UpOmvUmUe6AoOgKAYUXSlZ9kFUfZPuUdsgAm
X-Received: by 2002:a17:902:f7c7:b0:196:126d:b23f with SMTP id h7-20020a170902f7c700b00196126db23fmr3362236plw.11.1675090743676;
        Mon, 30 Jan 2023 06:59:03 -0800 (PST)
X-Google-Smtp-Source: AK7set+sAGYVTEn5YLkyZDWc8r8vhel37GIIMkfuEU3MedMChPbXydtDbOCz07xULhn6Iu/3Mji/y5KDg0zL47dQhKM=
X-Received: by 2002:a17:902:f7c7:b0:196:126d:b23f with SMTP id
 h7-20020a170902f7c700b00196126db23fmr3362227plw.11.1675090743406; Mon, 30 Jan
 2023 06:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20230120150246.20797-1-wander@redhat.com> <20230120150246.20797-2-wander@redhat.com>
 <20230123163002.GB6268@redhat.com> <CAAq0SUk1vfNDuzGbXNftgW4wq4PC_EzMhpq4E=RBQNkOB3f4YQ@mail.gmail.com>
 <xhsmhbkmkdla4.mognet@vschneid.remote.csb> <CAAq0SUnUH6DEjwEs2RxRCtkTU121JXpdsV_rZky1d0Bo04=fiQ@mail.gmail.com>
 <xhsmh357sdqqp.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmh357sdqqp.mognet@vschneid.remote.csb>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 30 Jan 2023 11:58:52 -0300
Message-ID: <CAAq0SUkATfafSdoKK+u4MYwtJpYjp7jY_f5t+fvp69x-iP=CXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] sched/task: Add the put_task_struct_atomic_safe function
To:     Valentin Schneider <vschneid@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:47 AM Valentin Schneider <vschneid@redhat.com> wrote:
>
> On 30/01/23 08:49, Wander Lairson Costa wrote:
> > On Fri, Jan 27, 2023 at 12:55 PM Valentin Schneider <vschneid@redhat.com> wrote:
> >>
> >> On 23/01/23 14:24, Wander Lairson Costa wrote:
> >> > Therefore (if I am correct in my assumption), it would make sense for
> >> > only some call sites to pay the overhead price for it. But this is
> >> > just a guess, and I have no evidence to support my claim.
> >>
> >> My worry here is that it's easy to miss problematic callgraphs, and it's
> >> potentially easy for new ones to creep in. Having a solution within
> >> put_task_struct() itself would prevent that.
> >>
> >
> > We could add a WARN_ON statement in put_task_struct() to detect such cases.
> >
>
> Anyone running their kernel with DEBUG_ATOMIC_SLEEP should be able to
> detect misuse, but it doesn't change that some callgraphs will only
> materialize under certain hardware/configuration combos.
>

If we put a WARN_ON in put_task_struct(), we catch cases where the
reference count didn't reach zero.

> >> Another thing, if you look at release_task_stack(), it either caches the
> >> outgoing stack for later use, or frees it via RCU (regardless of
> >> PREEMPT_RT). Perhaps we could follow that and just always punt the freeing
> >> of the task struct to RCU?
> >>
> >
> > That's a point. Do you mean doing that even for !PREEMPT_RT?
>
> Could be worth a try?

Sure. But I would do it only for PREEMPT_RT.

> I think because of the cache thing the task stack is
> a bit less aggressive wrt RCU callback processing, but at a quick glance I
> don't see any fundamental reason why the task_struct itself can't be given
> the same treatment.
>

Any idea about tests to catch performance regressions?

I

