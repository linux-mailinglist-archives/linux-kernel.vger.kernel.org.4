Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A7263B8EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiK2Dxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbiK2Dxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:53:45 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9461A429AE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:53:44 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id w23so12172032ply.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e85Faz6GgIj5RPG7ZNJ7BJuuIs9tuL36Xtp8N/AvifE=;
        b=k6Ldwqz5k2/jsAqGYSpp83T+pPxWk6YebVEfHwYJ3Y7IhAV/FrzF84DqkJ1a7LfPhh
         1OPxyFJZ3hnTPLxkjHAUb1jNVH8kEM5nPMMhFmh5PCaT93Ou49Xhqtha5WVLul7O2nJE
         /n8avz/EKrLOwblYRSRJL0RYxqguCeHcwX6I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e85Faz6GgIj5RPG7ZNJ7BJuuIs9tuL36Xtp8N/AvifE=;
        b=r+rAT4VhkBkrt8bIxOLN28GBlif8W40HLGwshXzR7S7KPYzPKOEjj93A1mhsdbm6dA
         pgpjBaGZmlydy/+rpcMS+PBYRGlPBfLuoxmUQbyHEd05bU/Dm/48ckWTRqT+JpPqSaWi
         aG6lonjdAJ/uUNVU5bON6HeRDxgGNd93U6CQIx5irTRlAlSmhBlfSySErtsLgWyHOqck
         ZyAtGkU/A9dc3y/U3YqCXT6wPq6Zfg48IL7Sz7nDL1fU0eZW4UDTAnMyOhQU+8UJwoy6
         aSMxolCRqpehB/a0akZ5CARUQPBXfjhkl4x1ybE98H6swhfaRDx7w0fsp11QMZtrg886
         Whtw==
X-Gm-Message-State: ANoB5pmhmSOECY8qag1Wh+6SvFZbJ0mSZ9+yQLD3e2z1RWlL3AN1spUg
        spYpyqQiVs9pYvAjBkU3543Pdg==
X-Google-Smtp-Source: AA0mqf5biYpNivZ8cXcAobGggJ+cgdUrcREgjS84ZmM9EUvlQ13tn4FvCn2k6rhs0+VDghnOtLwIYw==
X-Received: by 2002:a17:90a:4206:b0:213:2039:64c2 with SMTP id o6-20020a17090a420600b00213203964c2mr63945933pjg.165.1669694024162;
        Mon, 28 Nov 2022 19:53:44 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:2565:b2f5:cacd:a5d9])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b001782aab6318sm9628844plg.68.2022.11.28.19.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 19:53:43 -0800 (PST)
Date:   Tue, 29 Nov 2022 12:53:38 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v7 5/6] zsmalloc: Add zpool_ops field to zs_pool to store
 evict handlers
Message-ID: <Y4WCQhTiCIb8Lj5Z@google.com>
References: <20221128191616.1261026-1-nphamcs@gmail.com>
 <20221128191616.1261026-6-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128191616.1261026-6-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/28 11:16), Nhat Pham wrote:
> This adds a new field to zs_pool to store evict handlers for writeback,
> analogous to the zbud allocator.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> Acked-by: Minchan Kim <minchan@kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
