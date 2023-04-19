Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F986E82FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjDSVDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDSVD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:03:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C699B4C19
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5969362EDC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 21:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA28C433EF;
        Wed, 19 Apr 2023 21:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681938206;
        bh=ye0ftYUSPmnUq+n2iFW/CEVavhvXpFqajzaQuEBjlqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tqsNohtw9/z+j3788Kr2MJE9SdGFlE6exFfew93aKu06Sz5RzpPVaQKnR5k12eqMi
         AyBuf0RR64d1AG6Qh8+6re6inBP/J3Q/3Kw2R4MI+OADBuiPa18N1Vqj2lBxO2IQ2h
         qizdt4b2HqVXXIkXY6CSWYE/XANWFSRpSe0Jk93s=
Date:   Wed, 19 Apr 2023 14:03:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     zhangzhengming <zhang.zhengming@h3c.com>
Cc:     <surenb@google.com>, <wuchi.zero@gmail.com>,
        <Ilia.Gavrilov@infotecs.ru>, <xu.panda@zte.com.cn>,
        <colin.i.king@gmail.com>, <linux-kernel@vger.kernel.org>,
        <zhou.kete@h3c.com>, Pengcheng Yang <yangpc@wangsu.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] relayfs: fix out-of-bounds access in relay_file_read
Message-Id: <20230419140325.b85d54794baaa828a19c138f@linux-foundation.org>
In-Reply-To: <20230419040203.37676-1-zhang.zhengming@h3c.com>
References: <20230419040203.37676-1-zhang.zhengming@h3c.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 12:02:03 +0800 zhangzhengming <zhang.zhengming@h3c.com> wrote:

> From: Zhang Zhengming <zhang.zhengming@h3c.com>
> 
> There is a crash in relay_file_read, as the var from 
> point to the end of last subbuf.
> The oops looks something like:
> pc : __arch_copy_to_user+0x180/0x310
> lr : relay_file_read+0x20c/0x2c8
> Call trace:
>  __arch_copy_to_user+0x180/0x310
>  full_proxy_read+0x68/0x98
>  vfs_read+0xb0/0x1d0
>  ksys_read+0x6c/0xf0
>  __arm64_sys_read+0x20/0x28
>  el0_svc_common.constprop.3+0x84/0x108
>  do_el0_svc+0x74/0x90
>  el0_svc+0x1c/0x28
>  el0_sync_handler+0x88/0xb0
>  el0_sync+0x148/0x180
> 
> We get the condition by analyzing the vmcore:
> 1). The last produced byte and last consumed byte
>     both at the end of the last subbuf
> 2). A softirq who will call function(e.g __blk_add_trace)
>     to write relay buffer occurs when an program calling
>     function relay_file_read_avail.
>         relay_file_read
>                 relay_file_read_avail
>                         relay_file_read_consume(buf, 0, 0);
>                         //interrupted by softirq who will write subbuf
>                         ....
>                         return 1;
>                 //read_start point to the end of the last subbuf
>                 read_start = relay_file_read_start_pos
>                 //avail is equal to subsize
>                 avail = relay_file_read_subbuf_avail
>                 //from  points to an invalid memory address             
>                 from = buf->start + read_start
>                 //system is crashed
>                 copy_to_user(buffer, from, avail)

Thanks.  Hopefully Pengcheng Yang and Jens Axboe can comment.

> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -989,7 +989,8 @@ static size_t relay_file_read_start_pos(struct rchan_buf *buf)
>  	size_t subbuf_size = buf->chan->subbuf_size;
>  	size_t n_subbufs = buf->chan->n_subbufs;
>  	size_t consumed = buf->subbufs_consumed % n_subbufs;
> -	size_t read_pos = consumed * subbuf_size + buf->bytes_consumed;
> +	size_t read_pos = (consumed * subbuf_size + buf->bytes_consumed)
> +			% (n_subbufs * subbuf_size);
>  
>  	read_subbuf = read_pos / subbuf_size;
>  	padding = buf->padding[read_subbuf];

I'm thinking we should backport this into earlier kernels and that the
commit we're fixing is

Fixes: 341a7213e5c1 ("kernel/relay.c: fix read_pos error when multiple readers")
