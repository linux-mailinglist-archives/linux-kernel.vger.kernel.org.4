Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D9A682174
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjAaBk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjAaBkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:40:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D080E399
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:40:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34DBDB818C2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF44C433EF;
        Tue, 31 Jan 2023 01:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675129220;
        bh=/f9nOeXPzfyTQPKpu9wkj93f1Odhx3N6/5QwwcBRKrU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MSnh4JdLbyJcE9M3yKPSUEd3/Vk0bbmsvE3hdtk/tUVHyzRNCQ89MrxXPafVP/370
         Slhj5ZCB/ii29SgjmcFwtXVhpuaFWxe2fuqiCglTWaVfKZ0UERKoLbnBRn4TRWW3Ih
         miHvEgNh1sTJ0uRznNq7NEz0cOJrJ/ips5rk9e+21TfK/oiB8EYbR8ZlBWRRGcXEAa
         RcApt/6esuFgS5QL1mac8IdVHlT2kO4YSh5h31CfeKedIkg+lYyrLJCb/xEiRaYzIU
         Mudqkf6s12j4AnIu83AFJYmM3pTaONj8qAVNNUT3rE6/zh24EprakzHUm6ss58nRg8
         DOR/O02QgdtUg==
Message-ID: <4e0f4781-06ce-49e2-0bd5-031057e88888@kernel.org>
Date:   Tue, 31 Jan 2023 09:40:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] f2fs: fix to avoid potential memory corruption in
 __update_iostat_latency()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
References: <20230120161656.70308-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230120161656.70308-1-frank.li@vivo.com>
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

On 2023/1/21 0:16, Yangtao Li wrote:
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
> Suggested-by: Chao Yu <chao@kernel.org>
> Suggested-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
