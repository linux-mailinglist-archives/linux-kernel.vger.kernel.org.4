Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2482C6C782B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjCXGvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCXGvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:51:11 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7888522026
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:51:10 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3e392e10cc4so240411cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679640669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMsPc6861C4CUYPXH0vwHOOLJfwPo118oxYmEDFDQa8=;
        b=bUeHFvwAKGDNFMVYgrDpZxuSYR5qIUuVAJ+fnb973Z9ek65p+GzGodS+uiwdljFMo1
         JhGDi7KzFk9Pk+UnVNXyjhP/9pzTcoOISTWsaiSKUsi58zWRJ3M4pfbcBceAZCFFlgyW
         o5cDnVrc1minSljOhVPwF8ouUd7o6de60itTni8SfccvRFTJZ5Uw1sjMoDci07R05Ord
         cFN2rppgI4aImji3blzyURo5BcAWcLtVKnidGlVJ7A3XOkYxu7/sVGViKrLBKjV/hhLn
         rKs7ReKbOdnzqsML9M+Yfy3zvpt4aJOkWJoBVfp0ZENOrb2eLexLdLdpk5XebaCuk4M2
         XzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679640669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMsPc6861C4CUYPXH0vwHOOLJfwPo118oxYmEDFDQa8=;
        b=BR3wPa7hbfVvJ1u3UeHH6Cek/RxB/10B4TuIbAcFKYmL4Ak3oxLTdnZ1o1qKYMQVjj
         6oF47WI/jig8iPKAehhMNpUwyvUYdRsVO8XvjanqjyT2xFkYF5jOm4VUJdrpivkl1vuY
         nrJBnwsiRwRpjU47hy3WYDNQlT1o5FKd72LW2cDtwX/XsCVmAPjW9f2FNTzFYcYttXUi
         Wfs/op2jNOBwKxMjGTyVnBWyrwxRTEWk2kAdXFNOhiLRm6+ESz9nKmVdm+L3xEW+ClzJ
         XaaCisr9KCEZ01yrgfpr+djyMKwAcQjuIiO/kLw7hlzZ3ZlKVKhovhUvc+qOvHvpFVgQ
         On/w==
X-Gm-Message-State: AO0yUKUzhtn338lwwJx2YXBx93VqhqfhiWxaaFqEPC2TLMF7MCN1rVaF
        1JXmSdwt1PfGmhg7Wx0lMpxUkyEOfuO+VLX2V7bCuQ==
X-Google-Smtp-Source: AK7set+4bEq+uQUDoYrItOUrdWE8dV4LggwrlLLTMEWpmOfhfDwLMZ/7GqWwuTbzQ6qjdp8LcvZnm5lijUB+hL1vgCk=
X-Received: by 2002:a05:622a:283:b0:3b9:f696:c762 with SMTP id
 z3-20020a05622a028300b003b9f696c762mr167986qtw.19.1679640669407; Thu, 23 Mar
 2023 23:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230324001922.937634-1-namhyung@kernel.org>
In-Reply-To: <20230324001922.937634-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 23 Mar 2023 23:50:57 -0700
Message-ID: <CAP-5=fWPDSy31BLtxvJAsRq2pwnhKHN8T-CYckv=tELGCO9p0w@mail.gmail.com>
Subject: Re: [PATCH] perf lock contention: Fix msan issue in lock_contention_read()
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

On Thu, Mar 23, 2023 at 5:19=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> I got a report of a msan failure like below:
>
>   $ sudo perf lock con -ab -- sleep 1
>   ...
>   =3D=3D224416=3D=3DWARNING: MemorySanitizer: use-of-uninitialized-value
>       #0 0x5651160d6c96 in lock_contention_read  util/bpf_lock_contention=
.c:290:8
>       #1 0x565115f90870 in __cmd_contention  builtin-lock.c:1919:3
>       #2 0x565115f90870 in cmd_lock  builtin-lock.c:2385:8
>       #3 0x565115f03a83 in run_builtin  perf.c:330:11
>       #4 0x565115f03756 in handle_internal_command  perf.c:384:8
>       #5 0x565115f02d53 in run_argv  perf.c:428:2
>       #6 0x565115f02d53 in main  perf.c:562:3
>       #7 0x7f43553bc632 in __libc_start_main
>       #8 0x565115e865a9 in _start
>
> It was because the 'key' variable is not initialized.  Actually it'd be s=
et
> by bpf_map_get_next_key() but msan didn't seem to understand it.  Let's m=
ake
> msan happy by initializing the variable.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf_lock_contention.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_=
lock_contention.c
> index 235fc7150545..5927bf0bd92b 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -249,7 +249,7 @@ static const char *lock_contention_get_name(struct lo=
ck_contention *con,
>  int lock_contention_read(struct lock_contention *con)
>  {
>         int fd, stack, err =3D 0;
> -       struct contention_key *prev_key, key;
> +       struct contention_key *prev_key, key =3D {};
>         struct contention_data data =3D {};
>         struct lock_stat *st =3D NULL;
>         struct machine *machine =3D con->machine;
> --
> 2.40.0.348.gf938b09366-goog
>
