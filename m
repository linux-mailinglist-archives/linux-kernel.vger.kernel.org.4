Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788A4738129
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjFUKUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjFUKU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:20:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2EDEA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:20:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25f0e0bbcaaso1771465a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687342827; x=1689934827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcQaMP8s+AxLjoBlCFXTD9bsymZvwNu0P0OUlN7TZjI=;
        b=VF/f0gKy6Cfk+X4TK5U08DAgZE3/xdFeSomUIfc9CwoE/cEl+FT9Va0B24fqYMBcE+
         g0cS78O6pjUi7FYI76L7hWriU87noXmwP6CyU9ZtlkGPdSz7qDYC3+s6XfwX2yfmZ/Zg
         Dx7y+M6I8tTe/sPZeyV8ZitG0vPDTvHqEgX1DncAREBAGhsFGZEc3JyYyBCK2uAukLAc
         WYkwsH9yYH+jkeqsKIA8Vda8VhHpRZLoUlfuSKKP5Do2DXhTCW6uzXK0ArCrMhCL7fCk
         BewWxWV/Ed1l2UlFbWui71WfgWCrQ9mIcDn4mbmP6o4nXhL2+bT1yfKnUGuSvR93sbrB
         0k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687342827; x=1689934827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcQaMP8s+AxLjoBlCFXTD9bsymZvwNu0P0OUlN7TZjI=;
        b=eTxfsO1RZt3LPx/wZ8YoXW9QaLDZ6F4eg9NKAu0svOAOpyAfBAkJkUw4b4WsVaMhOO
         x7j2US77hKJmQafwvNvG7kjwFn7fB+rJTqaaAJXCCZo2UpZWUPxSLQIMpc4YUAICygLe
         1R6pdPku4Jp0atcpjKkW66V8LC23XCTShS/21n7wrcLpWyPw5WzpclM8oLSXZ4tf8JjS
         lOfNMgyNAOc0S8VvPZYXMCkxbt0/BYH2zfFfWFRW1ldypuMPqAnS8/9ph3q8ORc4K0cj
         MUzquQkZO2vWQTPl6t2ecfopOZutCUvn8Um1vm/NQLWMv7tScpMDkxyXUtfaOTuoU/rp
         2C/Q==
X-Gm-Message-State: AC+VfDxvI3QE3aBX36XAdTbohKE5QIKx0cWFZA5BblfZIlyJYCVkRkaI
        xkIwsbNS99gIolTngNcnyPhL78MNUDa4svalSXY=
X-Google-Smtp-Source: ACHHUZ5Qeg6rt461AK5fIaW73RYdd2qgVi2eyCOOkTm9Vl9NrU2nWM8G+wwqheNzZkJfb8UkCA5IIHINX1hGHAqb8p8=
X-Received: by 2002:a17:90a:7641:b0:25b:ca75:8f44 with SMTP id
 s1-20020a17090a764100b0025bca758f44mr9072244pjl.4.1687342826817; Wed, 21 Jun
 2023 03:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230621093009.637544-1-yosryahmed@google.com>
In-Reply-To: <20230621093009.637544-1-yosryahmed@google.com>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Wed, 21 Jun 2023 12:20:15 +0200
Message-ID: <CA+CLi1gjRJ25HqDpqM3dUkddVbzRJnUhxO=bxq-rEjYz3dUhNA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix double invalidate with exclusive loads
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:30=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> If exclusive loads are enabled for zswap, we invalidate the entry before
> returning from zswap_frontswap_load(), after dropping the local
> reference. However, the tree lock is dropped during decompression after
> the local reference is acquired, so the entry could be invalidated
> before we drop the local ref. If this happens, the entry is freed once
> we drop the local ref, and zswap_invalidate_entry() tries to invalidate
> an already freed entry.
>
> Fix this by:
> (a) Making sure zswap_invalidate_entry() is always called with a local
>     ref held, to avoid being called on a freed entry.
> (b) Making sure zswap_invalidate_entry() only drops the ref if the entry
>     was actually on the rbtree. Otherwise, another invalidation could
>     have already happened, and the initial ref is already dropped.
>
> With these changes, there is no need to check that there is no need to
> make sure the entry still exists in the tree in zswap_reclaim_entry()
> before invalidating it, as zswap_reclaim_entry() will make this check
> internally.
>
> Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/zswap.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 87b204233115..62195f72bf56 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -355,12 +355,14 @@ static int zswap_rb_insert(struct rb_root *root, st=
ruct zswap_entry *entry,
>         return 0;
>  }
>
> -static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *ent=
ry)
> +static bool zswap_rb_erase(struct rb_root *root, struct zswap_entry *ent=
ry)
>  {
>         if (!RB_EMPTY_NODE(&entry->rbnode)) {
>                 rb_erase(&entry->rbnode, root);
>                 RB_CLEAR_NODE(&entry->rbnode);
> +               return true;
>         }
> +       return false;
>  }
>
>  /*
> @@ -599,14 +601,16 @@ static struct zswap_pool *zswap_pool_find_get(char =
*type, char *compressor)
>         return NULL;
>  }
>
> +/*
> + * If the entry is still valid in the tree, drop the initial ref and rem=
ove it
> + * from the tree. This function must be called with an additional ref he=
ld,
> + * otherwise it may race with another invalidation freeing the entry.
> + */

On re-reading this comment there's one thing I'm not sure I get, do we
really need to hold an additional local ref to call this? As far as I
understood, once we check that the entry was in the tree before putting
the initial ref, there's no need for an additional local one.

>  static void zswap_invalidate_entry(struct zswap_tree *tree,
>                                    struct zswap_entry *entry)
>  {
> -       /* remove from rbtree */
> -       zswap_rb_erase(&tree->rbroot, entry);
> -
> -       /* drop the initial reference from entry creation */
> -       zswap_entry_put(tree, entry);
> +       if (zswap_rb_erase(&tree->rbroot, entry))
> +               zswap_entry_put(tree, entry);
>  }
>
>  static int zswap_reclaim_entry(struct zswap_pool *pool)
> @@ -659,8 +663,7 @@ static int zswap_reclaim_entry(struct zswap_pool *poo=
l)
>          * swapcache. Drop the entry from zswap - unless invalidate alrea=
dy
>          * took it out while we had the tree->lock released for IO.
>          */
> -       if (entry =3D=3D zswap_rb_search(&tree->rbroot, swpoffset))
> -               zswap_invalidate_entry(tree, entry);
> +       zswap_invalidate_entry(tree, entry);
>
>  put_unlock:
>         /* Drop local reference */
> @@ -1466,7 +1469,6 @@ static int zswap_frontswap_load(unsigned type, pgof=
f_t offset,
>                 count_objcg_event(entry->objcg, ZSWPIN);
>  freeentry:
>         spin_lock(&tree->lock);
> -       zswap_entry_put(tree, entry);
>         if (!ret && zswap_exclusive_loads_enabled) {
>                 zswap_invalidate_entry(tree, entry);
>                 *exclusive =3D true;
> @@ -1475,6 +1477,7 @@ static int zswap_frontswap_load(unsigned type, pgof=
f_t offset,
>                 list_move(&entry->lru, &entry->pool->lru);
>                 spin_unlock(&entry->pool->lru_lock);
>         }
> +       zswap_entry_put(tree, entry);
>         spin_unlock(&tree->lock);
>
>         return ret;
> --
> 2.41.0.162.gfafddb0af9-goog
>
