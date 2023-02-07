Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DBB68E468
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 00:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjBGX21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 18:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBGX20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 18:28:26 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3067413D6E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 15:28:25 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z1so17350252plg.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 15:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4+8WAA131sPVyHda3AYJx6Yaup4uoSfYs/I9EU6qRnM=;
        b=C3UE+oMEeLowc9vopV7fBId2LhF4UNAmnkF2U9YKW5w3o+WjBrDt9BYy7EXMRoBI4S
         Yb/fLAkDqXHvvwkB8ajSE9PkstANJNn6wCyK7bBdtRwJy6aujwxJXYk85VFZhtTZDO0S
         0yStOd7tl4Cc2GCZvAQD0T1pD+Dnpf+rBBTgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+8WAA131sPVyHda3AYJx6Yaup4uoSfYs/I9EU6qRnM=;
        b=lqui/q1ZcX/bgEe0wbsjT0X6R0H9ubrq0NHZCu4uVZmLf6MRhFiugYdBW2X1+N7iDF
         O2ObHaigL78jXl0ZaCXXjUiLySnb6tgQ79JPeandd6QD9shP3Uk+wjqq/RrsAajEFpRk
         z8CSNjJFjAMJKZbw0FZJKUed06AtUaxynNQa5xUyor/Sv6IMMs4UKTOZQ+vr78tnv/dl
         QXcw4+W0DdnhV4U5zxpkl405ej2hrpteU8WsQNqabxVqBc8Ot0R2RCQcMCuOgHxj/MVJ
         8Rh5JeTJcfGIaHiGwn5lMVoD444KLKjtqzVC5HSLdtzqBPK0YvV79joSpd937QdoPufa
         NIsQ==
X-Gm-Message-State: AO0yUKVU7HYblrN0VEyZ+QGjlPPuvgNWbQ1daAxtGGA15rIi32wM+sud
        SZy/1YeKeeszitDU5LuxJL1t1g==
X-Google-Smtp-Source: AK7set9ftfCJ+EgyXvapWeDdPNZB0dv1AdhWExLmm3Sb3A3nQLQ2tJwETOb4s9O+kUWH5deIaD5UCg==
X-Received: by 2002:a17:90b:3890:b0:22c:322a:12fc with SMTP id mu16-20020a17090b389000b0022c322a12fcmr5789854pjb.32.1675812504659;
        Tue, 07 Feb 2023 15:28:24 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e35-20020a17090a6fa600b002265ddfc13esm81854pjk.29.2023.02.07.15.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:28:24 -0800 (PST)
Message-ID: <63e2de98.170a0220.81eb8.02cb@mx.google.com>
X-Google-Original-Message-ID: <202302071525.@keescook>
Date:   Tue, 7 Feb 2023 15:28:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yann Droneaud <ydroneaud@ouvaton.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] uaccess: Add minimum bounds check on kernel buffer size
References: <20230203193523.never.667-kees@kernel.org>
 <6c728dfc-d777-4beb-b463-649704c81a5e@app.fastmail.com>
 <CAMuHMdXXSwYYoUMskhcgjF9SVjraZC-UsBT3sN+xkcUAYmJj4Q-2143@mail.gmail.com>
 <9f549c7b-bc72-8037-abfc-fe2f146ff82c@ouvaton.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f549c7b-bc72-8037-abfc-fe2f146ff82c@ouvaton.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 10:06:14AM +0100, Yann Droneaud wrote:
> Hi,
> 
> Le 06/02/2023 à 21:03, Geert Uytterhoeven a écrit :
> 
> > Hi Arnd,
> > 
> > On Fri, Feb 3, 2023 at 10:23 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Fri, Feb 3, 2023, at 20:35, Kees Cook wrote:
> > > > --- a/include/linux/uaccess.h
> > > > +++ b/include/linux/uaccess.h
> > > > @@ -329,6 +329,10 @@ copy_struct_from_user(void *dst, size_t ksize,
> > > > const void __user *src,
> > > >        size_t size = min(ksize, usize);
> > > >        size_t rest = max(ksize, usize) - size;
> > > > 
> > > > +     /* Double check if ksize is larger than a known object size. */
> > > > +     if (WARN_ON_ONCE(ksize > __builtin_object_size(dst, 1)))
> > > > +             return -E2BIG;
> > > > +
> > > WARN_ON_ONCE() may be a little expensive since that adds two
> > > comparisons and a static variable to each copy, but it's probably
> > > fine.
> > When seeing this, I was a bit worried about the size increase.
> > Hence I gave it a try on atari_defconfig and ran bloat-o-meter.
> > Surprisingly, there was no size increase at all, as all checks
> > were optimized away.
> > 
> > Hence perhaps this can become a compile-time check?
> 
> It should be a compile-time check, because one would not want __builtin_object_size(dst, 1) to return -1 if dst' size is not known at compile-time.

Note that it's size_t, so it's actually SIZE_MAX, which is why these
tests will vanish most of the time. i.e. it cannot ever be possible for
the SIZE_MAX case so the entire test is elided.

And when ksize is known at compile time and __bos is not SIZE_MAX, the
result is also known to be either always true or always false, etc.

What's nice here is that when ksize is only run-time known and the buffer
size is compile-time known, we'll keep the test.

-- 
Kees Cook
