Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D830768B199
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 21:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjBEUip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 15:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEUio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 15:38:44 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2BC18B02
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 12:38:42 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id lu11so28993802ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 12:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wvt+9v7ZrCcvwNSIs9yFE9UOAvlA1In5VUE560s0QVQ=;
        b=c9yOhiQFHIiydW5PI6ZFQp25LZqvp4QoRnSdfbt4F5WOXYAIm3/h5OkNKC+4HbWCWC
         d4wRvjgFiL2Vs84amIVPHxOI6IDv1tCx/b7JpcAiQNbZnwFLQYPLUZy651ynWVXga8Uc
         28Hgd+6npG+roH+SzeSauCkqTTfi49lTFGQQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wvt+9v7ZrCcvwNSIs9yFE9UOAvlA1In5VUE560s0QVQ=;
        b=ideT+N/CHXJDKKSCaOvQYnHgdoY6V97vWvwmY2QFc0sS3luGj+3wU/+Pf8/Cw8Dp5Y
         oJ3+n+/GzqQCCBYaeBqPJedzZRPcN2Rr6Z58IeKmyKvkdXsfAtr45SUDvl30K/y4WavB
         TOUR5vS+A+W9Y1gtdpTUWTrcnFHXhZKFreue9wCewSRJrBbHWozDPzbBo5KZ1WSpxU/I
         KNaxLOHN0XBMzZB87s1JKIs54EticbRYXlBOkWcuHeFUum4pCdVNzBCrRxPjuGUQ2SbC
         BObaSMq9sCWN/Q3xjsYpIlNzDD+k3UHCFaik/xHcgNSv6+UyecO1vCxtMA9Y+5MALBn3
         1DLg==
X-Gm-Message-State: AO0yUKVhguDuF17e7M04Pp6545D0cPfKOV1+IOkhBUbbJABdqf38+5QA
        h478HqdFTeXChJWTWPZtEmYkWJgMFb7PU+MucHE=
X-Google-Smtp-Source: AK7set91hvF5qLINDW/rbqATP2duG2gPcA7LlLjoekqQGTTP6AHayU7nVV/8q641Lx+ZqHGfYHzDvA==
X-Received: by 2002:a17:906:4b16:b0:88d:72c0:611 with SMTP id y22-20020a1709064b1600b0088d72c00611mr18828959eju.3.1675629520701;
        Sun, 05 Feb 2023 12:38:40 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id r5-20020a170906a20500b008710789d85fsm4546083ejy.156.2023.02.05.12.38.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 12:38:40 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id m2so28931792ejb.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 12:38:40 -0800 (PST)
X-Received: by 2002:a17:906:892:b0:87a:7098:ca09 with SMTP id
 n18-20020a170906089200b0087a7098ca09mr4401214eje.78.1675629519709; Sun, 05
 Feb 2023 12:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20230129123431.1282427-1-j.neuschaefer@gmx.net>
 <78d224a63f6c27bf700d59007b6f3c89746d728c.camel@perches.com> <3afee0493d3718f2e38b6c54dab23d38360cd5d0.camel@perches.com>
In-Reply-To: <3afee0493d3718f2e38b6c54dab23d38360cd5d0.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Feb 2023 12:38:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4apoSwWvZn0ZsUwxB_ALKOOHqoxp0AVMP97UHSGqLow@mail.gmail.com>
Message-ID: <CAHk-=wh4apoSwWvZn0ZsUwxB_ALKOOHqoxp0AVMP97UHSGqLow@mail.gmail.com>
Subject: Re: [PATCH] checkpatch.pl: Relax commit ID check to allow more than
 12 chars
To:     Joe Perches <joe@perches.com>
Cc:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
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

On Sat, Feb 4, 2023 at 8:58 AM Joe Perches <joe@perches.com> wrote:
>
> btw: it looks like 12 will still be sufficient for awhile yet

To be honest, that's actually closer to the 12-digit limit than I was expecting.

The git heuristics are pretty good, and it sounds like 13 hex digits
is already starting to happen, so maybe we should relax things.

That said, "up to 16" does sound questionable.

We're talking exponential growth by number of digits, so saying "let's
go from 12 to 16" is a *huge* jump. And I'd like to keep people doing
fewer digits just because these things get used in free-flowing prose,
and we have the whole line wrapping issue and things just get uglier
at some point.

So we're closing in on two decades of git use, and we are not that far
from having 10 million objects in our git database (for the base
tree). Sure, that's  a lot of objects, but to a close approximation
the object count grows _largely_ linearly with time.

Considering that git is actually pretty good at handling the ambiguous
case anyway, I'd say go up at *most* to 14 digits.

I just checked my current tip-of-tree, and I needed to go down to
*five* digits to have git start complaining about ambiguous object
names:

  [torvalds@ryzen linux]$ git show c608f
  error: short object ID c608f is ambiguous
  hint: The candidates are:
  hint:   c608f6b58f30 commit 2023-02-05 - Merge tag 'usb-6.2-rc7' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
  hint:   c608f14fb0ee tree
  hint:   c608fccf692f tree
  hint:   c608f76e5753 blob
  hint:   c608fa168fe6 blob
  hint:   c608fd96771c blob

and maybe that was pure luck, but looking at your stats it does look
like "6 digits is still unique for most objects", I really think that
we're better off with shorter and visually easier numbers than going
overboard.

Note above how even with just 5 digits, it's still unique in actual
commits, so from a *practical* standpoint even five digits are fine
(because normal human communication doesn't talk about the blob or
tree commits).

If this was some case of "when you hit the limit, things break
horribly badly", that would be one thing. But that not even being true
means that things like line wrapping and just visuals matter.

So I think 12 digits likely still work just fine for another decade or
two, but yes, we're at the point where we might want to start thinking
about 13 or 14.

                Linus
