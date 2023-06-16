Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03449733A34
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240942AbjFPTwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjFPTwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:52:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C546D269D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:52:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4912461E81
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 19:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C88C433C0;
        Fri, 16 Jun 2023 19:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686945140;
        bh=38PQ8mXTKmNOH9eVGrBGTZ0yea343MVgHP6RoGwZi3E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T5Z5qDMt0Hu62+5cHC0iEgIYOW90YxmvaXyL+RPf6gtCSt5bHm//L0HliL/X1pd3k
         DKe7Gmu31KV6DeR/Ux8wGinhKaSDidZ7pWA/Evc3hXPYytZaBYI4K054oWmcuklJGg
         WKbzBxLGaOKRePS9i5n/Bu08VzCoXYXgZm1lrh5I=
Date:   Fri, 16 Jun 2023 12:52:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] mm:Using div64_ul replaces do_div() function
Message-Id: <20230616125219.dc2346534d6f279a7527c0b0@linux-foundation.org>
In-Reply-To: <20230615075127.6832-1-machel@vivo.com>
References: <20230615075127.6832-1-machel@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 15:51:14 +0800 Wang Ming <machel@vivo.com> wrote:

> Fix the following coccicheck warning:
> 
> mm/mm_init.c:2492:2-8: WARNING: do_div() does a
> 64-by-32 division, please consider using div64_ul instead.

I guess coccicheck was fooled by the incorrect comment over do_div(). 
do_div() returns an unsigned long.

alloc_large_system_hash() should be using a u64 for `max'.  Nobody uses
unsigned long long any more.

> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2508,7 +2508,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>         /* limit allocation size to 1/16 total memory by default */
>         if (max == 0) {
>                 max = ((unsigned long long)nr_all_pages << PAGE_SHIFT) >> 4;
> -               do_div(max, bucketsize);
> +               div64_ul(max, bucketsize);
>         }
>         max = min(max, 0x80000000ULL);

