Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038A8665EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbjAKPFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239578AbjAKPEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:04:14 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A41D1CB2A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673449442; bh=hHfeLLlxtRVc9j6XU7XMcGMbGaTP5MTrvlJVfflhAEg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=NaZx9DtpQVdCqYEsczMRdJisFlGeZrkdzSp0EOUWk4MfbjhUHoA2dqqSwwfBdxYST
         9+zVkykUgmMOIGG8V56XkiXeOr1G/SdUdHi1NCSlD8d5zRWXrpOmEu8UZxE9Todt8t
         e2VCgxIzTTQym8LUdccJGX8kBsLR09yHsnDaxkYg=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed, 11 Jan 2023 16:04:02 +0100 (CET)
X-EA-Auth: NVX+7xJ9Eon+OnT0XqpyiBk4Z23i8U+cXRoqDHDZd43XT5I6Z5b4CuP7iDq4sK+2OoL+o8JAW0IKCNe2bItM/NAV/xBXGGc9
Date:   Wed, 11 Jan 2023 20:33:57 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [PATCH v2 2/2] drm/i915/fbc: Avoid full proxy f_ops for FBC
 debug attributes
Message-ID: <Y77P3Qt7P9BRMlco@ubun2204.myguest.virtualbox.org>
References: <cover.1673343994.git.drv@mailo.com>
 <a4200ae1de7324fcddac201009a43571d0a72104.1673343994.git.drv@mailo.com>
 <Y72z1T1bifo3YpSR@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y72z1T1bifo3YpSR@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:52:05PM -0500, Rodrigo Vivi wrote:
> On Tue, Jan 10, 2023 at 11:45:40PM +0530, Deepak R Varma wrote:
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
> > Following coccicheck make command helped identify this change:
> > 
> > make coccicheck M=drivers/gpu/drm/i915/ MODE=patch COCCI=./scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> > 
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> 
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> 
> (Are you planning to send the one for pxp file?)

Hello Rodrigo,
The pxp file is implemented differently using a common function for another SHOW
attribute file. I am exploring how to best handle that and would send in a patch
if feasible. See the simplified code snip below:

	static const struct intel_gt_debugfs_file files[] = {
		{ "info", &pxp_info_fops, NULL },
		{ "terminate_state", &pxp_terminate_fops, NULL },
	};
	...
	intel_gt_debugfs_register_files(root, files, ARRAY_SIZE(files), pxp);

Thank you.
./drv

> 
> > ---
> > Changes in v2:
> >    - Include coccicheck make command in the patch log message for clarity.
> >      Suggested by Rodrigo Vivi <rodrigo.vivi@intel.com>
> > 
> > 
> >  drivers/gpu/drm/i915/display/intel_fbc.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
> > index 5e69d3c11d21..c508dcf415b4 100644
> > --- a/drivers/gpu/drm/i915/display/intel_fbc.c
> > +++ b/drivers/gpu/drm/i915/display/intel_fbc.c
> > @@ -1807,10 +1807,10 @@ static int intel_fbc_debugfs_false_color_set(void *data, u64 val)
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
> > @@ -1819,8 +1819,8 @@ static void intel_fbc_debugfs_add(struct intel_fbc *fbc,
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


