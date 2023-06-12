Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170D072D376
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbjFLVnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjFLVnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:43:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42494E9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:43:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2E1E62E0B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC68C433EF;
        Mon, 12 Jun 2023 21:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686606213;
        bh=pJu03XMdmPE7SbWuyufLP/c1f6vs0Y+aafTE9PXHw1Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZJPFlxxSuK1z4No0psN3Y/lGE4KZCsRmSZq3Cu3v28aUB/M8v5Y4HtJkXMIB2UQIg
         NoVN3BIsmeDWXYSplidLRSNzvE4vq2BgLKN6XVQB6ENTsiKGwseQLqCb+qzAb5MytN
         C0YpByv+OpVN4WEG4V0nJa/craec2ZW7r/bp92Bg=
Date:   Mon, 12 Jun 2023 14:43:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Ma <yu.ma@intel.com>
Cc:     dennis@kernel.org, Liam.Howlett@oracle.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lipeng.zhu@intel.com, pan.deng@intel.com, shakeelb@google.com,
        tianyou.li@intel.com, tim.c.chen@intel.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v3] percpu-internal/pcpu_chunk: Re-layout pcpu_chunk
 structure to reduce false sharing
Message-Id: <20230612144331.b1d069bce4ba3800fdd62738@linux-foundation.org>
In-Reply-To: <20230610030730.110074-1-yu.ma@intel.com>
References: <ZINtij2HhIu9h9Wx@V92F7Y9K0C.lan>
        <20230610030730.110074-1-yu.ma@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Jun 2023 23:07:30 -0400 Yu Ma <yu.ma@intel.com> wrote:

> When running UnixBench/Execl throughput case, false sharing is observed
> due to frequent read on base_addr and write on free_bytes, chunk_md.
> 
> UnixBench/Execl represents a class of workload where bash scripts
> are spawned frequently to do some short jobs. It will do system call on
> execl frequently, and execl will call mm_init to initialize mm_struct
> of the process. mm_init will call __percpu_counter_init for
> percpu_counters initialization. Then pcpu_alloc is called to read
> the base_addr of pcpu_chunk for memory allocation. Inside pcpu_alloc,
> it will call pcpu_alloc_area  to allocate memory from a specified chunk.
> This function will update "free_bytes" and "chunk_md" to record the
> rest free bytes and other meta data for this chunk. Correspondingly,
> pcpu_free_area will also update these 2 members when free memory.
> Call trace from perf is as below:
> +   57.15%  0.01%  execl   [kernel.kallsyms] [k] __percpu_counter_init
> +   57.13%  0.91%  execl   [kernel.kallsyms] [k] pcpu_alloc
> -   55.27% 54.51%  execl   [kernel.kallsyms] [k] osq_lock
>    - 53.54% 0x654278696e552f34
>         main
>         __execve
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         __x64_sys_execve
>         do_execveat_common.isra.47
>         alloc_bprm
>         mm_init
>         __percpu_counter_init
>         pcpu_alloc
>       - __mutex_lock.isra.17
> 
> In current pcpu_chunk layout, ‘base_addr’ is in the same cache line
> with ‘free_bytes’ and ‘chunk_md’, and ‘base_addr’ is at the
> last 8 bytes. This patch moves ‘bound_map’ up to ‘base_addr’,
> to let ‘base_addr’ locate in a new cacheline.
> 
> With this change, on Intel Sapphire Rapids 112C/224T platform,
> based on v6.4-rc4, the 160 parallel score improves by 24%.

Well that's nice.

>
> ...
>
> --- a/mm/percpu-internal.h
> +++ b/mm/percpu-internal.h
> @@ -41,10 +41,17 @@ struct pcpu_chunk {
>  	struct list_head	list;		/* linked to pcpu_slot lists */
>  	int			free_bytes;	/* free bytes in the chunk */
>  	struct pcpu_block_md	chunk_md;
> -	void			*base_addr;	/* base address of this chunk */
> +	unsigned long		*bound_map;	/* boundary map */
> +	
> +	/* 
> +	 * base_addr is the base address of this chunk.
> +	 * To reduce false sharing, current layout is optimized to make sure
> +	 * base_addr locate in the different cacheline with free_bytes and
> +	 * chunk_md.
> +	 */
> +	void			*base_addr ____cacheline_aligned_in_smp;
>  
>  	unsigned long		*alloc_map;	/* allocation map */
> -	unsigned long		*bound_map;	/* boundary map */
>  	struct pcpu_block_md	*md_blocks;	/* metadata blocks */
>  
>  	void			*data;		/* chunk data */

This will of course consume more memory.  Do we have a feel for the
worst-case impact of this?

