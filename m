Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191726EF78B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241189AbjDZPKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240792AbjDZPKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:10:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA98FF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 08:10:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0B21D1FDD3;
        Wed, 26 Apr 2023 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682521815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dWbJXquLq0HXw9J9WboI99XWgz39K8W0xoVom0FsQAI=;
        b=u45u/h7+AK8frS2ho36XCAZj2I/9cFcXCFzbVBRgE2gChmo98PM7wDysxyzugO85vhLoAq
        9xJKA13bQ2F4LHM2lQofnv83l6IJbwN7l2/pNA12fmP1oFQlvEfZPsg2v9FtZnShxMyz50
        4mDiq9OyoKe6vsJCBNoQMbF9g8r2+EQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682521815;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dWbJXquLq0HXw9J9WboI99XWgz39K8W0xoVom0FsQAI=;
        b=GRKkt2gc6+JiiRVgH/UDKxHSN8CDIcVfQrbTG/PJNT2NyQOwiU5n9uTOjjeYnJ3GIe1D7r
        KY7z+gxOQXOebADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFD9613421;
        Wed, 26 Apr 2023 15:10:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H9TANdY+SWR3eQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 26 Apr 2023 15:10:14 +0000
Message-ID: <c48c4da5-9de5-f060-b6ad-5373ced87d0a@suse.cz>
Date:   Wed, 26 Apr 2023 17:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] Revert "Revert "mm/compaction: fix set skip in
 fast_find_migrateblock""
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <3576e3520c044beb2a81860aecb2d4f597089300.1682521303.git.baolin.wang@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <3576e3520c044beb2a81860aecb2d4f597089300.1682521303.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 17:03, Baolin Wang wrote:
> This reverts commit 95e7a450b8190673675836bfef236262ceff084a.
> 
> When I tested thpscale with v6.3 kernel, I found the compaction efficiency
> had a great regression compared to v6.2-rc1 kernel. See below numbers:
>                                     v6.2-rc             v6.3
> Percentage huge-3        81.35 (   0.00%)       32.97 ( -59.47%)
> Percentage huge-5        89.92 (   0.00%)       41.70 ( -53.63%)
> Percentage huge-7        92.41 (   0.00%)       34.08 ( -63.12%)
> Percentage huge-12       90.29 (   0.00%)       41.10 ( -54.49%)
> Percentage huge-18       82.38 (   0.00%)       41.24 ( -49.95%)
> Percentage huge-24       80.34 (   0.00%)       35.99 ( -55.20%)
> Percentage huge-30       88.90 (   0.00%)       44.20 ( -50.28%)
> Percentage huge-32       90.69 (   0.00%)       79.57 ( -12.25%)
> 
> Ops Compaction stalls                 113790.00      207099.00
> Ops Compaction success                 33983.00      19488.00
> Ops Compaction failures                79807.00      187611.00
> Ops Compaction efficiency                 29.86          9.41
> 
> After some investigation, I found the commit 95e7a450b819
> ("Revert mm/compaction: fix set skip in fast_find_migrateblock") caused
> the regression. This commit revert the commit 7efc3b726103 ("mm/compaction:
> fix set skip in fast_find_migrateblock") to fix a CPU stalling issue, which
> is caused by compaction stucked in repeating fast_find_migrateblock().
> 
> And now the compaction stalling issue is addressed by commit cfccd2e63e7e
> ("mm, compaction: finish pageblocks on complete migration failure"). So

IIRC at that time I was pointing out some scenarios that could make the
problem appear even after that commit, and we wanted to revisit that
when Mel is back.

> we should revert the temporary fix by commit 95e7a450b819, since the
> fast pfn found by fast_find_migrateblock() really can help to isolate
> some migratable pages.

So thanks for the reminder, yet we should make sure the fix is complete
before removing the workaround.

> After reverting the commit, the regression has gone.
>                                v6.2-rc1                  v6.3           v6.3_patched
> Percentage huge-3        81.35 (   0.00%)       32.97 ( -59.47%)       87.78 (   7.90%)
> Percentage huge-5        89.92 (   0.00%)       41.70 ( -53.63%)       89.68 (  -0.27%)
> Percentage huge-7        92.41 (   0.00%)       34.08 ( -63.12%)       85.89 (  -7.05%)
> Percentage huge-12       90.29 (   0.00%)       41.10 ( -54.49%)       94.10 (   4.22%)
> Percentage huge-18       82.38 (   0.00%)       41.24 ( -49.95%)       85.06 (   3.25%)
> Percentage huge-24       80.34 (   0.00%)       35.99 ( -55.20%)       84.38 (   5.02%)
> Percentage huge-30       88.90 (   0.00%)       44.20 ( -50.28%)       95.54 (   7.48%)
> Percentage huge-32       90.69 (   0.00%)       79.57 ( -12.25%)       92.30 (   1.78%)
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/compaction.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 33650541bebc..567c8d41d01e 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1860,7 +1860,6 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
>  					pfn = cc->zone->zone_start_pfn;
>  				cc->fast_search_fail = 0;
>  				found_block = true;
> -				set_pageblock_skip(freepage);
>  				break;
>  			}
>  		}
