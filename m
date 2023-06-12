Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB4672D3A7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbjFLVzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbjFLVzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:55:49 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8A5E47
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:55:48 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-3f9dd2fabe2so3126721cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686606947; x=1689198947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdjVUJ6/scsSqpoSTprToMI3M6bYhDxCkzPi9uXpyWQ=;
        b=B14QBvpVJbdqQsVKmxDcUXelCXP1fVETXj2AkcdhqCNGM2Ly7hrEupgIlmrSdCtOU/
         qpBMrnQIUFGIe86ruYVNkv6ZlmovzcWu9oDvzMtUn+CEL5N3+SaqNmx19TleGWOKwCPv
         ONKQoyITvR/5qO/dF9HxoV+XEDLVIfQywlAKNxAkpePrspMr7rPqCDpL/erY7TqlLTb0
         9bPMtPvh3dMg31nr7YhBkUoyGELSYCO7rZ037+oX3s99MOk2+jow/CeHP8jAycBkg8Rz
         loMagm13Dmzvj9+E0pZaj0LRBfoTZ5hvBpJxU0upAKvrieDDo/1t8iJ/qs9Y2r0jccEd
         LMiw==
X-Gm-Message-State: AC+VfDzWM6PiTTcLgoVMWvQwGYpemw1crqyD3NXbjbvMWZDiIsjWUlX0
        5vJuDUVUSpd4PkUlrg6g66o=
X-Google-Smtp-Source: ACHHUZ4m5vStrs0sioVKbOYDwj/2oyC5bo7y8pq6ntqGS4HJej45p5Csu8B3wr92BynaH+AKYVHjSw==
X-Received: by 2002:ad4:5ca8:0:b0:626:1984:2461 with SMTP id q8-20020ad45ca8000000b0062619842461mr11872904qvh.28.1686606947610;
        Mon, 12 Jun 2023 14:55:47 -0700 (PDT)
Received: from V92F7Y9K0C.lan (c-73-228-235-230.hsd1.mn.comcast.net. [73.228.235.230])
        by smtp.gmail.com with ESMTPSA id l5-20020a0ce085000000b0062439f05b87sm3539394qvk.45.2023.06.12.14.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:55:47 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:55:44 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Ma <yu.ma@intel.com>, dennis@kernel.org,
        Liam.Howlett@oracle.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lipeng.zhu@intel.com, pan.deng@intel.com,
        shakeelb@google.com, tianyou.li@intel.com, tim.c.chen@intel.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v3] percpu-internal/pcpu_chunk: Re-layout pcpu_chunk
 structure to reduce false sharing
Message-ID: <ZIeUYNd8sAVm1xE8@V92F7Y9K0C.lan>
References: <ZINtij2HhIu9h9Wx@V92F7Y9K0C.lan>
 <20230610030730.110074-1-yu.ma@intel.com>
 <20230612144331.b1d069bce4ba3800fdd62738@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612144331.b1d069bce4ba3800fdd62738@linux-foundation.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Mon, Jun 12, 2023 at 02:43:31PM -0700, Andrew Morton wrote:
> On Fri,  9 Jun 2023 23:07:30 -0400 Yu Ma <yu.ma@intel.com> wrote:
> 
> > When running UnixBench/Execl throughput case, false sharing is observed
> > due to frequent read on base_addr and write on free_bytes, chunk_md.
> > 
> > UnixBench/Execl represents a class of workload where bash scripts
> > are spawned frequently to do some short jobs. It will do system call on
> > execl frequently, and execl will call mm_init to initialize mm_struct
> > of the process. mm_init will call __percpu_counter_init for
> > percpu_counters initialization. Then pcpu_alloc is called to read
> > the base_addr of pcpu_chunk for memory allocation. Inside pcpu_alloc,
> > it will call pcpu_alloc_area  to allocate memory from a specified chunk.
> > This function will update "free_bytes" and "chunk_md" to record the
> > rest free bytes and other meta data for this chunk. Correspondingly,
> > pcpu_free_area will also update these 2 members when free memory.
> > Call trace from perf is as below:
> > +   57.15%  0.01%  execl   [kernel.kallsyms] [k] __percpu_counter_init
> > +   57.13%  0.91%  execl   [kernel.kallsyms] [k] pcpu_alloc
> > -   55.27% 54.51%  execl   [kernel.kallsyms] [k] osq_lock
> >    - 53.54% 0x654278696e552f34
> >         main
> >         __execve
> >         entry_SYSCALL_64_after_hwframe
> >         do_syscall_64
> >         __x64_sys_execve
> >         do_execveat_common.isra.47
> >         alloc_bprm
> >         mm_init
> >         __percpu_counter_init
> >         pcpu_alloc
> >       - __mutex_lock.isra.17
> > 
> > In current pcpu_chunk layout, ‘base_addr’ is in the same cache line
> > with ‘free_bytes’ and ‘chunk_md’, and ‘base_addr’ is at the
> > last 8 bytes. This patch moves ‘bound_map’ up to ‘base_addr’,
> > to let ‘base_addr’ locate in a new cacheline.
> > 
> > With this change, on Intel Sapphire Rapids 112C/224T platform,
> > based on v6.4-rc4, the 160 parallel score improves by 24%.
> 
> Well that's nice.
> 
> >
> > ...
> >
> > --- a/mm/percpu-internal.h
> > +++ b/mm/percpu-internal.h
> > @@ -41,10 +41,17 @@ struct pcpu_chunk {
> >  	struct list_head	list;		/* linked to pcpu_slot lists */
> >  	int			free_bytes;	/* free bytes in the chunk */
> >  	struct pcpu_block_md	chunk_md;
> > -	void			*base_addr;	/* base address of this chunk */
> > +	unsigned long		*bound_map;	/* boundary map */
> > +	
> > +	/* 
> > +	 * base_addr is the base address of this chunk.
> > +	 * To reduce false sharing, current layout is optimized to make sure
> > +	 * base_addr locate in the different cacheline with free_bytes and
> > +	 * chunk_md.
> > +	 */
> > +	void			*base_addr ____cacheline_aligned_in_smp;
> >  
> >  	unsigned long		*alloc_map;	/* allocation map */
> > -	unsigned long		*bound_map;	/* boundary map */
> >  	struct pcpu_block_md	*md_blocks;	/* metadata blocks */
> >  
> >  	void			*data;		/* chunk data */
> 
> This will of course consume more memory.  Do we have a feel for the
> worst-case impact of this?
> 

The pcpu_chunk struct is a backing data structure per chunk, so the
additional memory should not be dramatic. A chunk covers ballpark
between 64kb and 512kb memory depending on some config and boot time
stuff, so I believe the additional memory used here is nominal at best.

Working the #s on my desktop:
Percpu:            58624 kB
28 cores -> ~2.1MB of percpu memory.
At say ~128KB per chunk -> 33 chunks, generously 40 chunks.
Adding alignment might bump the chunk size ~64 bytes, so in total ~2KB
of overhead?

I believe we can do a little better to avoid eating that full padding,
so likely less than that.

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
