Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A0764B7FC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiLMPCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLMPCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:02:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD3721B2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZBUCX1fq7rVjzw9IZv3GvuEkxpJ3r5A2psEG7gmR1jM=; b=C3GI8dbcs5PgQhUrJSWQ3P8D9r
        xjJqW2cdFvQxkqcbNgFjO7XoEXv8hc3HA6GBKHTyj1MbbsSGZQex8iIKZuRszrgDelPE4/MXx9A/D
        fYF9IvDamMrhqr8tzut2aohnojop3yJ57OSce4dEhI0kk7GbGIHVLc6sdQ4FHbDBwtMEIFcX1AMaw
        UsS9uE5CTYn9C/6cjPIzTnli6DlvkktENgk2XEYwjm8TNijRgb5yWOroUTe0M08un5lHmSc1drTei
        JpvelxBSs+Dei4OoL+8jE7Qoewfr78TfQgV9KwpxG/UW6np+pMS8Uxcinbj11r8ByQzaz101XIdf+
        JT8eCoKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p56o0-00CKAA-5L; Tue, 13 Dec 2022 15:02:52 +0000
Date:   Tue, 13 Dec 2022 15:02:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     david.keisarschm@mail.huji.ac.il
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, aksecurity@gmail.com,
        ilay.bahat1@gmail.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] Replace invocation of weak PRNG in mm/slab.c
Message-ID: <Y5iUHJ+Qjso3U47M@casper.infradead.org>
References: <cover.1670890407.git.david.keisarschm@mail.huji.ac.il>
 <4925f0fe15e9cda5f9d90d75c6e15acdc413ef9e.1670890407.git.david.keisarschm@mail.huji.ac.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4925f0fe15e9cda5f9d90d75c6e15acdc413ef9e.1670890407.git.david.keisarschm@mail.huji.ac.il>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 12:34:57PM +0200, david.keisarschm@mail.huji.ac.il wrote:
> From: David <david.keisarschm@mail.huji.ac.il>

It's normal to include the surname in your sign-off, fwiw.

> @@ -2447,7 +2443,7 @@ static bool shuffle_freelist(struct kmem_cache *cachep, struct slab *slab)
>  
>  		/* Fisher-Yates shuffle */
>  		for (i = count - 1; i > 0; i--) {
> -			rand = prandom_u32_state(&state.rnd_state);
> +			rand = get_random_u32();
>  			rand %= (i + 1);

Shouldn't this be "rand = get_random_u32_below(i + 1)"?

>  			swap_free_obj(slab, i, rand);
>  		}
> -- 
> 2.38.0
> 
> 
