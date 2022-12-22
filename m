Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEEC653D31
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 09:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiLVI4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 03:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiLVI4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 03:56:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD5F1D0C8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=zifJKiMitrlfByU/WAVetRdSoX9cyLEqZ48bLhSjFoE=; b=z5juutT7hBzPnwRbRbqEy2ICxR
        bOwEe/myuE1UiHzUvAaVyYt8mUQ/nFTH869usF8sz1lWo+QnG/A/8WM8JpJNweZMFDzbEMvYNStvs
        ZqnjOjDWwdKLWL3UvkkhplOcEgNLOxsMV0W1OjMJ9q8vFZeyMsC2X1vEOpldBpH/hqeDJcRwSQ8wG
        X5ckuMnUIc50sBZ6XLh5zqkfCswR3LpCPBzd7Jjo1fBbLo0boXMMWqPWKksm/0bLPdNyvzHDpwtkE
        Ppsp24OTkxzlhMSVWnoat0izfAw8s0z/O15BtCmavvbXthst32mXP8hOiq57dYn1uunn6TpfRvpHI
        O7Ms1ARg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8HNN-009NHh-IB; Thu, 22 Dec 2022 08:56:29 +0000
Date:   Thu, 22 Dec 2022 00:56:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v2 1/3] mm: vmalloc: Avoid of calling __find_vmap_area()
 twise in __vunmap()
Message-ID: <Y6QbvYfvhUI3J7S+@infradead.org>
References: <20221221174454.1085130-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221221174454.1085130-1-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A sorry.  I need more coffee, this is not the cover letter, but the
patch that introduceѕ find_unlink_vmap_area.

> -	spin_lock(&vmap_area_lock);
> -	unlink_va(va, &vmap_area_root);
> -	spin_unlock(&vmap_area_lock);
> +	if (!list_empty(&va->list)) {
> +		spin_lock(&vmap_area_lock);
> +		unlink_va(va, &vmap_area_root);
> +		spin_unlock(&vmap_area_lock);
> +	}

As mentioned before, I'd much rather move this into the callers.

> +	va = find_unlink_vmap_area((unsigned long) addr);
> +	return __remove_vm_area(va);

This can drop the va local variable now.
