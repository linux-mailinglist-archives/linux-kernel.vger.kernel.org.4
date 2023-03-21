Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E7B6C35B0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjCUPaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjCUPaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:30:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECAF5259;
        Tue, 21 Mar 2023 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=V+bmw1RvbbZi6jSx984W7m2Bc3dCIIAmL6vIS1dzYPQ=; b=VZJsnuGBRKlaSnPzQK8ytVfPvu
        LP9xzhVAVhV54fQxrlSHoK1Oik/3I1hFCje+oVe9mjp+few0Rihx4xtT11eTtmAQZxc8kQZWqtRYV
        3WtKN7ZrH2Rs7l83POxtcSA5vuSmH2pmKkXsaBPH+UquPtHDlqjfx8c1LXPF1EfWhiWDnP42K8PPR
        NCm3M7aRkOWN7beNPeIuJcZDYDuO4wM45/OE0CNaW6I9Ca4TpLO7eKOOY9QToZNY/leetuqgX/FwV
        7V5leD5cAdSPFiq/iBacDNopHBP9FYJPOOYPdQqKjtYVP0/CjUm+qrjVQCQurdTRh8D1CSvAYJ1CT
        oJmjXEyw==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pedvK-00CvRL-1W;
        Tue, 21 Mar 2023 15:29:18 +0000
Message-ID: <6f5fd9d9-f247-a7c0-a5e5-c40c37c76281@infradead.org>
Date:   Tue, 21 Mar 2023 08:29:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm/slab: Fix undefined init_cache_node_node() for NUMA
 and !SMP
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <67261c513706241d479b8b4cf46eb4e6fb0417ba.1679387262.git.geert+renesas@glider.be>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <67261c513706241d479b8b4cf46eb4e6fb0417ba.1679387262.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/21/23 01:30, Geert Uytterhoeven wrote:
> sh/migor_defconfig:
> 
>     mm/slab.c: In function ‘slab_memory_callback’:
>     mm/slab.c:1127:23: error: implicit declaration of function ‘init_cache_node_node’; did you mean ‘drain_cache_node_node’? [-Werror=implicit-function-declaration]
>      1127 |                 ret = init_cache_node_node(nid);
> 	  |                       ^~~~~~~~~~~~~~~~~~~~
> 	  |                       drain_cache_node_node
> 
> The #ifdef condition protecting the definition of init_cache_node_node()
> no longer matches the conditions protecting the (multiple) users.
> 
> Fix this by syncing the conditions.
> 
> Fixes: 76af6a054da40553 ("mm/migrate: add CPU hotplug to demotion #ifdef")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/r/b5bdea22-ed2f-3187-6efe-0c72330270a4@infradead.org
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  mm/slab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index ba454246ee13dd4d..de1523a78f2e7367 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -839,7 +839,7 @@ static int init_cache_node(struct kmem_cache *cachep, int node, gfp_t gfp)
>  	return 0;
>  }
>  
> -#if (defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)) || defined(CONFIG_SMP)
> +#if defined(CONFIG_NUMA) || defined(CONFIG_SMP)
>  /*
>   * Allocates and initializes node for a node on each slab cache, used for
>   * either memory or cpu hotplug.  If memory is being hot-added, the kmem_cache_node

-- 
~Randy
