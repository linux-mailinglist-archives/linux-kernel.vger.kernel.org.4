Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230496860D8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjBAHnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjBAHns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:43:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4157E410A6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:43:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5D0B333A5A;
        Wed,  1 Feb 2023 07:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675237424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EIPupChmZWdqCbipzzk6WIge6ktn1mIlacRGTtLMASA=;
        b=plb39T261+q73vUMZloi+nvkH8nnyo+NMJ3mWpZsLfYYmeWt/WorRYCmo/s5C1ChCTGt2v
        3zeJW7/3Quy+a++wy39qc2ym1EPIKxsP++jtuZtDVsjGQBIcgFFF7gE5Hjqq1lrrCau9wl
        eZlhFhYILXyWtEI3TjhVbj0vmXaTico=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C2211348C;
        Wed,  1 Feb 2023 07:43:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UybHCTAY2mOWMwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 01 Feb 2023 07:43:44 +0000
Date:   Wed, 1 Feb 2023 08:43:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, 42.hyeyoo@gmail.com, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] mm: introduce vm_flags_reset_once to replace
 WRITE_ONCE vm_flags updates
Message-ID: <Y9oYL93beiezSf3V@dhcp22.suse.cz>
References: <20230201000116.1333160-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201000116.1333160-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-01-23 16:01:16, Suren Baghdasaryan wrote:
> Provide vm_flags_reset_once() and replace the vm_flags updates which used
> WRITE_ONCE() to prevent compiler optimizations.
> 
> Fixes: 0cce31a0aa0e ("mm: replace vma->vm_flags direct modifications with modifier calls")
> Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

This would have been better folded into the vm_flags modification patch
because it would be more obvious change. Hugh has provided a very nice
comment in mlock_vma_pages_range but the git blame would be more visible
when the conversion is from WRITE_ONCE.

One way or the other
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> Notes:
> - The patch applies cleanly over mm-unstable
> - The SHA in Fixes: line is from mm-unstable, so is... unstable
> 
>  include/linux/mm.h | 7 +++++++
>  mm/mlock.c         | 4 ++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5bf0ad48faaa..23ce04f6e91e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -648,6 +648,13 @@ static inline void vm_flags_reset(struct vm_area_struct *vma,
>  	vm_flags_init(vma, flags);
>  }
>  
> +static inline void vm_flags_reset_once(struct vm_area_struct *vma,
> +				       vm_flags_t flags)
> +{
> +	mmap_assert_write_locked(vma->vm_mm);
> +	WRITE_ONCE(ACCESS_PRIVATE(vma, __vm_flags), flags);
> +}
> +
>  static inline void vm_flags_set(struct vm_area_struct *vma,
>  				vm_flags_t flags)
>  {
> diff --git a/mm/mlock.c b/mm/mlock.c
> index ed49459e343e..617469fce96d 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -380,7 +380,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
>  	 */
>  	if (newflags & VM_LOCKED)
>  		newflags |= VM_IO;
> -	vm_flags_reset(vma, newflags);
> +	vm_flags_reset_once(vma, newflags);
>  
>  	lru_add_drain();
>  	walk_page_range(vma->vm_mm, start, end, &mlock_walk_ops, NULL);
> @@ -388,7 +388,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
>  
>  	if (newflags & VM_IO) {
>  		newflags &= ~VM_IO;
> -		vm_flags_reset(vma, newflags);
> +		vm_flags_reset_once(vma, newflags);
>  	}
>  }
>  
> -- 
> 2.39.1.456.gfc5497dd1b-goog

-- 
Michal Hocko
SUSE Labs
