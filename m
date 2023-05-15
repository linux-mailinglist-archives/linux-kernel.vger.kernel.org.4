Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67CF70368C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243748AbjEORLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243742AbjEORKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:10:55 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA119EF4
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:09:04 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f51ea3a062so274811cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684170544; x=1686762544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPSDCbAJaSJHqp9bvCCU6QEMLH8oL/k1JBrURKr01CE=;
        b=TB4BLtFI1tz91N9s2QNL8l0KaCb+S7VRtlq/WOORzRwH4RuLCH00uqSo1mhrgF3zfF
         8dbtPA3e+3sJlkD/s1KPx644TpVTxY7wEyF7bch8f/kWX8liFN/wUd/kQg7Ehm0egOcQ
         QwVuogBvMd135SPuF/uXDEa26KDaYIWLecbLrj6A2FQsvRdisHMCvVMXwvpcbemYTldg
         dbOYyd2jrAcRU48ZJtK3djZqQqOG9auOxgGVq40DvEOoFYBFJUwxwN9uwDEUjSbCpYx4
         fMY+TWtWPTr/Gw4h+bxqhZHsnpzqf3BqQBE06BmxkTFD9EoPajCPz9u6r5qlYY4Bs4V8
         zz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684170544; x=1686762544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPSDCbAJaSJHqp9bvCCU6QEMLH8oL/k1JBrURKr01CE=;
        b=E7Z9j0/fZMG1Z3rjJmLpcxYEuhlJWfTpS/IY97gcumAK5A+0ROKfzDnn4GLfEqfXQM
         L+Lvpn4mrFs680p12LssH13nuAar3NZid2Cf06zDY6tPz6BCwxpml8/EyMsrFgqCBRar
         BcHA63pg5hI0AwTr/R53nnn9fOHqxpXbo6eU9WFaMa6igbAB7fI3ZJCi0TfBXw8ONDiU
         dhktscb9hFuGMB1IWkMAHNJbnFgqHLkqDO3Bdf6nAFFDP0ShOfAsNvz9nAOT7OsAaXHh
         xIW1beKS5wnS5sCO3BYnalI44XOll79KokxCcMpFVZdNeOS4GnF8Zy7Dkqj+XHAGAg7w
         BXkQ==
X-Gm-Message-State: AC+VfDwLp9tBAI2yIbvy+Z1YdGkaMqSSuPj8u+UG60OlVoYA6hOGgG+i
        RPNbstrcmQ3WsWemyghVzdjjnUm/P+R+wdAQ7kJ1Wg==
X-Google-Smtp-Source: ACHHUZ491wLC3fgfV4rR8SFXTsdq5f72NtZ8dZpUBE0OXEcvZwv6oasWjNY7EhIhJXtepD4g4dvgqGGijKITxwUXcGw=
X-Received: by 2002:a05:622a:1887:b0:3ed:210b:e698 with SMTP id
 v7-20020a05622a188700b003ed210be698mr1287918qtc.7.1684170543955; Mon, 15 May
 2023 10:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230511062725.514752-1-namhyung@kernel.org> <20230511062725.514752-2-namhyung@kernel.org>
In-Reply-To: <20230511062725.514752-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 15 May 2023 10:08:52 -0700
Message-ID: <CAP-5=fX8N4JRseytuACXMZF7Gw8Uu15kBg7dXN2iZZg0_nG-Sg@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf annotate: Parse x86 SIB addressing properly
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
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

On Wed, May 10, 2023 at 11:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> When the source argument of mov instruction is look like below, it didn't
> parse the whole operand and just stopped at the first comma.
>
>   mov    (%rbx,%rax,1),%rcx
>
> Fix it by checking the parentheses and move it to the closing one.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/annotate.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index ca9f0add68f4..6053ddf9c32d 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -550,6 +550,19 @@ static int mov__parse(struct arch *arch, struct ins_=
operands *ops, struct map_sy
>                 return -1;
>
>         *s =3D '\0';
> +
> +       /*
> +        * x86 SIB addressing has something like 0x8(%rax, %rcx, 1)
> +        * then it needs to have the closing parenthesis.
> +        */
> +       if (strchr(ops->raw, '(')) {
> +               *s =3D ',';
> +               s =3D strchr(ops->raw, ')');
> +               if (s =3D=3D NULL || s[1] !=3D ',')
> +                       return -1;
> +               *++s =3D '\0';
> +       }
> +
>         ops->source.raw =3D strdup(ops->raw);
>         *s =3D ',';
>
> --
> 2.40.1.521.gf1e218fcd8-goog
>
