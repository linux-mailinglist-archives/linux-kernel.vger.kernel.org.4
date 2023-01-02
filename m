Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5477D65AE26
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjABIc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjABIcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:32:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF2AC03
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:32:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0F5AC20897;
        Mon,  2 Jan 2023 08:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672648336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H75DFi9ruBZtmFkVkdPw0eEU2taX9Gg8XsLbPaQHEe4=;
        b=MJPFsj0LM8oWnteJyW53u4CUKbsexOFgRTQV04ifwTmDySriYHMPDcHzvliisBgcGLUAws
        SEnnKOo1R4BpiYbwI4kA9M2U7bNT5jvoSXF5OEBZ0CabhUxNWZyRqfBlHP7k5t8n0tbl5c
        omMLmC4YweurOobMfALepySs0VpDzOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672648336;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H75DFi9ruBZtmFkVkdPw0eEU2taX9Gg8XsLbPaQHEe4=;
        b=TTQVax9agQi/0O0uIYCs4wv2f1250O6kked2hT2h/6j9UVQjlkSPohT5egknrZSKUmbTSe
        kU26ydWBmJrQjTAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D75FC139C8;
        Mon,  2 Jan 2023 08:32:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /JJuM4+WsmMPJQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 02 Jan 2023 08:32:15 +0000
Message-ID: <7fb9b7cc-5c07-4b30-fa5e-6146b402f73f@suse.cz>
Date:   Mon, 2 Jan 2023 09:32:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [patch] mm, slab: periodically resched in drain_freelist()
To:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <b1808b92-86df-9f53-bfb2-8862a9c554e9@google.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <b1808b92-86df-9f53-bfb2-8862a9c554e9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/22 07:05, David Rientjes wrote:
> drain_freelist() can be called with a very large number of slabs to free,
> such as for kmem_cache_shrink(), or depending on various settings of the
> slab cache when doing periodic reaping.
> 
> If there is a potentially long list of slabs to drain, periodically
> schedule to ensure we aren't saturating the cpu for too long.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>

Thanks, added to slab/for-6.2-rc3/fixes

> ---
>  mm/slab.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -2211,6 +2211,8 @@ static int drain_freelist(struct kmem_cache *cache,
>  		raw_spin_unlock_irq(&n->list_lock);
>  		slab_destroy(cache, slab);
>  		nr_freed++;
> +
> +		cond_resched();
>  	}
>  out:
>  	return nr_freed;

