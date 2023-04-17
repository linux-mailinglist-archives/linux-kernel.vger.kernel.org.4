Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8F76E46B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDQLou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjDQLor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:44:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64232E58
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:43:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fy21so20327840ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681731821; x=1684323821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvYzdosW+pl7hdpIOnke9mGqwsf21NWemxvx9QGqO7g=;
        b=AJInmT4OcLIEQY+GD2XQHALBCXIcHvQJqMLztaaCbt2SO/Qjzie0qsYDg/cMZin9NY
         i+Lk4tKMoh7EEmPZ234yP49QmA4o+SIAuUTzxNxk5qMrVekL0efcMGk4hzDS/ylir1tC
         jAYp9AOP1pS6eCFAkOLE91xVCTLgPtTpqUdZJuorzWUJj63up2vjB5qWYzloip/RjAA7
         wAjI+BPQhckBSo+VJ3Iy+p1sTnszyTThRpn4Aguj4p7vYms28M3KeCefhPgVeqOxmX7C
         ERoJOyueRav2HAcqejybOPM2AUW4cyRpunPgnW/CEnsO8B5BmTAYT90WYhAhfzExYoxj
         x1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681731821; x=1684323821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvYzdosW+pl7hdpIOnke9mGqwsf21NWemxvx9QGqO7g=;
        b=A+jvmdJwOmuGNMIPuDBI4nB39YlqYEmcsW/GMhfzGcmFuMvm26xv2snk40L3RYgN66
         9bwHi8JqTVlqP89K4uv4aJkv10kdseJw7Nset9ZEKKc2CAtZGbg1Pa6qukqbXiTI0jlL
         5TRUtIRsDjQKs2MxYlVfHrzwkq1QkzOUtclJE9aBhgcHYWYUr74bVrdqhLw1KQgsqfCJ
         6WEf64yFhGPrlnGGl3AHWaxieIJE1SwQb0deqUhGg3jbvQaoPCvrdxZuNAvT41ZuqjFU
         JzTa0mDDJLKcFtPPacjvR8EPe2kdrV4/XmxukSJJ26Xrkel5r8ir5FU1OE+hqLzuTKd0
         r3mg==
X-Gm-Message-State: AAQBX9eWKyJr4hkLO3lUEx9EuSvK9F3h8yjIRE+QjYHnmEvABeBfKzAO
        41JfgF6P1bNar0gy4Uy6RmgPYbP11uOCVp71z+olfQ==
X-Google-Smtp-Source: AKy350btwfqyhvz2GjP4rsO5HviV0z00JGlfvMRNBkF1/rvxruwwQkHN7fuoOYEQbY2b/B3+Pbac+RzAvLFXaJ7JwAs=
X-Received: by 2002:a17:906:48d4:b0:94f:1c69:f309 with SMTP id
 d20-20020a17090648d400b0094f1c69f309mr3146862ejt.15.1681731821217; Mon, 17
 Apr 2023 04:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230304034835.2082479-4-senozhatsky@chromium.org> <20230417050140.1653593-1-senozhatsky@chromium.org>
In-Reply-To: <20230417050140.1653593-1-senozhatsky@chromium.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 17 Apr 2023 04:43:04 -0700
Message-ID: <CAJD7tkYX4JEFwk3yjmMLMCLVPF=8UfFbv1qaPAufcQ++z8XqDQ@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: reset compaction source zspage pointer after putback_zspage()
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

Hi Sergey,

On Sun, Apr 16, 2023 at 10:01=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Fixup.

I think the original patch landed in mm-stable already, so we might
want a proper commit log and fixes tag.

I suspect we want:
Fixes: 5a845e9f2d66 ("zsmalloc: rework compaction algorithm")

>
> Reported-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Otherwise, LGTM.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/zsmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index aea50e2aa350..cc81dfba05a0 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -2239,8 +2239,8 @@ static unsigned long __zs_compact(struct zs_pool *p=
ool,
>                 if (fg =3D=3D ZS_INUSE_RATIO_0) {
>                         free_zspage(pool, class, src_zspage);
>                         pages_freed +=3D class->pages_per_zspage;
> -                       src_zspage =3D NULL;
>                 }
> +               src_zspage =3D NULL;
>
>                 if (get_fullness_group(class, dst_zspage) =3D=3D ZS_INUSE=
_RATIO_100
>                     || spin_is_contended(&pool->lock)) {
> --
> 2.40.0.634.g4ca3ef3211-goog
>
