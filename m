Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5CF73BF12
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 21:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjFWTsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 15:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFWTsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 15:48:02 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B92718
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 12:48:00 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-780cf728871so34628939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 12:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687549680; x=1690141680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XiHMDt9a0vZFZqqLFTPy1WN3O//4H6Ym390HyP9S5gg=;
        b=gguTBiWjlks1o5/ci+EVTzE+o2vm3j3U1xB4cY/UDTRIDl80TJnd13Fy+ZpYo4CAaf
         X3bXnmzGXUz3hzNA0SaHIa3JYCS6M/Aww9Rx/OznjzAxXU7JAvaGzIPsGKBwkrJocyLv
         WvMFMlwKU7B6Tj0LJ5aeRHA2nrTQCGsoVtm9893kYJbQT3bLpO3oIQkG+DBVrVWzQe3f
         nq+4oN++5Db+hAfSod1ipx4P46OgDcKq5sWeq/vj5W/yp6Jz735AIoF1zgTNullhoLL9
         JSx8rS7kOZ7Mjvb9lOjVBhgWBXe8nym0SSLvnGboXVqKwWjOtjk00SSB6WB3jhDcMVOB
         bKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687549680; x=1690141680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiHMDt9a0vZFZqqLFTPy1WN3O//4H6Ym390HyP9S5gg=;
        b=VFa5rZuyVIfXsdmmj2ElurhOc2ZSYveqMm59fGJsQvCfHOU4JIh/8rK3yClUN4kyGD
         7ISxCKqaTHsq3/EbO+WC6Ntma8c3WUmjWP8X8a2v7A8Sisyh5a44eixGBjpLQkF8K3GA
         wY3uAT68nOHvaIMGT8ipDuHRWh1zR0fn9N4idX0g8j14CCAQuVx9jI1Mh48d+JXg3yZn
         +RzDy2ji6M0PjV2JVdM5whujlMRJYsrsNYizEamp5Fpup565Fa9/H61knwfhfDdSARQ8
         GIPLW3BJ68eUHo/hVLkL29GJIdX7byR9VvgvWu9fj5pLEOJE8MFajgf1sIWg06W3cESg
         bIrA==
X-Gm-Message-State: AC+VfDxVP7Plu/PzzdKjfuot6d0fGDxpZlIcMvHtRIHNuUtRbZGA9yyl
        UID07HnLkJUIIBdPXoaEZ6DsB52dtUz7VQ==
X-Google-Smtp-Source: ACHHUZ5s5aK+lyhiFMqR5LYCmxjXsAw6m3uvXmzJp/XlkaFYX6LjznsaztHMkgoUaoVPE+YaGLPENw==
X-Received: by 2002:a5e:8909:0:b0:777:b6cd:5a93 with SMTP id k9-20020a5e8909000000b00777b6cd5a93mr21079722ioj.2.1687549679496;
        Fri, 23 Jun 2023 12:47:59 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id d8-20020a056602184800b007791e286fdbsm29046ioi.21.2023.06.23.12.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 12:47:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 23 Jun 2023 09:47:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: arm32 build warnings in workqueue.c
Message-ID: <ZJX27JDyrgvdeCe4@slm.duckdns.org>
References: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
 <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jun 23, 2023 at 11:24:16AM -0700, Linus Torvalds wrote:
...
>   enum {
>         [..]
>         WORK_STRUCT_FLAG_BITS   = WORK_STRUCT_COLOR_SHIFT +
>                 WORK_STRUCT_COLOR_BITS,
>         [..]
>         WORK_STRUCT_FLAG_MASK   = (1UL << WORK_STRUCT_FLAG_BITS) - 1,
>         WORK_STRUCT_WQ_DATA_MASK = ~WORK_STRUCT_FLAG_MASK,
>   }
> 
> and while the above is absolutely disgusting and the type is not very
> well defined, an enum type should be wide enough to contain all the
> values of the enum. It should all default to 'int', but gcc has some
> extensions.

What gcc used to do was determining the type for each enum entry in a way
that avoids surprises with sign extensions.

* If the initializer is signed, it just uses the smallest fitting integer
  type. e.g. Even if the initializer is -1LL, it'd just be an int as the
  negative range fits within int's range.

* If the intializer is unsigned. The size promotion rules are a bit tricky
  but the compiler makes sure that it doesn't end up in a situation where an
  unsigned initialized enums are sign extended through arithmetic type
  promotions.

