Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DF569B1DE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjBQRgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjBQRgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:36:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364CA6EB84
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676655336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5Ekvi/cgShIBq5Ias9rr0vAffoOycedxIerQd+Vy8o=;
        b=cd8UIjXZ7DrY/daRrlKKAv3va+tQaPFRHuwriQN9IS/0iP+Uc675I5JTgNomOtBs5XGKSq
        rukiVEH7ofTEOovqY/EPqOHixTJBQ0BPJUrhyFy4xhQvH6+Btrg7RJxC2p0dt7AKWs8rjh
        5uPtU9Nol2EHeZ8OISl7c47mvKSvtJo=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-159-ac-6GL3vP2uAjjg3pqVHzg-1; Fri, 17 Feb 2023 12:35:35 -0500
X-MC-Unique: ac-6GL3vP2uAjjg3pqVHzg-1
Received: by mail-ot1-f71.google.com with SMTP id a24-20020a9d74d8000000b0068d48d4e873so687992otl.22
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5Ekvi/cgShIBq5Ias9rr0vAffoOycedxIerQd+Vy8o=;
        b=aIxqVanezkivDdcb57P/Z1HD9bhO0q9dnVhZ81rM4IW0MV0obH6NHaYhQ+xjq74MFo
         ORoaYU3k3Nk4lMcYs/SVzIsTes/oTQheRgriJSvLVAGmP0/4+LpCfDRb31kXYrLFS3K+
         fNU2x4yNRlpM4vOJ5+5E/Tj9aAxi0exWTPkHsugYls0yo29am4qBuWLzJpOKiuO1IkId
         bhgpr/P9f7LW48rY6bysjlV61Qd6HduZah7prptgGNEyIFA/1BeOyn0rzKVGx46/XoqO
         UASpXo9ND63NrqjChF99JAtbtJJrp8hp/H0hjZ06cpD4Cgoh3g9yVOo4aZmmGdqr37pT
         gmUw==
X-Gm-Message-State: AO0yUKWSK29htDI2gcReXx0UHtK6I3oJt/F+QpytF+oUw9LjqAhZnkZ7
        ELIlggJ4CkDgGE6Grg051upTAwk/z0+SpU0QJ673SwC4A/53GFCgGJJh5LQPA3A/p/9eSPjfooM
        qe+qJtw3xLlrcuyXLx0scUMxt
X-Received: by 2002:a05:6870:9a23:b0:16e:9266:8f5c with SMTP id fo35-20020a0568709a2300b0016e92668f5cmr1986638oab.22.1676655334390;
        Fri, 17 Feb 2023 09:35:34 -0800 (PST)
X-Google-Smtp-Source: AK7set9IbJ4Bmz/IVrHg3clMrzNSJ/87htI6K7X1K4qBgrYIPbDivrWsxpyaDMQElKtdHGx1Ge3KFg==
X-Received: by 2002:a05:6870:9a23:b0:16e:9266:8f5c with SMTP id fo35-20020a0568709a2300b0016e92668f5cmr1986625oab.22.1676655334143;
        Fri, 17 Feb 2023 09:35:34 -0800 (PST)
Received: from [192.168.0.198] ([177.137.113.95])
        by smtp.gmail.com with ESMTPSA id v11-20020a05683011cb00b006863c59f685sm2085968otq.28.2023.02.17.09.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 09:35:32 -0800 (PST)
Message-ID: <8632d9c6-7ec7-c3aa-f9e7-fa63cc82f6ae@redhat.com>
Date:   Fri, 17 Feb 2023 14:35:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/4] sched/task: Add the put_task_struct_atomic_safe
 function
Content-Language: en-US
To:     Wander Lairson Costa <wander@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
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
References: <20230120150246.20797-1-wander@redhat.com>
 <20230120150246.20797-2-wander@redhat.com> <20230123163002.GB6268@redhat.com>
 <CAAq0SUk1vfNDuzGbXNftgW4wq4PC_EzMhpq4E=RBQNkOB3f4YQ@mail.gmail.com>
 <xhsmhbkmkdla4.mognet@vschneid.remote.csb>
 <CAAq0SUnUH6DEjwEs2RxRCtkTU121JXpdsV_rZky1d0Bo04=fiQ@mail.gmail.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <CAAq0SUnUH6DEjwEs2RxRCtkTU121JXpdsV_rZky1d0Bo04=fiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/23 08:49, Wander Lairson Costa wrote:
>> Another thing, if you look at release_task_stack(), it either caches the
>> outgoing stack for later use, or frees it via RCU (regardless of
>> PREEMPT_RT). Perhaps we could follow that and just always punt the freeing
>> of the task struct to RCU?
>>
> That's a point. Do you mean doing that even for !PREEMPT_RT?
> 

It seems that Luca Abeni (in Cc) is hitting the bug in the non-rt kernel
with SCHED_DEADLINE...

adding him to the thread.

-- Daniel 

