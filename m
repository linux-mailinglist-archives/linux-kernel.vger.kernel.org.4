Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4296B725A29
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbjFGJXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbjFGJXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:23:18 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B581731
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:23:09 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b1c5a6129eso43145131fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686129788; x=1688721788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TMhQ/p0kQE3tBKbaiCedT5vjfwFpJ54BprM1KGdd6w=;
        b=p4ULbLJGXZBAaOZK0w/TjZvKvCaeykMkmTu2Gb2/Ey4bmnzn8H4GS0lteNLmwBX1xb
         4E/kFbwJ7j5wiaLMvDsIuLNaSm1UfOeGCXoaffzV4a/J6HN5kIZo2CGYsfJKZ2OSpHvq
         WFBtGvelO4+IvobP3yKi9Y3g6kvWDGVI4RU1wT0KKTpfY3Q0xKqrbKrIq9m83TpE3tFW
         Hg7+p40jpYFVVXE2NaU9jKF7ovf/a0e1gxKC6i1cYrfTsKgXM6CzZACXHZKbjCMb/N47
         F8aSQ0Gdx0jQVSuNbwfD8r/GVuRZ+UwVempUsJTXzTjaHkYjoiL/+hPw+kVZoQ9CM2lu
         B6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129788; x=1688721788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TMhQ/p0kQE3tBKbaiCedT5vjfwFpJ54BprM1KGdd6w=;
        b=Gqefs7Hs8l3sFkEU4xGiUU9qgFJETemr9zveHpqjZcsx3VUhLv6IsdkZDqpNZo63uK
         ClQ4OTXZ5Z1H5vSKD/Hzdu/pFqERQux4YVNLDpm0VdDlm8rJPKrUFimAVIng4OHcSs7y
         oNsLtk0+p9bpLJgHTiQJfWtr38aJ2Y+dTD5hWnIJS/w6sx7tM+IcFEWdVBfgeiAgXMfp
         X+lXnLBJ89EVz3bW6d2Ukqvn+4LptTkwXDJEVbYbZqEgBCR1jLoKpFwiGpQDIk99ZNhU
         Dd5bGpUpkMz1UpDpa2nKm76obOows59O+7n0id9SikEvpTB+iiP4MrVIrvBk2hFhzKa6
         dbhA==
X-Gm-Message-State: AC+VfDxJCuQAy0G7nQ5L5iWoW/WqrcnPPc9tEP0pHOSAp+so17lsprLk
        Rv6DaOWRTWxzP6lW0hpp5EXtBld3u9+dnWvWERnJJofih5hLvBp7k6gw3w==
X-Google-Smtp-Source: ACHHUZ7I4Be34yWgXdUBEA9/iz5gm3cy/U6XxcFXqE5g8cm+WmKYXvfWdsqbCEB8yGMC/1fZ972YrlbnDUuj6+meeCA=
X-Received: by 2002:a17:907:ea5:b0:96f:d780:5734 with SMTP id
 ho37-20020a1709070ea500b0096fd7805734mr5573691ejc.65.1686129406516; Wed, 07
 Jun 2023 02:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
In-Reply-To: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 7 Jun 2023 02:16:10 -0700
Message-ID: <CAJD7tkad3cWs2CkZE2pV4kzNjn+0crmT2YYpSKU9SynQf7S24Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] mm: zswap: move writeback LRU from zpool to zswap
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, linux-mm@kvack.org, ddstreet@ieee.org,
        sjenning@redhat.com, nphamcs@gmail.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
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

On Tue, Jun 6, 2023 at 7:56=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> This series aims to improve the zswap reclaim mechanism by reorganizing
> the LRU management. In the current implementation, the LRU is maintained
> within each zpool driver, resulting in duplicated code across the three
> drivers. The proposed change consists in moving the LRU management from
> the individual implementations up to the zswap layer.
>
> The primary objective of this refactoring effort is to simplify the
> codebase. By unifying the reclaim loop and consolidating LRU handling
> within zswap, we can eliminate redundant code and improve
> maintainability. Additionally, this change enables the reclamation of
> stored pages in their actual LRU order. Presently, the zpool drivers
> link backing pages in an LRU, causing compressed pages with different
> LRU positions to be written back simultaneously.
>
> The series consists of several patches. The first patch implements the
> LRU and the reclaim loop in zswap, but it is not used yet because all
> three driver implementations are marked as zpool_evictable.
> The following three commits modify each zpool driver to be not
> zpool_evictable, allowing the use of the reclaim loop in zswap.
> As the drivers removed their shrink functions, the zpool interface is
> then trimmed by removing zpool_evictable, zpool_ops, and zpool_shrink.
> Finally, the code in zswap is further cleaned up by simplifying the
> writeback function and removing the now unnecessary zswap_header.
>
> Based on mm-stable + commit 399ab221f3ff
> ("mm: zswap: shrink until can accept") currently in mm-unstable.

I tested this + commit fe1d1f7d0fb5 ("mm: zswap: support exclusive
loads") currently in mm-unstable, using zsmalloc and
CONFIG_ZSWAP_EXCLUSIVE_LOADS=3Dy. I only ran basic zswap tests with
manual writeback induction and made sure everything is sane. I
obviously hope you did more involved testing :)

The only problem I came across is the conflict with fe1d1f7d0fb5, and
I suggested the fix in patch 1. With the fix, everything seems
correct.

So I guess, FWIW for all the patches except 2 & 3 (for zbud and z3fold):
Tested-by: Yosry Ahmed <yosryahmed@google.com>

>
> V2:
> - fixed lru list init/del/del_init (Johannes)
> - renamed pool.lock to lru_lock and added lock ordering comment (Yosry)
> - trimmed zsmalloc even more (Johannes | Nhat)
> - moved ref drop out of writeback function  (Johannes)
>
> Domenico Cerasuolo (7):
>   mm: zswap: add pool shrinking mechanism
>   mm: zswap: remove page reclaim logic from zbud
>   mm: zswap: remove page reclaim logic from z3fold
>   mm: zswap: remove page reclaim logic from zsmalloc
>   mm: zswap: remove shrink from zpool interface
>   mm: zswap: simplify writeback function
>   mm: zswap: remove zswap_header
>
>  include/linux/zpool.h |  19 +-
>  mm/z3fold.c           | 249 +-------------------------
>  mm/zbud.c             | 167 +-----------------
>  mm/zpool.c            |  48 +----
>  mm/zsmalloc.c         | 396 ++----------------------------------------
>  mm/zswap.c            | 186 +++++++++++---------
>  6 files changed, 130 insertions(+), 935 deletions(-)
>
> --
> 2.34.1
>
