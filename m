Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE50B6237DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiKJACL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiKJACI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:02:08 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8237225EBF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 16:02:07 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id io19so160557plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 16:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p7Daps8F455XQYwxt4zsfNkYk/NEUbSHg8y4fLlQGlw=;
        b=de0Un6NHJwrYjGdsd6Hymr0RokpmscUp2nh2NVTZj16/sDwr/QqPVU7saLLLzVMrUX
         YtE4r6ZyFaxxplkamm8PKWRaExJTGGKPuJBAXRgwy0dgvQ057uPnLb+EjXckvxx0bcwH
         LJ7COv565ogXqugWgr1BeSviJdw6iyuPBpUDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7Daps8F455XQYwxt4zsfNkYk/NEUbSHg8y4fLlQGlw=;
        b=SKejiIbBWY99QtbMpL7ZWXF6AexiIqumEIpB5bUlRDQX+oF+g2OuJEil2nmKKqIkCz
         rYMBFp7VkDpjHMGaY+i7d5Fl0FI9NmCOsh8H99KQwbYFxXajOey4ooqhNN4yvWUV0CN7
         Ytx4pmiNMYh5taGzfWTg58mGXPhHGc95aTGVjW8JTtGTIGHKTUzpTlPeQBeGC6VjaFtL
         R5btnmzxPdXiEXCQBU5A/8iv35aPdqabm6I3LWhDV/DtC1qBM/xwh0LtHlPlNXZTr0ou
         3o3GeJjLJMsirt3YT+XViNv2koLam1x2Zkm6Ozco+tIyMAZSZlnixzyXold92SJRhI/y
         7GZQ==
X-Gm-Message-State: ACrzQf0dgtGmHjkHiLDrX1j/ho9Pll3UgvFsKzRvm8RKyY/VKFEP55aI
        4gXPOPm+rsJsVOZoMcTu4VNcPQ==
X-Google-Smtp-Source: AMsMyM5bthcPbXOxkKa6K+tg7fCCiv2SKynZlpoNO+Ox1nGoYBjoLBD79gHYEBB3qUS2rPF4vEcp8g==
X-Received: by 2002:a17:90a:f306:b0:213:b191:f3bf with SMTP id ca6-20020a17090af30600b00213b191f3bfmr62515127pjb.237.1668038526964;
        Wed, 09 Nov 2022 16:02:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b005668b26ade0sm8799343pfk.136.2022.11.09.16.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 16:02:06 -0800 (PST)
Date:   Wed, 9 Nov 2022 16:02:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Jann Horn <jannh@google.com>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Gow <davidgow@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/6] panic: Separate sysctl logic from CONFIG_SMP
Message-ID: <202211091601.E07A8D57@keescook>
References: <20221109194404.gonna.558-kees@kernel.org>
 <20221109200050.3400857-1-keescook@chromium.org>
 <CAGG=3QXM3u_uz1fuW2LzvrZqqPhYL15m+LJgD39R=jkuyENmYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QXM3u_uz1fuW2LzvrZqqPhYL15m+LJgD39R=jkuyENmYg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 01:48:45PM -0800, Bill Wendling wrote:
> On Wed, Nov 9, 2022 at 12:01 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > In preparation for adding more sysctls directly in kernel/panic.c, split
> > CONFIG_SMP from the logic that adds sysctls.
> >
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: tangmeng <tangmeng@uniontech.com>
> > Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> > Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  kernel/panic.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index da323209f583..129936511380 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -75,8 +75,9 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
> >
> >  EXPORT_SYMBOL(panic_notifier_list);
> >
> > -#if defined(CONFIG_SMP) && defined(CONFIG_SYSCTL)
> > +#if CONFIG_SYSCTL
> 
> Should this be "#ifdef CONFIG_SYSCTL"?
> 
> >  static struct ctl_table kern_panic_table[] = {
> > +#if defined(CONFIG_SMP)
> 
> nit: This could be "#ifdef CONFIG_SMP"

Whoops, yes. Thanks. I'll fix these for v3.

-- 
Kees Cook
