Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159446C9BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjC0HPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjC0HPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:15:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699FF44BF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:15:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id br6so9960615lfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679901344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y4AJDK3Z5KJjc6XjtS850Wy68GXbyqouQwIvnNso9Ao=;
        b=pZMO2NpiXcDQN+R2yYMSAkikKbHBVhzkh0pDfj0ibCJTOfwD/oj8l/Wx4M8XDI7k21
         vxjcXU+nmcajxK2fZOX2pAEg8woJ7X6sazDGdvr5UHAafc/JA5m8NUrX/fnZZUxjyI43
         BruB2YshdTHNylx8cBn8uuA37HsLuO5WJR4KaZS4UaRfZCRbSjareZw4wqEwVWMsB9iV
         /cla9CoBM1VOHNugVyRqx/v2g+er7y8pmvOlQ7swB4OQQzRQBsz25WJeiF0nvskt7w2q
         SVjQKx3kqux8CWrn9BIZxXyzzLgZb7HyX6DNRUKHBTQ7wyoE+Bw8moOLmUzBKPT1egWb
         Br/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679901344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4AJDK3Z5KJjc6XjtS850Wy68GXbyqouQwIvnNso9Ao=;
        b=V9WtKsjZgU6yhDwj7Kaa7ixUlFuag8XTUt+D3KcGomnTgwR6Gx54H8DlQAfiNu2s/s
         pjeLK3xVPtfFnZX8MdekhPj1TZ3AUK8selMsKgZOZCrGJV8NOybs6pZkeHsP2vhx4GU5
         iK2T+b6HZMntabIL8VQCDNHIc88ZeMvqTUHHfgZe4AvjVka+CA5neXbDEi5ighzrYgUb
         WvWk9xWmmIVNaeoaNp1veoVqck0YtChf53F/jSQCUmo+eZVAZ94aVl6f/yiRYK/x61AS
         vAKXyBZnl23WBiH9+vELJrlBrRK6XQYPr3gmslDwBcyufoJYz7gFLIJ0YcoZmvLJ1jJL
         QW7w==
X-Gm-Message-State: AAQBX9d+fETe7klChIhBF2Gxb9hs/cX/dfcHy8pjjbHuZkX2Xb4IsWMc
        GX1nfytfGikhY7nreD3Vb6s=
X-Google-Smtp-Source: AKy350bsiS7UIvc6+dNNGbVLnD+KDO94bUHAF+znwuNGV5WANy2AALBtlr2nC/Aj5z/MN0h9/ogo/A==
X-Received: by 2002:ac2:4a6d:0:b0:4ea:e296:fe9e with SMTP id q13-20020ac24a6d000000b004eae296fe9emr3025444lfp.9.1679901343586;
        Mon, 27 Mar 2023 00:15:43 -0700 (PDT)
Received: from pc636 (host-90-233-209-50.mobileonline.telia.com. [90.233.209.50])
        by smtp.gmail.com with ESMTPSA id r8-20020a19ac48000000b004e8b90e14a8sm4571052lfc.25.2023.03.27.00.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 00:15:43 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 27 Mar 2023 09:15:40 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Remove a global vmap_blocks xarray
Message-ID: <ZCFCnJXWx3cAM4zv@pc636>
References: <20230323192111.1501308-1-urezki@gmail.com>
 <20230323141253.d5a626f5cbe03adec3d88add@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323141253.d5a626f5cbe03adec3d88add@linux-foundation.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 02:12:53PM -0700, Andrew Morton wrote:
> On Thu, 23 Mar 2023 20:21:11 +0100 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
> > A global vmap_blocks-xarray array can be contented under
> > heavy usage of the vm_map_ram()/vm_unmap_ram() APIs. The
> > lock_stat shows that a "vmap_blocks.xa_lock" lock is a
> > second in a top-list when it comes to contentions:
> > 
> > ...
> > 
> > This patch does not fix vmap_area_lock/free_vmap_area_lock and
> > purge_vmap_area_lock bottle-necks, it is rather a separate rework.
> > 
> > ...
> >
> >  static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> >  
> > ...
> >
> > +static struct vmap_block_queue *
> > +addr_to_vbq(unsigned long addr)
> > +{
> > +	int cpu = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > +	return &per_cpu(vmap_block_queue, cpu);
> > +}
> 
> Seems strange.  vmap_block_queue is not a per-cpu thing in this usage. 
> Instead it's a hash table, indexed off the (hashed) address, not off
> smp_processor_id().
> 
> Yet in other places, vmap_block_queue *is* used in the conventional
> cpu-local fashion.
> 
> So we can have CPU A using the cpu-local entry in vmap_block_queue
> while CPU B is simultaneously using it, having looked it up via `addr'.
> 
> AFAICT this all works OK, no races.
> 
> But still, what it's doing is mixing an addr-indexed hashtable with the
> CPU-indexed array in surprising ways.  It would be clearer to make the
> vmap_blocks array a separate thing from the per-cpu array, although it
> would presumably use a bit more memory.
> 
> Can we please at least get a big fat comment in an appropriate place
> which explains all this to the reader?
>
Yep, i will send out a v2 with all explanation. Indeed i have to add
detailed explanation.

Thanks!

--
Uladzislau Rezki
