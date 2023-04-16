Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC046E3560
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 08:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDPGSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 02:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjDPGSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 02:18:09 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495C72114
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 23:18:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u3so4110537ejj.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 23:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681625887; x=1684217887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzhWCHot5hqSnwZnXgtyoR6pDos1fuuJxKpZlUkcvNI=;
        b=j6xNCD38E/JfJZs0fIG1gHThqHjY13ZFlyhTRXu2dJkJ5tb8I3VvGd5kd91K7g1c9K
         Qx8Ug1E3UzYj66j8jHnHO9rDji/WFCJyAY6il4sIDw39HxA4Lc6mjtPbYWVbJqZFo6cb
         uwtBfYoc4f5O7mr8J9iBRXXo5phyr5Lh22lvB7kYOdGlxHhjFMwhmficT1ZRC22QHxd3
         vV0vczbZCOzcBse8E1Z2wmrcBj86TMKkhBieMMHYMGsHVolB7tLE3dYAmiT93YRL8Y95
         whoNheyDoGvuZNMwJQhVNbdUt6jf8Ks9biXImYPTWE1VjNDAjjQ1ykL/7YB90g0gAeFb
         UDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681625887; x=1684217887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzhWCHot5hqSnwZnXgtyoR6pDos1fuuJxKpZlUkcvNI=;
        b=dmUIt9EpU7NeLHWgwjlUzGCkdMkTCI8rl94mcySbYnCdNfeG1IAuNgr09DOgAKUErF
         kiGmD5SFMv91nA6BHyI2mZHdRzrm4RdnctWnPUpnBUtwk/IqBusNgdnXVXZHmzDMbeKK
         YK7GADnF3SwBbAWBYuHrdHx77n0rwK78oPHAPRC+O61HcjHuEhJ+rNXI2JC+Uxe4grKG
         GxjZnopKkHwBqsriq7BE14taJCc7+OuUjFBjQExpjYRcEinbwhnJl1AZVkfRs9i7+TdA
         +fiiFcgpQJZ+HQMOEXHnzyCnu1ztMGau0mULEtx393wwQTzJ4SZGfkFfPKJU0YIMbe+n
         BSNQ==
X-Gm-Message-State: AAQBX9dcCy+9pN4cXkCPqmMd/Nmd1QqAQDp47G/D5/sxHrX/tVYzBOgB
        as8KeHBaV392swttVv32dEBYw8t80yY01FChi0JXmQ==
X-Google-Smtp-Source: AKy350a65nF9KkZ3Q9X+bZ+hkS6IsdKkd2NcUjURvhvFw+igyAJYzQRCX1dWez9l/QM37/SV83Fhc/ZZIqR//BfSlMM=
X-Received: by 2002:a17:906:7b52:b0:94a:597f:30ee with SMTP id
 n18-20020a1709067b5200b0094a597f30eemr1542522ejo.15.1681625886602; Sat, 15
 Apr 2023 23:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230415100110.1419872-1-senozhatsky@chromium.org>
In-Reply-To: <20230415100110.1419872-1-senozhatsky@chromium.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sat, 15 Apr 2023 23:17:29 -0700
Message-ID: <CAJD7tkbUV_ac7+Q+yzZdY_MGyNnpiGoz3ftaiAbQcOQ_Rt_Ydw@mail.gmail.com>
Subject: Re: [PATCHv3] seq_buf: add seq_buf_do_printk() helper
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Tested-by: Yosry Ahmed <yosryahmed@google.com>

Thanks!
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
