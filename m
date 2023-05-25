Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2652F710D79
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241304AbjEYNmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241320AbjEYNmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:42:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F266195
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:42:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AA83B1FDF9;
        Thu, 25 May 2023 13:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685022134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J4ovSuJuRmCFLGhzW6A11jZKVJnD4mhv9rjFsLceTUM=;
        b=NZGHVrpacj1bueUwX304c5FZsCEY094RVyiYcJWaYFxzKdUtIgqXQmfrqUozuifVAGP3mP
        COU0E+P7gjd6M5IR7vyebxMpc6FmHpfLAcokxZK7GcBPNN4AKxji0zTljgh4ny/BpeI98g
        7QwkpVeYSVFI1FKx9LXyR5WS2rEVd4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685022134;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J4ovSuJuRmCFLGhzW6A11jZKVJnD4mhv9rjFsLceTUM=;
        b=7A/9Xuftxqy8s/wGmj504nIAt5uMTABUQx4C0+LJ0+jGbUi9+q+2LJRu1RHC2agyid0361
        bOxZvdILvChbzdDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87ED213356;
        Thu, 25 May 2023 13:42:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9GNpILZlb2SVVwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 25 May 2023 13:42:14 +0000
Message-ID: <52d922be-419a-de98-9561-7f8275b1c133@suse.cz>
Date:   Thu, 25 May 2023 15:42:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] Revert "Revert "mm/compaction: fix set skip in
 fast_find_migrateblock""
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
 <20230515113344.6869-5-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230515113344.6869-5-mgorman@techsingularity.net>
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
> This reverts commit 95e7a450b819 ("Revert "mm/compaction: fix set skip
> in fast_find_migrateblock"").
> 
> Commit 7efc3b726103 ("mm/compaction: fix set skip in fast_find_migrateblock")
> was reverted due to bug reports about khugepaged consuming large amounts
> of CPU without making progress. The underlying bug was partially fixed
> by commit cfccd2e63e7e ("mm, compaction: finish pageblocks on complete
> migration failure") but it only mitigated the problem and Vlastimil Babka
> pointing out the same issue could theoretically happen to kcompactd.
> 
> As pageblocks containing pages that fail to migrate should now be
> forcibly rescanned to set the skip hint if skip hints are used,
> fast_find_migrateblock() should no longer loop on a small subset
> of pageblocks for prolonged periods of time. Revert the revert so
> fast_find_migrateblock() is effective again.
> 
> Using the mmtests config workload-usemem-stress-numa-compact, the number
> of unique ranges scanned was analysed for both kcompactd and !kcompactd
> activity.
> 
> 6.4.0-rc1-vanilla
> kcompactd
>       7 range=(0x10d600~0x10d800)
>       7 range=(0x110c00~0x110e00)
>       7 range=(0x110e00~0x111000)
>       7 range=(0x111800~0x111a00)
>       7 range=(0x111a00~0x111c00)
> !kcompactd
>       1 range=(0x113e00~0x114000)
>       1 range=(0x114000~0x114020)
>       1 range=(0x114400~0x114489)
>       1 range=(0x114489~0x1144aa)
>       1 range=(0x1144aa~0x114600)
> 
> 6.4.0-rc1-mm-revertfastmigrate
> kcompactd
>      17 range=(0x104200~0x104400)
>      17 range=(0x104400~0x104600)
>      17 range=(0x104600~0x104800)
>      17 range=(0x104800~0x104a00)
>      17 range=(0x104a00~0x104c00)
> !kcompactd
>    1793 range=(0x15c200~0x15c400)
>    5436 range=(0x105800~0x105a00)
>   19826 range=(0x150a00~0x150c00)
>   19833 range=(0x150800~0x150a00)
>   19834 range=(0x11ce00~0x11d000)
> 
> 6.4.0-rc1-mm-follupfastfind
> kcompactd
>      22 range=(0x107200~0x107400)
>      23 range=(0x107400~0x107600)
>      23 range=(0x107600~0x107800)
>      23 range=(0x107c00~0x107e00)
>      23 range=(0x107e00~0x108000)
> !kcompactd
>       3 range=(0x890240~0x890400)
>       5 range=(0x886e00~0x887000)
>       5 range=(0x88a400~0x88a600)
>       6 range=(0x88f800~0x88fa00)
>       9 range=(0x88a400~0x88a420)
> 
> Note that the vanilla kernel and the full series had some duplication of
> ranges scanned but it was not severe and would be in line with compaction
> resets when the skip hints are cleared.  Just a revert of commit 7efc3b726103
> ("mm/compaction: fix set skip in fast_find_migrateblock") showed excessive
> rescans of the same ranges so the series should not reintroduce bug 1206848.
> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1206848
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

My concerns about patch 3/4 don't affect this part so

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/compaction.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index d7be990b1d60..91af6a8b7a98 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1859,7 +1859,6 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
>  					pfn = cc->zone->zone_start_pfn;
>  				cc->fast_search_fail = 0;
>  				found_block = true;
> -				set_pageblock_skip(freepage);
>  				break;
>  			}
>  		}

