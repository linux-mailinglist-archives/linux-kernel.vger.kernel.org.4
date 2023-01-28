Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FA867F9D7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjA1RYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjA1RYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:24:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82617144A0;
        Sat, 28 Jan 2023 09:24:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D2BC60BAD;
        Sat, 28 Jan 2023 17:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E038BC433D2;
        Sat, 28 Jan 2023 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674926683;
        bh=gyX0IhGsDxt9M//MLMJmErh/JVISs1iqdqbw8LxGycU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SKGTVEYTgizaeg2sRYtfkRDnXvvZ9mKhegZnWtJAbXBJGCUZVItAEKRgX0Rdljwfm
         kxCB+c7PqdVMwlESPArC07pvMYCTUvirD7eaPaf+zdhlSXfJV9BQUCpxZGbRqjFE7C
         PHYKk63vw3lJ5ZWjrxUHCt9U9wQ2S87YVmYde9kLuQxtvXGrEkGeRZcERCyKYGBYll
         sEumsTczWItcuSqCre49ipo+aH/eWpg6DuLvoCjCdqH1TmhI7Y/ZjRA2+FifFHXul0
         alU86L7ge03On5AQHiQnpRYju+IPRBg2yVPtNbgcMM2LXHqo3KiioLXc3mLEnm7aRA
         +SVlkGNhxrYAQ==
Date:   Sat, 28 Jan 2023 17:38:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, Lars-Peter Clausen <lars@metafoo.de>,
        Irina Tirdea <irina.tirdea@intel.com>,
        Vlad Dogaru <ddvlad@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma9551_core: Prevent uninitialized
 variable in mma9551_read_status_word()
Message-ID: <20230128173836.10a58a7e@jic23-huawei>
In-Reply-To: <20230126152147.3585874-1-harshit.m.mogalapalli@oracle.com>
References: <20230126152147.3585874-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 07:21:46 -0800
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> Smatch Warns: drivers/iio/accel/mma9551_core.c:357
> 	mma9551_read_status_word() error: uninitialized symbol 'v'.
> 
> When (offset >= 1 << 12) is true mma9551_transfer() will return -EINVAL
> without 'v' being initialized, so check for the error and return.
> 
> Fixes: d5b97f5c7dfc ("iio: accel: mma9551: split driver to expose mma955x api")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Whilst inelegant, there isn't actually a bug here as such because the function
callers don't use the value.  Given the function is exported, it's not going to
be easy for static analysis to see that however and your patch is definitely an
improvement.

Hence applied, but with fixes tag dropped and a note added for information
of anyone considering backporting this.

Jonathan

> ---
> This is detected using static analysis with smatch, and could probably
> be detected by syzkaller fuzzing in future.
> ---
>  drivers/iio/accel/mma9551_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
> index 75eee7f7303a..b898f865fb87 100644
> --- a/drivers/iio/accel/mma9551_core.c
> +++ b/drivers/iio/accel/mma9551_core.c
> @@ -357,9 +357,12 @@ int mma9551_read_status_word(struct i2c_client *client, u8 app_id,
>  
>  	ret = mma9551_transfer(client, app_id, MMA9551_CMD_READ_STATUS,
>  			       reg, NULL, 0, (u8 *)&v, 2);
> +	if (ret < 0)
> +		return ret;
> +
>  	*val = be16_to_cpu(v);
>  
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_NS(mma9551_read_status_word, IIO_MMA9551);
>  

