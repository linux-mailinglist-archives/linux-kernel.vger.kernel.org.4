Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A3E5B6A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiIMI7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiIMI6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:58:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F57C50072
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:58:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E6231063
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:58:59 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC2193F73B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:58:52 -0700 (PDT)
Date:   Tue, 13 Sep 2022 09:58:44 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, brian.starkey@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND drm-misc-next 4/7] drm/arm/hdlcd: plane: use drm
 managed resources
Message-ID: <YyBGRMAcV2Mrliis@e110455-lin.cambridge.arm.com>
References: <20220905152719.128539-1-dakr@redhat.com>
 <20220905152719.128539-5-dakr@redhat.com>
 <Yx9uAe//u/Z9zfmM@e110455-lin.cambridge.arm.com>
 <dc472070-34a8-93e1-2ca3-4847c49f12eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc472070-34a8-93e1-2ca3-4847c49f12eb@redhat.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 09:50:26PM +0200, Danilo Krummrich wrote:
> Hi Liviu,

Hi Danilo,

> 
> Thanks for having a look!
> 
> This is not about this patch, it's about patch 3/7 "drm/arm/hdlcd: crtc: use
> drmm_crtc_init_with_planes()".

Agree! However, this is the patch that removes the .destroy hook, so I've replied here.

> 
> And there it's the other way around. When using drmm_crtc_init_with_planes()
> we shouldn't have a destroy hook in place, that's the whole purpose of
> drmm_crtc_init_with_planes().
> 
> We should just drop patch 3/7 "drm/arm/hdlcd: crtc: use
> drmm_crtc_init_with_planes()", it's wrong.

So we end up with mixed use of managed and unmanaged APIs?

> 
> Do you want me to send a v2 for that?

Yes please! It would help me to understand your thinking around the whole lifecycle of the driver.

BTW, I appreciate the care in patches 5-7 to make sure that the driver doesn't access freed resources, 
however I'm not sure I like the fact that rmmod-ing the hdlcd driver while I have an fbcon running
hangs now the command and prevents a kernel reboot, while it works without your series. Can you explain
to me again what are you trying to fix?

Best regards,
Liviu


> 
> - Danilo
> 
> 
> 
> On 9/12/22 19:36, Liviu Dudau wrote:
> > Hi Danilo,
> > 
> > I have applied your patch series for HDLCD on top of drm-next (commit 213cb76ddc8b)
> > and on start up I get a warning:
> > 
> > [   12.882554] hdlcd 7ff50000.hdlcd: drm_WARN_ON(funcs && funcs->destroy)
> > [   12.882596] WARNING: CPU: 1 PID: 211 at drivers/gpu/drm/drm_crtc.c:393 __drmm_crtc_init_with_planes+0x70/0xf0 [drm]
> > 
> > It looks like the .destroy hook is still required or I'm missing some other required
> > series where the WARN has been removed?
> > 
> > Best regards,
> > Liviu
> > 
> > On Mon, Sep 05, 2022 at 05:27:16PM +0200, Danilo Krummrich wrote:
> > > Use drm managed resource allocation (drmm_universal_plane_alloc()) in
> > > order to get rid of the explicit destroy hook in struct drm_plane_funcs.
> > > 
> > > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > > ---
> > >   drivers/gpu/drm/arm/hdlcd_crtc.c | 20 +++++++-------------
> > >   1 file changed, 7 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> > > index c0a5ca7f578a..17d3ccf12245 100644
> > > --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> > > +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> > > @@ -289,7 +289,6 @@ static const struct drm_plane_helper_funcs hdlcd_plane_helper_funcs = {
> > >   static const struct drm_plane_funcs hdlcd_plane_funcs = {
> > >   	.update_plane		= drm_atomic_helper_update_plane,
> > >   	.disable_plane		= drm_atomic_helper_disable_plane,
> > > -	.destroy		= drm_plane_cleanup,
> > >   	.reset			= drm_atomic_helper_plane_reset,
> > >   	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
> > >   	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
> > > @@ -297,24 +296,19 @@ static const struct drm_plane_funcs hdlcd_plane_funcs = {
> > >   static struct drm_plane *hdlcd_plane_init(struct drm_device *drm)
> > >   {
> > > -	struct hdlcd_drm_private *hdlcd = drm->dev_private;
> > > +	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
> > >   	struct drm_plane *plane = NULL;
> > >   	u32 formats[ARRAY_SIZE(supported_formats)], i;
> > > -	int ret;
> > > -
> > > -	plane = devm_kzalloc(drm->dev, sizeof(*plane), GFP_KERNEL);
> > > -	if (!plane)
> > > -		return ERR_PTR(-ENOMEM);
> > >   	for (i = 0; i < ARRAY_SIZE(supported_formats); i++)
> > >   		formats[i] = supported_formats[i].fourcc;
> > > -	ret = drm_universal_plane_init(drm, plane, 0xff, &hdlcd_plane_funcs,
> > > -				       formats, ARRAY_SIZE(formats),
> > > -				       NULL,
> > > -				       DRM_PLANE_TYPE_PRIMARY, NULL);
> > > -	if (ret)
> > > -		return ERR_PTR(ret);
> > > +	plane = drmm_universal_plane_alloc(drm, struct drm_plane, dev, 0xff,
> > > +					   &hdlcd_plane_funcs,
> > > +					   formats, ARRAY_SIZE(formats),
> > > +					   NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
> > > +	if (IS_ERR(plane))
> > > +		return plane;
> > >   	drm_plane_helper_add(plane, &hdlcd_plane_helper_funcs);
> > >   	hdlcd->plane = plane;
> > > -- 
> > > 2.37.2
> > > 
> > 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
