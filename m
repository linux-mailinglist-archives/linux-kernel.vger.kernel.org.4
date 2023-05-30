Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789C27157DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjE3IDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjE3IDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:03:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD40C90
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:03:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4EE2C218FA;
        Tue, 30 May 2023 08:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685433795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+qoS3jIGlkGKPUSBmvDpUF0eZZvpHB3VQF5UkbjDa9E=;
        b=QqJvJXdjmHGYAFHj+C/oCXHEEmpyjbpt3lHiorTLWJnzfPd/A4USCED3ZzL6PDBqezMrPc
        P+/2OT0TbHmykTmkdjBjLM9ys2AjrcQF+58sU1uN9ewdFwRrEBpvMzTLtalgwOlR/D+GLx
        BCH0KL6JHQG9/hX8V8s/bbgbXAuazmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685433795;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+qoS3jIGlkGKPUSBmvDpUF0eZZvpHB3VQF5UkbjDa9E=;
        b=KjrLeWrXT/WSCfbdht4AaM45VsO+plc77xE5L/o9KJ9wVXgKzppcRAcXx/JZ5RZJbC+W0H
        1laj5UwAzHlQiHDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 386F913478;
        Tue, 30 May 2023 08:03:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SBQjDcOtdWRUJgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 30 May 2023 08:03:15 +0000
Message-ID: <fd3bc002-e322-1e69-fa4b-9d6cf97a187f@suse.cz>
Date:   Tue, 30 May 2023 10:03:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 4/6] mm: compaction: only set skip flag if
 cc->no_set_skip_hint is false
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1685018752.git.baolin.wang@linux.alibaba.com>
 <0eb2cd2407ffb259ae6e3071e10f70f2d41d0f3e.1685018752.git.baolin.wang@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <0eb2cd2407ffb259ae6e3071e10f70f2d41d0f3e.1685018752.git.baolin.wang@linux.alibaba.com>
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

On 5/25/23 14:53, Baolin Wang wrote:
> To keep the same logic as test_and_set_skip(), only set the skip flag
> if cc->no_set_skip_hint is false, which makes code more reasonable.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/compaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 1e5183f39ca9..65d8d9223acc 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1223,7 +1223,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  	 * rescanned twice in a row.
>  	 */
>  	if (low_pfn == end_pfn && (!nr_isolated || cc->finish_pageblock)) {
> -		if (valid_page && !skip_updated)
> +		if (!cc->no_set_skip_hint && valid_page && !skip_updated)
>  			set_pageblock_skip(valid_page);
>  		update_cached_migrate(cc, low_pfn);
>  	}

