Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4085B957F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiIOHgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiIOHgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:36:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D788C47D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:36:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 419175CE82;
        Thu, 15 Sep 2022 07:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663227369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h1+vhlSW9vfPnyz5X0nnqGP7dW92tQoYBZ6ShdfGobQ=;
        b=fFGemjSzG23aGrp5T9dEYL0S+HfetsY4S7oLMIYtVufTf/8IfI2CKnHzzESbfWsz9jXadr
        tL6mmpULkFlYxU1+pDTSMDbGDwwKfzVF3IhpsxQPORyaN7hRv/+5BTPZnjudwpb1YjCW78
        vjOD1pCtyco4oIUPCkQxOfFFXEYYya0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663227369;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h1+vhlSW9vfPnyz5X0nnqGP7dW92tQoYBZ6ShdfGobQ=;
        b=CWQcbNtMyo8YAOpvZ2C2PS8ryQBv6Wze8zMHfucg+XXPZuHng4bWMKk29Bd5SDbxB2ksTM
        sRwpTdXac01W7KBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DECF9133A7;
        Thu, 15 Sep 2022 07:36:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XKm0M+jVImNZZQAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 15 Sep 2022 07:36:08 +0000
Date:   Thu, 15 Sep 2022 09:36:07 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/16] mm/page_alloc: use local variable zone_idx directly
Message-ID: <YyLV50jxlqq5GKtJ@localhost.localdomain>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-10-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909092451.24883-10-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 05:24:44PM +0800, Miaohe Lin wrote:
> Use local variable zone_idx directly since it holds the exact value of
> zone_idx(). No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

By the way, zone_idx being "int" should be enough?

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 94baf33da865..3417232afa45 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6878,7 +6878,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>  	unsigned long start = jiffies;
>  	int nid = pgdat->node_id;
>  
> -	if (WARN_ON_ONCE(!pgmap || zone_idx(zone) != ZONE_DEVICE))
> +	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
>  		return;
>  
>  	/*
> -- 
> 2.23.0
> 

-- 
Oscar Salvador
SUSE Labs
