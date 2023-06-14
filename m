Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FDF7307BC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjFNTDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjFNTDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:03:38 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09D02686
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:03:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6665f5aa6e6so714634b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686769413; x=1689361413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z7vJ06JHBcZNj02+GJclkUqcSBIL0FgpBwKOynh90Y=;
        b=IEryMqptT6pEZkskh/xnNVuGwzpLAes50lz0bi5b8QODjy3cSGfTjeXzsv8kH809TD
         D4byptaDD0f4sFEMlKKVoDQmCzY/0eWo2lmm7AFJjMmKLFmhmbhmK3AKHrgZGm4cSIYO
         BCWd2kF9ImpO7UgsPL/cCpDujUFLM7fUQFsvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686769413; x=1689361413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z7vJ06JHBcZNj02+GJclkUqcSBIL0FgpBwKOynh90Y=;
        b=hxvsniPJayeVzzJP/KglCFxw4rSL08f5Zcx8XFdOM1P4k2KYzSGTG8dBfdMAq9CrOC
         noazugfPNEWt2EfOzR8Lzl7zC04ec9u4gBpjtdrYtFywyFQPhtFGN4nPGsF+PZHJ6WDR
         x/Y9YHCH/7oi6sPQI71Ocm0q2gY4jCDyGnuxrCwcJ9DPRHFIHKWwjL6dGIcu2BN/zHIa
         FVeKODefxHeFUJ3seWVPWfAIuQuX1R/qH+yUWTUmTuafqYGcw/shFlKpFU9LiOJ6EcEI
         qYQorBblnW0YOVA+URrOo3GhYxmv1MLxMkFm/P4IN31ppf4pmL/MDuEz2fspmj2eziDM
         Krdw==
X-Gm-Message-State: AC+VfDynpik2pdfCKI5NUXnZuYn8hjzR6lgFs35tVxwpln3Qox6RiYxp
        eKYH8NB3B46xJGPteQiQL40asQ==
X-Google-Smtp-Source: ACHHUZ7SSnLcPoRxAX5BhrhszZ+tRzPgtRh5GuML7fRZnQ5FRrJwK/oTiEpeqlp+QRZFTbWSIh+/9A==
X-Received: by 2002:a17:903:234b:b0:1ae:50cc:45b with SMTP id c11-20020a170903234b00b001ae50cc045bmr14432047plh.36.1686769413603;
        Wed, 14 Jun 2023 12:03:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902694100b001b025aba9edsm12563719plt.220.2023.06.14.12.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:03:33 -0700 (PDT)
Date:   Wed, 14 Jun 2023 12:03:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     ysato@users.sourceforge.jp, azeemshaikh38@gmail.com,
        dalias@libc.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, linux-sh@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sh: Replace all non-returning strlcpy with strscpy
Message-ID: <202306141203.0CAB93DD13@keescook>
References: <20230530163041.985456-1-azeemshaikh38@gmail.com>
 <168676826702.1963449.9061022814058323294.b4-ty@chromium.org>
 <2a1d8002f7e2982399cb8ab7641f54ac867270aa.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a1d8002f7e2982399cb8ab7641f54ac867270aa.camel@physik.fu-berlin.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 08:49:13PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Kees!
> 
> On Wed, 2023-06-14 at 11:44 -0700, Kees Cook wrote:
> > On Tue, 30 May 2023 16:30:41 +0000, Azeem Shaikh wrote:
> > > strlcpy() reads the entire source buffer first.
> > > This read may exceed the destination size limit.
> > > This is both inefficient and can lead to linear read
> > > overflows if a source string is not NUL-terminated [1].
> > > In an effort to remove strlcpy() completely [2], replace
> > > strlcpy() here with strscpy().
> > > No return values were used, so direct replacement is safe.
> > > 
> > > [...]
> > 
> > Build tested with sh4 GCC 13.1 from:
> > https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/
> > 
> > with defconfig and:
> > 	CONFIG_CPU_SUBTYPE_SH7343=y
> > 	CONFIG_SH_DMA=y
> > 	CONFIG_SH_DMA_API=y
> > 
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] sh: Replace all non-returning strlcpy with strscpy
> >       https://git.kernel.org/kees/c/ca64da3052be
> > 
> 
> Apologies, this fell off my table. I should have acked and tested this being the
> SuperH maintainer. If you can still update the patch in your tree, I can both
> test and ack this patch.

Absolutely! Thanks for double-checking. :)

-Kees

-- 
Kees Cook
