Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287B166BFBE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjAPN0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjAPNZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:25:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F1C1969A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:25:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AED53B80D31
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 13:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0746CC433D2;
        Mon, 16 Jan 2023 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673875532;
        bh=p01qBNFuoRosyJRMgusqGBN2al5abVi9iUdEfRMkO14=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=El6v5sqRwtmF5AicWZxXQXvxXFNVWhBLdadi3O+p9L9T3NzZJ9enyDpHtw5AncqfS
         s0sMG8tGLlHovcTti2XX6xbdaxFi8OtZx+UkCq/ru+MuWvw6DjzBdFLiRdvbS33JZA
         lAZYHQPR3RFsyXwHbFo9zfOwcsX+eDJ9CmtbOfwBY3iqDXfO6pvhwAVRStJTdS9BEH
         2rrobyJwrwMojSeVVyERZkHP5OP0Y6YB5nlH6woPMw1XvwERl9xvOQQMetq6o8tfhz
         7dQ3u4AUU/0EOw3ttjIHWP5eQamSp7agGKHh180Peh87hnkjmD7KbjzVa0Peug7n5M
         UOx4DKt46gQ3w==
Message-ID: <da57fbad-8242-eb1e-ab2b-322d61d0762d@kernel.org>
Date:   Mon, 16 Jan 2023 21:25:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
References: <20230116130210.34490-1-frank.li@vivo.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2 1/2] f2fs: fix to avoid potential memory corruption in
 __update_iostat_latency()
In-Reply-To: <20230116130210.34490-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/16 21:02, Yangtao Li wrote:
> Add iotype sanity check to avoid potential memory corruption.
> This is to fix the compile error below:
> 
> fs/f2fs/iostat.c:231 __update_iostat_latency() error: buffer overflow
> 'io_lat->peak_lat[type]' 3 <= 3
> 
> vim +228 fs/f2fs/iostat.c
> 
>    211  static inline void __update_iostat_latency(struct bio_iostat_ctx
> 	*iostat_ctx,
>    212					enum iostat_lat_type type)
>    213  {
>    214		unsigned long ts_diff;
>    215		unsigned int page_type = iostat_ctx->type;
>    216		struct f2fs_sb_info *sbi = iostat_ctx->sbi;
>    217		struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
>    218		unsigned long flags;
>    219
>    220		if (!sbi->iostat_enable)
>    221			return;
>    222
>    223		ts_diff = jiffies - iostat_ctx->submit_ts;
>    224		if (page_type >= META_FLUSH)
>                                   ^^^^^^^^^^
> 
>    225			page_type = META;
>    226
>    227		spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
>   @228		io_lat->sum_lat[type][page_type] += ts_diff;
>                                        ^^^^^^^^^
> Mixup between META_FLUSH and NR_PAGE_TYPE leads to memory corruption.
> 
> Fixes: a4b6817625e7 ("f2fs: introduce periodic iostat io latency traces")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/iostat.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
> index ed8176939aa5..e9a3df7ce4d9 100644
> --- a/fs/f2fs/iostat.c
> +++ b/fs/f2fs/iostat.c
> @@ -223,7 +223,7 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>   		return;
>   
>   	ts_diff = jiffies - iostat_ctx->submit_ts;
> -	if (iotype >= META_FLUSH)
> +	if (iotype == META_FLUSH)

Maybe it's betterr to merge these two check condition as below?

if (iotype >= NR_PAGE_TYPE) {
	f2fs_bug_on(sbi, iotype != META_FLUSH);
	iotype = META;
}

For CHECK_FS is off case, I guess it's fine to not return and just print
warning message for notice.

Thanks,

>   		iotype = META;
>   
>   	if (rw == 0) {
> @@ -235,6 +235,11 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>   			idx = WRITE_ASYNC_IO;
>   	}
>   
> +	if (iotype >= NR_PAGE_TYPE) {
> +		f2fs_bug_on(sbi, 1);
> +		return;
> +	}
> +
>   	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
>   	io_lat->sum_lat[idx][iotype] += ts_diff;
>   	io_lat->bio_cnt[idx][iotype]++;
