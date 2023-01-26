Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC0A67CC80
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjAZNoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjAZNoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:44:04 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFFD13DFB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674740640; x=1706276640;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=IE9WImV6ttkpscX6WJP7EEbQlQIw2Hf/3vh9FYwkFfI=;
  b=QLiGdgKeT7KXITewoTHySaqMsKGcRzEM446cd19/BoNM8GujCSlvmqT7
   xvEGBQIWwSDpjyaWgDlTscaCsKkK7gJnChsZoKFxSQpLPOPnxLGifWqyY
   gEofvaWMLAvUysnwvuI4Uarj51XKar7WU0mlgzTQrk560yCu6LUIo1ph6
   xzk7a+6kMldhC2alvJckzfIHs++U/qTZ+lqJD8pYNsBQEhgxau9MbEUlX
   rfZEae17uTNW/vMoR2hObq9EiUy5L5ae5Wk3/ATEqEjcJcQKIwI0oGBti
   ki5mjVj/2vmc27mhE781TwW/V3fjOUrB2NDu+fUtCWX7tYsLsgUQvgjSZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="307158631"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="307158631"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 05:43:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612790595"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="612790595"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.157])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 05:43:56 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, 971068@bugs.debian.org
Subject: Re: Assertion failure in i915 intel_display.c#assert_plane() after
 resume from hibernation
In-Reply-To: <20230124173127.os3rwxnt6m6nloce@nabtop.nabijaczleweli.xyz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <Y89xbXITTRFpjm5B@eldamar.lan> <87bkmo6ivf.fsf@intel.com>
 <20230124173127.os3rwxnt6m6nloce@nabtop.nabijaczleweli.xyz>
Date:   Thu, 26 Jan 2023 15:43:53 +0200
Message-ID: <878rhp5s2u.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023, =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz>=
 wrote:
> Booted with both, hibernated, resumed; full dmesg below.

Unfortunately, this is probably hitting a regression with drm debug
logging, and we don't get proper debug logging for i915. :(

Please use DRM_USE_DYNAMIC_DEBUG=3Dn with v6.1. I don't know if the proper
fixes have been backported to v6.1 stable kernels.

BR,
Jani.


--=20
Jani Nikula, Intel Open Source Graphics Center
