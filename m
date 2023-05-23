Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A73070DECF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbjEWOLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbjEWOLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:11:20 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94C01BC8
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:10:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96fb45a5258so608457466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1684851016; x=1687443016;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=odrvmB6aW4j6WyrX5D9zci+31pxZ6H0l+pIfR4FXqCA=;
        b=fX0B1I3mDg+racPxVnxeOqxxRwy6lp6PV/FCCoavnXihWp9UDWN7EoPie56ykAnZtt
         VmEAzbp8dcpTCXc7NGSAKbD+eGoPP9hwt2lYcR9UNQthJUpWVbRobigDsUVEdNTnNAPt
         bG7a9e+ZxNzUocpgq3GBtQQLjrCqwOdVTzUF/2tkCWfIh5fR5kSVySey7fpu0zep4x6Q
         6AuLbKaiaJrkovHKqFCg2L5jY9zxfQWDGsDsS1tTNEdi2B245dKaQmGmnENc1aeYpQi4
         o2uZVgqr5kO91R3hceNVJd/Vb5bj+94Gy8lK5Vp0J+p+JjtHM2VHgAN5ED3rnZT2Gj0F
         shWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684851016; x=1687443016;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odrvmB6aW4j6WyrX5D9zci+31pxZ6H0l+pIfR4FXqCA=;
        b=gRc4O4Oy1zahxEPzlLeCxELGWcvmEPTsAZsMeluJ5IJaok+2jyBNAwknXtV/U/Naze
         qACcIMwVpr8ZORLgR42ntJ9ilMxpU/2TOc8gVNuAJCq5rMv4n2MhqQ3iHQThCzKjiVw3
         0Hq44yanPEBBezbB3l0j8yMikMprHE39FcjGEx6pat3GemHMTGL44FxmdV/zEuJ1EmJC
         JIl0oLG7e9zPch83HLtzLdddHKSVuztZVLH2tQLFh23c3PMSHWKVOO/oIEMTDXJh0r+p
         J1CIlvBXZ1PHpbItIhmuHDmYIc91ruIsLZZVb8WMgWMERMV30jA2WH5V4igIBSuVqb3w
         RZHA==
X-Gm-Message-State: AC+VfDw+hye9Oj98bTEUUOSf6vWgNFzzLhIVd7lU4d4KJhp4IOLxuuzA
        JdBz3NQT26e2IhTHAhKkdgh1tA==
X-Google-Smtp-Source: ACHHUZ7SM0VxVHLY8BYml2BOqyofBDB/Imz9MBd9cH0Y3XZmo86yfhM9UPtUBbWqshb2x8JogJRgkg==
X-Received: by 2002:a17:907:8390:b0:953:37eb:7727 with SMTP id mv16-20020a170907839000b0095337eb7727mr11055069ejc.43.1684851015849;
        Tue, 23 May 2023 07:10:15 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id v3-20020a170906858300b0096a68648329sm4482396ejx.214.2023.05.23.07.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:10:15 -0700 (PDT)
References: <ZGVLo1V4kjx_lep5@slm.duckdns.org>
 <20230517222219.3191560-1-aliceryhl@google.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     tj@kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH v1 0/7] Bindings for the workqueue
Date:   Tue, 23 May 2023 16:08:20 +0200
In-reply-to: <20230517222219.3191560-1-aliceryhl@google.com>
Message-ID: <87mt1vdtq1.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> On Wed, 17 May 2023 11:48:19 -1000, Tejun Heo wrote:
>> I tried to read the patches but am too dumb to understand much.
>
> The patch is more complicated than I would have liked, unfortunately.
> However, as I mentioned in the cover letter, simplifications should be
> on their way.
>
> Luckily, using the workqueue bindings is simpler than the bindings
> themselves.
>
>> Any chance you can provide some examples so that I can at least
>> imagine how workqueue would be used from rust side?
>
> Yes, of course!

If you have bandwidth for it, it would be awesome to see some examples
in the series as well (for /samples/rust).

BR Andreas

>
> The simplest way to use the workqueue is to use the `try_spawn` method
> introduced by the last patch in the series. With this function, you just
> pass a function pointer to the `try_spawn` method, and it schedules the
> function for execution. Unfortunately this allocates memory, making it
> a fallible operation.
>
> To avoid allocation memory, we do something else. As an example, we can
> look at the Rust binder driver that I am currently working on. Here is
> how it will be used in the binder driver: First, the `Process` struct
> will be given a `work_struct` field:
>
> #[pin_data]
> pub(crate) struct Process {
>     // Work node for deferred work item.
>     #[pin]
>     defer_work: Work<Arc<Process>>,
>
>     // Other fields follow...
> }
>
> Here, we use the type `Work<Arc<Process>>` for our field. This type is
> the Rust wrapper for `work_struct`. The generic parameter to `Work`
> should be the pointer type used to access `Process`, and in this case it
> is `Arc<Process>`. The pointer type `Arc` is used for reference
> counting, and its a pointer type that owns a ref-count to the inner
> value. (So e.g., it decrements the ref-cout when the arc goes out of
> scope.) Arc is an abbreviation of "atomic reference count". This means
> that while it is enqueued in the workqueue, the workqueue owns a
> ref-count to the process.
>
> Next, binder will use the `impl_has_work!` macro to declare that it
> wants to use `defer_work` as its `work_struct` field. That looks like
> this:
>
> kernel::impl_has_work! {
>     impl HasWork<Arc<Process>> for Process { self.defer_work }
> }
>
> To define the code that should run when the work item is executed on the
> workqueue, binder does the following:
>
> impl workqueue::ArcWorkItem for Process {
>     fn run(self: Arc<Process>) {
>         // this runs when the work item is executed
>     }
> }
>
> Finally to schedule it to the system workqueue, it does the following:
>
> let _ = workqueue::system().enqueue(process);
>
> Here, the `enqueue` call is fallible, since it might fail if the process
> has already been enqueued to a work queue. However, binder just uses
> `let _ =` to ignore the failure, since it doesn't need to do anything
> special in that case.
>
> I hope that helps, and let me know if you have any further questions.
>
> Alice

