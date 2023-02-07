Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C581E68DE84
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjBGRKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBGRKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:10:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FAE3BDAA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:10:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 13075200F5;
        Tue,  7 Feb 2023 17:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675789814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqgHSvZVuaq+v+IH67EMkppDRKeF2E4q4iKhI5vfsLs=;
        b=JWBKD3zEhW9u5PTpMzNIu5j3KMSTM70D3oiK4riBRNbi68OWFrAZfwTt7ul4ba6YxAqYkY
        ZAhBr9G5gBFzPbkOmd2MWl+dbDGhbs40pL26JnFvw9l9MUvUMO+vZBxAwb/fwCui4yovzH
        ruIh4pRAQEX2ZaavPUUHBRHd8l36vKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675789814;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqgHSvZVuaq+v+IH67EMkppDRKeF2E4q4iKhI5vfsLs=;
        b=wSmncD+h99/IocMDuo/nxBQbi5BfdRLwWaofsg2xub6KDx+ougC0aeAtyBqe9i7T1q2959
        jYGeV9sE9pgNS9BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E06C613467;
        Tue,  7 Feb 2023 17:10:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cSEiNvWF4mPMVAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 07 Feb 2023 17:10:13 +0000
Message-ID: <cf3788c7-1b84-dac2-6f83-6da6baa36dd6@suse.cz>
Date:   Tue, 7 Feb 2023 18:10:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/4] mm, compaction: Finish scanning the current pageblock
 if requested
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
References: <20230125134434.18017-1-mgorman@techsingularity.net>
 <20230125134434.18017-4-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230125134434.18017-4-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/23 14:44, Mel Gorman wrote:
> cc->finish_pageblock is set when the current pageblock should be
> rescanned but fast_find_migrateblock can select an alternative
> block. Disable fast_find_migrateblock when the current pageblock
> scan should be completed.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/compaction.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 28711a21a8a2..4b3a0238879c 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1762,6 +1762,13 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
>  	if (cc->ignore_skip_hint)
>  		return pfn;
>  
> +	/*
> +	 * If the pageblock should be finished then do not select a different
> +	 * pageblock.
> +	 */
> +	if (cc->finish_pageblock)
> +		return pfn;
> +
>  	/*
>  	 * If the migrate_pfn is not at the start of a zone or the start
>  	 * of a pageblock then assume this is a continuation of a previous

