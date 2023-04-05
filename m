Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6BC6D83F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjDEQpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDEQp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:45:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB8410FA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ic9QOvyB41Y2i/Y5O+2Wte/XHLF8XILIloIzMxQmtv4=; b=qBB2UMFJ0uk6rP4OhE6b6msGJE
        yBtaGNpZWXKqSIUgTr92VD7DatKS6EceYmT1+NI7p+PbJKwDa0K6kA9wZh3cQ8/4QMvUZYADmvlhC
        3BuZRAPnvpTXNS7+nyXx0KOylpcOIfNuoYdfeSoKxWARTZgBBYWwFh4Hm4Foyt5x8G6czYtUvjoyv
        eEOBZ2GMyZNnvFnYd/Dsc2MGPUJFyY4N4PbM+elXGAHCxKRxotOA/ZAupdUqbGRI5ACMH6F9LxICS
        /LZtsO3ZN1QKd+aSfymlFEDyg4GPCX6p/udQqEcQXQrF+8EQAOPzcat2cgHCutrkh4SUYTaFSHkpN
        s96HGpcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pk6G0-00GYSX-02; Wed, 05 Apr 2023 16:45:12 +0000
Date:   Wed, 5 Apr 2023 17:45:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, lstoakes@gmail.com, mgorman@suse.de,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: swap: fix performance regression on
 sparsetruncate-tiny
Message-ID: <ZC2llw7lNSUHBCq/@casper.infradead.org>
References: <20230405161854.6931-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405161854.6931-1-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 12:18:53AM +0800, Qi Zheng wrote:
> The ->percpu_pvec_drained was originally introduced by
> commit d9ed0d08b6c6 ("mm: only drain per-cpu pagevecs once per
> pagevec usage") to drain per-cpu pagevecs only once per pagevec
> usage. But after converting the swap code to be more folio-based,
> the commit c2bc16817aa0 ("mm/swap: add folio_batch_move_lru()")
> breaks this logic, which would cause ->percpu_pvec_drained to be
> reset to false, that means per-cpu pagevecs will be drained
> multiple times per pagevec usage.

My mistake.  I didn't reaise that we'd need a folio_batch_reinit(),
and indeed we didn't have one until 811561288397 (January 2023).
I thought this usage of percpu_pvec_drained was going to be fine
with being set to false each time.  Thanks for showing I was wrong.

> Fixes: c2bc16817aa0 ("mm/swap: add folio_batch_move_lru()")
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
