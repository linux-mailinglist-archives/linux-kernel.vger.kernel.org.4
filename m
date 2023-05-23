Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42FA70D0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjEWBrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjEWBrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:47:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF85393;
        Mon, 22 May 2023 18:47:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2711862D98;
        Tue, 23 May 2023 01:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C6CC43443;
        Tue, 23 May 2023 01:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684806454;
        bh=zF9SlkquxGLSSSsCHeIU+JOEWIonnAgASkV8Rx91284=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hNjsFAIRCjjLHInm0rtZOeU0u2QBN+7SX1d35PNhKmbjTJUNgZahsq+as7R+Uq9OB
         opALivvid8n+5J6g5NnVKfWiU8RP776bhJ+jplk0eZxY4zK42if6lw2/ScC7sbtg5D
         g0adg/Ex5tUOfEu5hYZZDIhtAggbQ4d3TOGf/Z05JD0U/G07UbG2LBCSuGHjQGZ3Kh
         4IOJ0cr2t9S3SRZNs5ZcixBhv+LW5+b6wHFlrlK7APDre14MyvXbu7odngO6PDsAcE
         f7BnxTC+lQAKOOqTHvw+qQUIUdcdW9jVtkYGEHTH3wPnBI1BjCBfiJ09IwBZPMeWEO
         N2+aZi+qyW7og==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-510eb980ce2so451163a12.2;
        Mon, 22 May 2023 18:47:34 -0700 (PDT)
X-Gm-Message-State: AC+VfDwFDnXyW9LwzKt9BgiCNft7ewA5Gr3A4Op3w+wX6dy+TY9v/Jbt
        WhLxclzwQ24besWC0pY1JgKuRI0H2QSCKO7x5Yg=
X-Google-Smtp-Source: ACHHUZ6qqygH0lMEsrELRXy5wCYzVStel8CIlNRie2g9W5SwbYX6OwQG92lQVrbI1jC1i6Ej47DgLVRkT82CbNgvOPE=
X-Received: by 2002:a17:907:6e14:b0:971:5a46:8ac8 with SMTP id
 sd20-20020a1709076e1400b009715a468ac8mr418537ejc.27.1684806452724; Mon, 22
 May 2023 18:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <1683615352-10794-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7waE0gmSU09YKJMHDAnj7BV7ukiLqWs+JzzLrHDG5z8w@mail.gmail.com>
 <20230518030618.GB1068119@leoy-yangtze.lan> <CAAhV-H6L9kNyGU2UrX7jyN_6O_pafSVSamP7DYHkzfMgmCxVXA@mail.gmail.com>
 <20230518032129.GC1068119@leoy-yangtze.lan> <CAAhV-H6_=qwheWvNozop2+9MexnOZQcva28xaeikCc49_DqABA@mail.gmail.com>
 <20230518040553.GE1068119@leoy-yangtze.lan> <ZGYXKnRZQh18D2Fd@kernel.org>
 <CAAhV-H40kQf5WD-8ozFwS6copfQaGtUJqm=nvQ6btXZnpDmZFA@mail.gmail.com> <387463f9-adb0-8e98-1de6-cae7a79a7d03@loongson.cn>
In-Reply-To: <387463f9-adb0-8e98-1de6-cae7a79a7d03@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 23 May 2023 09:47:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4mLCZ7qN3y6siTzpaybMr64f4FrKhfUhA_Qjm-O+sKnQ@mail.gmail.com>
Message-ID: <CAAhV-H4mLCZ7qN3y6siTzpaybMr64f4FrKhfUhA_Qjm-O+sKnQ@mail.gmail.com>
Subject: Re: [PATCH] perf symbol: Add LoongArch case in get_plt_sizes()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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

