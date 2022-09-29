Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875BF5EF253
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiI2JlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiI2JlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:41:11 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFBF63F28
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:41:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d10so959828pfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=BHx1zCDSdTBNp89joh9T11xCS+o76HH+zzILWZ9znzM=;
        b=cspSs7H3LyUUSs9vPwD5J2NT3ZdlPiwG8IHc50VADMxkebb+9p3OuMrwi7FBjgRBeX
         VuNTP4/zfWvJ6R4UK2p9BjXml4R0tE+X+qvG7jBzyNaXkYIVKy2wpWPsBHvfHXtMtw4Y
         0Wjz+oNIijRd1Y6NUhEv5/0vYUzDo+wZ4+3Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BHx1zCDSdTBNp89joh9T11xCS+o76HH+zzILWZ9znzM=;
        b=jx9smwMfr0rDroAwt2Cgik8ZlGEy1BjvhnvT8aoor7gd5Nv2/ekynHsCrygj5rcCae
         ZOMW+rutfLm1nFXQbhq325bArmS7xNV/euGAEEfvKWZuQXJOLb8UFpmusw7lhoIvVyP0
         x4wYGyr4Uc+UtGF5PV+MCErcI2F3frbR8KYikFYLl8qMO4vvnXDf0Y6rf+dqCZi01QBd
         Mreu4ZROce49O5TdTXp+cvzJ4DjTcylUWACtdFlfP1LNASrIyBRfSIijWllMGSKUdTxC
         IGzUdB43WpXxTaHj890aNT41CRh85ibtwUcnRUx14alBcmfEuY3X6ld8bRevCEy5HM1e
         yQBw==
X-Gm-Message-State: ACrzQf1yLyv6ALZMSr22bRdPOihqADLSlX3t1qaxduaGDsoyhIUcXDNF
        ehOHKoO888pYTJXKroYxC+nWmg==
X-Google-Smtp-Source: AMsMyM7cG9XsS1TIYyKJGdWfGcgtAFkynXxpmmB24h4K+JChwZhLRsSjLhp3bViOpwBYNP8xmORLbQ==
X-Received: by 2002:a63:91ca:0:b0:436:64db:c902 with SMTP id l193-20020a6391ca000000b0043664dbc902mr2134275pge.87.1664444468572;
        Thu, 29 Sep 2022 02:41:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o2-20020aa79782000000b00537d60286c9sm5588429pfp.113.2022.09.29.02.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 02:41:07 -0700 (PDT)
Date:   Thu, 29 Sep 2022 02:41:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yonghong Song <yhs@fb.com>, Hao Luo <haoluo@google.com>,
        Marco Elver <elver@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] compiler_types.h: Test for __alloc_size__ again
Message-ID: <202209290240.A2C342CF30@keescook>
References: <20220929081642.1932200-1-keescook@chromium.org>
 <0eb638e3-b9ac-6dec-6881-b885c7874b45@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eb638e3-b9ac-6dec-6881-b885c7874b45@suse.cz>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:14:47AM +0200, Vlastimil Babka wrote:
> On 9/29/22 10:16, Kees Cook wrote:
> > While the "alloc_size" attribute is available on all GCC versions, I
> > forgot that it gets disabled explicitly by the kernel in GCC < 9.1 due
> > to misbehaviors. Add a note to the compiler_attributes.h entry for it,
> > and restore the #ifdef in compiler_types.h.
> > 
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Marco Elver <elver@google.com>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Link: https://lore.kernel.org/lkml/CAMuHMdXK+UN1YVZm9DenuXAM8hZRUZJwp=SXsueP7sWiVU3a9A@mail.gmail.com
> > Fixes: 63caa04ec60583b1 ("slab: Remove __malloc attribute from realloc functions")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Thanks, I decided to late squash it so we don't needlessly cause issues for
> people doing bisections with gcc-8 later.

Sounds good to me; thanks!

-- 
Kees Cook
