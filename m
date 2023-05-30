Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E549715890
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjE3IcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjE3IcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:32:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA91BF
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:32:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 620B21FD68;
        Tue, 30 May 2023 08:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685435524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sJ3r+Zcx1F1VI+OHNvs6PGvIA3W5WTyjuv6T40x7/nU=;
        b=kCJhCCejAz8NUs7P6KKXTDUcHPzLK+fGX9DRmATol1HakU3DvPYj2goWEQ8VlvrgkY0gMm
        k95ROY0vV7pY2umzpBKfQ+75vRTSy5HpgDek6ORBZE9OBSQ147FsOer6NuRABJE53aKpWg
        CHsyKfB90nkcp8RIlrsWpEOXYQu0f2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685435524;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sJ3r+Zcx1F1VI+OHNvs6PGvIA3W5WTyjuv6T40x7/nU=;
        b=EQMZKhqc567sVwXgTpNUk6s6PURSTUqUkFc7OEfgKv6tg22lt50mxI4CayfMWAcAsEymTH
        hMfqXCux25tlY8Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A02513597;
        Tue, 30 May 2023 08:32:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AZhrEYS0dWSfLwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 30 May 2023 08:32:04 +0000
Message-ID: <efc76ea3-9a85-96a3-f3d7-212aeea7cf1c@suse.cz>
Date:   Tue, 30 May 2023 10:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 6/6] mm: compaction: skip fast freepages isolation if
 enough freepages are isolated
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1685018752.git.baolin.wang@linux.alibaba.com>
 <f39c2c07f2dba2732fd9c0843572e5bef96f7f67.1685018752.git.baolin.wang@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <f39c2c07f2dba2732fd9c0843572e5bef96f7f67.1685018752.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/23 14:54, Baolin Wang wrote:
> I've observed that fast isolation often isolates more pages than
> cc->migratepages, and the excess freepages will be released back to the
> buddy system. So skip fast freepages isolation if enough freepages are
> isolated to save some CPU cycles.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/compaction.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index eccec84dae82..3ade4c095ed2 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1550,6 +1550,10 @@ static void fast_isolate_freepages(struct compact_control *cc)
>  
>  		spin_unlock_irqrestore(&cc->zone->lock, flags);
>  
> +		/* Skip fast search if enough freepages isolated */
> +		if (cc->nr_freepages >= cc->nr_migratepages)
> +			break;
> +
>  		/*
>  		 * Smaller scan on next order so the total scan is related
>  		 * to freelist_scan_limit.

