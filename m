Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C3072A209
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjFISVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjFISVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:21:04 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3543F3583
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:21:03 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1b02497f4cfso8199455ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 11:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686334862; x=1688926862;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IaWjrGNhqSByWN0/XqnLQhJI8MLJxrR5fieFPN9nYXE=;
        b=gTjFBcr3IT7XV77IRCDrjPBQQvALdqR5p0uN7UQwKx/0GcbeZzLo6FWPzkHIR6+yaY
         Wa17VBiCPuW2gnKonvAWDaGXcg41CE44BFJEUipP+HsJzGYp/GugJjqL1d9ZLvTM/x64
         STKd7Jo7vYgWPoAn3IZyjvPhHsWvDZKbzaGYoQCwrUA3v2BzGFtI98s0UC5xcsA/fEWQ
         u4wUL7tdcd8iarqPx93mCV+a4eL6uKIoZAptgGTDZJpckooIGU+AcQPoZTP7Z82f10q5
         B0s0ql2y57ZMzlMeT85s0C7upmcK2MIXr46eK76WHNBkPe9Ef6s+mtRx1jN0+dR+3116
         dPhQ==
X-Gm-Message-State: AC+VfDyKeK8nwZ/QvjrSTJG/7SCyuh9kqwKk8QOQoqSgYiwRD929YvSS
        csr9v1wC6yXLL07mGUPYgKw=
X-Google-Smtp-Source: ACHHUZ4BhBmkbsnJosS7fjxzReTQSXqEYezEONtWNid7NI7UpCLzdo4A4kG2zBTNRVrdS4HK4HdY6w==
X-Received: by 2002:a17:902:ecc9:b0:1b0:fe9:e57e with SMTP id a9-20020a170902ecc900b001b00fe9e57emr2117151plh.0.1686334862459;
        Fri, 09 Jun 2023 11:21:02 -0700 (PDT)
Received: from V92F7Y9K0C.lan ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001ae0a4b1d3fsm3589234plg.153.2023.06.09.11.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:21:01 -0700 (PDT)
Date:   Fri, 9 Jun 2023 11:20:58 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     "Ma, Yu" <yu.ma@intel.com>
Cc:     "Liam.Howlett@Oracle.com" <Liam.Howlett@oracle.com>,
        Dennis Zhou <dennis@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Zhu, Lipeng" <lipeng.zhu@intel.com>,
        "Deng, Pan" <pan.deng@intel.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "Li, Tianyou" <tianyou.li@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2] percpu-internal/pcpu_chunk: Re-layout pcpu_chunk
 structure to reduce false sharing
Message-ID: <ZINtij2HhIu9h9Wx@V92F7Y9K0C.lan>
References: <20230606125404.95256-1-yu.ma@intel.com>
 <20230607145009.58899-1-yu.ma@intel.com>
 <SN7PR11MB7590D5959AF7179137A314FEE153A@SN7PR11MB7590.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN7PR11MB7590D5959AF7179137A314FEE153A@SN7PR11MB7590.namprd11.prod.outlook.com>
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

Hi Yu,

On Wed, Jun 07, 2023 at 03:02:32PM +0000, Ma, Yu wrote:
> Thanks Liam and Dennis for review, this is updated patch with comment around:
> 
> > When running UnixBench/Execl throughput case, false sharing is observed
> > due to frequent read on base_addr and write on free_bytes, chunk_md.
> > 
> > UnixBench/Execl represents a class of workload where bash scripts are
> > spawned frequently to do some short jobs. It will do system call on execl
> > frequently, and execl will call mm_init to initialize mm_struct of the process.
> > mm_init will call __percpu_counter_init for percpu_counters initialization.
> > Then pcpu_alloc is called to read the base_addr of pcpu_chunk for memory
> > allocation. Inside pcpu_alloc, it will call pcpu_alloc_area  to allocate memory
> > from a specified chunk.
> > This function will update "free_bytes" and "chunk_md" to record the rest
> > free bytes and other meta data for this chunk. Correspondingly,
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
> > In current pcpu_chunk layout, ‘base_addr’ is in the same cache line with
> > ‘free_bytes’ and ‘chunk_md’, and ‘base_addr’ is at the last 8 bytes. This
> > patch moves ‘bound_map’ up to ‘base_addr’, to let ‘base_addr’ locate in a
> > new cacheline.
> > 
> > With this change, on Intel Sapphire Rapids 112C/224T platform, based on
> > v6.4-rc4, the 160 parallel score improves by 24%.
> > 
> > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > Signed-off-by: Yu Ma <yu.ma@intel.com>
> > ---
> >  mm/percpu-internal.h | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h index
> > f9847c131998..ecc7be1ec876 100644
> > --- a/mm/percpu-internal.h
> > +++ b/mm/percpu-internal.h
> > @@ -41,10 +41,16 @@ struct pcpu_chunk {
> >  	struct list_head	list;		/* linked to pcpu_slot lists */
> >  	int			free_bytes;	/* free bytes in the chunk */
> >  	struct pcpu_block_md	chunk_md;
> > +	unsigned long		*bound_map;	/* boundary map */
> > +
> > +	/*
> > +	 * To reduce false sharing, current layout is optimized to make sure
> > +	 * base_addr locate in the different cacheline with free_bytes and
> > +	 * chunk_md.
> > +	 */
> >  	void			*base_addr;	/* base address of this chunk
> > */
> > 
> >  	unsigned long		*alloc_map;	/* allocation map */
> > -	unsigned long		*bound_map;	/* boundary map */
> >  	struct pcpu_block_md	*md_blocks;	/* metadata blocks */
> > 
> >  	void			*data;		/* chunk data */
> > --
> > 2.39.3
> 

Thanks for adding the comment, but would you mind adding
____cacheline_aligned_in_smp? Unless that's something we're trying to
avoid, I think this is a good use case for it both on the pcpu_chunk and
specifically on base_addr as that's what we're accessing without a lock.

Thanks,
Dennis
