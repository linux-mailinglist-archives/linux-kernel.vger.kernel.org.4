Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5776D0A71
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjC3PwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjC3PwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:52:18 -0400
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch [185.70.41.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275D9E053
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:51:56 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:41:35 +0000
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Zy9gNGHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680190900; x=1680450100;
        bh=4UQL5YU3GftVLCSKg9iIuP0+cp+0sOxbHm9DzBH9Tg8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Zy9gNGHfDtFL19Ml2z4VGj5D2hEpJeOKewnLCxj76Fz6YTlOfIwIPGj/g6bf/cpZe
         OqoSfa2dUkE1qG5KJls8+BBQvsVJc1FWRdzHi6WzD0JkEsI2q3I7NTPjbAleNUb0d/
         ZyqMUx2LL5juEOBjz18LTzwfnisHNahB0saoEzE8kWBiQlX1S25xOGzZxiud8JnV5a
         fCC+a0LO1i8maYLYsTFr99OMLPNb/xbaiRmqefe2u2itsKBNXyldDSUrRNy5gNUS3O
         xgr7NFpwW7L6tR7NCrWfMcebpkz17O3RnA9je3xnOnuPhX2BWySRjlasmMDosSsPE8
         fH/v/QpA3YihQ==
To:     Gary Guo <gary@garyguo.net>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 07/13] rust: init: add `PinnedDrop` trait and macros
Message-ID: <bf492337-1a4d-cca3-f12a-d5f4eaf742f0@protonmail.com>
In-Reply-To: <20230330120103.2baaeb1b.gary@garyguo.net>
References: <20230329223239.138757-1-y86-dev@protonmail.com> <20230329223239.138757-8-y86-dev@protonmail.com> <20230330120103.2baaeb1b.gary@garyguo.net>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 13:01, Gary Guo wrote:
> On Wed, 29 Mar 2023 22:33:24 +0000
> y86-dev@protonmail.com wrote:
>
>> From: Benno Lossin <y86-dev@protonmail.com>
>>
>> The `PinnedDrop` trait that facilitates destruction of pinned types.
>> It has to be implemented via the `#[pinned_drop]` macro, since the
>> `drop` function should not be called by normal code, only by other
>> destructors. It also only works on structs that are annotated with
>> `#[pin_data(PinnedDrop)]`.
>>
>> Co-developed-by: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
>> ---
>>   rust/kernel/init.rs            | 111 ++++++++++++++
>>   rust/kernel/init/__internal.rs |  15 ++
>>   rust/kernel/init/macros.rs     | 263 +++++++++++++++++++++++++++++++++
>>   rust/macros/lib.rs             |  49 ++++++
>>   rust/macros/pinned_drop.rs     |  49 ++++++
>>   5 files changed, 487 insertions(+)
>>   create mode 100644 rust/macros/pinned_drop.rs
>>
>> diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__interna=
l.rs
>> index 692942a008b3..4a3c7bf27a06 100644
>> --- a/rust/kernel/init/__internal.rs
>> +++ b/rust/kernel/init/__internal.rs
>> @@ -132,3 +132,18 @@ impl<T: ?Sized> Drop for DropGuard<T> {
>>           }
>>       }
>>   }
>> +
>> +/// Token used by `PinnedDrop` to prevent calling the function without =
creating this unsafely
>> +/// created struct. This is needed, because the `drop` function is safe=
, but should not be called
>> +/// manually.
>> +pub struct OnlyCallFromDrop(());
>> +
>> +impl OnlyCallFromDrop {
>> +    /// # Safety
>> +    ///
>> +    /// This function should only be called from the [`Drop::drop`] fun=
ction and only be used to
>> +    /// delegate the destruction to the pinned destructor [`PinnedDrop:=
:drop`] of the same type.
>> +    pub unsafe fn create() -> Self {
>
> Although this is impl detail and the name doesn't really matter, but I
> am wondering why this is called `create` instead of just `new`.
Not really a good reason, I associate `new()` with 'unburdened' creation
(i.e. a safe function). Will change this.

--
Cheers,
Benno

>
>> +        Self(())
>> +    }
>> +}

