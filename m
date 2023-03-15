Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AD96BBAB2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjCORRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjCORRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:17:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA9B8C958
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:17:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 10ED31FD80;
        Wed, 15 Mar 2023 17:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678900661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hGXv92i+6WyqYwmJ5ByK88Ra0xDBNJ6yk3MGkSS2pXA=;
        b=Yn7U51j0l7q7qAPnT2tXy4RCbSlOBY4bqjajlfYVlkEqf70PnpI9E2cPU6FVhHiXLl9b3e
        eulFLYBJUF075Rvl0JUT3u7v8iIlDjRtqdGyekNbfHBRbRGjmEU4E0G0R2tb4AB/5zSDyg
        NlZrMw7g24i7i2MgXX2CfM3SZW87JYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678900661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hGXv92i+6WyqYwmJ5ByK88Ra0xDBNJ6yk3MGkSS2pXA=;
        b=jAmln1b0xiRxur4+hgmQ6/rnN/zGGb4M2AhBgVX72v+tS9nBZET2lOrVAprhaNfHHoMkXe
        5BSf8Mk+X2LFwGDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0E6513A00;
        Wed, 15 Mar 2023 17:17:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VIcnNrT9EWTEIwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 15 Mar 2023 17:17:40 +0000
Message-ID: <dc8e42cb-325b-83eb-8a5e-3c4cd743a255@suse.cz>
Date:   Wed, 15 Mar 2023 18:17:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] mm: compaction: fix the possible deadlock when
 isolating hugetlb pages
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, osalvador@suse.de,
        william.lam@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1bc1c955b03603c4e14f56dfbbef9f637f18dbbd.1678703534.git.baolin.wang@linux.alibaba.com>
 <a24a86fbae09711e61dc4424aa7aebff718e9995.1678703534.git.baolin.wang@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <a24a86fbae09711e61dc4424aa7aebff718e9995.1678703534.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 11:37, Baolin Wang wrote:
> When trying to isolate a migratable pageblock, it can contain several
> normal pages or several hugetlb pages (e.g. CONT-PTE 64K hugetlb on arm64)
> in a pageblock. That means we may hold the lru lock of a normal page to
> continue to isolate the next hugetlb page by isolate_or_dissolve_huge_page()
> in the same migratable pageblock.
> 
> However in the isolate_or_dissolve_huge_page(), it may allocate a new hugetlb
> page and dissolve the old one by alloc_and_dissolve_hugetlb_folio() if the
> hugetlb's refcount is zero. That means we can still enter the direct compaction
> path to allocate a new hugetlb page under the current lru lock, which
> may cause possible deadlock.
> 
> To avoid this possible deadlock, we should release the lru lock when trying
> to isolate a hugetbl page. Moreover it does not make sense to take the lru
> lock to isolate a hugetlb, which is not in the lru list.
> 
> Fixes: 369fa227c219 ("mm: make alloc_contig_range handle free hugetlb pages")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> ---
>  mm/compaction.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index c9d9ad958e2a..ac8ff152421a 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -893,6 +893,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		}
>  
>  		if (PageHuge(page) && cc->alloc_contig) {
> +			if (locked) {
> +				unlock_page_lruvec_irqrestore(locked, flags);
> +				locked = NULL;
> +			}
> +
>  			ret = isolate_or_dissolve_huge_page(page, &cc->migratepages);
>  
>  			/*

