Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27B9631DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiKUKLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiKUKLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:11:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FB2A8149
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669025452; x=1700561452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3PSOM4S3o1YjG9zFLfF1qbHWEVgNTxGOoPxNHnw1cLU=;
  b=heUP8UQAkGSBEwVR9NTTuwyiOTxYW7qZGpxY3Mq4KM8qL3AgVshwd4es
   KyIk8+Yc2tPTNJYH/WWDtCP9NzZY/FbCl+NqjL/0I/jFu6jqrrl+QEFgy
   +geZvVGRUrT1qiMztnZnJuc6L3a0hOuE7eZPWkC3rhr21oocrwHXN3FHn
   pWyI2kyLau4LuB+eiWPNPp/Ux2jZY3GoAip42FN+cnPeVy9rAdBrNFyir
   +ombCQpacJxbFeE/4Ilng1QCgqKejMGzjJ+zbYfaUGGjVG2R8GmQhe/Iu
   GU9NqEcMSWIPH7JvoT5ajmLOMAJ/qYffHL5Tzlitpjm/vYR3isgRoqMaO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="296880702"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="296880702"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 02:10:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="729955054"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="729955054"
Received: from joe-255.igk.intel.com (HELO localhost) ([172.22.229.67])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 02:10:49 -0800
Date:   Mon, 21 Nov 2022 11:10:47 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: Re: DRM-managed resources / devm_drm_dev_alloc leaking resources
Message-ID: <20221121101047.GA648920@linux.intel.com>
References: <20221117165311.vovrc7usy4efiytl@houat>
 <20221118161558.ym7sif4tkr5srk2b@houat>
 <Y3i6hi71mh18miHs@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3i6hi71mh18miHs@phenom.ffwll.local>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Sat, Nov 19, 2022 at 12:14:14PM +0100, Daniel Vetter wrote:
