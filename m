Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1265870AA34
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjETS0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjETS0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:26:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E7410E4
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 11:25:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-309d3e8777cso486255f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 11:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684607050; x=1687199050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFtB3NXqmGQcW1JqawEyCoAe+ankxFFwfVoPsoBwhw0=;
        b=A4QXQoBD5OWhphbMDh1nTWogwARbqEF7WCXW5fyCagC1TowCSoBH9FJOJ8J5orRS3E
         h1XRx0ylZJYA43EZy3SqAUCCaut8mU0zffjrDFzBbolAE7l6ZeFH/i4r2DonN09lcXwb
         5vh26ZaDlQYZDEiGTYGeqpYqRfcLUiVqE78DdCzpimncSwvO4axoqAYO6iCFu9iegaeY
         KJ6ttuCJ1bD/KAB65iEbsMnvyQ/WwBvOq/TIxUsZDoiN8dMh+Hcw1gQHEXKKsiBqZRh7
         NxDrkpsDYxRFpsznZmSD6sRFeejUHDi/XbBjel4+GqGdEJB2fPVeTu7E7FUJgUMfEpUR
         r0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684607050; x=1687199050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFtB3NXqmGQcW1JqawEyCoAe+ankxFFwfVoPsoBwhw0=;
        b=Yn3H+vkJf/FVq222jrCdjjzYm++BKibnSmYHDPfaFL1hx2lYcK5T1l4yrngrPjqtea
         aNp1/Ep4l5acz2Z4aWta/8qwsMLlZIAo7UvuinT1G80s9AjkMvgkOMADff8zStD6ulUO
         F2FFDjTmtBGHwmBij2KXkF7+fQZU7p0LYex97J5SdrhFIq1svCDdBEtCesXg50Qaenj+
         IXO2Ppa0SitSoMrxUJ658Hi0T5lyicQZUtYziVS3OuAt1MDya0acnKpBYi1HYSF1jhlY
         1VZehWdWuEC7xwTUAEDBT+4yLtzbb1epzFc7mmbkGjIFLMaFWRDfgNczEZf2MGccHEQF
         udNg==
X-Gm-Message-State: AC+VfDxymYeVaKL1IsVu3ZA+iDE84JEMGBOtiRdxAb4RBmFQloglDQka
        Hg7qBOTtqMT2hX2BVSlaoZBaKQ+1mQ==
X-Google-Smtp-Source: ACHHUZ4Cz6UoACfBF7G1qh9zdV9FD+XEsHbnvXG+8N0n0SIEwaYq4SwwxymQsIsTO3WrjUBa8fKbFg==
X-Received: by 2002:a5d:40cb:0:b0:309:599e:ea81 with SMTP id b11-20020a5d40cb000000b00309599eea81mr3610295wrq.3.1684607049597;
        Sat, 20 May 2023 11:24:09 -0700 (PDT)
Received: from p183 ([46.53.251.140])
        by smtp.gmail.com with ESMTPSA id o10-20020a056000010a00b002c70ce264bfsm2574242wrx.76.2023.05.20.11.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 11:24:08 -0700 (PDT)
Date:   Sat, 20 May 2023 21:24:07 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix mult_frac() multiple argument evaluation bug
Message-ID: <571c9de8-313a-49ed-b5e1-8d4948e062b0@p183>
References: <f522ad25-f899-4526-abc4-da35868b6a8b@p183>
 <20230519153622.f95f74819ecf467c5291de7d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230519153622.f95f74819ecf467c5291de7d@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 03:36:22PM -0700, Andrew Morton wrote:
> On Fri, 19 May 2023 23:24:54 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > mult_frac() evaluates _all_ arguments multiple times in the body.
> > 
> > --- a/include/linux/math.h
> > +++ b/include/linux/math.h
> > @@ -118,17 +118,17 @@ __STRUCT_FRACT(s32)
> >  __STRUCT_FRACT(u32)
> >  #undef __STRUCT_FRACT
> >  
> > -/*
> > - * Multiplies an integer by a fraction, while avoiding unnecessary
> > - * overflow or loss of precision.
> > - */
> > -#define mult_frac(x, numer, denom)(			\
> > -{							\
> > -	typeof(x) quot = (x) / (denom);			\
> > -	typeof(x) rem  = (x) % (denom);			\
> > -	(quot * (numer)) + ((rem * (numer)) / (denom));	\
> > -}							\
> > -)
> > +/* Calculate "x * n / d" without unnecessary overflow or loss of precision. */
> > +#define mult_frac(x, n, d)	\
> > +({				\
> > +	typeof(x) x_ = (x);	\
> > +	typeof(n) n_ = (n);	\
> > +	typeof(d) d_ = (d);	\
> > +				\
> > +	typeof(x) q = x_ / d_;	\
> > +	typeof(x) r = x_ % d_;	\
> > +	q * n_ + r * n_ / d_;	\
> > +})
> >  
> 
> I like, but the compiler doesn't.  x86_64 allmodconfig, gcc-12.2.0.
> 
> In file included from ./include/linux/math64.h:6,
>                  from ./include/linux/time.h:6,
>                  from ./include/linux/ktime.h:24,
>                  from ./include/linux/timer.h:6,
>                  from drivers/target/target_core_iblock.c:16:
> drivers/target/target_core_iblock.c: In function 'iblock_configure_device':
> drivers/target/target_core_iblock.c:127:73: error: passing argument 1 of 'queue_max_hw_sectors' makes pointer from integer without a cast [-Werror=int-conversion]
>   127 |         dev->dev_attrib.hw_max_sectors = mult_frac(queue_max_hw_sectors(q),
>       |                                                                         ^
>       |                                                                         |
>       |                                                                         unsigned int
> ./include/linux/math.h:129:16: note: in definition of macro 'mult_frac'
>   129 |         typeof(x) r = x_ % d_;  \
>       |                ^
> In file included from drivers/target/target_core_iblock.c:18:
> ./include/linux/blkdev.h:1112:77: note: expected 'const struct request_queue *' but argument is of type 'unsigned int'
>  1112 | static inline unsigned int queue_max_hw_sectors(const struct request_queue *q)
>       |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^

In my defence, original macro has the same bug:

	#define M(a)			\
	({				\
		typeof(a) b = ...;	\
		typeof(a) c = ...;	\

Now, first typeof can use f(b) because second b doesn't exist yet.
But second typeof can not because second b already exists with potentially
incompatible type.
