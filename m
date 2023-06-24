Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE0B73CA4B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjFXJtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjFXJta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:49:30 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CC791999;
        Sat, 24 Jun 2023 02:49:27 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxlfAmvJZkZSwBAA--.1903S3;
        Sat, 24 Jun 2023 17:49:26 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxvM4lvJZkqwYFAA--.25584S3;
        Sat, 24 Jun 2023 17:49:25 +0800 (CST)
Message-ID: <1a85a81b-36d4-02c9-50c2-8a1988a4ef37@loongson.cn>
Date:   Sat, 24 Jun 2023 17:49:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [20/39] drm: renesas: shmobile: Replace .dev_private with
 container_of()
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <48a0d1dcdf18ca07b97e2813ba26f9e52198a716.1687423204.git.geert+renesas@glider.be>
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <48a0d1dcdf18ca07b97e2813ba26f9e52198a716.1687423204.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxvM4lvJZkqwYFAA--.25584S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxtw45Xw43JF18Aw45XrW5urX_yoWfGF1xpF
        48AayYyFW0qrZ0gryUAFsruFnI9r13ta4fuFyUG3y3Kr4vq347J3WrJFnxCFWDJry7Ca13
        XrnIgF4rZr109rXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
        AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4oGQDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/22 17:21, Geert Uytterhoeven wrote:
> Now that drm_device is embedded in shmob_drm_device, we can use
> a container_of()-based helper to get the shmob_drm_device pointer from
> the drm_device, instead of using the deprecated drm_device.dev_private
> field.
>
> While at it, restore reverse Xmas tree ordering of local variable
> declarations.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>