> On Fri, Nov 18, 2022 at 05:15:58PM +0100, Maxime Ripard wrote:
> > Hi,
> > 
> > Javier and I looked into it some more today, and I think we have a
> > better idea of what is going on.
> > 
> > On Thu, Nov 17, 2022 at 05:53:11PM +0100, Maxime Ripard wrote:
> > > After trying to get more kunit tests for KMS, I found out that the
> > > recent kunit helpers we merged to create a DRM device [1] are broken and
> > > won't free their device-managed and DRM-managed resources.
> > > 
> > > With some help from Thomas, we've dug into this and it turns out that if
> > > we allocate a device with root_device_register, initialise our drm
> > > device with devm_drm_dev_alloc(), register it using drm_dev_register(),
> > > unregister it using drm_dev_unregister/drm_dev_unplug and then remove
> > > the parent device, neither the device managed nor the DRM managed
> > > actions are run.
> > > 
> > > root_device_register initializes the device by eventually calling
> > > device_initialize() which sets the initial reference count of the root
> > > device to 1 [2]. devm_drm_dev_alloc() then comes in, drm_dev_init() will
> > > increase the root device refcount [3] and initialize our DRM device to 1
> > > [4]. drm_dev_register(), through drm_minor_register() and device_add(),
> > > will increase the root device refcount [5].
> > > 
> > > When unrolling things, drm_dev_unregister(), through
> > > drm_minor_unregister() and device_del(), will give up its reference [6].
> > > root_device_unregister(), through device_unregister(), will also give up
> > > its own [7].
> > > 
> > > So we end up with this for the reference counts:
> > > 
> > > +------------------------+-------------+------------+
> > > |         funcs          | root device | DRM device |
> > > +------------------------+-------------+------------+
> > > | root_device_register   |           1 | N/A        |
> > > | devm_drm_dev_alloc     |           2 | 1          |
> > > | drm_dev_register       |           3 | 1          |
> > > | drm_dev_unregister     |           2 | 1          |
> > > | root_device_unregister |           1 | 1          |
> > > +------------------------+-------------+------------+
> > > 
> > > If we go back to the list of reference taken, the root device reference
> > > and the initial drm_device reference, both taken by devm_drm_dev_alloc()
> > > through drm_dev_init(), haven't been put back.
> > > 
> > > If we look at the drm_dev_init code(), we can see that it sets up a
> > > DRM-managed action [8] that will put back the device reference [9]. The
> > > DRM-managed code is executed by the drm_managed_cleanup() function, that
> > > is executed as part of a release hook [10] executed once we give up the
> > > final reference to the DRM device [11].
> > > 
> > > If we go back a little, the final reference to the DRM device is
> > > actually the initial one setup by devm_drm_dev_alloc(). This function
> > > has superseded drm_dev_alloc(), with the documentation that we do need a
> > > final drm_dev_put() to put back our final reference [12].
> > > 
> > > devm_drm_dev_alloc() is a more convenient variant that has been
> > > introduced explicitly to not require that drm_dev_put(), and states it
> > > as such in the documentation [13]. It does so by adding a device-managed
> > > action that will call drm_dev_put() [14].
> > > 
> > > Device-managed actions are ran as part devres_release_all() that is
> > > called by device_release() [15], itself being run when the last
> > > reference on the device is put back [16][17][18].
> > > 
> > > So if we sum things up, the DRM device will only give its last root
> > > device reference when the last DRM device reference will be put back,
> > > and the last DRM device reference will be put back when the last device
> > > reference will be put back, which sounds very circular to me, with both
> > > ending up in a deadlock scenario.
> > > 
> > > I've added two kunit tests that demonstrate the issue: we register a
> > > device, allocate and register a DRM device, register a DRM-managed
> > > action, remove the DRM device and the parent device, and wait for the
> > > action to execute. drm_register_unregister_with_devm_test() uses the
> > > broken(?) devm_drm_dev_alloc and is failing.
> > > drm_register_unregister_test uses the deprecated drm_dev_alloc() that
> > > requires an explicit call to drm_dev_put() which works fine.
> > > 
> > > It's also worth noting that Thomas tested with simpledrm and it seems to
> > > work fine.
> > 
> > Indeed, the transition from simpledrm to a full-blown DRM driver handles
> > this properly. It's using a platform_device_unregister() [1] and
> > eventually device_del() [2][3]. That part is handled just like
> > root_device_unregister() [4][5]. Basically, both will call device_del(),
> > and then device_put(), so device_del() is called while holding a
> > reference.
> > 
> > As we've seen before, at this point the DRM driver still holds a
> > reference to the device as well.
> > 
> > device_del() will call bus_remove_device() [6], which will be skipped
> > for the root device since it doesn't have a bus [7].
> > 
> > It will then call device_release_driver() [8], which is basically forwarded
> > to __device_release_driver() [9][10], that will call device_unbind_cleanup() [11].
> > 
> > device_unbind_cleanup() calls devres_release_all() directly [12], that
> > runs all the device-managed actions [13]. And it does so WHILE THERE'S
> > STILL A REFCOUNT OF 2!
> > 
> > I would expect the call to devres_release_all to happen only in
> > device_release, once all the device reference have been put back. Not 4
> > functions in as a side effect, and while there's still some active
> > references.
> 
> So maybe I'm missing something, but devm is tied to the device's
> existence, not to the lifetime of the struct device.

Yes, devm_ resources can be released even if somebody is keeping
positive reference to struct device FWICT, after bus->remove() you
can not access them.

> Or well, it's complicated, there's actually two cleanups, once when doing
> the hotunplug/unregister, and once when the final struct device cleanup
> happens. This is why devm_drm_dev_alloc absolutely must be in the former
> cleanup group, otherwise you have the loop you've described.

There are 2 separate managed resources list: one in drm_device and one
in struct device. Those are cleaned up separately.

But if we are talking about struct device there is only one cleanup.
However it can happen from few entry points that ended up on:
device_unbind_cleanup() -> devres_release_all()

And there is a problem when mixing devm_ and drmm_, because you have
to correctly chose devm_ resources and avoid those which can still be
accessed via drm callbacks. Or block access tho those after
bus->remove / sysfs unbind. Not sure it this is related to original,
problem presented here by Maxime though. Just my thoughts from
converting intel_vpu to use drmm.

Regards
Stanislaw
