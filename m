Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389B6717AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjEaJAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbjEaJAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:00:37 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAE4125
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:00:36 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-94a34e35f57so466291566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685523635; x=1688115635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PEW73TP0tUGYUfeakPneuxLod08yUyWlknx492xsU6I=;
        b=gYPrGvgJZ60XP/b1C8CGziAC6W7bJnxHJ7ittHw6F1f1N/eMr+WR5Ljn5jcPp9fYT1
         VTTggqdWq+M/qyWLAcHEy0y/c/8XGkXkT1+RMQGIf0+z8EZFVJMp7876YvnuYGa0BIHB
         HQO/5frgPLpxUsm/SqfeaqysjOI6I4dapjDMzJWh1btGSexT6s3PmQda0byDSMZyt3la
         X8bC9Rub6mAifjO/3+GlobSObhzbxuFPqV04JA/EZYaJNvQHia0s6B+xumKQjOQh7OCf
         f4nC4BGFTCTj008Xk1yJiyOhqcBihabUQ9/RbZUG10CACpxHDIfGb4chhIVn9oLCgmHx
         nQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685523635; x=1688115635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEW73TP0tUGYUfeakPneuxLod08yUyWlknx492xsU6I=;
        b=eTlZu9Vo4pbipQhLHjmbJZt1bazvxUKHBLfVNyk0kR178uRr9UFtMQn6mXlfxip2tz
         OuPFutvrTdxRTM7B8Vy6ltaktAm3xDda5E9NT7hHPcnh8NRu/DaXs1t0kSSS/+3Z37eX
         H4NndUawXz6EaaLr3Ya9t9sBC+3BJXAeIINKVN8j3oL84gSbHM6ToWz6q8+8tmhKbqJM
         kbgdDkBEdEw4smg1DfldEKfD0oPOMn8joRjmLaN86dqOBkj3guxNMFzPaRa/X/RXB8PT
         N/xxbSeztf3AXqak8El7aizQ7wbl7Ur/YRoKd+tTUnieKJizY9gaIyY0daWt7HyhxOTi
         3aXQ==
X-Gm-Message-State: AC+VfDwVbeE8kMEqR3MMlSOOWYpfk49XkUP+f8yL6qrrljMUwKWZoJ+y
        xVT5jJqrfZdPTWxiyFZxCDQcUAu++Lch1s4=
X-Google-Smtp-Source: ACHHUZ65hkl1uia6H6MximaB38OQnF+T/FPInRsNjxXobMlEoXQ5hscWUZ3mcBy5BHny1EYvzHMob7R5wWwcszc=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:9bc4:b0:973:8412:2f78 with SMTP
 id de4-20020a1709069bc400b0097384122f78mr1812269ejc.2.1685523634903; Wed, 31
 May 2023 02:00:34 -0700 (PDT)
Date:   Wed, 31 May 2023 09:00:32 +0000
In-Reply-To: <87leh69par.fsf@metaspace.dk>
Mime-Version: 1.0
References: <87leh69par.fsf@metaspace.dk>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531090032.3667467-1-aliceryhl@google.com>
Subject: Re: [PATCH v1 5/7] rust: workqueue: add helper for defining
 work_struct fields
From:   Alice Ryhl <aliceryhl@google.com>
To:     nmi@metaspace.dk
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        tj@kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hindborg <nmi@metaspace.dk> writes:
> Alice Ryhl <aliceryhl@google.com> writes:
>> +/// Used to safely implement the [`HasWork<T>`] trait.
>> +///
>> +/// # Examples
>> +///
>> +/// ```
>> +/// use kernel::sync::Arc;
>> +///
>> +/// struct MyStruct {
>> +///     work_field: Work<Arc<MyStruct>>,
>> +/// }
>> +///
>> +/// impl_has_work! {
>> +///     impl HasWork<Arc<MyStruct>> for MyStruct { self.work_field }
>> +/// }
>> +/// ```
>> +///
>> +/// [`HasWork<T>`]: HasWork
>> +#[macro_export]
>> +macro_rules! impl_has_work {
>> +    ($(impl$(<$($implarg:ident),*>)?
>> +       HasWork<$work_type:ty>
>> +       for $self:ident $(<$($selfarg:ident),*>)?
>> +       { self.$field:ident }
>> +    )*) => {$(
>> +        // SAFETY: The implementation of `raw_get_work` only compiles if the field has the right
>> +        // type.
>> +        unsafe impl$(<$($implarg),*>)? $crate::workqueue::HasWork<$work_type> for $self $(<$($selfarg),*>)? {
>> +            const OFFSET: usize = $crate::offset_of!(Self, $field) as usize;
>> +
>> +            #[inline]
>> +            unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_type> {
>> +                // SAFETY: The caller promises that the pointer is not dangling.
>> +                unsafe {
>> +                    ::core::ptr::addr_of_mut!((*ptr).$field)
>> +                }
>> +            }
> 
> What is the reason for overriding the default implementation of `raw_get_work()`?
> 
> BR Andreas

That's how the macro checks that the field actually has the type you
claim it has. If you lie about the type, then `raw_get_work` will not
compile. (See the safety comment on the impl block.)

Alice
