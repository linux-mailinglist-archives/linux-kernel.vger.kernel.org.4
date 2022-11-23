Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD8B636603
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbiKWQmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbiKWQmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:42:33 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFAFCE4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:42:27 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z18so25608355edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8JZOcUu6HJ6CYG3/kMUGO8YebOiQSwKW0GWNGGl19Y=;
        b=ADDEafqnLTCuv/1hHN90tRHtZ2Js3zcTCuaBMGMkbqvScSkBlGqnqBfT0wnc0LII80
         rDrcEHGNfHSMVJfmN26WsEdKKGwJYmzOaAvHE8ov7L+D01YMoweg/cBXtXUV4dLF35/+
         jF7QmEj/+Yd1KFcp4m5j7acTPPd6auvLVpCqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8JZOcUu6HJ6CYG3/kMUGO8YebOiQSwKW0GWNGGl19Y=;
        b=MSPeAo6mkiegl7UHe45DuYNjYCQ+fjHS0sV9AJ0mUVILuRKfCB1IuNrTAFMdUm/CbF
         r2eKdxBDc1gn+FrSjlH9BRj8YT/AxkqKyzXKZ+B72BIQ/kZ54b+d56/YsnuWnkqJcuoY
         iatYXcsgzPKZvRB8zIAYRJajbm5R+1K0s8hZwAV+Q+RkecsTZynmMRImZMqiVofT2rCV
         GvvONisutm+nMzV0e5nzIDZvL+w975jhs/+K7o9kTgO5tElFpLfDXl+MbajhBN907K2K
         rEznFTRbBmLHhgJ9KpPPPy/tiynlXT8pdksx3knpEG5wel0Xo3CFemPOBtECTM63XR0p
         BYnw==
X-Gm-Message-State: ANoB5pktcKFutfObOHNKFkVVkVDQq9SDjXAuazpxhzFUkYNJGMIcbg38
        Q2fVbG2plwHn1ZPZqOiaeC4n+A==
X-Google-Smtp-Source: AA0mqf6saUw2/dQuCbDeoGg7vK7k8Waf7Fx1BKirG8RmWJKZnwiw3hrYjy5Kryf4LcK8MTrhTAmczw==
X-Received: by 2002:a05:6402:181:b0:461:ea0c:e151 with SMTP id r1-20020a056402018100b00461ea0ce151mr12144745edv.376.1669221745500;
        Wed, 23 Nov 2022 08:42:25 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id p3-20020a05640210c300b00463c367024bsm7691898edu.63.2022.11.23.08.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 08:42:24 -0800 (PST)
Date:   Wed, 23 Nov 2022 17:42:22 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Hsia-Jun Li <randy.li@synaptics.com>,
        dri-devel@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        ezequiel@vanguardiasur.com.ar, helen.koike@collabora.com,
        laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mchehab@kernel.org, mripard@kernel.org, nicolas@ndufresne.ca,
        ribalda@chromium.org, sakari.ailus@linux.intel.com,
        sebastian.hesselbarth@gmail.com, tfiga@chromium.org,
        tzimmermann@suse.de, ayaka@soulik.info
Subject: Re: [PATCH v4] drm/fourcc: Add Synaptics VideoSmart tiled modifiers
Message-ID: <Y35Nbhd/fhESOFeU@phenom.ffwll.local>
Mail-Followup-To: Jisheng Zhang <jszhang@kernel.org>,
        Hsia-Jun Li <randy.li@synaptics.com>,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        ezequiel@vanguardiasur.com.ar, helen.koike@collabora.com,
        laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mchehab@kernel.org, mripard@kernel.org, nicolas@ndufresne.ca,
        ribalda@chromium.org, sakari.ailus@linux.intel.com,
        sebastian.hesselbarth@gmail.com, tfiga@chromium.org,
        tzimmermann@suse.de, ayaka@soulik.info
References: <20221123091957.75967-1-randy.li@synaptics.com>
 <Y341AxDwqRC/0eep@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y341AxDwqRC/0eep@xhacker>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:58:11PM +0800, Jisheng Zhang wrote:
