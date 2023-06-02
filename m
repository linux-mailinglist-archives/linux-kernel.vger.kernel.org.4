Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3C271FCBB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbjFBIxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjFBIw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:52:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381061B6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C98A2616C7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A63C4339B;
        Fri,  2 Jun 2023 08:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685695934;
        bh=UUGsYsnqEu8jbU1zwSqU8HEf+QxK5Ufh42Kq2cX812M=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=KHqzk+sGr6rUNDHQKL0DvRCMons0WUTQ4bg2zqUGrUTJWyrkb+ExeDnEamMtinDgk
         KMrmZDDa48EpyFwsDhgH6qRPu9OMhzyZAdqyTggANdLHSGVm838PMB2/heDuYc3ZiE
         Xg5ES/bRhMVgdTlHIwRc+2oKlOTuMwGIJlunlIiYhPxKH1ddOxQqkdlyFBsiotfCij
         YDiMCL0qE7eaJmdAQUt73fvWmsYTDPDtqft0MrH44AhMBTzIRcIP0C2F4FGR/XBwLv
         dIl1GW6PStqSIsCaOH5QafPgNTovlREC5wwfGmkEFa6FCD0PSTxAHGmG5QeM61g8Kd
         NqkyTTKqaVLTw==
Message-ID: <f301845f-c358-4632-1df5-5944d7483072@kernel.org>
Date:   Fri, 2 Jun 2023 16:52:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] f2fs: including waf data in f2fs status information
Content-Language: en-US
To:     beomsu7.kim@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yonggil Song <yonggil.song@samsung.com>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Seonghun Kim <seonghun-sui.kim@samsung.com>
References: <CGME20230602044830epcms2p141ec782e866c2adc5a3142516f051b87@epcms2p1>
 <20230602044830epcms2p141ec782e866c2adc5a3142516f051b87@epcms2p1>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230602044830epcms2p141ec782e866c2adc5a3142516f051b87@epcms2p1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/2 12:48, beomsu kim wrote:
> When evaluating in f2fs, it takes much time to obtain waf data.
> This patch helps to obtain waf data without calcluation.
> 
> Signed-off-by: Beomsu Kim <beomsu7.kim@samsung.com>
> ---
>   fs/f2fs/iostat.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
> index 3d5bfb1ad585..6eab11b0610d 100644
> --- a/fs/f2fs/iostat.c
> +++ b/fs/f2fs/iostat.c
> @@ -34,10 +34,22 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
>   {
>          struct super_block *sb = seq->private;
>          struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +       int j;
> +       unsigned long long waf = 0;
> +       unsigned long long data_written_to_storage = 0;
> +       unsigned long long data_written_by_user = 0;
>   
>          if (!sbi->iostat_enable)
>                  return 0;
>   
> +       for (j = FS_DATA_IO; j <= FS_CP_META_IO; j++)

FS_CDATA_IO is redundant?

> +               data_written_to_storage += sbi->iostat_bytes[j];
> +       for (j = FS_DATA_IO; j <= FS_CDATA_IO; j++)

Just needs to include APP_WRITE_IO and APP_MAPPED_IO?

Thanks,

> +               data_written_by_user += sbi->iostat_bytes[j];
> +
> +       if (data_written_by_user > 0)
> +               waf = data_written_to_storage * 100 / data_written_by_user;
> +
>          seq_printf(seq, "time:          %-16llu\n", ktime_get_real_seconds());
>          seq_printf(seq, "\t\t\t%-16s %-16s %-16s\n",
>                                  "io_bytes", "count", "avg_bytes");
> @@ -81,6 +93,10 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
>          IOSTAT_INFO_SHOW("fs discard", FS_DISCARD_IO);
>          IOSTAT_INFO_SHOW("fs flush", FS_FLUSH_IO);
>   
> +       /* print waf */
> +       seq_puts(seq, "[WAF]\n");
> +       seq_printf(seq, "fs waf:                %llu.%02llu\n", waf / 100, waf % 100);
> +
>          return 0;
>   }
>   
