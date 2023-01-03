Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D836965BFCE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbjACMW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjACMWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:22:21 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F5FF017
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 04:22:20 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id n8so20173360oih.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 04:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLTca1gX9g6fgPyk87rTl4KumqmJHjz23Fu2HgF4fpU=;
        b=K7uD8cPJEJdLlIOweJyH+gkLNEn8O96uE77Gcq4itN88ByyVPVGSJJfgm1nzlu0twe
         jSRWv6wMRxv4IW8YvDtr4l9+yth9HpeorflFJlKlHJWCl+cT22u52M1VIZdWnRO5WwDI
         XH9VAyTiSBt0K8/tuYGvBZyRomsEBm/TukHhl+06TKVqOB8A7ZM+A9T/IxdIcojwlW1s
         6ZA/l7VxyITeSUh20A0rKy2mhoei+UH3LqOpO4ArYSK5CNWGkrK7n+lJYipsvkFP+TGI
         TWOs97j5KIGtNn/yROsxIzhC2w0Byyo2EskisOvhkxS+LqZefEw/Bh9qtExy/1JkFVrf
         aM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLTca1gX9g6fgPyk87rTl4KumqmJHjz23Fu2HgF4fpU=;
        b=qvmA48N8dtjmwjTRJ7WrGgFSI06+sP1QZF7h9oUNq5kcLjAtqAqDynAAkV5KH+zUyq
         T6bGPuuNgMETwid0MZKzlpeIna1rzQUxJir8W+LLhAwDOVXHJwT1NFpGoZKdGRmBU9Mi
         TahGRk+exY0k0OmB61uKvyjg+J0kTclrg4zAq7bmc6BQUlZoaPoQQHnY1oLWO4WE9CaP
         0FDZwUSdQR+XbaDcvIU716dTUrlH5JIwqCpXoH4KSmeHRg5p0Ojz1W5DJEZk2w8etY8S
         USZGJab+DGN/NXNjwgH2ywkFWfSgQsN4s9yYf6sKPPAAxrzyIMCpNAOyKn1J2/o4hS16
         m4yw==
X-Gm-Message-State: AFqh2kq6Q+mevmthJCT8TL3qpGGcgddPIGryAGjf+z4d3wQkNNTbzPeo
        jwVgDT5u7VjdIXasqsTnwQQ=
X-Google-Smtp-Source: AMrXdXu1wPBh5LROXTTg8vx1zqhJ9ykghcJIV6qN7Rwpa2uRUhk6ZYwtNvMMbKCt2WyDRezgXDAsDw==
X-Received: by 2002:a05:6808:2082:b0:35e:93bf:a9bb with SMTP id s2-20020a056808208200b0035e93bfa9bbmr33973789oiw.13.1672748540046;
        Tue, 03 Jan 2023 04:22:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j12-20020a9d7f0c000000b00660fe564e12sm14724792otq.58.2023.01.03.04.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 04:22:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Jan 2023 04:22:17 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: Linux 6.2-rc2
Message-ID: <20230103122217.GA190111@roeck-us.net>
References: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
 <20230102225656.GA3532398@roeck-us.net>
 <CAHk-=wjZPPscjDhsHQw_ttHOaQS69rADLm0KuRhbNavBiO62OQ@mail.gmail.com>
 <20230103014535.GA313835@roeck-us.net>
 <CAHk-=whmeBkyu3iS_s-yk0=t3GEoW3sQb-wJFHKykOjG=iQVFw@mail.gmail.com>
 <CAMj1kXHqQoqoys83nEp=Q6oT68+-GpCuMjfnYK9pMy-X_+jjKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHqQoqoys83nEp=Q6oT68+-GpCuMjfnYK9pMy-X_+jjKw@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:58:48AM +0100, Ard Biesheuvel wrote:
> On Tue, 3 Jan 2023 at 03:13, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, Jan 2, 2023 at 5:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > ... and reverting commit 99cb0d917ff indeed fixes the problem.
> >
> > Hmm. My gut feel is that this just exposes some bug in binutils.
> >
> > That said, maybe that commit should not have added its own /DISCARDS/
> > thing, and instead just added that "*(.note.GNU-stack)" to the general
> > /DISCARDS/ thing that is defined by the
> >
> >   #define DISCARDS  ..
> >
> > a little bit later, so that we only end up with one single DISCARD
> > list. Something like this (broken patch on purpose):
> >
> >   --- a/include/asm-generic/vmlinux.lds.h
> >   +++ b/include/asm-generic/vmlinux.lds.h
> >   @@ -897,5 +897,4 @@
> >     */
> >    #define NOTES                                        \
> >   -     /DISCARD/ : { *(.note.GNU-stack) }              \
> >         .notes : AT(ADDR(.notes) - LOAD_OFFSET) {       \
> >                 BOUNDED_SECTION_BY(.note.*, _notes)     \
> >   @@ -1016,4 +1015,5 @@
> >    #define DISCARDS                                     \
> >         /DISCARD/ : {                                   \
> >   +     *(.note.GNU-stack)                              \
> >         EXIT_DISCARDS                                   \
> >         EXIT_CALL                                       \
> >
> > But maybe that DISCARDS macrop ends up being used too late?
> >
> 
> Masahiro's v1 did something like this, and it caused an issue on
> RISC-V, which is why we ended up with this approach instead.
> 
> > It really shouldn't matter, but here we are, with a build problem with
> > some random old binutils on an odd platform..
> >
> 
> AIUI, the way ld.bfd used to combine output sections may also affect
> the /DISCARD/ pseudo-section, and so introducing it much earlier
> results in these discards to be interpreted in a different order.
> 
> The purpose of this change is to prevent .note.GNU-stack from deciding
> the section type of the .notes output section, and so keeping it in
> its own section should be sufficient. E.g.,
> 
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -896,7 +896,7 @@
>   * Otherwise, the type of .notes section would become PROGBITS
> instead of NOTES.
>   */
>  #define NOTES                                                          \
> -       /DISCARD/ : { *(.note.GNU-stack) }                              \
> +       .note.GNU-stack : { *(.note.GNU-stack) }                        \
>         .notes : AT(ADDR(.notes) - LOAD_OFFSET) {                       \
>                 BOUNDED_SECTION_BY(.note.*, _notes)                     \
>         } NOTES_HEADERS                                                 \
> 
> The .note.GNU-stack has zero size, so the result should be the same.

The above fixes the problem for sh.

Guenter
