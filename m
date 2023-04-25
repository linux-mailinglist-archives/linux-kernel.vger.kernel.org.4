Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01DB6EE295
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjDYNP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbjDYNPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:15:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F9C14441
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:15:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5066ce4f490so8598035a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682428511; x=1685020511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wXhfSd6ndYRTqgNBH1PmmVW+TxD/lVOKSUIuB8m+tg=;
        b=E8l6cGkSnoQLjIvAoEzcjbGyJ0TTafyFHrsFBBtmN85giHNaqllmeKxkj+WgpamO/o
         TsjOk0ksdNObI484IIMo4+s7aje7IllaIHo8kfPu73xw7suYldbmI4bnntiJ8MvyxAlv
         8cDBGmzX1XFN45o4AgyInXqs9+cBTa1f3jsgBRapgzZwi34SEN9MxIaNWbGHM6mE9f2q
         GlzqrVzZyxXhHdc59NS6eeIeMSxVlxSNJfMYGKStKiABPn0kuc09DrJO3Np1DgcEBnn2
         JKNUf3jPZYwzQqUcjLZKv9BDjDp8DRiGHBLbHDpBR5PKnFpnjFIq4ptfY89o+lPfXs0j
         QdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682428511; x=1685020511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wXhfSd6ndYRTqgNBH1PmmVW+TxD/lVOKSUIuB8m+tg=;
        b=TMccv3lTrK1hGn7XneYHbpezRnJLI8N6rbtXp8AnZ3OBrdP/egCJR2dUp3h+dehjLU
         cRIcnfuvqU6UfHhxj5uUfzlGnQ6QjrHVB0Y3mKEfAIS3DIqjwpz3lKaezP76AZLByrK0
         5t5Q6I0lZ9ZnhymhN3F1Rz352Ryp5M4uaqOmCgbSaLc/kq6Bq7cYvdtNWIWRh0h01vRK
         68q5zs9WVMTZ/vsrpjM81vENaPZX2hyMOs1I6YiLcJjPq2URlQE8/M9Y0bqyYzcgZZ6Z
         cbTIXpOXvRIHyEAvfAJXwFzLQG8/7EgUgV3z3V9M/t2Bf/G/E1JXHOPhgERh2SeXq9K/
         eiwQ==
X-Gm-Message-State: AAQBX9fwXSrNxU1KavNw3T+ERmBRcSOgx37BIpPMB85a1DLO8CND6GG3
        HrS2cA5S6pEo71/gfhRSYIv4S7395V2ebGo7obq2z7udI9SxyGI5bv8=
X-Google-Smtp-Source: AKy350bK7zwfLTdPhvHFpsK1YtSIaoj5WM4s+iXclDhzS2FrjGINbZJ/MxxTYlM9F++HQ4my/BqKeYR6ml5JUztO2OQ=
X-Received: by 2002:aa7:dd47:0:b0:504:9ba0:4f83 with SMTP id
 o7-20020aa7dd47000000b005049ba04f83mr12351553edw.7.1682428510599; Tue, 25 Apr
 2023 06:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230415100110.1419872-1-senozhatsky@chromium.org>
In-Reply-To: <20230415100110.1419872-1-senozhatsky@chromium.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 25 Apr 2023 06:14:33 -0700
Message-ID: <CAJD7tkZf-TfRdXiVHwBBYw8PuptpfmzeKFGmDzB0mGnTYURrrA@mail.gmail.com>
Subject: Re: [PATCHv3] seq_buf: add seq_buf_do_printk() helper
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 3:01=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Sometimes we use seq_buf to format a string buffer, which
> we then pass to printk(). However, in certain situations
> the seq_buf string buffer can get too big, exceeding the
> PRINTKRB_RECORD_MAX bytes limit, and causing printk() to
> truncate the string.
>
> Add a new seq_buf helper. This helper prints the seq_buf
> string buffer line by line, using \n as a delimiter,
> rather than passing the whole string buffer to printk()
> at once.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/seq_buf.h |  2 ++
>  lib/seq_buf.c           | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index 5b31c5147969..515d7fcb9634 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -159,4 +159,6 @@ extern int
>  seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
>  #endif
>
> +void seq_buf_do_printk(struct seq_buf *s, const char *lvl);
> +
>  #endif /* _LINUX_SEQ_BUF_H */
> diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> index 0a68f7aa85d6..45c450f423fa 100644
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c
> @@ -93,6 +93,38 @@ int seq_buf_printf(struct seq_buf *s, const char *fmt,=
 ...)
>  }
>  EXPORT_SYMBOL_GPL(seq_buf_printf);
>
> +/**
> + * seq_buf_do_printk - printk seq_buf line by line
> + * @s: seq_buf descriptor
> + * @lvl: printk level
> + *
> + * printk()-s a multi-line sequential buffer line by line. The function
> + * makes sure that the buffer in @s is nul terminated and safe to read
> + * as a string.
> + */
> +void seq_buf_do_printk(struct seq_buf *s, const char *lvl)
> +{
> +       const char *start, *lf;
> +
> +       if (s->size =3D=3D 0 || s->len =3D=3D 0)
> +               return;
> +
> +       seq_buf_terminate(s);
> +
> +       start =3D s->buffer;
> +       while ((lf =3D strchr(start, '\n'))) {
> +               int len =3D lf - start + 1;
> +
> +               printk("%s%.*s", lvl, len, start);
> +               start =3D ++lf;
> +       }
> +
> +       /* No trailing LF */
> +       if (start < s->buffer + s->len)
> +               printk("%s%s\n", lvl, start);
> +}
> +EXPORT_SYMBOL_GPL(seq_buf_do_printk);
> +
>  #ifdef CONFIG_BINARY_PRINTF
>  /**
>   * seq_buf_bprintf - Write the printf string from binary arguments
> --
> 2.40.0.634.g4ca3ef3211-goog
>

Hey Steven,

Is there a chance this patch makes it in the next merge window? It
would be convenient to have it in Linus's tree so that we can send
patches using the new helper. I am assuming there is no risk involved
in merging an unused helper (but I can easily be wrong :)).

Thanks!
