Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F50866E1AE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjAQPJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjAQPJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:09:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1929D3E633
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:09:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4D0CF21AA6;
        Tue, 17 Jan 2023 15:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673968143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GbRWdJrQA5rsGsQ15mZxy3lCZu74wCpPmVNydKoLMQ0=;
        b=TGjBsFbbafNCK59Ka/VR2n3p3wpABbf1jdsLyLdBJ3nwlM81bSVbkGWncSt2v0Z7QlPHV+
        u2cV4TXTMNYj/wu/K7fGSFWcsGtrQGAVpnh9L+yTbsUCjJmx2u9rCmnO1NQn20Q+zSniqu
        +i9vScb+qAT6y46Eo/yiLU6fB6xX9bo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 249E21390C;
        Tue, 17 Jan 2023 15:09:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TMVsCA+6xmNhQQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 17 Jan 2023 15:09:03 +0000
Date:   Tue, 17 Jan 2023 16:09:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 13/41] mm: introduce vma->vm_flags modifier functions
Message-ID: <Y8a6DhA6o3jcZaM3@dhcp22.suse.cz>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-14-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109205336.3665937-14-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-01-23 12:53:08, Suren Baghdasaryan wrote:
> To keep vma locking correctness when vm_flags are modified, add modifier
> functions to be used whenever flags are updated.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/mm.h       | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mm_types.h |  8 +++++++-
>  2 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ec2c4c227d51..35cf0a6cbcc2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -702,6 +702,44 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  	vma_init_lock(vma);
>  }
>  
> +/* Use when VMA is not part of the VMA tree and needs no locking */
> +static inline
> +void init_vm_flags(struct vm_area_struct *vma, unsigned long flags)
> +{
> +	WRITE_ONCE(vma->vm_flags, flags);
> +}

Why do we need WRITE_ONCE here? Isn't vma invisible during its
initialization?

> +
> +/* Use when VMA is part of the VMA tree and needs appropriate locking */
> +static inline
> +void reset_vm_flags(struct vm_area_struct *vma, unsigned long flags)
> +{
> +	vma_write_lock(vma);
> +	init_vm_flags(vma, flags);
> +}
> +
> +static inline
> +void set_vm_flags(struct vm_area_struct *vma, unsigned long flags)
> +{
> +	vma_write_lock(vma);
> +	vma->vm_flags |= flags;
> +}
> +
> +static inline
> +void clear_vm_flags(struct vm_area_struct *vma, unsigned long flags)
> +{
> +	vma_write_lock(vma);
> +	vma->vm_flags &= ~flags;
> +}
> +
> +static inline
> +void mod_vm_flags(struct vm_area_struct *vma,
> +		  unsigned long set, unsigned long clear)
> +{
> +	vma_write_lock(vma);
> +	vma->vm_flags |= set;
> +	vma->vm_flags &= ~clear;
> +}
> +

This is rather unusual pattern. There is no note about locking involved
in the naming and also why is the locking part of this interface in the
first place? I can see reason for access functions to actually check for
lock asserts.
-- 
Michal Hocko
SUSE Labs
