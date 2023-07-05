Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E838F748EBB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjGEUTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjGEUTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:19:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AC41985
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T0XLnvzn5FkOLIw7q3RfBWKmkfDnS0W7AG/lbyZT7fw=; b=Q8nN/eVzqtRFhuNEk4/aZxiwlf
        b7nmE8lceUwvvkelHvAh5oK6q5zyM86Kco60daX9344Go8jHWsQhYFgnDwjMdBblwWw5YWU5nZ+Lp
        zBH+5PCKSX65joIEYLlpbOw4UK471N0qDkcUmLnMhR/OyZ5qxj57WWKNkEvf41yxTvfoQrrhM0yc9
        5F8C+pmqA0h3nHWwswjhLTC29fyoiuUiOBxiewi/YDVrcCSMIBjUFzgtj247FDte95jEFQZAQQVt4
        oJfH7aftPSAW8CxkGBtSn83CXOLoYpoyoi7WrMECd0vaqo8diyrlZb0LoqVd0aMMf21rHGzI+J/V0
        b1LwHeTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qH8xp-00AORJ-Aq; Wed, 05 Jul 2023 20:19:01 +0000
Date:   Wed, 5 Jul 2023 21:19:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 4/4] mm/memory: convert do_read_fault() to use folios
Message-ID: <ZKXQNa7mikRJWO2M@casper.infradead.org>
References: <20230705194335.273790-1-sidhartha.kumar@oracle.com>
 <20230705194335.273790-4-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705194335.273790-4-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 12:43:35PM -0700, Sidhartha Kumar wrote:
> Saves one implicit call to compound_head()
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> @@ -4543,10 +4544,12 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
>  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
>  		return ret;
>  
> +	folio = page_folio(vmf->page);

Why not move this down to after the call to finish_fault()?  The
compiler should be able to do a better job with that; it may have to
spill it to the stack to preserve it over the function call.

>  	ret |= finish_fault(vmf);
> -	unlock_page(vmf->page);
> +	folio_unlock(folio);
>  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
> -		put_page(vmf->page);
> +		folio_put(folio);
>  	return ret;

