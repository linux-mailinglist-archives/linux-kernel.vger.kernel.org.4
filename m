Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C15669F02
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjAMRET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjAMREN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:04:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0F75FF6;
        Fri, 13 Jan 2023 09:04:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5843020036;
        Fri, 13 Jan 2023 17:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673629450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZrIktPWt6uDyBFSnP2WU+2Nh/aWfw7kkDySc2ve2K0M=;
        b=FRpCw8xxBRP2i2AbveMiI9ohchbggYYiIX2zvghZQKS2RVujRdZMtv0nMEyqJT2ACsvomf
        yrJUepySV7UBaa/TxMa9plHdgHzpAjUeIegkpWWud2xe7cw9XwTtZGPoiCPYX03dW+pULi
        WF81SfDhkJDJ43+llmF6gZJU8BOwav0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38D4A13913;
        Fri, 13 Jan 2023 17:04:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CjXKCwqPwWPpZwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 13 Jan 2023 17:04:10 +0000
Date:   Fri, 13 Jan 2023 18:04:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        wuyun.abel@bytedance.com
Subject: Re: [PATCH 0/3] mm: replace atomic_t with percpu_ref in mempolicy.
Message-ID: <Y8GPCT2w0WKARLVF@dhcp22.suse.cz>
References: <20221204161432.2149375-1-hezhongkun.hzk@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204161432.2149375-1-hezhongkun.hzk@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-12-22 00:14:29, Zhongkun He wrote:
[...]
> +/* Obtain a reference on the specified mpol */
>  static inline void mpol_get(struct mempolicy *pol)
>  {
>  	if (pol)

Shouldn't this be mpol_needs_cond_ref?

> -		atomic_inc(&pol->refcnt);
> +		percpu_ref_get(&pol->refcnt);
> +}
> +
> +static inline bool mpol_tryget(struct mempolicy *pol)
> +{
> +	return pol && percpu_ref_tryget(&pol->refcnt);
>  }
>  
> +/*
> + * This function initiates destruction of mempolicy.

This is not a useful comment. It would be much more helpful to say when
this should be called.

> + */
> +static inline void mpol_kill(struct mempolicy *pol)
> +{
> +        if (pol)
> +                percpu_ref_kill(&pol->refcnt);
> +}
> +
> +
>  extern bool __mpol_equal(struct mempolicy *a, struct mempolicy *b);
>  static inline bool mpol_equal(struct mempolicy *a, struct mempolicy *b)
>  {
> @@ -197,11 +210,15 @@ static inline void mpol_put(struct mempolicy *p)
>  {
>  }
>  
> -static inline void mpol_cond_put(struct mempolicy *pol)
> +static inline void mpol_get(struct mempolicy *pol)
>  {
>  }
>  
> -static inline void mpol_get(struct mempolicy *pol)
> +static inline bool mpol_tryget(struct mempolicy *pol)
> +{
> +}

This should return false, right?

[...]
> +/* Obtain a reference on the specified task mempolicy */

Again, this is pretty much clear from the name. It would be more useful
to explain how the pointer can be used - e.g. needs to call mpol_put
or mpol_kill depending on the calling context.

> +static mempolicy *get_task_mpol(struct task_struct *p)
> +{
> +	struct mempolicy *pol;
> +
> +	rcu_read_lock();
> +	pol = rcu_dereference(p->mempolicy);
> +
> +	if (!pol || mpol_tryget(pol))

Shouldn't be !mpol_tryget?

> +		pol = NULL;
> +	rcu_read_unlock();
> +
> +	return pol;
> +}
> +

I do not see any rcu_assign_pointer for the newly created policy so this
seems incomplete. Ditto no mpol_kill calls. I am unlikely to get into
follow up patches now. Please split up the work so that it is reviewable
more easily and then I can have a further look.

Thanks!
-- 
Michal Hocko
SUSE Labs
