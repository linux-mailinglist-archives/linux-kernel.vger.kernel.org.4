Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C066746630
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 01:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjGCXbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 19:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCXbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 19:31:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF54EA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 16:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+FjGWFml8+ZT0b8rY3qqX0B8OTNXfVUrO6Yai+Z1Yn8=; b=AbmctD4xXOqgyXpWNyyWMokas1
        zQ/NtQhjdsd0UHcuKQanPQJi+PLAWXPLque+QmwOSMsHdA3Dx3+aQSgHI8Pw9jgWf7u1FXnBoxT5w
        vNXeTJwKrOO1gIZhw+OIWkQl0UvZ4A+jOK9OlXtwhvt+g2h/fzks8XElAfF1t9jLdkTpxu42XNnTs
        oeKPlqxtoJ8BNH3TnLwohW1PcEx84qVawUxoIEOIaQWkWz8vgKTqm0JcKVYTqyciI/MnYeXIgiIQ7
        55BdgqUqjFYVht7/oLq6tJFm7ug77PtnbLJzx1g+JPvExXD0xILCJwHM8EJAS5IkpGNGzSgUVjMAU
        6PYAtmzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qGT12-008cva-Tn; Mon, 03 Jul 2023 23:31:33 +0000
Date:   Tue, 4 Jul 2023 00:31:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 3/4] mm/memory: convert do_shared_fault() to folios
Message-ID: <ZKNaVJCDH7ac8SCu@casper.infradead.org>
References: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
 <20230703055850.227169-3-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703055850.227169-3-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 10:58:49PM -0700, Sidhartha Kumar wrote:
> Saves three implicit calls to compound_head().
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/memory.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 93480e846ace6..33bf13431974c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4594,6 +4594,7 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	vm_fault_t ret, tmp;
> +	struct folio *folio = page_folio(vmf->page);

You can't call page_folio() until after __do_fault().  Did you test this
series?

>  	ret = __do_fault(vmf);
>  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
