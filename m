Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E487D6362E7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbiKWPJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238299AbiKWPIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:08:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0711F63160;
        Wed, 23 Nov 2022 07:08:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 371BEB82096;
        Wed, 23 Nov 2022 15:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56599C433D6;
        Wed, 23 Nov 2022 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669216084;
        bh=WLXFnRRwAGSB6144++E7djuO+TN+sZS/XitCX2fAGgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TG/g2GBNIgALQ5wN0e7SltfaGtNUnCLJ4tyf5qe6uQ5+MbiK+cD1wi657xD/BIUEB
         CG+UXgA9PMKXtbZp1C2/A/mO5p3IAw8lYD3+jt+t283E7aalR0c3smvT62zCNrAtnX
         1ivquwrWVIhD54Y1FcbDNoo/E0bVzCk9kMS2Ov7Haz3ukZkKg05zLfGETYiLRbFXww
         NtmKrARu8OD+0ZRSAQUuri8TQn7V77A49zWffoSq6LVnp+DaR/E0V8R9JRXyoGNt92
         3DbPYMJG/1akWttP5fwCshqoMLtUm+QMHEZWaaAAkB3tKwp1uA/39TsJWpLJjNXiQl
         eHjl8jTYlAyCQ==
Date:   Wed, 23 Nov 2022 22:58:11 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Hsia-Jun Li <randy.li@synaptics.com>
Cc:     dri-devel@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        ezequiel@vanguardiasur.com.ar, helen.koike@collabora.com,
        laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mchehab@kernel.org, mripard@kernel.org, nicolas@ndufresne.ca,
        ribalda@chromium.org, sakari.ailus@linux.intel.com,
        sebastian.hesselbarth@gmail.com, tfiga@chromium.org,
        tzimmermann@suse.de, ayaka@soulik.info
Subject: Re: [PATCH v4] drm/fourcc: Add Synaptics VideoSmart tiled modifiers
Message-ID: <Y341AxDwqRC/0eep@xhacker>
References: <20221123091957.75967-1-randy.li@synaptics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221123091957.75967-1-randy.li@synaptics.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 05:19:57PM +0800, Hsia-Jun Li wrote:
> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
> 
> Memory Traffic Reduction(MTR) is a module in Synaptics
> VideoSmart platform could process lossless compression image
> and cache the tile memory line.
> 
> Those modifiers only record the parameters would effort pixel
> layout or memory layout. Whether physical memory page mapping
> is used is not a part of format.
> 
> We would allocate the same size of memory for uncompressed
> and compressed luma and chroma data, while the compressed buffer
> would request two extra planes holding the metadata for
> the decompression.
> 
> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> ---
>  include/uapi/drm/drm_fourcc.h | 75 +++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index bc056f2d537d..ca0b4ca70b36 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -407,6 +407,7 @@ extern "C" {
>  #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
>  #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
>  #define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
> +#define DRM_FORMAT_MOD_VENDOR_SYNAPTICS 0x0b

Any users in the mainline tree?

>  
>  /* add more to the end as needed */
>  
> @@ -1507,6 +1508,80 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
>  #define AMD_FMT_MOD_CLEAR(field) \
>  	(~((__u64)AMD_FMT_MOD_##field##_MASK << AMD_FMT_MOD_##field##_SHIFT))
>  
> +/*
> + * Synaptics VideoSmart modifiers
> + *
> + * Tiles could be arranged in Groups of Tiles (GOTs), it is a small tile
> + * within a tile. GOT size and layout varies based on platform and
> + * performance concern. When the compression is applied, it is possible
> + * that we would have two tile type in the GOT, these parameters can't
> + * tell the secondary tile type.
> + *
> + * Besides, an 8 size 4 bytes arrary (32 bytes) would be need to store
> + * some compression parameters for a compression meta data plane.
> + *
> + *       Macro
> + * Bits  Param Description
> + * ----  ----- -----------------------------------------------------------------
> + *
> + *  7:0  f     Scan direction description.
> + *
> + *               0 = Invalid
> + *               1 = V4, the scan would always start from vertical for 4 pixel
> + *                   then move back to the start pixel of the next horizontal
> + *                   direction.
> + *               2 = Reserved for future use.
> + *
> + * 15:8  m     The times of pattern repeat in the right angle direction from
> + *             the first scan direction.
> + *
> + * 19:16 p     The padding bits after the whole scan, could be zero.
> + *
> + * 20:20 g     GOT packing flag.
> + *
> + * 23:21 -     Reserved for future use.  Must be zero.
> + *
> + * 27:24 h     log2(horizontal) of bytes, in GOTs.
> + *
> + * 31:28 v     log2(vertical) of bytes, in GOTs.
> + *
> + * 35:32 -     Reserved for future use.  Must be zero.
> + *
> + * 36:36 c     Compression flag.
> + *
> + * 55:37 -     Reserved for future use.  Must be zero.
> + *
> + */
> +
> +#define DRM_FORMAT_MOD_SYNA_V4_TILED		fourcc_mod_code(SYNAPTICS, 1)
> +
> +#define DRM_FORMAT_MOD_SYNA_MTR_LINEAR_2D(f, m, p, g, h, v, c) \
> +	fourcc_mod_code(SYNAPTICS, ((__u64)((f) & 0xff) | \
> +				 ((__u64)((m) & 0xff) << 8) | \
> +				 ((__u64)((p) & 0xf) << 16) | \
> +				 ((__u64)((g) & 0x1) << 20) | \
> +				 ((__u64)((h) & 0xf) << 24) | \
> +				 ((__u64)((v) & 0xf) << 28) | \
> +				 ((__u64)((c) & 0x1) << 36)))
> +
> +#define DRM_FORMAT_MOD_SYNA_V4H1 \
> +	DRM_FORMAT_MOD_SYNA_MTR_LINEAR_2D(1, 1, 0, 0, 0, 0, 0)
> +
> +#define DRM_FORMAT_MOD_SYNA_V4H3P8 \
> +	DRM_FORMAT_MOD_SYNA_MTR_LINEAR_2D(1, 3, 8, 0, 0, 0, 0)
> +
> +#define DRM_FORMAT_MOD_SYNA_V4H1_64L4_COMPRESSED \
> +	DRM_FORMAT_MOD_SYNA_MTR_LINEAR_2D(1, 1, 0, 1, 6, 2, 1)
> +
> +#define DRM_FORMAT_MOD_SYNA_V4H3P8_64L4_COMPRESSED \
> +	DRM_FORMAT_MOD_SYNA_MTR_LINEAR_2D(1, 3, 8, 1, 6, 2, 1)
> +
> +#define DRM_FORMAT_MOD_SYNA_V4H1_128L128_COMPRESSED \
> +	DRM_FORMAT_MOD_SYNA_MTR_LINEAR_2D(1, 1, 0, 1, 7, 7, 1)
> +
> +#define DRM_FORMAT_MOD_SYNA_V4H3P8_128L128_COMPRESSED \
> +	DRM_FORMAT_MOD_SYNA_MTR_LINEAR_2D(1, 3, 8, 1, 7, 7, 1)
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> -- 
> 2.17.1
> 
