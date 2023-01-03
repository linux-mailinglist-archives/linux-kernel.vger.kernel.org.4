Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BF465BA24
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 05:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjACE5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 23:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjACE5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 23:57:38 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F2BB7E6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 20:57:35 -0800 (PST)
Date:   Tue, 3 Jan 2023 04:57:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1672721852; bh=qHT9ynUNePmbez+/aAzqzwd6n3m2y1VpkqHC8LN1MnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTHw1I0H/f6r6okGl49TwcTJbdbBuJ8h9xcEb351bCM6nGPMvlq/xWTpkwiSWmPAB
         QFt56p5DbSSB/P7bONUIHTuhTR0yJXC9Ddh5OQf8w+kHFjCppv3HXY/2EyY8LJ0UPQ
         A+gLjUxdo+XaOstIWGaO4lW7OkmCx/ZuEqST27Y8=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, linux@weissschuh.net
Subject: Re: [PATCH v7 0/6] Implement writeback for zsmalloc
Message-ID: <20230103045730.2ctv3n2ckzzmdzdx@snowball.t-8ch.de>
References: <20221128191616.1261026-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128191616.1261026-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 28, 2022 at 11:16:09AM -0800, Nhat Pham wrote:
> Unlike other zswap's allocators such as zbud or z3fold, zsmalloc
> currently lacks the writeback mechanism. This means that when the zswap
> pool is full, it will simply reject further allocations, and the pages
> will be written directly to swap.
> 
> This series of patches implements writeback for zsmalloc. When the zswap
> pool becomes full, zsmalloc will attempt to evict all the compressed
> objects in the least-recently used zspages.

Then this part of Documentation/admin-guide/mm/zswap.rst should probably
also be updated at some point:

    However, zsmalloc does not implement compressed page eviction, so
    once zswap fills it cannot evict the oldest page, it can only reject
    new pages.

Thomas
