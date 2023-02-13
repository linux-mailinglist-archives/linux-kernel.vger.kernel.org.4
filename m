Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED6A693B93
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBMBGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBMBGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:06:52 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F9793D9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:06:51 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id l3so12990875ljo.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H0tOTl0q9G0IbiCA8ynYG2VbbtfPCnSoMkBJxv+VPkk=;
        b=p3p2+yunSP8zag+A7hM/kfSUJ/nuLfcHj3C8enkMjTrcEkQa8I+P30KMtdIFGcCrNo
         N0J00ZnsL7ZlkXDPPsYaVZ4yyNE2KIYZTcJMtoTWIRdv0wwBLJ5ZwvGSV6GHRUvFmTDE
         L2s+/QaxWKHYytRh/zl8+RZhiZzh6JjD5u+R1DR+4M0ygpmzc9wgFoCvWYeMaUfC/jpG
         NhTYtvIG6jiKG1AkRIkCV7o+ADzT6rKGNPFPhxJ3lIj1QoCk90XNj/AhOqDLiXM6xTOV
         4yr2UvHSbc3ypeAexc3TxFo4hQaqWmk3iULCk6yKlIbPVJR77tWdS/QLbUUEIA6qB/nB
         Kt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0tOTl0q9G0IbiCA8ynYG2VbbtfPCnSoMkBJxv+VPkk=;
        b=YeXyoHOCo9Q7cuVI4wfhCWoOu1C5olcCYgUyNT5CaFRVXjyvnzrge7sFVm56urb/22
         eE260uImf0Ys3oC46j03V5IQZlGChUpXUvVxoUkJD31gN0rZEnNCh1c8iMgHW2muhqEQ
         ZRyGVNAqmzEHgodV2RJ7EfDgWnwm4RKSkpaSu4buT3PhR82E7Isdzz79SLQS/deCyKY9
         5X/M5lJNVYsLLcNxVVPROcxEeifWgjk3J1W0BTTaE5D1ae5JXyjchByOYoKRzdEVd6zS
         RWLsZhB30PwQnQUqKJ0gCX+CNLCiwOi1+WtfDBiNtgwKmq2JnjbeMVvThzOwAkyXX+gh
         Y0DA==
X-Gm-Message-State: AO0yUKUyBwBhWKGjqn4Yet4qOAnC9LjV+GniMHP/jkoUaORBgdFZPHff
        Rjr9R4hbgluHjrbtePIyXzZuZYYBkJMl7LaisTM7fsgZ50k=
X-Google-Smtp-Source: AK7set8XpcGjgfMefDDmmIZk31WrVPckHl8M/dQUPlwxVExbl3UjUkOEDjEYckTydZ8xIhxrGgA4G3OZeMgWRkXjBlA=
X-Received: by 2002:a2e:8457:0:b0:293:5147:d811 with SMTP id
 u23-20020a2e8457000000b002935147d811mr50919ljh.132.1676250410037; Sun, 12 Feb
 2023 17:06:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675907639.git.chenfeiyang@loongson.cn> <f60027664200d6d1f0ed6c7b87915a223afb982f.1675907639.git.chenfeiyang@loongson.cn>
 <Y+lWQC3XU3xWqEi2@1wt.eu>
In-Reply-To: <Y+lWQC3XU3xWqEi2@1wt.eu>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Mon, 13 Feb 2023 09:06:36 +0800
Message-ID: <CACWXhK=FKV=CppZnHtO3x33GhJgMQ8gmcgxp_Hn-bo7YcxRrnQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] tools/nolibc: Add statx() and make stat() rely on
 statx() if necessary
To:     Willy Tarreau <w@1wt.eu>
Cc:     paulmck@kernel.org, Feiyang Chen <chenfeiyang@loongson.cn>,
        arnd@arndb.de, chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vincent Dagonneau <v@vda.io>
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

On Mon, 13 Feb 2023 at 05:12, Willy Tarreau <w@1wt.eu> wrote:
>
> Hi Feiyang,
>
> On Thu, Feb 09, 2023 at 11:24:13AM +0800, chris.chenfeiyang@gmail.com wrote:
> > From: Feiyang Chen <chenfeiyang@loongson.cn>
> >
> > LoongArch and RISC-V 32-bit only have statx(). ARC, Hexagon, Nios2 and
> > OpenRISC have statx() and stat64() but not stat() or newstat(). Add
> > statx() and make stat() rely on statx() if necessary to make them happy.
> > We may just use statx() for all architectures in the future.
> >
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > ---
> >  tools/include/nolibc/sys.h | 56 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >
> > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > index c4818a9c8823..70c30d457952 100644
> > --- a/tools/include/nolibc/sys.h
> > +++ b/tools/include/nolibc/sys.h
> > @@ -20,6 +20,7 @@
> >  #include <linux/time.h>
> >  #include <linux/auxvec.h>
> >  #include <linux/fcntl.h> // for O_* and AT_*
> > +#include <linux/stat.h>  // for statx()
>
> This one causes build warnings on all archs but x86_64:
>
>   /f/tc/nolibc/gcc-11.3.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc -Os -fno-ident -fno-asynchronous-unwind-tables  -s -o nolibc-test \
>     -nostdlib -static -Isysroot/arm64/include nolibc-test.c -lgcc
>   In file included from sysroot/arm64/include/sys.h:23,
>                    from sysroot/arm64/include/nolibc.h:99,
>                    from sysroot/arm64/include/errno.h:26,
>                    from sysroot/arm64/include/stdio.h:14,
>                    from nolibc-test.c:15:
>   sysroot/arm64/include/linux/stat.h:9: warning: "S_IFMT" redefined
>       9 | #define S_IFMT  00170000
>         |
>   In file included from sysroot/arm64/include/nolibc.h:98,
>                    from sysroot/arm64/include/errno.h:26,
>                    from sysroot/arm64/include/stdio.h:14,
>                    from nolibc-test.c:15:
>   sysroot/arm64/include/types.h:27: note: this is the location of the previous definition
>
> This is caused by the definitions for S_IF* and S_IS* in types.h. However
> if I remove them I'm seeing x86_64 fail on S_IFCHR not defined. The root
> cause is that the x86_64 toolchain falls back to /usr/include for the
> include_next <limits.h> that others do not do (probably that when built
> it thought it was a native compiler instead of a cross-compiler). I'm
> apparently able to work around this by ifdefing out the definitions but
> it makes me feel like I'm hiding the dust under the carpet. Instead I'm
> thinking of reusing Vincent's work who added stdint and the definitions
> for the various INT*MAX values that are normally found in limits.h and
> providing our own limits.h so that this issue is globally addressed.
>
> I'm going to experiment a little bit about this and will propose something
> once I'm satisfied with a solution that we can queue for 6.4. Most likely
> it will involve merging a variant of Vincent's series first, a few changes
> to have limits.h then your series.
>

Hi, Willy,

OK. Thank you very much!

Thanks,
Feiyang

> Best regards,
> Willy
