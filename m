Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EE0616DE0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiKBTdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiKBTdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:33:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09F338AC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:33:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p21so13679876plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 12:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Is8uxYlhyk8bBxYXj/AJ+5Ed7risnbmV/bZZuRONlGw=;
        b=YgTo3g4CWnxassQXwnQGCJRK8UV2dkG1gd5qUAMt9TS//89B3+EgDk8JBHMqQRWbqE
         SasIIt6rr9pasf/tRkH/JpmtucjEENqYnz4Ij31JPs/tyYvKfhh0Xab/ZL8Kv52Brl9z
         k+6eHolz1b5J42Hw8E/CNYhE3n7UgliU9iEI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Is8uxYlhyk8bBxYXj/AJ+5Ed7risnbmV/bZZuRONlGw=;
        b=MjUXPMLeh+Dx4sdk5eI1MwKmInFGLJ+Ao89Jd5fnAR4D5xjeHzMEueKWf9ItNod3f2
         jsCGtn1a80D7Er2UM/dvkXFvkCPbrzKdl8GV7Xs0PLw/ZiriiJnb8BUrNWG1jkt5cCjW
         hBRj8JimGAf87nEx+qKeJUfbv8ztJPGvIOdd5tWwTkWAHIrwq4Ie1kU4GsFgQqHqdT8X
         6RbNIDkly5TDFSBNjlnWmXrjeZykvH8vsFo5m1pi8oSmBX/aWuJ3HN1vXFyLrxnKIMb9
         8w1+aYKi5O6QHumD0hcLIFyi6b30VtiVfPBNpqUGTmJ7AImG3JuHUtWYLr9w26N/YyoZ
         WKng==
X-Gm-Message-State: ACrzQf1oIWG0+HTOWW89cKz8dxMi3upES4eA8aOwed3q55jE6tUoLDWU
        aAcoF3XisYH5TqXXPHEW/XMRLw==
X-Google-Smtp-Source: AMsMyM53U0WVK/IltYw2wXUwLPZJui+ftOfV8T9ZqcZx2iahytioyLerdzpOUR84Yg1+mPoG2ixzFA==
X-Received: by 2002:a17:902:7446:b0:186:a3a1:782d with SMTP id e6-20020a170902744600b00186a3a1782dmr26452013plt.76.1667417615186;
        Wed, 02 Nov 2022 12:33:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b001811a197797sm8605891plp.194.2022.11.02.12.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:33:34 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:33:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        luc.vanoostenryck@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, dlatypov@google.com,
        vitor@massaru.org, gustavoars@kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-sparse@vger.kernel.org, arnd@kernel.org, mchehab@kernel.org,
        mauro.chehab@linux.intel.com
Subject: Re: [PATCH v5] overflow: Introduce overflows_type() and
 castable_to_type()
Message-ID: <202211021233.02BF0D38@keescook>
References: <20220926191109.1803094-1-keescook@chromium.org>
 <20221024201125.1416422-1-gwan-gyeong.mun@intel.com>
 <307b90cb-b80d-6ce3-14ae-4a0b2ee5e447@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <307b90cb-b80d-6ce3-14ae-4a0b2ee5e447@prevas.dk>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 12:52:32PM +0100, Rasmus Villemoes wrote:
> On 24/10/2022 22.11, Gwan-gyeong Mun wrote:
> > From: Kees Cook <keescook@chromium.org>
> > 
> > Implement a robust overflows_type() macro to test if a variable or
> > constant value would overflow another variable or type. This can be
> > used as a constant expression for static_assert() (which requires a
> > constant expression[1][2]) when used on constant values. This must be
> > constructed manually, since __builtin_add_overflow() does not produce
> > a constant expression[3].
> > 
> > Additionally adds castable_to_type(), similar to __same_type(), but for
> > checking if a constant value would overflow if cast to a given type.
> > 
> 
> > +#define __overflows_type_constexpr(x, T) (			\
> > +	is_unsigned_type(typeof(x)) ?				\
> > +		(x) > type_max(typeof(T)) ? 1 : 0		\
> > +	: is_unsigned_type(typeof(T)) ?				\
> > +		(x) < 0 || (x) > type_max(typeof(T)) ? 1 : 0	\
> > +		: (x) < type_min(typeof(T)) ||			\
> > +		  (x) > type_max(typeof(T)) ? 1 : 0)
> > +
> 
> Can't all these instances of "foo ? 1 : 0" be simplified to "foo"? That
> would improve the readability of this thing somewhat IMO.

Oh, good point. :P I'll fix these.

-- 
Kees Cook
