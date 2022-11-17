Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2EC62D09F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiKQBZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbiKQBZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:25:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF553134D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:25:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFD296205E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115AEC433D7;
        Thu, 17 Nov 2022 01:25:24 +0000 (UTC)
Date:   Wed, 16 Nov 2022 20:25:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mingo@redhat.com, sfr@canb.auug.org.au,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 2/8] riscv/kprobe: Allocate detour buffer from module
 area
Message-ID: <20221116202521.6c528955@gandalf.local.home>
In-Reply-To: <20221106100316.2803176-3-chenguokai17@mails.ucas.ac.cn>
References: <20221106100316.2803176-1-chenguokai17@mails.ucas.ac.cn>
        <20221106100316.2803176-3-chenguokai17@mails.ucas.ac.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  6 Nov 2022 18:03:10 +0800
Chen Guokai <chenguokai17@mails.ucas.ac.cn> wrote:

> @@ -84,6 +85,30 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  }
>  
>  #ifdef CONFIG_MMU
> +#if defined(CONFIG_OPTPROBES) && defined(CONFIG_64BIT)
> +void *alloc_optinsn_page(void)
> +{
> +	void *page;
> +
> +	page = __vmalloc_node_range(PAGE_SIZE, 1, MODULES_VADDR,
> +				    MODULES_END, GFP_KERNEL,
> +				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> +				    __builtin_return_address(0));
> +	if (!page)
> +		return NULL;
> +
> +	set_vm_flush_reset_perms(page);
> +	/*
> +	 * First make the page read-only, and only then make it executable to
> +	 * prevent it from being W+X in between.
> +	 */
> +	set_memory_ro((unsigned long)page, 1);
> +	set_memory_x((unsigned long)page, 1);

FYI, the above combination is going to be going away:

  https://lore.kernel.org/all/Y10OyLCLAAS6rsZv@hirez.programming.kicks-ass.net/

-- Steve


> +
> +	return page;
> +}
> +#endif
> +
