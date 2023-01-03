Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFD965B945
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 03:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbjACCNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 21:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjACCNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 21:13:32 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB750FC5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 18:13:27 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z12so23642493qtv.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 18:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=afjfLO4eESs57C5GGtx6gjr0hpfsG3j/EHodbPT/rRk=;
        b=CZpEnWZjTCTBTc+oWXEaS9fuWCd5GGIRIIZgZzBPuE85RcKOnevkhvinef4ZkgMNQP
         JB+U2pkJAZPEjtlX1u1xfq16i5L7YajW6N5+ivq7WiCOPP1AteWZA5oi167HAJQ5rKdi
         b7wbg9khhdz9DjSfh/jpQ0Je6U4ZIj2mzpybw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afjfLO4eESs57C5GGtx6gjr0hpfsG3j/EHodbPT/rRk=;
        b=MlUJl7IJ6B+fNqbMri09H8u7EDTCp5BC5nNfXjKqK1krLF5ipcHzArazG1PSTK0s2N
         5dpDYJyZYTThJC/29wuz3p0fZaUQVNyscWbKEq/NwBtuOecJcMnWah9ZpxZKfRjE6jdh
         TQGEeOoe0MS8/Nbp9pdyGcybHkXocTNlEfin2W7F1pRC5jco7t9XPORkIiZL+6/ioZY6
         SoC5D8EAykG9uKmEbCPRUYgE8o2lJbGO+HMzd6PkmGekNvjcT4cbJv3Z/5NPHjUiQXBt
         ZQB86VephFgA1choRDRmCt0tChyr4hkQWPyLesI847NpXzMFWXpTOHby7oKJeZCcxup5
         j31w==
X-Gm-Message-State: AFqh2kpzRfYTc6F1YW7sf853xSdONPWhag8u1+R8DUYOVbHDnJ7IReen
        TE1B2bC0pzb2a3KZ/WMMlqLrCiye1cfZ5lHS
X-Google-Smtp-Source: AMrXdXu5nhVcNIIGcwJHUv0HZrbeJFwVu4rqF4LEZxwkv92rQIGTXdEjiUz+gbMuXjZYtpjCc+zgZg==
X-Received: by 2002:a05:622a:244e:b0:3a5:17f0:e718 with SMTP id bl14-20020a05622a244e00b003a517f0e718mr58761024qtb.14.1672712006588;
        Mon, 02 Jan 2023 18:13:26 -0800 (PST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id dm2-20020a05620a1d4200b006bbc3724affsm21087580qkb.45.2023.01.02.18.13.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 18:13:26 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id g7so23650421qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 18:13:25 -0800 (PST)
X-Received: by 2002:ac8:71da:0:b0:3a9:80b6:4ca0 with SMTP id
 i26-20020ac871da000000b003a980b64ca0mr1632297qtp.304.1672712005420; Mon, 02
 Jan 2023 18:13:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
 <20230102225656.GA3532398@roeck-us.net> <CAHk-=wjZPPscjDhsHQw_ttHOaQS69rADLm0KuRhbNavBiO62OQ@mail.gmail.com>
 <20230103014535.GA313835@roeck-us.net>
In-Reply-To: <20230103014535.GA313835@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jan 2023 18:13:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmeBkyu3iS_s-yk0=t3GEoW3sQb-wJFHKykOjG=iQVFw@mail.gmail.com>
Message-ID: <CAHk-=whmeBkyu3iS_s-yk0=t3GEoW3sQb-wJFHKykOjG=iQVFw@mail.gmail.com>
Subject: Re: Linux 6.2-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 2, 2023 at 5:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> ... and reverting commit 99cb0d917ff indeed fixes the problem.

Hmm. My gut feel is that this just exposes some bug in binutils.

That said, maybe that commit should not have added its own /DISCARDS/
thing, and instead just added that "*(.note.GNU-stack)" to the general
/DISCARDS/ thing that is defined by the

  #define DISCARDS  ..

a little bit later, so that we only end up with one single DISCARD
list. Something like this (broken patch on purpose):

  --- a/include/asm-generic/vmlinux.lds.h
  +++ b/include/asm-generic/vmlinux.lds.h
  @@ -897,5 +897,4 @@
    */
   #define NOTES                                        \
  -     /DISCARD/ : { *(.note.GNU-stack) }              \
        .notes : AT(ADDR(.notes) - LOAD_OFFSET) {       \
                BOUNDED_SECTION_BY(.note.*, _notes)     \
  @@ -1016,4 +1015,5 @@
   #define DISCARDS                                     \
        /DISCARD/ : {                                   \
  +     *(.note.GNU-stack)                              \
        EXIT_DISCARDS                                   \
        EXIT_CALL                                       \

But maybe that DISCARDS macrop ends up being used too late?

It really shouldn't matter, but here we are, with a build problem with
some random old binutils on an odd platform..

             Linus
