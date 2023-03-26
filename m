Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B196C98B2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 01:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCZX3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 19:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjCZX3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 19:29:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1280259DB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:29:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B7DFB68B05; Mon, 27 Mar 2023 01:29:09 +0200 (CEST)
Date:   Mon, 27 Mar 2023 01:29:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -next v7 4/4] mm/zswap: delay the initializaton of zswap
Message-ID: <20230326232909.GD19631@lst.de>
References: <20230325071420.2246461-1-liushixin2@huawei.com> <20230325071420.2246461-5-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325071420.2246461-5-liushixin2@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -1480,11 +1500,14 @@ static int __init zswap_debugfs_init(void)
>  /*********************************
>  * module init and exit
>  **********************************/
> -static int __init init_zswap(void)
> +static int zswap_setup(void)
>  {
>  	struct zswap_pool *pool;
>  	int ret;
>  
> +	if (zswap_init_state != ZSWAP_UNINIT)
> +		return 0;

I feel like doing this in zswap_enabled_param_set would be a lot cleaner.
With that we could do a switch on the possible enum values for
zswap_init_state there, and that is a good way to explain the possible
outcomes.
