Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37C5B9584
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIOHh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIOHhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:37:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777CC792E4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:37:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 24FC55CE7D;
        Thu, 15 Sep 2022 07:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663227442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cck5aBNQb2HmTYWLTPEzJu3AnzbBNC8yc9w8Epo2kqs=;
        b=zGypcOTPxg8BXInKkII5AlBxd5gie0n5BVsH/6mjIp4Cl2yqxIhgK0wvy9ktguIeifIVE3
        iVeS8C7Jh3I6WpxBk69qT9MxkxjMgJBtz10td6aWcxIU9NWHJw6dQ+bELJVjFYjkFxQkbd
        ffpRmdJ7v9Kv2zkGRRDOWeOuA983XCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663227442;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cck5aBNQb2HmTYWLTPEzJu3AnzbBNC8yc9w8Epo2kqs=;
        b=SqYiZwAhWSJl8lgozLelF3kW3xTF1wBs0g063z8lxcGVYkl+JlsZVftM98pq025qvUqnQF
        Cs9lpdLKkOKVf1Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3993133A7;
        Thu, 15 Sep 2022 07:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qH8KLTHWImPDZQAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 15 Sep 2022 07:37:21 +0000
Date:   Thu, 15 Sep 2022 09:37:20 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] mm, memory_hotplug: remove obsolete
 generic_free_nodedata()
Message-ID: <YyLWMDetsofyz6Y+@localhost.localdomain>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-11-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909092451.24883-11-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 05:24:45PM +0800, Miaohe Lin wrote:
> Commit 390511e1476e ("mm, memory_hotplug: drop arch_free_nodedata")
> drops the last caller of generic_free_nodedata(). Remove it too.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  include/linux/memory_hotplug.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 51052969dbfe..9fcbf5706595 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -43,11 +43,6 @@ extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
>  ({								\
>  	memblock_alloc(sizeof(*pgdat), SMP_CACHE_BYTES);	\
>  })
> -/*
> - * This definition is just for error path in node hotadd.
> - * For node hotremove, we have to replace this.
> - */
> -#define generic_free_nodedata(pgdat)	kfree(pgdat)
>  
>  extern pg_data_t *node_data[];
>  static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
> @@ -63,9 +58,6 @@ static inline pg_data_t *generic_alloc_nodedata(int nid)
>  	BUG();
>  	return NULL;
>  }
> -static inline void generic_free_nodedata(pg_data_t *pgdat)
> -{
> -}
>  static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
>  {
>  }
> -- 
> 2.23.0
> 

-- 
Oscar Salvador
SUSE Labs
