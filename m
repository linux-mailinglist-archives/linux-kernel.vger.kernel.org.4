Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D1970D3A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjEWGIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjEWGIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:08:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04DD109
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=owdq4bOKhiwEwPqay2Uzo5vGXFeLCMdjpZNuyI6GdYE=; b=RO1JUnR/Vl76GI5e7oIoVCDMFL
        60b7wwVYKzB424v4KXseBhfAmA5NNwHS1YmsBUKY36zoIJrjyTe33ITJ3M+ZmQSqkwXkw/QfjX8uO
        10nmEzrSxiMJ+RBjTKUR3U7XE70hf18yDEAn+MzFDrPggztPIX64sBaWvy1O7Leek2wUTZsIjT+gp
        U7b+laX4uAx3POHayAnl4Imo/QsJeqNrk0mF4NRaFkUS3hvpRh42P7eOuYNaKf3m2MpqWEv/i5qcM
        Z/4J9NRw41NIllV/SmoCh74hBQeN9uHSVvzoUBzR0UcjgrCHwmKdlJk25H9fptOnLkfUDmC4kPQms
        bR0NWZkA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1LCI-0092f5-2r;
        Tue, 23 May 2023 06:08:38 +0000
Date:   Mon, 22 May 2023 23:08:38 -0700
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
Subject: Re: [PATCH 4/9] mm: vmalloc: Add a per-CPU-zone infrastructure
Message-ID: <ZGxYZlLoADBWktT8@infradead.org>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-5-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522110849.2921-5-urezki@gmail.com>
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

On Mon, May 22, 2023 at 01:08:44PM +0200, Uladzislau Rezki (Sony) wrote:
> +#define fbl(z, i, m) z->fbl[i].m
> +#define fbl_root(z, i) fbl(z, i, root)
> +#define fbl_head(z, i) fbl(z, i, head)
> +
> +#define fbl_lock(z, i) spin_lock(&fbl(z, i, lock))
> +#define fbl_unlock(z, i) spin_unlock(&fbl(z, i, lock))

Even if it is just temporary, I don't think adding these wrappers
make much sense.

> +struct cpu_vmap_zone {
> +	/*
> +	 * FREE, BUSY, LAZY bookkeeping data of this CPU zone.
> +	 */
> +	struct {
> +		struct rb_root root;
> +		struct list_head head;
> +		spinlock_t lock;
> +	} fbl[NFBL];

Maybe replace NFBL with something longer and more descriptive?

But also in general it feels like this should be folded into a patch
doing real work.  As-is it doesn't look very useful.
