Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DA1669BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjAMPZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjAMPZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:25:35 -0500
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:404::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EB110540
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=5Ec9VEpxL0HdQ3ys6pNHqMik91oFBgfMANcke80xD/A=;
        b=mNsL6p20VOs74QKIu8snpBt8lWcWR1uguGQk7ru7ofSMp35A1oCHYta7HJUwcGkPn561uhzGtVVJb
         YEwpoJYI/4DSAA9rsapANR3CEi09F9aHr9g5WxkajAP5W6jnF//3HmrSMDtPprhJVlOSbs6u1fVfXI
         +fRVLa8bFfuNyAYAn8oPQC16RAjHav49Z6s8lJU7F0qwlzMRQhTJnhj3j8SWLPQiZ2UhdCV86FnMA7
         +sxRCet5Cx5uBOySOCGPlr9jgr9tQUQzf7MbRfHdOS0wxSgByTW8EqYRNfe28hl8LH0r0p9Tjihwgn
         mW32T+trR0jdFN7na/nuSwgivwn/j9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=5Ec9VEpxL0HdQ3ys6pNHqMik91oFBgfMANcke80xD/A=;
        b=6cLlDT99AqkJuJaJoLKjJ3jWirKVmctGHXRyb6MZW9SNOTVHZRCTbGjd2HjbqxlOIr/XgibkTrpQj
         cH+L7k4DQ==
X-HalOne-ID: 5f693b70-9355-11ed-a136-7703b0afff57
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay5 (Halon) with ESMTPSA
        id 5f693b70-9355-11ed-a136-7703b0afff57;
        Fri, 13 Jan 2023 15:17:23 +0000 (UTC)
Date:   Fri, 13 Jan 2023 16:17:21 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Ondrej Jirman <megous@megous.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] drm/panel: st7703: Avoid full proxy f_ops for st7703
 debug attributes
Message-ID: <Y8F2AQdzVEdmeWGU@ravnborg.org>
References: <Y73JRnLQ3RHSwLiO@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y73JRnLQ3RHSwLiO@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 01:53:34AM +0530, Deepak R Varma wrote:
> Using DEFINE_SIMPLE_ATTRIBUTE macro with the debugfs_create_file()
> function adds the overhead of introducing a proxy file operation
> functions to wrap the original read/write inside file removal protection
> functions. This adds significant overhead in terms of introducing and
> managing the proxy factory file operations structure and function
> wrapping at runtime.
> As a replacement, a combination of DEFINE_DEBUGFS_ATTRIBUTE macro paired
> with debugfs_create_file_unsafe() is suggested to be used instead.  The
> DEFINE_DEBUGFS_ATTRIBUTE utilises debugfs_file_get() and
> debugfs_file_put() wrappers to protect the original read and write
> function calls for the debug attributes. There is no need for any
> runtime proxy file operations to be managed by the debugfs core.
> Following coccicheck make command helped identify this change:
> 
> make coccicheck M=drivers/gpu/drm/i915/ MODE=patch COCCI=./scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

Anyone up for testing this change?
I have never dealt with debugfs so dunno if the chnage will work or not.

	Sam

> ---
> Note: Patch compile tested only.
> 
>  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> index 86a472b01360..22ed7e2b0e00 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> @@ -510,15 +510,14 @@ static int allpixelson_set(void *data, u64 val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(allpixelson_fops, NULL,
> -			allpixelson_set, "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(allpixelson_fops, NULL, allpixelson_set, "%llu\n");
>  
>  static void st7703_debugfs_init(struct st7703 *ctx)
>  {
>  	ctx->debugfs = debugfs_create_dir(DRV_NAME, NULL);
>  
> -	debugfs_create_file("allpixelson", 0600, ctx->debugfs, ctx,
> -			    &allpixelson_fops);
> +	debugfs_create_file_unsafe("allpixelson", 0600, ctx->debugfs, ctx,
> +				   &allpixelson_fops);
>  }
>  
>  static void st7703_debugfs_remove(struct st7703 *ctx)
> -- 
> 2.34.1
> 
> 
