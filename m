Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855C76CD1AC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjC2Ffh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjC2Ffc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:35:32 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350D33A87
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:35:21 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3e392e10cc4so246481cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680068120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ4VxHw3gziyai/ZHT9juicLaUWs3flel3m1iMnqLzY=;
        b=IpAS+ZmGTIoLmfVp5XUzebFqVZujsLlpp1ScMKuJhSbrLYvrl1zaUFwl+LqNZQKHm9
         u+FTJhJyd4nVtFRd/bNbg+phyF0MQWoGO5pVeEATw4nwVlAvCU5p9JwlKn6Bo1RUe3U/
         dr2B+k/Q8n1wyGB8aj4TNbSsW9E9WO4XSBKSPyL9Ej5IZhHouFT75h5qI7eRsdC2/FBK
         swrlAeafdZOQZttSIFxW3Tfn+3x6Jqsq1NMZMW5+Xc1aEjusucUWBzS+fUFhQGbXUdDB
         brSu4MWD8pM5fURKrNWqrIhuzQcZukfYbQhVJV2afrQ65lUU41JJFb8KpbiMYCHAgdGC
         kCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680068120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJ4VxHw3gziyai/ZHT9juicLaUWs3flel3m1iMnqLzY=;
        b=vOk8TTQOEvXMs7dFZvvmE8PrU9/iyj6EZP7m1z7Vl6UDBdY076wdWr4hDpncMu8iOt
         jU1UODNEFlRQKx5f0TCk3apv43KX60yk+SMt+kh0kesF0ZnwD+BeKKdfKSJE+cCNZJxa
         LRGpTs1pLiOPkfQrZvTvvkb95v5CqzLygh7DKAlpc6Fz68Wh5m8eUv06zStXWx2KhPIr
         /6EfVfzlr/KI3I4KjUajPsvLKwRuvtUzX75NQ6Llelxz9w2ypgHOxI0b/RIpv0Svtl2x
         Ip1aZZGnill2SjEtdg4+yAXo2FpXh/O9PArzTalGrbU9m9aA146tNUVj7Ve7j/ek4vWO
         QJFA==
X-Gm-Message-State: AAQBX9eXuJR05jIG/Tv+vCf/dP+3fLiqHEEsugJJGURbV3eWCTt7LvQt
        PUb7PJaXiTDZaHpnQa3GHdCuPtl0c9IY8rCkicKJeQ==
X-Google-Smtp-Source: AKy350ZJxLwvpg9Ap30DXxDFqoQBG9JMH4wrgkDhKQ4F8ERTQyVtE+QpOJzLu825EVk26ftbY0ud9wjO1VNT7NF4Gps=
X-Received: by 2002:ac8:7d0a:0:b0:3bf:b62a:508b with SMTP id
 g10-20020ac87d0a000000b003bfb62a508bmr284915qtb.12.1680068120187; Tue, 28 Mar
 2023 22:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230328234413.1081014-1-irogers@google.com> <67d81a70-1adc-dad4-4592-5e7d67e6c926@intel.com>
In-Reply-To: <67d81a70-1adc-dad4-4592-5e7d67e6c926@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 28 Mar 2023 22:35:07 -0700
Message-ID: <CAP-5=fXhc-nwVp=HKmycmryYSY6sBrDKGnQ+Ogt+86sHfsT82Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf symbol: Avoid use after free
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 9:52=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 29/03/23 02:44, Ian Rogers wrote:
> > If demangling succeeds then sym_name is set to the demangled string
> > that is freed. Rather than test if sym_name is empty and possibly
> > use-after-free on the return path, expand out the alternatives.
>
> Looks the same as:
>
> https://lore.kernel.org/linux-perf-users/20230316194156.8320-2-adrian.hun=
ter@intel.com/

Sorry for missing that. In the case it returns false, this avoids an
unnecessary snprintf.

Thanks,
Ian

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/symbol-elf.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.=
c
> > index c0a2de42c51b..b7e3e492bff3 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -577,15 +577,17 @@ static bool get_plt_got_name(GElf_Shdr *shdr, siz=
e_t i,
> >       /* Get the associated symbol */
> >       gelf_getsym(di->dynsym_data, vr->sym_idx, &sym);
> >       sym_name =3D elf_sym__name(&sym, di->dynstr_data);
> > -     demangled =3D demangle_sym(di->dso, 0, sym_name);
> > -     if (demangled !=3D NULL)
> > -             sym_name =3D demangled;
> > -
> > -     snprintf(buf, buf_sz, "%s@plt", sym_name);
> > -
> > -     free(demangled);
> > +     if (*sym_name =3D=3D '\0')
> > +             return false;
> >
> > -     return *sym_name;
> > +     demangled =3D demangle_sym(di->dso, 0, sym_name);
> > +     if (demangled !=3D NULL) {
> > +             snprintf(buf, buf_sz, "%s@plt", demangled);
> > +             free(demangled);
> > +     } else {
> > +             snprintf(buf, buf_sz, "%s@plt", sym_name);
> > +     }
> > +     return true;
> >  }
> >
> >  static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
>
