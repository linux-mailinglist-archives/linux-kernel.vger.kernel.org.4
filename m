Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEFE60EA49
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiJZUdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiJZUdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:33:50 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD55E7E338
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:33:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f9so11701083pgj.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E0kxEl2S2a68MlFLjbJ42CBU2Unm12GzaCEH0lHQWuY=;
        b=obeJhxI+ENacAUlLPp+v61BhonjTS9sjU5Bul5it9+TdjHX1b4Op8qbkgN5uiAd9Gn
         Rd++IsKXJUdHvO+QOHUTGWHEmxI4CX4zFjED0OsH9PsV0jOV3C/F27o4oDQHKnHqCHbR
         ik1V1MssxtQ/uj/MararQ0+xsoC+XV6V9lfSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0kxEl2S2a68MlFLjbJ42CBU2Unm12GzaCEH0lHQWuY=;
        b=Uj/XuJyHHUPeSivkHXUnq0inOmP2ris4stsx6c+PlUDT9ztafoED8AbgllMsmveeAr
         AiIsgfByphj70sUih73EnacKFAEiMWOSsXJ3LSCrrEaAaVxfRjlP/aU0k5tmNmA118Rb
         uFAuSbjyOMC5FMclb8c9M+RwBJSEETrdYMOkXqraB+qE22sE2EF3afesJ8k92uQL7GfJ
         zvsA8NKxrrcSElrz7HmN9JmF0s4+IVk8rAo+sgkKfizQtETqrrn1BxJKgJ7Br6ij6aD1
         55fv7zwHqazFMUyDq4s6yAgnp2h+BkdRerS3eOtigXDd9d9oEFZRPSESpXlpCztMBmuM
         iG2Q==
X-Gm-Message-State: ACrzQf0KTNSZ4/mJyBXfwfrfhch5jP7+X/cjXQR2ubFxCHbigN3bIOWW
        Pz22oV0sJjY2fOYMpFPW6f/OOA==
X-Google-Smtp-Source: AMsMyM4LL5FU6eakv/Sxfgq+61DepYp6/wpZrXWfv9mn6/p1V/LnMHUZp0tBb0NQskKtGvdKrQEfXA==
X-Received: by 2002:a05:6a00:2307:b0:565:9079:b165 with SMTP id h7-20020a056a00230700b005659079b165mr46196368pfh.53.1666816429195;
        Wed, 26 Oct 2022 13:33:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s27-20020aa78bdb000000b0056bc30e618dsm3377335pfd.38.2022.10.26.13.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:33:48 -0700 (PDT)
Date:   Wed, 26 Oct 2022 13:33:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Keith Packard <keithp@keithp.com>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Daniel Axtens <dja@axtens.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        Zorro Lang <zlang@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Introduce flexible array struct helpers
Message-ID: <202210260904.41D0BE00A@keescook>
References: <20221024171848.never.522-kees@kernel.org>
 <20221024172058.534477-1-keescook@chromium.org>
 <87k04pf4tk.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k04pf4tk.fsf@keithp.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 11:35:03AM -0700, Keith Packard wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > + * struct flex_array_struct_example {
> > + *	...			 // arbitrary members
> > + *	bounded_flex_array(
> > + *		u16, part_count, // count of elements stored in "parts" below.
> > + *		u32, parts	 // flexible array with elements of type u32.
> > + *	);
> > + * );
> 
> > + * struct flex_array_struct_example {
> > + *	...		// position-sensitive members
> > + *	// count of elements stored in "parts" below.
> > + *	DECLARE_FAS_COUNT(u16, part_count);
> > + *	..		// position-sensitive members
> > + *	// flexible array with elements of type u32.
> > + *	DECLARE_FAS_ARRAY(u32, parts);
> > + * };
> 
> I'm sure there's a good reason, but these two macros appear to be doing
> similar things and yet have very different naming conventions. Maybe:
> 
>         FAS_DECLARE_COUNT(type, name)
>         FAS_DECLARE_ARRAY(type, name)
>         FAS_DECLARE(size_type, size_name, array_type, array_name)

Well, the custom has been for individual things, call it "DECLARE_*",
and for groups, we went with lower-case macros (e.g. struct_group()).

> 
> > +/* For use with flexible array structure helpers, in <linux/flex_array.h> */
> > +#define __DECLARE_FAS_COUNT(TYPE, NAME)					\
> > +	union {								\
> > +		TYPE __flex_array_elements_count;			\
> > +		TYPE NAME;						\
> > +	}
> 
> How often could that second "public" member be 'const'? That would catch
> places which accidentally assign to this field.
> 
> For code which does want to write to this field, is it mostly trimming
> data from the end, or does it actually smash in arbitrary values? For
> the former case, would it be helpful to have a test to make sure the
> assigned size isn't larger than the real size (yeah, that would probably
> take an extra field holding the real size), or larger than the current size?

I don't think this'll work within arbitrary struct declarations, but it
would be nice. :)

-- 
Kees Cook
