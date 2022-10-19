Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC89604237
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiJSK4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbiJSK4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF00165521
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666175181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PzoUhWIK85kptE51uwz51om5WE1Ga9wjKYqu8XEkG+g=;
        b=NxS53nBmd5bswCbyPvvOaDfhgnf6JAPy3tXh35hPQeodxwqQeidWszn/TuvhM9FKjClKms
        MUUrNYljcya4I+SCbS8R7IVl1NVyLpAQ5ZWcUXcAIKAKWw/eXJ+ShbpVvL8Id0YJoXbirO
        dKIEb2QoIvZ9AlzHc3OZ4f0+A07zaJs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-170-oHqoSswzNDuV-HBoODmITw-1; Wed, 19 Oct 2022 05:11:55 -0400
X-MC-Unique: oHqoSswzNDuV-HBoODmITw-1
Received: by mail-wm1-f70.google.com with SMTP id c5-20020a1c3505000000b003c56da8e894so12669900wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzoUhWIK85kptE51uwz51om5WE1Ga9wjKYqu8XEkG+g=;
        b=kpp4P7OEDij+JwaSklcoyYGtVooUtuQjiiVULyh9mH7wrt7GghoPvpd/LV6MJBSrdu
         RkMhvTOA8VDf131/Y2iK5vjxOJRVTPJ7UfyqhX05anArjCfneIngPywLEgrMcWY8b2l2
         rQRKxGrxFNQRnBhKyTYuDsRRWwz/iOioiXzT308R096P5uiEYe4qgTNXrsQXrwqK2RAO
         gLcctRox5rI95k/q9N3AOAtMPJtMVHTRBBSSvINus4Jaw1dMKxML9UDP62lRtjwuA36/
         8fhyJ+LjIb3ODFQRReQcAYU7UjKtm0jFeUZ2PpmcRyK46CnRreZiGgY1cJ9327H39yb2
         /MBQ==
X-Gm-Message-State: ACrzQf19pUuqBGMVIA0ZwG4PesZreLg6XuwHtOCFSI79TzRXMLHrnhmf
        AyK2Bis2O4gCRodiS91WhBi558z51lowpERytaHktJsOIEG+M88GKd9LoLn8egpbjY8pgUX5Cvz
        N6HuEPTCf/p+scA8iJk9jdRPA
X-Received: by 2002:a05:6000:61b:b0:231:1b8:172 with SMTP id bn27-20020a056000061b00b0023101b80172mr4512257wrb.372.1666170714596;
        Wed, 19 Oct 2022 02:11:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM68dtRViiZRaJ2Mw/iENBUTiMMftQBXt+Pg2pPJCiTsXdeAp5L34FEE/x++Dw8oYYL5ADnIEg==
X-Received: by 2002:a05:6000:61b:b0:231:1b8:172 with SMTP id bn27-20020a056000061b00b0023101b80172mr4512236wrb.372.1666170714206;
        Wed, 19 Oct 2022 02:11:54 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d550a000000b0022860e8ae7csm12939391wrv.77.2022.10.19.02.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 02:11:53 -0700 (PDT)
Message-ID: <845a6797-d71b-33b3-5ee4-358d227e19d6@redhat.com>
Date:   Wed, 19 Oct 2022 11:11:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] drm/tiny: add support for tft displays based on
 ilitek, ili9488
Content-Language: en-US
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     michael@amarulasolutions.com,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>, linuxfancy@googlegroups.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        kamlesh.gurudasani@gmail.com, linux-amarula@amarulasolutions.com
References: <20221018164532.1705215-1-tommaso.merciai@amarulasolutions.com>
 <20221018164532.1705215-3-tommaso.merciai@amarulasolutions.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221018164532.1705215-3-tommaso.merciai@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tommaso,

On 10/18/22 18:45, Tommaso Merciai wrote:

[...]

> +config TINYDRM_ILI9488
> +	tristate "DRM support for ILI9488 display panels"
> +	depends on DRM && SPI
> +	select DRM_KMS_HELPER
> +	select DRM_GEM_CMA_HELPER
> +	select DRM_MIPI_DBI
> +	select BACKLIGHT_CLASS_DEVICE
> +	help
> +	  DRM driver for the following Ilitek ILI9488 panels:
> +	  * LCD 3.5" 320x480 TFT (Waveshare Pico-ResTouch-LCD-3.5")
> +
> +	  If M is selected the module will be called ili9486.
> +

Typo here, should be ili9488.

[...]

> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_damage_helper.h>
> +#include <drm/drm_framebuffer.h>
> +#include <drm/drm_gem_atomic_helper.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_managed.h>
> +#include <drm/drm_mipi_dbi.h>
> +#include <drm/drm_modeset_helper.h>
> +

Please sort these alphabetically

> +
> +static void ili9488_rgb565_to_rgb666_line(u8 *dst, u16 *sbuf,
> +					  unsigned int pixels)
> +{
> +	unsigned int x;
> +
> +	for (x = 0; x < pixels; x++) {
> +		*dst++ = ((*sbuf & 0xF800) >> 8);
> +		*dst++ = ((*sbuf & 0x07E0) >> 3);
> +		*dst++ = ((*sbuf & 0x001F) << 3);
> +		sbuf++;
> +	}
> +}
> +

If these format conversions helpers are really needed, they need to be
added as helpers to drivers/gpu/drm/drm_format_helper.c instead.

