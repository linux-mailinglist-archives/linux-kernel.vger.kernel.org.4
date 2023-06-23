Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1859F73BBFF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjFWPt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjFWPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:49:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4C52117;
        Fri, 23 Jun 2023 08:49:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 395C0838;
        Fri, 23 Jun 2023 17:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687535326;
        bh=B+HCtCbVdeoR7xbVap5Pedr+jgl7SnRDJw5vJm/gcUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r3Wvgacw724k8Jza1TnDQMXRqCyux9eWvs5V8hkgNbje5Ow++FkWZ6HAndV8mTVri
         W65rqawOWnMbYcv1aF6ApRfQdm30yorzhR2DICmqz6sRjpKXvsQVr3kAyCUfBGh8tH
         om3DZa9UFl7RMxGdKCtSLbc50wYH8JJLx7GgVjWk=
Date:   Fri, 23 Jun 2023 18:49:21 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/39] drm: renesas: shmobile: Convert container helpers
 to static inline functions
Message-ID: <20230623154921.GW2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <63f1bef1f316175615a54490f752d64b7ddd29ab.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63f1bef1f316175615a54490f752d64b7ddd29ab.1687423204.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thu, Jun 22, 2023 at 11:21:31AM +0200, Geert Uytterhoeven wrote:
> Replace to conversion helper macros using container_of() by static
> inline functions, to improve type-safety.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  | 11 ++++++++---
>  drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c |  5 ++++-
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> index 26611440f7a12715..40948b56017ff2df 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> @@ -291,7 +291,10 @@ static void shmob_drm_crtc_update_base(struct shmob_drm_crtc *scrtc)
>  	lcdc_write(sdev, LDRCNTR, lcdc_read(sdev, LDRCNTR) ^ LDRCNTR_MRS);
>  }
>  
> -#define to_shmob_crtc(c)	container_of(c, struct shmob_drm_crtc, crtc)
> +static inline struct shmob_drm_crtc *to_shmob_crtc(struct drm_crtc *crtc)
> +{
> +	return container_of(crtc, struct shmob_drm_crtc, crtc);
> +}
>  
>  static void shmob_drm_crtc_dpms(struct drm_crtc *crtc, int mode)
>  {
> @@ -571,8 +574,10 @@ int shmob_drm_encoder_create(struct shmob_drm_device *sdev)
>   * Connector
>   */
>  
> -#define to_shmob_connector(c) \
> -	container_of(c, struct shmob_drm_connector, connector)
> +static inline struct shmob_drm_connector *to_shmob_connector(struct drm_connector *connector)
> +{
> +	return container_of(connector, struct shmob_drm_connector, connector);
> +}
>  
>  static int shmob_drm_connector_get_modes(struct drm_connector *connector)
>  {
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> index 17e66a018689f648..258288c80756bf16 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> @@ -34,7 +34,10 @@ struct shmob_drm_plane {
>  	unsigned int crtc_h;
>  };
>  
> -#define to_shmob_plane(p)	container_of(p, struct shmob_drm_plane, plane)
> +static inline struct shmob_drm_plane *to_shmob_plane(struct drm_plane *plane)
> +{
> +	return container_of(plane, struct shmob_drm_plane, plane);
> +}
>  
>  static void shmob_drm_plane_compute_base(struct shmob_drm_plane *splane,
>  					 struct drm_framebuffer *fb,

-- 
Regards,

Laurent Pinchart
