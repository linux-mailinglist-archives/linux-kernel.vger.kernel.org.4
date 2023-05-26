Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBFE712CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243250AbjEZSub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjEZSu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:50:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D736A13D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685126979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l9gW2VXa2A5baAgf65KnUVTdVX+nM4KBjAb0pb4V13g=;
        b=PZ6ay2ncrJ71tWI+Cj5VLMxaSb2PGJJuGsCafrPDbAXO7zscagrZz3Se9RHVvweQEukI5s
        PFRx3drjun39obDmf+6SZD5qu2VFjHmu3o7kpEsVkVUn3gJOaJARYVCpziQ6VfUkLBwya2
        dYZqQq70EmbcEJ1bK5G3lTfggl+5CwI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-Cu3RT8TzMue2tp8jbuO0pg-1; Fri, 26 May 2023 14:49:37 -0400
X-MC-Unique: Cu3RT8TzMue2tp8jbuO0pg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23081101A52C;
        Fri, 26 May 2023 18:49:36 +0000 (UTC)
Received: from [10.22.32.123] (unknown [10.22.32.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87B37492B00;
        Fri, 26 May 2023 18:49:34 +0000 (UTC)
Message-ID: <cf20bbbc-c435-326d-f31a-86b1f4ce927a@redhat.com>
Date:   Fri, 26 May 2023 14:49:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC][PATCH 1/2] locking: Introduce __cleanup__ based guards
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang1.zhang@intel.com, rcu@vger.kernel.org, tj@kernel.org,
        tglx@linutronix.de
References: <20230526150549.250372621@infradead.org>
 <20230526151946.960406324@infradead.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230526151946.960406324@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 11:05, Peter Zijlstra wrote:
> Use __attribute__((__cleanup__(func))) to buid various guards:
>
>   - ptr_guard()
>   - void_guard() / void_scope()
>   - lock_guard() / lock_scope()
>   - double_lock_guard() / double_lock_scope()
>
> Where the _guard thingies are variables with scope-based cleanup and
> the _scope thingies are basically do-once for-loops with the same.
>
> The CPP is rather impenetrable -- but I'll attempt to write proper
> comments if/when people think this is worth pursuing.
>
> Actual usage in the next patch
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   include/linux/compiler_attributes.h |    2
>   include/linux/irqflags.h            |    7 ++
>   include/linux/guards.h          |  118 ++++++++++++++++++++++++++++++++++++
>   include/linux/mutex.h               |    5 +
>   include/linux/preempt.h             |    4 +
>   include/linux/rcupdate.h            |    3
>   include/linux/sched/task.h          |    2
>   include/linux/spinlock.h            |   23 +++++++
>   8 files changed, 164 insertions(+)

That is an interesting idea and may help to simplify some of the common 
code patterns that we have in the kernel. The macros are a bit hard to 
read and understand though I thought I got a rough idea of what they are 
trying to do.

BTW, do we have a use case for double_lock_guard/double_lock_scope? I 
can envision a nested lock_scope inside a lock_scope, but taking 2 auto 
locks of the same type at init time and then unlock them at exit just 
doesn't make sense to me.

Cheers,
Longman

