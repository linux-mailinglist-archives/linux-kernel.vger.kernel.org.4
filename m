Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B4673A738
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjFVR1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjFVR1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:27:16 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F17DF1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:27:15 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4007b5bafceso11781cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687454834; x=1690046834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpAAA1t2APTPIL6TPZrRweRbUpiJB6pmgpDTWMvn/FY=;
        b=ajJCaXRDlhuKvi0JuMH0jHQN9zU/adnA6jpAoXryuU5WQ214eidnG1B3qIMV5EtJW+
         j3NWJdZbfDzrgST1YaxpZUKbRk1uDtMOvViaJsWHZ3rw6xEK4p4iXjludjzYnLVvuZls
         PzLDL+uOR+s/2UaCqngW3Mc8rB9JtOoIQbZcaO5R2SarOhdGFSAYx5jM7sLKuqgAfC78
         MEDwG1CpgHBm/54DeSGOygxeog9oztqbe5uhxqDKZrnXZvN9EBADBEbujbs2n+ykCH5s
         c4rAcgjn6rHl1g176cAu+0vmWM7cK0jO3Vi5EfjngEaaxsGpd4Ewfri0PlPDYt9SvSEp
         o91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687454834; x=1690046834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpAAA1t2APTPIL6TPZrRweRbUpiJB6pmgpDTWMvn/FY=;
        b=KdcoJDnoXerCbCscXVK+fzhs1C3xuqqxMw2/1tuMKZP3TFAhaAJLlZ69AJhssGyuMe
         q4ie7MHzI6j23C3qzm/C9Pevcs/0aFwRIxW+b1EISeSQfbXrQiVKr2SPW0O2uSE5k0X3
         zFAY9Ffwd7baFII5k3nImV3mHDXkR7Szd2NSY/Ioxqx/2Lb4LPYq0L/zO5BICGIeo+RW
         7uw/xsLPKU7yjN8K32Tv9UPAkectWdYPOp7t4kCxKACg1BQTXiz6mtkg1QsTBbRfGhP8
         n73fsLPhZs2ZzWrY371FfbBlqE2Yt2Cn4TlDM6+JGmZPI9DBJayn8xVlbUmZk0Fhjdov
         wpVg==
X-Gm-Message-State: AC+VfDzJRQpIt3OquYTljqsnskHCjekHIqgbiK3nZqYEYyYA5ZoTWYh8
        x4i7JPgHDTVks+hxNddblCYXhMlau1lIEyApbMF3xA==
X-Google-Smtp-Source: ACHHUZ7xXJVU1iaVQHNWBcjIROUN8XBx6twf/NQXOFch3Z0Pg9XmNAKotuHXqSCRwZCmUiFWOYZ3pyng/357JWNd2Hs=
X-Received: by 2002:a05:622a:85:b0:3f8:5b2:aeed with SMTP id
 o5-20020a05622a008500b003f805b2aeedmr1600635qtw.21.1687454834160; Thu, 22 Jun
 2023 10:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230620201818.1670753-1-namhyung@kernel.org> <20230620201818.1670753-3-namhyung@kernel.org>
In-Reply-To: <20230620201818.1670753-3-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Jun 2023 10:27:02 -0700
Message-ID: <CAP-5=fWvxMyzbY6gg7R-TzWNpbRcUKHpxoyJq-04c84CzkW4Cw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf machine: Include data symbols in the kernel map
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 1:18=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> When perf record -d is used, it needs data mmaps to symbolize global data=
.
> But it missed to collect kernel data maps so it cannot symbolize them.
> Instead of having a separate map, just increase the kernel map size to
> include the data section.
>
> Probably we can have a separate kernel map for data, but the current
> code assumes a single kernel map.  So it'd require more changes in other
> places and looks error-prone.  I decided not to go that way for now.
>
> Also it seems the kernel module size already includes the data section.
>
> For example, my system has the following.
>
>   $ grep -e _stext -e _etext -e _edata /proc/kallsyms
>   ffffffff99800000 T _stext
>   ffffffff9a601ac8 T _etext
>   ffffffff9b446a00 D _edata
>
> Size of the text section is (0x9a601ac8 - 0x99800000 =3D 0xe01ac8) and
> size of the data section is (0x9b446a00 - 0x99800000 =3D 0x1c46a00).
>
> Before:
>   $ perf record -d true
>
>   $ perf report -D | grep MMAP | head -1
>   0 0 0x460 [0x60]: PERF_RECORD_MMAP -1/0: [0xffffffff99800000(0xe01ac8) =
@ 0xffffffff99800000]: x [kernel.kallsyms]_text
>                                                                ^^^^^^^^
>                                                                  here

nit: should the ^^^ be under 0xe01ac8?

> After:
>   $ perf report -D | grep MMAP | head -1
>   0 0 0x460 [0x60]: PERF_RECORD_MMAP -1/0: [0xffffffff99800000(0x1c46a00)=
 @ 0xffffffff99800000]: x [kernel.kallsyms]_text
>                                                                ^^^^^^^^^

nit: and here under 0x1c46a00 ?

>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/machine.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index ddc0a2130caf..e93a66f6e0b3 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1218,7 +1218,10 @@ static int machine__get_running_kernel_start(struc=
t machine *machine,
>
>         *start =3D addr;
>
> -       err =3D kallsyms__get_function_start(filename, "_etext", &addr);
> +       if (machine->has_data_mmap)
> +               err =3D kallsyms__get_symbol_start(filename, "_edata", &a=
ddr);
> +       else
> +               err =3D kallsyms__get_function_start(filename, "_etext", =
&addr);
>         if (!err)
>                 *end =3D addr;
>
> --
> 2.41.0.185.g7c58973941-goog
>
