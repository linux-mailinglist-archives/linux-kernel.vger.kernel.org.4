Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1370D722BBA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjFEPp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbjFEPph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:45:37 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8378E54
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:45:06 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-628f267aa5aso22753486d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685979847; x=1688571847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nkLUpVI1lRm5o5xemq0WhMisepgmj/y0uGONlgnlU+A=;
        b=nOGLwaP+U7e8L3HcxgP9meigUb3oKF+35bxZbXYh5Yd2H8J1HwaID+4tNrRb/LxHzn
         DQod8hD+QSWMsxjJEi8fir6WWG5xx+K7JWoMYyslKd/X3i71ddrQAZ5K94P152gPKoxT
         gbTkWqO25P8cQUGyKt6xI/5k/S9BEXqU1zfAlwF0vGfbbJsJY3JSzGlfT/NDV55Hb6Qs
         CqEaDxt8T6ajGoXt/MgIBiGpgqQlHLWE1BeN//5yQcGvPN80Gm3zVWnhMjjuliMvxCjf
         x9+rSfGd46tDrFCUhdF+W6QQlBGcWkcrJLfBdDZ3O3d2pwxtLG4YQGXj/6Z+3EhDOcA0
         h8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685979847; x=1688571847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkLUpVI1lRm5o5xemq0WhMisepgmj/y0uGONlgnlU+A=;
        b=UyUrI2igZx6OZMT9nlwwWSLwiZgEoGAlyU83kLlOZGi9Lc99CaUM29ni+8InkKMY84
         I8x5rAkwdhc61TXFqWehtYL3byBTCp7e3iswzI1he/NOc/x+MFWAEnobwKEIfbJw8xyg
         qrBNzu58GWybcwoxMUoh4hbdqQwh6a0whp6TPkAQsk2+GwN2+Y3XJV3Zzpb/2/phI99v
         cHXQO+MpS5pToLgN83IxhRucV44Y0nHkboRQ+GpBu8i6U+pezVSJh+9EI0a/19FqSYuj
         KTpPeSycZSZNiCZkwKEJxGACtCz24W7SxC6qBKXjpEttJbBaKdN1rSNezgsTFtwIt394
         VV/g==
X-Gm-Message-State: AC+VfDw8nV4A0cjvfArAPWChrp2tWJkZVcfUXJI6ke92pNiuaXuQGp7K
        JaFwbQyFVjoA2RBfoeFYO7URWQ==
X-Google-Smtp-Source: ACHHUZ4NUbgNApLfe1kSENP43g3/Z5rp+V5OU4b4f5roTjrGPmcUF6GOU1MjyEq7GllgINkpoSHyfg==
X-Received: by 2002:a05:6214:765:b0:626:1862:7d75 with SMTP id f5-20020a056214076500b0062618627d75mr6815337qvz.44.1685979846818;
        Mon, 05 Jun 2023 08:44:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ec58])
        by smtp.gmail.com with ESMTPSA id j27-20020a05620a001b00b007592af6fce6sm4258887qki.43.2023.06.05.08.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:44:06 -0700 (PDT)
Date:   Mon, 5 Jun 2023 11:44:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 6/7] mm: zswap: simplify writeback function
Message-ID: <20230605154405.GC221380@cmpxchg.org>
References: <20230605085419.44383-1-cerasuolodomenico@gmail.com>
 <20230605085419.44383-7-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605085419.44383-7-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 10:54:18AM +0200, Domenico Cerasuolo wrote:
> @@ -1142,9 +1122,6 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
>  	zswap_written_back_pages++;
>  
>  	spin_lock(&tree->lock);
> -	/* drop local reference */
> -	zswap_entry_put(tree, entry);
> -
>  	/*
>  	* There are two possible situations for entry here:
>  	* (1) refcount is 1(normal case),  entry is valid and on the tree
> @@ -1152,7 +1129,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
>  	*     because invalidate happened during writeback
>  	*  search the tree and free the entry if find entry
>  	*/
> -	if (entry == zswap_rb_search(&tree->rbroot, offset))
> +	if (entry == zswap_rb_search(&tree->rbroot, swp_offset(swpentry)))
>  		zswap_entry_put(tree, entry);
>  	spin_unlock(&tree->lock);

This can be moved to zswap_shrink() as well. It already has a
post-writeback tree->lock section for lru putback and dropping its
local reference, it should do this as well.

Writeback is then is done after it bumped zswap_written_pages.
