Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7C87162D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjE3N7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjE3N7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:59:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECFFD9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685455098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GyS/XEJVr+X0SCCnfa5wepVjXQBcDWeiJTyar/+z4gE=;
        b=UH6ikL151zkxA2zVkRloBgAxb/hOmjqhCTgL2pPtl8NTVpMhqLsEmsU2FZOQF3W+M0JbFu
        oUXfBQAsaP3PCm0v5x+jGvjyf25iEYMhvhVAHpxsjZdZ6TlPYgCcaldooZHMeuswZYbjZt
        Qa593p7DQmtJ/RCqS0W3sLzd1TwK/m0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-2c5IXGMGNBq40UvY6O0XmQ-1; Tue, 30 May 2023 09:58:16 -0400
X-MC-Unique: 2c5IXGMGNBq40UvY6O0XmQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f603b8eb61so26663975e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685455095; x=1688047095;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GyS/XEJVr+X0SCCnfa5wepVjXQBcDWeiJTyar/+z4gE=;
        b=J7NMdfRhQ7XE9DcO8h+QQTDCPUtbABkGZtZK89cSUl0bQfBJHS5BuT8VNYx2dU62n4
         XrPiYl2S0kSCW/rIUamBoocbVRKdIGJeBP1T6GfM0eQxWC9a7UjvE8WyX2BTyrF4GRTB
         yRCOIr+vVrfv047UQssdMnY450evV/w3/u7Vtnf7bDlXuuT602DL8Se5aSkzdbSlV3li
         zb//veu0rM4gsuWYrwPuqcNxDpXGswxy9sppkOyq0Py42dYoppuGa/DsUfDtttwqIUjw
         4kpd1fEehba/uW/lIm0J6ujK9EOYZPxFzB7TY6GeYTtJmRCQnWy3IlY7y4MgwW9WVHNt
         Rs/g==
X-Gm-Message-State: AC+VfDzj0mAcYOSDake6qAI4YKVc7v9zVR/qh0D5S8Yk8fkAfqzONBkl
        GB8C4cGA2jV9+P6wqNbk5bjHwGHaj1D2HQupf8ldCNin190tHmrAdDUzep9w6FyJRvaeXo72mXv
        xXnPEYmdpHKFTw418JHdH/na7
X-Received: by 2002:a05:600c:2242:b0:3f6:a44:73bb with SMTP id a2-20020a05600c224200b003f60a4473bbmr2278316wmm.8.1685455095766;
        Tue, 30 May 2023 06:58:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5StBwPC6tNR2MseH7QMbfqVmLsT1D8KTQf8mlITfI6xHq2esGeCKT0VsWAof/TVfeHnC9m6Q==
X-Received: by 2002:a05:600c:2242:b0:3f6:a44:73bb with SMTP id a2-20020a05600c224200b003f60a4473bbmr2278278wmm.8.1685455095496;
        Tue, 30 May 2023 06:58:15 -0700 (PDT)
Received: from vschneid.remote.csb ([208.178.8.98])
        by smtp.gmail.com with ESMTPSA id s5-20020adff805000000b00307d58b3da9sm3440837wrp.25.2023.05.30.06.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 06:58:14 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
In-Reply-To: <20230530092342.GA149947@hirez.programming.kicks-ass.net>
References: <20230526205204.861311518@infradead.org>
 <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net>
Date:   Tue, 30 May 2023 14:58:12 +0100
Message-ID: <xhsmhy1l5or9n.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/23 11:23, Peter Zijlstra wrote:
> On Sat, May 27, 2023 at 12:18:04PM -0700, Linus Torvalds wrote:
>
>
>> And it turns out that the above two trivial macros are actually quite
>> useful in themselves. You want to do an auto-cleanup version of
>> 'struct fd'? It's trivial:
>>
>>     /* Trivial "getfd()" wrapper */
>>     static inline void release_fd(struct fd *fd)
>>     { fdput(*fd); }
>>
>>     #define auto_getfd(name, n) \
>>         auto_release_name(struct fd, name, fdget(n), release_fd)
>>
>
>>  - I think the above is simpler and objectively better in every way
>> from the explicitly scoped thing
>
> Well, I think having that as a option would still be very nice.
>

IMO the explicit scoping can help with readability. It gives a clear visual
indication of where critical sections are, and you can break it up with a
scope + guards as in migrate_swap_stop() to stay at sane indentation
levels (with Python context managers, this would all be one scope).

I'd argue that for these, the scope/indentation is beneficial and not just
a byproduct. Even for longer functions like try_to_wake_up(), this works
out alright.

This obviously falls apart when dealing with too many guards
(e.g. copy_process()) or if the resulting indentation is nuts, but I concur
that keeping the explicit scope as an option would be nice.

