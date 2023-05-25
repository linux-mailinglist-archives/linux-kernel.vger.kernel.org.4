Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57863710957
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240582AbjEYJ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbjEYJ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:57:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AF1E42
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:57:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F9481FDEB;
        Thu, 25 May 2023 09:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685008622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4GNSHGfIZxQ1UhhiGEkHCb26Lr2vl2sDD7sOPkyvdkU=;
        b=MZDYBRU9Bci0RIKRdZfhb12KZdd9o1+5028a4eYfDixTe4z1IdRWSXjk66QO6tzlNaulQy
        WZ1dBfkrIItBPmayNV/8uTD00kaoo20NBU8WkD1phAjgkj00Xdl7uTivdEejt7FHwMMCZp
        mVxs9mvTLhPm9+eWdNcEDUTZV59bBtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685008622;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4GNSHGfIZxQ1UhhiGEkHCb26Lr2vl2sDD7sOPkyvdkU=;
        b=0t/2LQU/B8+fh1GulagPyChZ0uVz9Rj1PtNj04VJ1wXRvIb7YwU/hyR/vQYuKzI5gEJeTc
        ZL4xpARQQtIMHCBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BEBE134B2;
        Thu, 25 May 2023 09:57:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 51s1Bu4wb2TzagAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 25 May 2023 09:57:02 +0000
Message-ID: <df866e1b-a052-4323-8662-cef5d924fa2b@suse.cz>
Date:   Thu, 25 May 2023 11:57:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] mm: compaction: Ensure rescanning only happens on
 partially scanned pageblocks
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230515113344.6869-1-mgorman@techsingularity.net>
 <20230515113344.6869-2-mgorman@techsingularity.net>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230515113344.6869-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 13:33, Mel Gorman wrote:
> compact_zone() intends to rescan pageblocks if there is a failure to
> migrate "within the current order-aligned block". However, the pageblock
> scan may already be complete and moved to the next block causing the
> next pageblock to be "rescanned". Ensure only the most recent pageblock
> is rescanned.
> 
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/compaction.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index c8bcdea15f5f..81791c124bb8 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2464,8 +2464,9 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>  			 * fast_find_migrateblock revisiting blocks that were
>  			 * recently partially scanned.
>  			 */
> -			if (cc->direct_compaction && !cc->finish_pageblock &&
> -						(cc->mode < MIGRATE_SYNC)) {
> +			if (!pageblock_aligned(cc->migrate_pfn) &&
> +			    cc->direct_compaction && !cc->finish_pageblock &&
> +			    (cc->mode < MIGRATE_SYNC)) {
>  				cc->finish_pageblock = true;
>  
>  				/*

