Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8429D67B510
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjAYOra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbjAYOr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:47:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5095030E3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 06:47:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2D7F61534
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D65C433D2;
        Wed, 25 Jan 2023 14:47:23 +0000 (UTC)
Date:   Wed, 25 Jan 2023 14:47:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     George Prekas <george@enfabrica.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 1/9] mm: kmemleak: properly disable task stack scanning
Message-ID: <Y9FA+fFBytksYZi9@arm.com>
References: <20230123170419.7292-1-george@enfabrica.net>
 <20230123170419.7292-2-george@enfabrica.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123170419.7292-2-george@enfabrica.net>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 11:04:11AM -0600, George Prekas wrote:
> @@ -1586,23 +1608,6 @@ static void kmemleak_scan(void)
>  	}
>  	put_online_mems();
>  
> -	/*
> -	 * Scanning the task stacks (may introduce false negatives).
> -	 */
> -	if (kmemleak_stack_scan) {
> -		struct task_struct *p, *g;
> -
> -		rcu_read_lock();
> -		for_each_process_thread(g, p) {
> -			void *stack = try_get_task_stack(p);
> -			if (stack) {
> -				scan_block(stack, stack + THREAD_SIZE, NULL);
> -				put_task_stack(p);
> -			}
> -		}
> -		rcu_read_unlock();
> -	}

On architectures without VMAP_STACK, we still need the above otherwise
it could lead to some false positives.

-- 
Catalin
