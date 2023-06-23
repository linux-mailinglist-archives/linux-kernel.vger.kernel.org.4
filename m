Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B8E73BA2E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjFWOaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjFWOa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4A22133
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9DE261A39
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 14:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE2EC433C8;
        Fri, 23 Jun 2023 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687530624;
        bh=f3SgirWMZNzjfOv8MYe/IZWYhtq4Pk7EtreXIX39Ouo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrvz33zVTHywWSc1zMFNfB7orFvzAit4G8Zf/6857l8f81Dru/DVyTqvLoMubGIaU
         +Qu5yjaHBcksIkpD4gTqI6UsqGuAgx9hJ2CtXtvBCwZiM3Z6XL78BuwtkqY2/+W6iJ
         rW54Js11m/Yj2HAU6G76cdOMS9/jOikAPSjUhsII=
Date:   Fri, 23 Jun 2023 16:30:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     rafael@kernel.org, badhri@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysfs: Replace %p with %pK in the warning of sysfs_emit*
Message-ID: <2023062359-moody-bunch-3011@gregkh>
References: <20230623142054.3945121-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623142054.3945121-1-kyletso@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 10:20:54PM +0800, Kyle Tso wrote:
> According to Documentation/core-api/printk-formats.rst, kernel pointers
> need to be printed with %pK format specifier to respect kptr_restrict in
> sysctl.
> 
> Also replace the function names in the strings with %s and __func__ as
> checkpatch.pl suggested.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
>  fs/sysfs/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index a12ac0356c69..56712f0886ef 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -732,7 +732,7 @@ int sysfs_emit(char *buf, const char *fmt, ...)
>  	int len;
>  
>  	if (WARN(!buf || offset_in_page(buf),
> -		 "invalid sysfs_emit: buf:%p\n", buf))
> +		 "invalid %s: buf:%pK\n", __func__, buf))

Wait, no, these are not going out in sysfs files, as they are still
going to dmesg, right?

So I think this line in the documentation matters:
	This modifier is *only* intended when producing content of a file read by
	userspace from e.g. procfs or sysfs, not for dmesg. Please refer to the
	section about %p above for discussion about how to manage hashing pointers
	in printk().

so %p should still be ok here, the hashed value will end up in the
kernerl log, which is what we want, and the WARN() traceback will show
the problem properly, right?

>  		return 0;
>  
>  	va_start(args, fmt);
> @@ -760,7 +760,7 @@ int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
>  	int len;
>  
>  	if (WARN(!buf || offset_in_page(buf) || at < 0 || at >= PAGE_SIZE,
> -		 "invalid sysfs_emit_at: buf:%p at:%d\n", buf, at))
> +		 "invalid %s: buf:%pK at:%d\n", __func__, buf, at))


Same here, %p should be correct.

Sorry for missing this before.

greg k-h
