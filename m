Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC0B6F0FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344679AbjD1AdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344555AbjD1AdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:33:09 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C560E46AB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:32:39 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3f0a2f8216fso869361cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682641957; x=1685233957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJaY9sgaqKLUmeW0DT4PpZqe8svi0MLaSjCCEjhIrtI=;
        b=pfVTkOVNi1QXcT1uTFiTcD8+HIfY8ZOmRtmS4qP4m5u3RIksUetT36jzwry0hhMOzj
         ocKVJzhrS7E1VrRRfNhRFD57wImEa0XLNL1YWX40M7B+arP1Iq7nv2c73KDgP/H0AfmS
         fcsOFoejBQyETzM7aaJPz23RiAojihr611xMC1rlyOP1liMzRFizIUFveFWx9qF1jsGJ
         yifRJYeZHlUlyEbdn3SZHT2Lr2bSEt+roEW96PEpSaNrtV+k1m1v8tUcz2xMSjyPdJyO
         826dqo3oPIO7h8pIyb14hTh5/3mnPUN8q8IKNAdWLRMqcNinaIk6LjQj4Wqm7VWnU5cP
         /qBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682641957; x=1685233957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJaY9sgaqKLUmeW0DT4PpZqe8svi0MLaSjCCEjhIrtI=;
        b=LfG/RgL9pbSCcIbhSzYEIObD1H1hbgMHAPQSdhkvFQFvYo+0tjiKEDjCrhK8qv3HIc
         zxHiZYZCjysQRTFKUyzqmBytySiU95ARL5fnTkTC4nQdGMi+JU5/jXIYqO1uk257aptl
         vEstMm/HVSit8rQ7kuWSokdYDyGc3V680/pVEjv+/Xkp3+Uz3699uCQYvZ+mtUHAk7b/
         gkAP7YL4rr45tKYzlyIA3tzu/NETi950IbrQcBFq1UVQh8cMTmCcsJ4hCkg1Rl0MzaKg
         yxyXPuf+Zghwkstfl9gcvOFFwjxXjO4lGQauJYkJWFakSVPtBKEBUWvxg+pQBYEblA4/
         5k5g==
X-Gm-Message-State: AC+VfDxP2Ay56/FhOVgORMWG0YwmxpVVptQ4piuSahaffUKrW5nU7DKy
        5Vd64hw57pHDnH0W8KRPGQ8AwIl5yNZ74YiK6P5f6Q==
X-Google-Smtp-Source: ACHHUZ4Mn9fA1Rv+pb1tCRREtcv+IVBtvXoEZK3Oaafli+Lta5PSWy5CQIDM1vdPr+yiXWvEtBHlctK7/LNcLIEZEcw=
X-Received: by 2002:a05:622a:1a0e:b0:3ef:3510:7c3a with SMTP id
 f14-20020a05622a1a0e00b003ef35107c3amr73868qtb.3.1682641957523; Thu, 27 Apr
 2023 17:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230427234833.1576130-1-namhyung@kernel.org> <20230427234833.1576130-2-namhyung@kernel.org>
In-Reply-To: <20230427234833.1576130-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 Apr 2023 17:32:26 -0700
Message-ID: <CAP-5=fXf12-Ym_iFhXeKpj5mb-QsnFCEdorp9gf=OC86c8p8WA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf lock contention: Rework offset calculation with
 BPF CO-RE
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>, Song Liu <song@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Thu, Apr 27, 2023 at 4:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It seems BPF CO-RE reloc doesn't work well with the pattern that gets
> the field-offset only.  Use offsetof() to make it explicit so that
> the compiler would generate the correct code.
>
> Fixes: 0c1228486bef ("perf lock contention: Support pre-5.14 kernels")
> Co-developed-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index 30c193078bdb..8d3cfbb3cc65 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -429,21 +429,21 @@ struct rq___new {
>  SEC("raw_tp/bpf_test_finish")
>  int BPF_PROG(collect_lock_syms)
>  {
> -       __u64 lock_addr;
> +       __u64 lock_addr, lock_off;
>         __u32 lock_flag;
>
> +       if (bpf_core_field_exists(struct rq___new, __lock))
> +               lock_off =3D offsetof(struct rq___new, __lock);
> +       else
> +               lock_off =3D offsetof(struct rq___old, lock);
> +
>         for (int i =3D 0; i < MAX_CPUS; i++) {
>                 struct rq *rq =3D bpf_per_cpu_ptr(&runqueues, i);
> -               struct rq___new *rq_new =3D (void *)rq;
> -               struct rq___old *rq_old =3D (void *)rq;
>
>                 if (rq =3D=3D NULL)
>                         break;
>
> -               if (bpf_core_field_exists(rq_new->__lock))
> -                       lock_addr =3D (__u64)&rq_new->__lock;
> -               else
> -                       lock_addr =3D (__u64)&rq_old->lock;
> +               lock_addr =3D (__u64)(void *)rq + lock_off;
>                 lock_flag =3D LOCK_CLASS_RQLOCK;
>                 bpf_map_update_elem(&lock_syms, &lock_addr, &lock_flag, B=
PF_ANY);
>         }
> --
> 2.40.1.495.gc816e09b53d-goog
>
