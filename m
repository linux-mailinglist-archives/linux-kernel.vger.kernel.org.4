Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCDD6FFD3D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbjEKXWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjEKXWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:22:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA925BA9;
        Thu, 11 May 2023 16:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 775BD6524D;
        Thu, 11 May 2023 23:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B0FC433EF;
        Thu, 11 May 2023 23:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683847326;
        bh=eZGu5MJPJ9fXCT6mKVeohpImVi3IXtivEBhSPsiKHOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g/p0s/80BuG8QS2NbcgoYi5bEDDMQbmnm/6jBTKkXUW30ndqoiy26r6sptZIfP5rM
         YpehZ9P9+CPEe5e9iR3XDrKFCrUgPzzVzpOCHo5cZyGbCYYAS9ctngU711QfUHdMJo
         /8MUgZ7sW7EXte1mhmAGcyefc3buoWgPnQNU9NZVcKvLLPdgL5khJkIvof0ON7I8Eq
         J8vAIcuuHY4f4hL5Z0F8adnk5cAZ9DKXsARBm1lcHcmlvUAJFSPqVs+7XSTWGkFpNM
         03bHzQhgCcFuknqKjJ3otUE1N+o9mVg9/rGE+SptXHC4fFXIXlu9gBBjxTCDPzhV2+
         iIgj9GrCQ6joA==
Date:   Thu, 11 May 2023 16:22:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     renlei1@chinatelecom.cn
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: xfs_nfs_get_inode support zero generation
Message-ID: <20230511232206.GG858799@frogsfrogsfrogs>
References: <1683800241-14488-1-git-send-email-renlei1@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683800241-14488-1-git-send-email-renlei1@chinatelecom.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 06:17:21PM +0800, renlei1@chinatelecom.cn wrote:
> From: Ren Lei <renlei1@chinatelecom.cn>
> 
> If generation is zero, bypass the verification of generation number
> to avoid stale file error. (Be consistent with other fs, such as
> ext4, fat, jfs, etc.)

What code is affected by the gen==0 handles being rejected?  Is there a
user program or test case where this is required?

--D

> Signed-off-by: Ren Lei<renlei1@chinatelecom.cn>
> ---
>  fs/xfs/xfs_export.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_export.c b/fs/xfs/xfs_export.c
> index 1064c2342876..cbee32c5ad37 100644
> --- a/fs/xfs/xfs_export.c
> +++ b/fs/xfs/xfs_export.c
> @@ -146,7 +146,7 @@ xfs_nfs_get_inode(
>  		return ERR_PTR(error);
>  	}
>  
> -	if (VFS_I(ip)->i_generation != generation) {
> +	if (generation && VFS_I(ip)->i_generation != generation) {
>  		xfs_irele(ip);
>  		return ERR_PTR(-ESTALE);
>  	}
> -- 
> 2.27.0
> 
