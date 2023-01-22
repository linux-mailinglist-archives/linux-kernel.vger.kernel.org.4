Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E3677172
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjAVSWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjAVSWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:22:30 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595651DBB6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 10:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674411742; bh=G6basNI+cGfC3xf2QmqV9FLtY71hlHZTIWWsWpMT/pM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=PazcGRFEVIta7DGoklCdlfbcG2S3U8rRiPyX/AmibmfakRtwaFrIrrW1bMWhndlI+
         nhqSWO4GCuU/3wseipVVnDO1qsfWb7yAfLMStrsJBmOBOJ5V+u/N1yhjtRUFpeuo9w
         GVRhLKdK3CWIa/TxHLDqopeWgdZa5Pnr26/HbJsc=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 22 Jan 2023 19:22:22 +0100 (CET)
X-EA-Auth: ZtbcX1FW5ED5yK7LT+dHFriGQz9zsqlbyX7i7c9N7iM/uItxpVrHWwbTtEzTmgnsj0wwMaV/LaCjZM1pl2bILMhmhIA4NKLL
Date:   Sun, 22 Jan 2023 23:52:18 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] drm/sti: Avoid full proxy f_ops for sti debug attributes
Message-ID: <Y81+2gAtmPW2n0gS@ubun2204.myguest.virtualbox.org>
References: <Y73IdsbXhB5aUrkP@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y73IdsbXhB5aUrkP@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 01:50:06AM +0530, Deepak R Varma wrote:
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
> ---
> Note: Change cross compile tested using stm32_defconfig for arm

Hello,
Is there a feedback/comment on this patch proposal please? Let me know if I
should resend it.

Thank you,
./drv

> 
>  drivers/gpu/drm/sti/sti_drv.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
> index ef6a4e63198f..c9be82043638 100644
> --- a/drivers/gpu/drm/sti/sti_drv.c
> +++ b/drivers/gpu/drm/sti/sti_drv.c
> @@ -67,8 +67,8 @@ static int sti_drm_fps_set(void *data, u64 val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(sti_drm_fps_fops,
> -			sti_drm_fps_get, sti_drm_fps_set, "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(sti_drm_fps_fops,
> +			 sti_drm_fps_get, sti_drm_fps_set, "%llu\n");
>  
>  static int sti_drm_fps_dbg_show(struct seq_file *s, void *data)
>  {
> @@ -97,8 +97,8 @@ static void sti_drm_dbg_init(struct drm_minor *minor)
>  				 ARRAY_SIZE(sti_drm_dbg_list),
>  				 minor->debugfs_root, minor);
>  
> -	debugfs_create_file("fps_show", S_IRUGO | S_IWUSR, minor->debugfs_root,
> -			    minor->dev, &sti_drm_fps_fops);
> +	debugfs_create_file_unsafe("fps_show", S_IRUGO | S_IWUSR, minor->debugfs_root,
> +				   minor->dev, &sti_drm_fps_fops);
>  
>  	DRM_INFO("%s: debugfs installed\n", DRIVER_NAME);
>  }
> -- 
> 2.34.1
> 
> 
> 


