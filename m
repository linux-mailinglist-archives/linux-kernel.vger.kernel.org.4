Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809AB665C84
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbjAKN3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbjAKN3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:29:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A1B62E2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:25:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A612B81BE6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9192BC433EF;
        Wed, 11 Jan 2023 13:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673443555;
        bh=M20/WHbbHylbZdX8Uu54Y8EoLEkklBuaRyDGzuWSCeU=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=C/ZQrkW+J8kGwmGWfLtDA3bHIdDLV93wXJfBHcYAzlr9mEn7ExI+UZDnMExUuDAfy
         RE83+xaAEvcywLWDF2AABnrZ0XTuiluYrXuwV+QPE1hOrsryTGBGji1SVKSyTLesJe
         rNtLxSI9VYgFEESnpT/krOwIydmljrcThTfb5tFcMjEdRHAPGeONOGozElRmgIlSrz
         Zt2LJmzFxqawEZXauZ4khaVnxnjKjx1nNdxV7WUlUgIC69Q1v18gBEkbKioV6f9lcn
         CzQeBG3ZhGepP/EUavmaO3Qq0/Joy9r/O4IOanARr6p9Q/wA6NoudxBKby2Y41/MGI
         pUMgPREBhQOTQ==
Message-ID: <59f19f5f-dcde-6042-cbc1-eee4b3d2469b@kernel.org>
Date:   Wed, 11 Jan 2023 21:25:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221222081855.81553-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: drop useless initializer and unneeded local
 variable
In-Reply-To: <20221222081855.81553-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/22 16:18, Yangtao Li wrote:
> No need to initialize idx twice. BTW, remove the unnecessary cnt variable.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/iostat.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
> index 3166a8939ed4..335b055ffe7d 100644
> --- a/fs/f2fs/iostat.c
> +++ b/fs/f2fs/iostat.c
> @@ -97,8 +97,7 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
>   
>   static inline void __record_iostat_latency(struct f2fs_sb_info *sbi)
>   {
> -	int io, idx = 0;
> -	unsigned int cnt;
> +	int io, idx;
>   	struct f2fs_iostat_latency iostat_lat[MAX_IO_TYPE][NR_PAGE_TYPE];
>   	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
>   	unsigned long flags;
> @@ -106,12 +105,11 @@ static inline void __record_iostat_latency(struct f2fs_sb_info *sbi)
>   	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
>   	for (idx = 0; idx < MAX_IO_TYPE; idx++) {
>   		for (io = 0; io < NR_PAGE_TYPE; io++) {
> -			cnt = io_lat->bio_cnt[idx][io];
>   			iostat_lat[idx][io].peak_lat =
>   			   jiffies_to_msecs(io_lat->peak_lat[idx][io]);
> -			iostat_lat[idx][io].cnt = cnt;
> -			iostat_lat[idx][io].avg_lat = cnt ?
> -			   jiffies_to_msecs(io_lat->sum_lat[idx][io]) / cnt : 0;
> +			iostat_lat[idx][io].cnt = io_lat->bio_cnt[idx][io];
> +			iostat_lat[idx][io].avg_lat = iostat_lat[idx][io].cnt ?
> +			   jiffies_to_msecs(io_lat->sum_lat[idx][io]) / iostat_lat[idx][io].cnt : 0;

exceed 80 column?

Thanks,

>   			io_lat->sum_lat[idx][io] = 0;
>   			io_lat->peak_lat[idx][io] = 0;
>   			io_lat->bio_cnt[idx][io] = 0;
