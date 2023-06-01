Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08157194F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjFAICW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjFAICC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:02:02 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163E11BF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:01:33 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-568928af8f5so9665327b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685606488; x=1688198488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9YFgvxYasGOc52hSkyIdHgDbZQErSjGRMw/oOdPziU=;
        b=KHQ6pezybqAMTHHZ8WiEt5Y4JrHEW01ffkpAxUAmUiroeo/5qdYlrTmnYDVXWXcHGt
         1/mopfyHFotT6CZilwukCVa+wkgmGHftlaD3GaaSoU9E/8SPAEo/oi4Gg3N7GA3bzuQB
         7Bcdd1KfXygyM2G0zqS/T8o/cNVkXFUJ840ORoCp6XtK/56Cm6dyiXyIWVLcLgb7D21e
         LrHPJLWWXabfpK4L0FOIEcu9OMGkCUGDt+XZtzi0bBLjQ0fzlqxufcWZSNGzVMyHC4si
         kC0dOIAssKBI8I5wdkOmnLM21PEZ7ahnfK1DAYIkyHFAesOOFDknuRM+8VPZgFNALw0E
         tmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685606488; x=1688198488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9YFgvxYasGOc52hSkyIdHgDbZQErSjGRMw/oOdPziU=;
        b=FiIqijHVxtJGwsl85d7o09GtpqS4KE1t0tFejlxAWDMmGRwPVs7EjuSaZXBHwXZAd9
         gFAzOLZBpjuJLgaOPX2yvTQbMWrPiLM/bFSQRjNH/be8DuDlZM5rD1lVRi5IV4HksR5P
         W7ynAluU+6G8NH/c97/MsHa75dxtJIswwg6hUWNHFuHU4IJ4aYM1KAfnuV5fLfOuKG51
         GsK2aKA+3yYA3nPfGvMoblXsFbqVz4df1gcL5Xf1J183zUJ7RysMF9gjii7+5NNd+6dn
         +y1EqX9Al+yxFAto3ofTDoZ3FREGYNfCAWOpeRG3zE0zr70tivWSIOfBjGKTqUUgW64V
         M2bA==
X-Gm-Message-State: AC+VfDxt/Zm62UHdzVvSuoYVEJSlfMq98Q1KXyP9grds580sB4fQN/ON
        Kcb9LcdIL0msgTcMEXTo1B80a/hQxx7yas2WiU9lqA==
X-Google-Smtp-Source: ACHHUZ6lblCs2Xm3DyDKlSuHvyjWhitGv4+LXcfblidMGCwWUFHyZMmO48y0apGeQ/v0yHRXEF+K3RFeQEfv0IKfupw=
X-Received: by 2002:a0d:d651:0:b0:55d:626e:3dcf with SMTP id
 y78-20020a0dd651000000b0055d626e3dcfmr1069948ywd.12.1685606488382; Thu, 01
 Jun 2023 01:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230522112058.2965866-1-talumbau@google.com>
In-Reply-To: <20230522112058.2965866-1-talumbau@google.com>
From:   Yuanchu Xie <yuanchu@google.com>
Date:   Thu, 1 Jun 2023 16:01:16 +0800
Message-ID: <CAJj2-QGuYP68ZVfb1PAHmCnS8H+Bzkvpz3c7G9An4=FL-=JApg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 1/4] mm: multi-gen LRU: use macro for bitmap
To:     "T.J. Alumbaugh" <talumbau@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com
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

Reviewed-by: Yuanchu Xie <yuanchu@google.com>

On Mon, May 22, 2023 at 7:21=E2=80=AFPM T.J. Alumbaugh <talumbau@google.com=
> wrote:
>
> Use DECLARE_BITMAP macro when possible.
>
> Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4637f6462e9c..cf18873a36b9 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4144,7 +4144,7 @@ static void walk_pmd_range(pud_t *pud, unsigned lon=
g start, unsigned long end,
>         unsigned long next;
>         unsigned long addr;
>         struct vm_area_struct *vma;
> -       unsigned long bitmap[BITS_TO_LONGS(MIN_LRU_BATCH)];
> +       DECLARE_BITMAP(bitmap, MIN_LRU_BATCH);
>         unsigned long first =3D -1;
>         struct lru_gen_mm_walk *walk =3D args->private;
>
> --
> 2.40.1.698.g37aff9b760-goog
>
