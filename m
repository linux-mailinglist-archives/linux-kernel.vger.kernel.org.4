Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A5261A420
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiKDWgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKDWg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:36:27 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553462FFD3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 15:36:25 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so3445490otb.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpQe0GQouYCXrUkQC1b5O53vxvTor3C127dFvGwudgk=;
        b=o5NcI/zd536+UxVbG4fUWv/p8nvyRj5HISSvXEvSRs0b74FaoKAxbSzlz1WuOEVRRs
         jVBLoj4RnwiHXxvMnQBugsqsmFEAl2MWXrRisZ8ZFHjQE3L8dJ1PQUfmF+sRy7pDLcF8
         kw1ulQPNd5EJ18VK+e5UK/8X9rnnrH5DBd2Fax0N4jsXofz3wYHCb3nPuhK0HCSEwc4z
         ghLlxCENxHawrZ+5CW7MwXqCX9D9jCl7jX/Y821vfwiolwXjFl7LRUSjpSeLZ7K9niH9
         tYTfIcHIWxy65bx5OR5a9ZnJOaIiSM5SkV0D95qZevEDWzvMF1VZg8b0TCoDT+NQiuSp
         EiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpQe0GQouYCXrUkQC1b5O53vxvTor3C127dFvGwudgk=;
        b=YRNexVoQyBrSceJiHJKr9hZxv5VhpTRDtifDDEUQJvpTDqVRsPLv8v48/FvVjYrYEl
         drxLiVjx3On/THL2SHXhnEF8N2FmgmZb0Wnkno7tz3Pw0pwuwWV8uv/uWClxErQSmOjz
         63nRmgaqGR1W8fJgA0u+638noRvvkSG6LXflGavdUgt/YmmEnKihSZDxHHo+4EYlH9is
         sY37KHfN3w24jUKPtpfAqoWLFgTxgc2C8nrJnyShHM9JtcwkqTFhk8ABbh7d4KuHiAHd
         +P2b92DztYk4LDQKnV5m7J1OUHl1gb8guzYBr3xpdc7+yhbRltWmpNTLBdG0cjVdYe+8
         RYvA==
X-Gm-Message-State: ACrzQf2t2zQL4zlEYGnaexGjJy2IAyDLxjQxXs7Io+WN4C11uCunTiyx
        piE22Moc8UguV8lnLRYbbgxqmVcyFvI=
X-Google-Smtp-Source: AMsMyM7utmHwi/DuqRrxXEnEZtaVJcAIMaIkO2vk6hTcKQ/R2W81NfZZQcKSqgv/NU2DAfSZK2/X3g==
X-Received: by 2002:a05:6830:1199:b0:66c:5c27:23ad with SMTP id u25-20020a056830119900b0066c5c2723admr12851132otq.165.1667601384503;
        Fri, 04 Nov 2022 15:36:24 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id q133-20020aca438b000000b00359f96eeb47sm112088oia.49.2022.11.04.15.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 15:36:24 -0700 (PDT)
Date:   Fri, 4 Nov 2022 15:36:22 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2] cpumask: limit visibility of FORCE_NR_CPUS
Message-ID: <Y2WT5qVi+YU2VEXU@yury-laptop>
References: <20221019225939.1646349-1-yury.norov@gmail.com>
 <xhsmhtu3evcme.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhtu3evcme.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 05:43:53PM +0000, Valentin Schneider wrote:
> On 19/10/22 15:59, Yury Norov wrote:
> > In current form, FORCE_NR_CPUS is visible to all users building their
> > kernels, even not experts. It is also set in allmodconfig or allyesconfig,
> > which is not a correct behavior.
> >
> > The 'choice' and unused config UNFORCE_NR_CPUS are used to ensure that
> > auto-generated configs that try to enable as much options as possible,
> > like allmodconfig, don't enable FORCE_NR_CPUS.
> >
> > Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> > v2: extend commit message with an explanation for what we need 'choice'.
> >
> >  lib/Kconfig | 31 ++++++++++++++++++++++++-------
> >  1 file changed, 24 insertions(+), 7 deletions(-)
> >
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 9bbf8a4b2108..1ada12f5dda6 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -528,14 +528,31 @@ config CPUMASK_OFFSTACK
> >         them on the stack.  This is a bit more expensive, but avoids
> >         stack overflow.
> >
> > +choice
> > +	prompt "Number of CPUs detection method"
> > +	default UNFORCE_NR_CPUS
> > +	depends on SMP && EXPERT
> 
> What about moving the 'depends on EXPERT' onto FORCE_NR_CPUS? I find it
> makes it easier to figure out the requirements for that option, and is
> similar to how e.g. CONFIG_PREEMPT_RT is handled.

In case of PREEMPT_RT, there are some other options to choose. In case of
FORCE_NR_CPUS there will be a choice with a single option, and it would be
weird that the option is never used.

I'd prefer to hide this choice for non-experts entirely.
