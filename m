Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BC75B93B8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 06:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIOEo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 00:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIOEoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 00:44:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437B391088
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 21:44:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A8CCE5CC6C;
        Thu, 15 Sep 2022 04:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663217062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eEZSJ2L42Kmrv2TY3H2eMASjpoqY5XSkBJlalhqKLgo=;
        b=qvjiNxgofJWYxPYmORHxYmJ+2UyJBSrUhEIvz23oABdCe2RTNkIXPVk1MQCtH/Lo5JUZLQ
        P4iPEy/bqzc55t813O+e2tnl2u030OwI+53LjFCQVPXPoE7lrUjgaG36gjfCIQvsnBSu8x
        FfoDI2qNipeHdTVvjz5DdSn8UknfSS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663217062;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eEZSJ2L42Kmrv2TY3H2eMASjpoqY5XSkBJlalhqKLgo=;
        b=p1GtpaARgp56h5XU/O78xjxzT+GbY2ZIoZ+YXOs0IMTRJy+WKWf7QLAiEsNg5PESAHkfXx
        9ngJjjErFt78eQDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B574139C8;
        Thu, 15 Sep 2022 04:44:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0MuiD6atImMUKwAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 15 Sep 2022 04:44:22 +0000
Date:   Thu, 15 Sep 2022 06:44:20 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] mm: remove obsolete macro NR_PCP_ORDER_MASK
Message-ID: <YyKtpJjTxL9DHv+V@localhost.localdomain>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909092451.24883-4-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 05:24:38PM +0800, Miaohe Lin wrote:
> Since commit 8b10b465d0e1 ("mm/page_alloc: free pages in a single pass
> during bulk free"), it's not used anymore. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

with the changes from Matthew applied:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  include/linux/mmzone.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index d907a29cc429..6950179a20a2 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -569,7 +569,6 @@ enum zone_watermarks {
>   * in the least significant bits.
>   */
>  #define NR_PCP_ORDER_WIDTH 8
> -#define NR_PCP_ORDER_MASK ((1<<NR_PCP_ORDER_WIDTH) - 1)
>  
>  #define min_wmark_pages(z) (z->_watermark[WMARK_MIN] + z->watermark_boost)
>  #define low_wmark_pages(z) (z->_watermark[WMARK_LOW] + z->watermark_boost)
> -- 
> 2.23.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
