Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AD4705FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjEQGXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjEQGXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:23:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7972D4C;
        Tue, 16 May 2023 23:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6Yrk/M1EbXl/kX00xJrpSXS6oPhvx6jBCa0pOVA/Fvc=; b=QLDKcIxhaZeTjAcqCHut7E8taM
        v7znFgRP6KTVpBFix3YkEYzXxV40cbqE+nriHreHGbeq1lVmYHPi9gbGyfalBYM8m/kJRf29g2TGj
        6288yslVoRO2W20wdV22BmtyVcK5CbVSujD6TcvFeIZzdYpF+plAfgYIAThSlN2gvTcFC4a+uAt/4
        HNmGtNjgjK0Se3xZA0LoYQ9Y5cgnzmKumNV1kq/ACjaORyilNCwsGOrbZdk0ULsLamcM+t0dEMI1z
        nzK0Le7jU2Sp+7r+boAnqrz6EUhmfqY+HeAA20EJo41stcXNd3CZctwDtd95HnD7vM/K15OR3U5BP
        G0cYmEWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzAYq-008QEK-1i;
        Wed, 17 May 2023 06:22:56 +0000
Date:   Tue, 16 May 2023 23:22:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ruihan Li <lrh2000@pku.edu.cn>
Cc:     linux-mm@kvack.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.comm,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] usb: usbfs: Enforce page requirements for mmap
Message-ID: <ZGRywDdN97RN1s/9@infradead.org>
References: <20230515130958.32471-1-lrh2000@pku.edu.cn>
 <20230515130958.32471-2-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515130958.32471-2-lrh2000@pku.edu.cn>
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

On Mon, May 15, 2023 at 09:09:55PM +0800, Ruihan Li wrote:
> To address these issues, this patch introduces hcd_alloc_coherent_pages,
> which addresses the above two problems. Specifically,
> hcd_alloc_coherent_pages uses gen_pool_dma_alloc_align instead of
> gen_pool_dma_alloc to ensure that the memory is page-aligned. To replace
> kmalloc, hcd_alloc_coherent_pages directly allocates pages by calling
> __get_free_pages.

This looks reasonable in that it fixes the bug.  But I really don't
like how it makes the mess of USB allocation APIs even messier :P

Not really your faul, but someone really needs to look into the usb
memory allocators and DMA mapping, which is tied to that and just as
bad.
