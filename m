Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35FE69A8CA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBQKB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQKBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:01:54 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8389A30B18
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:01:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id j5so741599pjz.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8t7WQSrgRYnzbMUfpx5jhJTpcbpl8qDHziyJ4Fw+Sg=;
        b=q70CP/QFgs6PEqGyKgfVEA31Yu5EVz0lkM7E0OfzfZRNasH/nYKuY8/S01CCtQVTEY
         Z86AYmsAYeqWkmLWlk+ky0Vh7fhXFFsD1WXJCYoxoKNsWDa/9rnsuvdtGgjFi7F23mTA
         7oHoOonf9TnLsij+/1GfNIY7m62MRHlwjNPpufMKT28geomKXPPjCfk1GBBXom1w5Jdg
         m5nHQgRVtoATOcImH8OMOrGxtjv/yehFcdEVy1GY8sqcfqrflK8cauK03L76LhX8lR6V
         RAqzkvFUX/EE40Loo7UgwATVBfiUZWSGBSZIgqja2U0PJVCmKyNdRk5keXByOsaL0ywK
         FuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8t7WQSrgRYnzbMUfpx5jhJTpcbpl8qDHziyJ4Fw+Sg=;
        b=z6ONp7iah/DHKp2+JvBFevM3krRh5I5KgH33k07NxffV6Ux9LX1QcRat2fBwRufcXk
         qhF/IbebcEXokWpH17G4eC866X2N35NVO/XHdcKwz03lOtMiNmR6ishzxya2b7QfzjVt
         0b+fd9pC4Z5aHaOrXUJEjhC4sSIsZM5q0ZHZq54i3QELVGDRH6cWWifCmzWKhlG9NHOj
         fUcvbcMGl0rf3IX5XJfdCZFauP25SU0kTVKA4hScF4rmlq9BNPdUn/KjedltDP/bJv13
         5sYTvSJ7Y02Dau7W18NGS2cCyKPn8MAwCQ4vgGmks7nbXDMGU8nY02gJxfin3rPly5lJ
         q0jA==
X-Gm-Message-State: AO0yUKVjgZdVhlJSHvZJzHecUubRSLcc8qVp5J30nsFxj36aZFcYAqG4
        r/S+s2kyg1v8KJM8fimnHAtUzXi2YXB0zejDR14=
X-Google-Smtp-Source: AK7set941QTkqCm3TFzslREr98zlAXZMgvgCqNHyiGIY5qIz8+bgoLo/EMT4lkKeBddDOxdAlC1IMmZZ+3RekZkEKW8=
X-Received: by 2002:a17:90b:1f8f:b0:233:3c5a:b41b with SMTP id
 so15-20020a17090b1f8f00b002333c5ab41bmr1381346pjb.133.1676628112015; Fri, 17
 Feb 2023 02:01:52 -0800 (PST)
MIME-Version: 1.0
References: <20230214103030.1051950-1-arnd@kernel.org> <20230214114014.4ce0afb658fae97d81f32925@linux-foundation.org>
In-Reply-To: <20230214114014.4ce0afb658fae97d81f32925@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 17 Feb 2023 11:01:41 +0100
Message-ID: <CA+fCnZebcevCZModJKRAVM_-WL0o_C+ooVxNpZtw+-Bwu3GMRA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] maple_tree: reduce stack usage with gcc-9 and earlier
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Vernon Yang <vernon2gm@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 8:40 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 14 Feb 2023 11:30:24 +0100 Arnd Bergmann <arnd@kernel.org> wrote:
>
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > gcc-10 changed the way inlining works to be less aggressive, but
> > older versions run into an oversized stack frame warning whenever
> > CONFIG_KASAN_STACK is enabled, as that forces variables from
> > inlined callees to be non-overlapping:
> >
> > lib/maple_tree.c: In function 'mas_wr_bnode':
> > lib/maple_tree.c:4320:1: error: the frame size of 1424 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> >
> > Change the annotations on mas_store_b_node() and mas_commit_b_node()
> > to explicitly forbid inlining in this configuration, which is
> > the same behavior that newer versions already have.
> >
> > ...
> >
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -146,6 +146,13 @@ struct maple_subtree_state {
> >       struct maple_big_node *bn;
> >  };
> >
> > +#ifdef CONFIG_KASAN_STACK
> > +/* Prevent mas_wr_bnode() from exceeding the stack frame limit */
> > +#define noinline_for_kasan noinline_for_stack
> > +#else
> > +#define noinline_for_kasan inline
> > +#endif
>
> Should noinline_for_kasan be defined in kasan.h?  maple_tree.c is
> unlikely to be the only place in the kernel which could use this
> treatment?

We could also define it in include/linux/compiler_types.h along with
other KASAN attributes.
