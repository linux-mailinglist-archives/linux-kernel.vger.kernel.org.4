Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4C75B955B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiIOH1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIOH1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:27:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B28E999
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:26:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3AD7C22BFB;
        Thu, 15 Sep 2022 07:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663226777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OP4fCqJiZrcUBoKZtnNq2ubY4gQ9sGvrUFWRv/Jwd/8=;
        b=K6GXXjYpighhPMObs6jla85a3QvKkacXUh11NLyl+oTFryVPxyaw8fj1E3ROZ48YWBp4GD
        ylKX5OP5dqK92ul5gys/9sQXX8/ocD+vvqd9gBXmGP1z3BusRqurtGncmiDQ+xbDe0QQYK
        ZKIZHW5Un18Ef3+6uRc1X5WSWINm9Jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663226777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OP4fCqJiZrcUBoKZtnNq2ubY4gQ9sGvrUFWRv/Jwd/8=;
        b=IC79jF+zy7RedPVgN783FEHhP5C2PJJNjw0IdxBcm21zLn4/8gkp4iSripdalf5Hdxuwdn
        3Bp/9HEokb2bgkCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA629133A7;
        Thu, 15 Sep 2022 07:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SSmoLpjTImOfYQAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 15 Sep 2022 07:26:16 +0000
Date:   Thu, 15 Sep 2022 09:26:15 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/16] mm/page_alloc: add missing is_migrate_isolate()
 check in set_page_guard()
Message-ID: <YyLTl8FvmcRuUYi9@localhost.localdomain>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-9-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909092451.24883-9-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 05:24:43PM +0800, Miaohe Lin wrote:
> In MIGRATE_ISOLATE case, zone freepage state shouldn't be modified as
> caller will take care of it. Add missing is_migrate_isolate() here to
> avoid possible unbalanced freepage state.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Ok, I gave it some thought and I guess it's safe to assume that this would happen if
someone isolates the block, and then we face an MCE failure/soft-offline on a page
within that block.

take_page_off_buddy
 break_down_buddy_pages
  set_page_guard

will trigger __mod_zone_freepage_state(), which already had been triggered back
when the block was isolated.

I think the changelog could grow fatter to better explain the issue.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/page_alloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a35ef385d906..94baf33da865 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -873,7 +873,8 @@ static inline bool set_page_guard(struct zone *zone, struct page *page,
>  	INIT_LIST_HEAD(&page->buddy_list);
>  	set_page_private(page, order);
>  	/* Guard pages are not available for any usage */
> -	__mod_zone_freepage_state(zone, -(1 << order), migratetype);
> +	if (!is_migrate_isolate(migratetype))
> +		__mod_zone_freepage_state(zone, -(1 << order), migratetype);
>  
>  	return true;
>  }
> -- 
> 2.23.0
> 

-- 
Oscar Salvador
SUSE Labs
