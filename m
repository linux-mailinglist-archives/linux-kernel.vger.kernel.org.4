Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8227C72A115
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjFIRSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjFIRSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:18:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B406DC1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=61PEQyEyFh/a5EC3ccv24KEyOK2K+luT3/KMWI7QFEY=; b=Q4VE+vp9G/IbsNK847JEcED+ef
        xWL+lEiEcw3sxhZ9GKTxFTc2Zb7pGHkyvRB7p17c+PLAdha2q3jgdPyWuSmn+XY4zhN0azNN/X2Js
        Bzztd4bvKls4LcyQCokC9Th/5D6Fzd9qs/2fEwsVES3mgosmIaV8sSfLgTQHdhk9XlxeIvtSYFWCi
        DZvbNkdUOk8+byjrln4D4eTKMiRgg/qBQ+GSmPjHwMP3oW8NjQgsJ+HXEQMR57rkTOA+l4f2muWHk
        LZbwOkqDDsT8xbsArWDoFirq2T/ACediM/GaH6PbNIfYVvgVfyerFBLxLbE3BPmT6AalcygHtlggm
        Q4sYZoeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7fl1-00Gpjq-BV; Fri, 09 Jun 2023 17:18:39 +0000
Date:   Fri, 9 Jun 2023 18:18:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kill [add|del]_page_to_lru_list()
Message-ID: <ZINe7xJPI3s6HJG4@casper.infradead.org>
References: <20230609013901.79250-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609013901.79250-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 09:39:01AM +0800, Kefeng Wang wrote:
> Directly call lruvec_del_folio(), and drop unused page interfaces.

Convert isolate_migratepages_block() to actually use folios and
then we can kill the interfaces.

> +++ b/mm/compaction.c
> @@ -1145,7 +1145,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  			low_pfn += compound_nr(page) - 1;
>  
>  		/* Successfully isolated */
> -		del_page_from_lru_list(page, lruvec);
> +		lruvec_del_folio(lruvec, page_folio(page));

This kind of thing is not encouraged.  It's just churn and gets in
the way of actual conversions.
