Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4724C5F2E57
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiJCJoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiJCJnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:43:41 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8F22FC1C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 02:38:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z4so15750944lft.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 02:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=dANBLy9Pkuer3zrizbGdj6SpwUeQniCxpZBW0aJuHzs=;
        b=DPMHZ2ZH4R+ci5dPn2ER3rf1R/0i913FAkq4g2QEV20Ow729LeCDzDJ520/7ON4ZQv
         jm6k/23rFDUYem1ZLhtvJp01+PXmOwsK1KcA9cMI6EHGSLob2hW2RfaxKpjJ2ZU+3Uad
         EzBqKorUWQ4YCt4BbgIWjpfU/bGW2Xpu+RpWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dANBLy9Pkuer3zrizbGdj6SpwUeQniCxpZBW0aJuHzs=;
        b=roeTSXG9bgpI3Z8ilS3ZH3L4VApTBiQz/9zLAJ1FfCF4ZSZ8to6aAR1m3r+j2KF+FO
         vNiGMSVemQxseo3MPIOr0FrNv2VGqzDlFQ2u/AO52xqPFqoZ7wMJD6iuqTw+EK0YpjFE
         xu6PB3moga+D4dxsgTruZZ4+e1jVtSpGgtUolE+dG9mW+TIJdANpwCKgVaW9eYRCZGYs
         ChHJgtYvuV5dfwDrBE01tFBmexFtwD1UseCNUQEy0kYR/k6XH9QpijhY2MLOA7blME7+
         nivsySvH+i+q1thYBa7WbFhukBR9wweKH1AF2ZhphZ2588E8+5Y4SKf2zemq0kLNDyl2
         p2Lw==
X-Gm-Message-State: ACrzQf2na+QEX5ijLK+U7ZGv5iGJo9FvsdbhJW5JNgoNQMUsmpJJV408
        MYZ4tVma7NUtCef+fAHI8DQtcw==
X-Google-Smtp-Source: AMsMyM7bUkSugzAM3erycF3eY16LBjwRvF21M0DYTgKbtTm5ZgRoygtOV/AOZG8pLP7Rgg2JXbRe+A==
X-Received: by 2002:ac2:5a08:0:b0:4a2:2db2:2dfb with SMTP id q8-20020ac25a08000000b004a22db22dfbmr2630885lfn.638.1664789913072;
        Mon, 03 Oct 2022 02:38:33 -0700 (PDT)
Received: from [172.21.2.224] ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id l20-20020a2e99d4000000b0026dce212f24sm539601ljj.98.2022.10.03.02.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 02:38:32 -0700 (PDT)
Message-ID: <dfa55d7d-4063-c249-f6b8-e7b7d2efc8cc@rasmusvillemoes.dk>
Date:   Mon, 3 Oct 2022 11:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm: slub: remove dead and buggy code from
 sysfs_slab_add()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220930084742.771804-1-linux@rasmusvillemoes.dk>
 <YzqJFnCA1bfYqJ5x@hyeyoo>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <YzqJFnCA1bfYqJ5x@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2022 09.02, Hyeonggon Yoo wrote:
> On Fri, Sep 30, 2022 at 10:47:42AM +0200, Rasmus Villemoes wrote:
>> The function sysfs_slab_add() has two callers:
>>
>> One is slab_sysfs_init(), which first initializes slab_kset, and only
>> when that succeeds sets slab_state to FULL, and then proceeds to call
>> sysfs_slab_add() for all previously created slabs.
>>
>> The other is __kmem_cache_create(), but only after a
>>
>> 	if (slab_state <= UP)
>> 		return 0;
>>
>> check.
>>
>> So in other words, sysfs_slab_add() is never called without
>> slab_kset (aka the return value of cache_kset()) being non-NULL.
>>
>> And this is just as well, because if we ever did take this path and
>> called kobject_init(&s->kobj), and then later when called again from
>> slab_sysfs_init() would end up calling kobject_init_and_add(), we
>> would hit
>>
>> 	if (kobj->state_initialized) {
>> 		/* do not error out as sometimes we can recover */
>> 		pr_err("kobject (%p): tried to init an initialized object, something is seriously wrong.\n",
>> 		dump_stack();
>> 	}
>>
>> in kobject.c.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  mm/slub.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 4b98dff9be8e..04a7f75a7b1f 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -5937,11 +5937,6 @@ static int sysfs_slab_add(struct kmem_cache *s)
>>  	struct kset *kset = cache_kset(s);
>>  	int unmergeable = slab_unmergeable(s);
>>  
>> -	if (!kset) {
>> -		kobject_init(&s->kobj, &slab_ktype);
>> -		return 0;
>> -	}
>> -
>>  	if (!unmergeable && disable_higher_order_debug &&
>>  			(slub_debug & DEBUG_METADATA_FLAGS))
>>  		unmergeable = 1;
>> -- 
>> 2.37.2
> 
> I assumed that it's hit when SLUB failed to initialize slab_kset in
> slab_sysfs_init(). (Yeah, it is too unlikely, though....)

No, it is not, because if the creation of slab_kset fails,
slab_sysfs_init() returns early, and hence slab_state never transitions
to FULL. I don't see anywhere else where slab_state could become FULL
(of course in slab.c and slob.c, but those are not built when slub.c
is), so I do believe my analysis in the commit log is correct.

> And obviously it's a bug if sysfs_slab_add() is called early than
> slab_sysfs_init().

Yes, and that's already what the existing slab_state check guards.

Rasmus

