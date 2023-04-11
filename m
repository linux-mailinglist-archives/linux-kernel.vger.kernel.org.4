Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F95A6DE376
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjDKSGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjDKSF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:05:57 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3459C76B1;
        Tue, 11 Apr 2023 11:05:22 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id y69so16014054ybe.2;
        Tue, 11 Apr 2023 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681236313;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+na8MfW+GAHqXa6WOo9dywQDhpNy1/XvjZ3S9OfmjGo=;
        b=Hj5pHh3SjaTuu4FZhTIl3ygx9Ofc7zHkrot2wCNVZBVWZg2d0yjGc5lmN9M3H0kZab
         Tuy0Q+XUeZXLN2XizhoXqPpnyDqdpvgWtn6SuTUZv6m4IuDjcfRbxsMFFljsA8wK2OhZ
         Vnl+QU0NcvoGWcbivjPnPk5O8prHrrRoewne8uhr5wp+bF6HjilDJ9kPXjtz9YhYLOYj
         ZTL1kyJUusAV0iP7850/sI67ZE2JMhs4khQrU5jNiVI3JBF/t45dOqHgP+4LE8i1l08e
         FJFDE/kj4W+ZiM9YUuLSNC/4NL83LfBOIOEwO8r0QyDlJkyGJGHGsONOpORczFWFZ9sA
         5NDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681236313;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+na8MfW+GAHqXa6WOo9dywQDhpNy1/XvjZ3S9OfmjGo=;
        b=RLhDj70svHxPACR+sCdFRolGe3Vjal0pf9ozKrUHq8w6MBoGXwD0kXaipJiJw7WAyb
         u1UOxKWfS3S36bHzOr7EaiRt7Jr2ay0Dg6CiD+mhGkGzYgOYqMGEisYJClPe1oqOWq19
         pxOujWSXv0Vb6cdGvpu7xYKZ08Mvayf8cj9qhl3VoohvZfboKU9lpE3d+CTz0zAWb2WB
         DQfOHdEtfXTD3PLFhck6g67+w3hJvvqImvAVS+PcLa5+SVmkbr3l37KStu5WXX/s6/Hu
         CztuqzJxGqoLPyYJCVaY7zMx5qCe/ywnm1Mgie8FIzlkmn8Mji1/ccsMicKauRCceXhk
         hOew==
X-Gm-Message-State: AAQBX9ezJaY90tiwELDCQsgmw2nvvSBtve6JSaGZeW0HfSwtbkAGPpWm
        Kurs4npjmQtD/pSVaWrK7FXqxgPF6n+8RzzvL6M=
X-Google-Smtp-Source: AKy350a/lhAd+WCwEd8SwsYEyEyDohgcXZkNuv5mS7JvnoJ0T8e/XLEy9453AcEGb9z0NnCrFNNwnnXdRgsTQaTfoKg=
X-Received: by 2002:a25:d210:0:b0:b8f:1d90:e62a with SMTP id
 j16-20020a25d210000000b00b8f1d90e62amr2158490ybg.6.1681236312987; Tue, 11 Apr
 2023 11:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230411054543.21278-1-wedsonaf@gmail.com> <20230411054543.21278-4-wedsonaf@gmail.com>
In-Reply-To: <20230411054543.21278-4-wedsonaf@gmail.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Tue, 11 Apr 2023 15:05:07 -0300
Message-ID: <CANeycqqM5o_4gj2rT=8yV0NGTRWY=jTA6HT4F2Esho-WAJCPOQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/13] locking/spinlock: introduce spin_lock_init_with_key
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 at 02:46, Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> Rust cannot call C macros, so it has its own macro to create a new lock
> class when a spin lock is initialised. This new function allows Rust
> code to pass the lock class it generates to the C implementation.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: No changes
> v2 -> v3: No changes
> v3 -> v4: No changes
>
>  include/linux/spinlock.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index be48f1cb1878..cdc92d095133 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -327,12 +327,17 @@ static __always_inline raw_spinlock_t *spinlock_check(spinlock_t *lock)
>
>  #ifdef CONFIG_DEBUG_SPINLOCK
>
> +static inline void spin_lock_init_with_key(spinlock_t *lock, const char *name,
> +                                          struct lock_class_key *key)
> +{
> +       __raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
> +}
> +
>  # define spin_lock_init(lock)                                  \
>  do {                                                           \
>         static struct lock_class_key __key;                     \
>                                                                 \
> -       __raw_spin_lock_init(spinlock_check(lock),              \
> -                            #lock, &__key, LD_WAIT_CONFIG);    \
> +       spin_lock_init_with_key(lock, #lock, &__key);           \
>  } while (0)

Peter, the code above is just factoring out spin lock init when
lockdep is enabled to take a lock class key.

Would you be able to review it?

If it's ok with you, we'd like to carry it through the rust tree
because we have code that depends on it.

Thanks,
-Wedson

>
>  #else
> --
> 2.34.1
>
