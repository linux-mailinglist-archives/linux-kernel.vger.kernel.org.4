Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CF06DE016
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjDKPzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjDKPza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:55:30 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48B92D63;
        Tue, 11 Apr 2023 08:55:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5C0B141F72;
        Tue, 11 Apr 2023 15:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1681228523;
        bh=0KFpXLyxRFISS+Ok78SUbTpjO3mej+5SYnKp4vu77tU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=hOObcoIiPm5nhpMj85/3ogUsMGJrj56TwD86fbkKjYVe/c110SbKsDbRTHUqG+5FE
         KmykrTUYIo3fmB5oK8tKQwztpD7oZdbeonfpHRQyZwZRhtFVpam7IQJ2C23OYQjE5e
         4HuKdCxVPJEDldq15KUrCiYLTGcnDWbbEWJ09Vo2WECsGjOZialoojz/PXFTPqsT/x
         YcGiZ6tYyE75PNRD0lOlz4u8diH104iZtfWmVI8ZDtoQK1MeH9lAAwVo0q7MbT9EXb
         U/YFgOASC0xPcI52P9Hysioz6uGprvR24xMnkh4DJHBgziClpKr5qir2Yucvf2O8f/
         3aXJWmfVDpYpQ==
Message-ID: <1bb98ef1-727a-45d6-3cf6-39765fe99c5c@asahilina.net>
Date:   Wed, 12 Apr 2023 00:55:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] rust: xarray: Add an abstraction for XArray
Content-Language: en-US
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Neal Gompa <neal@gompa.dev>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
References: <20230224-rust-xarray-v3-1-04305b1173a5@asahilina.net>
 <20230404152516.0368a92b.gary@garyguo.net>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <20230404152516.0368a92b.gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 23.25, Gary Guo wrote:
> On Mon, 03 Apr 2023 19:14:23 +0900
> Asahi Lina <lina@asahilina.net> wrote:
> 
>> The XArray is an abstract data type which behaves like a very large
>> array of pointers. Add a Rust abstraction for this data type.
>>
>> The initial implementation uses explicit locking on get operations and
>> returns a guard which blocks mutation, ensuring that the referenced
>> object remains alive. To avoid excessive serialization, users are
>> expected to use an inner type that can be efficiently cloned (such as
>> Arc<T>), and eagerly clone and drop the guard to unblock other users
>> after a lookup.
>>
>> Future variants may support using RCU instead to avoid mutex locking.
>>
>> This abstraction also introduces a reservation mechanism, which can be
>> used by alloc-capable XArrays to reserve a free slot without immediately
>> filling it, and then do so at a later time. If the reservation is
>> dropped without being filled, the slot is freed again for other users,
>> which eliminates the need for explicit cleanup code.
>>
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> ---
>>
>> Hi everyone!
>>
>> This abstraction is part of the set of dependencies for the drm/asahi
>> Apple M1/M2 GPU driver.
>>
>> The branch at [1] contains the full series of patches rebased on
>> upstream leading to the complete driver, for reference on how it is
>> intended to be used.
>>
>> Thank you everyone who helped review this on GitHub [2]! I hope I didn't
>> forget any CCs...
>>
>> Note that I dropped the convenience `Deref` impl for `Guard`, since I
>> couldn't figure out how to do it safely. Suggestions welcome, or we can
>> leave it for a future improvement ^^
>>
>> [1] https://github.com/AsahiLinux/linux/tree/gpu/rebase-20230224
>> [2] https://github.com/Rust-for-Linux/linux/pull/952
>>
>> Changes in v3:
>> - Updated to the error v2/v3 series API.
>> - Renamed `err` to `ret` for consistency with the other instance.
>> - Link to v2: https://lore.kernel.org/r/20230224-rust-xarray-v2-1-4eeb0134944c@asahilina.net
>> Changes in v2:
>> - Added Pin requirement for all XArray operations, to close a
>>    soundness hole due to the lock in the XArray (locks are not safe to
>>    move while locked). Creation does not require pinning in place, since
>>    the lock cannot be acquired at that point.
>> - Added safety note to Drop impl about why we don't need to do the lock
>>    unlock dance to ensure soundness in case of a dropped lock guard.
>> - Downstream drm/asahi driver was also rebased on this version to prove
>>    it works (previously it was still on a pre-v1 version).
>> - This still depends on the Error series (v1). v2 of that will need a
>>    trivial rename of Error::from_kernel_errno -> Error::from_errno. If
>>    this version of XArray ends up looking good, I'll send a trivial v4 of
>>    XArray with the rename, after sending the v2 of the Error series.
>> - Link to v1: https://lore.kernel.org/r/20230224-rust-xarray-v1-1-80f0904ce5d3@asahilina.net
>> ---
>>   rust/bindings/bindings_helper.h |  17 +++
>>   rust/helpers.c                  |  37 +++++
>>   rust/kernel/lib.rs              |   1 +
>>   rust/kernel/xarray.rs           | 302 ++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 357 insertions(+)
>>
[snip]
>> +    /// Replaces an entry with a new value, returning the old value (if any).
>> +    pub fn replace(self: Pin<&Self>, index: usize, value: T) -> Result<Option<T>> {
>> +        let new = value.into_foreign();
>> +        // SAFETY: `new` just came from into_foreign(), and we dismiss this guard if
>> +        // the xa_store operation succeeds and takes ownership of the pointer.
>> +        let guard = ScopeGuard::new(|| unsafe {
>> +            T::from_foreign(new);
>> +        });
>> +
>> +        // SAFETY: `self.xa` is always valid by the type invariant, and we are storing
>> +        // a `T::into_foreign()` result which upholds the later invariants.
>> +        let old = unsafe {
>> +            bindings::xa_store(
>> +                self.xa.get(),
>> +                index.try_into()?,
>> +                new as *mut _,
>> +                bindings::GFP_KERNEL,
>> +            )
>> +        };
> 
> XArray's doc says the pointer must be 4-byte aligned, but I didn't see
> any checks.

Hmm... should we just assert that at runtime here?

I doubt any reasonable boxed type will ever have a non-aligned address 
in practice, but I guess it's technically not impossible. Maybe we 
should just add it to the contract for ForeignOwnable?

~~ Lina

