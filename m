Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A5D6734B8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjASJq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjASJqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:46:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B2C6C55B;
        Thu, 19 Jan 2023 01:45:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C0936132F;
        Thu, 19 Jan 2023 09:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658ACC433EF;
        Thu, 19 Jan 2023 09:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674121544;
        bh=86dQPWFpAB2B9o/b+NLqYzvxFFkIRRnlhWeIPtazXf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UhVKbhG9GbPkFYGVE7fEp/J673sYlchRWnirLbLe8U+O7t6Ex16OrAUIDFU2wAYqb
         Emq/x6VUHonZ2HZmWCWRGK3cOOgelbDaK04yHnKrGsgIoZ6DUjxNNcsED3ahbus0KI
         jxLzHZu4MhTNYF/pHzvyRmnR221q5mXXuJFW3UIU3kfFZoZRdBDimkoOtl/gVgJ3Wi
         b6o4AeFP0LQxIOgRUg9qQhPsz/cv+1szFySI3cKZTEQdN2IYNi0J01S1VF5qVLJKr5
         gCgrZCoGBOpQqEfQI8NtxuAhBGrgoJ+Ze+PZYYEmhO8oo/0+OClE/Hazm+BruBJzEC
         EbvZmwDCioOBg==
Date:   Thu, 19 Jan 2023 11:45:32 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mm/secretmem: remove redundant initiialization of
 pointer file
Message-ID: <Y8kRPPTpL5J85YXW@kernel.org>
References: <20230116164332.79500-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116164332.79500-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 04:43:32PM +0000, Colin Ian King wrote:
> The pointer file is being initialized with a value that is never read, it
> is being re-assigned later on. Clean up code by removing the redundant
> initialization.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/secretmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 04c3ac9448a1..be3fff86ba00 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -190,7 +190,7 @@ static struct vfsmount *secretmem_mnt;
>  
>  static struct file *secretmem_file_create(unsigned long flags)
>  {
> -	struct file *file = ERR_PTR(-ENOMEM);
> +	struct file *file;
>  	struct inode *inode;
>  	const char *anon_name = "[secretmem]";
>  	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
