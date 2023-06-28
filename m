Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B810E741568
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjF1Pkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjF1PkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:40:04 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DE02110
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 08:40:03 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-785d738d3feso1598039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687966803; x=1690558803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOSO4zVpvAMwe82RSNidD+tbsLnsOaD0mj0C5Zdtr28=;
        b=V8aAqZOooDN/qnT93zZgeue1+ka0jZKguF1CMblSS+Ob7R90ZJ2oO9QLsjU5DolgKv
         lgEM7oF2Y97+R8wdWwV42Un6ICHi8ME3E5iE98imfoee/ENxe/t4VpypJWevrRzcvPd7
         b284Dre7/54zfTZjwphANWhWIZy9K+DecNv7Nq7rzy8NnmXiO4W3hzf9XWspxaRfHz5q
         2pPPCwa2PAvKT0DlNOQxVM/K5p+fIp/Bq4RqIQ5ov/U5U6d7poPZJ5OkqPy7U6e8NBZY
         6vif8/TJubhGw1v6s/lwlxMJhrA7Y10rM6M9AHewEhRC7B+HNjvFwtyjp+JbnhiS2+zk
         GAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687966803; x=1690558803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOSO4zVpvAMwe82RSNidD+tbsLnsOaD0mj0C5Zdtr28=;
        b=ORo+9ZAJ8VkRSn6MtsYCOSas8ankNRq3b1vqTqNY1GjY/MoFOGNaM8oJcHT9dvQlJR
         wb0uflzn1hOTLDVmDDWKmvAblC11hZ8f9/KEgK6MeyfNvjGPaD2ckKVlneEsW3GAyErk
         onvysOk/KBcxYwQFaTdiZoZf1rVHPFALxDXkFwuBcKaEpqBnQqk8qxn1iySZHbT+oPBl
         Gzf7YLYciwqYJjJuzbR+KNqNXndYBt6b2/4oPv6YJRPiJy+AdpS2bKb6KC10GT6b5DZD
         WbTUrKvGjzz5HxYKzJrJs4pH9mNSE7FWXuM1wfA4Z+A0PNh92q3GagGqQ7LhKR//QFAl
         O4XA==
X-Gm-Message-State: AC+VfDwE8SA7PY3kuxcGmQxsOIXCVeI2emis/MV43mmFlY7IjjhNMoCz
        e61qW86TEW+MdC2miDM/3P3GQIQGXQ7qqstKRvcpOQ==
X-Google-Smtp-Source: ACHHUZ5E3xJmaCI90D6A1BT+kRyBtFHgb/LjEfnKhF7Ss/PY2Su6NtI4BF50DUWovrNaAX2wnCRS55JeKY1oshzrTZg=
X-Received: by 2002:a6b:7d06:0:b0:783:727a:8e15 with SMTP id
 c6-20020a6b7d06000000b00783727a8e15mr1146287ioq.6.1687966803127; Wed, 28 Jun
 2023 08:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230628153342.53406-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230628153342.53406-1-andriy.shevchenko@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 28 Jun 2023 17:39:26 +0200
Message-ID: <CAG_fn=WjLDsnUPKFwF8XJiyqYP6M+Q9ZqUweRPzPT3dW0i_E+A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] kasan: Replace strreplace() with strchrnul()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
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

On Wed, Jun 28, 2023 at 5:34=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> We don't need to traverse over the entire string and replace
> occurrences of a character with '\0'. The first match will
> suffice. Hence, replace strreplace() with strchrnul().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  mm/kasan/report_generic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> index 51a1e8a8877f..63a34eac4a8c 100644
> --- a/mm/kasan/report_generic.c
> +++ b/mm/kasan/report_generic.c
> @@ -264,6 +264,7 @@ static void print_decoded_frame_descr(const char *fra=
me_descr)
>         while (num_objects--) {
>                 unsigned long offset;
>                 unsigned long size;
> +               char *p;
>
>                 /* access offset */
>                 if (!tokenize_frame_descr(&frame_descr, token, sizeof(tok=
en),
> @@ -282,7 +283,7 @@ static void print_decoded_frame_descr(const char *fra=
me_descr)
>                         return;
>
>                 /* Strip line number; without filename it's not very help=
ful. */
> -               strreplace(token, ':', '\0');
> +               p[strchrnul(token, ':') - token] =3D '\0';

Why not just
   *(strchrnul(token, ':')) =3D '\0';
?
