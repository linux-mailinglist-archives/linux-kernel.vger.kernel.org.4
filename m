Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D47164F267
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 21:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiLPUc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 15:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiLPUcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:32:55 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DC41006E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:32:55 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id js9so3606275pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHhZ9ZPwjqbZ4BcttSt3Sdnf2qIn3B52gMX2PCgd3xg=;
        b=LWJb4jETCkdIV7xwZtPKFKqnBfRSGtDxr7b66C7yE2bTbTaDzkWz+4OKI39o84LAKl
         0K8UgyhKz8UI++gjYxjpZc42BOykIlvpCB0rQYhwh8+TMTFNEpLpjcKujq9JGiROE6s5
         jTPkLUp4wlnBaeM32SbGfc66gmPSy63uURfoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHhZ9ZPwjqbZ4BcttSt3Sdnf2qIn3B52gMX2PCgd3xg=;
        b=h4l7b01bpR2NoEWJi3VrP7Hg9/epvCz/w1i92E+F28F/6px3djZwqd6OcuHox9SyM/
         r7DCiwDaV1nZdEgIEkZsfCHSCa4YbjavHYiVgckZ6jzPWq1BV/bRAvNryj6ZPX87ie9F
         R4zOU2MMsVKKgfp/8tsO8cmqAAaJDx+/RueBjxyJeTl1wJUnWeW+M1YNqyQWKU3fLAnk
         tKay1P7zHrhwwkWY92vDa8HroskMObBpxMEMJkjyM/uletBqaywQZFf1Od/5w8H/UOQo
         1e/bY3yTljrmBjGNZxvuBWg2N7Cmvo+H9jSp/ei+F+7qOzUMK3n6E75XNDamc7K5QJ74
         bu2g==
X-Gm-Message-State: ANoB5pmq2W1OARIM7tClW9Y5CvkwuTat9SIrkXQepWLXrr3byNswIwiZ
        VJb1ObBPZW4nLiD+7qJv3CZU9g==
X-Google-Smtp-Source: AA0mqf6Y2ZywjGs0mB+Uova/fqMsnSnunDEP+ZiLAHwTDeXSyAzc/Cvzm2FmPHyyWH35eIUM0u3IWA==
X-Received: by 2002:a17:902:ab8d:b0:187:467f:c76c with SMTP id f13-20020a170902ab8d00b00187467fc76cmr30243669plr.51.1671222774412;
        Fri, 16 Dec 2022 12:32:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v7-20020a170902b7c700b00186e2123506sm2005977plz.300.2022.12.16.12.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 12:32:53 -0800 (PST)
Date:   Fri, 16 Dec 2022 12:32:53 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        Seth Jenkins <sethjenkins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exit: Allow oops_limit to be disabled
Message-ID: <202212161232.D752E46@keescook>
References: <20221202210617.never.105-kees@kernel.org>
 <Y5x7GXeluFmZ8E0E@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5x7GXeluFmZ8E0E@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 03:05:13PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 02, 2022 at 01:06:21PM -0800, Kees Cook wrote:
> 
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -954,7 +954,7 @@ void __noreturn make_task_dead(int signr)
> >  	 * To make sure this can't happen, place an upper bound on how often the
> >  	 * kernel may oops without panic().
> >  	 */
> > -	if (atomic_inc_return(&oops_count) >= READ_ONCE(oops_limit))
> > +	if (atomic_inc_return(&oops_count) >= READ_ONCE(oops_limit) && oops_limit)
> >  		panic("Oopsed too often (kernel.oops_limit is %d)", oops_limit);
> >  
> 
> That's dodgy, please write as:
> 
> 	limit = READ_ONCE(oops_limit);
> 	if (atomic_inc_return(&oops_count) >= limit && limit)
> 
> So we don't explicitly add a reload that negates the whole READ_ONCE().

Yup, that's more correct. Sent:
https://lore.kernel.org/lkml/20221216203024.never.640-kees@kernel.org

-- 
Kees Cook
