Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05139716E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjE3UPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjE3UPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:15:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A820138
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 13:14:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1612562EF3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E29AC433D2;
        Tue, 30 May 2023 20:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685477695;
        bh=44WCNV7nugST0nNtKo1Ce1/xmKinsbP8BNQC8KvX40A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YEJBWByVW2deQuA7F+8Hver0h5JX9MXCf2m2Bhf75KSl9usSlxtMYF0IMSDVvp9Js
         use80RNkOYgRfCUAr1x8VX8DOe9kfsNSXOmRv4AuFhS8O2qlSBdRvLc/PBhpSSAsNk
         JBKej+WlUyG7AczIGwvh9btc1tZW8f6453If8T4U=
Date:   Tue, 30 May 2023 21:14:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chris hyser <chris.hyser@oracle.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] debugfs: return EINVAL if write to unsigned simple
 files exceed storage.
Message-ID: <2023053058-favorably-snowbound-39eb@gregkh>
References: <20230530194012.44411-1-chris.hyser@oracle.com>
 <20230530194012.44411-2-chris.hyser@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530194012.44411-2-chris.hyser@oracle.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:40:09PM -0400, chris hyser wrote:
> Writes to the debug files created by "debugfs_create_*" (u8/u16/u32/u64),
> (x8/x16/x32/x64) should not silently succeed if the value exceeds the
> storage space for the type and upper written bits are lost. Absent an
> error, a read should return the last written value.  Current behaviour is
> to down cast the storage type thus losing upper bits (thus u64/x64
> files are unaffected).
> 
> This patch ensures the written value fits into the specified storage space
> returning EINVAL on error.
> 
> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
> ---
>  Documentation/filesystems/debugfs.rst | 7 ++++---
>  fs/debugfs/file.c                     | 6 ++++++
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/debugfs.rst b/Documentation/filesystems/debugfs.rst
> index dc35da8b8792..6f1ac8d7f108 100644
> --- a/Documentation/filesystems/debugfs.rst
> +++ b/Documentation/filesystems/debugfs.rst
> @@ -85,9 +85,10 @@ created with any of::
>  			    struct dentry *parent, u64 *value);
>  
>  These files support both reading and writing the given value; if a specific
> -file should not be written to, simply set the mode bits accordingly.  The
> -values in these files are in decimal; if hexadecimal is more appropriate,
> -the following functions can be used instead::
> +file should not be written to, simply set the mode bits accordingly.  Written
> +values that exceed the storage for the type return EINVAL. The values in these
> +files are in decimal; if hexadecimal is more appropriate, the following
> +functions can be used instead::
>  
>      void debugfs_create_x8(const char *name, umode_t mode,
>  			   struct dentry *parent, u8 *value);
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 1f971c880dde..743ddd04f8d8 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -429,6 +429,8 @@ static struct dentry *debugfs_create_mode_unsafe(const char *name, umode_t mode,
>  
>  static int debugfs_u8_set(void *data, u64 val)
>  {
> +	if (val > (1 << sizeof(u8) * 8) - 1)
> +		return -EINVAL;

We do have U8_MAX and friends, please don't reinvent the wheel.

But really, why?  This is debugfs, if userspace messes something up like
this, why not just cast and be done with it?

In other words, what existing workflow is now going to break with this
patchset?  :)

thanks,

greg k-h
