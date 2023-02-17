Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F7F69AF9B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBQPfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBQPfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:35:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFEE6FF1E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mW57kN4nTCLJuRyVbdsv8IvuOujU0onfmLc5EEdibmM=; b=Q5z0XNdVbtxVGcSi4F/3j52gkE
        x6Wq/ee+v0Av4/otISRfB3Dv1eHOI0yI4hCGYPjBgs23Lo7BoGXaxni2jXGN5Rqb1HaSJw53zV+fm
        NY5aVO75TN6hREvKzJw8RpFj2o8hOPG3LI83yANT190VlNeImjW3OhTl6JoLSPgwgGPYCEOURn7cn
        HQQxGMkgJsiCSHzQFIRcxYLSRK0sJ80GP5iwF9OwEYRPWXn5Qc1ZugK0QsuVhOZP8Rs+eZilzb0MT
        ikabJ2tfK8bamSyLmqnbl6F/0Ugpn3xvz7GZ4t9kW0TcgZ6YEjLFD937PcM+pv4VjCn1e+0TQjmPK
        bh+qFM0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pT2lk-00Et7n-UJ; Fri, 17 Feb 2023 15:35:28 +0000
Date:   Fri, 17 Feb 2023 07:35:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexander Sapozhnikov <alsp705@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] mm/vmalloc: fix unsafe dereference of potential null ptr
 in vmalloc_init()
Message-ID: <Y++ewLr68kfX6q9r@infradead.org>
References: <20230217125105.12385-1-alsp705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217125105.12385-1-alsp705@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 03:51:05PM +0300, Alexander Sapozhnikov wrote:
> Return value of a function 'kmem_cache_create' is dereferenced 
> at vmalloc.c:2444 without checking for null, but it is usually 
> checked for this function.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

I think that checker needs to learn about SLAB_PANIC..
