Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A7970EDC7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbjEXGSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbjEXGSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:18:10 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1BE1BC
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:17:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VjMtVRI_1684909055;
Received: from 30.97.48.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjMtVRI_1684909055)
          by smtp.aliyun-inc.com;
          Wed, 24 May 2023 14:17:36 +0800
Message-ID: <058b354f-3543-bf60-4a1c-8e4bcefcd49a@linux.alibaba.com>
Date:   Wed, 24 May 2023 14:17:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: remove the member readahead from struct
 z_erofs_decompress_frontend
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
        jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
References: <20230524061152.30155-1-zbestahu@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230524061152.30155-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/24 23:11, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The struct member is only used to add REQ_RAHEAD during I/O submission.
> So it is cleaner to pass it as a parameter than keep it in the struct.
> 
> Also, rename function z_erofs_get_sync_decompress_policy() to
> z_erofs_is_sync_decompress() for better clarity and conciseness.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>   fs/erofs/zdata.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 45f21db2303a..4522a3be2ce9 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -550,7 +550,6 @@ struct z_erofs_decompress_frontend {
>   	z_erofs_next_pcluster_t owned_head;
>   	enum z_erofs_pclustermode mode;
>   
> -	bool readahead;
>   	/* used for applying cache strategy on the fly */
>   	bool backmost;
>   	erofs_off_t headoffset;
> @@ -1106,7 +1105,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>   	return err;
>   }
>   
> -static bool z_erofs_get_sync_decompress_policy(struct erofs_sb_info *sbi,
> +static bool z_erofs_is_sync_decompress(struct erofs_sb_info *sbi,
>   				       unsigned int readahead_pages)
>   {
>   	/* auto: enable for read_folio, disable for readahead */
> @@ -1672,7 +1671,7 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
>   static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>   				 struct page **pagepool,
>   				 struct z_erofs_decompressqueue *fgq,
> -				 bool *force_fg)
> +				 bool *force_fg, bool readahead)
>   {
>   	struct super_block *sb = f->inode->i_sb;
>   	struct address_space *mc = MNGD_MAPPING(EROFS_SB(sb));
> @@ -1763,7 +1762,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>   				bio->bi_iter.bi_sector = (sector_t)cur <<
>   					(sb->s_blocksize_bits - 9);
>   				bio->bi_private = q[JQ_SUBMIT];
> -				if (f->readahead)
> +				if (readahead)
>   					bio->bi_opf |= REQ_RAHEAD;
>   				++nr_bios;
>   			}
> @@ -1799,13 +1798,14 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>   }
>   
>   static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
> -			     struct page **pagepool, bool force_fg)
> +			     struct page **pagepool, bool force_fg,
> +			     bool readahead)

			     struct page **pagepool, bool force_fg, bool ra)


>   {
>   	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
>   
>   	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
>   		return;
> -	z_erofs_submit_queue(f, pagepool, io, &force_fg);
> +	z_erofs_submit_queue(f, pagepool, io, &force_fg, readahead);

	z_erofs_submit_queue(f, pagepool, io, &force_fg, ra);


Otherwise it seems ok to me,

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
