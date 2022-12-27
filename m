Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0F0656DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 19:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiL0SGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 13:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0SGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 13:06:33 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243E5E41
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 10:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672164379; bh=zxrGV6ifTSulE8N2ayWJie6beCLzXxvXheTGblxTLLs=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=B4bGLAbPTHDpDzDsq2ZoF4DeF6HGS1ca9ihDIZcfWW+tCnThRA0v7BRSHhEOZGxWz
         kRuCYX2l1nRFP8ThXknOG+g1kL0LmPcriI5WSZMK3Y0oNiqLrqT+PkRyuiaVmwsY7E
         PKHjWJEx41k6jwVe1iB/Egr4DV1Ie9sqPh4oi990=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 27 Dec 2022 19:06:19 +0100 (CET)
X-EA-Auth: hdHTa+YVHebgj2OAtim6AI745HMESDa2jC0+qkCFj+4bzh86fKH9DBcOPTM07YbedQtiHDmjnZF3xVa34huFJF/71vlwbbK6
Date:   Tue, 27 Dec 2022 23:36:13 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] drm/i915/fbc: Avoid full proxy f_ops for FBC debug
 attributes
Message-ID: <Y6s0FSK9+F+/oKSf@qemulion>
References: <Y6qmNW6cOHjGwn03@qemulion>
 <Y6sn1BmhFJFssW0h@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6sn1BmhFJFssW0h@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 12:13:56PM -0500, Rodrigo Vivi wrote:
> On Tue, Dec 27, 2022 at 01:30:53PM +0530, Deepak R Varma wrote:
> > Using DEFINE_SIMPLE_ATTRIBUTE macro with the debugfs_create_file()
> > function adds the overhead of introducing a proxy file operation
> > functions to wrap the original read/write inside file removal protection
> > functions. This adds significant overhead in terms of introducing and
> > managing the proxy factory file operations structure and function
> > wrapping at runtime.
> > As a replacement, a combination of DEFINE_DEBUGFS_ATTRIBUTE macro paired
> > with debugfs_create_file_unsafe() is suggested to be used instead.  The
> > DEFINE_DEBUGFS_ATTRIBUTE utilises debugfs_file_get() and
> > debugfs_file_put() wrappers to protect the original read and write
> > function calls for the debug attributes. There is no need for any
> > runtime proxy file operations to be managed by the debugfs core.
> >
> > This Change is reported by the debugfs_simple_attr.cocci Coccinelle
> > semantic patch.
>
> I just checked here with
> $ make coccicheck M=drivers/gpu/drm/i915/ MODE=context COCCI=./scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci

Hello Rodrigo,
Thank you so much for your review and feedback on the patch proposal.

>
> The part reported by the this script is the s/SIMPLE/DEBUGFS
> but the change to the unsafe option is not.

If you look at the original commit of this coccinelle file, it calls out the
need for pairing debugfs_create_file_unsafe() as well. Please review this

commitID: 5103068eaca2: ("debugfs, coccinelle: check for obsolete DEFINE_SIMPLE_ATTRIBUTE() usage")

Based on my review of the code, the functions debugfs_create_file() and
debugfs_create_file_unsafe(), both internally call __debugfs_create_file().
However, they pass debugfs_full_proxy_file_operations and
debugfs_open_proxy_file_operations respectively to it. The former represents the
full proxy factory, where as the later one is lightweight open proxy
implementation of the file operations structure.

>
> This commit message is not explaining why the unsafe is the suggested
> or who suggested it.

If you find the response above accurate, I will include these details about
the _unsafe() function in my commit message in v2.

>
> If you remove the unsafe part feel free to resend adding:

Please confirm you still believe switching to _unsafe() is not necessary.

>
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> (to both patches, this and the drrs one.
>
> Also, it looks like you could contribute with other 2 patches:
> drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c:64:0-23: WARNING: pxp_terminate_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> drivers/gpu/drm/i915/gvt/debugfs.c:150:0-23: WARNING: vgpu_scan_nonprivbb_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE

Yes, these are on my list. Was waiting for a feedback on the first submission
before I send more similar patches.

Appreciate your time and the feedback.


Regards,
./drv

>
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_fbc.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
> > index b5ee5ea0d010..4b481e2f908b 100644
> > --- a/drivers/gpu/drm/i915/display/intel_fbc.c
> > +++ b/drivers/gpu/drm/i915/display/intel_fbc.c
> > @@ -1809,10 +1809,10 @@ static int intel_fbc_debugfs_false_color_set(void *data, u64 val)
> >  	return 0;
> >  }
> >
> > -DEFINE_SIMPLE_ATTRIBUTE(intel_fbc_debugfs_false_color_fops,
> > -			intel_fbc_debugfs_false_color_get,
> > -			intel_fbc_debugfs_false_color_set,
> > -			"%llu\n");
> > +DEFINE_DEBUGFS_ATTRIBUTE(intel_fbc_debugfs_false_color_fops,
> > +			 intel_fbc_debugfs_false_color_get,
> > +			 intel_fbc_debugfs_false_color_set,
> > +			 "%llu\n");
> >
> >  static void intel_fbc_debugfs_add(struct intel_fbc *fbc,
> >  				  struct dentry *parent)
> > @@ -1821,8 +1821,8 @@ static void intel_fbc_debugfs_add(struct intel_fbc *fbc,
> >  			    fbc, &intel_fbc_debugfs_status_fops);
> >
> >  	if (fbc->funcs->set_false_color)
> > -		debugfs_create_file("i915_fbc_false_color", 0644, parent,
> > -				    fbc, &intel_fbc_debugfs_false_color_fops);
> > +		debugfs_create_file_unsafe("i915_fbc_false_color", 0644, parent,
> > +					   fbc, &intel_fbc_debugfs_false_color_fops);
> >  }
> >
> >  void intel_fbc_crtc_debugfs_add(struct intel_crtc *crtc)
> > --
> > 2.34.1
> >
> >
> >


