Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7912E613DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJaStg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJaStf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:49:35 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F4BDEDA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:49:34 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r18so11428381pgr.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sYx3uN1xhiMhAnziXHSHnRo2dJBOaDo/NYyMf4DLx1M=;
        b=QoSnwZ/B/liuYfGtfabdroBKsCRGncbY/5BM/crc///S+QhWCBt43aQ5r0Vmwhrcf/
         WwOKEFKSiTqkmAHolYSLciwfxNgIzEpX3FXQ7aIgkd1kt3JcvZSl1W7Xd0J8ulfFoQj7
         CDCI4G3lnoirhR/+pYe4r3hUmFmuyZS1LzdmfUmzPg0u70C+GxPIOMwiJyr4PhNYNnW3
         0AoFUj4/dqZQIONeYqmjfj5Xf6oOuAywghZtb7bjE/ySGNQE6AtxLvZhGj7F0xclZh7B
         WUeCMEZ5roRJ1a51ImZki8RwlFf+73wTHR2ceZn8IvT2ngdvWOvGW75SABwTiBOr4Ve2
         sIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYx3uN1xhiMhAnziXHSHnRo2dJBOaDo/NYyMf4DLx1M=;
        b=vtomnMsh0vK6hXJDlb3c1CGUBkHFWA+UehyEStN3brNcL+PgGuf9rsOP3sGEMF32k1
         hOlExEeEDUZ9HEhnEZXErMAhL/C6de4TknenDsI8FI6ZWMdfS6mFi+3A0PbX/XkeMkJw
         fi/TTuZAGSJJe9uquVsLxz2DGxXLTyCCTgEnBBzSKY/inY+WYsANNcSwVca4VQIV0Tgk
         i+mNts4n4sI/HFiBSUayQfFb6aR/thGYcuYprdPyWjmx/rqQNYNyZo0BzKLsvJHnDl71
         W4pCxF0D/eeNdZN9bhTce1C8aUmTD6CaR9kpnURgmTFlq+DHBEWBFn6juD+/1H17WhIp
         Vs7A==
X-Gm-Message-State: ACrzQf1++V7ts0tEzB/BRJlI0IzULXPJwT6K+tL34M60CPkV/wxUFa9z
        tJkRMDVtBobOctnNA/S/7K3Uct8Iq71VqqE7jwjCFw==
X-Google-Smtp-Source: AMsMyM4S3tC7xPezSvjUTlfcIuqPLzX7yvUpVHeB36ca9UjD2xZfpbWrw4G+lSGyj0zJ8Sty6027mRMTVnhoCsLjKd0=
X-Received: by 2002:a63:1f5c:0:b0:469:d0e6:dac0 with SMTP id
 q28-20020a631f5c000000b00469d0e6dac0mr13505473pgm.427.1667242173802; Mon, 31
 Oct 2022 11:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221020175655.1660864-1-ndesaulniers@google.com>
 <Y1GV9sHyODVmBbFW@dev-arch.thelio-3990X> <CA+icZUW2tFR=xjJEXJDNARW1yd_vjOOA1etF6aMN3Cx5ReFgmg@mail.gmail.com>
 <CAKwvOdn_mP8kVn5Bhe7bbC8R+VZxr8h02yWwKhvaTHW40ZJ_Uw@mail.gmail.com>
In-Reply-To: <CAKwvOdn_mP8kVn5Bhe7bbC8R+VZxr8h02yWwKhvaTHW40ZJ_Uw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 31 Oct 2022 11:49:21 -0700
Message-ID: <CAKwvOdkNBM2-pMm+fqzXpMxL5745p0Gzmw_+--P8RSqTk=v+VQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile.debug: support for -gz=zstd
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Sedat Dilek <sedat.dilek@dhl.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Terrell <terrelln@fb.com>, Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Gow <davidgow@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, sedat.dilek@gmail.com
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

On Mon, Oct 24, 2022 at 10:44 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Oct 23, 2022 at 8:46 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Thu, Oct 20, 2022 at 8:43 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > On Thu, Oct 20, 2022 at 10:56:49AM -0700, Nick Desaulniers wrote:
> > > > +config DEBUG_INFO_UNCOMPRESSED
> > > > +     bool "Don't compress debug information"
> > > > +     help
> > > > +       Don't compress debug info sections.
> > > > +
> > > >  config DEBUG_INFO_COMPRESSED
> >
> > Also, I prefer...
> >
> > DEBUG_INFO_COMPRESSED_NONE
> > DEBUG_INFO_COMPRESSED_ZLIB
> > DEBUG_INFO_COMPRESSED_ZSTD
> >
> > Following...
> >
> > $ ld.lld-16 -v
> > Debian LLD 16.0.0 (compatible with GNU linkers)
> >
> > $ ld.lld-16 --help | grep compress-debug-sections
> >  --compress-debug-sections=[none,zlib,zstd]
>
> It's a good suggestion, though I deliberately did not modify the
> identifier used for the existing DEBUG_INFO_COMPRESSED.  No defconfigs
> set DEBUG_INFO_COMPRESSED explicitly, but I think one issue with
> changing the identifier of existing kconfigs is that upon upgrading to
> newer kernel sources, if you run `make oldmodconfig` if you previously
> had DEBUG_INFO_COMPRESSED=y, kconfig doesn't know that that option has
> been renamed to DEBUG_INFO_COMPRESSED_ZLIB so it would be silently
> disabled, and image sizes would increase due to uncompressed debug
> info. That seems developer hostile.
>
> Masahiro, what are your thoughts on how to proceed? Should I change
> the pre-existing Kconfig identifier, or "let sleeping dogs lie?"

Hi Masahiro,
What are your thoughts on the above?

> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
