Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFDB688787
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjBBTbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjBBTbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:31:18 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F125872648
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:31:13 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k13so2981470plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 11:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VBmv2nsbVE0gJmlmNoP7kbXDeT3T6G5d3aWuIere0+E=;
        b=nCOH74iYkqZBzZRH7PECt51DmW4zg54cN0sJnIhyDdeeLMF5czdkwL6AoLuPYVo0NG
         f+s3wsoVW7fwmsHiiM1ztoYR1Spy0eqq1VVa9YYxDXBbuH0YeFkotS1IjlQ1yTsLzE5A
         KUvae7dpP1F6lq+QJv/F1OthgAzuzGufocfj1yB8id/D9DVopcBxgZSGUlZ7mXc6CAkz
         TvTGxd3EN6rGygQj+Xw5K4bEZB5bwM6ywGXXasyiPZUOQ+EHnPUW2vvCDv7FdqVKnM8X
         1NRCC3W1iWuXmFdwAghm3GOreXYYV8i0GmLNA+Ac7OPb3zh4zsCztwGAIIM3L3WvU9Cz
         59iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBmv2nsbVE0gJmlmNoP7kbXDeT3T6G5d3aWuIere0+E=;
        b=GKHsbRmzFN7u9GuR2qju/39j+c+jvR6qIBNFZ7eulBMEqJI+iMhCtAlaDtm+6TYdwO
         FQzkC/ode72X4fFnvUZqVV/wMNyS4IXn6gdKT1C5p5aVGs7dxoMJjcjbznEnyMSwL73N
         BwACVJKPo1yp2+gb3Pjv7tUcfVQPFOX4yHCc9tHOyQDVfshaxry0M2e1AHeNX+zOyAa3
         15CoeN666ULCDNwqe6ciJn8ZH5K9vRFeSqoe4bvSn5JpM3YCAWXJPlLF7eqoCsy9GRvj
         2y6SyhMiDb7XrZ/B6O/E7TUGNjRGb3zqqcRyN+ua2Rb/6BEsXyTZSgcor8GtgiNrOqVV
         0c0Q==
X-Gm-Message-State: AO0yUKW4inD0pB20vuBW2DLzARoVGn77092as05RE7GxjxyemvVsGrzK
        zPosYCOqcB7EsHLxUqVwxON2jy50P+Zni5OCqhL6QA==
X-Google-Smtp-Source: AK7set8GBHiJ3Y1ulPBVw2wOkpjPhGLilq3YAf0r+/FgEFrYJlo2S8fLZaZMb0Qh1OoLbUoUdBBqZUYnIcao1uW1y4g=
X-Received: by 2002:a17:903:120e:b0:196:44d4:244b with SMTP id
 l14-20020a170903120e00b0019644d4244bmr1807933plh.8.1675366272913; Thu, 02 Feb
 2023 11:31:12 -0800 (PST)
MIME-Version: 1.0
References: <20221101222520.never.109-kees@kernel.org> <20221101223321.1326815-5-keescook@chromium.org>
 <CAMSo37W3gRkP02tSCxGX71ZDAt3WgPZrkTRTM6J1iQ4gvUS9vg@mail.gmail.com>
 <CANDhNCogJrvt=yEXFK-xVmGjkcRxSNGZUqUeNw2MV9bFRrwPdQ@mail.gmail.com>
 <63dbf04a.630a0220.2608a.0149@mx.google.com> <CANDhNCoJJs_jSAdr6uved=cK=-6+nzSJq3e_E3HgtiXHZXkVww@mail.gmail.com>
 <63dc0a89.170a0220.49507.0091@mx.google.com> <CAMj1kXHTwFH-OADZ5nZXfZyuH-x7XJL3DMyiz2Tr_nCuup+xFA@mail.gmail.com>
In-Reply-To: <CAMj1kXHTwFH-OADZ5nZXfZyuH-x7XJL3DMyiz2Tr_nCuup+xFA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 2 Feb 2023 11:31:01 -0800
Message-ID: <CAKwvOd=cuDb2NNK4uoUTYTLryFig47hvDQ08ta5XhjHsEhAG4A@mail.gmail.com>
Subject: Re: [PATCH 5/6] driver core: Add __alloc_size hint to devm allocators
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        John Stultz <jstultz@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev, Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 11:20 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 2 Feb 2023 at 20:10, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Feb 02, 2023 at 10:56:29AM -0800, John Stultz wrote:
> > > That said, making sense of the error message isn't completely trivial
> > > either. I've been seeing a few cases recently of some of the new
> > > compiler tooling (I pinged you earlier on a CFI one) causing errors
> > > that developers aren't really sure how to address.  I know sometimes
> > > it's not easy to surface the errors with context to what was wrong,
> > > but at the risk of intense bike shedding, is there some way to provide
> > > something like "Likely array bounds error" instead of just "BRK
> > > handler: Fatal exception"?
> >
> > Yeah, this is a result of the size trade-off that resulted in config
> > CONFIG_UBSAN_TRAP -- there ends up being no message about what went
> > wrong. I'd really like to have cleaner handling of this -- perhaps what
> > was done for KCFI could be applied to UBSAN as well, though this is an
> > area I don't know well myself. (i.e. encoding "this was a UBSAN trap"
> > in the trap itself.)
> >
> > Sami or Ard, is this something that could be improved for arm64?
> >
>
> -ENOCONTEXT, so I am going to assume this is about runtime
> instrumentation that needs some kind of 'panic' function which it will
> invoke if some condition is met that should never occur?
>
> We already use brk with different immediate values in the opcode, so
> the arch layer already has what we need. Is this a limitation in the
> compiler, perhaps, where it always emits the same brk opcode?

Yeah, we'd need to update both the compiler to produce the encoding,
and the kernel to recognize the encoding and do something special.

-- 
Thanks,
~Nick Desaulniers
