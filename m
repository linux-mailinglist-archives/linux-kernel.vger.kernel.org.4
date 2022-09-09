Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A035B3FFE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiIITk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiIITkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:40:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D9A14670B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kpoKyQoV4q4nCI29fW8HhVgzf02UIWYkeQLeEr7DdCc=; b=nwfYVX1GzyoWxH8Fna2Ws7mr26
        5B4gbZ5Z45mgPdt8mUSRmXvcKite7R6kmdjRcT7RwYuft+HvZEc9HGCxZB1KU3iGWi30+jK+v4Gd1
        BgRajWnmLpL5+HlPGIOFrBtQIhGvfcLaNdPTbWo8lYkA8tRdCIVu8h2i0M/sGuk+M08dCYAgHaE2S
        kJ68VVJrBkTA5/86h8LFh+sOeteYXduocPK5IGHoMDexELGF62bNJJKKRadmXgAvwJsSu3pjnc1uD
        mQwM5Jof8mXtuHXtAMesy5J75dO7bCiHx7bXTxnKaDqUFns2xXZRqFwL8QyPit/z7VkMWAyhWnfqQ
        +E490VfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWjod-00DVvN-8Y; Fri, 09 Sep 2022 19:37:27 +0000
Date:   Fri, 9 Sep 2022 20:37:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] mm: remove obsolete macro NR_PCP_ORDER_MASK
Message-ID: <YxuV94OgEF5ZQrMv@casper.infradead.org>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909092451.24883-4-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 05:24:38PM +0800, Miaohe Lin wrote:
> Since commit 8b10b465d0e1 ("mm/page_alloc: free pages in a single pass
> during bulk free"), it's not used anymore. Remove it.

Yes, but this patch needs to go further.  The comment is no longer true
(after the patch you mention), so need to also delete these lines:

-/*
- * Shift to encode migratetype and order in the same integer, with order
- * in the least significant bits.
- */
-#define NR_PCP_ORDER_WIDTH 8

and the line:
-                BUILD_BUG_ON(MAX_ORDER >= (1<<NR_PCP_ORDER_WIDTH));

