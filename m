Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC907689DDF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjBCPRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjBCPOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:14:40 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987D6AFC98
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 07:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675437151; x=1706973151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dDXulvyNwPtFpDiJ7+TPE2SX8thC6ozOW4bx2sfpBpc=;
  b=QqNQdGId2Zbf9x99T4k6JnNvxWy86EQXkuZvHgommgb05f2VVQjXjVfY
   X1Rlwtl/lny1bCf7LPCRhf73lT89TM0wE+hEz6zk6eaXZZXCNZ/jh4HbO
   iOpMiyX2ViGJTA9m4TWEf0ck8ZnjGYQQzauDACSlKHCdJq2J8jvHaVdZX
   yHdX9WNwdKYP7HNDmvXHbJtXvIc1DkpPXLnF1kXf5g4mJgg1CpYMlXKhf
   rYDa1OmB/qDVXH0ETRMLV3D44+dCpAIkT916DqCaPZt9ZjLrgzUjcfNHm
   mFyf7XjnyDH9jPpgf23B1j6RTt/vyXelg9YGKRgxb6jwX23FdVFocFEKO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="330897767"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="330897767"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 07:08:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="729289575"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="729289575"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 07:08:35 -0800
Date:   Fri, 3 Feb 2023 16:08:34 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, Thomas Zimmermann <tzimmermann@suse.de>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 00/19] fix DRM_USE_DYNAMIC_DEBUG regression
Message-ID: <20230203150834.GA2751526@linux.intel.com>
References: <20230125203743.564009-1-jim.cromie@gmail.com>
 <87a61v14ad.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a61v14ad.fsf@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 11:34:02AM +0200, Jani Nikula wrote:
> On Wed, 25 Jan 2023, Jim Cromie <jim.cromie@gmail.com> wrote:
> > Hi everyone,
> >
> > In v6.1 DRM_USE_DYNAMIC_DEBUG=y has a regression enabling drm.debug in
> > drivers at modprobe.
> 
> I realize we haven't actually addressed the regression in any way yet,
> and any distro enabling DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE will have
> DRM_USE_DYNAMIC_DEBUG=y by default, and we're hitting the issue with
> trying to gather logs from users on v6.1 or later. It hampers debugging
> pretty badly.
> 
> I appreciate the effort in fixing the problem properly here, but we'll
> need a fix that we can backport to stable kernels.
> 
> Maybe just Ville's idea of
> 
>  config DRM_USE_DYNAMIC_DEBUG
>         bool "use dynamic debug to implement drm.debug"
> -       default y
> +       default n
> +       depends on BROKEN
>         depends on DRM
>         depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
> 
> but we'll need that as a patch and merged and backported ASAP.

+1 for this

Regards
Stanislaw
