Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAF970DBDD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbjEWL7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbjEWL7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:59:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F443109
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:59:00 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae507af2e5so34470645ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684843140; x=1687435140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n4th3iXOfa5qIG2MobVS/IDr8buOOQSispksL/hzEfA=;
        b=oBuMY1mwpDRyQ/c9mrNJt6P4ahBppKTLrL1gS6q7FTOkPweEwSDwIMF6kpRz8gpVAE
         /zr6l2BFroCbmEhqu23/LI6Cu9W2/+8TztbaLnQqteEU0caVwds1TkJQt9aLss4OGhDb
         OjpPgbVOomylzCfu+gJPYBf1JXjC0shXmIgh0vO3powFQMvn/+rZ5x7935z+VFlNWWzX
         A6xlMpLYHDIbUVPnd0F8qEevcgibG4FsZdlBzdcAh76BUcvCbWuftm3RuX2AsX6rfGK2
         aPN6X5kr339zlfvg/RvbpYrseq0eAadjAFsZR6t7XXit5w1C5wrCmgZL3qiRH39OGaDV
         0NVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684843140; x=1687435140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4th3iXOfa5qIG2MobVS/IDr8buOOQSispksL/hzEfA=;
        b=kVkT2M+a+moEpNK59MBiiwFI+kmsK7XVgV1j4H0hAyPf4iBWzEiLYMwpaJdhywD8ux
         0ELcl58ZiOgT3RNaOtUUbburj2aKqVek/dW6fOVzaOJIp8IQg5QqAi+XCS1IOVcQ1wxz
         o3Pvwt2jmmpTvdpDp7bp4cEu/7/OunhpOIZe/uBkYo/YxRtt8egRaECRPjOQBo/+6t/L
         DjrCPOtz4Tln28+S2jxZYri76/mNNEmcBzF1cX0BpVKsp6Xe/7MnTWA0leiz7xfUyho5
         1FjRbsXGT6qIlzo4Q6yYQrhBP8eyetmSMSIxriUCTSniJbSQc0wN0to8jr96A++gGXuR
         XYxQ==
X-Gm-Message-State: AC+VfDyLHTToLhkq8pfRBvCpnm9IX7QJ/o7IBFYkaEEkMhIK0VmgGhmm
        g2LYdqL8nGLcE0tZqsHa+BM=
X-Google-Smtp-Source: ACHHUZ6pTcFC6bhAYSWxCL+9RgiqZwcBn1Swkgkp+WkLW+9AgtOk1VjAOPYjwpciAhT574UEhmE/og==
X-Received: by 2002:a17:902:c403:b0:1a9:4cd5:e7e0 with SMTP id k3-20020a170902c40300b001a94cd5e7e0mr21664656plk.17.1684843139548;
        Tue, 23 May 2023 04:58:59 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 ([121.183.137.144])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001a943c41c37sm6659206plc.7.2023.05.23.04.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 04:58:58 -0700 (PDT)
Date:   Tue, 23 May 2023 20:59:05 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 0/9] Mitigate a vmap lock contention
Message-ID: <ZGyqiaRnMJPFhxR6@debian-BULLSEYE-live-builder-AMD64>
References: <20230522110849.2921-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522110849.2921-1-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 01:08:40PM +0200, Uladzislau Rezki (Sony) wrote:
> Hello, folk.
> 
> 1. This is a followup of the vmap topic that was highlighted at the LSFMMBPF-2023
> conference. This small serial attempts to mitigate the contention across the
> vmap/vmalloc code. The problem is described here:
> 

Hello Uladzislau, thank you for the work!

> wget ftp://vps418301.ovh.net/incoming/Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf

I ran the exactly same command but couldn't download the file, did I
miss something?

$ wget ftp://vps418301.ovh.net/incoming/Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf
[...]
==> PASV ... done.    ==> RETR Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf ... 
No such file `Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf'.

> The material is tagged as a v2 version. It contains extra slides about testing
> the throughput, steps and comparison with a current approach.
> 
> 2. Motivation.
> 
> - The vmap code is not scalled to number of CPUs and this should be fixed;
> - XFS folk has complained several times that vmalloc might be contented on
>   their workloads:
> 
> <snip>
> commit 8dc9384b7d75012856b02ff44c37566a55fc2abf
> Author: Dave Chinner <dchinner@redhat.com>
> Date:   Tue Jan 4 17:22:18 2022 -0800
> 
>     xfs: reduce kvmalloc overhead for CIL shadow buffers
>     
>     Oh, let me count the ways that the kvmalloc API sucks dog eggs.
>     
>     The problem is when we are logging lots of large objects, we hit
>     kvmalloc really damn hard with costly order allocations, and
>     behaviour utterly sucks:

based on the commit I guess xfs should use vmalloc/kvmalloc is because
it allocates large buffers, how large could it be?

> 3. Test
> 
> On my: AMD Ryzen Threadripper 3970X 32-Core Processor, i have below figures:
> 
>     1-page     1-page-this-patch
> 1  0.576131   vs   0.555889
> 2   2.68376   vs    1.07895
> 3   4.26502   vs    1.01739
> 4   6.04306   vs    1.28924
> 5   8.04786   vs    1.57616
> 6   9.38844   vs    1.78142

<snip>

> 29    20.06   vs    3.59869
> 30  20.4353   vs     3.6991
> 31  20.9082   vs    3.73028
> 32  21.0865   vs    3.82904
> 
> 1..32 - is a number of jobs. The results are in usec and is a vmallco()/vfree()
> pair throughput.

I would be more interested in real numbers than synthetic benchmarks,
Maybe XFS folks could help performing profiling similar to commit 8dc9384b7d750
with and without this patchset?

By the way looking at the commit, teaching __p?d_alloc() about gfp
context (that I'm _slowly_ working on...) could be nice for allowing
non-GFP_KERNEL kvmalloc allocations, as Matthew mentioned. [1]

Thanks!

[1] https://lore.kernel.org/linux-mm/Y%2FOHC33YLedMXTlD@casper.infradead.org

-- 
Hyeonggon Yoo

Doing kernel stuff as a hobby
Undergraduate | Chungnam National University
Dept. Computer Science & Engineering
