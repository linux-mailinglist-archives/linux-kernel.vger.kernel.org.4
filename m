Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D846073CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiJUJSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiJUJSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:18:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992152565CC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666343915; x=1697879915;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=nVetjXHRfqyVKF1htzqfquwo9eva30/LnRsHGeRwraI=;
  b=izw9NJTLiTeO0uYbnqORVEMSLxV3ATL6LIVQ+oScCGs/cGw6GoTS+R6Z
   KpBFPXiAWwrbZohUKo7uW4opggiKFr/EtxfWIkT8dTjx42ycVfRZUcdCy
   yk6/WCpbPnFMQMbM2emEv3gmXq8v08bUiYgj7R4pO9k9BOIV1cV0LPpAL
   J7qnkgHp/RdQwGWg2uHnB1QCdt0WQVt2V1/AEin1yS8buHIpo5dnI/rhR
   AhJzAvmj/bWsASwbC8m7keEztP/JWNEKYfohYVTOaJUNPAG0pXwfOdxGa
   V6CfCTk4YC2gi3Ey9qs8nfOAsU+wJUY2FSjAF1gNyPifa2uQwhDvx5I0R
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="306948910"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="306948910"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 02:18:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="755707666"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="755707666"
Received: from avilla3-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.53.153])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 02:18:19 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Jim Cromie <jim.cromie@gmail.com>, daniel.vetter@ffwll.ch,
        intel-gfx@lists.freedesktop.org, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        jbaron@akamai.com, seanpaul@chromium.org,
        dri-devel@lists.freedesktop.org, joe@perches.com,
        intel-gvt-dev@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH v7 0/9] dyndbg: drm.debug adaptation
In-Reply-To: <Y1Fyuh12g/gt3Izn@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
 <Yy7/6oTBW2lqVSK1@kroah.com> <Y1Fyuh12g/gt3Izn@intel.com>
Date:   Fri, 21 Oct 2022 12:18:17 +0300
Message-ID: <87a65pfsbq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Sat, Sep 24, 2022 at 03:02:34PM +0200, Greg KH wrote:
>> On Sun, Sep 11, 2022 at 11:28:43PM -0600, Jim Cromie wrote:
>> > hi Greg, Dan, Jason, DRM-folk,
>> >=20
>> > heres follow-up to V6:
>> >   rebased on driver-core/driver-core-next for -v6 applied bits (thanks)
>> >   rework drm_debug_enabled{_raw,_instrumented,} per Dan.
>> >=20
>> > It excludes:
>> >   nouveau parts (immature)
>> >   tracefs parts (I missed --to=3DSteve on v6)
>> >   split _ddebug_site and de-duplicate experiment (way unready)
>> >=20
>> > IOW, its the remaining commits of V6 on which Dan gave his Reviewed-by.
>> >=20
>> > If these are good to apply, I'll rebase and repost the rest separately.
>>=20
>> All now queued up, thanks.
>
> This stuff broke i915 debugs. When I first load i915 no debug prints are
> produced. If I then go fiddle around in /sys/module/drm/parameters/debug
> the debug prints start to suddenly work.

Wait what? I always assumed the default behaviour would stay the same,
which is usually how we roll. It's a regression in my books. We've got a
CI farm that's not very helpful in terms of dmesg logging right now
because of this.

BR,
Jani.


--=20
Jani Nikula, Intel Open Source Graphics Center
