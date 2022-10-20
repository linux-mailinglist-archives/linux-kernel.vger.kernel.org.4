Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D5E60657C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiJTQNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiJTQNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:13:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD2A1BC15D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666282394; x=1697818394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=e+g8eWaHmm8lmomVC++HUnHoR1ppSUnPPO8atDjLPoA=;
  b=QVJDjhm70ouIJ+Rj7yKWGciukm2dskTigAEwGRCTitVQwSfXdZPvf9D9
   yaGbey++LR5msN9XFkelDx4x5Do0qVkTwX6m2LWWFtM22IUaubncJDjFZ
   Rd6yHWFMPR8rmLrvHPZkpNasedc522rUaYKrPDKUcl7uRs4d/QipXTU03
   7Tp00c32xi691hJwLe1S8c8BpW6I3khv96XUdDpgn2HWiD16A8pUw4fKw
   1/3qy6VH5B+H+SDxRzq9pJYUh/u8CU20jz0xUUa41BplpUiTKcZ/Aouod
   72pfL4q/EQ7HT2BjgTBolwuCdcno766kC9DighfqIVRlxHzbEJ1S8vHH7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="393060286"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="393060286"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:09:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="719147223"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="719147223"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by FMSMGA003.fm.intel.com with SMTP; 20 Oct 2022 09:09:31 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 20 Oct 2022 19:09:30 +0300
Date:   Thu, 20 Oct 2022 19:09:30 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jim Cromie <jim.cromie@gmail.com>, daniel.vetter@ffwll.ch,
        intel-gfx@lists.freedesktop.org, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        jbaron@akamai.com, seanpaul@chromium.org,
        dri-devel@lists.freedesktop.org, joe@perches.com,
        intel-gvt-dev@lists.freedesktop.org
Subject: Re: [PATCH v7 0/9] dyndbg: drm.debug adaptation
Message-ID: <Y1Fyuh12g/gt3Izn@intel.com>
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
 <Yy7/6oTBW2lqVSK1@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yy7/6oTBW2lqVSK1@kroah.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 03:02:34PM +0200, Greg KH wrote:
> On Sun, Sep 11, 2022 at 11:28:43PM -0600, Jim Cromie wrote:
> > hi Greg, Dan, Jason, DRM-folk,
> > 
> > heres follow-up to V6:
> >   rebased on driver-core/driver-core-next for -v6 applied bits (thanks)
> >   rework drm_debug_enabled{_raw,_instrumented,} per Dan.
> > 
> > It excludes:
> >   nouveau parts (immature)
> >   tracefs parts (I missed --to=Steve on v6)
> >   split _ddebug_site and de-duplicate experiment (way unready)
> > 
> > IOW, its the remaining commits of V6 on which Dan gave his Reviewed-by.
> > 
> > If these are good to apply, I'll rebase and repost the rest separately.
> 
> All now queued up, thanks.

This stuff broke i915 debugs. When I first load i915 no debug prints are
produced. If I then go fiddle around in /sys/module/drm/parameters/debug
the debug prints start to suddenly work.

-- 
Ville Syrjälä
Intel
