Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DD167299C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjARUn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjARUnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:43:53 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169815F3AC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:43:47 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r18so25423537pgr.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KStM3HmfW6zjszqSuM2wQKSCCuEFuFkt3tPZnP+tR7I=;
        b=L3qce/23w/O2c6J0Sgvm8TGIFHR7tKd5Beqd1seyYV/7EV6novDaC5eXSiWU/f2FS5
         zSaPnuKyAYIsn+fAqZCqa1zAtjqrkRU6JUhLJSSO/aayxOkqt4XedkfO4QfCQWo7R1zM
         3jfnJDXMc4ataF6oRRyoiuCLTocCsVrHqDJns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KStM3HmfW6zjszqSuM2wQKSCCuEFuFkt3tPZnP+tR7I=;
        b=Ls07mR/7n4p7CzESzQ8zjYm1f8bgJQABI/6CTXI1L4jtYMlpeEVEupFYiDj8hGkkdJ
         wc2y66YVZMNwQM4sbODI27JSajwurDAHVhq2XsWPVGYR4kUA62GozHsw/bquG4e/z51F
         RqYMc6fH6UXuWX4ndHIjgTynCuo2bLWBg9Z4MInbOjogDLwOOnEZggrP1qLyG5KCZ3Oc
         hhHyNzdN2kj8UsweK1zel+cqE8yiHBHVr6TrlH9P+I9iyjIZgkwxdXF8VoCRrHj4lA5F
         doxOqkSK68uG++brMixyvuEkQj8qMz6+bl8f0mK2EKLmtZf5UA/eR1zrjLDMtocQ7L6R
         H7xg==
X-Gm-Message-State: AFqh2krSbf8vwfXaNOB5A4Qz1Qqcl8O7LuK6dwe3czwGNWVEMZQWgl3l
        oGm4MyWtD2KbJ0qXLMNjvcXg5g==
X-Google-Smtp-Source: AMrXdXtQTleYSShMrqb3uuqdACEmAmgcS2GNXTtWlwQaiiEsj75gzw65XygJAnb8zA+2WFBUq52IWg==
X-Received: by 2002:a05:6a00:2a04:b0:582:26bc:a75b with SMTP id ce4-20020a056a002a0400b0058226bca75bmr9405109pfb.9.1674074626585;
        Wed, 18 Jan 2023 12:43:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z13-20020aa7990d000000b0058a313f4e4esm16911700pff.149.2023.01.18.12.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:43:44 -0800 (PST)
Date:   Wed, 18 Jan 2023 12:43:43 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Gow <davidgow@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kunit: memcpy: Split slow memcpy tests into
 MEMCPY_SLOW_KUNIT_TEST
Message-ID: <202301181243.2DBDD432E@keescook>
References: <20230118200653.give.574-kees@kernel.org>
 <20230118203216.GA987351@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118203216.GA987351@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 12:32:16PM -0800, Guenter Roeck wrote:
> On Wed, Jan 18, 2023 at 12:06:54PM -0800, Kees Cook wrote:
> > Since the long memcpy tests may stall a system for tens of seconds
> > in virtualized architecture environments, split those tests off under
> > CONFIG_MEMCPY_SLOW_KUNIT_TEST so they can be separately disabled.
> > 
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Link: https://lore.kernel.org/lkml/20221226195206.GA2626419@roeck-us.net
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>
> > Reviewed-by: David Gow <davidgow@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v3: fix defaults, avoid redundant returns.
> > v2: https://lore.kernel.org/all/20230114005408.never.756-kees@kernel.org/
> > v1: https://lore.kernel.org/lkml/20230107040203.never.112-kees@kernel.org
> > ---
> >  lib/Kconfig.debug  | 9 +++++++++
> >  lib/memcpy_kunit.c | 3 +++
> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 881c3f84e88a..149d6403b8a9 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2566,6 +2566,15 @@ config MEMCPY_KUNIT_TEST
> >  
> >  	  If unsure, say N.
> >  
> > +config MEMCPY_SLOW_KUNIT_TEST
> > +	bool "Include exhaustive memcpy tests"
> > +	depends on MEMCPY_KUNIT_TEST
> > +	default y
> > +	help
> > +	  Some memcpy tests are quite exhaustive in checking for overlaps
> > +	  and bit ranges. These can be very slow, so they are split out
> > +	  as a separate config, in case they need to be disabled.
> > +
> >  config IS_SIGNED_TYPE_KUNIT_TEST
> >  	tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
> >  	depends on KUNIT
> > diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> > index 89128551448d..90f3aa9e909f 100644
> > --- a/lib/memcpy_kunit.c
> > +++ b/lib/memcpy_kunit.c
> > @@ -309,6 +309,8 @@ static void set_random_nonzero(struct kunit *test, u8 *byte)
> >  
> >  static void init_large(struct kunit *test)
> >  {
> > +	if (!IS_ENABLED(CONFIG_MEMCPY_SLOW_KUNIT_TEST))
> > +		kunit_skip(test, "Slow test skipped. Enable with CONFIG_MEMCPY_SLOW_KUNIT_TEST=y");
> >  
> >  	/* Get many bit patterns. */
> >  	get_random_bytes(large_src, ARRAY_SIZE(large_src));
> > @@ -327,6 +329,7 @@ static void init_large(struct kunit *test)
> >   */
> >  static void copy_large_test(struct kunit *test, bool use_memmove)
> >  {
> > +
> 
> Some whitespace noise slipped in here.

Ah-ha; thanks! I'll fix this in my tree.

-- 
Kees Cook
