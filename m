Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AA4639D6C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 22:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiK0Vyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 16:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiK0Vyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:54:31 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA0D65BB
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:54:30 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id z6so5620955qtv.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KUPaod9IpGVY3KrFq93mf9r1syF4GT/HEcxWlUyS0JA=;
        b=D1FdI8tR3BeDchZJC5RU25xj9Ua/pfkfLoq7vN0mtiPjwmrYk2ru3ETt7KYxrN9KOV
         oM1NKZpCdGJEb+4IXARNY3fohlvGxknIhFE7EoGnd+1yer6+PGSWLks71c6JKjL58syG
         m9ozn43ZDf0MDum777oQb7Y2acI45lcCEbZ/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUPaod9IpGVY3KrFq93mf9r1syF4GT/HEcxWlUyS0JA=;
        b=IsERB8/etRsJc2yzoT1MExfmGzupMcNtzKnSIis5U0jyVKCWTI/yfyLCLxbXw8BDMr
         cF75cXq398qazKmvD8QO9zCQPYVWqTW/VoD2iAnn9K2rpVo+qn8gfEwowi6TXZyhtgPc
         KPqLkvou01IP6cFj/f7S2PwtsxL+Pz1X9JIR4UjJJ6aZacmouPqk4sxCcE+6LD3RyhqS
         IoQOgM1BYGtyopX2bR/LmC5wPXdqcAoVGn0WYIGs95YViJEKCVUeORK4AC4GU2hdLji+
         pmA5wr3dHOH/uhBux0vVmuYnCrgrhZ9ftIvvk4ihpcf4zr/bkdk5jl62LAsBoKTARV5t
         kjIg==
X-Gm-Message-State: ANoB5plTQ5dGu12Sa0XPYlny8SZpM+g05I6bt91MEepYeld/f6vlE9TZ
        qQsMEBenMSDxJNUUQBCIhn6w470MmcZp0Q==
X-Google-Smtp-Source: AA0mqf6Ffyww6B03XbYX+Pr40dXeCNvRNGfyj/etLDFSvzjBK1BX0hCMhmMMWZZptEgrV0CF1fRgHw==
X-Received: by 2002:ac8:1081:0:b0:3a5:2615:5698 with SMTP id a1-20020ac81081000000b003a526155698mr45274170qtj.275.1669586069241;
        Sun, 27 Nov 2022 13:54:29 -0800 (PST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id o22-20020a05620a2a1600b006eeb3165554sm7099332qkp.19.2022.11.27.13.54.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 13:54:28 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id cg5so5604171qtb.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:54:28 -0800 (PST)
X-Received: by 2002:a05:622a:5a87:b0:3a5:47de:a214 with SMTP id
 fz7-20020a05622a5a8700b003a547dea214mr29106335qtb.304.1669586068202; Sun, 27
 Nov 2022 13:54:28 -0800 (PST)
MIME-Version: 1.0
References: <58cac72242e54380971cfa842f824470@AcuMS.aculab.com>
 <CAHk-=wgZCBedi_xrysY2EAsN8tQjb3K4-qYtF-FaEE+GFuuE4Q@mail.gmail.com> <433b8b44fe6e43b2b576c311bb55cc8a@AcuMS.aculab.com>
In-Reply-To: <433b8b44fe6e43b2b576c311bb55cc8a@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Nov 2022 13:54:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjgqs7Uev9=X8qP0mR0C+KoRze6d+1SoMib5x6o3yZSQg@mail.gmail.com>
Message-ID: <CAHk-=wjgqs7Uev9=X8qP0mR0C+KoRze6d+1SoMib5x6o3yZSQg@mail.gmail.com>
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

On Sun, Nov 27, 2022 at 1:42 PM David Laight <David.Laight@aculab.com> wrote:
>
> Why should it be a problem?
> min(-4, sizeof(X)) becomes min(-4, (int)sizeof(X)) and thus -4.
> Without the cast the -4 is converted to a very large unsigned
> value so the result is sizeof(X) - not at all expected.

That is EXACTLY the problem.

You even enumerate it, and work through exactly what happens, and then
you STILL say "this is not a problem".

It damn well is a HUGE problem. When people say "I need my offset to
be smaller than the size of the object", then a value like -4 IS NOT
ACCEPTABLE. It should cause a huge type warning about how the test was
broken.

David, this is literally *EXACTLY* why we have those strict type issues.

The fact that you don't even seem to realize why this would be a
problem makes me NAK this patch so hard that it isn't even funny.

Andrew, please remove this from your queue. It's not even remotely
acceptable. I was hoping I was misreading the patch, but it turns out
that this "relax the rules way too much" was apparently intentional.

            Linus
