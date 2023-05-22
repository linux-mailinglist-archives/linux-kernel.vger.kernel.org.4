Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFFB70CE14
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbjEVWib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjEVWi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:38:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A6AC4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:38:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-4d9b2045e1cso1184a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684795105; x=1687387105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OmBpDRSSbwI449wncEKKHIr08pizy/6x6aOd767vrw=;
        b=Je2sOFMeyw4pTXmE/29WmEAUo244TysWAsA0DYFWsnM2gG5UANAC0jyXl/Q3GlDneG
         a0Qb8yIVs7VF5pxprl565rnjkY8SwmCXcV4dH4cmZ7OQVNI3uLxV+OFQ2HXEqY0oADoR
         65J4RJ7YCPJjsxhaYxIxcxNrJTo0abu1P4vIbCDXsf9YWVY0eU7ntUyXHGwzkEOi2MGG
         kAaEFLkAFx5qDeW55/q5NfF+2ErD7boq/7vBaPOrsw5yQcLFMttoYtB6tqGV+pewOPJI
         vSgG68Jq3Wsrak1w2pQJj5L+GY/5NXftoRSnp9WC1OXwa0mtVsMCShK9Y7cCsN7qVPzI
         mxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684795105; x=1687387105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OmBpDRSSbwI449wncEKKHIr08pizy/6x6aOd767vrw=;
        b=le4s+uFyR9JD+NYkR/ZkV1KzscH0IIaniTZEckGNY+bHOayIn+/zyfU+mDtWrGWZ4n
         Rj3ByGZb5gHZEezdweNVovb+DamkLzQuOk/K9y/VFqmgxxd2M01A/cTx8yTcCndVLCKY
         1suBtYqAbscl4UDdM+da9MVlyE2JmbCsYKFNKVjXtyMihk1K/vc/o+GIVPd3c5OKuE0e
         izXPFvABNiuF3h8/o7eODmoOIcViVURthY8x4/5eazrCFvFzIy95SmTEDo0oaJDTPAu/
         HzLKje8T5ZFDLqMeZkNQvYJxhe09JCgKfDzMYM8yabDiUkB/NY2iEhqkDnHLNPQmwS8o
         v9LA==
X-Gm-Message-State: AC+VfDw2brpMXVX6LG9lim9I7luHMqgTevwXO9aBB0urrE1CRaLUh5c6
        QBRE2GUAKgoeJ1oFSvsI7c7giXbkME8pI+pfc7Guc4ezjrgo3a+v4Q==
X-Google-Smtp-Source: ACHHUZ4lJmqdV7xIDj3vLmn1PxNTvQcHwQIDPtQ5dW806lONr5h84EdgwoG2BvvjsS9kQGVQuNBZhF9MeoN/wewjrz4=
X-Received: by 2002:a50:9f05:0:b0:505:863:d85f with SMTP id
 b5-20020a509f05000000b005050863d85fmr42956edf.4.1684795105374; Mon, 22 May
 2023 15:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230522212949.never.283-kees@kernel.org>
In-Reply-To: <20230522212949.never.283-kees@kernel.org>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 22 May 2023 15:38:09 -0700
Message-ID: <CAGG=3QWFHYnUex4ZUYyMp=JNS9PDLjcagkdLbgTdLQf81Xqp_A@mail.gmail.com>
Subject: Re: [PATCH] lkdtm/bugs: Switch from 1-element array to flexible array
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Mon, May 22, 2023 at 2:30=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> The testing for ARRAY_BOUNDS just wants an uninstrumented array,
> and the proper flexible array definition is fine for that.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Bill Wendling <morbo@google.com>

> ---
>  drivers/misc/lkdtm/bugs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 48821f4c2b21..224f42cdddf2 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -305,11 +305,10 @@ static void lkdtm_OVERFLOW_UNSIGNED(void)
>         ignored =3D value;
>  }
>
> -/* Intentionally using old-style flex array definition of 1 byte. */
>  struct array_bounds_flex_array {
>         int one;
>         int two;
> -       char data[1];
> +       char data[];
>  };
>
>  struct array_bounds {
> --
> 2.34.1
>
