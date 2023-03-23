Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94BB6C7231
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjCWVNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjCWVNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:13:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E186612858
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84FF0B82242
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 21:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E78C4339B;
        Thu, 23 Mar 2023 21:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679605974;
        bh=Z0sInuaH1aKsCzVuN3S/I6jdhr0FX0yp6ICyU7bBNig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0RrW82habQUn3iTNR+722021vuT109WUE/b+asyJPATK4F8V/gfZBzYAZ7BoO/cTf
         G6TwY2KPsVQB4NWHY5WZMhdoY1aJoyKl6Cv/memxq+gDXhV7D/jiRiwGTkPVXvxs2C
         UoDY7v1J4cQZ4vGLriEe/zoGjcKfaa80ET9DD1hI=
Date:   Thu, 23 Mar 2023 14:12:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Remove a global vmap_blocks xarray
Message-Id: <20230323141253.d5a626f5cbe03adec3d88add@linux-foundation.org>
In-Reply-To: <20230323192111.1501308-1-urezki@gmail.com>
References: <20230323192111.1501308-1-urezki@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 20:21:11 +0100 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> A global vmap_blocks-xarray array can be contented under
> heavy usage of the vm_map_ram()/vm_unmap_ram() APIs. The
> lock_stat shows that a "vmap_blocks.xa_lock" lock is a
> second in a top-list when it comes to contentions:
> 
> ...
> 
> This patch does not fix vmap_area_lock/free_vmap_area_lock and
> purge_vmap_area_lock bottle-necks, it is rather a separate rework.
> 
> ...
>
>  static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
>  
> ...
>
> +static struct vmap_block_queue *
> +addr_to_vbq(unsigned long addr)
> +{
> +	int cpu = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> +	return &per_cpu(vmap_block_queue, cpu);
> +}

Seems strange.  vmap_block_queue is not a per-cpu thing in this usage. 
Instead it's a hash table, indexed off the (hashed) address, not off
smp_processor_id().

Yet in other places, vmap_block_queue *is* used in the conventional
cpu-local fashion.

So we can have CPU A using the cpu-local entry in vmap_block_queue
while CPU B is simultaneously using it, having looked it up via `addr'.

AFAICT this all works OK, no races.

But still, what it's doing is mixing an addr-indexed hashtable with the
CPU-indexed array in surprising ways.  It would be clearer to make the
vmap_blocks array a separate thing from the per-cpu array, although it
would presumably use a bit more memory.

Can we please at least get a big fat comment in an appropriate place
which explains all this to the reader?
