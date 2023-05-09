Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DB56FC4A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbjEILLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjEILLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:11:07 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD1019AF;
        Tue,  9 May 2023 04:11:06 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b9e2b65d006so8677447276.3;
        Tue, 09 May 2023 04:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683630665; x=1686222665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vkk5DCy0z8eSEQJVhraU0gyt2AdUF96RHlpvGnmt4l8=;
        b=jWHqrlv1baM2RFyMyWnFWvRvQzJwzy1tI//qEiBRlo7NtLAkNSSADCHP1qXq2HKOXw
         4ylVczxZLkaVP5CHkls7q1hHxLD9XQlHp2eObYN2YwWNBhhumPVdMc60Fe0yZcD+TBKL
         fATB2lmJZK+t/B+KdFaQ1eBX7oo6DrSMhiRAegBaPghSGt9y0PI8jusxxywFJA8/XEG0
         UUD/6hRxCrT7bNkKCmwmb53CsaiENjSM4KedxejCfcAE3JmR3Ga7lj0MWT9W5Wsp89fr
         AINQdsIMhgWTgeVny665E9o666cv3Fu3un2KgJ0M9BzavlnFZq2WM71Uxia4rsnaA1oA
         QtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683630665; x=1686222665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vkk5DCy0z8eSEQJVhraU0gyt2AdUF96RHlpvGnmt4l8=;
        b=TZUTYYTkmeQ7IuR7CL+XISk2Rx3ndu+FiZsCIi8m+s4CSiU1idriBwvMzKQeko3IRf
         JQSS7TioZkl7wmXbHrJfvsfLmSNb8yrvOuEzovps7f96QQOspKQQwipa49p9dotJueEL
         DspVKSJot78+kHjLG/1sgn8OLZ2bBzN0aJbxrSgkGga/FKrC2pistg+cV2Gpwfp4jG8o
         jkJGHCG1BWFek356bbzUfbG7YDSosQrDZ8g4GdBwDwKzohsHadIzJCjRjDoHVPFn5u5k
         ph0QNMOfMAr2fh8JKeNfecIL6VDhkBoAII7u5ytHYypDI7hpPfzDNWi2IE7TS8jrR7PH
         A3nw==
X-Gm-Message-State: AC+VfDzv55D7PF9YmuLnmYPwo/F6P4ptukUMrEA8HGSQb8dIGxl4kMgw
        uWl3ILJEnZCIN6NrUXpl0gZe+BdGfGyvDCS/3j0=
X-Google-Smtp-Source: ACHHUZ6F9VU8XtGo+n2aInAJWRWYS2JnkqgFQhs0oZ9WPnE+YhEjkUNoi+ZYf4bu9RXqyJMqktr3zZL0nifP5dHX+xo=
X-Received: by 2002:a25:2d4:0:b0:b9e:7896:63a0 with SMTP id
 203-20020a2502d4000000b00b9e789663a0mr14839271ybc.54.1683630665536; Tue, 09
 May 2023 04:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230508124701.443ba331.gary@garyguo.net> <20230509080700.1608146-1-aliceryhl@google.com>
 <2023050937-scouring-truck-d7c0@gregkh>
In-Reply-To: <2023050937-scouring-truck-d7c0@gregkh>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 9 May 2023 13:10:54 +0200
Message-ID: <CANiq72=g=CnEQTkc50qozUdOBZECr7Jr2NCRfGFaKh751i6Sww@mail.gmail.com>
Subject: Re: [PATCH v2] rust: error: add missing error codes
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alice Ryhl <aliceryhl@google.com>, gary@garyguo.net,
        alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 10:46=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> It depends on which arch you are building for.  That's why we have
> per-platform errno.h files, the values are different for different ones.
> So you need to handle them all properly somehow.  How is rust going to
> handle per-arch stuff like this?

We can do conditional compilation in the same file, possibly with a
Rust macro which takes a nice table that shows all arches at once.

We can also split into files like C and move it to each `arch/`, there
are a couple of approaches for this. This is best for `MAINTAINERS`,
although these headers almost never change, so it is not a big
advantage.

We could also automatically do everything based on the C headers, too.
Back then it felt to me like too much complexity for little gain,
given those C headers almost never change, but now it may be worth it.
Or, instead, having a test that verifies they are the same instead,
and that way we don't introduce complexity for the build itself.

Alice only needs `ERESTARTSYS` so far, as far as I understand, so
perhaps it is simplest to only add the rest of the non-generic ones
for the moment; and gather opinions on the approaches above meanwhile.

Cheers,
Miguel
