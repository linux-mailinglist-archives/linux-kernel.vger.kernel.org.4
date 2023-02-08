Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DAA68F3F4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjBHRCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBHRCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:02:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45122B2BC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:02:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8485D1FF10;
        Wed,  8 Feb 2023 17:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675875768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nY2vXdwHiUi3upLIwQWRCsV8NPYZtr4IXeAtBs5Kaaw=;
        b=ko+debm/S9WRnZ4IJ2BwND17LugSmccg1Dttj6pmkYYMd7PrjDEaYCRYqtkNnWHAAzOwWr
        HvwIKsWqGA4D2q2vLYQupujQPeCM/uKi050QktOSbThEH+oGPJJzd8Z47vqE/UY/YHpZQR
        J0BXAU9mo0Osg1xwtxpxToPNpZlks6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675875768;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nY2vXdwHiUi3upLIwQWRCsV8NPYZtr4IXeAtBs5Kaaw=;
        b=DbSs3cq48z1R6rg+Px8GMIJs9iPYUJS4gr8ByZNB4WmiAAzCaSFjHi1+roCOwnBBQA2pMm
        7bKYoN1aoeSIp2Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 671B513425;
        Wed,  8 Feb 2023 17:02:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n/qgGLjV42NyaAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 08 Feb 2023 17:02:48 +0000
Message-ID: <244795ea-78f6-d02b-ecbb-0b2e1d2dfdfb@suse.cz>
Date:   Wed, 8 Feb 2023 18:02:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mm-unstable] mm/page_owner: record single timestamp value
 for high order allocations
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230121165054.520507-1-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230121165054.520507-1-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/23 17:50, Hyeonggon Yoo wrote:
> When allocating a high-order page, separate allocation timestamp is
> recorded for each sub-page resulting in different timestamp values between
> them.
> 
> This behavior is not consistent with the behavior when recording free
> timestamp and caused confusion when analyzing memory dumps. Record single
> timestamp for the entire allocation, aligning with the behavior for
> free timestamps.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_owner.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index f0553bedb39d..80dc8f4050fa 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -163,6 +163,7 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
>  {
>  	struct page_owner *page_owner;
>  	int i;
> +	u64 ts_nsec = local_clock();
>  
>  	for (i = 0; i < (1 << order); i++) {
>  		page_owner = get_page_owner(page_ext);
> @@ -172,7 +173,7 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
>  		page_owner->last_migrate_reason = -1;
>  		page_owner->pid = current->pid;
>  		page_owner->tgid = current->tgid;
> -		page_owner->ts_nsec = local_clock();
> +		page_owner->ts_nsec = ts_nsec;
>  		strscpy(page_owner->comm, current->comm,
>  			sizeof(page_owner->comm));
>  		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);

