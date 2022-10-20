Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02123605A72
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiJTJBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiJTJBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:01:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2818196B7D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:01:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35E99B826A4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8452CC433D7;
        Thu, 20 Oct 2022 09:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666256481;
        bh=L53OLp+EtSA3/Wo9g7x7vk8nFVgvWC22Aa/T6e2PStc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M3XDzlbDmMtxOYamMV21F0m6VnlwZFg0LY+wHzzdoBY8javIfionD+3iUvZhlyWBt
         AZI9QuzkDvW5hSCHnXJLYY2XwQet9dNqD0m5rLxWXjiqVp2ccTm7iEw7BlErWAg5v7
         Ds6ssvdP3jfpyssodkraSv6PP6tGHdytcUIyF6tWHPDMBS0x9S40Tf66VfHFuNHhn2
         aZ7WkAZVXViCeWEGizu38iyLVhUHPA70CPU9QM3vBH3KO1RC0nT9Wq0H4F6LNa+wQ/
         /nTG4xpSx/cpcE9emZzb/8zJzWxCPIK/+k/+ZifzVR7xn6Gu/gwTxXPk6VR2CzUDeV
         38TqdeM9oaXug==
Message-ID: <35c29f27-96c6-6d74-1efb-1588cbf430a2@kernel.org>
Date:   Thu, 20 Oct 2022 17:01:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] f2fs: fix the assign logic of iocb
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, jaegeuk@kernel.org,
        mhiramat@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1666196277-27014-1-git-send-email-quic_mojha@quicinc.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <1666196277-27014-1-git-send-email-quic_mojha@quicinc.com>
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

On 2022/10/20 0:17, Mukesh Ojha wrote:
> commit 18ae8d12991b ("f2fs: show more DIO information in tracepoint")
> introduces iocb field in 'f2fs_direct_IO_enter' trace event
> And it only assigns the pointer and later it accesses its field
> in trace print log.
> 
> Fix it by correcting data type and memcpy the content of iocb.

So the implementation below is wrong, right? since it just assign __entry->name
with dentry->d_name.name rather than copyiny entirely, so that, during printing
of tracepoint, __entry->name may be invalid.

TRACE_EVENT(f2fs_unlink_enter,

	TP_PROTO(struct inode *dir, struct dentry *dentry),

	TP_ARGS(dir, dentry),

	TP_STRUCT__entry(
		__field(dev_t,	dev)
		__field(ino_t,	ino)
		__field(loff_t,	size)
		__field(blkcnt_t, blocks)
		__field(const char *,	name)
	),

	TP_fast_assign(
		__entry->dev	= dir->i_sb->s_dev;
		__entry->ino	= dir->i_ino;
		__entry->size	= dir->i_size;
		__entry->blocks	= dir->i_blocks;
		__entry->name	= dentry->d_name.name;
	),

> 
> Fixes: 18ae8d12991b ("f2fs: show more DIO information in tracepoint")
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   include/trace/events/f2fs.h | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index c6b3724..7727ec9 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -940,7 +940,7 @@ TRACE_EVENT(f2fs_direct_IO_enter,
>   	TP_STRUCT__entry(
>   		__field(dev_t,	dev)
>   		__field(ino_t,	ino)
> -		__field(struct kiocb *,	iocb)
> +		__field_struct(struct kiocb,	iocb)
>   		__field(unsigned long,	len)
>   		__field(int,	rw)
>   	),
> @@ -948,17 +948,17 @@ TRACE_EVENT(f2fs_direct_IO_enter,
>   	TP_fast_assign(
>   		__entry->dev	= inode->i_sb->s_dev;
>   		__entry->ino	= inode->i_ino;
> -		__entry->iocb	= iocb;
> +		 memcpy(&__entry->iocb, iocb, sizeof(*iocb));
>   		__entry->len	= len;
>   		__entry->rw	= rw;
>   	),
>   
>   	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu ki_flags = %x ki_ioprio = %x rw = %d",
>   		show_dev_ino(__entry),
> -		__entry->iocb->ki_pos,
> +		__entry->iocb.ki_pos,
>   		__entry->len,
> -		__entry->iocb->ki_flags,
> -		__entry->iocb->ki_ioprio,
> +		__entry->iocb.ki_flags,
> +		__entry->iocb.ki_ioprio,
>   		__entry->rw)
>   );
>   
