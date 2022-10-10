Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F395FA309
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJJR5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJJR5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C74F77E8C;
        Mon, 10 Oct 2022 10:57:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1BD760AFE;
        Mon, 10 Oct 2022 17:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124E7C433D6;
        Mon, 10 Oct 2022 17:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665424631;
        bh=M7074iTkISJ9LZPDfVJMFnThIn/SiCbzfEecQjj1gX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iHHSQuNIjuhNfzwXDqX4y6wVGUARVjPgaMXSpcDwbQg6wd1xcBPk8tUn+23GqWF0a
         HBRYrsSUShKP5LhuxNbclbJRMbkDTqwcYUR7xiw5Mu2JT+2z3LUCD0mUAnerLzWzLb
         7GIVoEEQgIawZLEBtvxdk5Vs7e22tpI8HMc0XHFXMcwJiahqMpLXPSJ7Y6DXZD1U/i
         TegnKNLRcIqr9A6Xk40RW89Dg3RQKg4f48t52B0ZcECoJa6IymRyLFHF8RshVqCMZ7
         cXs5WgkCScM/laaRTMpOFr+UQqAeuu2LlZfo9FVLU4/bL91NekNHWvikAleJnM549y
         vYfki7gdqcFjw==
Date:   Mon, 10 Oct 2022 10:57:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-xfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] xfs: remove redundant pointer lip
Message-ID: <Y0Rc9ulPUJb77up6@magnolia>
References: <20221010160515.3199641-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010160515.3199641-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 05:05:15PM +0100, Colin Ian King wrote:
> The assignment to pointer lip is not really required, the pointer lip
> is redundant and can be removed.
> 
> Cleans up clang-scan warning:
> warning: Although the value stored to 'lip' is used in the enclosing
> expression, the value is never actually read from 'lip'
> [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Looks good!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> 
> V2: Keep != NULL comparison for stylistic reasons, as suggested by
>     Darrick J. Wong
> ---
>  fs/xfs/xfs_trans_ail.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> index 16fbf2a1144c..87db72758d1f 100644
> --- a/fs/xfs/xfs_trans_ail.c
> +++ b/fs/xfs/xfs_trans_ail.c
> @@ -730,11 +730,10 @@ void
>  xfs_ail_push_all_sync(
>  	struct xfs_ail  *ailp)
>  {
> -	struct xfs_log_item	*lip;
>  	DEFINE_WAIT(wait);
>  
>  	spin_lock(&ailp->ail_lock);
> -	while ((lip = xfs_ail_max(ailp)) != NULL) {
> +	while (xfs_ail_max(ailp) != NULL) {
>  		prepare_to_wait(&ailp->ail_empty, &wait, TASK_UNINTERRUPTIBLE);
>  		wake_up_process(ailp->ail_task);
>  		spin_unlock(&ailp->ail_lock);
> -- 
> 2.37.3
> 
