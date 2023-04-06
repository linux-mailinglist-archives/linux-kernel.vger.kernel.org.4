Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D116D9C55
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbjDFP3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239669AbjDFP3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:29:31 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EBA271E;
        Thu,  6 Apr 2023 08:29:12 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54c12009c30so33386297b3.9;
        Thu, 06 Apr 2023 08:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680794951; x=1683386951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxFTeqIM+fDaf2S47yMcsdQqpuIYfa7qMZjwycfNH5g=;
        b=cCsSTN64qhk+zz1XDwfKJYV5Vla3s40LS2pOkGuKFZ91uihaisxJE0zTX68pnyUQe5
         pFa7kJFc4ApdHws+9K+6In7cgWiJGiFdp1KJqLmyIBiA/OLe5zcnhxO/j1U+lFVcoTOQ
         0cSKwMteRXgF3ghvwQ3pLf4Wn0TMIjlTpD/TsS7XOwVJvo0W36tHdkZLJb0wxbDmfasV
         Q5NkfQdPvGtde1ML/KBz4rwxbkEXVpukSoFKQQZ/61kvdyWQH4sXXhCWhgdfkKyBb8x5
         YOkZMySoy2ITBBrlSnC3gPZ7XOTqJGSPpQoZq2xnfA4hJA6/Pu2rFVZr6OQ0X2eueuBT
         6Fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680794951; x=1683386951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxFTeqIM+fDaf2S47yMcsdQqpuIYfa7qMZjwycfNH5g=;
        b=FURY08EcNUIiFc6GWZT+Scg6Zco6olE3fFuug3VtVuHwolYbjGiiH4AIxRC3HoUi2m
         TA4N+tLr7cJE5x1TcGuR4ZhdO62jWjjidaz6mj6TvIg65flT1UW6sdDjn0uGMnGDx6ol
         1WjT8T/wYS0gT5b4Htl2mgDp5jGqK5yCk2HDsI/4j609jt/ttGIBdKiM03DynbPiiVZ/
         +fIuv07H/OXj8pGGWwkoFYSoVto9ilymPMFJLA8pS4a73uFkw7JvnAmTc691xTtI/6FK
         ZAjmw18YvcKbcdXz4/0qg1T8O9pikmX+ZftOEmLtR93z8ZMNK7GHmjrv4pZ9BFjdKaaz
         sjkA==
X-Gm-Message-State: AAQBX9e1a8bKfQYPw135oe6Hr6NOBKB1rtgSbdHFFU353ZmlmMoEGjMI
        Nb+SEVkAedqXWGlmuOPC0EsOtJ9camtSTHpAtdE=
X-Google-Smtp-Source: AKy350ZGlnMhrTcj8ggWVDpiiZttcTbM5yc9/n5YlIKY4xLA0FyE8Dzs9supQ62ZYl3Hb+BY3i+mXwNTY/putakI4Us=
X-Received: by 2002:a81:c509:0:b0:52e:e095:d840 with SMTP id
 k9-20020a81c509000000b0052ee095d840mr6288437ywi.0.1680794951046; Thu, 06 Apr
 2023 08:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-7-917ff5bc80a8@asahilina.net> <ZC7T92F7K9XTZPZ1@phenom.ffwll.local>
In-Reply-To: <ZC7T92F7K9XTZPZ1@phenom.ffwll.local>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 6 Apr 2023 17:28:59 +0200
Message-ID: <CANiq72=E2k7+_cwYw_EjVezk0mWCRqbH4MUjsEmxWgJMh=3AEQ@mail.gmail.com>
Subject: Re: [PATCH RFC 07/18] rust: drm: mm: Add DRM MM Range Allocator abstraction
To:     Asahi Lina <lina@asahilina.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 4:15=E2=80=AFPM Daniel Vetter <daniel@ffwll.ch> wrot=
e:
>
> Documentation:
>
> In drm we try to document all the interfaces that drivers use with formal
> docs. Yes there's some areas that are not great for historical reasons,
> but for new stuff and new wrappers we're really trying:
>
> - This helps in telling internal (even across .c files or in rust across
>   modules within a crate) from stuff drivers access. Sure you have static
>   in C or pub in rust, but that doesn't tell you whether it's public all
>   the way to drivers.

