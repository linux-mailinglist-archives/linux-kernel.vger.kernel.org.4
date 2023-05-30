Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB79D716C16
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjE3SQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjE3SQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:16:43 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DD4B2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:16:41 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f6c6320d4eso25611cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685470601; x=1688062601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kVEj843CHgMv+dCunk1UqfhchtPivldBaBOHjhNqio=;
        b=rnWe8N6fmz34Nmj+miuUcbtMxa9WO2Cj/nDwQB2qMId4XmWz3ogI6p3hfvx/IQrQmS
         Q8i1Epz4HuCdfp36ZX8Jin0/6IqdnA4tfslHqab/T9b+yOOjm0giF1hQTvj7/lapmveN
         /VcdoKqz7w64cvtCPxCxgv3Kr7Q9poRd93/DnBbD4WYi5mNi3lPW0SjofhVSMy1QIx+G
         8AsfJhVB9WP3Njgjw18Y1UD6c07Jd7OrLzTFYs/ZCUxbrrKOoEhMLSZp0ec+Zfa8zUub
         sX/pFd/9liMPgrHIqwByJZm3CqX6nJaGNTXhlonC8E8rK7SVR1HTlMUMfZCZ/8HVoYlN
         oa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685470601; x=1688062601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kVEj843CHgMv+dCunk1UqfhchtPivldBaBOHjhNqio=;
        b=KkXKWrcXiIYyVICIOerJ/DSggKgdntbcpFsqp9VWmgWXZMzFSYCAJ4a6SZ2c+y5tB1
         49iUry4gCBloGjB6bxcT9oHyoqEj24K/OHM5BEcjkB+YqJkpH53nJAuncVC+CELwKzB4
         14Qa7PtBjAtxb/z874kk8H8CbTo29PdAcBEwf84ppIEWV7GdExeiuh1kDZAixjF3KokZ
         O6fBpFlnfHeEgoJh6H5554ZLvR3vcu1//1/LnEGwDTxK7XjEM7NsgbkcbCgR0KYcL7xt
         1fQDOoQY+9V2LQE5TFQq2l2PfOnE6C5v8+Y9aFhUOEy6gabYGBOdhZL+Wzt7W5lq7nF1
         DAqg==
X-Gm-Message-State: AC+VfDxpExzt93Dc+PXwpJS595N+SZ8lu1BDPY7uhIMxt7M1GQhynsOM
        hs9D2U4+OcI9ZFF9XTMSRe0IBDGMbeQ3QR/NhIfenqa4TBgfiTIDmYrf
X-Google-Smtp-Source: ACHHUZ56knjqd5JWW4SGlcgVP5Uoa+bIdal55cK7Ul2sjDA32jT0AibnM5236LiIyGfl5XDekw9XKUPTitMwt5Wwm0w=
X-Received: by 2002:a05:622a:49:b0:3ef:3361:75d5 with SMTP id
 y9-20020a05622a004900b003ef336175d5mr190529qtw.11.1685470600656; Tue, 30 May
 2023 11:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230530163546.986188-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230530163546.986188-1-azeemshaikh38@gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 30 May 2023 11:16:30 -0700
Message-ID: <CANDhNCrZBWFGtt49_Eu=yvKLCxeydXXowbS_9VnTH2E6-wtvzg@mail.gmail.com>
Subject: Re: [PATCH] clocksource: Replace all non-returning strlcpy with strscpy
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-hardening@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org
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

On Tue, May 30, 2023 at 9:35=E2=80=AFAM Azeem Shaikh <azeemshaikh38@gmail.c=
om> wrote:
>
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  kernel/time/clocksource.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 91836b727cef..88cbc1181b23 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -1480,7 +1480,7 @@ static int __init boot_override_clocksource(char* s=
tr)
>  {
>         mutex_lock(&clocksource_mutex);
>         if (str)
> -               strlcpy(override_name, str, sizeof(override_name));
> +               strscpy(override_name, str, sizeof(override_name));
>         mutex_unlock(&clocksource_mutex);
>         return 1;
>  }

Sounds reasonable to me.

Acked-by: John Stultz <jstultz@google.com>

Thanks for submitting this!
-john
