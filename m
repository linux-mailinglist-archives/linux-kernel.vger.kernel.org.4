Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E81562B014
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 01:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiKPAgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 19:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKPAgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:36:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AFA2A73F;
        Tue, 15 Nov 2022 16:36:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E53426176B;
        Wed, 16 Nov 2022 00:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32545C433C1;
        Wed, 16 Nov 2022 00:36:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=fail reason="signature verification failed" (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WadNeQqZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668558963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xxwhZ1JbZLEFT7v8XmPjo2GDV7ahuoimNewbxe4SHR4=;
        b=WadNeQqZfpaaG7pOGoOZegG56N+tU7vmniNRsbAnAmvOFql3UgnmZlGF3jkwAg0KYUuJnl
        vPO1x3/+Yd1mV8BLHiLJBtr7DWgWQX74GhaPD5R6gjrXeuQpkaV6S8JqLBhF8HcPiQAIeF
        giEdXmUZGn2q93G/kA+FleaT4qgoh6w=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 151f81bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Nov 2022 00:36:03 +0000 (UTC)
Date:   Wed, 16 Nov 2022 01:36:00 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     dri-devel@lists.freedesktop.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Christian Brauner <brauner@kernel.org>,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        Alex Deucher <alexdeucher@gmail.com>,
        Adam Jackson <ajax@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] drm/atomic: do not branch based on the value of
 current->comm[0]
Message-ID: <Y3QwcKEVTg8hu2WA@zx2c4.com>
References: <20221105222012.4226-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221105222012.4226-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I'm a bit surprised that this patch was ignored. I had sort of assumed
the response would be, "good god, I can't believe we're doing this.
Applied to drm-next!" rather than crickets, but maybe it just got buried
under a lot of other patches. So I thought I'd poke about this again.
The original message is reproduced in full below.

Regards,
Jason

On Sat, Nov 05, 2022 at 11:20:12PM +0100, Jason A. Donenfeld wrote:
> This reverts 26b1d3b527e7 ("drm/atomic: Take the atomic toys away from
> X"), a rootkit-like kludge that has no business being inside of a
> general purpose kernel. It's the type of debugging hack I'll use
> momentarily but never commit, or a sort of babbies-first-process-hider
> malware trick.
> 
> The backstory is that some userspace code -- xorg-server -- has a
> modesetting DDX that isn't really coded right. With nobody wanting to
> maintain X11 anymore, rather than fixing the buggy code, the kernel was
> adjusted to avoid having to touch X11. A bummer, but fair enough: if the
> kernel doesn't want to support some userspace API any more, the right
> thing to do is to arrange for a graceful fallback where userspace thinks
> it's not available in a manageable way.
> 
> However, the *way* it goes about doing that is just to check
> `current->comm[0] == 'X'`, and disable it for only that case. So that
> means it's *not* simply a matter of the kernel not wanting to support a
> particular userspace API anymore, but rather it's the kernel not wanting
> to support xorg-server, in theory, but actually, it turns out, that's
> all processes that begin with 'X'.
> 
> Playing games with current->comm like this is obviously wrong, and it's
> pretty shocking that this ever got committed.
> 
> Fortunately, since this was committed, somebody did actually disable
> the userspace side by default in X11:
> https://gitlab.freedesktop.org/xorg/xserver/-/merge_requests/180 and
> this was three years ago. So userspace is mostly fine now for ordinary
> default usage. And people who opt into this -- since it does actually
> work fine for many use cases on i915 -- ostensibly know what they're
> getting themselves into (my case).
> 
> So let's just revert this `comm[0] == 'X'` business entirely, but still
> allow for `value == 2`, in case anybody actually started working on that
> part elsewhere.
> 
> Fixes: 26b1d3b527e7 ("drm/atomic: Take the atomic toys away from X")
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ilia Mirkin <imirkin@alum.mit.edu>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Michel Dänzer <michel@daenzer.net>
> Cc: Alex Deucher <alexdeucher@gmail.com>
> Cc: Adam Jackson <ajax@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Sultan Alsawaf <sultan@kerneltoast.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/gpu/drm/drm_ioctl.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index ca2a6e6101dc..017f31e67179 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -336,11 +336,6 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
>  	case DRM_CLIENT_CAP_ATOMIC:
>  		if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
>  			return -EOPNOTSUPP;
> -		/* The modesetting DDX has a totally broken idea of atomic. */
> -		if (current->comm[0] == 'X' && req->value == 1) {
> -			pr_info("broken atomic modeset userspace detected, disabling atomic\n");
> -			return -EOPNOTSUPP;
> -		}
>  		if (req->value > 2)
>  			return -EINVAL;
>  		file_priv->atomic = req->value;
> -- 
> 2.38.1
> 
