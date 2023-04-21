Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FED46EAA31
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjDUMTa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Apr 2023 08:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjDUMT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:19:28 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA199016;
        Fri, 21 Apr 2023 05:19:27 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-54f851bcd4fso18321077b3.3;
        Fri, 21 Apr 2023 05:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682079566; x=1684671566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBGPxGXW5B4PY2iHwEX+HXfd0m2xt7m/C36xWqTMiSA=;
        b=AqFykgijJuqjGymMzP0RZqWP/wC1yXC7hsBygpbHU3oxn3p2bWtahMl41Ofaa/c43N
         f2aI1n36BHTQkobRobG9oNTmG911+pEc4CjRLBrcrDhMIKV6X9KZV8N/UXt+m5FnsY5v
         Pr9T+60bbG8zZm2PoQ3WcfNnLvO3wizfdwnr5lENQBo8PEUzu11FXx2zsrgBvfVXz1X9
         PEhAdOQgZXl7YtVYs7hXJ9AvR8ml/KUx1JHGIiY5d5HFtAWfdDvE+TVtI+t5z2BoXC5j
         fLKTz5w3JQAD8Z0be2vvGsX6tR+Z9DcsNkp/9RpINJqnNPUEHYlThtgx1ivK4u69CZlX
         k2sQ==
X-Gm-Message-State: AAQBX9dc+Wo2SmKcY7sW+YlIr2pfoKSLs6y/tvBHGEKp/x63tOOPAQvC
        2uyKIf1s41OjPvnUlfNkRY4y0U2cP/IeHtP3
X-Google-Smtp-Source: AKy350ZRuKSELWIE5Ozqt7iRdH+dDlFRPTbfRf9NJRDn9lhm70obydqAYCQI32ROUJ8nrvXq32KkfQ==
X-Received: by 2002:a0d:ccd2:0:b0:54f:b4c2:bba9 with SMTP id o201-20020a0dccd2000000b0054fb4c2bba9mr1537793ywd.25.1682079566344;
        Fri, 21 Apr 2023 05:19:26 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id d197-20020a814fce000000b0054f8de7c6f1sm920373ywb.70.2023.04.21.05.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 05:19:25 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-54f99770f86so18372957b3.1;
        Fri, 21 Apr 2023 05:19:25 -0700 (PDT)
X-Received: by 2002:a81:65c6:0:b0:52e:cd73:f927 with SMTP id
 z189-20020a8165c6000000b0052ecd73f927mr1487441ywb.48.1682079565541; Fri, 21
 Apr 2023 05:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <26932016c83c2ad350db59f5daf96117a38bbbd8.1679566927.git.geert@linux-m68k.org>
 <cfcfc689de8480a3ab0a03826e4c95f22c5af937.camel@physik.fu-berlin.de>
In-Reply-To: <cfcfc689de8480a3ab0a03826e4c95f22c5af937.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Apr 2023 14:19:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_oZDe-FWLHPKaqEdMZRcumbNbaf6PY6HTUzF6YmNmJw@mail.gmail.com>
Message-ID: <CAMuHMdV_oZDe-FWLHPKaqEdMZRcumbNbaf6PY6HTUzF6YmNmJw@mail.gmail.com>
Subject: Re: [PATCH v2] sh: Replace <uapi/asm/types.h> by <asm-generic/int-ll64.h>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Fri, Apr 21, 2023 at 1:14 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Thu, 2023-03-23 at 11:22 +0100, Geert Uytterhoeven wrote:
> > As arch/sh/include/uapi/asm/types.h doesn't exist, sh doesn't provide
> > any sh-specific uapi definitions, and it can just include
> > <asm-generic/int-ll64.h>, like most other architectures.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > v2:
> >   - Rebased for SPDX-License-Identifier addition in 2017.
> >
> >  arch/sh/include/asm/types.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/sh/include/asm/types.h b/arch/sh/include/asm/types.h
> > index 68eb24ad201383ef..9b3fc923ee28701c 100644
> > --- a/arch/sh/include/asm/types.h
> > +++ b/arch/sh/include/asm/types.h
> > @@ -2,7 +2,7 @@
> >  #ifndef __ASM_SH_TYPES_H
> >  #define __ASM_SH_TYPES_H
> >
> > -#include <uapi/asm/types.h>
> > +#include <asm-generic/int-ll64.h>
> >
> >  /*
> >   * These aren't exported outside the kernel to avoid name space clashes
>
> It seems that many (most?) architectures don't even provide their own types.h
> header. Does it even make sense to still carry that header or can it be provided
> from somewhere else?

SH does because it defines extra types {insn,reg}_size_t.
We can get rid of it by moving these extra types elsewhere, but is that
worth the effort?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
