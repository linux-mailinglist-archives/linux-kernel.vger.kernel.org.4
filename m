Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA30065DB8B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbjADRvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjADRvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:51:41 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA7F2BE9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 09:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jPIOICMJamB8Q+k5NZeaoYSyd6m7DdgJ938P616hzCc=;
  b=QQY9ert9138tBSipHgPuDLMcAPtLB2fm0L8B1JdP2te+pSz0p6WnxmEG
   NEiFbSoMLo6aFvP12O7CnxGlwplm4rRSIdzsWz3xRrXnZ+fMbZZfSkS/A
   djFmMTCati7ETdLEiovvya0zvAuiEQZ1lv5PB/sQ5Ei1MGpIcZcyhYA/c
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.96,300,1665439200"; 
   d="scan'208";a="85986134"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 18:51:38 +0100
Date:   Wed, 4 Jan 2023 18:51:37 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Deepak R Varma <drv@mailo.com>
cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Nicolai Stange <nicstange@gmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] drm/i915/fbc: Avoid full proxy f_ops for FBC debug
 attributes
In-Reply-To: <Y7PG5Hx5dDE7aHSx@qemulion>
Message-ID: <alpine.DEB.2.22.394.2301041850570.7216@hadrien>
References: <Y6qmNW6cOHjGwn03@qemulion> <Y6sn1BmhFJFssW0h@intel.com> <Y6s0FSK9+F+/oKSf@qemulion> <Y6wl9NhYZG5RjJL7@intel.com> <Y7PG5Hx5dDE7aHSx@qemulion>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Jan 2023, Deepak R Varma wrote:

> On Wed, Dec 28, 2022 at 06:18:12AM -0500, Rodrigo Vivi wrote:
> > On Tue, Dec 27, 2022 at 11:36:13PM +0530, Deepak R Varma wrote:
> > > On Tue, Dec 27, 2022 at 12:13:56PM -0500, Rodrigo Vivi wrote:
> > > > On Tue, Dec 27, 2022 at 01:30:53PM +0530, Deepak R Varma wrote:
> > > > > Using DEFINE_SIMPLE_ATTRIBUTE macro with the debugfs_create_file()
> > > > > function adds the overhead of introducing a proxy file operation
> > > > > functions to wrap the original read/write inside file removal protection
> > > > > functions. This adds significant overhead in terms of introducing and
> > > > > managing the proxy factory file operations structure and function
> > > > > wrapping at runtime.
> > > > > As a replacement, a combination of DEFINE_DEBUGFS_ATTRIBUTE macro paired
> > > > > with debugfs_create_file_unsafe() is suggested to be used instead.  The
> > > > > DEFINE_DEBUGFS_ATTRIBUTE utilises debugfs_file_get() and
> > > > > debugfs_file_put() wrappers to protect the original read and write
> > > > > function calls for the debug attributes. There is no need for any
> > > > > runtime proxy file operations to be managed by the debugfs core.
> > > > >
> > > > > This Change is reported by the debugfs_simple_attr.cocci Coccinelle
> > > > > semantic patch.
> > > >
> > > > I just checked here with
> > > > $ make coccicheck M=drivers/gpu/drm/i915/ MODE=context COCCI=./scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> > >
> > > Hello Rodrigo,
> > > Thank you so much for your review and feedback on the patch proposal.
> > >
> > > >
> > > > The part reported by the this script is the s/SIMPLE/DEBUGFS
> > > > but the change to the unsafe option is not.
> > >
> > > If you look at the original commit of this coccinelle file, it calls out the
> > > need for pairing debugfs_create_file_unsafe() as well. Please review this
> > >
> > > commitID: 5103068eaca2: ("debugfs, coccinelle: check for obsolete DEFINE_SIMPLE_ATTRIBUTE() usage")
> >
> > +Nicolai and Julia.
> >
> > It looks like coccinelle got right the
> > - DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
> > + DEFINE_DEBUGFS_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
> >
> > but it failed badly on
> > - debugfs_create_file(name, mode, parent, data, &dsa_fops)
> > + debugfs_create_file_unsafe(name, mode, parent, data, &dsa_fops)
> >
> > >
> > > Based on my review of the code, the functions debugfs_create_file() and
> > > debugfs_create_file_unsafe(), both internally call __debugfs_create_file().
> > > However, they pass debugfs_full_proxy_file_operations and
> > > debugfs_open_proxy_file_operations respectively to it. The former represents the
> > > full proxy factory, where as the later one is lightweight open proxy
> > > implementation of the file operations structure.
> > >
> > > >
> > > > This commit message is not explaining why the unsafe is the suggested
> > > > or who suggested it.
> > >
> > > If you find the response above accurate, I will include these details about
> > > the _unsafe() function in my commit message in v2.
> > >
> > > >
> > > > If you remove the unsafe part feel free to resend adding:
> > >
> > > Please confirm you still believe switching to _unsafe() is not necessary.
> >
> > Based on the coccinelle commit it looks like you are right, but cocinelle
> > just failed to detect the case. Let's see what Nicolai and Julia respond
> > before we move with any patch here.
>
> Hello Nicolai and Julia,
> Can you please review this proposed patch and the feedback comments from Rodrigo
> please?

