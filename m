Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4A66C6D91
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjCWQan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjCWQaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:30:03 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53EE298F8;
        Thu, 23 Mar 2023 09:29:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 29C2E420CF;
        Thu, 23 Mar 2023 16:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1679588998;
        bh=oNvVr1kFt3SmK/C28H/bAWInhx7VA90WwPgLpowzoxE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=sPErOouVd0l1ICYYe6Ol29w/aHljjg7cNEsNKlDDY9NGBAAvvHr/4+OnOazGB/kh2
         C4I0TR9PbjFRz5yfE2vFPkJ+HGOjOC3+SdkwIitW8t8rz9yx+CQnq85sRjf/Jr/OdD
         VlzFlwBBb3jJ/vUF2xzFYVwRORaUbQnnV+bVt5bRTrBOoyJpaTS3OSm66j2Sh9jhhH
         87KYiYuFN6dAnJVuPiUQjYDG3C8X1tULvZUkFJ1DN8amz+zCz6TcJRKA0QXZn8qnMY
         FgfJnqM3fFQiG5RDRMPAtA+Gkn4bnaPayUndjV6CHe7i6F7ZqhrjEnCp+c9MpIfmIA
         XDkNE0/wBCzkQ==
Message-ID: <e5e24cec-f4b5-b641-c860-c157663c1ff8@asahilina.net>
Date:   Fri, 24 Mar 2023 01:29:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] rust: xarray: Add an abstraction for XArray
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Neal Gompa <neal@gompa.dev>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
References: <20230224-rust-xarray-v2-1-4eeb0134944c@asahilina.net>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <20230224-rust-xarray-v2-1-4eeb0134944c@asahilina.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Why do I always notice mistakes after sending the patch... this is
missing the comment I intended to add because I edited the file in the
wrong git checkout. Sorry!

The intended comment is below, I'll roll it into v3 when I make the 
Error API change.

On 24/03/2023 01.23, Asahi Lina wrote:
> The XArray is an abstract data type which behaves like a very large
> array of pointers. Add a Rust abstraction for this data type.
> 
> The initial implementation uses explicit locking on get operations and
> returns a guard which blocks mutation, ensuring that the referenced
> object remains alive. To avoid excessive serialization, users are
> expected to use an inner type that can be efficiently cloned (such as
> Arc<T>), and eagerly clone and drop the guard to unblock other users
> after a lookup.
> 
> Future variants may support using RCU instead to avoid mutex locking.
> 
> This abstraction also introduces a reservation mechanism, which can be
> used by alloc-capable XArrays to reserve a free slot without immediately
> filling it, and then do so at a later time. If the reservation is
> dropped without being filled, the slot is freed again for other users,
> which eliminates the need for explicit cleanup code.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
[...]
> +impl<T: ForeignOwnable> Drop for XArray<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.xa` is valid by the type invariant, and as we have the only reference to
> +        // the `XArray` we can safely iterate its contents and drop everything.
> +        unsafe {
> +            let mut index: core::ffi::c_ulong = 0;
> +            let mut entry = bindings::xa_find(
> +                self.xa.get(),
> +                &mut index,
> +                core::ffi::c_ulong::MAX,
> +                bindings::BINDINGS_XA_PRESENT,
> +            );
> +            while !entry.is_null() {
> +                T::from_foreign(entry);
> +                entry = bindings::xa_find_after(
> +                    self.xa.get(),
> +                    &mut index,
> +                    core::ffi::c_ulong::MAX,
> +                    bindings::BINDINGS_XA_PRESENT,
> +                );
> +            }
> +

Add for v3:
> +            // Locked locks are not safe to drop. Normally we would want to try_lock()/unlock() here
> +            // for safety or something similar, but in this case xa_destroy() is guaranteed to
> +            // acquire the lock anyway. This will deadlock if a lock guard was improperly dropped,
> +            // but that is not UB, so it's sufficient for soundness purposes.

> +            bindings::xa_destroy(self.xa.get());
> +        }
> +    }
> +}
> +
> +// SAFETY: XArray is thread-safe and all mutation operations are internally locked.
> +unsafe impl<T: Send + ForeignOwnable> Send for XArray<T> {}
> +unsafe impl<T: Sync + ForeignOwnable> Sync for XArray<T> {}
> 
> ---
> base-commit: 3ef2e9730ba4bb914dd8654ae34aef3f486c8c58
> change-id: 20230224-rust-xarray-f503f9e5455e
> 
> Thank you,
> ~~ Lina
> 
> 

~~ Lina

