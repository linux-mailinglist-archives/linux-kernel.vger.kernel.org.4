Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F703724EC5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbjFFV0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbjFFV0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:26:03 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9761703
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 14:26:03 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-53404873a19so3459584a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 14:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686086762; x=1688678762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zC4QoBDS/PVcd+xuGELUqjLK2nruU3LnP3t1Jluqdlw=;
        b=is6Lqv6XZpAvGIxIG3JcNVC4C9OfiuXU27JTYhYoysYh3Kghs9hvkIF9FQVIBy9wu5
         f4kV4dF1ML6/sFhv6bSbrobZQYO1MFzwMb2rtTB1PyLhp6oIDzwdEVXFpZybr82qI6dY
         qdhqVNqVGZQajM0JuApr6W1h9QIxm6pB4TP+Vqr8ZjJTk3JAa2BFaWugdYDXwrM04/hs
         yC1BAMtjuRqQ+/q4ZpFbfGSIT0Nhwj0qhCShhEGR7GwD92W29VOOISkyZCm/50oUBGWW
         IB2ioSrOFcEuXgmOpHbSAQDlwnxiQf2myNuvBx1ZbCFLCcUKvAnB0aR4JctrkxIBYjc4
         IaXw==
X-Gm-Message-State: AC+VfDz9Png6CZZSIhZga5xqkhuxeDUvmPIj2yA0pYsqG5GLsYX0+vH1
        A1piSGfaubDWujB4g8oevtE=
X-Google-Smtp-Source: ACHHUZ5KL2dkTrDBHB5xFhsizQ21blEeXqp67Pe2LQdYDiY/iIvys/JkvRO5W6BkaVZJEHCTVOZdKQ==
X-Received: by 2002:a05:6a20:9191:b0:113:fe95:da8c with SMTP id v17-20020a056a20919100b00113fe95da8cmr712667pzd.14.1686086762296;
        Tue, 06 Jun 2023 14:26:02 -0700 (PDT)
Received: from V92F7Y9K0C.corp.robot.car ([199.73.127.2])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c24c00b001afebec96basm8992514plg.148.2023.06.06.14.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 14:26:01 -0700 (PDT)
Date:   Tue, 6 Jun 2023 14:25:56 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Yu Ma <yu.ma@intel.com>, akpm@linux-foundation.org,
        tim.c.chen@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        dan.j.williams@intel.com, shakeelb@google.com, pan.deng@intel.com,
        tianyou.li@intel.com, lipeng.zhu@intel.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH] percpu-internal/pcpu_chunk: Re-layout pcpu_chunk
 structure to reduce false sharing
Message-ID: <ZH-kZA5kRmWjcrTI@V92F7Y9K0C.corp.robot.car>
References: <20230606125404.95256-1-yu.ma@intel.com>
 <20230606192127.w66indpq74ec6eyt@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230606192127.w66indpq74ec6eyt@revolver>
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

Hello,

On Tue, Jun 06, 2023 at 03:21:27PM -0400, Liam R. Howlett wrote:
> * Yu Ma <yu.ma@intel.com> [230606 08:27]:
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
> Can we have a comment somewhere around this structure to avoid someone
> reverting this change by accident?
> 

I agree with Liam. It was only recently percpu was added to the
mm_struct so this wasn't originally on the hot path. It's probably worth
reshuffling around pcpu_chunk because as you point out base_addr is
read_only after init. There in general aren't that many of these structs
on any particular host, so its probably good to just annotate with
____cacheline_aligned_in_smp and potentially reshuffle around a few
other variables.

Another optimization here is a batch allocation which hasn't been done
yet (allocate essentially an array of percpu variables all at once, but
allow for their lifetimes to be independent).

PS - I know I'm not super active, but please cc me on percpu changes.

Thanks,
Dennis

> > 
> > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > Signed-off-by: Yu Ma <yu.ma@intel.com>
> > ---
> >  mm/percpu-internal.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
> > index f9847c131998..981eeb2ad0a9 100644
> > --- a/mm/percpu-internal.h
> > +++ b/mm/percpu-internal.h
> > @@ -41,10 +41,10 @@ struct pcpu_chunk {
> >  	struct list_head	list;		/* linked to pcpu_slot lists */
> >  	int			free_bytes;	/* free bytes in the chunk */
> >  	struct pcpu_block_md	chunk_md;
> > +	unsigned long		*bound_map;	/* boundary map */
> >  	void			*base_addr;	/* base address of this chunk */
> >  
> >  	unsigned long		*alloc_map;	/* allocation map */
> > -	unsigned long		*bound_map;	/* boundary map */
> >  	struct pcpu_block_md	*md_blocks;	/* metadata blocks */
> >  
> >  	void			*data;		/* chunk data */
> > -- 
> > 2.39.3
> > 
> 
