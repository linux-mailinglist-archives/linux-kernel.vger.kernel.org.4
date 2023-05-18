Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E98D707854
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjERDMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjERDMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:12:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924BC2D49;
        Wed, 17 May 2023 20:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D98E64C9B;
        Thu, 18 May 2023 03:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B86C4339B;
        Thu, 18 May 2023 03:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684379559;
        bh=7aF5lH0mP5b6pCJtWjRF5xQjqv7LCMYgzHKEL4dYL4I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LCHrRgHWbIfGMvjrm/zmjKc0MH6hLhGXUMa8ZNHQrJSXmunuy16Jf8CQekbinK3Al
         AZAdj56aToYF6/FXr6MFK9JnJU3vdf/2kWcCOP2+uAaDshqjBcRg5ckG+A8+bGce3d
         Q9YXTCto9jt7nwLS0rks3MDZeaVu2ZLwt8DL3T0JpxUn8WP+TOEadcLcCzZ1f68rUs
         GHAo8YtbgYlMRplzdCrbxdLoVQq3UKXRvAlAuZsAJ+sHahsYngzKJuRUluDHeEuvoq
         DAypkNJILWUrYTpYZ4s9E+Gx/7kqTPxprAZHXcyOeNo17U1MLkg0Cpbjj5ZrzgFtgH
         y9rE6heZP2+oA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-965d2749e2eso237320066b.1;
        Wed, 17 May 2023 20:12:39 -0700 (PDT)
X-Gm-Message-State: AC+VfDzr87FzIj2d0lTYQE6SeqpgRKn01y6IgnLB5Ov5TDQLSWToMZGE
        VZTVggybtMb7Tq8MwUiagAGil41fnn5kPZYSA1U=
X-Google-Smtp-Source: ACHHUZ5B0XdPA0YzDWqpNxUW3XIZdTdARnHWWJ5MZGUZf4C+4WP3MVgjMX7O4nuMVw5vGUxMtsXPtdohE/I5LUQIAps=
X-Received: by 2002:a17:906:794c:b0:969:fcfe:182c with SMTP id
 l12-20020a170906794c00b00969fcfe182cmr27428977ejo.68.1684379557716; Wed, 17
 May 2023 20:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <1683615352-10794-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7waE0gmSU09YKJMHDAnj7BV7ukiLqWs+JzzLrHDG5z8w@mail.gmail.com> <20230518030618.GB1068119@leoy-yangtze.lan>
In-Reply-To: <20230518030618.GB1068119@leoy-yangtze.lan>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 18 May 2023 11:12:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6L9kNyGU2UrX7jyN_6O_pafSVSamP7DYHkzfMgmCxVXA@mail.gmail.com>
Message-ID: <CAAhV-H6L9kNyGU2UrX7jyN_6O_pafSVSamP7DYHkzfMgmCxVXA@mail.gmail.com>
Subject: Re: [PATCH] perf symbol: Add LoongArch case in get_plt_sizes()
To:     Leo Yan <leo.yan@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 11:06=E2=80=AFAM Leo Yan <leo.yan@linaro.org> wrote=
:
>
> On Thu, May 18, 2023 at 10:11:27AM +0800, Huacai Chen wrote:
> > Queued, thanks.
>
> The patch is fine for me.
>
> Should not perf patches are to be merged via Arnaldo's tree?
I think both are OK, if Arnaldo takes this patch, I will drop it.

Huacai
>
> Thanks,
> Leo
>
> > On Tue, May 9, 2023 at 2:56=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson=
.cn> wrote:
> > >
> > > We can see the following definitions in bfd/elfnn-loongarch.c:
> > >
> > >   #define PLT_HEADER_INSNS 8
> > >   #define PLT_HEADER_SIZE (PLT_HEADER_INSNS * 4)
> > >
> > >   #define PLT_ENTRY_INSNS 4
> > >   #define PLT_ENTRY_SIZE (PLT_ENTRY_INSNS * 4)
> > >
> > > so plt header size is 32 and plt entry size is 16 on LoongArch,
> > > let us add LoongArch case in get_plt_sizes().
> > >
> > > Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Db=
fd/elfnn-loongarch.c
> > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > ---
> > >
> > > This is based on 6.4-rc1
> > >
> > >  tools/perf/util/symbol-elf.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-el=
f.c
> > > index b2ed9cc..5d409c2 100644
> > > --- a/tools/perf/util/symbol-elf.c
> > > +++ b/tools/perf/util/symbol-elf.c
> > > @@ -411,6 +411,10 @@ static bool get_plt_sizes(struct dso *dso, GElf_=
Ehdr *ehdr, GElf_Shdr *shdr_plt,
> > >                 *plt_header_size =3D 32;
> > >                 *plt_entry_size =3D 16;
> > >                 return true;
> > > +       case EM_LOONGARCH:
> > > +               *plt_header_size =3D 32;
> > > +               *plt_entry_size =3D 16;
> > > +               return true;
> > >         case EM_SPARC:
> > >                 *plt_header_size =3D 48;
> > >                 *plt_entry_size =3D 12;
> > > --
> > > 2.1.0
> > >
> > >
