Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C47656E79
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiL0TzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiL0TzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:55:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF3426E0;
        Tue, 27 Dec 2022 11:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zpbjvSCk+EA51UMWboDDrs33iyLVu5VoWtLxS3V5gMw=; b=f/LnLhttpMtg/qiw0quRr7RVgS
        tc6p96mH9LqPWEvk93/M7XerMyC+4gENbVshpT2Sed66AubxHDagtrugbFpzn+lmq/jHEGYMVJQVy
        K1jJaNylZ25/llXQfRQAujlGE2Np/WDAZW7pzg5eHazJ93m4KIfsH3BkYr2Jqf5NdQi90vfoRqbXL
        FV0tCDN8tMvuyveI9bkl50tDd5WMtYCUmBsszQGXHjCjxdJkOTgS8dY5LnxB+dy92cxAdi3f5cf8A
        lNXxUu4nDys9QnPmqHekS3P8gjDtvwBoznRZpVOM4gTtgcXb70889+LNUShXfl4/TsZybCidk9EAn
        NsssFbJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pAG2X-008GpV-Bv; Tue, 27 Dec 2022 19:55:09 +0000
Date:   Tue, 27 Dec 2022 19:55:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, alexander.h.duyck@linux.intel.com,
        paulmck@kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_reporting: replace rcu_access_pointer() with
 rcu_dereference_protected()
Message-ID: <Y6tNnQvGGV+JVgC7@casper.infradead.org>
References: <20221227192158.2553-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227192158.2553-1-sj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 07:21:58PM +0000, SeongJae Park wrote:
> +++ b/mm/page_reporting.c
> @@ -356,7 +356,7 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
>  	mutex_lock(&page_reporting_mutex);
>  
>  	/* nothing to do if already in use */
> -	if (rcu_access_pointer(pr_dev_info)) {
> +	if (rcu_dereference_protected(pr_dev_info, true)) {

Pretty sure that passing a bare 'true' is an antipattern.
Instead, document _what_ lock protects us, ie:

	if (rcu_dereference_protected(pr_dev_info,
				      lockdep_is_held(&page_reporting_mutex))) {

Obviously, we took it just one line up, but if code moves around, it
may save us.
