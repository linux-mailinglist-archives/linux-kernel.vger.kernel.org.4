Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531B074662C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 01:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjGCXZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 19:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGCXZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 19:25:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6649BEA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 16:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r6NW5ob5nydgft1g4tMd/ZQ4GrO0FPkqE43DiG6awyM=; b=EEr+L4w47VF/MNPkmxdmKRs/xt
        NFuVkNRnV3/7y2/8pClxkZMTOVVDlVaSku51V+RGR8tqhxJMfx06bmBJmgsI+ei/5Sn/plZxu9v9k
        AmAqxgMmuCDmdov9TfXMeclIdlwWrRwvKmajaeu20K9kSirPhszzcaDdr9U+zIJEEbPIhOnQo/YgY
        vsqy1lqMjdtY8e9DzG2gvE2PHSN5REV/0BhMjxXl3u/j1Rgh0ETjjO2ioPkcsOua128pGjuQ7kY/l
        b1H25oFALLQdC3ERb1K1tHCo7W98yGI4Yh9vUbqG8I12MuPv8BruItqmHYxZRSWcHUTv51y62cEV1
        1I9BeEBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qGSvF-008cjd-37; Mon, 03 Jul 2023 23:25:33 +0000
Date:   Tue, 4 Jul 2023 00:25:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 1/4] mm/memory: convert do_page_mkwrite() to use folios
Message-ID: <ZKNY7XOQFYJoHrBS@casper.infradead.org>
References: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 10:58:47PM -0700, Sidhartha Kumar wrote:
> @@ -2947,14 +2947,14 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
>  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))
>  		return ret;
>  	if (unlikely(!(ret & VM_FAULT_LOCKED))) {
> -		lock_page(page);
> -		if (!page->mapping) {
> -			unlock_page(page);
> +		folio_lock(folio);
> +		if (!folio_mapping(folio)) {

You don't need to call folio_mapping() here.  folio->mapping works
absolutely fine in this circumstance.  In fact, you may have broken a
driver with this change.  I can elaborate more, but I'm not quite in the
mood to do that right now.

