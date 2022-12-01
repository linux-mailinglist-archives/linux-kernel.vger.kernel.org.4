Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C1E63F60C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiLARPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiLARPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:15:42 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54532AFCF5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:15:36 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id jn7so2221676plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIINIHGhGskcMDqmUFFXNmVZPREPkJD5rw4zIRk+6sQ=;
        b=lX7ncvUzSC9rS2ZdVzvSVXdSjYS0XfkOJUpUDqM9m1MziQwQ+9qm+151brYvHnWkOo
         FgANLgqlGG/z5WgU/eqZH7t6i4HEXTREHuZ76s9iSD6WuDoDYQ9MIb/9FB99Uo1dHdPm
         I1pD+By6iGuvWEmYvkWzU2tygVfKpSYoBbn4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIINIHGhGskcMDqmUFFXNmVZPREPkJD5rw4zIRk+6sQ=;
        b=NsjW5qGXEomucFLEgF+XupbjQ4ENlLtVcyHJPqwx9dDU6D7U75VEYms5vJQlk7u1Qj
         1u2rUZP1cEmc6iKHx6R6puZKMhaZ8moUylrw3U41xQv3Z+BQIxqKcUQZYt9xAbQUr8Z6
         q4Q13bZrSBFuI5aJOyakrBJoX8KeE+p36tXg4tWeGbdD75pklKcmMZB14n4L9UJETLdQ
         qMd2Ge9gvJl5/soS2Pt83u4Cyt6VYvSXoELNBpwzpMFL+wzw/YpRGHm427aoWlKw1+sF
         ZIPC4rvnGgY0nOiw5iR+vyYEnunBRkaFQJCDqT4PCsdppQAOkhwRWlUicohGNVsbnIVr
         pwRw==
X-Gm-Message-State: ANoB5pmabhUHZNSTo0LWCtlNHg2F1bDrii8N+zJqLlds/adFxXwVHanH
        U/UybN6IXmuQ3haudJGFZv5P6w==
X-Google-Smtp-Source: AA0mqf7hLOuoteAV7+avN4qvvGgVHF7ekfjG+aG+RXbz2yEIxrPB3hTqariDmAhhNwmKDWq0XzzGcg==
X-Received: by 2002:a17:90b:3e8b:b0:1fb:825c:af8a with SMTP id rj11-20020a17090b3e8b00b001fb825caf8amr31770278pjb.104.1669914935787;
        Thu, 01 Dec 2022 09:15:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902a51400b001894dc5fdf2sm3850559plq.296.2022.12.01.09.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:15:34 -0800 (PST)
Date:   Thu, 1 Dec 2022 09:15:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Conor.Dooley" <conor.dooley@microchip.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 0/6] slab: Provide full coverage for __alloc_size
 attribute
Message-ID: <202212010915.ADB7D298@keescook>
References: <20221101222520.never.109-kees@kernel.org>
 <Y4X6AHdMZcxvFnDP@wendy>
 <63ced4a4-33b9-4c03-8d7a-987ceb1fc2c7@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63ced4a4-33b9-4c03-8d7a-987ceb1fc2c7@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 01:33:03PM +0100, Arnd Bergmann wrote:
> On Tue, Nov 29, 2022, at 13:24, Conor Dooley wrote:
> > On Tue, Nov 01, 2022 at 03:33:08PM -0700, Kees Cook wrote:
> >> Hi,
> >> 
> >> This is a series to work around a deficiency in GCC (>=11) and Clang
> >> (<16) where the __alloc_size attribute does not apply to inlines. :(
> >> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96503
> >> 
> >> This manifests as reduced overflow detection coverage for many allocation
> >> sites under CONFIG_FORTIFY_SOURCE=y, where the allocation size was
> >> not actually being propagated to __builtin_dynamic_object_size(). In
> >> addition to working around the issue, expand use of __alloc_size (and
> >> __realloc_size) to more places and provide KUnit tests to validate all
> >> the covered allocator APIs.
> >
> > Hello Kees!
> >
> > It would appear that one of the macros you've added here is doing Bad
> > Things^TM to allmodconfig on RISC-V since the 22nd:
> >
> > ../lib/fortify_kunit.c: In function 'alloc_size_kmalloc_const_test':
> > ../lib/fortify_kunit.c:140:1: error: the frame size of 2384 bytes is 
> > larger than 2048 bytes [-Werror=frame-larger-than=]
> >   140 | }                                                               
> >         \
> >       | ^
> > ../lib/fortify_kunit.c:209:1: note: in expansion of macro 
> > 'DEFINE_ALLOC_SIZE_TEST_PAIR'
> >   209 | DEFINE_ALLOC_SIZE_TEST_PAIR(kmalloc)
> >       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> >
> > CONFIG_GCC_VERSION=110100
> > CONFIG_AS_VERSION=23700
> > CONFIG_LD_VERSION=23700
> >
> > The report came out of my CI (which I should have passed on sooner) so
> > I do not have anything other than stderr - I can get you anything else
> > you'd like/need though if you LMK.
> 
> There is generally a conflict between kunit and the structleak
> gcc plugin, I think the Makefile needs a line like
> 
> CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)

Thanks for the report! I've taken Anders's patch for this now.

-- 
Kees Cook
