Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5D670540F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjEPQiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjEPQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:37:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDA51FD8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:37:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AC68632E2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3EEC433D2;
        Tue, 16 May 2023 16:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684255025;
        bh=14jDO9HnlH/eygMDTDhZy7erQpDiEI1dolQOiBip1yU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rI0ZRx06/UDTBq8eyEAuntFS7SsHA/Xpgxqm7NKCxBNrqLFq6rXMH3V8Q0Bjau/wN
         7CCm87MOaG+Pu6HqwR4x8XeQm93sRb4Ic90l3SAw2wZSqBglALufC6is7yZSTtH9GI
         TIZfB3Da3t0qg7CAglTbRFy15ZLJAZiGZ0bk+L4k=
Date:   Tue, 16 May 2023 18:37:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 5/5] debugfs: Add debugfs_create_const_str()
Message-ID: <2023051651-pebble-simmering-58b8@gregkh>
References: <20230516160753.32317-1-rf@opensource.cirrus.com>
 <20230516160753.32317-6-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516160753.32317-6-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 05:07:53PM +0100, Richard Fitzgerald wrote:
> Add a wrapper for debugfs_create_str() that takes a const char **.
> 
> It's never nice to have to cast a const pointer to a non-const to be
> able to pass it to an API. It always looks suspicious and it is relying
> on "knowing" that it's safe. A function that explicitly takes a const
> pointer is creating a contract that a const pointer is safe.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  include/linux/debugfs.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
> index ea2d919fd9c7..2723690aedd1 100644
> --- a/include/linux/debugfs.h
> +++ b/include/linux/debugfs.h
> @@ -401,4 +401,31 @@ static inline void debugfs_create_xul(const char *name, umode_t mode,
>  		debugfs_create_x64(name, mode, parent, (u64 *)value);
>  }
>  
> +/**
> + * debugfs_create_const_str - create a debugfs file that is used to read a string value
> + * @name: a pointer to a string containing the name of the file to create.
> + * @mode: the permission that the file should have
> + * @parent: a pointer to the parent dentry for this file.  This should be a
> + *          directory dentry if set.  If this parameter is %NULL, then the
> + *          file will be created in the root of the debugfs filesystem.
> + * @value: a pointer to the variable that the file should read from.
> + *         The const char* pointer must not change, except from NULL to
> + *         non-NULL.
> + *
> + * This function creates a file in debugfs with the given name that
> + * contains the value of the variable @value.
> + *
> + * The const char* pointed to by @value must not change after calling this
> + * function EXCEPT that it may change from NULL to non-NULL. This is to
> + * prevent the file read from accessing a stale pointer. A change from
> + * NULL to non-NULL is the only safe change, because the read will
> + * instantaneously see either NULL or the valid pointer.
> + */
> +static inline void debugfs_create_const_str(const char *name, umode_t mode,
> +					    struct dentry *parent,
> +					    const char **value)
> +{
> +	debugfs_create_str(name, mode & ~0222, parent, (char **)value);

You just "know" it's safe to do this?  There is nothing in
debugfs_create_str() that would prevent future changes from violating
the "const" here, which makes this very unsafe to maintain over time.

This feels backwards, why not make debugfs_create_str() take the const
pointer instead?

thanks,

greg k-h