On Mon, May 22, 2023 at 3:59=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
>
>
> On 05/22/2023 11:50 AM, Huacai Chen wrote:
> > Hi, Arnaldo,
> >
> > On Thu, May 18, 2023 at 8:16=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> >>
> >> Em Thu, May 18, 2023 at 12:05:53PM +0800, Leo Yan escreveu:
> >>> On Thu, May 18, 2023 at 11:57:29AM +0800, Huacai Chen wrote:
> >>>> On Thu, May 18, 2023 at 11:21=E2=80=AFAM Leo Yan <leo.yan@linaro.org=
> wrote:
> >>>>>
> >>>>> On Thu, May 18, 2023 at 11:12:26AM +0800, Huacai Chen wrote:
> >>>>>> On Thu, May 18, 2023 at 11:06=E2=80=AFAM Leo Yan <leo.yan@linaro.o=
rg> wrote:
> >>>>>>>
> >>>>>>> On Thu, May 18, 2023 at 10:11:27AM +0800, Huacai Chen wrote:
> >>>>>>>> Queued, thanks.
> >>>>>>>
> >>>>>>> The patch is fine for me.
> >>>>>>>
> >>>>>>> Should not perf patches are to be merged via Arnaldo's tree?
> >>>>>>
> >>>>>> I think both are OK, if Arnaldo takes this patch, I will drop it.
> >>>>>
> >>>>> A good practice is to firstly inquiry the maintainers.
> >>>>>
> >>>>> AFAIK, Arnaldo will test perf patches before sending out pull reque=
st;
> >>>>> if perf patches are scattered out, it might be out of the testing
> >>>>> radar.
> >>>> OK, I know, thank you very much.
> >>>
> >>> You are welcome!
> >>>
> >>> I found the code base for bfd:
> >>> https://github.com/bminor/binutils-gdb/blob/master/bfd/elfnn-loongarc=
h.c
> >>>
> >>> And this patch is consistent with above link, FWIW:
> >>>
> >>> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> >>
> >> Thanks, applied.
> > I'm very sorry that this patch breaks cross-build. We need some
> > additional modification.
> >
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.=
c
> > index 5d409c26a22e..b3dbf6ca99a7 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -35,6 +35,10 @@
> >  #define EM_AARCH64     183  /* ARM 64 bit */
> >  #endif
> >
> > +#ifndef EM_LOONGARCH
> > +#define EM_LOONGARCH   258
> > +#endif
> > +
> >  #ifndef ELF32_ST_VISIBILITY
> >  #define ELF32_ST_VISIBILITY(o) ((o) & 0x03)
> >  #endif
> >
> > Then, drop this patch to get an updated version, or let me send an
> > incremental patch?
> >
>
> I tested this patch on native LoongArch and x86 system, I did not
> hit the build error about undeclared EM_LOONGARCH both on LoongArch
> and x86, because EM_LOONGARCH is defined in /usr/include/elf.h
>
> Here is the x86 system info:
>
> [root@fedora yangtiezhu]# cat /etc/fedora-release
> Fedora release 38 (Thirty Eight)
> [root@fedora yangtiezhu]# uname -m
> x86_64
> [root@fedora yangtiezhu]# grep -rn -w EM_LOONGARCH /usr/include/
> /usr/include/linux/elf-em.h:54:#define EM_LOONGARCH    258    /*
> LoongArch */
> /usr/include/linux/audit.h:442:#define AUDIT_ARCH_LOONGARCH32
> (EM_LOONGARCH|__AUDIT_ARCH_LE)
> /usr/include/linux/audit.h:443:#define AUDIT_ARCH_LOONGARCH64
> (EM_LOONGARCH|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> /usr/include/elf.h:361:#define EM_LOONGARCH    258    /* LoongArch */
> [root@fedora yangtiezhu]# rpm -qf /usr/include/elf.h
> glibc-headers-x86-2.37-1.fc38.noarch
>
> If I am missing something, please let me know.
Fedora 38 has a very new toolchain, older distribution will meet build erro=
rs.

Huacai
>
> Anyway, it is not a bad thing to add the EM_LOONGARCH definition
> to avoid the build error on some systems which have no EM_LOONGARCH
> in the glibc header.
>
> Thanks,
> Tiezhu
>
>