> ---
>   .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 20 +++++++++----------
>   .../gpu/drm/renesas/shmobile/shmob_drm_drv.c  |  4 +---
>   .../gpu/drm/renesas/shmobile/shmob_drm_drv.h  |  5 +++++
>   .../drm/renesas/shmobile/shmob_drm_plane.c    |  6 +++---
>   4 files changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> index 40948b56017ff2df..291b3a5014c24f08 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> @@ -63,7 +63,7 @@ static void shmob_drm_clk_off(struct shmob_drm_device *sdev)
>   static void shmob_drm_crtc_setup_geometry(struct shmob_drm_crtc *scrtc)
>   {
>   	struct drm_crtc *crtc = &scrtc->crtc;
> -	struct shmob_drm_device *sdev = crtc->dev->dev_private;
> +	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
>   	const struct shmob_drm_interface_data *idata = &sdev->pdata->iface;
>   	const struct drm_display_mode *mode = &crtc->mode;
>   	u32 value;
> @@ -102,7 +102,7 @@ static void shmob_drm_crtc_setup_geometry(struct shmob_drm_crtc *scrtc)
>   
>   static void shmob_drm_crtc_start_stop(struct shmob_drm_crtc *scrtc, bool start)
>   {
> -	struct shmob_drm_device *sdev = scrtc->crtc.dev->dev_private;
> +	struct shmob_drm_device *sdev = to_shmob_device(scrtc->crtc.dev);
>   	u32 value;
>   
>   	value = lcdc_read(sdev, LDCNT2R);
> @@ -136,7 +136,7 @@ static void shmob_drm_crtc_start_stop(struct shmob_drm_crtc *scrtc, bool start)
>   static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
>   {
>   	struct drm_crtc *crtc = &scrtc->crtc;
> -	struct shmob_drm_device *sdev = crtc->dev->dev_private;
> +	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
>   	const struct shmob_drm_interface_data *idata = &sdev->pdata->iface;
>   	const struct shmob_drm_format_info *format;
>   	struct drm_device *dev = &sdev->ddev;
> @@ -223,7 +223,7 @@ static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
>   static void shmob_drm_crtc_stop(struct shmob_drm_crtc *scrtc)
>   {
>   	struct drm_crtc *crtc = &scrtc->crtc;
> -	struct shmob_drm_device *sdev = crtc->dev->dev_private;
> +	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
>   
>   	if (!scrtc->started)
>   		return;
> @@ -280,7 +280,7 @@ static void shmob_drm_crtc_compute_base(struct shmob_drm_crtc *scrtc,
>   static void shmob_drm_crtc_update_base(struct shmob_drm_crtc *scrtc)
>   {
>   	struct drm_crtc *crtc = &scrtc->crtc;
> -	struct shmob_drm_device *sdev = crtc->dev->dev_private;
> +	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
>   
>   	shmob_drm_crtc_compute_base(scrtc, crtc->x, crtc->y);
>   
> @@ -322,8 +322,8 @@ static int shmob_drm_crtc_mode_set(struct drm_crtc *crtc,
>   				   int x, int y,
>   				   struct drm_framebuffer *old_fb)
>   {
> +	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
>   	struct shmob_drm_crtc *scrtc = to_shmob_crtc(crtc);
> -	struct shmob_drm_device *sdev = crtc->dev->dev_private;
>   	const struct shmob_drm_format_info *format;
>   
>   	format = shmob_drm_format_info(crtc->primary->fb->format->format);
> @@ -428,7 +428,7 @@ static void shmob_drm_crtc_enable_vblank(struct shmob_drm_device *sdev,
>   
>   static int shmob_drm_enable_vblank(struct drm_crtc *crtc)
>   {
> -	struct shmob_drm_device *sdev = crtc->dev->dev_private;
> +	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
>   
>   	shmob_drm_crtc_enable_vblank(sdev, true);
>   
> @@ -437,7 +437,7 @@ static int shmob_drm_enable_vblank(struct drm_crtc *crtc)
>   
>   static void shmob_drm_disable_vblank(struct drm_crtc *crtc)
>   {
> -	struct shmob_drm_device *sdev = crtc->dev->dev_private;
> +	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
>   
>   	shmob_drm_crtc_enable_vblank(sdev, false);
>   }
> @@ -511,7 +511,7 @@ static bool shmob_drm_encoder_mode_fixup(struct drm_encoder *encoder,
>   					 struct drm_display_mode *adjusted_mode)
>   {
>   	struct drm_device *dev = encoder->dev;
> -	struct shmob_drm_device *sdev = dev->dev_private;
> +	struct shmob_drm_device *sdev = to_shmob_device(dev);
>   	struct drm_connector *connector = &sdev->connector.connector;
>   	const struct drm_display_mode *panel_mode;
>   
> @@ -581,7 +581,7 @@ static inline struct shmob_drm_connector *to_shmob_connector(struct drm_connecto
>   
>   static int shmob_drm_connector_get_modes(struct drm_connector *connector)
>   {
> -	struct shmob_drm_device *sdev = connector->dev->dev_private;
> +	struct shmob_drm_device *sdev = to_shmob_device(connector->dev);
>   	struct drm_display_mode *mode;
>   
>   	mode = drm_mode_create(connector->dev);
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> index 2b77af3a8c97ef8c..1a1d66c6e817e227 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> @@ -95,7 +95,7 @@ static int shmob_drm_setup_clocks(struct shmob_drm_device *sdev,
>   static irqreturn_t shmob_drm_irq(int irq, void *arg)
>   {
>   	struct drm_device *dev = arg;
> -	struct shmob_drm_device *sdev = dev->dev_private;
> +	struct shmob_drm_device *sdev = to_shmob_device(dev);
>   	unsigned long flags;
>   	u32 status;
>   
> @@ -217,8 +217,6 @@ static int shmob_drm_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		return ret;
>   
> -	ddev->dev_private = sdev;
> -
>   	ret = shmob_drm_modeset_init(sdev);
>   	if (ret < 0)
>   		return dev_err_probe(&pdev->dev, ret,
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.h
> index 77bb0da48f37ace8..5e55ba7a207865bd 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.h
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.h
> @@ -39,4 +39,9 @@ struct shmob_drm_device {
>   	struct shmob_drm_connector connector;
>   };
>   
> +static inline struct shmob_drm_device *to_shmob_device(struct drm_device *dev)
> +{
> +	return container_of(dev, struct shmob_drm_device, ddev);
> +}
> +
>   #endif /* __SHMOB_DRM_DRV_H__ */
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> index 258288c80756bf16..c58b9dca34736342 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> @@ -63,7 +63,7 @@ static void shmob_drm_plane_compute_base(struct shmob_drm_plane *splane,
>   static void __shmob_drm_plane_setup(struct shmob_drm_plane *splane,
>   				    struct drm_framebuffer *fb)
>   {
> -	struct shmob_drm_device *sdev = splane->plane.dev->dev_private;
> +	struct shmob_drm_device *sdev = to_shmob_device(splane->plane.dev);
>   	u32 format;
>   
>   	/* TODO: Support ROP3 mode */
> @@ -135,8 +135,8 @@ shmob_drm_plane_update(struct drm_plane *plane, struct drm_crtc *crtc,
>   		       uint32_t src_w, uint32_t src_h,
>   		       struct drm_modeset_acquire_ctx *ctx)
>   {
> +	struct shmob_drm_device *sdev = to_shmob_device(plane->dev);
>   	struct shmob_drm_plane *splane = to_shmob_plane(plane);
> -	struct shmob_drm_device *sdev = plane->dev->dev_private;
>   	const struct shmob_drm_format_info *format;
>   
>   	format = shmob_drm_format_info(fb->format->format);
> @@ -167,8 +167,8 @@ shmob_drm_plane_update(struct drm_plane *plane, struct drm_crtc *crtc,
>   static int shmob_drm_plane_disable(struct drm_plane *plane,
>   				   struct drm_modeset_acquire_ctx *ctx)
>   {
> +	struct shmob_drm_device *sdev = to_shmob_device(plane->dev);
>   	struct shmob_drm_plane *splane = to_shmob_plane(plane);
> -	struct shmob_drm_device *sdev = plane->dev->dev_private;
>   
>   	splane->format = NULL;
>   

-- 
Jingfeng

