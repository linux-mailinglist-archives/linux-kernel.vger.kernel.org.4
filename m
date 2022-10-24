Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4051760AEB7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiJXPNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiJXPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:13:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449B2B3B32
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:50:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 696DD2213A;
        Mon, 24 Oct 2022 13:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666617615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+FHugioHev0dYpi/nUm07zjo089onS6uPsLiTaY09U=;
        b=YGnOEXMUKhpzjhdrRJT8pvM79MmBrBSshmlyuJKl/08O7MznBpOau7zosGEjdO+vIHsT0E
        wLGXjCQ9To9FKexFzWwLSKyxFCIBfoiLQEBLNlR8xOYqd9ib/rPQalQf7/F0LCodVDG9Rm
        sqmJTZDfqfRTGxgysN4cOt9sSjEk7QU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666617615;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+FHugioHev0dYpi/nUm07zjo089onS6uPsLiTaY09U=;
        b=rw+pgQMRRv0TsxWnEMcZZfUQ6CMSi6Axy52rV72+fYbmugAPGJzeDj6k/+yUDc5ahHKlJu
        7tZD6AZqaiVAVoBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 412D713357;
        Mon, 24 Oct 2022 13:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ykBLDw+RVmMQeAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 24 Oct 2022 13:20:15 +0000
Message-ID: <b2c843db-4688-2bf2-108f-855c8840edc9@suse.cz>
Date:   Mon, 24 Oct 2022 15:20:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3] mm/slab: Annotate kmem_cache_node->list_lock as raw
Content-Language: en-US
To:     Jiri Kosina <jikos@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <nycvar.YFH.7.76.2210211643330.29912@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2210212114480.29912@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2210212117090.29912@cbobk.fhfr.pm>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <nycvar.YFH.7.76.2210212117090.29912@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 21:18, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> The list_lock can be taken in hardirq context when do_drain() is being 
> called via IPI on all cores, and therefore lockdep complains about it, 
> because it can't be preempted on PREEMPT_RT.
> 
> That's not a real issue, as SLAB can't be built on PREEMPT_RT anyway, but 
> we still want to get rid of the warning on non-PREEMPT_RT builds.
> 
> Annotate it therefore as a raw lock in order to get rid of he lockdep 
> warning below.
> 
> 	 =============================
> 	 [ BUG: Invalid wait context ]
> 	 6.1.0-rc1-00134-ge35184f32151 #4 Not tainted
> 	 -----------------------------
> 	 swapper/3/0 is trying to lock:
> 	 ffff8bc88086dc18 (&parent->list_lock){..-.}-{3:3}, at: do_drain+0x57/0xb0
> 	 other info that might help us debug this:
> 	 context-{2:2}
> 	 no locks held by swapper/3/0.
> 	 stack backtrace:
> 	 CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.1.0-rc1-00134-ge35184f32151 #4
> 	 Hardware name: LENOVO 20K5S22R00/20K5S22R00, BIOS R0IET38W (1.16 ) 05/31/2017
> 	 Call Trace:
> 	  <IRQ>
> 	  dump_stack_lvl+0x6b/0x9d
> 	  __lock_acquire+0x1519/0x1730
> 	  ? build_sched_domains+0x4bd/0x1590
> 	  ? __lock_acquire+0xad2/0x1730
> 	  lock_acquire+0x294/0x340
> 	  ? do_drain+0x57/0xb0
> 	  ? sched_clock_tick+0x41/0x60
> 	  _raw_spin_lock+0x2c/0x40
> 	  ? do_drain+0x57/0xb0
> 	  do_drain+0x57/0xb0
> 	  __flush_smp_call_function_queue+0x138/0x220
> 	  __sysvec_call_function+0x4f/0x210
> 	  sysvec_call_function+0x4b/0x90
> 	  </IRQ>
> 	  <TASK>
> 	  asm_sysvec_call_function+0x16/0x20
> 	 RIP: 0010:mwait_idle+0x5e/0x80
> 	 Code: 31 d2 65 48 8b 04 25 80 ed 01 00 48 89 d1 0f 01 c8 48 8b 00 a8 08 75 14 66 90 0f 00 2d 0b 78 46 00 31 c0 48 89 c1 fb 0f 01 c9 <eb> 06 fb 0f 1f 44 00 00 65 48 8b 04 25 80 ed 01 00 f0 80 60 02 df
> 	 RSP: 0000:ffffa90940217ee0 EFLAGS: 00000246
> 	 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> 	 RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9bb9f93a
> 	 RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000001
> 	 R10: ffffa90940217ea8 R11: 0000000000000000 R12: ffffffffffffffff
> 	 R13: 0000000000000000 R14: ffff8bc88127c500 R15: 0000000000000000
> 	  ? default_idle_call+0x1a/0xa0
> 	  default_idle_call+0x4b/0xa0
> 	  do_idle+0x1f1/0x2c0
> 	  ? _raw_spin_unlock_irqrestore+0x56/0x70
> 	  cpu_startup_entry+0x19/0x20
> 	  start_secondary+0x122/0x150
> 	  secondary_startup_64_no_verify+0xce/0xdb
> 	  </TASK>
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Thanks, added to slab/for-6.2/locking

...
> diff --git a/mm/slab.h b/mm/slab.h
> index 0202a8c2f0d2..7a705e4228c8 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -750,7 +750,11 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>   * The slab lists for all objects.
>   */
>  struct kmem_cache_node {
> +#ifdef CONFIG_SLAB
> +	raw_spinlock_t list_lock;
> +#else
>  	spinlock_t list_lock;
> +#endif
>  
>  #ifdef CONFIG_SLAB
>  	struct list_head slabs_partial;	/* partial list first, better asm code */

Simplified a bit. Since we already have CONFIG_SLAB/CONFIG_SLUB #ifdef
sections, moved the list_lock there.
