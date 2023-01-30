Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F62D6813BA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbjA3Oru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjA3Ors (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:47:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5146583
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675090021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mbdGAd5Gc+CeSR09L2sHX0L7qLtN8UTW5GUeq3iWb2o=;
        b=F28sKGqsuNIb+C9F7TDk6XGELZg3KmFVIVEyZR3fsiQ5Z8wOzUbZDAayOpxmzQEse97gJF
        rCk0Od4u9Vm34tZyxTNrivxc2omGEkbpXF5O8HcEefjXrdT4BgA08cHiiNFcX2pDz7AM4f
        witNisun6tN/EdH9FyDYwYxQUarJ3WY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-608-bBKUAFOFNYKZlj8G1IGydg-1; Mon, 30 Jan 2023 09:46:59 -0500
X-MC-Unique: bBKUAFOFNYKZlj8G1IGydg-1
Received: by mail-qv1-f69.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso6564395qvr.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbdGAd5Gc+CeSR09L2sHX0L7qLtN8UTW5GUeq3iWb2o=;
        b=ZnfHyRlUYksfNdkxjThjTKTJI8YbLtGkmaCZ0LlMIlFe4bGHMotrEfYWCtpQLAlnF8
         30lhs9KnKu844q0ghzFIjcx7vxP3ZjHM2TTBqW0cDGtN/vdq/QEaJrUChHZj+j2Ym5jo
         9zj7jBLgUhXJKZ92jAy9twGPs48LwEfniQDt7zLo7o6nF1xBuGZGX3bebVAof25qiL00
         2V+DuTLoC6C8nnxL2sAYfADqBYHTMTs1x4jzZmMj2FOFt7yYOxwuZ1ujpYa4Ot538vFN
         k0nLwyjCJtzXE4dReQCzoZFpcdg/GRzw/qPMQLXb+UuRdiSI9KXqAl46MFLGmAIiJK9U
         7Chw==
X-Gm-Message-State: AO0yUKVDrK+kK+3+vcauKSHWb2TfCNDnoQJvzx+eIu46zEYBaZSJiSBB
        nSaQxFRgfNxoc3DWS/3mo1O+yK0ezMRkf4pGkZwwhH6TbqOss5r+dMYS7xJsrI8cGI+XKVsvGqb
        ddbyZGyl9NsXWp0XIcj+XBRGQ
X-Received: by 2002:ac8:580c:0:b0:3b8:683c:40f with SMTP id g12-20020ac8580c000000b003b8683c040fmr8271995qtg.30.1675090019354;
        Mon, 30 Jan 2023 06:46:59 -0800 (PST)
X-Google-Smtp-Source: AK7set/JA1nw/SruzHK0Oqe75jBaibxmHMmBwxTRKffVdT24iWr4NBK+0Bz5m/p5UKLMUcYU+hO3lQ==
X-Received: by 2002:ac8:580c:0:b0:3b8:683c:40f with SMTP id g12-20020ac8580c000000b003b8683c040fmr8271956qtg.30.1675090019110;
        Mon, 30 Jan 2023 06:46:59 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id b25-20020ac844d9000000b003b82cb8748dsm5701627qto.96.2023.01.30.06.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 06:46:58 -0800 (PST)
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
In-Reply-To: <CAAq0SUnUH6DEjwEs2RxRCtkTU121JXpdsV_rZky1d0Bo04=fiQ@mail.gmail.com>
References: <20230120150246.20797-1-wander@redhat.com>
 <20230120150246.20797-2-wander@redhat.com>
 <20230123163002.GB6268@redhat.com>
 <CAAq0SUk1vfNDuzGbXNftgW4wq4PC_EzMhpq4E=RBQNkOB3f4YQ@mail.gmail.com>
 <xhsmhbkmkdla4.mognet@vschneid.remote.csb>
 <CAAq0SUnUH6DEjwEs2RxRCtkTU121JXpdsV_rZky1d0Bo04=fiQ@mail.gmail.com>
Date:   Mon, 30 Jan 2023 14:46:54 +0000
Message-ID: <xhsmh357sdqqp.mognet@vschneid.remote.csb>
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

On 30/01/23 08:49, Wander Lairson Costa wrote:
> On Fri, Jan 27, 2023 at 12:55 PM Valentin Schneider <vschneid@redhat.com> wrote:
>>
>> On 23/01/23 14:24, Wander Lairson Costa wrote:
>> > Therefore (if I am correct in my assumption), it would make sense for
>> > only some call sites to pay the overhead price for it. But this is
>> > just a guess, and I have no evidence to support my claim.
>>
>> My worry here is that it's easy to miss problematic callgraphs, and it's
>> potentially easy for new ones to creep in. Having a solution within
>> put_task_struct() itself would prevent that.
>>
>
> We could add a WARN_ON statement in put_task_struct() to detect such cases.
>

Anyone running their kernel with DEBUG_ATOMIC_SLEEP should be able to
detect misuse, but it doesn't change that some callgraphs will only
materialize under certain hardware/configuration combos.

>> Another thing, if you look at release_task_stack(), it either caches the
>> outgoing stack for later use, or frees it via RCU (regardless of
>> PREEMPT_RT). Perhaps we could follow that and just always punt the freeing
>> of the task struct to RCU?
>>
>
> That's a point. Do you mean doing that even for !PREEMPT_RT?

Could be worth a try? I think because of the cache thing the task stack is
a bit less aggressive wrt RCU callback processing, but at a quick glance I
don't see any fundamental reason why the task_struct itself can't be given
the same treatment.

