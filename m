Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A6B691A57
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjBJIv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjBJIvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:51:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0F681865;
        Fri, 10 Feb 2023 00:51:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22CEF61CD0;
        Fri, 10 Feb 2023 08:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79321C433EF;
        Fri, 10 Feb 2023 08:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676019078;
        bh=JI8cHUgyTEkDE3ilV5VF4UR3pyD3wXeZHeBRXfSLD6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLEbnvlA8kYZJfWzus1+1zcYHLQO8pPaBtuHo9tr8tGLSchpQ4nJs/o/YJ+BxT9k6
         I19l8JRqnWmWDDdpP3HLh9+mhjF2jThlvw38hedr43mTZOdIXAk7fFPJwUmWM3r/T+
         xP6oi4iTcGRPQKDnvU7UBKqzuWdJ9nGgncnZ/AyTmQPDQK5esd+CCnTTqYziY12gF5
         foGBlWyVRNR3KUSc87oLF06FgmdMCd/QJdDT+WLrnbKw8/Pq2bNAfBdAxvzz8MApIK
         yExEj+6QtiWtytG2ew/cTfM88OtoaWFccfO+vSCflcVHNN8i32FM+IidKdZh2YtCSk
         hubrQF3LjRvWw==
Date:   Fri, 10 Feb 2023 16:51:08 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] USB: chipidea: fix memory leak with using
 debugfs_lookup()
Message-ID: <20230210085108.GA1991028@nchen-desktop>
References: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-02 16:32:23, Greg Kroah-Hartman wrote:
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  To make things simpler, just
> call debugfs_lookup_and_remove() instead which handles all of the logic
> at once.
> 
> Cc: Peter Chen <peter.chen@kernel.org>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Peter Chen <peter.chen@kernel.org>
> ---
>  drivers/usb/chipidea/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/debug.c b/drivers/usb/chipidea/debug.c
> index faf6b078b6c4..bbc610e5bd69 100644
> --- a/drivers/usb/chipidea/debug.c
> +++ b/drivers/usb/chipidea/debug.c
> @@ -364,5 +364,5 @@ void dbg_create_files(struct ci_hdrc *ci)
>   */
>  void dbg_remove_files(struct ci_hdrc *ci)
>  {
> -	debugfs_remove(debugfs_lookup(dev_name(ci->dev), usb_debug_root));
> +	debugfs_lookup_and_remove(dev_name(ci->dev), usb_debug_root);
>  }
> -- 
> 2.39.1
> 

-- 

Thanks,
Peter Chen
