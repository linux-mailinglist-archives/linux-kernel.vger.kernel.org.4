Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C66639F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiK1CnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiK1CnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:43:08 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9325A2DD3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 18:43:06 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id p18so6370424qkg.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 18:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yQ4Xu61CYGHjWbJcSWgRrYkhbPD51qpZ7qoAxUTl0A8=;
        b=eo4BU/Qu7DayaKdmBITLrk7MQ8jMSBUzDS/YDJQVU80SLY0GJ1+tHbtEKqQ6hc8NJw
         B87WTI2DQYYixrAaxFEiInmJQQMQs2MaHGHMlfT94w22j32GOp5Cwbgg7UdmogxCA/R2
         hmqYvUeeyOPFfcrOCqIVKy9n2BlaHgW6Rf2Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQ4Xu61CYGHjWbJcSWgRrYkhbPD51qpZ7qoAxUTl0A8=;
        b=Wck0s/QJqL2XV/WhJk5p51RS/QnwHFyJg+/wbsMrBuWPGljd8JLocDC5TSYXHVgkrI
         gs/XBE4SY7eZUmaA9PUKGeg1kfflNq+ut1JDsnn+UllLBsHK5dsy3OEh92jAkp2XyiD0
         3PzgRAdwnVQ+DF8OIX8K3UP6uX7oe8h45X5Y//qjxohI052YYB1SLklJwEZBxVuJWe56
         AbCXGXDkksy1SZDRd59kPtEZtSJnH+nF91f0056iusyJWYymjwAYNvCjkh6jvCqSA25Y
         Du7Oc3PF/xWfJO2qO02p3uJvkL4wNCrdMcIHSWkuF/tr5bQucNu2Q0Mbip6Gu+XmJaBA
         eBNg==
X-Gm-Message-State: ANoB5pmtB/Mys2U5feW6EE4PPY68Q2YR7WD81FQkItd8D/XAqOTCOVer
        SLU6t+xi1CcpyLSCIf4ABoZTJ+G3CBkbbw==
X-Google-Smtp-Source: AA0mqf55wNM6Go2VLiGHP75f6f9+GAdQ8aoHzV59kC6fQRTRk31WZYGEbZ2doL7snF2R9T90kbxEcg==
X-Received: by 2002:a05:620a:a93:b0:6f9:de1b:8814 with SMTP id v19-20020a05620a0a9300b006f9de1b8814mr44196790qkg.18.1669603384641;
        Sun, 27 Nov 2022 18:43:04 -0800 (PST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id v17-20020a05620a0f1100b006b9c9b7db8bsm7549368qkl.82.2022.11.27.18.43.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 18:43:03 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id j26so6344179qki.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 18:43:03 -0800 (PST)
X-Received: by 2002:ae9:e00c:0:b0:6f8:1e47:8422 with SMTP id
 m12-20020ae9e00c000000b006f81e478422mr44422054qkk.72.1669603383024; Sun, 27
 Nov 2022 18:43:03 -0800 (PST)
MIME-Version: 1.0
References: <58cac72242e54380971cfa842f824470@AcuMS.aculab.com>
 <CAHk-=wgZCBedi_xrysY2EAsN8tQjb3K4-qYtF-FaEE+GFuuE4Q@mail.gmail.com>
 <433b8b44fe6e43b2b576c311bb55cc8a@AcuMS.aculab.com> <CAHk-=wjgqs7Uev9=X8qP0mR0C+KoRze6d+1SoMib5x6o3yZSQg@mail.gmail.com>
 <b96a46eb24c2482bb6081418bd2ace02@AcuMS.aculab.com>
In-Reply-To: <b96a46eb24c2482bb6081418bd2ace02@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Nov 2022 18:42:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgxzGTsqcNv7B5Cr_BshyRkhrvsPMratxhNb0LA1EnwdA@mail.gmail.com>
Message-ID: <CAHk-=wgxzGTsqcNv7B5Cr_BshyRkhrvsPMratxhNb0LA1EnwdA@mail.gmail.com>
Subject: Re: [PATCH 1/1] minmax.h: Slightly relax the type checking done by
 min() and max().
To:     David Laight <David.Laight@aculab.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Perches <joe@perches.com>
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

On Sun, Nov 27, 2022 at 2:26 PM David Laight <David.Laight@aculab.com> wrote:
>
> But what actually happens is the compiler bleats about min()
> so rather then change a constant to be unsigned (etc) the code
> is rewritten with min_t() and both sides are cast to (usually)
> an unsigned type.

Sure, and at least then there is no question about "what is the type
that the comparison is done in".

> There are a non-zero number of cases where the cast masks high
> bits off the large value.

So? At least somebody looked at them.

I'd be ok with a warning for that case of 'min_t()' narrowing a cast,
perhaps. But the normal 'min()' has to be *completely* unambiguous.

So your patch that makes "one side is signed, other side is unsigned,
so normally we'd do it as an unsigned compare. But because the
unsigned side was a constant, we made it signed after all, and do the
comparison as signed with no warning".

That's just *horrible*. It's even crazier than the regular C type
conversions that (some) people have at least had decades of getting
used to.

Don't you see how nasty that kind of completely random thing is?

Now, I agree that sometimes we warn *too* much, but no, it's not
acceptable to change that to "let's not warn as much, and in the
process also change the sign of the comparison in strange ways".

If it was the *other* way around, where we warned too much, but at
least didn't change the actual semantics, that would be one thing. So,
for example, I think that if you have

    unsigned long a;

then:

 - min(a,5)

 - min(a,5u)

both currently warn "annoyingly", even though the result is obvious.

One because "5" is an "int" and thus signed, but hey, comparing a
signed *positive* constant to a unsigned variable is pretty darn safe.

So getting rid of the warning in that case - and just doing it as an
unsigned comparison which then also gives the smallest possible result
range and as such cannot possibly confuse anything - would likely be a
good thing.

And the fact that '5u' _also_ warns is just annoying. There's zero
ambiguity about the result (which will always fit in 'unsigned int'),
but the comparison should always be done in 'unsigned long'.

And for that '5u' case there is even _less_ of a chance that there
could be any sign confusion.

But note that "signed 5" thing: it's really really important to
understand that doing that constant comparison as an *unsigned*
comparison is much safer for 'min()', because it minimizes the result
range. Returning a negative number because you converted it to a
signed comparison would be potentially dangerous, because people often
forget to thin kabout the negative case. Returning the range 0..5 is
_clearly_ safe.

And that danger is very much when the '5' is a 'sizeof(xyz)'. We're
clearly talking about object sizes that cannot be negative, so
negative numbers are almost certainly wrong. Making the 'min()' return
a negative number there is horrendous.

Now, for 'max()', that 'minimize the range' argument doesn't work.

Right now we just have "both must be the same type". At least that is
always unambiguous. It can be annoying, yes. But then the expectation
is that when somebody changes it to a "min_t()", they activel;y
*THINK* about it.

                Linus
