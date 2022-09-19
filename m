Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AF55BD3BD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiISRbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiISRaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:30:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E468724970
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:30:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 66DE41F898;
        Mon, 19 Sep 2022 17:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663608641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PmLUJNFKcsCZ1gHK73spc+qwFN9fPuW7xXhdt6tJOQ=;
        b=e6Szmj3CuBWAGaE1OSi+u0rV50q+8/frIWnnJUsYfoI1YkRtwynZQIAPAzZBF53kC2c8qo
        TpH0+5DBMWTbq3nY1oQcn1dfOjAbNcbvndni9kqLeyui4IL00GcQklp1/PPVni591qnsTy
        uXPIrSLJEMCkCsbXBcDpTrO7E21Wusw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663608641;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PmLUJNFKcsCZ1gHK73spc+qwFN9fPuW7xXhdt6tJOQ=;
        b=li0L7ViU5O9rsAijUUzrIUd5EflTAR6rcTgXDPm55/qdpOSKXkT5g9waF+JS4WJ2VPMT5r
        IhkRpOff4kOgSoBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D45413A96;
        Mon, 19 Sep 2022 17:30:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XEZHDkGnKGPyKgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 19 Sep 2022 17:30:41 +0000
Message-ID: <045d6ddc-463c-a620-89e1-d48c86217c23@suse.cz>
Date:   Mon, 19 Sep 2022 19:30:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V3] mm: slub: fix flush_cpu_slab()/__free_slab()
 invocations in task context.
Content-Language: en-US
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     linux-mm@kvack.org, rientjes@google.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <20220919163929.351068-1-mlombard@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220919163929.351068-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/22 18:39, Maurizio Lombardi wrote:
> Commit 5a836bf6b09f ("mm: slub: move flush_cpu_slab() invocations
> __free_slab() invocations out of IRQ context") moved all flush_cpu_slab()
> invocations to the global workqueue to avoid a problem related
> with deactivate_slab()/__free_slab() being called from an IRQ context
> on PREEMPT_RT kernels.
> 
> When the flush_all_cpu_locked() function is called from a task context
> it may happen that a workqueue with WQ_MEM_RECLAIM bit set ends up
> flushing the global workqueue, this will cause a dependency issue.
> 
>  workqueue: WQ_MEM_RECLAIM nvme-delete-wq:nvme_delete_ctrl_work [nvme_core]
>    is flushing !WQ_MEM_RECLAIM events:flush_cpu_slab
>  WARNING: CPU: 37 PID: 410 at kernel/workqueue.c:2637
>    check_flush_dependency+0x10a/0x120
>  Workqueue: nvme-delete-wq nvme_delete_ctrl_work [nvme_core]
>  RIP: 0010:check_flush_dependency+0x10a/0x120[  453.262125] Call Trace:
>  __flush_work.isra.0+0xbf/0x220
>  ? __queue_work+0x1dc/0x420
>  flush_all_cpus_locked+0xfb/0x120
>  __kmem_cache_shutdown+0x2b/0x320
>  kmem_cache_destroy+0x49/0x100
>  bioset_exit+0x143/0x190
>  blk_release_queue+0xb9/0x100
>  kobject_cleanup+0x37/0x130
>  nvme_fc_ctrl_free+0xc6/0x150 [nvme_fc]
>  nvme_free_ctrl+0x1ac/0x2b0 [nvme_core]
> 
> Fix this bug by creating a workqueue for the flush operation with
> the WQ_MEM_RECLAIM bit set.
> 
> v2: Create a workqueue with WQ_MEM_RECLAIM
>     instead of trying to revert the changes.
> 
> v3: replace create_workqueue() with alloc_workqueue() and BUG_ON() with
>     WARN_ON()
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>

Thanks, I added a Fixes: and Cc stable as AFAICS the warnings are not under
a debugging config option, and it could bite somebody near OOM. Added to
slab.git for-6.0/fixes and will include in pullrq this week.