I think you may be talking about the value high-level docs here, but
just in case, visibility in Rust is flexible enough to expose (or not)
APIs to those that you need. In other words, it does tell you (and
enforces!) whether it is public all the way to drivers.

There is also the possibility of even more fancy visibility, but so
far we just needed `pub(crate)`.

`rustdoc` also shows/hides things as needed, thus the generated docs
for the crate should only show what is usable by others.

Then there is the `kernel` crate split, too.

> - ideally docs have a short intro section that explains the main concepts
>   and links to the main data structures and functions. Just to give
>   readers a good starting point to explore.

Agreed, this is typically done in Rust in the top-level doc comments
(module or crate). For the Rust side of the kernel, we are definitely
trying to emphasize the quality of the docs, including compile- and
runtime-tested examples.

Regarding linking, `rustdoc` already generates a listing with the
contents of each crate/module even if there is no other docs. So as
long as the short descriptions of the items are good, it may be fairly
readable already, e.g. see
https://rust-for-linux.github.io/docs/rust/kernel/sync/index.html for
an example in our old `rust` branch. But, of course, you can add extra
docs at that level too when there are many things or is unclear what
should be used.

Also note that, sometimes, the docs we write are in the type, rather
than the module, e.g. see the nice examples Wedson wrote for `RBTree`:
https://rust-for-linux.github.io/docs/rust/kernel/rbtree/struct.RBTree.html=
.

> - Linking all the things, so that readers can connect the different parts=
.
>   This is really important in C where e.g. get/put() or any such function
>   pairs all needed to be linked together. With rust I'm hoping that
>   rustdoc liberally sprinkles links already and we don't have to do this
>   as much.

If you mean within doc comments, it does! :) It is called "intra-doc
links". Basically, you just write something in-between square
brackets, and it is able to create the link to the right thing (in
most cases, otherwise you can help it more), e.g.

    /// Returns a new [`Foo`].

And, of course, for the rest of things that aren't inside comments, it
automatically provides links etc.

There has been work on `rustdoc` on getting "Jump to Definition" and
similar features to work on the source view, too.

> - Short explainers for parameters. For rust this also means type
>   parameters, for those even simplified examples of how drivers are
>   supposed to use them would help a lot in reading docs & understanding
>   concepts.

For parameters, we are not forcing to write explanations for every
parameter (as in providing a list), but rather writing what is
actually useful to know (referring to the parameters as needed). So it
depends on a case-by-case.

In any case, in general is clearer what parameters are compared to C,
due to the stronger typing. Of course, if one uses integers
everywhere, it is as confusing as C. But if one has a type, it is
easier to tell, plus one may jump with a click into the explanation of
that type etc.

Regarding examples, 100% agreed. And not only that, the examples are
enforced to be kept up to date by compiling and running them via KUnit
(not yet submitted for mainline, but we have been enforcing it for our
old `rust` branch for a long time).

> - Ideally links from the rust to the sphinx side to linke relevant
>   chapters together. Often the bigger explanations are in .rst files with
>   DOT graphs (kms has a bunch I've added) or similar, and it doesn't make
>   that much sense to duplicate all that on the rust side I guess. But it
>   needs to be discoverable.

Definitely. One next step is having easy-to-write links to the rST
docs. For this, a couple years ago I talked with the `rustdoc`
maintainers about having a "External references map file" feature, so
that we can link rST documents from the Rust docs, including generated
C docs too. For instance, ideally we would be able to use the square
brackets around a C type and have it work:

    /// Exposes the kernel=E2=80=99s [`struct wait_queue_head`] as a condit=
ion variable.

Regarding the bigger explanations: we are trying to keep most of the
docs close to the Rust code where it makes sense, as
module-level/crate-level docs, rather than as rST docs. This has
several benefits, like keeping them closer to the code, the linking
features, having them organized equally as the code, no need to know
whether there is a doc somewhere or not (e.g. if it is, it is near the
code), examples are compiled, etc.

Of course, sometimes longer-form docs and other documents may not make
sense as part of any code in particular, or may be shared across C and
Rust, etc., and there it may more sense to use `Documentation/` files
instead.

But, in general, the idea is that, compared to C, most of the docs go
into the code. To give an idea of the difference: so far, in our old
`rust` branch, we only needed a few documents in `Documentation/`
(e.g. the Quick Start guide etc.), and everything else went into the
code itself.

Cheers,
Miguel
