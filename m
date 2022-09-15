Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158B45B95AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiIOHqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIOHqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:46:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA4226AEE
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:46:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8DF2C33732;
        Thu, 15 Sep 2022 07:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663227961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EnoU/oELLwx7p7FCDzEhUZP1vg7QCXH0MU0bcZrnfVo=;
        b=stb3TERw1nqdrOz8v4GoQVB1Ctk1dyt5BukieX68jy2Z9lMoIZKC8+odVpz0f4c1kC/ZhU
        FNl8Ir+D3LGQf4zVcpfUcNM8oAAJqG5LAWTAar7FLTCnoXOMc5suJtcJvKLukZ3Owh46aZ
        oTTRHbObzO9JHSIHoXKF/P5AWTZv2QQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663227961;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EnoU/oELLwx7p7FCDzEhUZP1vg7QCXH0MU0bcZrnfVo=;
        b=GTQpKi4wGUMEvaTnuTnr7Bp1kLM28ZxxfF2RW+t1dIrXf9wYL0A7YMBcPJXCX1XxWVPXSm
        wZ320PlCvWzO7kCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31C61133A7;
        Thu, 15 Sep 2022 07:46:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qtlHCTnYImOwaQAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 15 Sep 2022 07:46:01 +0000
Date:   Thu, 15 Sep 2022 09:45:59 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/16] mm/page_alloc: use costly_order in
 WARN_ON_ONCE_GFP()
Message-ID: <YyLYN5uMIQw3UFnP@localhost.localdomain>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-15-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909092451.24883-15-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 05:24:49PM +0800, Miaohe Lin wrote:
> There's no need to check whether order > PAGE_ALLOC_COSTLY_ORDER again.
> Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 63ad25e86010..262e8972e019 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5272,7 +5272,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		 * so that we can identify them and convert them to something
>  		 * else.
>  		 */
> -		WARN_ON_ONCE_GFP(order > PAGE_ALLOC_COSTLY_ORDER, gfp_mask);
> +		WARN_ON_ONCE_GFP(costly_order, gfp_mask);
>  
>  		/*
>  		 * Help non-failing allocations by giving them access to memory
> -- 
> 2.23.0
> 

-- 
Oscar Salvador
SUSE Labs
