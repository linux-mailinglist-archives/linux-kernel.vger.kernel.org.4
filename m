Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1394C60363C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJRWvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJRWvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:51:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1795AC4B0;
        Tue, 18 Oct 2022 15:51:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C4DDB81F68;
        Tue, 18 Oct 2022 22:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BB5C433C1;
        Tue, 18 Oct 2022 22:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666133498;
        bh=PLolGzFjkspOWqmPEYf07SMZh4xTpXtSwabOm4Hm2xI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=reBMnFYqHw2C1ezSHVnffqGHCxVov0NPKvjwCe82d9znSjLz06dqyMmcqimENxLdx
         yStmP1W4fyPWdzqzxdNfxb3qU3Toj4w6Wb+U9sAmdimARcHrWFW7tW51DbJ5t6j7e/
         G7AoOu2gxT1ANNtfFZ9XnXRo+XKy8kIqzkOzysZQ=
Date:   Tue, 18 Oct 2022 15:51:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mempool: Use kmalloc_size_roundup() to match ksize()
 usage
Message-Id: <20221018155137.f6898d165aade2e3a5f0b2d3@linux-foundation.org>
In-Reply-To: <20221018090323.never.897-kees@kernel.org>
References: <20221018090323.never.897-kees@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 02:03:29 -0700 Kees Cook <keescook@chromium.org> wrote:

> Round up allocations with kmalloc_size_roundup() so that mempool's use
> of ksize() is always accurate and no special handling of the memory is
> needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.

Confused.  If the special handling is not needed, why doesn't the patch
removed the no longer needed special handling?

> 
> diff --git a/mm/mempool.c b/mm/mempool.c
> index 96488b13a1ef..0f3107b28e6b 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -526,7 +526,7 @@ EXPORT_SYMBOL(mempool_free_slab);
>   */
>  void *mempool_kmalloc(gfp_t gfp_mask, void *pool_data)
>  {
> -	size_t size = (size_t)pool_data;
> +	size_t size = kmalloc_size_roundup((size_t)pool_data);
>  	return kmalloc(size, gfp_mask);
>  }
>  EXPORT_SYMBOL(mempool_kmalloc);
> -- 
> 2.34.1
