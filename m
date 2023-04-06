Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415376D9B50
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDFOyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239389AbjDFOy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:54:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328728A66
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:53:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 547E367373; Thu,  6 Apr 2023 16:53:47 +0200 (CEST)
Date:   Thu, 6 Apr 2023 16:53:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -next v8 3/3] mm/zswap: delay the initialization of
 zswap
Message-ID: <20230406145347.GB11839@lst.de>
References: <20230403121318.1876082-1-liushixin2@huawei.com> <20230403121318.1876082-4-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403121318.1876082-4-liushixin2@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 08:13:18PM +0800, Liu Shixin wrote:
> Since some users may not use zswap, the zswap_pool is wasted. Save memory
> by delaying the initialization of zswap until enabled.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  mm/zswap.c | 56 +++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 43 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 9169c2baee87..14db57450bfd 100644
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
> @@ -222,6 +224,9 @@ enum zswap_init_type {
>  
>  static enum zswap_init_type zswap_init_state;
>  
> +/* used to ensure the integrity of initialization */
> +static DEFINE_MUTEX(zswap_init_lock);
> +
>  /* init completed, but couldn't create the initial pool */
>  static bool zswap_has_pool;
>  
> @@ -654,7 +659,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>  	return NULL;
>  }
>  
> -static __init struct zswap_pool *__zswap_pool_create_fallback(void)
> +static struct zswap_pool *__zswap_pool_create_fallback(void)
>  {
>  	bool has_comp, has_zpool;
>  
> @@ -763,21 +768,28 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
>  	char *s = strstrip((char *)val);
>  	int ret;
>  
> +	mutex_lock(&zswap_init_lock);
>  	switch (zswap_init_state) {
>  	case ZSWAP_UNINIT:
>  		/* if this is load-time (pre-init) param setting,
>  		 * don't create a pool; that's done during init.
>  		 */
> -		return param_set_charp(s, kp);
> +		ret = param_set_charp(s, kp);
> +		mutex_unlock(&zswap_init_lock);
> +		return ret;
>  	case ZSWAP_INIT_SUCCEED:
>  		/* no change required */
> -		if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool)
> +		if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool) {
> +			mutex_unlock(&zswap_init_lock);
>  			return 0;
> +		}
>  		break;
>  	case ZSWAP_INIT_FAILED:
>  		pr_err("can't set param, initialization failed\n");
> +		mutex_unlock(&zswap_init_lock);
>  		return -ENODEV;
>  	}
> +	mutex_unlock(&zswap_init_lock);

The pattern here looks a bit odd.  Can you split the code that
the ZSWAP_INIT_SUCCEED case falls through into a helper, then just
assign ret inside the switch statement, break out and do a single
unlock and return?

> +	/*if this is load-time (pre-init) param setting, only set param.*/

missing space after the initial and before the last * here.

But except for these nitpicks this version looks good to me now.
