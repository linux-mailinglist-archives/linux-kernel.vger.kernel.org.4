Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25565E59B7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 05:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiIVDq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 23:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIVDqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:46:51 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5AFAB07F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:46:50 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v4so7882416pgi.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=qyywbofJe0eyuZ1xhJp6fm2W5D3XouXfRrTFYq94Fp4=;
        b=Pw/f8KQsfXL0i7dI2WsLILA87LJmHWktVmMcNk02AdJw7OYwyfgFBp6OV5I7L2z+jK
         VT+jdCOhM59bxVoafw7uz7OyCyVKqc0ozDJVlZBiaOzy9ANYBjVgH5FdxsycfdmNd5Kb
         FCweeMeThswnUmgdalb60X24AzKQnx8Ym9Exw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qyywbofJe0eyuZ1xhJp6fm2W5D3XouXfRrTFYq94Fp4=;
        b=uZPlM/JJz8UsyLhacEgBlN/eIZ9cwSkZguNwwAogsLBZqqRoQy58rtzPXWNG8inR97
         sLmowWsB5Tpwdro6Q6ORRahXf2OniS1MU6pTUtNRrGpOJi6mgXply+aCc1ymDjBF5AZq
         ++yLKkE0HXqkdiqI8d4GQ2oqWEqk2idnAxX4idEmfdALgAgWuLXBpwO/ippzhQpy2och
         k5fejbp8Of4S8Ba1F5iVbfYdye+cXZ5l6PZ/EjrWT56qVATNvuNoJXsjfloWOWiLvTFL
         83y9DyIXps0CNOvvI0zJqI6L5yfBjhAldCmgZXA42K7dWUeNI2RQliMQR6XJ9mhqR6w+
         PmUg==
X-Gm-Message-State: ACrzQf0XJ1TQe8Aa0TAK1mIn84Qbbye3R4/gfBsAO0MnnimQkUvP+AYA
        xLxusM5zmXQGSLpFDPyD3PqFzg==
X-Google-Smtp-Source: AMsMyM782q4XStf7lFdBqwxNht8rRT7HLS72CIh1Ml4+FAknLR1yMkKJwakD2mYyJVOufVODYI0FsQ==
X-Received: by 2002:a63:ba05:0:b0:43b:e89b:da2b with SMTP id k5-20020a63ba05000000b0043be89bda2bmr1299435pgf.209.1663818409568;
        Wed, 21 Sep 2022 20:46:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b00174fa8cbf31sm2837874ple.303.2022.09.21.20.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 20:46:48 -0700 (PDT)
Date:   Wed, 21 Sep 2022 20:46:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Siddhesh Poyarekar <siddhesh@gotplt.org>
Cc:     linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/4] fortify: Explicitly check bounds are compile-time
 constants
Message-ID: <202209212034.16D9025882@keescook>
References: <20220920192202.190793-1-keescook@chromium.org>
 <20220920192202.190793-3-keescook@chromium.org>
 <b8f5f716-3ee6-87fd-d0e2-b1c35c98e0b0@gotplt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8f5f716-3ee6-87fd-d0e2-b1c35c98e0b0@gotplt.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 07:48:44AM -0400, Siddhesh Poyarekar wrote:
> On 2022-09-20 15:22, Kees Cook wrote:
> > In preparation for replacing __builtin_object_size() with
> > __builtin_dynamic_object_size(), all the compile-time size checks need
> > to check that the bounds variables are, in fact, known at compile-time.
> > Enforce what was guaranteed with __bos(). In other words, since all uses
> > of __bos() were constant expressions, it was not required to test for
> > this. When these change to __bdos(), they _may_ be constant expressions,
> > and the checks are only valid when the prior condition holds. This
> > results in no binary differences.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   include/linux/fortify-string.h | 50 +++++++++++++++++++++-------------
> >   1 file changed, 31 insertions(+), 19 deletions(-)
> > 
> > diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> > index ff879efe94ed..71c0a432c638 100644
> > --- a/include/linux/fortify-string.h
> > +++ b/include/linux/fortify-string.h
> > @@ -80,6 +80,12 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
> >   #define POS	__pass_object_size(1)
> >   #define POS0	__pass_object_size(0)
> > +#define __compiletime_lessthan(bounds, length)	(	\
> > +	__builtin_constant_p(length) &&			\
> > +	__builtin_constant_p(bounds) &&			\
> > +	bounds < length					\
> > +)
> 
> So with the gcc ranger, the compiler has lately been quite successful at
> computing a constant `bounds < length` even though bounds and length are not
> constant.  So perhaps this:
> 
> #define __compiletime_lessthan (bounds, length) (	\
> 	__builtin_constant (bounds < length) &&		\
> 	bounds < length					\
> )
> 
> might succeed in a few more cases.

Oh, interesting! That's very cool -- I never considered tossing a full
expression into __bcp. Yeah, that seems to work just fine:
https://godbolt.org/z/xrchErEx1

-- 
Kees Cook
