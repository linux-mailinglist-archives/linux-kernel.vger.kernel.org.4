Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E0472C860
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbjFLO0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbjFLO0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:26:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101392953
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:24:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA3EA615E3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6656BC433EF;
        Mon, 12 Jun 2023 14:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579835;
        bh=ru8p5cn4S9smhGWMCMzJZMSU8wN0AsEFLROWReLGgxo=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Zi10AnLsRmaE0mjSsNlAG/fSkLrflx62UQ/GzGd9nU7h/uA79ZGYUdUYMLq424JvQ
         wZX4JYP4GJCiTXF31768h3v4WcuYwEaEL3alc0q9ZNMI6Uh5Zc7Sg88IHjioBN7eL/
         7JgQcAZncEbZ2JtZWLq2a6fio1j1hgSYG13d3GJWiol+U8G98Y4A9d/BqLZp8wwfJc
         YW7i10sRtp9FkwptmMjfyXEGdjEbpbCsSAsPFwznbPRm9X6iKZbC1YyVAr+btAW+n8
         EZzWpu8rkYLrj7vU6+AbmbGUy/ZgPPKjZmdpYjrWDmW1gYH2eASiADT2rGz7V2jPnU
         tpR+KfJ0thnCg==
Message-ID: <85ff67e0-c6c6-e693-bcba-6e36a3dd2ea4@kernel.org>
Date:   Mon, 12 Jun 2023 22:23:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [f2fs-dev] [PATCH] f2fs: set zstd default compression level to 3
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230607162954.2651657-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230607162954.2651657-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/8 0:29, Jaegeuk Kim wrote:
> ZSTD does not support compress_level=0.

IIUC, it looks the range is [0, ZSTD_MAX_CLEVEL], 0 equals to default
(ZSTD_CLEVEL_DEFAULT).

zstd_compress.c

     /* row */
     if (compressionLevel == 0) row = ZSTD_CLEVEL_DEFAULT;   /* 0 == default */
     else if (compressionLevel < 0) row = 0;   /* entry 0 is baseline for fast mode */
     else if (compressionLevel > ZSTD_MAX_CLEVEL) row = ZSTD_MAX_CLEVEL;
     else row = compressionLevel;

Thanks,

> 
> The commit d7ffafc99c42 ("f2fs: add sanity compress level check for compressed file")
> revealed the issue.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 8fd23caa1ed9..1fb8d4f27a40 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -627,7 +627,7 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
>   	int len = 4;
>   
>   	if (strlen(str) == len) {
> -		F2FS_OPTION(sbi).compress_level = 0;
> +		F2FS_OPTION(sbi).compress_level = 3;
>   		return 0;
>   	}
>   
