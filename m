Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2F70784F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjERDG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjERDG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:06:26 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E1A102
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:06:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d139e0d67so188865b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684379185; x=1686971185;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VZxAJuNZvZOf2PM7ERBaGRuoePGDwpy1853Ks1BOCkU=;
        b=yv18ToFNadIMZPkCAcQNXKT3LVJToMnN8eYjMeDshshik9b1qp8LAWkYfjgGVarkpH
         ls8p8a32/PMQiKVfGlGdOVKYA14iMwDZfXaKQlIEitTEJxmEO1gZ2s0FaXsFGNPl5+Gp
         aK86Dksn5HBA7xGDBve9pLs4Ond4FjQD7nE22hbonQUCGKmkkwEgDfGdGO5GTIBKDh+x
         TJy0TabycrYEngK5t74IHwB3yc1Yc/kj9yHmOCIvmGX9FGBQlyvjIS3Y4rutYpknLEI5
         uR7v/rewYRNjI8lKStK1jHa6T3GFOn/rN2kei/WM0kjobyMhu8vseSSUq3LgtuJq6QzI
         6yWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684379185; x=1686971185;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZxAJuNZvZOf2PM7ERBaGRuoePGDwpy1853Ks1BOCkU=;
        b=hppN1QCzlZfhs3jvvlD6AD9TCU/U3km1pGZdL7rYr0xr0RkR79Q2I/P9DNdRw2Mrq6
         N0iAssF+jt2EDOL/odJwjSy1Z9zm4HwddpOTIK+Wyy4lcyk67WDBW2KnRGlnae1Mh61i
         La65LfbWSsy0wMsg6R74IVVyYDt2acc62JVCCssdZBUwv/FoxMRMP+497womodMhw/8A
         W2dDr0tcMiluBlYhCXmMF6tq7Sn2VdcsE37OESw+Gf6ZloyBpqn+40c5lBqr+jt0fliV
         yCo5v9U66uj4mtN6ETjcJ7pfos78O7VMa7IGF57FoKk5gJ43lle99NaSA5Ukbgxya+PR
         VySg==
X-Gm-Message-State: AC+VfDzpg9DeG5miMv7Rlf9gwFVasZtFZngN2V4Hloos+8Tny9xeTjW/
        1VSsGQOvGqYs1o69rizOnYBiYxKWwVkXqrDr5ws=
X-Google-Smtp-Source: ACHHUZ6wMSlwT0O68UsYIGLKK0p+uaz1sgfDV2HUip2ijz7q4tkF+kLEJyN1uLQPGTt0gyHw4SxPOg==
X-Received: by 2002:a05:6a00:15cd:b0:646:5f98:6bb4 with SMTP id o13-20020a056a0015cd00b006465f986bb4mr2583507pfu.33.1684379184601;
        Wed, 17 May 2023 20:06:24 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.115])
        by smtp.gmail.com with ESMTPSA id j13-20020aa78dcd000000b0064afdc88465sm208448pfr.213.2023.05.17.20.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 20:06:24 -0700 (PDT)
Date:   Thu, 18 May 2023 11:06:18 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] perf symbol: Add LoongArch case in get_plt_sizes()
Message-ID: <20230518030618.GB1068119@leoy-yangtze.lan>
References: <1683615352-10794-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7waE0gmSU09YKJMHDAnj7BV7ukiLqWs+JzzLrHDG5z8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7waE0gmSU09YKJMHDAnj7BV7ukiLqWs+JzzLrHDG5z8w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 10:11:27AM +0800, Huacai Chen wrote:
> Queued, thanks.

The patch is fine for me.

Should not perf patches are to be merged via Arnaldo's tree?

Thanks,
Leo

> On Tue, May 9, 2023 at 2:56 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> > We can see the following definitions in bfd/elfnn-loongarch.c:
> >
> >   #define PLT_HEADER_INSNS 8
> >   #define PLT_HEADER_SIZE (PLT_HEADER_INSNS * 4)
> >
> >   #define PLT_ENTRY_INSNS 4
> >   #define PLT_ENTRY_SIZE (PLT_ENTRY_INSNS * 4)
> >
> > so plt header size is 32 and plt entry size is 16 on LoongArch,
> > let us add LoongArch case in get_plt_sizes().
> >
> > Link: https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=bfd/elfnn-loongarch.c
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >
> > This is based on 6.4-rc1
> >
> >  tools/perf/util/symbol-elf.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index b2ed9cc..5d409c2 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -411,6 +411,10 @@ static bool get_plt_sizes(struct dso *dso, GElf_Ehdr *ehdr, GElf_Shdr *shdr_plt,
> >                 *plt_header_size = 32;
> >                 *plt_entry_size = 16;
> >                 return true;
> > +       case EM_LOONGARCH:
> > +               *plt_header_size = 32;
> > +               *plt_entry_size = 16;
> > +               return true;
> >         case EM_SPARC:
> >                 *plt_header_size = 48;
> >                 *plt_entry_size = 12;
> > --
> > 2.1.0
> >
> >
