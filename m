Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CCD6491DF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiLKC12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLKC1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:27:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7383ADEDB
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 18:27:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 175CDB80966
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 02:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9B4C433EF;
        Sun, 11 Dec 2022 02:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670725641;
        bh=Kz4hLtbGrjd7gtG9dlPx4Fp0vpjG79m3yjTtXj56pBw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gr8MD30huWtiIQpUoOpTNyOlPWzTeYL9uu7K8Exaavzkq84e/0ZVuTnbP5KcUdqPZ
         yXnRLpv3Z0kYruFOrC5gk6Ig29x9s9kvyyo6QsbqKoAGkqQOlCugCHgTJltFTggXyZ
         PDvuBzBQ/ZTUgxYG5FwVMzojwxnT58YJl3rebEikFROFRKgpwoLoUYrJrAAni8qurb
         F3FgVGkYr9TSqaCzYbTpMUqsETGAdqoZ6YgsVQEakaVVw0yiAyF7FFTcaxsOWMQs6n
         Z5wXSVfjQ2p2gYHSMuLjf3Xq9VkCLXtkSW3pkWKPTGBgGn//n7It+Cie9lBuw4iIzV
         eRTOGQarRIGCQ==
Message-ID: <3f2c81f8-7946-d2e0-8768-6f0b03282944@kernel.org>
Date:   Sun, 11 Dec 2022 10:27:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] f2fs: don't call f2fs_issue_discard_timeout() when
 discard_cmd_cnt is 0 in f2fs_put_super()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20221202045841.9888-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221202045841.9888-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/2 12:58, Yangtao Li wrote:
> No need to call f2fs_issue_discard_timeout() in f2fs_put_super,
> when no discard command requires issue. Since the caller of
> f2fs_issue_discard_timeout() usually judges the number of discard
> commands before using it. Let's move this logic to
> f2fs_issue_discard_timeout().
> 
> By the way, use f2fs_realtime_discard_enable to simplify the code.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/segment.c | 6 ++++--
>   fs/f2fs/super.c   | 8 ++------
>   2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9486ca49ecb1..d5f150a08285 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1655,6 +1655,9 @@ bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
>   	struct discard_policy dpolicy;
>   	bool dropped;
>   
> +	if (!atomic_read(&dcc->discard_cmd_cnt))
> +		return false;
> +
>   	__init_discard_policy(sbi, &dpolicy, DPOLICY_UMOUNT,
>   					dcc->discard_granularity);
>   	__issue_discard_cmd(sbi, &dpolicy);
> @@ -2110,8 +2113,7 @@ static void destroy_discard_cmd_control(struct f2fs_sb_info *sbi)
>   	 * Recovery can cache discard commands, so in error path of
>   	 * fill_super(), it needs to give a chance to handle them.
>   	 */
> -	if (unlikely(atomic_read(&dcc->discard_cmd_cnt)))
> -		f2fs_issue_discard_timeout(sbi);
> +	f2fs_issue_discard_timeout(sbi);
>   
>   	kfree(dcc);
>   	SM_I(sbi)->dcc_info = NULL;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 79bf1faf4161..aa1cadfd34a5 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1576,8 +1576,7 @@ static void f2fs_put_super(struct super_block *sb)
>   	/* be sure to wait for any on-going discard commands */
>   	dropped = f2fs_issue_discard_timeout(sbi);
>   
> -	if ((f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi)) &&
> -					!sbi->discard_blks && !dropped) {
> +	if (f2fs_realtime_discard_enable(sbi) && !sbi->discard_blks && !dropped) {

static inline bool f2fs_realtime_discard_enable(struct f2fs_sb_info *sbi)
{
	return (test_opt(sbi, DISCARD) && f2fs_hw_support_discard(sbi)) ||
					f2fs_hw_should_discard(sbi);
}

It looks the logic is changed?

Thanks,


>   		struct cp_control cpc = {
>   			.reason = CP_UMOUNT | CP_TRIMMED,
>   		};
> @@ -2225,7 +2224,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	bool no_discard = !test_opt(sbi, DISCARD);
>   	bool no_compress_cache = !test_opt(sbi, COMPRESS_CACHE);
>   	bool block_unit_discard = f2fs_block_unit_discard(sbi);
> -	struct discard_cmd_control *dcc;
>   #ifdef CONFIG_QUOTA
>   	int i, j;
>   #endif
> @@ -2406,10 +2404,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   				goto restore_flush;
>   			need_stop_discard = true;
>   		} else {
> -			dcc = SM_I(sbi)->dcc_info;
>   			f2fs_stop_discard_thread(sbi);
> -			if (atomic_read(&dcc->discard_cmd_cnt))
> -				f2fs_issue_discard_timeout(sbi);
> +			f2fs_issue_discard_timeout(sbi);
>   			need_restart_discard = true;
>   		}
>   	}
