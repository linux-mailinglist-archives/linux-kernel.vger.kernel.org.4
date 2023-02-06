Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1BC68C8D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBFVcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjBFVcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:32:22 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47325244
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:32:21 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id r8so13624420pls.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 13:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dYd4vw6qa2q3HVSke3k4dJg7B9fv6oKQRTR063eTLyw=;
        b=hhJ+wkCFnD+azG3S7INqkkLNfX14eFFCoW5YHsgdOj35ZK6CZNSK1T3Mb0p3q7QvWf
         JVXK03Z3k68a4nIQI6T0xcR4/AXrm3gHT2qH7rBYRnqy/nHJGyIT7F69bXOjMNh+x9RF
         GRt4ov/yjCibJ3uLuLpkb1TQr6ek4N7Mf+bgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYd4vw6qa2q3HVSke3k4dJg7B9fv6oKQRTR063eTLyw=;
        b=5ow7xeu3cZQAc1qXFkYTbupgPAbZ57PdjY1hEZttFhbzfqqE3eywHTguqWbnUXvsRJ
         iTv7v+BeD4ZVzWjC6NBQ6IwzDMu6ypmX8xsL8xhmY31PCkhpEtvas1o1xkg8ZMrUkpFX
         KgWMdpXIu31t8FmyYyWjFW2sQSvLJcZKG6lT90tiM9LZwgXwDmY4U+9JwZrTfkCbbq8j
         3uZDqRra1nADpbNQBMjY3LQW3TpmBIHEKrIMk1PzoO2SPEG34MjQ1XRgETxUbzguv1fw
         Eo5ffkZ28529FuNgxcdAFPP/4eUZwIIMIyRv0x0kCGbd/l1CJEzTt1I/qGD/KCGPML6/
         zW8A==
X-Gm-Message-State: AO0yUKW2CuJRjNeV6BBoSeceqtuTtTAP7HbWS9/CYrIUsGWm4eKnAEn/
        UAMhuZ8O8T9iuDVphf32s4nakg==
X-Google-Smtp-Source: AK7set+16Qy8Kuyq7Pi7eKziEtbtp+kKoyIjtGO7Y1tNxSLjjR96/4kzFu2ZPCBxcW3hcRCsOLoj/w==
X-Received: by 2002:a17:90b:4c0c:b0:230:a3ef:b334 with SMTP id na12-20020a17090b4c0c00b00230a3efb334mr1420106pjb.0.1675719141284;
        Mon, 06 Feb 2023 13:32:21 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i64-20020a639d43000000b0044ed37dbca8sm6591357pgd.2.2023.02.06.13.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:32:20 -0800 (PST)
Message-ID: <63e171e4.630a0220.b52f4.b63f@mx.google.com>
X-Google-Original-Message-ID: <202302061331.@keescook>
Date:   Mon, 6 Feb 2023 13:32:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Aleksa Sarai <cyphar@cyphar.com>,
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
 <CAMuHMdXXSwYYoUMskhcgjF9SVjraZC-UsBT3sN+xkcUAYmJj4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXXSwYYoUMskhcgjF9SVjraZC-UsBT3sN+xkcUAYmJj4Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 09:03:19PM +0100, Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Fri, Feb 3, 2023 at 10:23 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Feb 3, 2023, at 20:35, Kees Cook wrote:
> > > --- a/include/linux/uaccess.h
> > > +++ b/include/linux/uaccess.h
> > > @@ -329,6 +329,10 @@ copy_struct_from_user(void *dst, size_t ksize,
> > > const void __user *src,
> > >       size_t size = min(ksize, usize);
> > >       size_t rest = max(ksize, usize) - size;
> > >
> > > +     /* Double check if ksize is larger than a known object size. */
> > > +     if (WARN_ON_ONCE(ksize > __builtin_object_size(dst, 1)))
> > > +             return -E2BIG;
> > > +
> >
> > WARN_ON_ONCE() may be a little expensive since that adds two
> > comparisons and a static variable to each copy, but it's probably
> > fine.
> 
> When seeing this, I was a bit worried about the size increase.
> Hence I gave it a try on atari_defconfig and ran bloat-o-meter.
> Surprisingly, there was no size increase at all, as all checks
> were optimized away.
> 
> Hence perhaps this can become a compile-time check?

Normally it should optimize away, yes.

-- 
Kees Cook
