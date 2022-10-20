Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0276064E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJTPqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJTPqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:46:09 -0400
Received: from p3plwbeout17-03.prod.phx3.secureserver.net (p3plsmtp17-03-2.prod.phx3.secureserver.net [173.201.193.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E5A16656A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:46:01 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.141])
        by :WBEOUT: with ESMTP
        id lXk7oDi1aFo2plXk8oK9Ih; Thu, 20 Oct 2022 08:46:00 -0700
X-CMAE-Analysis: v=2.4 cv=McWpB7zf c=1 sm=1 tr=0 ts=63516d38
 a=bheWAUFm1xGnSTQFbH9Kqg==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10
 a=u-kXCg0vROs3Ngr0XrIA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  lXk7oDi1aFo2p
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp10.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1olXk6-0001Nj-O3; Thu, 20 Oct 2022 16:45:59 +0100
Message-ID: <41ef4b22-eea8-2d67-99d8-6aaae7d25ac1@squashfs.org.uk>
Date:   Thu, 20 Oct 2022 16:45:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Jintao Yin <nicememory@gmail.com>
Cc:     bagasdotme@gmail.com, hsinyi@chromium.org,
        linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        mirsad.todorovac@alu.unizg.hr, regressions@leemhuis.info,
        regressions@lists.linux.dev, srw@sladewatkins.net
References: <20221018174157.1897-1-phillip@squashfs.org.uk>
 <20221020135545.586-1-nicememory@gmail.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20221020135545.586-1-nicememory@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfJmGz2vb9VQKEbWdHk0Xfv+6HLG3HNm198SEoqKwyw2cig5kvYPxRlLfjq7FNt96O9Aqxefhs42OHuesymJYt8De1waJz8WuhWSzLZ6JZolwEHNOTfSt
 0ID3Ppyj96YCA5VMNvlB47vi7JgoCYnaHaz3CixuRVtHNLdS9O0GcjbeKKe6kSzj5Nxlau9/DIiVlFnapAoLtrI+QEPHs1Bzngo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 14:55, Jintao Yin wrote:
> Hi all,
> 
> After review the details of page actor, the tail bytes may be written to
> a temp buffer instead the last used page. So before diff would wrongly
> memzero a page which is not the tail bytes in.
> 
> In this diff fixes it by caculation of the real index the trailing bytes
> in and check if the last used page matches this index. If the page is
> the real tail bytes in, then memzero the trailing bypte of the page.
> 
> Please help test and any feedbacks are welcome.
> 
> Thanks,

This is a rediculously complex patch.  Sorry, but, absolute NACK.

Additionally, it is poor etiquette and pointless to fix an
already fixed issue with a _more_ complex patch.

Phillip

