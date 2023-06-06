Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CC2723C24
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbjFFIsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjFFIsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:48:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBB6E8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:48:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D47D81FD63;
        Tue,  6 Jun 2023 08:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686041302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uzifdbB9a65Ly0G3HQ1gDE5VXMzSADFqEAtU4sEv7kM=;
        b=giUmbODmna+vEGLAKAtlSKl6s+82si34njLk3JkeDYm0UXDA17+8bGXYeb+gO65R4BIE8K
        Z8L6efq7pmK4nYPtR9Ltm/A3UhdvWBbBHbyK60aj8+QZpahsmXrj87F6iW5k3eq8ad4cVW
        VLL5x06cRIROEeDURg3HET3VvUO7sTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686041302;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uzifdbB9a65Ly0G3HQ1gDE5VXMzSADFqEAtU4sEv7kM=;
        b=JEeJiwIKT4nnDDq+tUejJ4DgkdMMwpIS1ufoFlyZYZaRsVyuv+3yQdSMbHd0rjSXt6QKkd
        qu8Zm8+hPkf7R5Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B12B613776;
        Tue,  6 Jun 2023 08:48:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G92LKtbyfmS7PAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 06 Jun 2023 08:48:22 +0000
Message-ID: <b05aba56-cdf0-1a8f-c2cc-3dbfcf801c53@suse.cz>
Date:   Tue, 6 Jun 2023 10:48:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] mm/slab_common: reduce an if statement in create_cache()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230606065543.1324-1-thunder.leizhen@huawei.com>
 <ZH7ktMtP8ho2/SFT@debian-BULLSEYE-live-builder-AMD64>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZH7ktMtP8ho2/SFT@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/23 09:48, Hyeonggon Yoo wrote:
> On Tue, Jun 06, 2023 at 02:55:43PM +0800, Zhen Lei wrote:
>> Move the 'out:' statement block out of the successful path to avoid
>> redundant check on 'err'. The value of 'err' is always zero on success
>> and negative on failure.
>> 
>> No functional changes, no performance improvements, just a little more
>> readability.
>> 
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  mm/slab_common.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>> 
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 607249785c077e9..f6fe35105774944 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -236,14 +236,12 @@ static struct kmem_cache *create_cache(const char *name,
>>  
>>  	s->refcount = 1;
>>  	list_add(&s->list, &slab_caches);
>> -out:
>> -	if (err)
>> -		return ERR_PTR(err);
>>  	return s;
>>  
>>  out_free_cache:
>>  	kmem_cache_free(kmem_cache, s);
>> -	goto out;
>> +out:
>> +	return ERR_PTR(err);
>>  }
>>  
>>  /**
> 
> Hi Zhen,
> nice cleanup!
> 
> Looks correct to me,
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks, added to slab/for-6.5/cleanup

>> -- 
>> 2.25.1
>> 
> 

