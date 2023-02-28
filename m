Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB01A6A577E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjB1LHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjB1LHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:07:48 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51822ED5A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:07:30 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id e27so792769uan.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rNfciygMzVNBDRrjpdQwJPuhnz4YivqlqvOG4g21Tc0=;
        b=Il/1IkEAW14Ed7gRqLPWJdMYAxdc7D8VH60v2LgxQ0b/80EXAGXRRqwl2hVm2ff7tT
         3KPCr/Ff8TO7D7UBd56HTqrAczLgPyZ7rzZdo3z3kpmrkoAvsdCFgi09qFA1JqhP/KnB
         vBzRDYdLDWdtMYsW2jl1CQ06blyxgeix2Bvu672fybcMOsbz4Hwv6lxsfEgj7+170hiX
         tCWcU7YYcWkM/yQDw6JfmAtS9GdyefFPR88ncXZbQyT6S6Xks2VneJyKT8QxmmjZiYsi
         koky/G60MzyQhoUVh5WRczvtc48hnUQT9W3WWiwfMTdgxI+MhNi53EkHLst+1ewOKEHk
         Hi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNfciygMzVNBDRrjpdQwJPuhnz4YivqlqvOG4g21Tc0=;
        b=En2c46yokkQCQ3BlS8V+MSZcMFZPHeles9M9VVd/ukwG+94Dg+KenQTWdHqulShp3q
         wODyfWeFaYDLp7FlvNtntIMixhByI5WP5KycgNvLT9X0KlUcMmsT3vhUx/GEzO7mgg6D
         7u/E4RZWvKWuUMulbM40wtol7murh1qKEz2J6YUMcgkIi4Fehm7Dm1hXeXlS4IIZ4lw9
         eQ6OY3SnFelbAxMpF6FxvL10uqXA0zUoG3n0zr7pLokKatQBidD7izcRJOIqrY0WNQFo
         ebwu6M4iVGmDfTfC8/K2DBmolybhc5vhqcs/cO1rwPg6PQFm9KLQNxkJsSv69G6Ow8Td
         ROXA==
X-Gm-Message-State: AO0yUKUAgW6B46gImQU9bxzTcrH5LZNpL3W5VecWXKioRP5ibrJXSxFg
        SNYbyDHamMaH5Q/piGkTxCf5Izli8NdMB5bqrJB68w==
X-Google-Smtp-Source: AK7set8xnWEcj0PoN3PFXB/ASvTpJJf4Y9zJxubQeCJYwll+4K8yw0tWai3jHZNMTg/9QEuEjzmPXalUE6Fxe9XMvHY=
X-Received: by 2002:a1f:31c6:0:b0:411:ff57:d3b9 with SMTP id
 x189-20020a1f31c6000000b00411ff57d3b9mr1130074vkx.2.1677582449615; Tue, 28
 Feb 2023 03:07:29 -0800 (PST)
MIME-Version: 1.0
References: <5bf4f1d679e2f80814d07937309602877afd02c6.1677577036.git.Rijo-john.Thomas@amd.com>
In-Reply-To: <5bf4f1d679e2f80814d07937309602877afd02c6.1677577036.git.Rijo-john.Thomas@amd.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 28 Feb 2023 16:37:18 +0530
Message-ID: <CAFA6WYOZwWuMHXGscgK0Lv9Jbt5WHhfhmK+2ZNR6cr2EAbikCw@mail.gmail.com>
Subject: Re: [PATCH 1/1] tee: amdtee: fix race condition in amdtee_open_session
To:     Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        lm0963 <lm0963hack@gmail.com>,
        Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        security@kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 at 15:11, Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>
> There is a potential race condition in amdtee_open_session that may
> lead to use-after-free. For instance, in amdtee_open_session() after
> sess->sess_mask is set, and before setting:
>
>     sess->session_info[i] = session_info;
>
> if amdtee_close_session() closes this same session, then 'sess' data
> structure will be released, causing kernel panic when 'sess' is
> accessed within amdtee_open_session().
>
> The solution is to set the bit sess->sess_mask as the last step in
> amdtee_open_session().
>
> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> ---
>  drivers/tee/amdtee/core.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>

Looks sane to me, FWIW:

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> index 297dc62bca29..372d64756ed6 100644
> --- a/drivers/tee/amdtee/core.c
> +++ b/drivers/tee/amdtee/core.c
> @@ -267,35 +267,34 @@ int amdtee_open_session(struct tee_context *ctx,
>                 goto out;
>         }
>
> +       /* Open session with loaded TA */
> +       handle_open_session(arg, &session_info, param);
> +       if (arg->ret != TEEC_SUCCESS) {
> +               pr_err("open_session failed %d\n", arg->ret);
> +               handle_unload_ta(ta_handle);
> +               kref_put(&sess->refcount, destroy_session);
> +               goto out;
> +       }
> +
>         /* Find an empty session index for the given TA */
>         spin_lock(&sess->lock);
>         i = find_first_zero_bit(sess->sess_mask, TEE_NUM_SESSIONS);
> -       if (i < TEE_NUM_SESSIONS)
> +       if (i < TEE_NUM_SESSIONS) {
> +               sess->session_info[i] = session_info;
> +               set_session_id(ta_handle, i, &arg->session);
>                 set_bit(i, sess->sess_mask);
> +       }
>         spin_unlock(&sess->lock);
>
>         if (i >= TEE_NUM_SESSIONS) {
>                 pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
> +               handle_close_session(ta_handle, session_info);
>                 handle_unload_ta(ta_handle);
>                 kref_put(&sess->refcount, destroy_session);
>                 rc = -ENOMEM;
>                 goto out;
>         }
>
> -       /* Open session with loaded TA */
> -       handle_open_session(arg, &session_info, param);
> -       if (arg->ret != TEEC_SUCCESS) {
> -               pr_err("open_session failed %d\n", arg->ret);
> -               spin_lock(&sess->lock);
> -               clear_bit(i, sess->sess_mask);
> -               spin_unlock(&sess->lock);
> -               handle_unload_ta(ta_handle);
> -               kref_put(&sess->refcount, destroy_session);
> -               goto out;
> -       }
> -
> -       sess->session_info[i] = session_info;
> -       set_session_id(ta_handle, i, &arg->session);
>  out:
>         free_pages((u64)ta, get_order(ta_size));
>         return rc;
> --
> 2.25.1
>
