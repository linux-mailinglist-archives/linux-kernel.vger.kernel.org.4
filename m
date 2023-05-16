Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBF5705403
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjEPQf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjEPQfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:35:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30AD199C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:35:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 513D863C45
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66805C433D2;
        Tue, 16 May 2023 16:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684254928;
        bh=pzrphtg3UBaTAewESas3zBzhgLY1SwFmbsXEBG4l5RM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VaVc3A73M2+xJnn6r1nffgQwJzpMkUBkNjz0nnnB7DJniaf7oBsKC3AnIY8GuCeMC
         u/QZvXNhYT7Z8FO9TkyCfibxG7NMtj0Add+UpNJCdw7aDJubOCJ/EBOSVj26vxJvrW
         Qkn8Wn6zhC6m8xOC/lrm2XWo8/ekUA9snV06YoP4=
Date:   Tue, 16 May 2023 18:35:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 3/5] debugfs: Update debugfs_create_str() kerneldoc to
 warn about pointer race
Message-ID: <2023051607-trial-worrisome-87df@gregkh>
References: <20230516160753.32317-1-rf@opensource.cirrus.com>
 <20230516160753.32317-4-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516160753.32317-4-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 05:07:51PM +0100, Richard Fitzgerald wrote:
> Add a warning to the debugfs_create_str() kerneldoc that the char * pointer
> value must not change after the function returns, because of a race with
> debugfs_read_file_str() accessing the pointer.
> 
> The only safe case is a change from NULL to non-NULL because in that case
> debugfs_read_file_str() will see either the NULL or the valid pointer.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  fs/debugfs/file.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 0c039a3d9a42..77794871f26d 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -938,11 +938,18 @@ static const struct file_operations fops_str_wo = {
>   *          directory dentry if set.  If this parameter is %NULL, then the
>   *          file will be created in the root of the debugfs filesystem.
>   * @value: a pointer to the variable that the file should read to and write
> - *         from.
> + *         from. The char* pointer must not change, except from NULL to
> + *         non-NULL.

This feels odd.  Why wouldn't you want to change the string value?  Or
why would you?

And why is this one-way transition ok?

Given that this is only used internally, why is it exported?

thanks,

greg k-h
