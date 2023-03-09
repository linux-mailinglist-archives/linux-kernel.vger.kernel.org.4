Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399A96B2C5E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjCIRwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCIRwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:52:05 -0500
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46B3FC239
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 09:52:04 -0800 (PST)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4PXcFb5SCKz9t2t;
        Thu,  9 Mar 2023 17:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1678384324; bh=JuFW52oZIbKvMuoqXJG7KSEarsvi6C7zK3hTzLLF/Nw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l7bISwWoCUpjZUMuDU3CUT5ZbNT5O1UEbAd34Mar41LCYN6YBGECZvSAkSj3egGXw
         djbREjhLVeplKzUyBYQKIziU2myIb7egInhzpv/Ezmm5vUXlvK4D2TvdgNZL3vLTtg
         yA+0rQ5s7hOzZ7mbYaAm9tNkH5pAajcIaarZiLus=
X-Riseup-User-ID: 69B7135DCA07D4F4C0BE4AE8A87CCB08DD9D0EDCE64E33CE998F59481EC5273D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4PXcFX5wmZz1yNK;
        Thu,  9 Mar 2023 17:52:00 +0000 (UTC)
Message-ID: <6a3d0907-5e04-5e72-cf45-3eb619ea6efb@riseup.net>
Date:   Thu, 9 Mar 2023 14:51:58 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v2] drm/format-helper: Make conversion_buf_size() support
 sub-byte pixel fmts
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        David Gow <davidgow@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        dri-devel@lists.freedesktop.org
References: <20230307215039.346863-1-javierm@redhat.com>
From:   Arthur Grillo Queiroz Cabral <arthurgrillo@riseup.net>
In-Reply-To: <20230307215039.346863-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 07/03/23 18:50, Javier Martinez Canillas wrote:
> There are DRM fourcc formats that have pixels smaller than a byte, but the
> conversion_buf_size() function assumes that pixels are a multiple of bytes
> and use the struct drm_format_info .cpp field to calculate the dst_pitch.
> 
> Instead, calculate it by using the bits per pixel (bpp) and divide it by 8
> to account for formats that have sub-byte pixels.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> Tested by making sure that the following command still succeeds:
> 
> ./tools/testing/kunit/kunit.py run \
> --kunitconfig=drivers/gpu/drm/tests/.kunitconfig
> 
> Changes in v2:
> - Drop an unused variable, that was pointed out by the kernel robot.
> 
>  drivers/gpu/drm/tests/drm_format_helper_test.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
> index 9536829c6e3a..84b5cc29c8fc 100644
> --- a/drivers/gpu/drm/tests/drm_format_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
> @@ -409,12 +409,15 @@ static size_t conversion_buf_size(u32 dst_format, unsigned int dst_pitch,
>  				  const struct drm_rect *clip)
>  {
>  	const struct drm_format_info *dst_fi = drm_format_info(dst_format);
> +	unsigned int bpp;
>  
>  	if (!dst_fi)
>  		return -EINVAL;
>  
> -	if (!dst_pitch)
> -		dst_pitch = drm_rect_width(clip) * dst_fi->cpp[0];
> +	if (!dst_pitch) {
> +		bpp = drm_format_info_bpp(dst_fi, 0);
> +		dst_pitch = DIV_ROUND_UP(drm_rect_width(clip) * bpp, 8);
> +	}
>  
>  	return dst_pitch * drm_rect_height(clip);
>  }

Ran it on UML, arm and powerpc with my patch above it, All looks good
:).

Reviewed-by: Arthur Grillo <arthurgrillo@riseup.net>

Thanks,
Grillo
