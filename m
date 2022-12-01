Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B196E63F891
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiLATsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiLATsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:48:11 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D75E5444A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:48:10 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id e26so965011uaa.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nbpk4AkvtKLAPHTKixeSgzLmRJlY8WI7hSqD7VhAlxQ=;
        b=mAR73VxMIhpsSpn+ZYfJYZpFuC/OQBiKV6Hv7ryKTrq7ru56rD6I2rD1d1c0DozVHj
         oeWBiWTle2FTv/tbzT3J1U87aQwBBkEKKH17ISZWygb/CEGMs98Oif75QgNRCVa2vzim
         dlJdNW7RBki0Jf6XTvbJwUupKT/LaAHT04sXmEw9iapUtpLUFaIIp6uuxIJ4ksYhitnQ
         PL5HIv00SQefRQqTqc+PSNFLE3Fu/asJnDvr0SkmH5FpQt8JS8l3dQvC0TSewMUyoFb5
         TXdNWq1QpeVgDJ5JTB2oY7VFDeZOLKbdQt7KgsvnC4AMM33xgBda6uWwmnMAL+h/BbYk
         +NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nbpk4AkvtKLAPHTKixeSgzLmRJlY8WI7hSqD7VhAlxQ=;
        b=ilFukmJMxONDdyh1VklJPqdsanxuZ7MJV3i3ptQaMTAtXeE2LRjGMog1xv27BIJYA+
         M5KD/Ax3fwvqfci+r9HG9qSrPBNYQZ7bixPChU77AItNdZfM1bgyAw+mtgT33am+oK+o
         MQJwKJTyDJ+mypuhi0TJ0xBduLknGM6CLVTDWp3D6+Qgt3qP4eeY/PkkzdFkAaJ4JvPE
         nXQ+NdxtZmkca2QlxK04ranneuW3UT3IXN4Vm5WtWRVKAm5QS+JHkYFTa9urDJG9F588
         tMmfikFs6coJRfJjFp9vT9ynBeR6n0cha8sBYZW09LdHEu7PnSdd26isop4aewX9YS0y
         uwQQ==
X-Gm-Message-State: ANoB5pl/9ypx5Ysx6Z+y5IbipZBN7P5KnV+yA+e0xinzUQgDbQPSLTbw
        oa6cZ03hlqO+ueVqR4pikrqmgSynjsUIM6uTR+DXow==
X-Google-Smtp-Source: AA0mqf6uYhdufcLkfU7zA59TWSwL4ZObP9kf6g4EdoR8h5fZX7uha+sIhP500EtyGBljABMMO/wnjVWDOwFNyhuDzbs=
X-Received: by 2002:ab0:1602:0:b0:3c7:9fbd:a455 with SMTP id
 k2-20020ab01602000000b003c79fbda455mr32052467uae.113.1669924089303; Thu, 01
 Dec 2022 11:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20221201192644.1941049-1-axelrasmussen@google.com>
In-Reply-To: <20221201192644.1941049-1-axelrasmussen@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 1 Dec 2022 12:47:33 -0700
Message-ID: <CAOUHufb8cD_i=RacgeVH5HHwnr++HsXbtGP3Rx9CJi20obHcqg@mail.gmail.com>
Subject: Re: [PATCH] mm: multi-gen LRU: fix LRU size accounting on folio removal
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Steven Barrett <steven@liquorix.net>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Dec 1, 2022 at 12:26 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> When removing a folio from MGLRU, we want to update the LRU size
> accordingly based on the generation it belonged to previously -
> lru_gen_update_size() does this.
>
> The bug here is, set_mask_bits effectively clears the generation bits.
> Ignoring the complexity set_mask_bits is meant to handle, the code being
> changed here is in effect:
>
>     flags = !reclaiming && lru_gen_is_active(lruvec, gen) ? BIT(PG_active) : 0;
>     flags = *folio->flags = (*folio->flags & ~LRU_GEN_MASK) | flags;
>     gen = ((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
>
> In other words, the bug is we clear all of the `LGU_GEN_MASK` bits, and
> then we recalculate `gen` - but of course after clearing the bits
> `flags & LRU_GEN_MASK` is always zero, and so now `gen` is always -1.
>
> So we effectively always call:
>
>     lru_gen_update_size(lruvec, folio, -1, -1);
>
> This leads `lru_gen_update_size` to incorrectly conclude that we're
> **adding**, not removing, a folio. We take this path:
>
>     /* addition */
>     if (old_gen < 0) {
>         /* always false, new_gen is -1 too */
>         if (lru_gen_is_active(lruvec, new_gen))
>             /* ... */
>         __update_lru_size(lruvec, lru, zone, delta);
>         return;
>     }
>
> In other words, when removing, we incorrectly *add* the delta to the
> inactive LRU instead of subtracting.
>
> The fix is simple. We already have the generation number the folio
> belonged to: we set `int gen = folio_lru_gen(folio);` at the top of
> `lru_gen_del_folio`. So, just delete the line incorrectly recalculating
> the generation number.
>
> Fixes: ec1c86b25f4b ("mm: multi-gen LRU: groundwork")
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

NAK.

You are referencing our old (9xx) set_mask_bits(), which returns "new"
(a bad behavior). Its latest version returns "old".

Even if it was a bug:

1. lru_gen_update_size(lruvec, folio, -1, -1) would have been caught by
VM_WARN_ON_ONCE(old_gen == -1 && new_gen == -1).

2. The fix is still wrong, because "gen" read from
folio_lru_gen(folio) is non atomic and can change before
set_mask_bits() finishes.
