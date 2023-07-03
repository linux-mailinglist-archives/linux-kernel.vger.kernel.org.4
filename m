Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F6B74662E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 01:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjGCX3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 19:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCX3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 19:29:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D767CEA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 16:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wt4a8RXJ2JiYk/Pl31BqCi5HFHSZASXBHI2soh1Xmv0=; b=XAhAkYYNNjRvruE1yDRVPXBErg
        9BfU/bc6Ntz02LFkbsWOLfgjNfbHcn9/v+A/9LWu++OCVgLTgSF8GM13v/uzY8Ibuf920n8vuWxhm
        TgngC213z5oB/3QepAl4a4xmzKTbSHvaoJSOnjW2j7+1wWCQauo/TZ9KB4A7YUd4TpQbQo4qgq1Na
        6l7cnzBAO0TCYt6Lywaa+noX1sGZLeirees01YEM9S6CFhBmkR6ZA1LxG/cBRMSZCF63Q2MYHfAfW
        gEutZAM/qjUNNP0D8wwxUhavZ7gALUekQGwL4FrNOojTLrKk6MigFerLpYYBoOskd6C+3o/CMUR0j
        a4piZS3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qGSz4-008crP-Ki; Mon, 03 Jul 2023 23:29:30 +0000
Date:   Tue, 4 Jul 2023 00:29:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 2/4] mm/memory: convert wp_page_shared() to use folios
Message-ID: <ZKNZ2kY2DGI49DBk@casper.infradead.org>
References: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
 <20230703055850.227169-2-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703055850.227169-2-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 10:58:48PM -0700, Sidhartha Kumar wrote:
> @@ -3296,21 +3297,21 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
>  		tmp = do_page_mkwrite(vmf);

A nice improvement to make after the series might be to pass (vmf,
folio) to save even more calls to compound_head().

