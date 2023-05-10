Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E536FD352
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 02:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbjEJAjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 20:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEJAja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 20:39:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914B33C14
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 17:39:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so45436285ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 17:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683679169; x=1686271169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcViK9IobKDKWPhV8NMoXtvaRoAckuBG9q8Pc6JSThg=;
        b=nXY2qvmGJh7n28CT9igHKbqJhLwZbxCmkmJruRksz7lOOJuVke+sKIur9g8YYh/aOt
         jPCSVSvLW8jbZfXorsMloqZYr0kCzmHAZxlbUDDYNINlHwjKpBqDQisRLHmoiuoXmPwH
         0aHMsLMekAm1ZNNCi5dUMtMEP8cQqiXJzLzbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683679169; x=1686271169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcViK9IobKDKWPhV8NMoXtvaRoAckuBG9q8Pc6JSThg=;
        b=I7FZIkqKFO4LwjQsKCSK/ArUdsoINcbY9BpI20i8WH9pTjhy20bppkkClotBfz1vgP
         oAfZHaXrdjkXGXwUfrxM2wo/2WqYlYevjJM8zuK4gFiqjvx9CCWwLSkIPFN5XHdNPvKy
         a6L0fqzfWt1QWNDH7M+xijanG4Fn6LLVNWBiaq0bKMMx/h9vzPufTeyjhg6RXvPhM5Rx
         5Ik188pyY3/+RjGCmMDpEf13Bk1hSxuWo4/hVjEt/JwkN2gp8Hi+N2w/NDwqIo8LFb41
         LBGHg9TqzfXcCncAkcXPAsytZoBVZBZj7ReXOt9jOxL4jahR6UVscKCEY1WooXa7y3uC
         Shpw==
X-Gm-Message-State: AC+VfDxwkXsqTpzoEsBiaUSLblCda7vNqy8SoQsF8OJG7u5hW+t3ytBt
        KQoWimuM4iVKLA6Ve9mdvdwUNA==
X-Google-Smtp-Source: ACHHUZ7VeUOPvO8vvgYTw9Zp2bTuVqG5xU+a1K/++6VYrIoBAxq1tEqbeBiwSSts7jOHtj9FuOI3cw==
X-Received: by 2002:a17:902:a50b:b0:19a:9880:175f with SMTP id s11-20020a170902a50b00b0019a9880175fmr14549353plq.51.1683679169061;
        Tue, 09 May 2023 17:39:29 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b001aadd0d7364sm2277606plf.83.2023.05.09.17.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 17:39:28 -0700 (PDT)
Date:   Wed, 10 May 2023 09:39:22 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
Subject: Re: [PATCH] zsmalloc: move LRU update from zs_map_object() to
 zs_malloc()
Message-ID: <20230510003922.GF11511@google.com>
References: <20230505185054.2417128-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505185054.2417128-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/05/05 11:50), Nhat Pham wrote:
[..]
> zswap_frontswap_store()            shrink_worker()
>   zs_malloc()                        zs_zpool_shrink()
>     spin_lock(&pool->lock)             zs_reclaim_page()
>     zspage = find_get_zspage()
>     spin_unlock(&pool->lock)
>                                          spin_lock(&pool->lock)
>                                          zspage = list_first_entry(&pool->lru)
>                                          list_del(&zspage->lru)
>                                            zspage->lru.next = LIST_POISON1
>                                            zspage->lru.prev = LIST_POISON2
>                                          spin_unlock(&pool->lock)
>   zs_map_object()
>     spin_lock(&pool->lock)
>     if (!list_empty(&zspage->lru))
>       list_del(&zspage->lru)
>         CHECK_DATA_CORRUPTION(next == LIST_POISON1) /* BOOM */
> 
> With the current upstream code, this issue rarely happens. zswap only
> triggers writeback when the pool is already full, at which point all
> further store attempts are short-circuited. This creates an implicit
> pseudo-serialization between reclaim and store. I am working on a new
> zswap shrinking mechanism, which makes interleaving reclaim and store
> more likely, exposing this bug.
> 
> zbud and z3fold do not have this problem, because they perform the LRU
> list update in the alloc function, while still holding the pool's lock.
> This patch fixes the aforementioned bug by moving the LRU update back to
> zs_malloc(), analogous to zbud and z3fold.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
