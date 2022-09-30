Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3BF5F1053
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiI3Q5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiI3Q5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:57:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DF081D84A8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:57:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B16511474
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:57:11 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C594A3F792
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:57:04 -0700 (PDT)
Date:   Fri, 30 Sep 2022 17:56:53 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, brian.starkey@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND drm-misc-next 4/7] drm/arm/hdlcd: plane: use drm
 managed resources
Message-ID: <Yzcf1bGciMoQExIh@e110455-lin.cambridge.arm.com>
References: <20220905152719.128539-1-dakr@redhat.com>
 <20220905152719.128539-5-dakr@redhat.com>
 <Yx9uAe//u/Z9zfmM@e110455-lin.cambridge.arm.com>
 <dc472070-34a8-93e1-2ca3-4847c49f12eb@redhat.com>
 <YyBGRMAcV2Mrliis@e110455-lin.cambridge.arm.com>
 <a10cf8af-1f62-ddd2-3975-066dd9494c9f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a10cf8af-1f62-ddd2-3975-066dd9494c9f@redhat.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 12:03:58AM +0200, Danilo Krummrich wrote:
> On 9/13/22 10:58, Liviu Dudau wrote:
> > On Mon, Sep 12, 2022 at 09:50:26PM +0200, Danilo Krummrich wrote:
> > > Hi Liviu,
> > 
> > Hi Danilo,
> > 
> > > 
> > > Thanks for having a look!
> > > 
> > > This is not about this patch, it's about patch 3/7 "drm/arm/hdlcd: crtc: use
> > > drmm_crtc_init_with_planes()".
> > 
> > Agree! However, this is the patch that removes the .destroy hook, so I've replied here.
> 
> This is a different .destroy hook, it's the struct drm_plane_funcs one, not
> the struct drm_crtc_funcs one, which the warning is about. Anyway, as said,
> we can just drop the mentioned patch. :-)
> 
> > 
> > > 
> > > And there it's the other way around. When using drmm_crtc_init_with_planes()
> > > we shouldn't have a destroy hook in place, that's the whole purpose of
> > > drmm_crtc_init_with_planes().
> > > 
> > > We should just drop patch 3/7 "drm/arm/hdlcd: crtc: use
> > > drmm_crtc_init_with_planes()", it's wrong.
> > 
> > So we end up with mixed use of managed and unmanaged APIs?
> 
> In this case, yes. However, I don't think this makes it inconsistent. They
> only thing drmm_crtc_init_with_planes() does different than
> drm_crtc_init_with_planes() is that it set's things up to automatically call
> drm_crtc_cleanup() on .destroy. Since this driver also does a register write
> in the .destroy callback and hence we can't get rid of the callback we can
> just keep it as it is.
> 
> > 
> > > 
> > > Do you want me to send a v2 for that?
> > 
> > Yes please! It would help me to understand your thinking around the whole lifecycle of the driver.
> > 
> > BTW, I appreciate the care in patches 5-7 to make sure that the driver doesn't access freed resources,
> > however I'm not sure I like the fact that rmmod-ing the hdlcd driver while I have an fbcon running
> > hangs now the command and prevents a kernel reboot, while it works without your series. Can you explain
> > to me again what are you trying to fix?
> 
> Sure! DRM managed resources are cleaned up whenever the last reference is
> put. This is not necessarily the case when the driver is unbound, hence
> there might still be calls into the driver and therefore we must protect
> resources that are bound to the driver/device lifecycle (e.g. a MMIO region
> mapped via devm_ioremap_resource()) from being accessed. That's why the
> hdlcd_write() and hdlcd_read() calls in the crtc callbacks need to be
> protected.
> 
> However, of course, the changes needed to achieve that should not result
> into hanging rmmod. Unfortunately, just by looking at the patches again I
> don't see how this could happen.
> 
> Do you mind trying again with my v2 (although v2 shouldn't make a difference
> for this issue) and provide the back-trace when it hangs?

Hi Danilo,


I've finally got a replacement Juno board that it is stable enough.

I've tried your v2 on top of 7860d720a84c ("drm/msm: Fix build break with recent mm tree") which
is the head of drm-next today and rmmod hangs. /proc/<pid_of_rmmod>/stack shows:

[<0>] __synchronize_srcu.part.0+0x78/0xec
[<0>] synchronize_srcu+0xe0/0x134
[<0>] drm_dev_unplug+0x2c/0x60 [drm]
[<0>] hdlcd_drm_unbind+0x20/0xc0 [hdlcd]
[<0>] component_master_del+0xa4/0xc0
[<0>] hdlcd_remove+0x1c/0x2c [hdlcd]
[<0>] platform_remove+0x28/0x60
[<0>] device_remove+0x4c/0x80
[<0>] device_release_driver_internal+0x1e4/0x250
[<0>] driver_detach+0x50/0xe0
[<0>] bus_remove_driver+0x5c/0xbc
[<0>] driver_unregister+0x30/0x60
[<0>] platform_driver_unregister+0x14/0x20
[<0>] hdlcd_platform_driver_exit+0x1c/0xe40 [hdlcd]
[<0>] __arm64_sys_delete_module+0x18c/0x240
[<0>] invoke_syscall+0x48/0x114
[<0>] el0_svc_common.constprop.0+0xcc/0xec
[<0>] do_el0_svc+0x2c/0xc0
[<0>] el0_svc+0x2c/0x84
[<0>] el0t_64_sync_handler+0x11c/0x150
[<0>] el0t_64_sync+0x18c/0x190

My quick guess would be that the mixing of managed and unmanaged APIs manages to
confuse the sleepable RCUs and we get the hang. Will chat with Daniel Vetter next
week at XDC on what would be the best approach here.

Best regards,
Liviu




> 
> Thanks,
> Danilo
> 
> > 
> > Best regards,
> > Liviu
> > 
> > 
> > > 
> > > - Danilo
> > > 
> > > 
> > > 
> > > On 9/12/22 19:36, Liviu Dudau wrote:
> > > > Hi Danilo,
> > > > 
> > > > I have applied your patch series for HDLCD on top of drm-next (commit 213cb76ddc8b)
> > > > and on start up I get a warning:
> > > > 
> > > > [   12.882554] hdlcd 7ff50000.hdlcd: drm_WARN_ON(funcs && funcs->destroy)
> > > > [   12.882596] WARNING: CPU: 1 PID: 211 at drivers/gpu/drm/drm_crtc.c:393 __drmm_crtc_init_with_planes+0x70/0xf0 [drm]
> > > > 
> > > > It looks like the .destroy hook is still required or I'm missing some other required
> > > > series where the WARN has been removed?
> > > > 
> > > > Best regards,
> > > > Liviu
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
