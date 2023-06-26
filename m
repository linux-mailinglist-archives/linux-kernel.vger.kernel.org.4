Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7622373D8FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjFZH5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFZH5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C31EC2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687766217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uOAJnP04QAKFCJcxBbwOR++ymuaGUXxlWyrgK3rvWd0=;
        b=ieMOfEUu++JrNc7njwO+kwRfULLr99fpzYyM5xFVQ4AOYuIPaXYry+Mr+0T/MUNXNQje7w
        7KVn9YqZPbCNLuRBIH5fD39o4+VrMBsdHCK1bxCdBYEhYbRctvYxVrTwFPxxfVwSH/9n+n
        WKLDOt2dlfRkObKV5fCjOpsDOts7zDk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-BcZsT97_OGaCTjxtAeSiRA-1; Mon, 26 Jun 2023 03:56:55 -0400
X-MC-Unique: BcZsT97_OGaCTjxtAeSiRA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6a2a5f08aso4399891fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687766214; x=1690358214;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOAJnP04QAKFCJcxBbwOR++ymuaGUXxlWyrgK3rvWd0=;
        b=MBcQ8gXkJVx/2yM4TewI5LdRO1t8zu3BRknxWNixGlNIcEcFMSbvmNquvP6P3bPF3M
         /IXQagYPK+gJQSGXE6MxTSvAcSM4aQ5WqSqyjjUDNPtU6uXNJW9Ggcf+z1fK9BI/5VT2
         Qy7vW/m0OyUDsy5NpnIzu40/eZHddCzZJFBQV03/Aclf1arpviUL0SgyV/mnkJkND1tQ
         1e4KbuEhati4RYfwIKk5uuzPmRgWEHUv6aXcYqbm++F2WPS2nzaBC92tIObBq5P7CztD
         ijOfVEMKUyUzhU/mXja4U+1iOUbuRdlxJPoqLNQDVQ2L23RteBZinul5sYz8hqa+FQ93
         v/8w==
X-Gm-Message-State: AC+VfDyXR4eHHT02wB/utJxWmXo3lSjmJO0mN7+3E2qCQ0U/VGCMo311
        cMOwlsKmtWQN1otIbP13AIiPLmiLEoPpcsTSatp8YK/dO13tsQVVJn/EStNCKNgJNFiS+F/dKgQ
        Grr1Mq0SFaw6IWS4S1TowzIoS
X-Received: by 2002:a2e:998c:0:b0:2b1:a3ce:b709 with SMTP id w12-20020a2e998c000000b002b1a3ceb709mr18996191lji.39.1687766214338;
        Mon, 26 Jun 2023 00:56:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Pp1hDwDmtTCkredimp4j8EGH9zDcZodiknqhWEV595slDqikBK6q21kUti8q4+gmhsIWPaw==
X-Received: by 2002:a2e:998c:0:b0:2b1:a3ce:b709 with SMTP id w12-20020a2e998c000000b002b1a3ceb709mr18996180lji.39.1687766213960;
        Mon, 26 Jun 2023 00:56:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:7300:2ef6:6cd6:703c:e498? (p200300cbc74b73002ef66cd6703ce498.dip0.t-ipconnect.de. [2003:cb:c74b:7300:2ef6:6cd6:703c:e498])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f90067880esm9749493wmk.47.2023.06.26.00.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 00:56:53 -0700 (PDT)
Message-ID: <b0a50290-9387-8398-e241-f76f4719f963@redhat.com>
Date:   Mon, 26 Jun 2023 09:56:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/2] mm/page_alloc: Use write_seqlock_irqsave() instead
 write_seqlock() + local_irq_save().
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-3-bigeasy@linutronix.de>
 <ZJXhxJU2jFccMjkg@dhcp22.suse.cz> <20230623201517.yw286Knb@linutronix.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230623201517.yw286Knb@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.23 22:15, Sebastian Andrzej Siewior wrote:
> __build_all_zonelists() acquires zonelist_update_seq by first disabling
> interrupts via local_irq_save() and then acquiring the seqlock with
> write_seqlock(). This is troublesome and leads to problems on
> PREEMPT_RT. The problem is that the inner spinlock_t becomes a sleeping
> lock on PREEMPT_RT and must not be acquired with disabled interrupts.
> 
> The API provides write_seqlock_irqsave() which does the right thing in
> one step.
> printk_deferred_enter() has to be invoked in non-migrate-able context to
> ensure that deferred printing is enabled and disabled on the same CPU.
> This is the case after zonelist_update_seq has been acquired.
> 
> There was discussion on the first submission that the order should be:
> 	local_irq_disable();
> 	printk_deferred_enter();
> 	write_seqlock();
> 
> to avoid pitfalls like having an unaccounted printk() coming from
> write_seqlock_irqsave() before printk_deferred_enter() is invoked. The
> only origin of such a printk() can be a lockdep splat because the
> lockdep annotation happens after the sequence count is incremented.
> This is exceptional and subject to change.
> 
> It was also pointed that PREEMPT_RT can be affected by the printk
> problem since its write_seqlock_irqsave() does not really disable
> interrupts. This isn't the case because PREEMPT_RT's printk
> implementation differs from the mainline implementation in two important
> aspects:
> - Printing happens in a dedicated threads and not at during the
>    invocation of printk().
> - In emergency cases where synchronous printing is used, a different
>    driver is used which does not use tty_port::lock.
> 
> Acquire zonelist_update_seq with write_seqlock_irqsave() and then defer
> printk output.
> 
> Fixes: 1007843a91909 ("mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
> v2…v3
>    - Update comment as per Michal's suggestion.
> 
> v1…v2:
>    - Improve commit description
> 
>   mm/page_alloc.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 47421bedc12b7..440e9af67b48d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5808,19 +5808,17 @@ static void __build_all_zonelists(void *data)
>   	unsigned long flags;
>   
>   	/*
> -	 * Explicitly disable this CPU's interrupts before taking seqlock
> -	 * to prevent any IRQ handler from calling into the page allocator
> -	 * (e.g. GFP_ATOMIC) that could hit zonelist_iter_begin and livelock.
> +	 * The zonelist_update_seq must be acquired with irqsave because the
> +	 * reader can be invoked from IRQ with GFP_ATOMIC.
>   	 */
> -	local_irq_save(flags);
> +	write_seqlock_irqsave(&zonelist_update_seq, flags);
>   	/*
> -	 * Explicitly disable this CPU's synchronous printk() before taking
> -	 * seqlock to prevent any printk() from trying to hold port->lock, for
> +	 * Also disable synchronous printk() to prevent any printk() from
> +	 * trying to hold port->lock, for
>   	 * tty_insert_flip_string_and_push_buffer() on other CPU might be
>   	 * calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with port->lock held.
>   	 */
>   	printk_deferred_enter();
> -	write_seqlock(&zonelist_update_seq);
>   
>   #ifdef CONFIG_NUMA
>   	memset(node_load, 0, sizeof(node_load));
> @@ -5857,9 +5855,8 @@ static void __build_all_zonelists(void *data)
>   #endif
>   	}
>   
> -	write_sequnlock(&zonelist_update_seq);
>   	printk_deferred_exit();
> -	local_irq_restore(flags);
> +	write_sequnlock_irqrestore(&zonelist_update_seq, flags);
>   }
>   
>   static noinline void __init

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

