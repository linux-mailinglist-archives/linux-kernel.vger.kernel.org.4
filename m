Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561AC70D3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjEWGMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbjEWGMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:12:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FBD109
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ixn+rZNZqU08FRWrwa4R0S2pNfRR6ks2apgoACPUtP0=; b=tAhQb7ITM0IVw8kqDWDG1iI34e
        5wjZI67d7Bvjdz3SBtq2hfBj3IX0v0U9et0Xa2nXwb11qNf/Z28zafYPTfJQ5MqxiSDui/7UV4nPi
        xJpNEiw3eGo0urW7+8oflokdeGO7iHnyykS1a83NHWvc3HicrDNy9WJYDHJX0FXKWEugVZL8+JAlZ
        F2rFecMK9pkHyfn37sFrHY3p4IVicFmZK74uWcMNJqV5WtV98KxQGb73ihDM1PFhCAyxeHNROsDnx
        4WgvAdzyyuJKtDowLfwI92iLZ6riqDOAYXDOTOVfSXB2lQKRNg80Sje1UKwuXKdf5+2JYqgnUOhWL
        TvivjCng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1LFg-0092yI-1I;
        Tue, 23 May 2023 06:12:08 +0000
Date:   Mon, 22 May 2023 23:12:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 5/9] mm: vmalloc: Insert busy-VA per-cpu zone
Message-ID: <ZGxZOGpaq9ybRLZ7@infradead.org>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-6-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522110849.2921-6-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  /* Look up the first VA which satisfies addr < va_end, NULL if none. */
> -static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
> +static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)

Please avoid the overly long line.

> +	struct cpu_vmap_zone *z = addr_to_cvz(va->va_start);
> +
>  	/*
>  	 * Remove from the busy tree/list.
>  	 */
> -	spin_lock(&vmap_area_lock);
> -	unlink_va(va, &vmap_area_root);
> -	spin_unlock(&vmap_area_lock);
> +	fbl_lock(z, BUSY);
> +	unlink_va(va, &fbl_root(z, BUSY));
> +	fbl_unlock(z, BUSY);

I find the BUSY magic here very confusing, and would prefer to
just spell the actual lock reference out.