> On Wed, Nov 23, 2022 at 05:19:57PM +0800, Hsia-Jun Li wrote:
> > From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
> > 
> > Memory Traffic Reduction(MTR) is a module in Synaptics
> > VideoSmart platform could process lossless compression image
> > and cache the tile memory line.
> > 
> > Those modifiers only record the parameters would effort pixel
> > layout or memory layout. Whether physical memory page mapping
> > is used is not a part of format.
> > 
> > We would allocate the same size of memory for uncompressed
> > and compressed luma and chroma data, while the compressed buffer
> > would request two extra planes holding the metadata for
> > the decompression.
> > 
> > Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> > ---
> >  include/uapi/drm/drm_fourcc.h | 75 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> > 
> > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> > index bc056f2d537d..ca0b4ca70b36 100644
> > --- a/include/uapi/drm/drm_fourcc.h
> > +++ b/include/uapi/drm/drm_fourcc.h
> > @@ -407,6 +407,7 @@ extern "C" {
> >  #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
> >  #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
> >  #define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
> > +#define DRM_FORMAT_MOD_VENDOR_SYNAPTICS 0x0b
> 
> Any users in the mainline tree?

Note that drm_fourcc.h serves as the vendor-neutral registry for these
numbers, and they're referenced in both gl and vk extensions. So this is
the one case where we do _not_ require in-kernel users or open source
userspace.

If there is someone interested in an in-kernel or open userspace driver
though it would be really great to have their acks before merging. Just to
make sure that the modifiers will work with both upstream and downstream
driver stacks.

I just realized that we've failed to document this, I'll type up a patch.
-Daniel


> 
> >  
> >  /* add more to the end as needed */
> >  
> > @@ -1507,6 +1508,80 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
> >  #define AMD_FMT_MOD_CLEAR(field) \
> >  	(~((__u64)AMD_FMT_MOD_##field##_MASK << AMD_FMT_MOD_##field##_SHIFT))
> >  
> > +/*
> > + * Synaptics VideoSmart modifiers
> > + *
> > + * Tiles could be arranged in Groups of Tiles (GOTs), it is a small tile
> > + * within a tile. GOT size and layout varies based on platform and
> > + * performance concern. When the compression is applied, it is possible
> > + * that we would have two tile type in the GOT, these parameters can't
> > + * tell the secondary tile type.
> > + *
> > + * Besides, an 8 size 4 bytes arrary (32 bytes) would be need to store
> > + * some compression parameters for a compression meta data plane.
> > + *
> > + *       Macro
> > + * Bits  Param Description
> > + * ----  ----- -----------------------------------------------------------------
> > + *
> > + *  7:0  f     Scan direction description.
> > + *
> > + *               0 = Invalid
> > + *               1 = V4, the scan would always start from vertical for 4 pixel
> > + *                   then move back to the start pixel of the next horizontal
> > + *                   direction.
> > + *               2 = Reserved for future use.
> > + *
> > + * 15:8  m     The times of pattern repeat in the right angle direction from
> > + *             the first scan direction.
> > + *
> > + * 19:16 p     The padding bits after the whole scan, could be zero.
> > + *
> > + * 20:20 g     GOT packing flag.
> > + *
> > + * 23:21 -     Reserved for future use.  Must be zero.
> > + *
> > + * 27:24 h     log2(horizontal) of bytes, in GOTs.
> > + *
> > + * 31:28 v     log2(vertical) of bytes, in GOTs.
> > + *
> > + * 35:32 -     Reserved for future use.  Must be zero.
> > + *
> > + * 36:36 c     Compression flag.
> > + *
> > + * 55:37 -     Reserved for future use.  Must be zero.
> > + *
> > + */
> > +
> > +#define DRM_FORMAT_MOD_SYNA_V4_TILED		fourcc_mod_code(SYNAPTICS, 1)
> > +
> > +#define DRM_FORMAT_MOD_SYNA_MTR_LINEAR_2D(f, m, p, g, h, v, c) \
> > +	fourcc_mod_code(SYNAPTICS, ((__u64)((f) & 0xff) | \
> > +				 ((__u64)((m) & 0xff) << 8) | \
> > +				 ((__u64)((p) & 0xf) << 16) | \
> > +				 ((__u64)((g) & 0x1) << 20) | \
> > +				 ((__u64)((h) & 0xf) << 24) | \
> > +				 ((__u64)((v) & 0xf) << 28) | \
> > +				 ((__u64)((c) & 0x1) << 36)))
> > +
> > +#define DRM_FORMAT_MOD_SYNA_V4H1 \
> > +	DRM_FORMAT_MOD_SYNA_MTR_LINEAR_2D(1, 1, 0, 0, 0, 0, 0)
> > +
> > +#define DRM_FORMAT_MOD_SYNA_V4H3P8 \
> > +	DRM_FORMAT_MOD_SYNA_MTR_LINEAR_2D(1, 3, 8, 0, 0, 0, 0)
> > +
> > +#define DRM_FORMAT_MOD_SYNA_V4H1_64L4_COMPRESSED \
> > +	DRM_FORMAT_MOD_SYNA_MTR_LINEAR_2D(1, 1, 0, 1, 6, 2, 1)
> > +
> > +#define DRM_FORMAT_MOD_SYNA_V4H3P8_64L4_COMPRESSED \
> > +	DRM_FORMAT_MOD_SYNA_MTR_LINEAR_2D(1, 3, 8, 1, 6, 2, 1)
> > +
> > +#define DRM_FORMAT_MOD_SYNA_V4H1_128L128_COMPRESSED \
> > +	DRM_FORMAT_MOD_SYNA_MTR_LINEAR_2D(1, 1, 0, 1, 7, 7, 1)
> > +
> > +#define DRM_FORMAT_MOD_SYNA_V4H3P8_128L128_COMPRESSED \
> > +	DRM_FORMAT_MOD_SYNA_MTR_LINEAR_2D(1, 3, 8, 1, 7, 7, 1)
> > +
> >  #if defined(__cplusplus)
> >  }
> >  #endif
> > -- 
> > 2.17.1
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
