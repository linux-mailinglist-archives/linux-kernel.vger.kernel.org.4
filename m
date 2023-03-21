Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4256C2CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCUImc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Mar 2023 04:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjCUIm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:42:29 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87775B96;
        Tue, 21 Mar 2023 01:41:38 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1peXYU-002KXH-5J; Tue, 21 Mar 2023 09:41:18 +0100
Received: from p57bd9952.dip0.t-ipconnect.de ([87.189.153.82] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1peXYT-001AuK-U4; Tue, 21 Mar 2023 09:41:18 +0100
Message-ID: <fac6b2c757166df891d60bd00524af7e7d30fe78.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] mm/slab: Fix undefined init_cache_node_node() for NUMA
 and !SMP
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
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
Cc:     linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Date:   Tue, 21 Mar 2023 09:41:16 +0100
In-Reply-To: <67261c513706241d479b8b4cf46eb4e6fb0417ba.1679387262.git.geert+renesas@glider.be>
References: <67261c513706241d479b8b4cf46eb4e6fb0417ba.1679387262.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.153.82
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

On Tue, 2023-03-21 at 09:30 +0100, Geert Uytterhoeven wrote:
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

FWIW, the other #ifdef starting at drain_cache_node_node() closes with "#endif /* CONFIG_NUMA */",
while this #ifdef just ends with "#endif". Just in case you want to make this consistent.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
