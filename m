Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99866A9AB0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjCCPbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCCPbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:31:01 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111F0222F9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:30:58 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id 4so1812981ilz.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 07:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677857457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivYNExXn1wG97fVTST3XeNaQklU6TM1KpbQL9nqgRVE=;
        b=TJLnJxUlO9BpWopUmYbnlOcffV0+QgOqT6Lv9TaHngZbMcjv0s6BL+73qf19o9ONE9
         bPV/e8A6Y6fNCKX/9Pyi8yhROr8+Pdp0UruTVmRqpm+h5Ov05rhYcDj4+Spj9vIkPZ5P
         8uUhblNfNQUHuNQSNEU46xh3e488KI0Hgi3AXMCV3HpE8QKs1izLFxwY5MSiT82Ya39B
         ZxtsxbA4ypkU4uudzN27K+O27/i2cEg89VfLNcm5vf2YhPOKh3B3bz6dcx2qAqgvLRWl
         Y5pavR75GxEWLOt13yWlgLrZPEYPp7zT7v5WAx6iOdI8K+/FDRUlSpEOF4dSrtAoTDnU
         LPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677857457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivYNExXn1wG97fVTST3XeNaQklU6TM1KpbQL9nqgRVE=;
        b=TYZQGE75txoDoSf5IFA46BU4tTvytmiRzKQFfolyg8SI+Vq3SmzwDq30ZFK+COhojC
         rEuQ5odTn7fpoAIRYJN4+p52K3sbhD10oSna3UVq/kh2MYHspyXO+bgVvChc4GDClzKs
         FUsi/qDr9+Z4BmIj/elCfKEZl4IeFjHgyZHpWhsP9pnZE6h9TdcV7spvSbShquB1P9tF
         e0sG7fMdF/NP9NrhYjM6cGLvCUUDTzLWryllYRpzB3z8tvngZolQet5IDWmJ7mga370x
         a0RlYPnmsstrtSdZKLb4ItQKZh0n5kKfqvj6j1yFqc/9oGO2wWpX8iYr2kBIzd6/AQXt
         ZVrg==
X-Gm-Message-State: AO0yUKWsd/UpjaUUz9aKgm84OBSKcqX3TOO83JKEs6UfXbhjLrA45dbB
        5E21yuBULjpDljgsdAZJEPU+vovdxN5UO6gQxJtGsA==
X-Google-Smtp-Source: AK7set/WaCpaoe2jC5WxYG9nj+2ggsMdB668GmzsmKzMssQC+JsgfP4rpsFOLdISKiY2FChuUZzix+rTw4ac1+brFnY=
X-Received: by 2002:a92:c5c2:0:b0:315:8de2:2163 with SMTP id
 s2-20020a92c5c2000000b003158de22163mr1034041ilt.5.1677857457256; Fri, 03 Mar
 2023 07:30:57 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV> <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
 <CAHk-=wi11ZbOBdMR5hQDz0x0NNZ9gM-4SxXxK-7R3_yh7e10rQ@mail.gmail.com>
 <ZAD21ZEiB2V9Ttto@ZenIV> <6400fedb.170a0220.ece29.04b8@mx.google.com> <ZAEC3LN6oUe6BKSN@ZenIV>
In-Reply-To: <ZAEC3LN6oUe6BKSN@ZenIV>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 3 Mar 2023 16:30:20 +0100
Message-ID: <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 9:11=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Thu, Mar 02, 2023 at 11:54:03AM -0800, Kees Cook wrote:
> > On Thu, Mar 02, 2023 at 07:19:49PM +0000, Al Viro wrote:
> > > On Thu, Mar 02, 2023 at 11:10:03AM -0800, Linus Torvalds wrote:
> > > > On Thu, Mar 2, 2023 at 11:03=E2=80=AFAM Linus Torvalds
> > > > <torvalds@linux-foundation.org> wrote:
> > > > >
> > > > > It might be best if we actually exposed it as a SLAB_SKIP_ZERO th=
ing,
> > > > > just to make it possible to say - exactly in situations like this=
 -
> > > > > that this particular slab cache has no advantage from pre-zeroing=
.
> > > >
> > > > Actually, maybe it's just as well to keep it per-allocation, and ju=
st
> > > > special-case getname_flags() itself.
> > > >
> > > > We could replace the __getname() there with just a
> > > >
> > > >         kmem_cache_alloc(names_cachep, GFP_KERNEL | __GFP_SKIP_ZERO=
);
> > > >
> > > > we're going to overwrite the beginning of the buffer with the path =
we
> > > > copy from user space, and then we'd have to make people comfortable
> > > > with the fact that even with zero initialization hardening on, the
> > > > space after the filename wouldn't be initialized...
> > >
> > > ACK; same in getname_kernel() and sys_getcwd(), at the very least.
> >
> > FWIW, much earlier analysis suggested opting out these kmem caches:
> >
> >       buffer_head
> >       names_cache
> >       mm_struct
> >       anon_vma
> >       skbuff_head_cache
> >       skbuff_fclone_cache
>
> I would probably add dentry_cache to it; the only subtle part is
> ->d_iname and I'm convinced that explicit "make sure there's a NUL
> at the very end" is enough.

FWIW, a couple of years ago I was looking into implementing the
following scheme for opt-out that I also discussed with Kees:

1. Add a ___GFP_SKIP_ZERO flag that is not intended to be used
explicitly (e.g. disallow passing it to kmalloc(), add a checkpatch.pl
warning). Explicitly passing an opt-out flag to allocation functions
was considered harmful previously:
https://lore.kernel.org/kernel-hardening/20190423083148.GF25106@dhcp22.suse=
.cz/

2. Define new allocation API that will allow opt-out:

  struct page *alloc_pages_uninit(gfp_t gfp, unsigned int order, const
char *key);
  void *kmalloc_uninit(size_t size, gfp_t flags, const char *key);
  void *kmem_cache_alloc_uninit(struct kmem_cache *, gfp_t flags,
const char *key);

, where @key is an arbitrary string that identifies a single
allocation or a group of allocations.

3. Provide a boot-time flag that holds a comma-separated list of
opt-out keys that actually take effect:

  init_on_alloc.skip=3D"xyz-camera-driver,some_big_buffer".

The rationale behind this two-step mechanism is that despite certain
allocations may be appealing opt-out targets for performance reasons,
some vendors may choose to be on the safe side and explicitly list the
allocations that should not be zeroed.

Several possible enhancements include:
1. A SLAB_NOINIT memcache flag that prohibits cache merging and
disables initialization. Because the number of caches is relatively
small, it might be fine to explicitly pass SLAB_NOINIT at cache
creation sites.
Again, if needed, we could only use this flag as a hint that needs to
be acknowledged by a boot-time option.
2. No opt-out for kmalloc() - instead advise users to promote the
anonymous allocations they want to opt-out to memory caches with
SLAB_NOINIT.
3. Provide an emergency brake that completely disables
___GFP_SKIP_ZERO if a major security breach is discovered.

Extending this idea of per-callsite opt-out we could generate unique
keys for every allocation in the kernel (or e.g. group them together
by the caller name) and decide at runtime if we want to opt them out.
But I am not sure anyone would want this level of control in their distro.