> +static void ili9488_rgb565_to_rgb666(u8 *dst, void *vaddr,
> +				     struct drm_framebuffer *fb,
> +				     struct drm_rect *rect)
> +{
> +	unsigned long linepixels = drm_rect_width(rect);
> +	unsigned long lines = drm_rect_height(rect);
> +	size_t dst_len = linepixels * 3;
> +	size_t src_len = linepixels * fb->format->cpp[0];
> +	unsigned int y;
> +	u16 *sbuf;
> +
> +	/*
> +	 * The cma memory is write-combined so reads are uncached.
> +	 * Speed up by fetching one line at a time.
> +	 */
> +	sbuf = kmalloc(src_len, GFP_KERNEL);
> +	if (!sbuf)
> +		return;

This will cause an extra copy even when CMA isn't used. Please take a look
how the format helpers do this. You should pass a struct iosys_map param
and internally use the drm_fb_xfrm() helper that would handle both the I/O
mem and system memory cases.

> +static int ili9488_buf_copy(void *dst, struct drm_framebuffer *fb,
> +			    struct drm_rect *rect)
> +{
> +	struct drm_gem_cma_object *cma_obj = drm_fb_cma_get_gem_obj(fb, 0);
> +	void *src = cma_obj->vaddr;
> +	int ret = 0;
> +
> +	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
> +	if (ret)
> +		return ret;
> +

If you rebase on top of the "[PATCH 0/5] drm: Add new plane helpers to
begin/end FB access" series then an explicit CPU access to GEM BOs sync
isn't needed anymore:

https://lore.kernel.org/dri-devel/20221017111510.20818-1-tzimmermann@suse.de/


> +	switch (fb->format->format) {
> +	case DRM_FORMAT_RGB565:
> +		ili9488_rgb565_to_rgb666(dst, src, fb, rect);

This is the biggest issue I see with this driver. The exported format is
RGB565 but RGB666 is used. I believe the policy is for the driver to expose
the native format to user-space.

I know that there isn't a DRM_FORMAT_RGB666 in neither DRM nor mesa, but
still I think that adding it should be part of this series. If you also
want to expose DRM_FORMAT_RGB565 for compatibility reasons, then I guess
that's OK but as mentioned the format helpers need to be in the DRM core.

[...]

> +static void ili9488_fb_dirty(struct drm_framebuffer *fb, struct drm_rect *rect)
> +{

This looks very similar, if not the same than the mipi_dbi_fb_dirty() helper.

[...]

> +static void ili9488_pipe_update(struct drm_simple_display_pipe *pipe,
> +			       struct drm_plane_state *old_state)
> +{

And same for this, it's basically mipi_dbi_pipe_update() if you end using the
mipi_dbi_fb_dirty() helper instead of a custom ili9488_fb_dirty() handler.

> +	struct drm_plane_state *state = pipe->plane.state;
> +	struct drm_rect rect;
> +
> +	if (!pipe->crtc.state->active)
> +		return;
> +
> +	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
> +		ili9488_fb_dirty(state->fb, &rect);

I see that most MIPI DBI drivers use this function to merge all the damage clips
into a big rectangle. Is there a reason why this is done in this way rather than
just iterating over all the damage areas and update them one by one?

Since for example there are multiple damage clips that aren't close to each other,
the resulting rectangle could be quite big.

[...]

> +DEFINE_DRM_GEM_CMA_FOPS(ili9488_fops);
> +

Do you really need CMA for this? Can't you just use DEFINE_DRM_GEM_FOPS() instead?

> +static struct drm_driver ili9488_driver = {
> +	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
> +	.fops			= &ili9488_fops,
> +	DRM_GEM_CMA_DRIVER_OPS_VMAP,

	DRM_GEM_SHMEM_DRIVER_OPS, ?

> +	.debugfs_init		= mipi_dbi_debugfs_init,
> +	.name			= "ili9488",
> +	.desc			= "Ilitek ILI9488",
> +	.date			= "20221017",
> +	.major			= 1,
> +	.minor			= 0,
> +};
> +
> +static const struct of_device_id ili9488_of_match[] = {
> +	{ .compatible = "waveshare,pico-rt-lcd-35" },
> +	{ }
> +};

Do you really need to make the compatible that specific? I would just have an entry
for "ilitek,ili9488".

> +MODULE_DEVICE_TABLE(of, ili9488_of_match);
> +
> +static const struct spi_device_id ili9488_id[] = {
> +	{ "ili9488", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ili9488_id);
> +

The fact that this doesn't match the OF compatible string would break module auto
loading. Because the SPI core doesn't report an OF module alias, but always a SPI
alias regardless whether the device was registered using Device Trees or not.

[...]

> +	dbi->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(dbi->reset)) {
> +		DRM_DEV_ERROR(dev, "Failed to get gpio 'reset'\n");
> +		return PTR_ERR(dbi->reset);
> +	}

You could use dev_err_probe() instead. And same in other places.

> +static void ili9488_remove(struct spi_device *spi)
> +{
> +	struct drm_device *drm = spi_get_drvdata(spi);
> +
> +	drm_dev_unplug(drm);
> +	drm_atomic_helper_shutdown(drm);

I believe drm_atomic_helper_shutdown() isn't needed here since is done already
in ili9488_shutdown().

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

