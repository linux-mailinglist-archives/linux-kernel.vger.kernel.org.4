Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0656ED5E0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 22:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjDXUGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 16:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDXUGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:06:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4567B1FE6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C54A4628B9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 20:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DF6C433D2;
        Mon, 24 Apr 2023 20:06:48 +0000 (UTC)
Date:   Mon, 24 Apr 2023 16:06:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hao Zeng <zenghao@kylinos.cn>
Cc:     chenhuacai@kernel.org, zhangqing@loongson.cn,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] recordmcount: Fix memory leaks in the uwrite function
Message-ID: <20230424160646.3faf00f1@rorschach.local.home>
In-Reply-To: <20230412093048.3005276-1-zenghao@kylinos.cn>
References: <20230412093048.3005276-1-zenghao@kylinos.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 17:30:48 +0800
Hao Zeng <zenghao@kylinos.cn> wrote:

> Common realloc mistake: 'file_append' nulled but not freed upon failure
> 
> Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
> ---
>  scripts/recordmcount.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
> index e30216525325..2b7173a86d4c 100644
> --- a/scripts/recordmcount.c
> +++ b/scripts/recordmcount.c
> @@ -110,22 +110,23 @@ static ssize_t uwrite(void const *const buf, size_t const count)
>  {
>  	size_t cnt = count;
>  	off_t idx = 0;
> -
> +	void *p = NULL;
>  	file_updated = 1;
>  
>  	if (file_ptr + count >= file_end) {
>  		off_t aoffset = (file_ptr + count) - file_end;
>  
>  		if (aoffset > file_append_size) {
> -			file_append = realloc(file_append, aoffset);
> +			p = realloc(file_append, aoffset);
> +			if (!p) {
> +				perror("write");
> +				file_append_cleanup();
> +				mmap_cleanup();
> +				return -1;
> +			}
> +			file_append = p;
>  			file_append_size = aoffset;
>  		}

This changes the logic of the function. If file_append is NULL when
entering, and does not get into the allocate path we still want this to
error.

Just do:

		p = realloc(file_append, aoffset);
		if (!p) {
			free(file_append);
			file_append = NULL;
		}

And that keeps the same logic but removes the memory leak.

-- Steve


> -		if (!file_append) {
> -			perror("write");
> -			file_append_cleanup();
> -			mmap_cleanup();
> -			return -1;
> -		}
>  		if (file_ptr < file_end) {
>  			cnt = file_end - file_ptr;
>  		} else {

