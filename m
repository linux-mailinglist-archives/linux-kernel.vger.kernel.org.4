Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3556016CB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJQTAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiJQTAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:00:34 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E893DEC6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=KaiF/SCfWzsRvXRBubrvLDOWGhfVrO/hXf7iRdDzGmk=; b=sHtai
        yqAEg9DkUpwrXBnspJ5VZMuZQYaZ85XTaLkxgnHhfTQX2I30OjhPcYuA3AuXZDtMwnIFhYyQAXt2N
        18wzcdV8ZRPLAxg+4proMrSifd0wnRENgY5rwQnZ1qTqv0RJxf6Br/K3HPIShZkClZU6+xHRtsTht
        bNCdWtd6sf2ipr6EFhyxr0e8wN4ruwhobn7jZPeUA/pNszAz1JqpGrGd6HQktfLpmFMLBq74H2+gu
        eOstzi+9GjOYkMAdpaNHU1XeExVa9bHTQQJa4zmcBnMPrc0KBqiQR1NYU+iIl+wqnl9dcB7fFzRC9
        iaHWgHFF4q11A/ryHRFmhlWnHesrg==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1okVLZ-0006Sk-25;
        Mon, 17 Oct 2022 20:00:22 +0100
Date:   Mon, 17 Oct 2022 20:00:21 +0100
From:   John Keeping <john@metanate.com>
To:     Johan Jonker <jbx6244@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [BUG] [PATCH] drm/rockchip: use generic fbdev setup
Message-ID: <Y02mRUuecw2C1i+h@donbot>
References: <20211029115014.264084-1-john@metanate.com>
 <d814394b-86c3-beb1-ddd4-04c65004f138@gmail.com>
 <Y00o3M7SKAB/w9sW@donbot>
 <2220890.jZfb76A358@phil>
 <c4bf7723-b3b8-0955-5ba3-e4d05bdc835a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4bf7723-b3b8-0955-5ba3-e4d05bdc835a@gmail.com>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 08:30:23PM +0200, Johan Jonker wrote:
> 
> 
> On 10/17/22 13:29, Heiko Stuebner wrote:
> > Am Montag, 17. Oktober 2022, 12:05:16 CEST schrieb John Keeping:
> >> Hi Johan,
> >>
> >> On Mon, Oct 17, 2022 at 10:11:32AM +0200, Johan Jonker wrote:
> >>> Your patch contribution causes a kernel panic on MK808 with Rockchip rk3066a SoC.
> >>> Would you like to contribute to fix this issue?
> >>> The assumtion that drm_fbdev_generic_setup() does what rockchip_drm_fbdev_init did is not true!
> >>> A revert makes it work again.
> >>
> 
> >> It looks like there are 3 different ways to end up with -ENOMEM here,
> >> can you track down whether you're hitting one of the cases in
> >> rockchip_gem_prime_vmap() or if it's the iosys_map_is_null case in
> >> drm_gem_vmap()?
> 
> It looks like it comes from rockchip_gem_prime_vmap() second return (2).
> 
> 
> 	if (rk_obj->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
> 
> ////////////////
> 
> 		printk("FBDEV rockchip_gem_prime_vmap 2");
> 
> ////////////////
> 		return -ENOMEM;
> 	}

Ah-ha, Heiko was right that this is because the no-iommu path is broken
as a result of switching to the generic fbdev code.

This patch should fix it, but I wonder if Thomas has any ideas about a
better way to handle this since it feels a bit hacky to special-case the
fb_helper inside the GEM code:

-- >8 --
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 614e97aaac80..da8a69953706 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -364,9 +364,12 @@ rockchip_gem_create_with_handle(struct drm_file *file_priv,
 {
 	struct rockchip_gem_object *rk_obj;
 	struct drm_gem_object *obj;
+	bool is_framebuffer;
 	int ret;
 
-	rk_obj = rockchip_gem_create_object(drm, size, false);
+	is_framebuffer = drm->fb_helper && file_priv == drm->fb_helper->client.file;
+
+	rk_obj = rockchip_gem_create_object(drm, size, is_framebuffer);
 	if (IS_ERR(rk_obj))
 		return ERR_CAST(rk_obj);
-- 8< -- 
