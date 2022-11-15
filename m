Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3289D6291F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiKOGnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKOGnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:43:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875C51F2F0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:43:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BCF561554
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F3CC433D6;
        Tue, 15 Nov 2022 06:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668494589;
        bh=841NKq7gNARFE/LJxYV02SFg0/321NUgaAKLTR8Xj4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EBQeTQqo5fgici3qu6T0mx9/X0zIERoZDsklmY1JVvqx9GEfG930gBDXCqKZgTrQu
         wio9lF5mzCJpfh3ifT2X3YO8AVkEKwbGfA9ic64g+lD9Ph0Uxhl4XmtQNwNr08lE9N
         FXqFAMSAUu5pHZzG1sv2Cx8zgK1NadlNpm+Mtnkk=
Date:   Tue, 15 Nov 2022 07:43:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     guo.ziliang@zte.com.cn
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] kernfs: use strscpy() is more robust and safer
Message-ID: <Y3M0+fNWo+lrEPZw@kroah.com>
References: <202211150847452601249@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211150847452601249@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 08:47:45AM +0800, guo.ziliang@zte.com.cn wrote:
> From: guo ziliang <guo.ziliang@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.

How exactly is it more robust and safer?

> That's now the recommended way to copy NUL terminated strings.

Recommended by whom for what?



> 
> Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>
> ---
>  fs/kernfs/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 77d7a3a..fbb8df4 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -844,7 +844,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
> 
>         spin_lock_irq(&kernfs_pr_cont_lock);
> 
> -       len = strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
> +       len = strscpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));

How did you test this change is correct and does not cause any problems?

How was this issue found?

thanks,

greg k-h
