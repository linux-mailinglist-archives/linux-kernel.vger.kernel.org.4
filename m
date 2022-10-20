Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199DE6057EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJTHK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJTHKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:10:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2345A11877B;
        Thu, 20 Oct 2022 00:10:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B97F822D59;
        Thu, 20 Oct 2022 07:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666249849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QEWeVjqOYQQbw5lvF3e2xG6grXcXxC+LHr64nLybfY=;
        b=BlpEQEGIWXdyaLE+1wpizI3EUhFKMrkzXkII2T/9R279p/Kxn8ytVYS2A78V5Knu8z28ye
        8uXOTTDXY/3wMZbID3yRnsfsTxlmOGXl1r7ti5CgKOXX8YH3CZ3xYlfTXRFIrSBmB+e/+W
        G/pR0/rmXvvOgm9tq3ezV7zUGpbpNds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666249849;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QEWeVjqOYQQbw5lvF3e2xG6grXcXxC+LHr64nLybfY=;
        b=Khq4v0o0jW1Q8j9D4oCutp++7tYOkaIs7WdS8FfwQqjStgh3MPqY1JGYpqVPdPDCGlxo9z
        ILnpMhrbTHDas5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87C9B139D2;
        Thu, 20 Oct 2022 07:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ewSCIHn0UGMffQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 20 Oct 2022 07:10:49 +0000
Message-ID: <4a29b39a-b9b5-9c95-e43a-9e5f87801786@suse.cz>
Date:   Thu, 20 Oct 2022 09:10:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH rcu 5/8] slab: Explain why SLAB_DESTROY_BY_RCU reference
 before locking
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
References: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
 <20221019224659.2499511-5-paulmck@kernel.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221019224659.2499511-5-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 00:46, Paul E. McKenney wrote:
> It is not obvious to the casual user why it is absolutely necessary to
> acquire a reference to a SLAB_DESTROY_BY_RCU structure before acquiring
> a lock in that structure.  Therefore, add a comment explaining this point.

s/SLAB_DESTROY_BY_RCU/SLAB_TYPESAFE_BY_RCU/ in subject, commit log and the
added comment? :)

> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: <linux-mm@kvack.org>
> ---
>  include/linux/slab.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 90877fcde70bd..446303e385265 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -76,6 +76,12 @@
>   * rcu_read_lock before reading the address, then rcu_read_unlock after
>   * taking the spinlock within the structure expected at that address.
>   *
> + * Note that it is not possible to acquire a lock within a structure
> + * allocated with SLAB_DESTROY_BY_RCU without first acquiring a reference
> + * as described above.  The reason is that SLAB_DESTROY_BY_RCU pages are
> + * not zeroed before being given to the slab, which means that any locks
> + * must be initialized after each and every kmem_struct_alloc().
> + *

Wonder if slab caches with a constructor should be OK here as AFAIK it
should mean the object has to be in the initialized state both when
allocated and freed?

>   * Note that SLAB_TYPESAFE_BY_RCU was originally named SLAB_DESTROY_BY_RCU.
>   */
>  /* Defer freeing slabs to RCU */