I'm not an expert on this issue.  If the semantic patch needs to change in
some way, I would be happy to take any improvements.

julia


>
> Thank you,
> ./drv
>
> >
> > >
> > > >
> > > > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > > (to both patches, this and the drrs one.
> > > >
> > > > Also, it looks like you could contribute with other 2 patches:
> > > > drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c:64:0-23: WARNING: pxp_terminate_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> > > > drivers/gpu/drm/i915/gvt/debugfs.c:150:0-23: WARNING: vgpu_scan_nonprivbb_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> > >
> > > Yes, these are on my list. Was waiting for a feedback on the first submission
> > > before I send more similar patches.
> > >
> > > Appreciate your time and the feedback.
> > >
> > >
> > > Regards,
> > > ./drv
> > >
> > > >
> > > > >
> > > > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > > > ---
> > > > >  drivers/gpu/drm/i915/display/intel_fbc.c | 12 ++++++------
> > > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
> > > > > index b5ee5ea0d010..4b481e2f908b 100644
> > > > > --- a/drivers/gpu/drm/i915/display/intel_fbc.c
> > > > > +++ b/drivers/gpu/drm/i915/display/intel_fbc.c
> > > > > @@ -1809,10 +1809,10 @@ static int intel_fbc_debugfs_false_color_set(void *data, u64 val)
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > -DEFINE_SIMPLE_ATTRIBUTE(intel_fbc_debugfs_false_color_fops,
> > > > > -			intel_fbc_debugfs_false_color_get,
> > > > > -			intel_fbc_debugfs_false_color_set,
> > > > > -			"%llu\n");
> > > > > +DEFINE_DEBUGFS_ATTRIBUTE(intel_fbc_debugfs_false_color_fops,
> > > > > +			 intel_fbc_debugfs_false_color_get,
> > > > > +			 intel_fbc_debugfs_false_color_set,
> > > > > +			 "%llu\n");
> > > > >
> > > > >  static void intel_fbc_debugfs_add(struct intel_fbc *fbc,
> > > > >  				  struct dentry *parent)
> > > > > @@ -1821,8 +1821,8 @@ static void intel_fbc_debugfs_add(struct intel_fbc *fbc,
> > > > >  			    fbc, &intel_fbc_debugfs_status_fops);
> > > > >
> > > > >  	if (fbc->funcs->set_false_color)
> > > > > -		debugfs_create_file("i915_fbc_false_color", 0644, parent,
> > > > > -				    fbc, &intel_fbc_debugfs_false_color_fops);
> > > > > +		debugfs_create_file_unsafe("i915_fbc_false_color", 0644, parent,
> > > > > +					   fbc, &intel_fbc_debugfs_false_color_fops);
> > > > >  }
> > > > >
> > > > >  void intel_fbc_crtc_debugfs_add(struct intel_crtc *crtc)
> > > > > --
> > > > > 2.34.1
> > > > >
> > > > >
> > > > >
> > >
> > >
> >
>
>
>
