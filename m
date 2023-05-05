Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C779A6F8302
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjEEMdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjEEMdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:33:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF8611617
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:33:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0833E611B7
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6010C433D2;
        Fri,  5 May 2023 12:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683289983;
        bh=pKG4Mf1bb5gbOdPLge/zmMjdEqspBKyucO7r0APgGMg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AAVyB+eImxXSdHKQeX+a1ytJ4aYUF9jejBsjDavPyRP/Iw66yBoHdGaAdCgMtcfHe
         pe1LKTN5L7iwKKjqDVOHsYZv/JMy2R3fjU4k51bb5whcW8OMF6ttJbWkt4PIxE4SXG
         wazkSXjR4yEtht1pX+SC9I0GI/wX7Aki7HtFjilD2ym5IMejQHQsS4EOtxIby3HoeF
         hgqkMuaEmmJbBQSzmN053FwY9hdXyj+inDCUViWfJnkLQjlbUESp6McmwCT7Vw2hct
         YPxyHx0XF9x5ATo8JhPG7+z8N2y5eluoZWTT2Pg292pSIAHAyd01xux0hoKiazayKc
         opd0qZyraVjEQ==
Message-ID: <d853431a-897c-71b2-d97f-5572bd7f79cb@kernel.org>
Date:   Fri, 5 May 2023 20:32:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] f2fs_io: support move_range command
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230504144406.33713-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230504144406.33713-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/4 22:44, Yangtao Li wrote:
> This patch supports a new sub-command 'move_range' in f2fs_io
> to move a range of data blocks from source file to destination
> file via F2FS_IOC_MOVE_RANGE ioctl.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   man/f2fs_io.8           |  4 ++++
>   tools/f2fs_io/f2fs_io.c | 35 +++++++++++++++++++++++++++++++++++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/man/f2fs_io.8 b/man/f2fs_io.8
> index 13d4bf3..b25f807 100644
> --- a/man/f2fs_io.8
> +++ b/man/f2fs_io.8
> @@ -138,8 +138,12 @@ Trigger filesystem GC
>   .TP
>   \fBcheckpoint\fR \fI[file]\fR
>   Trigger filesystem checkpoint
> +.TP
>   \fBprecache_extents\fR \fI[file]\fR
>   Trigger precache extents
> +.TP
> +\fBmove_range\fR \fI[src_path] [dst_path] [src_start] [dst_start] [length]\fR
> +Move a range of data blocks from source file to destination file
>   .SH AUTHOR
>   This version of
>   .B f2fs_io
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index ac7b588..d545d8e 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -1357,6 +1357,40 @@ static void do_precache_extents(int argc, char **argv, const struct cmd_desc *cm
>   	exit(0);
>   }
>   
> +#define move_range_desc "moving a range of data blocks from source file to destination file"
> +#define move_range_help						\
> +"f2fs_io move_range [src_path] [dst_path] [src_start] [dst_start] [length]\n\n"		\

It's better to wrap the long line as below?

#define move_range_help							\
"f2fs_io move_range [src_path] [dst_path] [src_start] [dst_start] "	\
"[length]\n\n"								\

Thanks,

> +"  src_path  : path to source file\n"					\
> +"  dst_path  : path to destination file\n"				\
> +"  src_start : start offset of src file move region, unit: bytes\n"	\
> +"  dst_start : start offset of dst file move region, unit: bytes\n"	\
> +"  length    : size to move\n"						\
> +
> +static void do_move_range(int argc, char **argv, const struct cmd_desc *cmd)
> +{
> +	struct f2fs_move_range range;
> +	int ret, fd;
> +
> +	if (argc != 6) {
> +		fputs("Excess arguments\n\n", stderr);
> +		fputs(cmd->cmd_help, stderr);
> +		exit(1);
> +	}
> +
> +	fd = xopen(argv[1], O_RDWR, 0);
> +	range.dst_fd = xopen(argv[2], O_RDWR | O_CREAT, 0644);
> +	range.pos_in = atoi(argv[3]);
> +	range.pos_out = atoi(argv[4]);
> +	range.len = atoi(argv[5]);
> +
> +	ret = ioctl(fd, F2FS_IOC_MOVE_RANGE, &range);
> +	if (ret < 0)
> +		die_errno("F2FS_IOC_MOVE_RANGE failed");
> +
> +	printf("move range ret=%d\n", ret);
> +	exit(0);
> +}
> +
>   #define CMD_HIDDEN 	0x0001
>   #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
>   #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
> @@ -1391,6 +1425,7 @@ const struct cmd_desc cmd_list[] = {
>   	CMD(gc),
>   	CMD(checkpoint),
>   	CMD(precache_extents),
> +	CMD(move_range),
>   	{ NULL, NULL, NULL, NULL, 0 }
>   };
>   
