Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF347157BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjE3H7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjE3H7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:59:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965EF90
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:59:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4372F1F889;
        Tue, 30 May 2023 07:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685433555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aR5mnon4zhDf1c/NKhS1CdKNreGelh3NU7PyzV1RfKI=;
        b=IdefEP5Vs8tPnDdV939qTvhz0n/itBbSr7uiMbjaWXqpkL195D+dpTilo7cKs5sCRMyRQ7
        Ovx49GhI8bh8QnDoq3y9Cu07TIczVegXm1iUtdpH1t0VDjdojy58DnySwNlkm9O21YVpMs
        w+23whnoI2l7jzruE8Gm8XIhMD6iAV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685433555;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aR5mnon4zhDf1c/NKhS1CdKNreGelh3NU7PyzV1RfKI=;
        b=I4k39qnPl7RKRD2hKCXntATiTlRtXQrFCBUUtSOakMGk7ZiB4xfZO2PNh/YeZJi82kkPMA
        5WA0lRi+NhG5Z5CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 283B613478;
        Tue, 30 May 2023 07:59:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DyItCdOsdWQHJQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 30 May 2023 07:59:15 +0000
Message-ID: <415a2266-868c-b0d8-b45c-d92eaf02611c@suse.cz>
Date:   Tue, 30 May 2023 09:59:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/6] mm: compaction: skip more fully scanned pageblock
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1685018752.git.baolin.wang@linux.alibaba.com>
 <f4efd2fa08735794a6d809da3249b6715ba6ad38.1685018752.git.baolin.wang@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <f4efd2fa08735794a6d809da3249b6715ba6ad38.1685018752.git.baolin.wang@linux.alibaba.com>
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
> In fast_isolate_around(), it assumes the pageblock is fully scanned if
> cc->nr_freepages < cc->nr_migratepages after trying to isolate some free
> pages, and will set skip flag to avoid scanning in future. However this
> can miss setting the skip flag for a fully scanned pageblock (returned
> 'start_pfn' is equal to 'end_pfn') in the case where cc->nr_freepages
> is larger than cc->nr_migratepages.
> 
> So using the returned 'start_pfn' from isolate_freepages_block() and
> 'end_pfn' to decide if a pageblock is fully scanned makes more sense.
> It can also cover the case where cc->nr_freepages < cc->nr_migratepages,
> which means the 'start_pfn' is usually equal to 'end_pfn' except some
> uncommon fatal error occurs after non-strict mode isolation.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/compaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 3737c6591bfb..1e5183f39ca9 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1411,7 +1411,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
>  	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
>  
>  	/* Skip this pageblock in the future as it's full or nearly full */
> -	if (cc->nr_freepages < cc->nr_migratepages)
> +	if (start_pfn == end_pfn)
>  		set_pageblock_skip(page);
>  
>  	return;

