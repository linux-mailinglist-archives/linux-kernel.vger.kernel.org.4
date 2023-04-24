Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E636EC969
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjDXJu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjDXJu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:50:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5180E2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:50:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5558021A9D;
        Mon, 24 Apr 2023 09:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682329845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ZUgSr94Jx/J73nPOpbJJQSBYtauxCEgSgnwexVfHok=;
        b=DIdAluO2JRmmSp8fUFz7lKfg4S4uiUzaNgWmv5moUiA/xbIWATn03d5WBelqL46BV4D6ZI
        4lnszhrQH0vM37FJEBF4J7OsE1klxfd+mq+Dv+HmFwM/t5JZPOiPChPdF6rh1mh3pB9HmN
        gGdDQPNjN+6LWKxycPua9LphFVz8tf4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 358F61390E;
        Mon, 24 Apr 2023 09:50:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lO/ACvVQRmQjGgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 24 Apr 2023 09:50:45 +0000
Date:   Mon, 24 Apr 2023 11:50:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net, vbabka@suse.cz, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/page_alloc: drop the unnecessary pfn_valid()
 for start pfn
Message-ID: <ZEZQ9EpUY8Mj5TwQ@dhcp22.suse.cz>
References: <9fc85cce8908938f4fd75ff50bc981c073779aa5.1682229876.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fc85cce8908938f4fd75ff50bc981c073779aa5.1682229876.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 23-04-23 18:59:10, Baolin Wang wrote:
> We've already used pfn_to_online_page() for start pfn to make sure

Who is we? I do not see any note explicitly requiring that start_pfn has
to be valid for __pageblock_pfn_to_page.

> it is online and valid, so the pfn_valid() for the start pfn is
> unnecessary, drop it.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> ---
> Changes from v1:
>  - Collect reviewed tags. Thanks David and Ying.
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9de2a18519a1..6457b64fe562 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1512,7 +1512,7 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>  	/* end_pfn is one past the range we are checking */
>  	end_pfn--;
>  
> -	if (!pfn_valid(start_pfn) || !pfn_valid(end_pfn))
> +	if (!pfn_valid(end_pfn))
>  		return NULL;
>  
>  	start_page = pfn_to_online_page(start_pfn);
> -- 
> 2.27.0

-- 
Michal Hocko
SUSE Labs
