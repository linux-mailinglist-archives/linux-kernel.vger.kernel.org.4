Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5D272CA8C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbjFLPpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239655AbjFLPpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:45:01 -0400
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [46.30.211.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2B119C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=7bu+0WMycvl+xw/+UyWKXzBeoyi+ITWwP8OmM2m6w3U=;
        b=J+MAAjazh0cqG8FTxXFAYorKfEJAfsolz5nI559Jg1dYWl+zBGxsqkJ6L6BZ/ycEKGG0o5rYcqZCD
         kcppxqP96zS8pZRaW0AlxvZQddFQJ4FGG8xh7nLabP5jmbEiTmFPIxHZwE66kmSW9gc21kidZ3Sw6Q
         kSVUE8Jr9ytkg1ujf3zUjU3RDlwieTz5o2Yaq49RAUoHl1oR4/a72L8kbTgORoVdZxXVv+FHfJyCyU
         HBI5Dd92Attjse05uyKed0VvezEULHVIIhucSdj9Ses6OcByYncWv07UpbFe13TuZlfWCmJSGiQHmp
         Cu6rXjFgT0n7g5Qrp36lNE7Xhnc7BgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=7bu+0WMycvl+xw/+UyWKXzBeoyi+ITWwP8OmM2m6w3U=;
        b=IC1PPDdgBDKI7zq8IJwwQGlbYUO3D4efEtYXAJFdx3LdaekNytlsyGPtFvhCi4WXxtdmi0mW6gEQ9
         tHIWDuxDw==
X-HalOne-ID: ef9b6055-0937-11ee-91ee-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id ef9b6055-0937-11ee-91ee-b90637070a9d;
        Mon, 12 Jun 2023 15:43:56 +0000 (UTC)
Date:   Mon, 12 Jun 2023 17:43:54 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, javierm@redhat.com, deller@gmx.de,
        geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 34/38] fbdev/core: Add fb_device_{create,destroy}()
Message-ID: <20230612154354.GA1243864@ravnborg.org>
References: <20230612141352.29939-1-tzimmermann@suse.de>
 <20230612141352.29939-35-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612141352.29939-35-tzimmermann@suse.de>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 04:08:12PM +0200, Thomas Zimmermann wrote:
> Move the logic to create and destroy fbdev devices into the new
> helpers fb_device_create() and fb_device_destroy().
> 
> There was a call to fb_cleanup_device() in do_unregister_framebuffer()
> that was too late. The device had already been removed at this point.
> Move the call into fb_device_destroy().
> 
> Declare the helpers in the new internal header file  fb_internal.h, as
> they are only used within the fbdev core module.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
