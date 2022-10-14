Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2134D5FED03
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJNLLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJNLLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:11:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5FA528E02
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:11:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EE4A13D5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:11:27 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB2913F792
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:11:20 -0700 (PDT)
Date:   Fri, 14 Oct 2022 12:11:13 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, brian.starkey@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v3 4/7] drm/arm/hdlcd: use drm_dev_unplug()
Message-ID: <Y0lD0T+JNbyWuutU@e110455-lin.cambridge.arm.com>
References: <20221001011905.433408-1-dakr@redhat.com>
 <20221001011905.433408-5-dakr@redhat.com>
 <Y0bYGjtAHbjeGJHF@e110455-lin.cambridge.arm.com>
 <4010f21b-4478-d860-c5ba-d6680d35993b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4010f21b-4478-d860-c5ba-d6680d35993b@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 02:07:09AM +0200, Danilo Krummrich wrote:
> Hi Liviu,
> 
> On 10/12/22 17:07, Liviu Dudau wrote:
> > Hi Danilo,
> > 
> > Appologies again for the delay in reviewing this as I was at XDC last week.
> 
> No worries, thanks for following up.
> 
> > Looking at the documentation for drm_dev_unplug, you can get a hint about what is going on:
> > 
> >   /*
> >   * [....] There is one
> >   * shortcoming however, drm_dev_unplug() marks the drm_device as unplugged before
> >   * drm_atomic_helper_shutdown() is called. This means that if the disable code
> >   * paths are protected, they will not run on regular driver module unload,
> >   * possibly leaving the hardware enabled.
> >   */
> > 
> 
> Yes, that's the issue we have and pretty unfortunate. What we'd want for
> platform device drivers is to still be able to enter the sections locked
> with drm_dev_{enter,exit} on driver unbind, which we can't for at the
> moment.
> 
> I discussed this with Daniel Vetter on #dri-devel and for now he suggests to
> just not lock access to platform device bound resources and respin the
> patchset removing those parts.
> 
> Besides that I'll also work on a solution for drm_dev_unplug() /
> drm_dev_{enter,exit} to overcome this issue in the future.
> 
> > I'm finally getting to a conclusion: I'm still not sure what problem you were trying
> > to solve when you have started this series and if you have found a scenario where
> > you've got use after free then I would like to be able to reproduce it on my setup.
> > Otherwise, I think this whole series introduces a regression on the behaviour of the
> > driver and I would be inclined to reject it.
> 
> The problem is that DRM modeset objects should never be allocated with
> devm_*, since this can result in use-after free issues on driver unload.
> They should be freed when the last reference to the object is dropped, which
> DRM managed APIs take care of. As a consequence, DRM managed objects can
> potentially out-live platform device bound resources, which then should be
> protected from access. The first at least we can and should do.
> 
> It's not an issue that's unique to hdlcd, it's just a known issue to be
> addressed by all drivers. There's still the shortcoming concerning
> protecting platform bound resources as discussed above, but "the drmm parts
> should be a good idea no matter what" to cite Daniel.
> 
> I'll send a v4 without the drm_dev_{enter,exit} parts removed if that's fine
> for you.

Thanks for the description of the problem!

Also bear in mind that hdlcd and malidp use the component framework, which means that
the unbind is happening through the component_master_del() function.

I'm still keen to get a reproducer for the original issue of use-after free on hdlcd
(or malidp) that I can play with so that I can validate the final fix.

Best regards,
Liviu

> 
> - Danilo
> 
> > 
> > Best regards,
> > Liviu
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
