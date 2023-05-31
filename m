Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98488717A99
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbjEaIsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbjEaIr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:47:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726B0E4D
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685522865; x=1717058865;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/t/IRQycrRsaywMENmlH357EbeiJB8Tfnj+9vXHLpmg=;
  b=nZ6daK5+7n5taDo2qv7G1f4qSDUdsGWspor92J188P3jEk1lFId4kc3v
   TXDtwgmWmmyxL1Xbii20jOZfseopIxFdJhTUgKbfBKIvMDGo4KCznQXty
   decgXQyVLezlSVIEv25/UnK8zn0jUvR6gElcsyjL3SeAJpiit9WH31rZd
   N4olxYJ5rTb5Rm9r2mQ2BoMbi2pqhUZtd2LRZZRK7OoLMgrISrec8HGRG
   gzZsPFuggBIkbmkObgk6rnvEpmQAyTvfdKrnpqiev4buEwjIIDguQI18d
   IY+SEs3WpC3BeKyifPJSXyBF6ARwYlpqCyCInMk/gOzaF2+w9A8BwfYu1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="354023354"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="354023354"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 01:47:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="701025604"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="701025604"
Received: from unknown (HELO ideak-desk) ([10.237.72.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 01:47:41 -0700
Date:   Wed, 31 May 2023 11:47:40 +0300
From:   Imre Deak <imre.deak@intel.com>
To:     Rudi Heitbaum <rudi@heitbaum.com>
Cc:     Dave Airlie <airlied@redhat.com>, Dave Airlie <airlied@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v4,01/14] drm/i915: Fix PIPEDMC disabling for a bigjoiner
 configuration
Message-ID: <ZHcJhs4ySOGojBvZ@ideak-desk>
Reply-To: imre.deak@intel.com
References: <20230510103131.1618266-2-imre.deak@intel.com>
 <20230530134907.GA8@5e905162a5a7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230530134907.GA8@5e905162a5a7>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 01:49:07PM +0000, Rudi Heitbaum wrote:
Hi Rudi,

Could you open a ticket at
https://gitlab.freedesktop.org/drm/intel/-/issues/new

attaching a dmesg log after booting with drm.debug=0xe, with the
messages from boot-up until the issue happens?

Thanks,
Imre

> Hi Imre/Dave,
> 
> Ref: [v4,01/14] drm/i915: Fix PIPEDMC disabling for a bigjoiner configuration
>      [git pull] drm fixes for 6.4-rc4
>      drm-fixes-2023-05-26:
>      drm fixes for 6.4-rc4
> 
> This patch has caused a regression between 6.4-rc3 and 6.4-rc4. Other
> tested kernels include 6.3.4 work fine. Dropping the patch allows the decode
> playback of media via Kodi. Without dropping the patch - the media
> starts and stutters then ceases to play.
> 
> There is an additional issue that 6.4-rc4 audio playback is also failing
> (where 6.4-rc3 was fine), I have not yet tracked this down.
> 
> This is all on:
> DMI: Intel(R) Client Systems NUC12WSKi7/NUC12WSBi7, BIOS WSADL357.0087.2023.0306.1931 03/06/2023
> 12th Gen Intel(R) Core(TM) i7-1260P (family: 0x6, model: 0x9a, stepping: 0x3)
> microcode: updated early: 0x429 -> 0x42a, date = 2023-02-14
> 
> Regards
> 
> Rudi
> 
> On Wed, May 10, 2023 at 01:31:18PM +0300, Imre Deak wrote:
> > For a bigjoiner configuration display->crtc_disable() will be called
> > first for the slave CRTCs and then for the master CRTC. However slave
> > CRTCs will be actually disabled only after the master CRTC is disabled
> > (from the encoder disable hooks called with the master CRTC state).
> > Hence the slave PIPEDMCs can be disabled only after the master CRTC is
> > disabled, make this so.
> > 
> > intel_encoders_post_pll_disable() must be called only for the master
> > CRTC, as for the other two encoder disable hooks. While at it fix this
> > up as well. This didn't cause a problem, since
> > intel_encoders_post_pll_disable() will call the corresponding hook only
> > for an encoder/connector connected to the given CRTC, however slave
> > CRTCs will have no associated encoder/connector.
> > 
> > Fixes: 3af2ff0840be ("drm/i915: Enable a PIPEDMC whenever its corresponding pipe is enabled")
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Signed-off-by: Imre Deak <imre.deak@intel.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_display.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> > index 1d5d42a408035..116fa52290b84 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display.c
> > @@ -1702,9 +1702,17 @@ static void hsw_crtc_disable(struct intel_atomic_state *state,
> >  
> >  	intel_disable_shared_dpll(old_crtc_state);
> >  
> > -	intel_encoders_post_pll_disable(state, crtc);
> > +	if (!intel_crtc_is_bigjoiner_slave(old_crtc_state)) {
> > +		struct intel_crtc *slave_crtc;
> > +
> > +		intel_encoders_post_pll_disable(state, crtc);
> >  
> > -	intel_dmc_disable_pipe(i915, crtc->pipe);
> > +		intel_dmc_disable_pipe(i915, crtc->pipe);
> > +
> > +		for_each_intel_crtc_in_pipe_mask(&i915->drm, slave_crtc,
> > +						 intel_crtc_bigjoiner_slave_pipes(old_crtc_state))
> > +			intel_dmc_disable_pipe(i915, slave_crtc->pipe);
> > +	}
> >  }
> >  
> >  static void i9xx_pfit_enable(const struct intel_crtc_state *crtc_state)
