Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74216C6147
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjCWIEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjCWIEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:04:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3745FF974
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:04:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C6BB968B05; Thu, 23 Mar 2023 09:04:43 +0100 (CET)
Date:   Thu, 23 Mar 2023 09:04:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -next v6 2/2] mm/zswap: delay the initializaton of zswap
Message-ID: <20230323080443.GC20444@lst.de>
References: <20230322102006.780624-1-liushixin2@huawei.com> <20230322102006.780624-3-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322102006.780624-3-liushixin2@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 06:20:06PM +0800, Liu Shixin wrote:
> Since some users may not use zswap, the zswap_pool is wasted. Save memory
> by delaying the initialization of zswap until enabled.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  mm/zswap.c | 51 +++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 41 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 09fa956920fa..3aed3b26524a 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -81,6 +81,8 @@ static bool zswap_pool_reached_full;
>  
>  #define ZSWAP_PARAM_UNSET ""
>  
> +static int zswap_setup(void);
> +
>  /* Enable/disable zswap */
>  static bool zswap_enabled = IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
>  static int zswap_enabled_param_set(const char *,
> @@ -220,6 +222,9 @@ static bool zswap_init_started;
>  /* fatal error during init */
>  static bool zswap_init_failed;
>  
> +/* used to ensure the integrity of initialization */
> +static DEFINE_MUTEX(zswap_init_lock);
> +
>  /* init completed, but couldn't create the initial pool */
>  static bool zswap_has_pool;
>  
> @@ -272,13 +277,13 @@ static void zswap_update_total_size(void)
>  **********************************/
>  static struct kmem_cache *zswap_entry_cache;
>  
> -static int __init zswap_entry_cache_create(void)
> +static int zswap_entry_cache_create(void)
>  {
>  	zswap_entry_cache = KMEM_CACHE(zswap_entry, 0);
>  	return zswap_entry_cache == NULL;
>  }

Please add a cleanup patch to remove this helper first, it just
massivel confuses the reader.

> -static void __init zswap_entry_cache_destroy(void)
> +static void zswap_entry_cache_destroy(void)
>  {
>  	kmem_cache_destroy(zswap_entry_cache);
>  }

Same here.

> @@ -663,7 +668,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>  	return NULL;
>  }
>  
> -static __init struct zswap_pool *__zswap_pool_create_fallback(void)
> +static struct zswap_pool *__zswap_pool_create_fallback(void)
>  {
>  	bool has_comp, has_zpool;
>  
> @@ -784,8 +789,15 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
>  	/* if this is load-time (pre-init) param setting,
>  	 * don't create a pool; that's done during init.
>  	 */
> -	if (!zswap_init_started)
> -		return param_set_charp(s, kp);
> +	if (!zswap_init_started) {
> +		mutex_lock(&zswap_init_lock);
> +		if (!zswap_init_started) {
> +			ret = param_set_charp(s, kp);
> +			mutex_unlock(&zswap_init_lock);
> +			return ret;
> +		}
> +		mutex_unlock(&zswap_init_lock);
> +	}

Just take the lock around the whole function.  No need to micro-optimize
setting a kernel paramter.

> @@ -884,6 +896,15 @@ static int zswap_enabled_param_set(const char *val,
>  	if (res == *(bool *)kp->arg)
>  		return 0;
>  
> +	if (!zswap_init_started && (system_state == SYSTEM_RUNNING)) {

No need for the inner braces.  But directly looking at
SYSTEM_RUNNING, especially without a comment is a bit of a mess.
Is there any better way to deal with this?

Also the zswap_init_started variable name has always been a bit
confusing.  If everything around it takes zswap_init_lock now,
it can be replaced with a check for successful zswap initialization
as all the initializtion is covered by the lock.  That would really
help to clean up the code.

> +static int zswap_debugfs_init(void)
>  {
>  	if (!debugfs_initialized())
>  		return -ENODEV;
> @@ -1482,7 +1503,7 @@ static int __init zswap_debugfs_init(void)
>  	return 0;
>  }
>  #else
> -static int __init zswap_debugfs_init(void)
> +static int zswap_debugfs_init(void)

Is there any reason to not just always initialize debugfs and
only defer the expensive allocations?
