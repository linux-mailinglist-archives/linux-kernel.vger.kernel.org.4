Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BAF6D07F0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjC3OSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjC3ORw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:17:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9A0CDFE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:17:17 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso11887436wmo.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680185834;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=V3w4/MoUcTVEnZSoDDuIRGwZ4uXMTJFYF6lNB23fCPk=;
        b=jZto7yzee4mHExZhJYL8EBHaZ6kim1/ImNBRIxf6WnHEB/vfwpDG8HHF19HwOgGoFk
         Unpwei39GNh2Cck7ne7iQyiMONqo2bhkqe7txxOMh38OBbcpgPs3nEBWiPrVZR4Uvpqq
         1MUkJQQA/IjSoweErLKrTPAS6o9lBl0NVyP9QkjRYseuJiMakuYSwt0pf90ZZWu6N8oq
         HhfYUat9G5hFKKTQo2hxzAYW6IkZr37fG8DzCSCeuUxPxkd5Lzyd4PcpmOQ9HtYYvilE
         8q5Hi/KSH14T1siemr7507LrIZgmOEfVz9aw80Pc5tmt8Sg3bbGMsM69cK5MGowQabF6
         UCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680185834;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3w4/MoUcTVEnZSoDDuIRGwZ4uXMTJFYF6lNB23fCPk=;
        b=QsmUx9fG1SlzWe4fRGrNwj9DxTVMgcDANuBcuYmdYES+MowrEEUuWjqHO2vOSzDPYF
         c0PVTqyYNyUhOpssGt9iJPepHY4bHVlXiOOTDsdjj03aWpr3XqQefmB98WeudO0Jd0Tp
         6r/yXm8jI9MF48TpV/meBlbzU2R+ePrDZiZ5i4UNi77Bi/1YVl1Fm9vrPROwPx80YIkO
         N+kFRC9TqMatfrI3JTinOqWBjgaJjseF0dHXBF+ioD9auX2Uz6hDP8CS+Uf2jXh2V6z7
         BtiDvyJcqY2jkIyuwp9E4z0KKg6uO8vcxIsmQTl/uAwkNTfbhdA4vQ6RnkPeFb4GeHwE
         IavQ==
X-Gm-Message-State: AAQBX9fJnZK6sPCkcKyfmm0S7RvSBHSCZ+2ImuSmSu3h54o8P7jTF9tl
        3/N2E96MlmhCLpC9o1PxEYjTFg==
X-Google-Smtp-Source: AKy350bUobZJlvGg3INFY05R6/8uEgvZI6Llp4W7q1vO27xygsDmmZw61af5XrgjBmoSBx3Cv1ghcA==
X-Received: by 2002:a05:600c:4591:b0:3f0:3070:f4ea with SMTP id r17-20020a05600c459100b003f03070f4eamr3689550wmo.11.1680185834017;
        Thu, 30 Mar 2023 07:17:14 -0700 (PDT)
Received: from localhost ([147.161.155.82])
        by smtp.gmail.com with ESMTPSA id o39-20020a05600c512700b003edddae1068sm6455975wms.9.2023.03.30.07.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:17:13 -0700 (PDT)
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-5-y86-dev@protonmail.com>
 <ce17f68e-521f-f55e-8ae2-35bcd6ebd709@ryhl.io>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Alice Ryhl <alice@ryhl.io>
Cc:     y86-dev@protonmail.com, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v3 04/13] rust: add pin-init API core
Date:   Thu, 30 Mar 2023 16:16:31 +0200
In-reply-to: <ce17f68e-521f-f55e-8ae2-35bcd6ebd709@ryhl.io>
Message-ID: <878rfe493r.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <alice@ryhl.io> writes:

> On 3/30/23 00:33, y86-dev@protonmail.com wrote:
>> From: Benno Lossin <y86-dev@protonmail.com>
>> This API is used to facilitate safe pinned initialization of structs. It
>> replaces cumbersome `unsafe` manual initialization with elegant safe macro
>> invocations.
>> Due to the size of this change it has been split into six commits:
>> 1. This commit introducing the basic public interface: traits and
>>     functions to represent and create initializers.
>> 2. Adds the `#[pin_data]`, `pin_init!`, `try_pin_init!`, `init!` and
>>     `try_init!` macros along with their internal types.
>> 3. Adds the `InPlaceInit` trait that allows using an initializer to create
>>     an object inside of a `Box<T>` and other smart pointers.
>> 4. Adds the `PinnedDrop` trait and adds macro support for it in
>>     the `#[pin_data]` macro.
>> 5. Adds the `stack_pin_init!` macro allowing to pin-initialize a struct on
>>     the stack.
>> 6. Adds the `Zeroable` trait and `init::zeroed` function to initialize
>>     types that have `0x00` in all bytes as a valid bit pattern.
>> Co-developed-by: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
>> +//! Aside from pinned initialization, this API also supports in-place construction without pinning,
>> +//! the marcos/types/functions are generally named like the pinned variants without the `pin`
>> +//! prefix.
>
> Typo: Should be "macros".
>
>> +type Invariant<T> = PhantomData<fn(*mut T) -> *mut T>;
>
> I think it would make sense to include a link to the nomicon on the
> documentation for the Invariant type.
>
> E.g. this link: https://doc.rust-lang.org/nomicon/subtyping.html

That would be nice. I think this also applies: https://doc.rust-lang.org/nomicon/phantom-data.html#table-of-phantomdata-patterns

>
>> +// This is the module-internal type implementing `PinInit` and `Init`. It is unsafe to create this
>> +// type, since the closure needs to fulfill the same safety requirement as the
>> +// `__pinned_init`/`__init` functions.
>> +struct InitClosure<F, T: ?Sized, E>(F, Invariant<(E, T)>);
>
> Documentation for a type should use /// rather than //.
>
> I think it would help to call out explicitly in the documentation on this type
> that it is an implementation detail of the pin_init_from_closure and
> init_from_closure methods.

