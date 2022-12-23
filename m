Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80896552D4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiLWQ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbiLWQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:29:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B37A220EB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l8Xt/3atswUT69U09UNdnUFdOKiDOqd4GvHj/Wr9dKo=; b=SeixTs5FTyePf9lvHU0rAXjXcf
        HlW7R06P3fVJ+Ev1gg0H9Id9Zn/eg6YeF8ZYrpX0JlyLCpibAEspHqg52k+R98fZlxd7tXMWzKrRL
        ZuPu4H42QxC/YUVoAVGsF8msM2JnoloeGNWRx7ZDpXCUHWIOcwpxBmbkJ5C2Oepl18uBztjtRas1C
        WxOM9vcf4dPALYEfZSEoB/6nZ1EFRBOEiknYk2dX82HRaV1CjaQjoEgspAbWPtJTLJctbfYamKtnF
        vilnH2l3f+akVkPa7aTeA6Jn0GKxcOhKtN1kz/fldUQ35PB52KFgdqWPNTXHacsnbFneRgKRBXLUB
        chcgcdDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8kum-009z7Z-Cx; Fri, 23 Dec 2022 16:28:56 +0000
Date:   Fri, 23 Dec 2022 08:28:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 03/11] dmapool: use sysfs_emit() instead of scnprintf()
Message-ID: <Y6XXSDuqCC9EoxI6@infradead.org>
References: <20221216201625.2362737-1-kbusch@meta.com>
 <20221216201625.2362737-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216201625.2362737-4-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +		size += sysfs_emit_at(buf, size, "%-16s %4u %4zu %4zu %2u\n",
> +				      pool->name, blocks,
> +				      pages * (pool->allocation / pool->size),
> +				      pool->size, pages);

Did I mention that the sysfs_emit_at API sucks and should just take
size as a pointer argument an auto-increment?

Not really something we can change in this series, though.  So:

Reviewed-by: Christoph Hellwig <hch@lst.de>
