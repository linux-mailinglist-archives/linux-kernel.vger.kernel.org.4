Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B00F712BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbjEZRVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbjEZRVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:21:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDF1DF
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B590E651E5
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 17:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1489C4339B;
        Fri, 26 May 2023 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685121673;
        bh=gh6aGwNXF50lyfx9OR33zTQ40B1N9Ok+l110UgV9qcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCZWZO1PWnA8Cq7ymgLi3vRtsV0NlSriolEERPEA+bwPTZTWmfaLKm0H3LuxCbkHF
         j+o1OzQiW3Nu3kkBjBkqZ8lcKomyl4c/96+9/R6XAq2cqjk/SzOSysxhQ7N7XHDj1k
         35DTIrnhfczEV6SGpFHZtqDhZ+Ww4CQ+40N1OY9LdynmL4brW1eBsIyAI2Hzu1V3nu
         VtBKjURAhdG+9lpFHBoQS0eSaUiEWcFe0IwGugC5NEooutaAocq/jlD6/j2bq9TUHl
         3QKblWFwpOOLi9bYbwx69M4mPSp/LXSQIxwcAQcvUwewnPXkGQTiFGB33ExAgfRWh8
         asFhwsOwQO2nQ==
Date:   Fri, 26 May 2023 10:21:11 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Wu Bo <bo.wu@vivo.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com
Subject: Re: [PATCH 1/1] f2fs: fix args passed to trace_f2fs_lookup_end
Message-ID: <ZHDqhy4E9iSnneLa@google.com>
References: <20230524100812.80741-1-bo.wu@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524100812.80741-1-bo.wu@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24, Wu Bo wrote:
> The NULL return of 'd_splice_alias' dosen't mean error.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  fs/f2fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 77a71276ecb1..e5a3e39ce90c 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -577,7 +577,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>  #endif
>  	new = d_splice_alias(inode, dentry);
>  	err = PTR_ERR_OR_ZERO(new);
> -	trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
> +	trace_f2fs_lookup_end(dir, new ? new : dentry, ino, err);

Shouldn't give an error pointer to the dentry field.

How about just giving the err?

-       err = PTR_ERR_OR_ZERO(new);
-       trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
+       trace_f2fs_lookup_end(dir, dentry, ino, PTR_ERR_OR_ZERO(new));


>  	return new;
>  out_iput:
>  	iput(inode);
> -- 
> 2.35.3
