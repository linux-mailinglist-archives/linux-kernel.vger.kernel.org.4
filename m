Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83F66050A4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiJSTnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJSTnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:43:00 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5901B6CB4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:42:59 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id cr19so9131570qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctubdjh4YmT23XBCyOP83PEoc4qREB4xb9pxg9MbHH8=;
        b=lxq2+XC//p4aOXvQcewRKN+56adD5u9RIh51WlcbCv+GCsUhMHKL/DTmLJA54CPErW
         +bCDcK5P7yMYNkjHrV2fw5WTxEY7KEbnEJJwSoLOBobqExhPlhAf91B/2t93PbFVRU4z
         4vwd6suZSoFxPPpFxFzSk0xAZfxoQ8Hc8a8i6hwZAFV4M9vh2plG/DxeZQ+3c1g85N5n
         U7DPzPnNb99GDH9mCuYAvZhNWLwY9nKppwxkA6XPx9TZfIapug7gQz7nftS77XFG1EuV
         YfSyqWbhfNPjD/9/XUWSSzZUxuwCQ2rPkhmz1Yhl0Nifev4MG1IKhnMLR8HlOZKi+8JZ
         gDgg==
X-Gm-Message-State: ACrzQf3xr/Da8EGmrVttHJplHuI+YlrCCDuGJKLZw6Fm2QKf6i51Uzdp
        3Qucqutmhyp8YEGrsiU4317J8v5RgitZHw==
X-Google-Smtp-Source: AMsMyM4LVVB2P3zD+Ug+2xywTRcMHG6cbFPJFCpGhuwSojkPKgtRHkuleI4M2BzeM9GTSEW+c7/XXg==
X-Received: by 2002:ac8:7d4e:0:b0:39c:d73a:dbc5 with SMTP id h14-20020ac87d4e000000b0039cd73adbc5mr8137516qtb.650.1666208578021;
        Wed, 19 Oct 2022 12:42:58 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id cq10-20020a05622a424a00b0035cf0f50d7csm4623726qtb.52.2022.10.19.12.42.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 12:42:56 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id i127so11343963ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:42:56 -0700 (PDT)
X-Received: by 2002:a25:cd01:0:b0:6c2:6f0d:f4ce with SMTP id
 d1-20020a25cd01000000b006c26f0df4cemr7615879ybf.365.1666208576058; Wed, 19
 Oct 2022 12:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221019052200.1604488-1-yury.norov@gmail.com>
 <Y0/eAD+eN7+3R/4Q@smile.fi.intel.com> <Y1BAekFR0DVY4rfo@yury-laptop>
In-Reply-To: <Y1BAekFR0DVY4rfo@yury-laptop>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Oct 2022 21:42:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWYnoYrCS=sa5F17RpE6MQdi+nOyo+n_6JydsYKfugn6g@mail.gmail.com>
Message-ID: <CAMuHMdWYnoYrCS=sa5F17RpE6MQdi+nOyo+n_6JydsYKfugn6g@mail.gmail.com>
Subject: Re: [PATCH] cpumask: limit visibility of FORCE_NR_CPUS
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuri,

On Wed, Oct 19, 2022 at 8:25 PM Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Oct 19, 2022 at 02:22:40PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 18, 2022 at 10:22:00PM -0700, Yury Norov wrote:
> > > In current form, FORCE_NR_CPUS is visible to all users building their
> > > kernels, even not experts. It is also set in allmodconfig or allyesconfig,
> > > which is not a correct behavior.
> >
> > Seems you forgot to update the commit message to explain the choise usage.
>
> OK, I'll fold-in something like this:
>
> The 'choice' and sudo config UNFORCE_NR_CPUS are used to ensure that

sudo?

> auto-generated configs that try to enable as much options as possible,
> like allmodconfig, don't enable FORCE_NR_CPUS.
>
> Is that what you mean?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