> 
> Jintao
> 
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index e56510964b22..e1fafd10a850 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -506,8 +506,9 @@ static int squashfs_readahead_fragment(struct page **page,
>   		squashfs_i(inode)->fragment_size);
>   	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>   	unsigned int n, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
> +	int res = buffer->error;
>   
> -	if (buffer->error)
> +	if (res)
>   		goto out;
>   
>   	expected += squashfs_i(inode)->fragment_offset;
> @@ -529,7 +530,7 @@ static int squashfs_readahead_fragment(struct page **page,
>   
>   out:
>   	squashfs_cache_put(buffer);
> -	return buffer->error;
> +	return res;
>   }
>   
>   static void squashfs_readahead(struct readahead_control *ractl)
> @@ -557,6 +558,7 @@ static void squashfs_readahead(struct readahead_control *ractl)
>   		int res, bsize;
>   		u64 block = 0;
>   		unsigned int expected;
> +		int nr_used_pages;
>   
>   		nr_pages = __readahead_batch(ractl, pages, max_pages);
>   		if (!nr_pages)
> @@ -593,18 +595,21 @@ static void squashfs_readahead(struct readahead_control *ractl)
>   
>   		res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
>   
> -		squashfs_page_actor_free(actor);
> +		nr_used_pages = squashfs_page_actor_free(actor);
>   
>   		if (res == expected) {
>   			int bytes;
> +			pgoff_t bytes_index;
>   
>   			/* Last page (if present) may have trailing bytes not filled */
>   			bytes = res % PAGE_SIZE;
> -			if (pages[nr_pages - 1]->index == file_end && bytes)
> -				memzero_page(pages[nr_pages - 1], bytes,
> +			bytes_index = (index << shift) + ((res - bytes) >> PAGE_SHIFT);
> +			if (bytes && nr_used_pages > 0 &&
> +				pages[nr_used_pages - 1]->index == bytes_index)
> +				memzero_page(pages[nr_used_pages - 1], bytes,
>   					     PAGE_SIZE - bytes);
>   
> -			for (i = 0; i < nr_pages; i++) {
> +			for (i = 0; i < nr_used_pages; i++) {
>   				flush_dcache_page(pages[i]);
>   				SetPageUptodate(pages[i]);
>   			}
> diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
> index f1ccad519e28..ee462ef380bf 100644
> --- a/fs/squashfs/file_direct.c
> +++ b/fs/squashfs/file_direct.c
> @@ -26,14 +26,14 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>   	struct inode *inode = target_page->mapping->host;
>   	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>   
> -	int file_end = (i_size_read(inode) - 1) >> PAGE_SHIFT;
> -	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
> -	int start_index = target_page->index & ~mask;
> -	int end_index = start_index | mask;
> -	int i, n, pages, bytes, res = -ENOMEM;
> +	pgoff_t file_end = (i_size_read(inode) - 1) >> PAGE_SHIFT;
> +	pgoff_t mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
> +	pgoff_t start_index = target_page->index & ~mask;
> +	pgoff_t end_index = start_index | mask;
> +	int i, pages, used_pages, bytes, res = -ENOMEM;
> +	pgoff_t n, bytes_index;
>   	struct page **page;
>   	struct squashfs_page_actor *actor;
> -	void *pageaddr;
>   
>   	if (end_index > file_end)
>   		end_index = file_end;
> @@ -74,7 +74,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>   	/* Decompress directly into the page cache buffers */
>   	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
>   
> -	squashfs_page_actor_free(actor);
> +	used_pages = squashfs_page_actor_free(actor);
>   
>   	if (res < 0)
>   		goto mark_errored;
> @@ -86,16 +86,19 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>   
>   	/* Last page (if present) may have trailing bytes not filled */
>   	bytes = res % PAGE_SIZE;
> -	if (page[pages - 1]->index == end_index && bytes) {
> -		pageaddr = kmap_local_page(page[pages - 1]);
> -		memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
> -		kunmap_local(pageaddr);
> +	bytes_index = start_index + ((res - bytes) >> PAGE_SHIFT);
> +	if (used_pages > 0 && bytes &&
> +		page[used_pages - 1]->index == bytes_index) {
> +		memzero_page(page[used_pages - 1], bytes,
> +			     PAGE_SIZE - bytes);
>   	}
>   
>   	/* Mark pages as uptodate, unlock and release */
>   	for (i = 0; i < pages; i++) {
> -		flush_dcache_page(page[i]);
> -		SetPageUptodate(page[i]);
> +		if (i < used_pages) {
> +			flush_dcache_page(page[i]);
> +			SetPageUptodate(page[i]);
> +		}
>   		unlock_page(page[i]);
>   		if (page[i] != target_page)
>   			put_page(page[i]);
> @@ -112,8 +115,10 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
>   	for (i = 0; i < pages; i++) {
>   		if (page[i] == NULL || page[i] == target_page)
>   			continue;
> -		flush_dcache_page(page[i]);
> -		SetPageError(page[i]);
> +		if (i < used_pages) {
> +			flush_dcache_page(page[i]);
> +			SetPageError(page[i]);
> +		}
>   		unlock_page(page[i]);
>   		put_page(page[i]);
>   	}
> diff --git a/fs/squashfs/page_actor.h b/fs/squashfs/page_actor.h
> index 95ffbb543d91..c2c5c3937ef9 100644
> --- a/fs/squashfs/page_actor.h
> +++ b/fs/squashfs/page_actor.h
> @@ -29,10 +29,12 @@ extern struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
>   extern struct squashfs_page_actor *squashfs_page_actor_init_special(
>   				struct squashfs_sb_info *msblk,
>   				struct page **page, int pages, int length);
> -static inline void squashfs_page_actor_free(struct squashfs_page_actor *actor)
> +static inline int squashfs_page_actor_free(struct squashfs_page_actor *actor)
>   {
> +	int res = actor->next_page;
>   	kfree(actor->tmp_buffer);
>   	kfree(actor);
> +	return res;
>   }
>   static inline void *squashfs_first_page(struct squashfs_page_actor *actor)
>   {

