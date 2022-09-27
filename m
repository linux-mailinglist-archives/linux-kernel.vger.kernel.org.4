Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203845EB977
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiI0FOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiI0FOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:14:21 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CC488DF2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 22:14:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQqJQ6N_1664255655;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VQqJQ6N_1664255655)
          by smtp.aliyun-inc.com;
          Tue, 27 Sep 2022 13:14:17 +0800
Date:   Tue, 27 Sep 2022 13:14:14 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, zhangwen@coolpad.com,
        Yue Hu <huyue2@coolpad.com>
Subject: Re: [PATCH] erofs: fold in z_erofs_reload_indexes()
Message-ID: <YzKGpUJsVh/T1nVO@B-P7TQMD6M-0146.local>
References: <20220927032518.25266-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220927032518.25266-1-zbestahu@gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 11:25:18AM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The name of this function looks not very accurate compared to it's
> implementation and it's only a wrapper to erofs_read_metabuf(). So,
> let's fold it directly instead.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/zmap.c | 28 ++++++++--------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index ccdddb755be8..4cecd32b87c6 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -166,18 +166,6 @@ struct z_erofs_maprecorder {
>  	bool partialref;
>  };
>  
> -static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
> -				  erofs_blk_t eblk)
> -{
> -	struct super_block *const sb = m->inode->i_sb;
> -
> -	m->kaddr = erofs_read_metabuf(&m->map->buf, sb, eblk,
> -				      EROFS_KMAP_ATOMIC);
> -	if (IS_ERR(m->kaddr))
> -		return PTR_ERR(m->kaddr);
> -	return 0;
> -}
> -
>  static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  					 unsigned long lcn)
>  {
> @@ -190,11 +178,11 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  		lcn * sizeof(struct z_erofs_vle_decompressed_index);
>  	struct z_erofs_vle_decompressed_index *di;
>  	unsigned int advise, type;
> -	int err;
>  
> -	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
> -	if (err)
> -		return err;
> +	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
> +				      erofs_blknr(pos), EROFS_KMAP_ATOMIC);
> +	if (IS_ERR(m->kaddr))
> +		return PTR_ERR(m->kaddr);
>  
>  	m->nextpackoff = pos + sizeof(struct z_erofs_vle_decompressed_index);
>  	m->lcn = lcn;
> @@ -393,7 +381,6 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  	unsigned int compacted_4b_initial, compacted_2b;
>  	unsigned int amortizedshift;
>  	erofs_off_t pos;
> -	int err;
>  
>  	if (lclusterbits != 12)
>  		return -EOPNOTSUPP;
> @@ -430,9 +417,10 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  	amortizedshift = 2;
>  out:
>  	pos += lcn * (1 << amortizedshift);
> -	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
> -	if (err)
> -		return err;
> +	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
> +				      erofs_blknr(pos), EROFS_KMAP_ATOMIC);
> +	if (IS_ERR(m->kaddr))
> +		return PTR_ERR(m->kaddr);
>  	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
>  }
>  
> -- 
> 2.17.1
