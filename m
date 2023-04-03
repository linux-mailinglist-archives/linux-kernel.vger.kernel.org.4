Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E54A6D45EB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjDCNgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDCNgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:36:09 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3BB26A9;
        Mon,  3 Apr 2023 06:36:08 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id l7-20020a4abe07000000b0053e1205c84bso4244489oop.9;
        Mon, 03 Apr 2023 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680528967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYKF1IOFdYdmMau8S74pH0eQKa7KDditNTWLVFfh1xU=;
        b=L72sR8rVpm5kXFW93EZ4PrhCcMDwXowaf6adss76iNOTOukW7EfOLq4xSpMeYXP7Ny
         vCa5fHNDvOrIhRZ7g79HG87tQ3Sidqv+M/+MluNJiCBYfg2iR+9mG4BlNaf4TGfL8hPp
         o3UvcnAJBKMy/BLwv4eOXf+u3l5QLBM5N8X/RHfyNyS8ff0JleFiXZ3Knlo4VFNtlQzX
         vz+WsOya4LJPxTe0EJjd5yCC22KnMdu26Hq2IQjtm6RNVU/F42tqPz23V/URefgOD9I7
         wlCU14A+zAJoFVspF84+VfTEf2GqcrvxOvnDtBWJFG11I8GfAugHqYyrxsue4nl67vyg
         XdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680528967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYKF1IOFdYdmMau8S74pH0eQKa7KDditNTWLVFfh1xU=;
        b=xR5fdUuwODDHpC5hzHbs7EIb1sobcbEB1ICwDYFoo9BBsNS4ETk34D2fl3+8qtPHNB
         fT9r57fYzUpigzHtjiHvgZpb6//8P9I9F4o8J8sP/htt9knOZhoy37kz304ipzwqGjqd
         QxKmWwsBlGNS4JYyEEmhiJOqGidDSpwAB3yV7tY4irUx17fhZDb6NS7lfYH5j04zCmwW
         VLY+fI/oIITF/6dYLgGPTnk1yuDYoh23XLKDvLEZNJIy+HIO0LHnqEGQmjBAYWFcNOMH
         XwDTnodOADN0wK8nFkI1IF+SFd+UlgYBwGy8kt7pRBywx8/k7HK2Fm8TQUfZDxpg/cXb
         hqLQ==
X-Gm-Message-State: AO0yUKWR8YVv2dFLWxS/yL3HW4itDrhwsRqe5zHOMCcV3+ONyTlUWcz6
        8/EYwYhxmB4y2y+dC+YlvZ0=
X-Google-Smtp-Source: AK7set99HvhvZ4qBDldx7BlcBiuxil1nBzB/DEtMzvSzNxKAuNow0gRY/3kakarANXXCi2A/QgmktA==
X-Received: by 2002:a4a:4fce:0:b0:53b:6bc2:6429 with SMTP id c197-20020a4a4fce000000b0053b6bc26429mr16827535oob.0.1680528967434;
        Mon, 03 Apr 2023 06:36:07 -0700 (PDT)
Received: from wedsonaf-dev ([189.124.190.154])
        by smtp.gmail.com with ESMTPSA id n15-20020a4ad62f000000b0053a7aaa85a0sm4005858oon.0.2023.04.03.06.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:36:07 -0700 (PDT)
Date:   Mon, 3 Apr 2023 10:35:58 -0300
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 12/13] rust: sync: introduce `CondVar`
Message-ID: <ZCrWPiqfAxsBNL+W@wedsonaf-dev>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
 <20230330043954.562237-12-wedsonaf@gmail.com>
 <20230330125927.GD124812@hirez.programming.kicks-ass.net>
 <ZCWjIaByRHDhdCud@wedsonaf-dev>
 <20230403085959.GS4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403085959.GS4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 10:59:59AM +0200, Peter Zijlstra wrote:
> On Thu, Mar 30, 2023 at 11:56:33AM -0300, Wedson Almeida Filho wrote:
> > On Thu, Mar 30, 2023 at 02:59:27PM +0200, Peter Zijlstra wrote:
> > > On Thu, Mar 30, 2023 at 01:39:53AM -0300, Wedson Almeida Filho wrote:
> > > 
> > > > +    fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guard<'_, T, B>) {
> > > > +        let wait = Opaque::<bindings::wait_queue_entry>::uninit();
> > > > +
> > > > +        // SAFETY: `wait` points to valid memory.
> > > > +        unsafe { bindings::init_wait(wait.get()) };
> > > > +
> > > > +        // SAFETY: Both `wait` and `wait_list` point to valid memory.
> > > > +        unsafe {
> > > > +            bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
> > > > +        };
> > > 
> > > I can't read this rust gunk, but where is the condition test gone?
> > > 
> > > Also, where is the loop gone to?
> > 
> > They're both at the caller. The usage of condition variables is something like:
> > 
> > while guard.value != v {
> >     condvar.wait_uninterruptible(&mut guard);
> > }
> > 
> > (Note that this is not specific to the kernel or to Rust: this is how condvars
> > work in general. You'll find this in any textbook on the topic.)
> > 
> > In the implementation of wait_internal(), we add the local wait entry to the
> > wait queue _before_ releasing the lock (i.e., before the test result can
> > change), so we guarantee that we don't miss wake up attempts.
> 
> Ah, so you've not yet been exposed to the wonderful 'feature' where
> pthread_cond_timedwait() gets called with .mutex=NULL and people expect
> things to just work :/ (luckily not accepted by the majority of
> implementations)

Rust doesn't have this problem: a `Guard` cannot exist without a lock, and one
cannot call `wait` or `wait_uninterruptible` without a `Guard`.

> Or a little more devious, calling signal and not holding the same mutex.

We don't require that callers hold the lock while singaling. If they signal when
the condition isn't satisfied (with or without the lock held, it doesn't
matter), it will just look like a spurious signal to the waiting thread.

> I just got alarm bells going off because I see prepare_to_wait without an
> obvious loop around it.

Fair enough, we do need a loop.
