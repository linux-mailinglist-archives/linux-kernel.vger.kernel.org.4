Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9DB710962
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbjEYKBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjEYKBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:01:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D53BE7
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:01:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0857C1FDFA;
        Thu, 25 May 2023 10:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685008879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fcaGKeQO8rFxxr202sw2vP0gVAY2NAJ8aoAl4iO6eiI=;
        b=uGYVCAfPehPquyJjUbhiNx6V2txpsmHSFI7n7xb3M5TKZNcnPJnKCNj49Qb0iJCBoeMyvd
        +4bFUtcHfKSo2Y96UG3nBtg5CYW0cd9XFMskVrzXKaWXLcXT3KUmYCI5DatMUnR+J/EXLP
        xUcxqL8nkaDDrzP1qbmZbzqvZf2z1Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685008879;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fcaGKeQO8rFxxr202sw2vP0gVAY2NAJ8aoAl4iO6eiI=;
        b=xHn03rizVaTYNSQR8imtdC59I4GxgRM+Cy34s73SQeURU+gjTHropE/JX3tAmNFhBkD9Zl
        GproTgmgWXguoODg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8C85134B2;
        Thu, 25 May 2023 10:01:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ycNJNO4xb2S3bQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 25 May 2023 10:01:18 +0000
Message-ID: <f34401f5-48a9-d881-dcbd-2a9fea0a7914@suse.cz>
Date:   Thu, 25 May 2023 12:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] mm: compaction: Only force pageblock scan completion
 when skip hints are obeyed
Content-Language: en-US
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
 <20230515113344.6869-3-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230515113344.6869-3-mgorman@techsingularity.net>
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
> fast_find_migrateblock relies on skip hints to avoid rescanning a recently
> selected pageblock but compact_zone() only forces the pageblock scan
> completion to set the skip hint if in direct compaction.  While this
> prevents direct compaction repeatedly scanning a subset of blocks due
> to fast_find_migrateblock(), it does not prevent proactive compaction,
> node compaction and kcompactd encountering the same problem described
> in commit cfccd2e63e7e ("mm, compaction: finish pageblocks on complete
> migration failure").
> 
> Force the scan completion of a pageblock to set the skip hint if skip
> hints are obeyed to prevent fast_find_migrateblock() repeatedly selecting
> a subset of pageblocks.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/compaction.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 81791c124bb8..accc6568091a 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2456,7 +2456,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>  			}
>  			/*
>  			 * If an ASYNC or SYNC_LIGHT fails to migrate a page
> -			 * within the current order-aligned block, scan the
> +			 * within the current order-aligned block and
> +			 * fast_find_migrateblock may be used then scan the
>  			 * remainder of the pageblock. This will mark the
>  			 * pageblock "skip" to avoid rescanning in the near
>  			 * future. This will isolate more pages than necessary
> @@ -2465,7 +2466,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>  			 * recently partially scanned.
>  			 */
>  			if (!pageblock_aligned(cc->migrate_pfn) &&
> -			    cc->direct_compaction && !cc->finish_pageblock &&
> +			    !cc->ignore_skip_hint && !cc->finish_pageblock &&
>  			    (cc->mode < MIGRATE_SYNC)) {
>  				cc->finish_pageblock = true;
>  

