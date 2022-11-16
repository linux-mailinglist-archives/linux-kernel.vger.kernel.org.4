Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EF362BF02
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbiKPNHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbiKPNGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:06:43 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1304387D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668603967; x=1700139967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=InMnGBG9WIu93rX/1BniIAb5g2P3gQSwtf4zO3a6OCk=;
  b=ZQjcAqi8RCdgxDki/8hB3l0BerZ1E20iu9nTCPGsvW8HK2BEzV/eocs1
   X5zPFKOxkl/SOs9rQ5uR6N37n1LZIu2fOq+keOGbw/ZOFrNpLioeunuCt
   twqhRWxon+plUWEHRb1KNt31Rm7amoBH1jiZpQ0kYnhitCBuBsVN03aNO
   ey9d1wyrnZXkv1c4uZ93JaL3YhLnJw5sPAoRGQpfDBfJY9AM2nTl9JhtY
   4yWsaCl2h4YzhThGLD8baoCf7H5I6Z8cFtq+SSWLn01DvWZJh9Ur7jRWf
   IjBfshpos4VJokNqGVGsDtDeT+MpaiJRQen3wEWyG1+/ZD5VydGBLLDFC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="312544095"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="312544095"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 05:06:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="633622290"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="633622290"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by orsmga007.jf.intel.com with SMTP; 16 Nov 2022 05:06:04 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 16 Nov 2022 15:06:03 +0200
Date:   Wed, 16 Nov 2022 15:06:03 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        DRI <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] How is the progress for removing
 flush_scheduled_work() callers?
Message-ID: <Y3TgO7pHo9z9FINO@intel.com>
References: <e170edc2-e5b9-4c8b-4ed3-7e2d7a2850dc@I-love.SAKURA.ne.jp>
 <877czv2ov8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877czv2ov8.fsf@intel.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:08:27PM +0200, Jani Nikula wrote:
> On Sun, 06 Nov 2022, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> > Like commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue() using a
> > macro") says, flush_scheduled_work() is dangerous and will be forbidden.
> > We are on the way for removing all flush_scheduled_work() callers from
> > the kernel, and there are only 4 callers remaining as of linux-20221104.
> >
> >   drivers/gpu/drm/i915/display/intel_display.c:8997:      flush_scheduled_work();
> 
> Thanks for the reminder, I've pinged folks to get someone working on
> this. We do schedule quite a bunch of work, so it's not immediately
> obvious (at least to me) what exactly needs flushing.

Here's my earlier cursory analysis of the subject:
https://lore.kernel.org/intel-gfx/Yy3byxFrfAfQL9xK@intel.com/

> 
> https://gitlab.freedesktop.org/drm/intel/-/issues/7546
> 
> >   drivers/gpu/drm/i915/gt/selftest_execlists.c:88:        flush_scheduled_work();
> 
> Removed by commit 7d33fd02dd94 ("drm/i915/selftests: Remove
> flush_scheduled_work() from live_execlists") in drm-next.
> 
> BR,
> Jani.
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center

-- 
Ville Syrjälä
Intel
