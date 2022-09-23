Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69D95E801A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiIWQn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiIWQnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:43:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D5C139F6D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:43:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C5D562889
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 16:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF1BC433C1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 16:43:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="N88L+RZZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663951388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NfPwWGJjSuA+aMD8WMtVroU4oVr5n6lPjI6B2paPxWA=;
        b=N88L+RZZ8+vQLdqb99iNZe2lmMXScpUvJ4HDomkEtFU2h4SW548QPMAAwjpo+Kxs9vqc98
        AxhaRGY65gyU07npdNmpiMMuYKgfsn/hzgMwBdvsBsugscYyJMxO1f7fIhUyD2cn/wVQKM
        AebsRldou7pLLE1YlUPml2VfyUN1o0Y=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4a082f9a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 23 Sep 2022 16:43:08 +0000 (UTC)
Received: by mail-vs1-f48.google.com with SMTP id k2so503651vsk.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:43:08 -0700 (PDT)
X-Gm-Message-State: ACrzQf3fYYuzdplNOlcv/DzAup2mEhQx466yaM/s8zZuey1WzBL4/EIv
        432fuyHhjAOAI9YpkBY9VeS6oBnkvA0F6YFYsqw=
X-Google-Smtp-Source: AMsMyM76a4mvOF9kxM3jRLuKNgLrz0bWouKv2zOcUzhq6oS6ufEq+TrMYCNEgeZz1hLi9i8XiqKzAxHFI7d1q3MZdlM=
X-Received: by 2002:a67:d81e:0:b0:398:2c98:229b with SMTP id
 e30-20020a67d81e000000b003982c98229bmr3941431vsj.73.1663951387659; Fri, 23
 Sep 2022 09:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rH47UFp6sXbDU0UZrTosFrDAa+m_FtqMqRFFNzmOzTdA@mail.gmail.com>
 <20220923154001.4074849-1-Jason@zx2c4.com> <202209230932.1FA2FF39@keescook>
In-Reply-To: <202209230932.1FA2FF39@keescook>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 23 Sep 2022 18:42:56 +0200
X-Gmail-Original-Message-ID: <CAHmME9oySGYZ=r5P6dUJnWp5R9TbwGGXLNWm8O5oyES2dn-PwQ@mail.gmail.com>
Message-ID: <CAHmME9oySGYZ=r5P6dUJnWp5R9TbwGGXLNWm8O5oyES2dn-PwQ@mail.gmail.com>
Subject: Re: [PATCH v2] minmax: clamp more efficiently by avoiding extra comparison
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 6:41 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Sep 23, 2022 at 05:40:01PM +0200, Jason A. Donenfeld wrote:
> > Currently the clamp algorithm does:
> >
> >       if (val > hi)
> >               val = hi;
> >       if (val < lo)
> >               val = lo;
> >
> > But since hi > lo by definition, this can be made more efficient with:
> >
> >       if (val > hi)
> >               val = hi;
> >       else if (val < lo)
> >               val = lo;
> >
> > So fix up the clamp and clamp_t functions to do this, adding the same
> > argument checking as for min and min_t.
> >
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  include/linux/minmax.h | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> > index 5433c08fcc68..30e2e2cd0f44 100644
> > --- a/include/linux/minmax.h
> > +++ b/include/linux/minmax.h
> > @@ -37,6 +37,27 @@
> >               __cmp(x, y, op), \
> >               __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
> >
> > +#define __clamp(val, lo, hi)                                                 \
> > +     ((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
> > +
> > +#define __clamp_once(val, lo, hi, unique_val, unique_lo, unique_hi) ({               \
> > +             typeof(val) unique_val = (val);                                 \
> > +             typeof(lo) unique_lo = (lo);                                    \
> > +             typeof(hi) unique_hi = (hi);                                    \
> > +             __clamp(unique_val, unique_lo, unique_hi); })
> > +
> > +#define __clamp_input_check(lo, hi)                                          \
> > +        (BUILD_BUG_ON_ZERO(__builtin_choose_expr(                            \
> > +                __is_constexpr((lo) > (hi)), (lo) > (hi), false)))
>
> Nice. :)
>
> > +
> > +#define __careful_clamp(val, lo, hi) ({                                              \
> > +     __clamp_input_check(lo, hi) +                                           \
> > +     __builtin_choose_expr(__typecheck(val, lo) && __typecheck(val, hi) &&   \
> > +                           __typecheck(hi, lo) && __is_constexpr(val) &&     \
> > +                           __is_constexpr(lo) && __is_constexpr(hi),         \
>
> I really like it! I might have used:
>
>         __safe_cmp(val, lo) && __safe_cmp(val, hi)
>
> instead of the "open coded" __typecheck()s and __is_constexpr()s, but
> it's the same result.
>
> > +             __clamp(val, lo, hi),                                           \
> > +             __clamp_once(val, lo, hi, __UNIQUE_ID(__val), __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })
>
> *complaint about line being >100 characters, but I don't really care* If
> anyone is really bothered, this looks fine, too:
>
>                 __clamp_once(val, lo, hi,                                       \
>                              __UNIQUE_ID(__val), __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })
>
> *shrug*
>
> > +
> >  /**
> >   * min - return minimum of two values of the same or compatible types
> >   * @x: first value
> > @@ -86,7 +107,7 @@
> >   * This macro does strict typechecking of @lo/@hi to make sure they are of the
> >   * same type as @val.  See the unnecessary pointer comparisons.
> >   */
> > -#define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
> > +#define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
> >
> >  /*
> >   * ..and if you can't take the strict
> > @@ -121,7 +142,7 @@
> >   * This macro does no typechecking and uses temporary variables of type
> >   * @type to make all the comparisons.
> >   */
> > -#define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)
> > +#define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo), (type)(hi))
> >
> >  /**
> >   * clamp_val - return a value clamped to a given range using val's type
> > --
> > 2.37.3
> >
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> I can take this unless akpm wants it?

Fine by me.
