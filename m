Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8541174178C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjF1Rx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:53:59 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:35584 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjF1Rxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:53:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 208A061426;
        Wed, 28 Jun 2023 17:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83295C433C0;
        Wed, 28 Jun 2023 17:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687974833;
        bh=7Y8Tf8pgFZSbW2qr4IXYWxLED2bq73fapoIxHzsBfd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuwRrxdMnJY+188PamF/Vtz3b1m7Wf4U1v1ENnWXee+8svZHB/ikT5qE+Va6aqH+z
         35v+4FIuWsbGFRyt4Sx46p/5LIdPTsWKYKQw6PGK/Iz4cyq5HvFG/vmA9OynGuH6hE
         8huZZBOSfxebRCmJreUGrJozSIw+NOB0wuXH+C6mgaZR24291gAd9KVpoQEm0nG1Ls
         nP4eYGCvvGQ7tKbeuq0B3ImVwmut/mgD8nIXiAR2rDBSrJf8CiHB/bxNlsFHH+lxoO
         1czFF1Zcq3H1JgRYSCI2xhuikmDlj+pZTwffsH16HbLPV/XHIMaYei4E6WAuUGYY6R
         KkDr0d0WZZOHA==
Date:   Wed, 28 Jun 2023 10:53:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] xfs: remove redundant initializations of pointers
 drop_leaf and save_leaf
Message-ID: <20230628175352.GZ11441@frogsfrogsfrogs>
References: <20230622093403.2829382-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622093403.2829382-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 10:34:03AM +0100, Colin Ian King wrote:
> Pointers drop_leaf and save_leaf are initialized with values that are never
> read, they are being re-assigned later on just before they are used. Remove
> the redundant early initializations and keep the later assignments at the
> point where they are used. Cleans up two clang scan build warnings:
> 
> fs/xfs/libxfs/xfs_attr_leaf.c:2288:29: warning: Value stored to 'drop_leaf'
> during its initialization is never read [deadcode.DeadStores]
> fs/xfs/libxfs/xfs_attr_leaf.c:2289:29: warning: Value stored to 'save_leaf'
> during its initialization is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

I'll change this to remove the /second/ initialization below the
variable declarations for a net -2 LOC.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_attr_leaf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
> index beee51ad75ce..3091d40a1eb6 100644
> --- a/fs/xfs/libxfs/xfs_attr_leaf.c
> +++ b/fs/xfs/libxfs/xfs_attr_leaf.c
> @@ -2285,8 +2285,8 @@ xfs_attr3_leaf_unbalance(
>  	struct xfs_da_state_blk	*drop_blk,
>  	struct xfs_da_state_blk	*save_blk)
>  {
> -	struct xfs_attr_leafblock *drop_leaf = drop_blk->bp->b_addr;
> -	struct xfs_attr_leafblock *save_leaf = save_blk->bp->b_addr;
> +	struct xfs_attr_leafblock *drop_leaf;
> +	struct xfs_attr_leafblock *save_leaf;
>  	struct xfs_attr3_icleaf_hdr drophdr;
>  	struct xfs_attr3_icleaf_hdr savehdr;
>  	struct xfs_attr_leaf_entry *entry;
> -- 
> 2.39.2
> 
