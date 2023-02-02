Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0C668729D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 01:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjBBA5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 19:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBBA5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 19:57:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915345C0DF;
        Wed,  1 Feb 2023 16:57:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48D35B80DCD;
        Thu,  2 Feb 2023 00:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF4EC433EF;
        Thu,  2 Feb 2023 00:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675299423;
        bh=Ub7s0Ucih/e7c6CsJRrOHe4+5kxX8xqRaSTCMxQjEHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/oAyrJ2dwrVkfmWC+9sYbGtiDXy9BdWCR6ZOLF81sphk7XMn5/KXBfsJddPAMRNl
         vz9mkzhZy3BvZ3/AR4MhpCcgAiJVmJ74rr78gPhO1CKlTNyG51CkyhhHiw2wsgM0ly
         qVBTZ0L5wcRYeQFgC2+c17ufWQII5J07s6jHsPpnREkknM2Db6PILNRnZQurReevvM
         LA7MaG1AIwK8HpB9noG7sjDWikGXjaH7kuQ5aUhYpusXMwl+9/loLREj4/YZCOcUWa
         RMdc4rVV84EVvuKIG8PaP1KYSMlQThelXcBTmi7Ihe2sEpheYc92fSngHEde+zxB3w
         vkdj5GtLfDDYw==
Date:   Wed, 1 Feb 2023 16:57:02 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     yang.yang29@zte.com.cn
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] xfs: use strscpy() to instead of strncpy()
Message-ID: <Y9sKXhxvf0DDusih@magnolia>
References: <202301091940437129873@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301091940437129873@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 07:40:43PM +0800, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.
> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>

Looks fine,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_xattr.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
> index 10aa1fd39d2b..913c1794bc2f 100644
> --- a/fs/xfs/xfs_xattr.c
> +++ b/fs/xfs/xfs_xattr.c
> @@ -212,9 +212,7 @@ __xfs_xattr_put_listent(
>  	offset = context->buffer + context->count;
>  	memcpy(offset, prefix, prefix_len);
>  	offset += prefix_len;
> -	strncpy(offset, (char *)name, namelen);			/* real name */
> -	offset += namelen;
> -	*offset = '\0';
> +	strscpy(offset, (char *)name, namelen + 1);			/* real name */
> 
>  compute_size:
>  	context->count += prefix_len + namelen + 1;
> -- 
> 2.15.2
