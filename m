Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CA36BC238
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjCPAMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjCPAL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:11:58 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D88938003
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:11:55 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h11so105169ild.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678925515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6A4+6WNZrg0XE9F8HhNkuyqp/9CoWfXobBlodcYCH9M=;
        b=ap8M5WVhaHadtY35pgDPiuTL1iT97fh3CCDvrGknj7w0ooU+SFohasJWs6qoRpYo+E
         9U4ShDKBucbUUoAXtNnCPBor6lifNAt9z+kLGBba4yVhJridSKPdnPIpWUekDG869P9e
         aJeBnzY1UkLPkeLdH53Ei5iwwfFhpmALvitV7GojqE5l4aELOpVpVRil9Z32C1gipBAY
         9WBMyIK1eEawYEG5sa6eLvBtF0feZC+2qdLd7SNOqlcs7sb732ls4d2KvBMd7KpFYq0N
         dLMdJpDYI53rgwJH/0mM9+iTrpFZQqo8Lgkcvdoihw5NfOPaZvYJnGwLG1GgVYcdwa1r
         ETOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678925515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6A4+6WNZrg0XE9F8HhNkuyqp/9CoWfXobBlodcYCH9M=;
        b=jAcDgQyCr2NLfSrJvlWCApqov7BBYYGCsrl6ZVUZJNpZqp3DXxA0ZFw7iwQm5f/0kg
         CBJUNVFYoIpQgWbZ34TjoEyHs2qeVx4UybTGdVw1ohgG4aSzwb8MJ5DRLgnQSIc5yhis
         OI9EMQ91D3mRYDIa3PBByUPWBMm6bPRYs5VNMKq6f+HtfAY0PloQBry59znuhqheivv+
         r/DDuy9LTD5ikG0dx1JGyCftl/eEOq562bgsgX+O4g2ai3BSGZ3TFVn0B2Hra57hTVjo
         vIxbrHtocCevbaGGCAYM5mHpo/knbrh9z7cU9+Pct967yaxjpnOSsN38CSfBbs5b6XZb
         EqPA==
X-Gm-Message-State: AO0yUKV6GPdJqLXEdDOI5KYwL5gr1+jRMA8LeEexRBOYKvN2mQAxUjVx
        WJIIxdQhEULRpULLsril66Go1jBaCLTyiKx7A2HMIQ==
X-Google-Smtp-Source: AK7set+A7BBRiTsFnL6nlX8eXSdT6HCEPYPWdoxP1z5nNV20cC7pviZfNP1E0fjsqMumMBseGhZMTD0Gi3RNQSq18Hs=
X-Received: by 2002:a05:6e02:1c89:b0:322:f3fb:6c45 with SMTP id
 w9-20020a056e021c8900b00322f3fb6c45mr71590ill.16.1678925514522; Wed, 15 Mar
 2023 17:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230315051500.13064-1-p4ranlee@gmail.com>
In-Reply-To: <20230315051500.13064-1-p4ranlee@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Mar 2023 17:11:41 -0700
Message-ID: <CAP-5=fUsgxM5H0T9kDyLra=0UMHXRqvYNeYcLeKr7ruc74vq-A@mail.gmail.com>
Subject: Re: [PATCH v2] perf tools riscv: Add support for riscv lookup_binutils_path
To:     Paran Lee <p4ranlee@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 10:15=E2=80=AFPM Paran Lee <p4ranlee@gmail.com> wro=
te:
>
> Add RISC-V binutils path on lookup triplets.
>
> Signed-off-by: Paran Lee <p4ranlee@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/common.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> index 59dd875fd5e4..e80d4d22cabf 100644
> --- a/tools/perf/arch/common.c
> +++ b/tools/perf/arch/common.c
> @@ -43,6 +43,20 @@ const char *const powerpc_triplets[] =3D {
>         NULL
>  };
>
> +const char *const riscv32_triplets[] =3D {
> +       "riscv32-unknown-linux-gnu-",
> +       "riscv32-linux-android-",
> +       "riscv32-linux-gnu-",
> +       NULL
> +};
> +
> +const char *const riscv64_triplets[] =3D {
> +       "riscv64-unknown-linux-gnu-",
> +       "riscv64-linux-android-",
> +       "riscv64-linux-gnu-",
> +       NULL
> +};
> +
>  const char *const s390_triplets[] =3D {
>         "s390-ibm-linux-",
>         "s390x-linux-gnu-",
> @@ -166,6 +180,10 @@ static int perf_env__lookup_binutils_path(struct per=
f_env *env,
>                 path_list =3D arm64_triplets;
>         else if (!strcmp(arch, "powerpc"))
>                 path_list =3D powerpc_triplets;
> +       else if (!strcmp(arch, "riscv32"))
> +               path_list =3D riscv32_triplets;
> +       else if (!strcmp(arch, "riscv64"))
> +               path_list =3D riscv64_triplets;
>         else if (!strcmp(arch, "sh"))
>                 path_list =3D sh_triplets;
>         else if (!strcmp(arch, "s390"))
> --
> 2.34.1
>
