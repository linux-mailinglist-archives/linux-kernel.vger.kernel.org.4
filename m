Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85F9730839
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbjFNT2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbjFNT2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:28:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA0A26B0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:28:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6667c54839bso524265b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686770899; x=1689362899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ad+D5Dtf5P11brvT0TL8ATklSfv9b3VOTG50BZV541w=;
        b=RYm1EFq4OePyg9ck8Sl8I5iSZ3CDZyaXMCgljtOh9kwtM6nZSqQ3R9HyDNaPWNspKI
         3elpcXARrWz5tPL3BgrChjZHkC0PHmqkGyM+9GIOEysjw6Rxi4owW7QKRs6Z4khXilt5
         63ce5ddLgp3cag7KclquGOMH5z7NBb6jDkFSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770899; x=1689362899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ad+D5Dtf5P11brvT0TL8ATklSfv9b3VOTG50BZV541w=;
        b=AgSYFjv7u+myZoBR0gUPI7Sj8l6ZrbhE5n1S8Vq50ezAVpNLeuTZ0DmVdNSDMJwpP/
         2627Ogc1LBRo8c4jMQiSTL3eGDp2VgghWTOa85r+dKrRr5feG1uKBKPW9tPVa0b+vxlM
         RuxgFykY5H5PjsBisb4+0YwpDOzmcCGGM7OTD015RC112c4K6ix9rA8i+MwP97LH24ig
         VgL4LKz7YRkVmpoCNKTvK7cmS9o2RND9jvoXU4wl6DXlmKzplcbdB2ulJlSK6ZK4eVoN
         ZIqSvBiESk1gsMQecfaitlG3SUAUhXj04dXiIy9+nXrIy8dwDdMknAfw6/lRN0VDQxnO
         YwPA==
X-Gm-Message-State: AC+VfDy6DuXFMFMrGu1a93K4UnRYCf5/nmXefk/Jv7WxIvaheyxEhz1W
        ep8SCfIrjdH9XDIKeOtXFNLbDg==
X-Google-Smtp-Source: ACHHUZ4qlSYkXTPrMZfYz6Guq3q8aOK4Yx6CUe+qOkfrwneambcP1ONPa+sRXsYkCRL/o507OdSNuw==
X-Received: by 2002:a05:6a00:3904:b0:65b:ccb0:8f00 with SMTP id fh4-20020a056a00390400b0065bccb08f00mr3786380pfb.4.1686770899094;
        Wed, 14 Jun 2023 12:28:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j24-20020a62b618000000b0065980654baasm10735199pff.130.2023.06.14.12.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:28:18 -0700 (PDT)
Date:   Wed, 14 Jun 2023 12:28:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     ysato@users.sourceforge.jp, azeemshaikh38@gmail.com,
        dalias@libc.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, linux-sh@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sh: Replace all non-returning strlcpy with strscpy
Message-ID: <202306141227.D4B2F1F6@keescook>
References: <20230530163041.985456-1-azeemshaikh38@gmail.com>
 <168676826702.1963449.9061022814058323294.b4-ty@chromium.org>
 <2a1d8002f7e2982399cb8ab7641f54ac867270aa.camel@physik.fu-berlin.de>
 <202306141203.0CAB93DD13@keescook>
 <af114229f6231ec180266eebce4e62851732a446.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af114229f6231ec180266eebce4e62851732a446.camel@physik.fu-berlin.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 09:23:49PM +0200, John Paul Adrian Glaubitz wrote:
> On Wed, 2023-06-14 at 12:03 -0700, Kees Cook wrote:
> > On Wed, Jun 14, 2023 at 08:49:13PM +0200, John Paul Adrian Glaubitz wrote:
> > > Hi Kees!
> > > 
> > > On Wed, 2023-06-14 at 11:44 -0700, Kees Cook wrote:
> > > > On Tue, 30 May 2023 16:30:41 +0000, Azeem Shaikh wrote:
> > > > > strlcpy() reads the entire source buffer first.
> > > > > This read may exceed the destination size limit.
> > > > > This is both inefficient and can lead to linear read
> > > > > overflows if a source string is not NUL-terminated [1].
> > > > > In an effort to remove strlcpy() completely [2], replace
> > > > > strlcpy() here with strscpy().
> > > > > No return values were used, so direct replacement is safe.
> > > > > 
> > > > > [...]
> > > > 
> > > > Build tested with sh4 GCC 13.1 from:
> > > > https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/
> > > > 
> > > > with defconfig and:
> > > > 	CONFIG_CPU_SUBTYPE_SH7343=y
> > > > 	CONFIG_SH_DMA=y
> > > > 	CONFIG_SH_DMA_API=y
> > > > 
> > > > Applied to for-next/hardening, thanks!
> > > > 
> > > > [1/1] sh: Replace all non-returning strlcpy with strscpy
> > > >       https://git.kernel.org/kees/c/ca64da3052be
> > > > 
> > > 
> > > Apologies, this fell off my table. I should have acked and tested this being the
> > > SuperH maintainer. If you can still update the patch in your tree, I can both
> > > test and ack this patch.
> > 
> > Absolutely! Thanks for double-checking. :)
> 
> I have tested the patch on my SH-7785LCR board on top of Linus' tree and
> also acked it.

Awesome. :) I have updated the tags and will push out my tree shortly.

Thanks!

-Kees

-- 
Kees Cook
