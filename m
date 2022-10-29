Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17622611FD2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 05:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJ2Dia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 23:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ2Di1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 23:38:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5F51C7D6B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 20:38:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 137ADB82E0C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 03:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F289C433C1;
        Sat, 29 Oct 2022 03:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667014702;
        bh=GDYgRLpPM2uZtvu6eyY88zG1Hs6CG0ltXrGiCBBjrb8=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=oeTSfSxUNfBG+B/2hQF/jWGp3yDmPDinrgnSMFVEn2PjpxGHXZtl2Su8bozODgFfx
         CNLixUiS3jfrzF2sFoYKMk1zz6XlxTC3B0bN7Y92LTfdFaGQXdtydRzhwvcNkWOhXC
         sfqWRB8Xn9lBvLMAzoRFVLNVhCJnzRRPJjGLZ9s6JYQVWi+ZgxprzzNPRU/bc2X9Zp
         nI1fRuDKwnMZ1NMBOhrYBNgcNJL3I1IKyC1MHsc+A8odwcGON9uQX05gJ5xSBlohDK
         tn0h65rYiJ6xN6OH+7PKngW64eMuwHOrBqUq82Dp+4zWGq3ea+TPisFj/F+zQ/Kzj3
         1X6AQTiuwk3Eg==
Message-ID: <0bfe4dab-6316-401c-3b6f-49df0ca0a271@kernel.org>
Date:   Sat, 29 Oct 2022 11:38:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20221025132638.38260-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add proc entry to show discard_plist
 info
In-Reply-To: <20221025132638.38260-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/25 21:26, Yangtao Li via Linux-f2fs-devel wrote:
> This patch adds a new proc entry to show discard_plist
> information in more detail, which is very helpful to
> know the discard pend list count clearly.
> 
> Such as:
> 
> Discard pend list(Show diacrd_cmd count on each entry, .:not exist):

Discard pending list

>    0       390     156      85      67      46      37      26      14
>    8        17      12       9       9       6      12      11      10
>    16        5       9       2       4       8       3       4       1
>    24        3       2       2       5       2       4       5       4
>    32        3       3       2       3       .       3       3       1
>    40        .       4       1       3       2       1       2       1
>    48        1       .       1       1       .       1       1       .
>    56        .       1       1       1       .       2       .       1
>    64        1       2       .       .       .       .       .       .
>    72        .       1       .       .       .       .       .       .
>    80        3       1       .       .       1       1       .       .
>    88        1       .       .       .       1       .       .       1
> ......
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -move to procfs entry
>   fs/f2fs/sysfs.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index df27afd71ef4..0fc17375e042 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1243,6 +1243,44 @@ static int __maybe_unused victim_bits_seq_show(struct seq_file *seq,
>   	return 0;
>   }
>   
> +static int __maybe_unused discard_plist_seq_show(struct seq_file *seq,
> +						void *offset)
> +{
> +	struct super_block *sb = seq->private;
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	int i, count;
> +
> +	seq_puts(seq, "Discard pend list(Show diacrd_cmd count on each entry, .:not exist):\n");
> +	if (!f2fs_realtime_discard_enable(sbi))
> +		return 0;
> +
> +	if (dcc) {

IIUC, dcc should always be valid.

> +		mutex_lock(&dcc->cmd_lock);
> +		for (i = 0; i < MAX_PLIST_NUM; i++) {
> +			struct list_head *pend_list;
> +			struct discard_cmd *dc, *tmp;

unsigned int count = 0;

> +
> +			if (i % 8 == 0)
> +				seq_printf(seq, "  %-3d", i);

seq_printf(seq, "%-10d", i);

> +			count = 0;
> +			pend_list = &dcc->pend_list[i];
> +			list_for_each_entry_safe(dc, tmp, pend_list, list)
> +				count++;
> +			if (count)
> +				seq_printf(seq, " %7d", count);

On 16TB size device, there will be about 2 billion discard entry at
maximum, so %10d will be more safe?

How about introducing an array to record discard numbers, if there is
millions of discard, lookuping this proc entry may hang f2fs due to
holding cmd_lock for long time.

> +			else
> +				seq_puts(seq, "       .");

It's fine to show '0' here.

> +			if (i % 8 == 7)
> +				seq_putc(seq, '\n');

else
	seq_putc(seq, ' ');

> +		}
> +		seq_putc(seq, '\n');
> +		mutex_unlock(&dcc->cmd_lock);
> +	}
> +
> +	return 0;
> +}
> +
>   int __init f2fs_init_sysfs(void)
>   {
>   	int ret;
> @@ -1313,6 +1351,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
>   #endif
>   		proc_create_single_data("victim_bits", 0444, sbi->s_proc,
>   				victim_bits_seq_show, sb);
> +		proc_create_single_data("discard_plist_info", 0444, sbi->s_proc,

Well, discard_plist?

Thanks,

> +				discard_plist_seq_show, sb);
>   	}
>   	return 0;
>   put_feature_list_kobj:
> @@ -1336,6 +1376,7 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
>   		remove_proc_entry("segment_info", sbi->s_proc);
>   		remove_proc_entry("segment_bits", sbi->s_proc);
>   		remove_proc_entry("victim_bits", sbi->s_proc);
> +		remove_proc_entry("discard_plist_info", sbi->s_proc);
>   		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
>   	}
>   