Here are results from clang 17.0.0 which I believe shows the same behavior
as older gcc's demonstrating how the types actually end up. The '-'s are
initialized with -1 or -1[L]U accordingly (source code at the end). TOGETHER
is them being defined in the same enum while SEPARATE is each enum in its
own enum block.

 TOGETHER S32+ S32- U32+ U32- S64+ S64- U64+ U64-
  sizeof:    4    4    4    8    4    4    4    8
  signed:         1         0         1         1

 SEPARATE S32+ S32- U32+ U32- S64+ S64- U64+ U64-
  sizeof:    4    4    4    4    4    4    4    8
  signed:         1         0         1         0

So, while it is a bit difficult to tell what exact type you'd end up with
(especially with the U64- but that also generates a warning indicating that
the enum initailizer is beyond max range), these shouldn't cause correctness
issues, although the fact that U32 with the highest bit set gets promoted to
the larger size when declared together is rather unfortunate and it's kidna
mysterious why that'd differ when each enum is defined separately.

gcc-13 dropped this behavior and uses the same widest type needed for the
entire enum definition block.

 TOGETHER S32+ S32- U32+ U32- S64+ S64- U64+ U64-
  sizeof:   16   16   16   16   16   16   16   16
  signed:         1         0         1         0  (IGNORE)

 SEPARATE S32+ S32- U32+ U32- S64+ S64- U64+ U64-
  sizeof:    4    4    4    4    4    4    4    8
  signed:         1         0         1         0

Because everything got pushed to 128bit for TOGETHER, the signed result
doesn't indicate anything, so please ignore that line.

Anyways, yeah, it's not great but it shouldn't cause correctness problems.
While the sizes can be difficult to expect, the signedness does get
respected.

> I think the whole 'type of an enum' is not only a very very bad thing
> to rely on, I think it's something that C23 ends up codifying new
> rules for. It may be why gcc started complaining now.

The behavior change in gcc-13 is fine on its own but it's frustrating
because there's no way to obtain previous behavior - ie. it can be
challenging to please both gcc-12 and gcc-13 with the same code when enums
are used this way.

> Anyway, that code absolutely has to be fixed. Using enums for types is
> wrong, wrong, wrong. You should consider an enum to be a weakly typed
> integer expression with some specific advantages (the automatic
> incrementing at definition time, and the compiler being able to limit
> ranges in switch() statements and maybe doing limited type warnings
> elsewhere)

The only benefit I care about is it being visible in the type system and
thus in debug info whether that's the usual one or BTF. This makes a huge
difference in tracing, monitoring and debugging. For one off's, it's fine to
track down the define values. For something more sophisticated (e.g.
non-trivial drgn, bcc and other BPF programs), the macro constants are a
source of sadness and a really dumb and insidious one.

I don't know why ppl didn't just add explicit types to enums or the size
promotion rules are like that, but we have to trade off between trivial
visibility and i-dont-know-how-big-this-is. It is really dumb but it is what
it is.

> Any time you think it has a specific type size, you're setting
> yourself up for pain and suffering. Gcc is right to warn when we do
> odd arithmetic with it and rely on the width of the result.
> 
> So I really think that code needs fixing, and the gcc warning was very valid.
> 
> Maybe something like the attached. Does this fix the gcc warning?
> Tejun, comments?

So, this is where I'm currently at. Given the circumstances, I don't think
we can get uniform or pretty. If we can enum our way, we should. If not,
macros. That means that we'll sometimes have to bother about these compiler
warnings and other issues and spend energy on them. One thing that's
positive is that this shouldn't lead to correctness problems. Does this make
sense to you?

For this particular case, some of the initializer values have highest bit
set, so gcc-13 must have pushed all of them to 64bit and then generated
warnings when we asked it to downcast it to a pointer.

> +/* Convenience constants - of type 'unsigned long', not 'enum'! */
> +#define WORK_OFFQ_CANCELING	(1ul << __WORK_OFFQ_CANCELING)
> +#define WORK_OFFQ_POOL_NONE	((1ul << WORK_OFFQ_POOL_BITS) - 1)
> +#define WORK_STRUCT_NO_POOL	(WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT)
> +
> +#define WORK_STRUCT_FLAG_MASK    ((1ul << WORK_STRUCT_FLAG_BITS) - 1)
> +#define WORK_STRUCT_WQ_DATA_MASK (~WORK_STRUCT_FLAG_MASK)

So, yeah, as we have the "source" values in enums, this works for both
purposes. It's not difficult to recalculate these values from outside from
the source values and we get to specify the exact type internally. I'd be
happy to route it through the workqueue tree w/ patch-originally-from if
that's okay with you.

Thanks.

-- 
tejun
