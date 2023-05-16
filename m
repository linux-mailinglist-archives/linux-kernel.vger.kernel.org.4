Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E372E7053FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjEPQel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjEPQeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:34:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E868A6F
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A37363C4E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F801C433EF;
        Tue, 16 May 2023 16:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684254790;
        bh=S662qo2UVoOXOFDuwEkwSVoUMgoQBmhOOr5kswpopv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o+7H1wisXbIBcAvQyoHAL3B+q7ARKGA6goA+cwdMrOi0XLMLycw0HhgiPwK9cHAU6
         XeG4VcilF6WaI930vA5K5fqXnAFxe5OHXZ8/ZOQFsPHJdRVR8awdx+4MPMXr2Smn9H
         KSx6Fx5HThvUcK7lMfWuw0DthbvmIZZwBHqD9XAM=
Date:   Tue, 16 May 2023 18:33:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 1/5] debugfs: Prevent NULL dereference reading from
 string property
Message-ID: <2023051659-sinless-lemon-e3b1@gregkh>
References: <20230516160753.32317-1-rf@opensource.cirrus.com>
 <20230516160753.32317-2-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516160753.32317-2-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 05:07:49PM +0100, Richard Fitzgerald wrote:
> Check in debugfs_read_file_str() if the string pointer is NULL.
> 
> It is perfectly reasonable that a driver may wish to export a string
> to debugfs that can have the value NULL to indicate empty/unused/ignore.

Does any in-kernel driver do this today?

If not, why not fix up the driver instead?

> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  fs/debugfs/file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 1f971c880dde..2c085ab4e800 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -878,6 +878,9 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
>  		return ret;
>  
>  	str = *(char **)file->private_data;
> +	if (!str)
> +		return simple_read_from_buffer(user_buf, count, ppos, "\n", 1);

Why not print "(NULL)"?

thanks,

greg k-h
