Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C2A6656FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbjAKJLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238579AbjAKJKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:10:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEF1E0FE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:07:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 932BC76928;
        Wed, 11 Jan 2023 09:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673428023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=onH5sfG39fwD+Mmi6xMMtzzcmp2FhS3nYAe+d+/ViRY=;
        b=aUnn0sLO/n8HWm87X3PIlmfeV/YwedWOESM3wdw4KoCGHlf6sWvHz0tdBYtF/YgF1kR8ER
        bw0/C7v3+uJiqBMp05P527KMWMA4L20UtV9QAZlbD0YBEX6PXyo5qCNrrxwaijCUmhykgY
        lPeHYs+BoZb6LozwcYn1PSA2fyKGCiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673428023;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=onH5sfG39fwD+Mmi6xMMtzzcmp2FhS3nYAe+d+/ViRY=;
        b=gYtlr7sZ9aNVIb7O9yxuu6ww+1ObYjXkR3VcwjHlMIbcvt5aSV0e9VOPjA62EiewXBPkFx
        HiFh6YDKXQkBcKBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A30713591;
        Wed, 11 Jan 2023 09:07:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kaA8GTd8vmN4WQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 11 Jan 2023 09:07:03 +0000
Message-ID: <8042dcd4-41e6-a18d-3899-8f6d2696068a@suse.cz>
Date:   Wed, 11 Jan 2023 10:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] mm/slab.c: Delete the if judgment and return the result
 directly Remove the if judgment and return the result directly to reduce
 assembly statements.
Content-Language: en-US
To:     lvqian@nfschina.com, cl@linux.co, penberg@kernel.org,
        rientjes@google.com, kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230111083102.111535-1-lvqian@nfschina.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230111083102.111535-1-lvqian@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/23 09:31, lvqian@nfschina.com wrote:
> From: lvqian <lvqian@nfschina.com>

The subject line is long, e.g. the second sentence should be part of body,
not subject.

Note the usual wording is "if statement" not "judgement"

> Remove the if judgment and return the result directly to reduce assembly  statements.

I'm pretty sure there will be no effect on generated code/assembly, so it
should be purely about the C code readability. That's somewhat subjective,
but I think it's acceptable in this case.

> diff --git a/mm/slab.c b/mm/slab.c
> index 7a269db050ee..713265fe2dea 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1415,11 +1415,8 @@ static void kmem_rcu_free(struct rcu_head *head)
>  #if DEBUG
>  static bool is_debug_pagealloc_cache(struct kmem_cache *cachep)
>  {
> -	if (debug_pagealloc_enabled_static() && OFF_SLAB(cachep) &&
> -		(cachep->size % PAGE_SIZE) == 0)
> -		return true;
> -
> -	return false;
> +	return debug_pagealloc_enabled_static() && OFF_SLAB(cachep) &&
> +			((cachep->size % PAGE_SIZE) == 0);
>  }
>  
>  #ifdef CONFIG_DEBUG_PAGEALLOC

