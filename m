Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333E671FE05
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjFBJhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjFBJhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:37:48 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10313E7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:37:45 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-974566553ccso81065766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685698663; x=1688290663;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g6hKGnk7+yrdCqGxFZXtFZSCtr3Hs69nhywa4vN9dQk=;
        b=k++9SNiv/OO3O33g9/9eTroGH9b5hGlPNSi00zMI+3lKBu4RkFuIC1EcEe7KD/jbaz
         w7M2YFlWaueUEZ3ZBRhBGEljk4CX6XobHPYEr/cMV88eHC8OdecDaOMfZJuBeqInAwD+
         AS49oX1gWO0jWTyaCmjdNL7X0Yk+k7i5creGBmVCLkabQjlsHTPe5sA28usbmDCXYCRJ
         4ZptKGmHboTtMeV00P4JBm95Ws+ym2erT/xlVh4nZgISW78geGc+StYhiNHOeV4sSw4e
         PAkVnBlceCInTUdm4jIK/4AJvO4dTSuhgWJSM/z4SZ2w33u+uzuwv+yyv44kgQKOdQGn
         uWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685698663; x=1688290663;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6hKGnk7+yrdCqGxFZXtFZSCtr3Hs69nhywa4vN9dQk=;
        b=M8fvrO565HalzqUvP2zgOJdyUZHVf8zHEOoN54sASOyF71N6DQV4T04JoXbVv5dhil
         SFkJ+Q6uGIT8mT20PMKDXIPcJehh1hA9C8PHusXmycr8N82TPSrmd+VuRc2Z00skgRE9
         GBZdm6j1MHTkLMl1gSy4QUsXwty7/QYmzVhDaJX+xeSzj+t1LwyTnWWdmgC8z2U9+tXy
         h6H21a17Iiw+iPllde23dFcHCxHOuaEt6Nqisma6zR5q/mn0ql+OV4yZXtA+zPaxxhxL
         Goz7JRYaJp3qFwKAXzvnsMK7l7Cp/IHVh6SlkZ5gv1X53+jfsXwdTBGoTT6b773wVmFY
         ei6A==
X-Gm-Message-State: AC+VfDyjSAmWNjc+HmOMpYduMebOiaPf2z9hzDvl7+K/P8awVLcwKC9z
        5jNQzytnOwlimhonzWgoi0soVF8mraijyi4=
X-Google-Smtp-Source: ACHHUZ6JmHF0O7xB25c4LZS3SBpbPu8gJ1LUrG2oig85p/mrkugigxAcAyjZYDiO5uEzwymT7yTtjwNZQO8JTzA=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:5a69:b0:974:5e62:2afc with SMTP
 id my41-20020a1709065a6900b009745e622afcmr502336ejc.13.1685698663640; Fri, 02
 Jun 2023 02:37:43 -0700 (PDT)
Date:   Fri,  2 Jun 2023 09:37:41 +0000
In-Reply-To: <ZHkI8LXrqUOJ7G5E@boqun-archlinux>
Mime-Version: 1.0
References: <ZHkI8LXrqUOJ7G5E@boqun-archlinux>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602093741.1040283-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 5/8] rust: workqueue: add helper for defining
 work_struct fields
From:   Alice Ryhl <aliceryhl@google.com>
To:     boqun.feng@gmail.com
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boqun Feng <boqun.feng@gmail.com> writes:
> On Thu, Jun 01, 2023 at 01:49:43PM +0000, Alice Ryhl wrote:
>> +/// Defines the method that should be called directly when a work item is executed.
>> +///
>> +/// Typically you would implement [`WorkItem`] instead. The `run` method on this trait will
>> +/// usually just perform the appropriate `container_of` translation and then call into the `run`
>> +/// method from the [`WorkItem`] trait.
>> +///
>> +/// This trait is used when the `work_struct` field is defined using the [`Work`] helper.
>> +///
>> +/// # Safety
>> +///
>> +/// Implementers must ensure that [`__enqueue`] uses a `work_struct` initialized with the [`run`]
>> +/// method of this trait as the function pointer.
>> +///
>> +/// [`__enqueue`]: RawWorkItem::__enqueue
>> +/// [`run`]: WorkItemPointer::run
>> +pub unsafe trait WorkItemPointer<const ID: u64>: RawWorkItem<ID> {
>> +    /// Run this work item.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The provided `work_struct` pointer must originate from a previous call to `__enqueue` where
>> +    /// the `queue_work_on` closure returned true, and the pointer must still be valid.
>> +    unsafe extern "C" fn run(ptr: *mut bindings::work_struct);
>> +}
>> +
>> +/// Defines the method that should be called when this work item is executed.
>> +///
>> +/// This trait is used when the `work_struct` field is defined using the [`Work`] helper.
>> +pub trait WorkItem<const ID: u64 = 0> {
>> +    /// The pointer type that this struct is wrapped in. This will typically be `Arc<Self>` or
>> +    /// `Pin<Box<Self>>`.
>> +    type Pointer: WorkItemPointer<ID>;
> 
> This being an associate type makes me wonder how do we want to support
> the following (totally made-up by me, but I think it makes sense)?:
> 
> Say we have a struct
> 
> 	pub struct Foo {
> 		work: Work<Foo>,
> 		data: Data,
> 	}
> 
> 	impl Foo {
> 		pub fn do_sth(&self) {
> 			...
> 		}
> 	}
> 
> and we want to queue both Pin<Box<Foo>> and Arc<Foo> as work items, but
> the following doesn't work:
> 
> 	// Pin<Box<Foo>> can be queued.
> 	impl WorkItem for Foo {
> 		type Pointer = Pin<Box<Foo>>;
> 		fn run(ptr: Self::Pointer) {
> 			ptr.do_sth();
> 		}
> 	}
> 
> 	// Arc<Foo> can also be queued.
> 	impl WorkItem for Foo {
> 		type Pointer = Arc<Foo>;
> 		fn run(ptr: Self::Pointer) {
> 			ptr.do_sth();
> 		}
> 	}
> 
> Of course, we can use new type idiom, but that's not really great, and
> we may have more smart pointer types in the future.
> 
> Am I missing something here?

Basically, you're asking "is it possible to use the same `work_struct`
field for several different pointer types"?

When creating the function pointer to store in the `work_struct`, the
function pointer _must_ know what the pointer type is. Otherwise it
cannot call the right `WorkItem::run` method or perform the correct
`container_of` operation. (E.g. an `Arc` embeds a `refcount_t` before
the struct, but a `Box` does not.)

With an associated type there is no problem with that. Associated types
force you to make a choice, which means that the `work_struct` knows
what the pointer type is when you create it. Supporting what you suggest
means that we must be able to change the function pointer stored in the
`work_struct` after initializing it.

This is rather tricky because you can call `enqueue` from several
threads in parallel; just setting the function pointer before you call
`queue_work_on` would be a data race. I suppose you could do it by
implementing our own `queue_work_on` that sets the function pointer
_after_ successfully setting the `WORK_STRUCT_PENDING_BIT`, but I don't
think this patchset should do that.

Alice
