Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D136F65E678
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjAEINm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjAEINj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:13:39 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A23574F2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 00:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fzV0HKTUGAzAK8YFWAsxGc2YnLeue6G6Fo1KiDz9FnA=;
  b=M1m68CEYHog5YQ/a9PchNLN0AlK8Zpc3DIEZYEhBgFGGI364c0m+3acX
   DtKG3ZTaM4up9xYAGM6WRlp9tw6igobXQJBcg0vtt0MzCpSskx0frIbSf
   F6z1g4j6bPVOrf8rZjzGYeCibHT6Y8beld2quKQiwo8OY+5LnjNTWf5pL
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.96,302,1665439200"; 
   d="scan'208";a="86036273"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 09:13:35 +0100
Date:   Thu, 5 Jan 2023 09:13:35 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
cc:     Deepak R Varma <drv@mailo.com>,
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
In-Reply-To: <Y7XABJ9MWCWO5IUA@intel.com>
Message-ID: <991ac2b4-f458-f6f2-f494-648ed61efcff@inria.fr>
References: <Y6qmNW6cOHjGwn03@qemulion> <Y6sn1BmhFJFssW0h@intel.com> <Y6s0FSK9+F+/oKSf@qemulion> <Y6wl9NhYZG5RjJL7@intel.com> <Y7PG5Hx5dDE7aHSx@qemulion> <alpine.DEB.2.22.394.2301041850570.7216@hadrien> <Y7XABJ9MWCWO5IUA@intel.com>
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

> Hi Julia, thanks for helping here.
>
> So, my question is why this
>
> make coccicheck M=drivers/gpu/drm/i915/ MODE=context COCCI=./scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
>
> didn't catch this chunck:
>
> -		debugfs_create_file("i915_fbc_false_color", 0644, parent,
> -				    fbc, &intel_fbc_debugfs_false_color_fops);
> +		debugfs_create_file_unsafe("i915_fbc_false_color", 0644, parent,
> +					   fbc, &intel_fbc_debugfs_false_color_fops);
>
> When I run it it only catches and replaces this:
>
> - DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
> + DEFINE_DEBUGFS_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);

There is something strange in your question.  You have MODE=context but
you show the output for MODE=patch.  The rule dcf matches a call to
debugfs_create_file, and the context rule matching DEFINE_SIMPLE_ATTRIBUTE
is only activated if dcf succeeds.  So when the context rule gives a
report, there is always a corresponding call to debugfs_create_file in the
same file, it is just not highlighted.  So the request is that it should
be highlighted as well?

julia

>
> But looking to the .cocci script or at least to its description,
> I believe it should catch both cases.
>
> But if it is not a bug in the cocci script, then I'd like to hear
> from Nicolai why. And have this documented in the script.
>
> Thanks,
> Rodrigo.
>
> >
> > julia
> >
> >
> > >
> > > Thank you,
> > > ./drv
> > >
> > > >
> > > > >
> > > > > >
> > > > > > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > > > > (to both patches, this and the drrs one.
> > > > > >
> > > > > > Also, it looks like you could contribute with other 2 patches:
> > > > > > drivers/gpu/drm/i915/pxp/intel_pxp_debugfs.c:64:0-23: WARNING: pxp_terminate_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> > > > > > drivers/gpu/drm/i915/gvt/debugfs.c:150:0-23: WARNING: vgpu_scan_nonprivbb_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> > > > >
> > > > > Yes, these are on my list. Was waiting for a feedback on the first submission
> > > > > before I send more similar patches.
> > > > >
> > > > > Appreciate your time and the feedback.
> > > > >
> > > > >
> > > > > Regards,
> > > > > ./drv
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/i915/display/intel_fbc.c | 12 ++++++------
> > > > > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
> > > > > > > index b5ee5ea0d010..4b481e2f908b 100644
> > > > > > > --- a/drivers/gpu/drm/i915/display/intel_fbc.c
> > > > > > > +++ b/drivers/gpu/drm/i915/display/intel_fbc.c
> > > > > > > @@ -1809,10 +1809,10 @@ static int intel_fbc_debugfs_false_color_set(void *data, u64 val)
> > > > > > >  	return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > -DEFINE_SIMPLE_ATTRIBUTE(intel_fbc_debugfs_false_color_fops,
> > > > > > > -			intel_fbc_debugfs_false_color_get,
> > > > > > > -			intel_fbc_debugfs_false_color_set,
> > > > > > > -			"%llu\n");
> > > > > > > +DEFINE_DEBUGFS_ATTRIBUTE(intel_fbc_debugfs_false_color_fops,
> > > > > > > +			 intel_fbc_debugfs_false_color_get,
> > > > > > > +			 intel_fbc_debugfs_false_color_set,
> > > > > > > +			 "%llu\n");
> > > > > > >
> > > > > > >  static void intel_fbc_debugfs_add(struct intel_fbc *fbc,
> > > > > > >  				  struct dentry *parent)
> > > > > > > @@ -1821,8 +1821,8 @@ static void intel_fbc_debugfs_add(struct intel_fbc *fbc,
> > > > > > >  			    fbc, &intel_fbc_debugfs_status_fops);
> > > > > > >
> > > > > > >  	if (fbc->funcs->set_false_color)
> > > > > > > -		debugfs_create_file("i915_fbc_false_color", 0644, parent,
> > > > > > > -				    fbc, &intel_fbc_debugfs_false_color_fops);
> > > > > > > +		debugfs_create_file_unsafe("i915_fbc_false_color", 0644, parent,
> > > > > > > +					   fbc, &intel_fbc_debugfs_false_color_fops);
> > > > > > >  }
> > > > > > >
> > > > > > >  void intel_fbc_crtc_debugfs_add(struct intel_crtc *crtc)
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
> > > > > > >
> > > > > > >
> > > > >
> > > > >
> > > >
> > >
> > >
> > >
>
