Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A19160C468
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJYG60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiJYG6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:58:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39542870B4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:58:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C86DD6172E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D45C433D7;
        Tue, 25 Oct 2022 06:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666681082;
        bh=q8A9jgNMfJHop8tmccVSs5ZNY1a4K4Q5DqYfg2Ki4/c=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Gcikk7BvD7Mi1AArQuPJ2kLnxgdZddQ+SNPmz1tToGO3ekGIi4l5yRX7aJGSLvi8n
         duprxhb3TfF6sp0uj2B/0oXuPdl1RS5stC0b0Ocprn1Rjo+xg3iNlzlxqlrAxYb82I
         FlwKFWTWMTWWM1tvEquB1Hd+GdFs2+5lh4wovsskPwACHbWz1slC5j01XofXb73M5r
         bqW5+URMcYVcESakAx0ZuzlzLwsxkApOCqAghhFS5EJlpX0TBs+FMjj0gyBQhcLQvb
         oBSCSxRJg96NkHCFBa/Mu7MpklT9dAZvPCZIG4gr2vZfn3zeBJFZnNofRlUosmyIN2
         xDD9B9jnF60Yg==
Message-ID: <ae5f7c6e-248b-3cf7-b111-a4ddc85dd411@kernel.org>
Date:   Tue, 25 Oct 2022 14:57:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow to set compression for inlined
 file
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20221024233634.803695-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221024233634.803695-1-jaegeuk@kernel.org>
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

On 2022/10/25 7:36, Jaegeuk Kim wrote:
> The below commit disallows to set compression on empty created file which
> has a inline_data. Let's fix it.
> 
> Fixes: 7165841d578e ("f2fs: fix to check inline_data during compressed inode conversion")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/file.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 1c4004c9245f..304fe08edc61 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1915,6 +1915,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>   			if (!f2fs_disable_compressed_file(inode))
>   				return -EINVAL;
>   		} else {
> +			/* try to convert inline_data to support compression */
> +			f2fs_convert_inline_inode(inode);

It needs to check return value of f2fs_convert_inline_inode()?

Thanks,

> +
>   			if (!f2fs_may_compress(inode))
>   				return -EINVAL;
>   			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
