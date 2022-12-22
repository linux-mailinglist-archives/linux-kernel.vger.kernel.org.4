Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07E0654378
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiLVPBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLVPBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:01:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8627765A6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XTTakKKGONeu99NX+RdV/3iW6zoTQF0qP973mKxDx7o=; b=SHkHag2Mw3rf/y0ZlemtnKyGgN
        1UQs3KD8hyYZp5PhMXDY9Ya6vcEBAvxtZfxWiv67hDP54ogWqz8vOaXOEQwLh2+GdaKvQY95Z5BS6
        Sb/3DD00EHnTNhPfulmeCouQ537B/SvzwGMCwSZsRGdKgQ8hxRDS+aH+7UfZhQZIzy9Kixm2FQv1/
        l3nIddMjv2bXD+Jqz5eMDfKvshGRBGs7ZnJppN4AN2Gb7eTAvYLzejERhxFGesz+ND/fbwp4JyjQn
        gN4WJNn1pYkeotAibbMbn3dhUXwWRSSm7OvXapvBbZOqM7fAIqtDHFiUCHmuwdTHlvQz+8yhkVLum
        eB9CP4Hw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8N4D-00DGeD-Nh; Thu, 22 Dec 2022 15:01:05 +0000
Date:   Thu, 22 Dec 2022 07:01:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 1/3] mm: vmalloc: Avoid of calling __find_vmap_area()
 twise in __vunmap()
Message-ID: <Y6RxMQnevF++FlRG@infradead.org>
References: <20221221174454.1085130-1-urezki@gmail.com>
 <Y6QbvYfvhUI3J7S+@infradead.org>
 <Y6RsmcvZ8Ru211Jk@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6RsmcvZ8Ru211Jk@pc636>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 03:41:29PM +0100, Uladzislau Rezki wrote:
> Do you mean like:

Yes.
