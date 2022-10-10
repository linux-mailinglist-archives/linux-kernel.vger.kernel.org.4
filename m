Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7607C5FA681
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJJUpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJJUpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:45:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1E7647DE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:45:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 608BB1F947;
        Mon, 10 Oct 2022 20:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665434745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KSEGUILVvyFFP3fbwKQnxW+rZJlTG9J4yuz2e5Q9QpU=;
        b=R9x4v1Qe6zzAhng3gFD+jQoxjE6qpW6vjWx40ndgy8iKHuh+8kfUXrFxnNBYG7YL1B5eKp
        4WLdMO8oSDCZjeK0WRP0E6uVLWR12KqWYYU58Dc3TXJIhATISiz8k+xbJa0BtjRjiHBM6y
        DmwsT4Zz7WjH3CqcbLUxx2/sSgcSvcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665434745;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KSEGUILVvyFFP3fbwKQnxW+rZJlTG9J4yuz2e5Q9QpU=;
        b=D8zNF/vDoeT9Ehk09ZKEYaUzjqW2Hm05Z2nyOOCYZGsfVzpFJM57qOy2KnQ6t9gpNaJUUv
        Aoqo9XvQFxZk86DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1FCD13ACA;
        Mon, 10 Oct 2022 20:45:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id awN8NHiERGOcLwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 10 Oct 2022 20:45:44 +0000
Message-ID: <a7092c47-63ef-200a-8968-7e3402e19a38@suse.cz>
Date:   Mon, 10 Oct 2022 22:45:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/1] mm/page_alloc: Leave IRQs enabled for per-cpu page
 allocations
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220824141802.23395-1-mgorman@techsingularity.net>
 <CAOUHufbxqn5gjYxnZDLsRtaKgtauFXwL+qq_829Eg5PSJaSPgg@mail.gmail.com>
 <20221010142208.ctsasloh7hbudupc@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221010142208.ctsasloh7hbudupc@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 16:22, Mel Gorman wrote:
> On Wed, Aug 24, 2022 at 10:58:26PM -0600, Yu Zhao wrote:
>> On Wed, Aug 24, 2022 at 8:18 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>>>
>>> The pcp_spin_lock_irqsave protecting the PCP lists is IRQ-safe as a task
>>> allocating from the PCP must not re-enter the allocator from IRQ context.
>>> In each instance where IRQ-reentrancy is possible, the lock is acquired using
>>> pcp_spin_trylock_irqsave() even though IRQs are disabled and re-entrancy
>>> is impossible.
>>>
>>> Demote the lock to pcp_spin_lock avoids an IRQ disable/enable in the common
>>> case at the cost of some IRQ allocations taking a slower path. If the PCP
>>> lists need to be refilled, the zone lock still needs to disable IRQs but
>>> that will only happen on PCP refill and drain. If an IRQ is raised when
>>> a PCP allocation is in progress, the trylock will fail and fallback to
>>> using the buddy lists directly. Note that this may not be a universal win
>>> if an interrupt-intensive workload also allocates heavily from interrupt
>>> context and contends heavily on the zone->lock as a result.
>>
>> Hi,
>>
>> This patch caused the following warning. Please take a look.
>>
>> Thanks.
>>
>>    WARNING: inconsistent lock state
>>    6.0.0-dbg-DEV #1 Tainted: G S      W  O
>>    --------------------------------
> 
> I finally found time to take a closer look at this and I cannot reproduce
> it against 6.0. What workload triggered the warning, on what platform and
> can you post the kernel config used please? It would also help if you
> can remember what git commit the patch was tested upon.
> 
> Thanks and sorry for the long delay.

I didn't (try to) reproduce this, but FWIW the report looked legit to 
me, as after the patch, pcp_spin_trylock() has to be used for both 
allocation and freeing to be IRQ safe. free_unref_page() uses it, so 
it's fine. But as the stack trace in the report shows, 
free_unref_page_list() does pcp_spin_lock() and not _trylock, and that's 
IMHO the problem.

