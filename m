Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618556C9498
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 15:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjCZNrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 09:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCZNrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 09:47:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9AE7689
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 06:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32944B80C9D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A364C433EF;
        Sun, 26 Mar 2023 13:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679838465;
        bh=Mbrp8vJfL4WUN8W5w3k6PtvrtBZ8ae9TAdSfQJPoQCY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EAGLHJEtYiiFDBODRxZ07bdcD8p12oHlpjlz1gRiKEjUcfWZ4nZB46uNRljMhFgzZ
         2Nf3yPjKaCdb63id3RP/xZHDPqNMYek2OzTLiCUoahWRePe/VbKV7uQBaXg+Xu739c
         Z4ZpQmyIj1Er6Tlj0YjZwZrAyrX/HfKaAWcY/15FQJIcEnM5RImqwtolWvYllV0hen
         2xAlG4NdeYyA/2//HJgRlZTyX9cEnLbhNVeTtaPhH2dJNQmNZnS7OBK8Euee5E3Eyd
         njVsOeAgwQsgoI8wSlYbNApE8iNISj1floUNOreIyYgJUU0AfznZRLFaeYtxH4h8iq
         lUmPr5VXbbioA==
Message-ID: <67aaa031-ab25-ffe4-ea56-3f3e4c0ac3d1@kernel.org>
Date:   Sun, 26 Mar 2023 21:47:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] f2fs: compress: fix to call
 f2fs_wait_on_page_writeback() in f2fs_write_raw_pages()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, hanqi@vivo.com,
        Christoph Hellwig <hch@lst.de>
References: <20230320172218.59628-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230320172218.59628-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/21 1:22, Yangtao Li wrote:
> BUG_ON() will be triggered when writing files concurrently,
> because the same page is writtenback multiple times.
> 
> 1597 void folio_end_writeback(struct folio *folio)
> 1598 {
> 		......
> 1618     if (!__folio_end_writeback(folio))
> 1619         BUG();
> 		......
> 1625 }
> 
> kernel BUG at mm/filemap.c:1619!
> Call Trace:
>   <TASK>
>   f2fs_write_end_io+0x1a0/0x370
>   blk_update_request+0x6c/0x410
>   blk_mq_end_request+0x15/0x130
>   blk_complete_reqs+0x3c/0x50
>   __do_softirq+0xb8/0x29b
>   ? sort_range+0x20/0x20
>   run_ksoftirqd+0x19/0x20
>   smpboot_thread_fn+0x10b/0x1d0
>   kthread+0xde/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x22/0x30
>   </TASK>
> 
> Below is the concurrency scenario:
> 
> [Process A]		[Process B]		[Process C]
> f2fs_write_raw_pages()
>    - redirty_page_for_writepage()
>    - unlock page()
> 			f2fs_do_write_data_page()
> 			  - lock_page()
> 			  - clear_page_dirty_for_io()
> 			  - set_page_writeback() [1st writeback]
> 			    .....
> 			    - unlock page()
> 
> 						generic_perform_write()
> 						  - f2fs_write_begin()
> 						    - wait_for_stable_page()
> 
> 						  - f2fs_write_end()
> 						    - set_page_dirty()
> 
>    - lock_page()
>      - f2fs_do_write_data_page()
>        - set_page_writeback() [2st writeback]
> 
> This problem was introduced by the previous commit 7377e853967b ("f2fs:
> compress: fix potential deadlock of compress file"). All pagelocks were
> released in f2fs_write_raw_pages(), but whether the page was
> in the writeback state was ignored in the subsequent writing process.
> Let's fix it by waiting for the page to writeback before writing.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Fixes: 7377e853967b ("f2fs: compress: fix potential deadlock of compress file")
> Signed-off-by: Qi Han <hanqi@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
