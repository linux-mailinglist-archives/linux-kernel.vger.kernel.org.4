Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650856ACE72
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCFTu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjCFTum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:50:42 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0734BEA0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:50:35 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s11so43421397edy.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 11:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678132233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGF3eBQCskPypQoa4poy914imrg9HtlxceInjpF7/z4=;
        b=mZ8aHkID3MYrdt/9Uj6MWAdKC+ca9LbPlDVSB+E2WxwydB9b5hNluXDkOI0ZIRIt6H
         JaqJBKlSeEI8ktDXf45lH4gll8I70MjIrn9Qg6DA83IlaJ6dX3Qjr1NoqnHm5SKdzT+1
         G0uXCK/1NJ/BWwryali1SKHJXLIz3z+Q52bu7PKzK4jUpW+a9aHPbHjkAEoBbDiS5xsL
         0xu2/ka/xWdjtna14tYdM/Lav4k2ZAlt4BUNXI5IzpKEaepS1llmLMJLj81yDJiYwQN7
         CHQWI3cMAAN9AdtB8q/EC+tlMFFVpnLa+lE7pEdgigAxXp00OiBF/7NESSZ2NudVvgqH
         /Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678132233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGF3eBQCskPypQoa4poy914imrg9HtlxceInjpF7/z4=;
        b=Luz+O2wAmGobsC4JeBeoMvXC0npr//28vOVpDSBmnhsvSI93WF8OZw591SIRZKbQaX
         oQTQU4chLDNKFZrET+vJvkYb7c8BLNayJAPd3TLbrafUaGTWPy8LkMpeYRaPMdQM4JQ7
         x2bDMh/+HRuezKud/hy94b1SLsQcv+hHvMYQ0QqE7KKRTiBVsjeWijBr33OFFvkJNgJm
         ErElHsEJXzt3G1Gz8N2E+8MZZMfTPnZBpVnSjETtJdJZXEls7La3ut0s77ShC2Ldgy7a
         V7tJVWAtLS9OsIqQ3F8rHdtBiEJGTORejBikulr+Z2FzlvCldvgFxrh8Ykdm1g0yFe1L
         BTqw==
X-Gm-Message-State: AO0yUKV8+Ex9TVMWsT6SkNOYun+pljgrWXlTBSyZP4IHP4AiKA8dgrjh
        /tTppg4v6Rk+wn01yRJsqrwgRwl1qkftKDnJEtO8Iw==
X-Google-Smtp-Source: AK7set/KxagLsz+HgruUKFFw19IQyTEgXRH5QRjlFyA1p1b8uEBesr2ZKqCVm3jOD9bsKoSfy751fj3R+bUQhbTtAt0=
X-Received: by 2002:a50:8711:0:b0:4bb:d098:2138 with SMTP id
 i17-20020a508711000000b004bbd0982138mr6450122edb.5.1678132233505; Mon, 06 Mar
 2023 11:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20230302232758.888157-1-mcgrof@kernel.org> <20230302232758.888157-5-mcgrof@kernel.org>
In-Reply-To: <20230302232758.888157-5-mcgrof@kernel.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 6 Mar 2023 11:49:57 -0800
Message-ID: <CAJD7tkbH5c-D9nvhSW6MNvDiBUBVJTpkJCbNvAamL_a801P7Sg@mail.gmail.com>
Subject: Re: [PATCH 4/6] shmem: skip page split if we're not reclaiming
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, linux-mm@kvack.org, p.raghav@samsung.com,
        da.gomez@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        keescook@chromium.org, patches@lists.linux.dev,
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

On Thu, Mar 2, 2023 at 3:28=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> In theory when info->flags & VM_LOCKED we should not be getting
> shem_writepage() called so we should be verifying this with a
> WARN_ON_ONCE(). Since we should not be swapping then best to ensure
> we also don't do the folio split earlier too. So just move the check
> early to avoid folio splits in case its a dubious call.
>
> We also have a similar early bail when !total_swap_pages so just move
> that earlier to avoid the possible folio split in the same situation.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/shmem.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index a5a6da51087e..6006dbb7dbcb 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1352,6 +1352,12 @@ static int shmem_writepage(struct page *page, stru=
ct writeback_control *wbc)
>                 goto redirty;
>         }
>
> +       if (WARN_ON_ONCE(info->flags & VM_LOCKED))
> +               goto redirty;
> +
> +       if (!total_swap_pages)
> +               goto redirty;
> +
>         /*
>          * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "alway=
s" or
>          * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge p=
ages,
> @@ -1367,10 +1373,6 @@ static int shmem_writepage(struct page *page, stru=
ct writeback_control *wbc)
>         }
>
>         index =3D folio->index;
> -       if (info->flags & VM_LOCKED)
> -               goto redirty;
> -       if (!total_swap_pages)
> -               goto redirty;
>
>         /*
>          * This is somewhat ridiculous, but without plumbing a SWAP_MAP_F=
ALLOC
> --
> 2.39.1
>
