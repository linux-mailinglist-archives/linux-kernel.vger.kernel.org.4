Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC9461402E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJaVxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJaVxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:53:48 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF8D140B1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:53:47 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id z9so6909239ilu.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UoC+o1dA/kh0+MOmEfvSCDk84t2FIDGBnI6Rcg5ImMo=;
        b=aK3PQn25+nFHVNHYNimanppB4aRKlWTUzSc9eZq7EiKK0b0Kwl6TzB2G+Q0iMhSkNu
         8OfDbSlNe9ZWz/oNqNrBnjKKdaTCeNOiGs2sKTxR/73/3CIQDyGibUoGVcIRy4aN+bIy
         Mc25TWFuu4qLCGQSrk6EvXccTUKSbwYXW4CNZe+rAZgwERLO1C4Mua5krpXBA5xAEdY5
         KPn/qR9p3gqKF7lDTBZvzRYC9sEJ1+P+LcOL/KO4ddojR6Ci9gTDYxhi2rNcelubL0d6
         AZ/5v40agOxfcfYMQ9CUG3vjtk0KjMeXkRcFbUqRp37y133fzarooQbb9MhwTNUamFPc
         dn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UoC+o1dA/kh0+MOmEfvSCDk84t2FIDGBnI6Rcg5ImMo=;
        b=YnGQyq0i8K75ME/jDWdedugm+0DnlQg/sY3w3gP7y0oqfZxQmCB1t2N9tyF7Z/vKNf
         FIaEhtcOoq44irWQNC9JkghWrSq/AgZennt9lFriYlQrtoY0WhTEoiY8ORbRlY0qYaoA
         DhuSyDkY1WaBoGz374+zfXPjauBUqk1jUZjk6FyXkd8nanrBbpqFmOSSo4+HM8D5y6Sj
         txD2faU8N5HLzx5GdN8jzohYwIpc4ikX/1DDiQq/H2Va7zwKmWck7ytkFDiVMxJ18tHX
         21rAZlvi6dsycBp3uEtoZ21RmyoSEn3w9ORUVTdK8cwRhY6xxUYcu/IXt6pJuXrXfxB9
         yDtg==
X-Gm-Message-State: ACrzQf0d2IUDoqfZcIYou8xRXuOOqREVBYq+oOfqlet9hY02IHS+Sj/6
        dwKOwtaWo3Zycadm8ufuAnG0iTykKIRYX2Zt6wASzQ==
X-Google-Smtp-Source: AMsMyM63vFkqFQ/XTot4Z2F499OIgZ3P+z0mQdszUmqz74FFU4KzGigXy7wS+JLjVY3TUKDRO55RjJ/s5tBQ8hx5r6o=
X-Received: by 2002:a05:6e02:1a41:b0:2fa:969d:fcd0 with SMTP id
 u1-20020a056e021a4100b002fa969dfcd0mr8403581ilv.6.1667253226708; Mon, 31 Oct
 2022 14:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221029024444.gonna.633-kees@kernel.org> <20221029025433.2533810-3-keescook@chromium.org>
In-Reply-To: <20221029025433.2533810-3-keescook@chromium.org>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 31 Oct 2022 14:53:35 -0700
Message-ID: <CAKH8qBtS9UHTVZ8PgFd2fOS1k6MLxot_SDBg2+H5BhoqQTOcGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf/verifier: Take advantage of full
 allocation sizes
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Fri, Oct 28, 2022 at 7:54 PM Kees Cook <keescook@chromium.org> wrote:
>
> Since the full kmalloc bucket size is being explicitly allocated, pass
> back the resulting details to take advantage of the full size so that
> reallocation checking will be needed less frequently.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/bpf/verifier.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1c040d27b8f6..e58b554e862b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1020,20 +1020,23 @@ static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t
>         return dst ? dst : ZERO_SIZE_PTR;
>  }
>
> -/* resize an array from old_n items to new_n items. the array is reallocated if it's too
> - * small to hold new_n items. new items are zeroed out if the array grows.
> +/* Resize an array from old_n items to *new_n items. The array is
> + * reallocated if it's too small to hold *new_n items. New items are
> + * zeroed out if the array grows. Allocation is rounded up to next kmalloc
> + * bucket size to reduce frequency of resizing. *new_n contains the new
> + * total number of items that will fit.
>   *
> - * Contrary to krealloc_array, does not free arr if new_n is zero.
> + * Contrary to krealloc, does not free arr if new_n is zero.
>   */
> -static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
> +static void *realloc_array(void *arr, size_t old_n, size_t *new_n, size_t size)
>  {
>         size_t alloc_size;
>         void *new_arr;
>
> -       if (!new_n || old_n == new_n)
> +       if (!new_n || !*new_n || old_n == *new_n)
>                 goto out;
>
> -       alloc_size = kmalloc_size_roundup(size_mul(new_n, size));
> +       alloc_size = kmalloc_size_roundup(size_mul(*new_n, size));
>         new_arr = krealloc(arr, alloc_size, GFP_KERNEL);
>         if (!new_arr) {
>                 kfree(arr);
> @@ -1041,8 +1044,9 @@ static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
>         }
>         arr = new_arr;
>
> -       if (new_n > old_n)
> -               memset(arr + old_n * size, 0, (new_n - old_n) * size);
> +       *new_n = alloc_size / size;
> +       if (*new_n > old_n)
> +               memset(arr + old_n * size, 0, (*new_n - old_n) * size);
>
>  out:
>         return arr ? arr : ZERO_SIZE_PTR;

[..]

> @@ -1074,7 +1078,7 @@ static int copy_stack_state(struct bpf_func_state *dst, const struct bpf_func_st
>
>  static int resize_reference_state(struct bpf_func_state *state, size_t n)
>  {
> -       state->refs = realloc_array(state->refs, state->acquired_refs, n,
> +       state->refs = realloc_array(state->refs, state->acquired_refs, &n,
>                                     sizeof(struct bpf_reference_state));
>         if (!state->refs)
>                 return -ENOMEM;

Patches 1 & 2 look good, but not sure about this part. We later do the
following in the same routine:

state->acquired_refs = n;

And acquire_reference_state() does "new_ofs = state->acquired_refs;" to append..

Which changes semantics a bit? It used to mean array size, now it
means array capacity.
Should we keep this part as is but add a shortcut to realloc_array
when ksize(ptr) == kmalloc_size_roundup(new size) -> reuse existing
array?
Or am I missing something? (haven't looked too deep)





> @@ -1090,11 +1094,12 @@ static int grow_stack_state(struct bpf_func_state *state, int size)
>         if (old_n >= n)
>                 return 0;
>
> -       state->stack = realloc_array(state->stack, old_n, n, sizeof(struct bpf_stack_state));
> +       state->stack = realloc_array(state->stack, old_n, &n,
> +                                    sizeof(struct bpf_stack_state));
>         if (!state->stack)
>                 return -ENOMEM;
>
> -       state->allocated_stack = size;
> +       state->allocated_stack = n * BPF_REG_SIZE;
>         return 0;
>  }
>
> --
> 2.34.1
>
