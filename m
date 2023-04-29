Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F506F267A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 23:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjD2VGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 17:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjD2VGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 17:06:12 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD49119A4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 14:06:10 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-32ec968434eso753595ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682802370; x=1685394370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRyE2bDyLHFOuKU5y1Z6rQcuSYgnNs3Rwoy8UxjyT/I=;
        b=MIWfaxja9qHIaA6Uk46nN8K8I0b8FPlrkOW5abmswIJwhJayvhsNvcUuq8fz7Q6Htg
         gbEfrj5+2bvk6oUt9flYEfrumL+3XkTLjnsj4um7NBiLw9YZ+pzS3nUSSAZO2YqT9pd7
         2MBsw4RlWVT3MedAZ0+4p4IuZ/ao/XTNBTt9y84IP1l6VR9vfonmwWIQZnt1RX7qbiC4
         r50C1Tpu93c0O9gsipTEu8d4hHl1IK7PL/P531NYvbxeFhZS6zFF1LMAeTditCCg0cBy
         xBs8UrEpl9OrKbxiuEfm+4XGcv8z17eh1ebmoyr77drTfEKg8i8DKKu7OELm9V6VuQDa
         tgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682802370; x=1685394370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRyE2bDyLHFOuKU5y1Z6rQcuSYgnNs3Rwoy8UxjyT/I=;
        b=dYLPA9aH2KlXOZs3COp/yXC6kVUuCp7kkwUB9AG6aXsY+dUdox27ePSjkV81naUnOo
         74689MVlQVspeOY3t/Ck4iiPojT62BEGrybuS+c0Lt5jNzRR9+7+1cGK0/51gwD6HuEF
         yDQ/CrPtTYFHL46pEO3zs+OwRWZJ9k8Bqa5V43acagR8+XTbseNmxczJgLuM/b3oj7/K
         dos0csPST44JB7uUMhx64EwJNXI4xi91CPEZyl6C/muYFPHvt0SjnntES4H+yA7l6IBD
         p6aMJW0Uez8aOjhpBGbm2Yu5HYVfq+yD1uXfaQ+Vui29ox7f8ldkIE48vUZdZLHZopYx
         IXlw==
X-Gm-Message-State: AC+VfDwdYLqM/8NBm8tYsyKx7KUbYCYbUhjzJDWmqQ9/gS+AKZiromGo
        l699pMXCe2tDCO42tQzSv33QKp/B6MhaiiI64wBpQR3TAFExOfBL9FL18w==
X-Google-Smtp-Source: ACHHUZ7QEmnXVaV5tLNXrheN9Fsqh5gPIkHtCVqbHU+2mORGHMgqsMQUo/fGvxg5Jgv1p3HqakcV8RtlqNufynwM8Bs=
X-Received: by 2002:a05:6e02:1bc3:b0:32c:a94e:b4b2 with SMTP id
 x3-20020a056e021bc300b0032ca94eb4b2mr168370ilv.7.1682802369997; Sat, 29 Apr
 2023 14:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230424102827.58707-1-ukleinek@debian.org>
In-Reply-To: <20230424102827.58707-1-ukleinek@debian.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 29 Apr 2023 14:05:58 -0700
Message-ID: <CAP-5=fUOL0FmtMbLQtRx2-_i6uvbsBLsxaAg54x8umT4npT7iA@mail.gmail.com>
Subject: Re: [PATCH] tools lib symbol: Use -D_FORTIFY_SOURCE=2 for non-debug builds
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@debian.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>
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

On Mon, Apr 24, 2023 at 3:28=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@deb=
ian.org> wrote:
>
> Commit 160be157eaba ("tool lib symbol: Add Makefile/Build") failed to
> define _FORTIFY_SOURCE to 2, probabaly this was cut&pasted from other
> Makefiles with the same problem.
>
> Fixes: 160be157eaba ("tool lib symbol: Add Makefile/Build")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@debian.org>

Acked-by: Ian Rogers <irogers@google.com>

Same problem here I think:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/lib/api/Makefile#n42

Thanks,
Ian

> ---
>  tools/lib/symbol/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/symbol/Makefile b/tools/lib/symbol/Makefile
> index 13d43c6f92b4..4a08cc4e19f2 100644
> --- a/tools/lib/symbol/Makefile
> +++ b/tools/lib/symbol/Makefile
> @@ -39,7 +39,7 @@ endif
>  endif
>
>  ifeq ($(DEBUG),0)
> -  CFLAGS +=3D -D_FORTIFY_SOURCE
> +  CFLAGS +=3D -D_FORTIFY_SOURCE=3D2
>  endif
>
>  # Treat warnings as errors unless directed not to
> --
> 2.39.2
>
