Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423E55B95B3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiIOHuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiIOHuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:50:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B642A73C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:50:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5F2155CD5C;
        Thu, 15 Sep 2022 07:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663228210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QPMXf8st9QQNsPfGUEwhIqebIUz53LTCe5E9TbcfRTQ=;
        b=ZYr9qNQxzsklsYYl7coCcq7ymchiK/WNIvqJ1uPvZ1GUf5Nc+dL8/qlFce+fDiEPs+fMdx
        f9jVAN9AmnT4hsQugo47Ygvp7bKi4NoALlS8WWmF11Z0Wv4PB3NnWjJ35l6B6l4X5kfhYF
        0jnq1TXoBAJJGRoU4hNPfUe212OMkjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663228210;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QPMXf8st9QQNsPfGUEwhIqebIUz53LTCe5E9TbcfRTQ=;
        b=vDypP2EUUxmGsWvZyAHWsypdrDnb1g86jOE3/74otDbyUGZhUjq4yLAb0b4lfG0IsJqfoW
        dAmPJ7IgDrI6dEBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A349133A7;
        Thu, 15 Sep 2022 07:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6sZSOzHZImNeawAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 15 Sep 2022 07:50:09 +0000
Date:   Thu, 15 Sep 2022 09:50:08 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/16] mm/page_alloc: fix obsolete comment in
 deferred_pfn_valid()
Message-ID: <YyLZMAg3y1uqYBrK@localhost.localdomain>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-17-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909092451.24883-17-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 05:24:51PM +0800, Miaohe Lin wrote:
> There are no architectures that can have holes in the memory map within
> a pageblock since commit 859a85ddf90e ("mm: remove pfn_valid_within()
> and CONFIG_HOLES_IN_ZONE"). Update the corresponding comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/page_alloc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 262e8972e019..4cc0232020d2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1929,11 +1929,7 @@ static inline void __init pgdat_init_report_one_done(void)
>  /*
>   * Returns true if page needs to be initialized or freed to buddy allocator.
>   *
> - * First we check if pfn is valid on architectures where it is possible to have
> - * holes within pageblock_nr_pages. On systems where it is not possible, this
> - * function is optimized out.
> - *
> - * Then, we check if a current large page is valid by only checking the validity
> + * We check if a current large page is valid by only checking the validity
>   * of the head pfn.
>   */
>  static inline bool __init deferred_pfn_valid(unsigned long pfn)
> -- 
> 2.23.0
> 

-- 
Oscar Salvador
SUSE Labs
