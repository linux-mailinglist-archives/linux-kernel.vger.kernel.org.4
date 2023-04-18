Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A49C6E5596
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 02:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjDRAIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 20:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDRAIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 20:08:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241ED2D50;
        Mon, 17 Apr 2023 17:08:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B52C0624BA;
        Tue, 18 Apr 2023 00:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4C6C433EF;
        Tue, 18 Apr 2023 00:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681776494;
        bh=Yb0irSBXw7t2Gz7uoAYA8W4twG36M0KbteVS8Ot9JOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KlF3IPnltglebQejcAINn7CSFumTAN+uisU/H+Bbs0gW17oebxb0pU1sU9gNzm596
         coAoF+pB2346rN0wcSHNsTT1iLUjv5a+p3WBH6rN5RiHaoTb76YWD6bOxsGF8VeG9j
         6x4JweJ4m2tIEKO6jqzszRPAv2c62s7A2eWte5nLoppkfmQejBtezaBG2K2nr4JbgR
         j0lZc0HMN77xyKsElGgYT1/rJwzMk6n8WANIt4jyZfQ6JlbvL+yMsitZZHBbHpi5Tl
         oFOThGjyczHD41tg0Nocp1cus+paF+r1mIDiAuRHk2ryi5owPuC/IbP5+ZVY9gWX/Y
         7Mdh1GYRuGHMQ==
Date:   Mon, 17 Apr 2023 17:08:13 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     dchinner@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: scrub: remove duplicate include headers
Message-ID: <20230418000813.GB360889@frogsfrogsfrogs>
References: <202304171613075788124@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202304171613075788124@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 04:13:07PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> xfs_trans_resv.h and xfs_mount.h are included more than once.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  fs/xfs/scrub/health.c   | 2 --
>  fs/xfs/scrub/refcount.c | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/fs/xfs/scrub/health.c b/fs/xfs/scrub/health.c
> index d2b2a1cb6533..66e99b0f6049 100644
> --- a/fs/xfs/scrub/health.c
> +++ b/fs/xfs/scrub/health.c
> @@ -7,8 +7,6 @@
>  #include "xfs_fs.h"
>  #include "xfs_shared.h"
>  #include "xfs_format.h"
> -#include "xfs_trans_resv.h"
> -#include "xfs_mount.h"
>  #include "xfs_btree.h"
>  #include "xfs_trans_resv.h"
>  #include "xfs_mount.h"

The convention (AFAICT) for include order is xfs_trans_resv -> xfs_mount
-> xfs_btree.h...

> diff --git a/fs/xfs/scrub/refcount.c b/fs/xfs/scrub/refcount.c
> index ed5eb367ce49..04d216261f36 100644
> --- a/fs/xfs/scrub/refcount.c
> +++ b/fs/xfs/scrub/refcount.c

Please check the list before sending duplicate diffs.

--D

> @@ -7,8 +7,6 @@
>  #include "xfs_fs.h"
>  #include "xfs_shared.h"
>  #include "xfs_format.h"
> -#include "xfs_trans_resv.h"
> -#include "xfs_mount.h"
>  #include "xfs_btree.h"
>  #include "xfs_rmap.h"
>  #include "xfs_refcount.h"
> -- 
> 2.25.1
