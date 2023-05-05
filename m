Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1776F88D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjEESqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjEESqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:46:13 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D0D3C10
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:46:06 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3ef5bea20caso9646691cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google; t=1683312366; x=1685904366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EhmbhDCRzak/t11wXpwMu2NOC9pgAHH93PKpbCf1qtA=;
        b=G4QDfdGTzO4rSstvF9JULH2agg39wZYGm0nZVPkuB63FSC18U3tIHgh/MgE122WMBH
         p/twjplPNfl+1E0E9Z1UrteFrIythH94J7d/AWSuxJLPTHdli5pkwaMD/wXE7UdE+Q1Q
         FyT1xfPSDRgD7KkOR2w802JXOiQ5nSwAJiRS45fHgz+GyOap8dVYLryiN2EE+zTNsRIR
         CIrD9UQljXXNAqfHwziSmDhh7++2JjQzEsexVdaeS9WoZhSCE+HfHEaANeIIKYv75fFz
         jfHGxvzY3fnhKhdycwH/5pNZHbyPZkutgwzSDevR80rIETpfhoeIdtjwzgD9sagW7LSp
         s9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683312366; x=1685904366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhmbhDCRzak/t11wXpwMu2NOC9pgAHH93PKpbCf1qtA=;
        b=a8n6939NLGRzwcCNEfW/GkdLrYj9iWZp6/FVxWdx5M9LJKls2SCVp8urPvyqSm8tfa
         HVsFaIyW5wL/YuqiwtohmQckTZ5QLSNUYiVWA2gOqmW8MdBKp92p8CBTrzJeG/1w6bvE
         DkuSgMGGpg3LVUIvRcJs/Q4Sh9BXfLc6KMN1+eq737WoXyRsILRBlU4PFAXN7vg75XM0
         2lEMRDCif4rFWxQP9Qbjye4PlckIh0eVTOcL5mAWj8kKsW0PNk181TGB+pFqrF+TXdyX
         cHEDKj8xAdzopO7LA/NUCaZ3lRVC18ByV1Mps028rQytHQ0K/hiEUSwhKEXjoE8B/DuV
         ewMA==
X-Gm-Message-State: AC+VfDy4cl+P/sAQHvlTuFNnuy4/aZFg0T1evD5rE8gGuwU4NaXpOsy8
        Ya596u2BIA5cE1kG1EYXEgyh3w==
X-Google-Smtp-Source: ACHHUZ6vlZe98aEMf6s3/JGq7Iyk2iDwsx/lw9OyEks9Uh1D/pOw8Gb/P9wzyi0pSNjwmIgQGhKOKg==
X-Received: by 2002:a05:622a:1999:b0:3e6:4fab:478e with SMTP id u25-20020a05622a199900b003e64fab478emr4806484qtc.33.1683312365928;
        Fri, 05 May 2023 11:46:05 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id i2-20020ac80042000000b003ef28a76a11sm59598qtg.68.2023.05.05.11.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 11:46:04 -0700 (PDT)
Date:   Fri, 5 May 2023 18:46:04 +0000
From:   Sean Paul <sean@poorly.run>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] drm/atomic: Allow vblank-enabled + self-refresh
 "disable"
Message-ID: <ZFVO7LAroGNZuCxu@art_vandelay>
References: <20230109171809.v3.1.I3904f697863649eb1be540ecca147a66e42bfad7@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109171809.v3.1.I3904f697863649eb1be540ecca147a66e42bfad7@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 05:18:16PM -0800, Brian Norris wrote:
> The self-refresh helper framework overloads "disable" to sometimes mean
> "go into self-refresh mode," and this mode activates automatically
> (e.g., after some period of unchanging display output). In such cases,
> the display pipe is still considered "on", and user-space is not aware
> that we went into self-refresh mode. Thus, users may expect that
> vblank-related features (such as DRM_IOCTL_WAIT_VBLANK) still work
> properly.
> 
> However, we trigger the WARN_ONCE() here if a CRTC driver tries to leave
> vblank enabled.
> 
> Add a different expectation: that CRTCs *should* leave vblank enabled
> when going into self-refresh.
> 
> This patch is preparation for another patch -- "drm/rockchip: vop: Leave
> vblank enabled in self-refresh" -- which resolves conflicts between the
> above self-refresh behavior and the API tests in IGT's kms_vblank test
> module.
> 
> == Some alternatives discussed: ==
> 
> It's likely that on many display controllers, vblank interrupts will
> turn off when the CRTC is disabled, and so in some cases, self-refresh
> may not support vblank. To support such cases, we might consider
> additions to the generic helpers such that we fire vblank events based
> on a timer.
> 
> However, there is currently only one driver using the common
> self-refresh helpers (i.e., rockchip), and at least as of commit
> bed030a49f3e ("drm/rockchip: Don't fully disable vop on self refresh"),
> the CRTC hardware is powered enough to continue to generate vblank
> interrupts.
> 
> So we chose the simpler option of leaving vblank interrupts enabled. We
> can reevaluate this decision and perhaps augment the helpers if/when we
> gain a second driver that has different requirements.
> 
> v3:
>  * include discussion summary
> 
> v2:
>  * add 'ret != 0' warning case for self-refresh
>  * describe failing test case and relation to drm/rockchip patch better
> 
> Cc: <stable@vger.kernel.org> # dependency for "drm/rockchip: vop: Leave
>                              # vblank enabled in self-refresh"
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Pushed both patches to drm-misc-next, thanks Brian

> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index d579fd8f7cb8..a22485e3e924 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1209,7 +1209,16 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  			continue;
>  
>  		ret = drm_crtc_vblank_get(crtc);
> -		WARN_ONCE(ret != -EINVAL, "driver forgot to call drm_crtc_vblank_off()\n");
> +		/*
> +		 * Self-refresh is not a true "disable"; ensure vblank remains
> +		 * enabled.
> +		 */
> +		if (new_crtc_state->self_refresh_active)
> +			WARN_ONCE(ret != 0,
> +				  "driver disabled vblank in self-refresh\n");
> +		else
> +			WARN_ONCE(ret != -EINVAL,
> +				  "driver forgot to call drm_crtc_vblank_off()\n");
>  		if (ret == 0)
>  			drm_crtc_vblank_put(crtc);
>  	}
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
