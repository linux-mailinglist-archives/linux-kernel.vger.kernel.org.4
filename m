Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6894A6100E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbiJ0S6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbiJ0S6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:58:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294FB32A86
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:58:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9so2512390pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0rEzPQriwPo47Lm4i24LI1bHNyCZGAXuw3tIRiGOno=;
        b=V2XxrzoXvdqaJk8i30tWvAs37oiT3u8hHgDDrUIbwP/IiKCO+3DGQu3a5Gd2T5pnHG
         OqVCAe7Wk9XnPtoRuGu/qBocuqjw7BMDvQF68tXzBjBS2Nad/HHlkoQpPntvv/LbASfd
         9kzsqSJokfr2PTlfqtanN0CvvfI4o3jMdiWqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0rEzPQriwPo47Lm4i24LI1bHNyCZGAXuw3tIRiGOno=;
        b=s8GPHob+peP758fqaZBUaMN9RdgpV0q9STsDol3BaHsaUvXUyNDpJSgghyrcbV/gZ0
         PtWkJ5VTqQBM5sA9GGLwG2eGy8BZacAEhjGVDDD4c7ptuouwsu4oR00Iu3mol2i+zoOz
         x6YDDlSNZ4pQTxXwB1Wn4yZu+HcH16IueT5JnBJJjcFLwBXCnteg7eW8DB6fDmaLxXfn
         p224JOxRX/qkn7q+n0CurqtKFFtGK98wrKEkK81l1pLjIJVTNNN15ivibU3MOjQikg6d
         tS7ygaTUFh3/vkkVaLI2FOtZ3UNvSJglAjBvwOmSZ+jkfBZz4bhpVxjPJtRqktAR0B4X
         igZQ==
X-Gm-Message-State: ACrzQf1mJBEBNcOMinMo4C/hkZJwfHCOCp6kca13imbbfP0ymoApSZdr
        bgUOXAMewL7hOMRbbMQIjbx7YA==
X-Google-Smtp-Source: AMsMyM7M1S3pYMn11kqaTSR05FudAWk7NZXCscCwXokV8piWycAQ3wjI0LkRvFh+wINQ10dYe4hkzA==
X-Received: by 2002:a17:902:b68b:b0:186:aee0:53ec with SMTP id c11-20020a170902b68b00b00186aee053ecmr21476664pls.90.1666897117516;
        Thu, 27 Oct 2022 11:58:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pj7-20020a17090b4f4700b00212e60c7d9csm2986668pjb.41.2022.10.27.11.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:58:36 -0700 (PDT)
Date:   Thu, 27 Oct 2022 11:58:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH] x86/uaccess: instrument copy_from_user_nmi()
Message-ID: <202210271155.33956B1@keescook>
References: <20221025221755.3810809-1-glider@google.com>
 <Y1j+Tt9mnMDU0zO+@hirez.programming.kicks-ass.net>
 <CAG_fn=XDeghFBGXT37Mc-ky-8NaPaMmCLdo3Par=xh92Fk_CAQ@mail.gmail.com>
 <Y1o72704bVK0FgCr@hirez.programming.kicks-ass.net>
 <CAG_fn=XESk1PPqbAVDqMdGbRwyvLvLQrm2hybr2cXaaYjfZEKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=XESk1PPqbAVDqMdGbRwyvLvLQrm2hybr2cXaaYjfZEKA@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:26:50AM -0700, Alexander Potapenko wrote:
> On Thu, Oct 27, 2022 at 1:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Oct 26, 2022 at 11:38:53AM -0700, Alexander Potapenko wrote:
> > > A bigger issue from the NMI perspective is probably
> > > having __msan_poison_alloca() inserted in every non-noinstr kernel
> > > function, because that hook may acquire the stackdepot lock.
> >
> > *urgghhh* that's broken, that must not be. There is a *TON* of NMI
> > functions that are non-noinstr.
> 
> __msan_poison_alloca() is guarded by kmsan_in_runtime(), which is
> currently implemented as:
> 
>   static __always_inline bool kmsan_in_runtime(void)
>   {
>           if ((hardirq_count() >> HARDIRQ_SHIFT) > 1)
>                   return true;
>           return kmsan_get_context()->kmsan_in_runtime;
>   }
> 
> I think the easiest way to fix the NMI situation would be adding "if
> in_nmi() return true"?

It might help to look through these threads:

https://lore.kernel.org/lkml/20220916135953.1320601-1-keescook@chromium.org/
https://lore.kernel.org/all/20220919201648.2250764-1-keescook@chromium.org/

I wandered around attempting to deal with in_nmi(), etc. And in
the end just drop the attempt to cover it. It's worth noting that
copy_from_user_nmi() exists on 1 architecture and has exactly 1
call-site...

-- 
Kees Cook
