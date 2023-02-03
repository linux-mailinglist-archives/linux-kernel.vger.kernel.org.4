Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6826F689B0B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjBCOEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjBCODm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:03:42 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7768A945E5;
        Fri,  3 Feb 2023 06:01:24 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cw4so5204319edb.13;
        Fri, 03 Feb 2023 06:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMxOcECTROuojakMPC85g2uiW2fNR65bS9sWaaYjKx0=;
        b=pysH+jNR1RIsPECfhz0zsLyvvDuLNlBFdVheQ6FlgxyuvfxxkCQAfswneFezsGrSI5
         7wnQygqm2eIXa0kpdRZ9kPhJQseL3JKpBfYT+3Vo/iNEtaFWQ1YnFQCrcfJWgzitmP6e
         bSjItThW27LMjcO/GEqASjzgDBm1P5eQ1psiozIha34JfkRijIcQIYt1w48pJdOp9NuF
         9VdRuCh0BBexkPEKGWW0WuuNX03CITLwGSQyBDWh+AyVPXtTKDq3FDS3pRLcmBUh84B/
         5Ogglv6Hy9K3TSwwn8X/oWxY1E/4IFxDAQc0iMigUo/hI8hEFREO9KUpfPCRPGYM5nQv
         Z3qA==
X-Gm-Message-State: AO0yUKUfPQHbavZPD9wYDVPD4hnVNMA/B2veZ0waKyG+GNsMgb8YWBPa
        e2bcuLTu7qpSZ6hTvw3ZcOC+cJqELD6JMRf1XDUdx78V
X-Google-Smtp-Source: AK7set8uq7ebbsSriWJxHjrHMUC6X+0zB2DHHT/wCwhhmPTuZACsbPFqJ8NoROQqePjZsa6D2K4EbGrVsWTgDZ6U/EQ=
X-Received: by 2002:a05:6402:40ce:b0:490:47c3:3d71 with SMTP id
 z14-20020a05640240ce00b0049047c33d71mr3247056edb.31.1675432767901; Fri, 03
 Feb 2023 05:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20230201210712.2170312-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0ieQocb2oe1ggDCOos4HtkmypsadMkXCwH2J5XmRUdVyQ@mail.gmail.com> <2eb7f5335241cc9ca2f31761766e8cb34cfaa42d.camel@linux.intel.com>
In-Reply-To: <2eb7f5335241cc9ca2f31761766e8cb34cfaa42d.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Feb 2023 14:59:16 +0100
Message-ID: <CAJZ5v0j=Hs9F3UQqV_qCJ+ra6y+Q+HhBrN-tRtfrE47nH_Suxg@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel_powerclamp: Return last requested state as cur_state
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 11:21 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Thu, 2023-02-02 at 17:44 +0100, Rafael J. Wysocki wrote:
> > On Wed, Feb 1, 2023 at 10:07 PM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > When the user is reading cur_state from the thermal cooling device
> > > for
> > > Intel powerclamp device:
> > > - It returns the idle ratio from Package C-state counters when
> > > there is active idle injection session.
> > > - -1, when there is no active idle injection session.
> > >
> > > This information is not very useful as the package C-state counters
> > > vary
> > > a lot from read to read. Instead just return the last requested
> > > cur_state.
> > >
> > > Signed-off-by: Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com>
> > > ---
> > >  drivers/thermal/intel/intel_powerclamp.c | 12 +-----------
> > >  1 file changed, 1 insertion(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/thermal/intel/intel_powerclamp.c
> > > b/drivers/thermal/intel/intel_powerclamp.c
> > > index 2f4cbfdf26a0..72a45cf2708c 100644
> > > --- a/drivers/thermal/intel/intel_powerclamp.c
> > > +++ b/drivers/thermal/intel/intel_powerclamp.c
> > > @@ -590,17 +590,7 @@ static int powerclamp_get_max_state(struct
> > > thermal_cooling_device *cdev,
> > >  static int powerclamp_get_cur_state(struct thermal_cooling_device
> > > *cdev,
> > >                                  unsigned long *state)
> > >  {
> > > -       if (clamping) {
> > > -               if (poll_pkg_cstate_enable)
> > > -                       *state = pkg_cstate_ratio_cur;
> > > -               else
> > > -                       *state = set_target_ratio;
> > > -       } else {
> > > -               /* to save power, do not poll idle ratio while not
> > > clamping */
> > > -               *state = -1; /* indicates invalid state */
> > > -       }
> > > -
> > > -       return 0;
> > > +       return set_target_ratio;
> >
> > *state = set_target_ratio;
> > return 0;
> >
> Sorry.
>
> What a blunder! Sent patch from 37000 ft. Should never do that.

No worries.

I didn't realize that you were traveling.

I can prepare this patch myself just fine if that helps.
