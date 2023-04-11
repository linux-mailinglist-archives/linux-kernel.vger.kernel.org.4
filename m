Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63AC6DD07C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjDKDrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDKDqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:46:43 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11282D6A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:46:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5049a1085cbso1389597a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681184773; x=1683776773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bf8F318nLoefPcMLqCgizA5GRUWcGSjJgJz8T2VD+Io=;
        b=F10UTNF2Qyxk5RMjSwTGkl7Rf55aPy8k7O0CsmZUoSzxuMaPDAnIVrj97DSbA5qkRg
         sVRwyMLr/Yq44CkxllGxs60XrPXeoEMgz8vh6/c8nvkBrJx44y60GQ4eNP5K52z1xJzU
         giuXn2bTnM/yQYmMc5N1tKiD2BArjENB+PY4M3/Bp3TzEWAaBZLmA65SjpaPRfqXr4cX
         iefp+q7S2PZhc++rr1sIvp5sn0sqC9H9xkXZAdAm3wU0fom9QlvIddDFhuamIPhJ1SJ3
         ebzPymbCYnpCN0wtW4dFKbnGPpVask+qj4bBM4aPQyhn22SPaBM6RstHtupugZHJBd5T
         q6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681184773; x=1683776773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bf8F318nLoefPcMLqCgizA5GRUWcGSjJgJz8T2VD+Io=;
        b=62NXRGIqvM0Ytos8rlIuB7sMRMoMg5OUXUlHkLGA3KaStz3vP7f6bu32NyMszblgWJ
         NZeV1jX1qW0Jg22BxjpJ6l2NwXcq9xbmWpub5HlzjS9UrRQkg2Fbr2WefUoMelB1O1R+
         WmDJ4amd4tqekRSK8CAfYrAybRXd32zuPWw2+6+EIVFB700Ah7sx5FhHN/k53F7DimMc
         pyiilANzuHARydpYMr5JE4mEH2/zToFHxI6V8uR+kjQwv/XRZufixFAJWCQOub5h8mps
         8xAaeokiq1zKacwSnPmJMozxifT0a5U4DGm4ZDGf9+0gdwmW7oDBFwMW1ULgkPZlQkd7
         EJWg==
X-Gm-Message-State: AAQBX9dCvblON/uDwqpQmN3+xdXAr/CZWk82sjW3vVXoNnQckXVAK/9e
        CwE/fMT9b09QfUI+Qr99H2Km5rF6xQ14hkNzWMnPAk56XElqwGao+Htm+g==
X-Google-Smtp-Source: AKy350YeLsHM73Hu0Ya1USHFvG75y7APlLwYEeCeHxLAeH7M5mGBtVUs04s9jcVwjJgYCyGcKOUDIediIRq09qNhgyo=
X-Received: by 2002:a50:cddc:0:b0:4fb:9735:f915 with SMTP id
 h28-20020a50cddc000000b004fb9735f915mr5890120edj.8.1681184773077; Mon, 10 Apr
 2023 20:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230411025556.751349-1-senozhatsky@chromium.org>
In-Reply-To: <20230411025556.751349-1-senozhatsky@chromium.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 10 Apr 2023 20:45:36 -0700
Message-ID: <CAJD7tkY-k34JB7ZazXik7bQ7HSvaT1wpMons++Kkc8AHd41XjQ@mail.gmail.com>
Subject: Re: [PATCH] seq_buf: add seq_buf_printk() helper
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
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

On Mon, Apr 10, 2023 at 7:56=E2=80=AFPM Sergey Senozhatsky
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


I tested this with a local patch that I am currently working on that
benefits from this helper, works great.

Tested-by: Yosry Ahmed <yosryahmed@google.com>

>
> ---
>  include/linux/seq_buf.h |  2 ++
>  lib/seq_buf.c           | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index 5b31c5147969..80b78df89809 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -159,4 +159,6 @@ extern int
>  seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
>  #endif
>
> +void seq_buf_printk(struct seq_buf *s, const char *lvl);
> +
>  #endif /* _LINUX_SEQ_BUF_H */
> diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> index 0a68f7aa85d6..9d13004c2324 100644
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c
> @@ -93,6 +93,36 @@ int seq_buf_printf(struct seq_buf *s, const char *fmt,=
 ...)
>  }
>  EXPORT_SYMBOL_GPL(seq_buf_printf);
>
> +/**
> + * seq_buf_printk - printk seq_buf line by line
> + * @s: seq_buf descriptor
> + * @lvl: printk level
> + *
> + * printk()-s a multi-line sequential buffer line by line
> + */
> +void seq_buf_printk(struct seq_buf *s, const char *lvl)
> +{
> +       const char *start, *lf;
> +       int len;
> +
> +       if (s->size =3D=3D 0)
> +               return;
> +
> +       start =3D s->buffer;
> +       while ((lf =3D strchr(start, '\n'))) {
> +               len =3D lf - start + 1;
> +               printk("%s%.*s", lvl, len, start);
> +               start =3D ++lf;
> +       }
> +
> +       /* No trailing LF */
> +       if (start < s->buffer + s->len) {
> +               len =3D s->buffer + s->len - start;
> +               printk("%s%.*s\n", lvl, len, start);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(seq_buf_printk);
> +
>  #ifdef CONFIG_BINARY_PRINTF
>  /**
>   * seq_buf_bprintf - Write the printf string from binary arguments
> --
> 2.40.0.577.gac1e443424-goog
>
