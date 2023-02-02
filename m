Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F6E6889A8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjBBWV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjBBWVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:21:55 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB92261D73;
        Thu,  2 Feb 2023 14:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675376513; x=1706912513;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kTsSFZa6MGNL8g9COnkJ19PXJ4Qg12GUYTOxCtS30TQ=;
  b=W1yBh+WgSHmK6VjVQutp7tqf1S43+r5+ZuVLcu+5/gZS8OMIaszT9air
   ScByaig+O20DrAkVbUQM+1BUzQDOph49aon0g6nUKHyrUV6lVKqu0oIL0
   QrJDamgdZ/ReCypSei/z4vcXeTTWcM0WHqu3HZQWDI4dByLVwP4s599CA
   09oCkZyYmgnYca4ne96y5LHcYKKs3WpmCcjp0423QvbXikRV1lG+XO4G+
   H4JaxAXRf9imdDalnjxz6wQwi1jpB+wFoJrTHe2g8AP1lKbIuCxGsXFdN
   wjpLSdtQf3jYAgRrDZKZbSIwNCzFffnGdU/Yt7/zjHAcCo9xbttYa7y25
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="327233416"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="327233416"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 14:21:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="665469599"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="665469599"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.8])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 14:21:53 -0800
Message-ID: <2eb7f5335241cc9ca2f31761766e8cb34cfaa42d.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: intel_powerclamp: Return last requested state
 as cur_state
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com
Date:   Thu, 02 Feb 2023 14:21:29 -0800
In-Reply-To: <CAJZ5v0ieQocb2oe1ggDCOos4HtkmypsadMkXCwH2J5XmRUdVyQ@mail.gmail.com>
References: <20230201210712.2170312-1-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0ieQocb2oe1ggDCOos4HtkmypsadMkXCwH2J5XmRUdVyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-02-02 at 17:44 +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 1, 2023 at 10:07 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > When the user is reading cur_state from the thermal cooling device
> > for
> > Intel powerclamp device:
> > - It returns the idle ratio from Package C-state counters when
> > there is active idle injection session.
> > - -1, when there is no active idle injection session.
> >=20
> > This information is not very useful as the package C-state counters
> > vary
> > a lot from read to read. Instead just return the last requested
> > cur_state.
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > =C2=A0drivers/thermal/intel/intel_powerclamp.c | 12 +-----------
> > =C2=A01 file changed, 1 insertion(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/thermal/intel/intel_powerclamp.c
> > b/drivers/thermal/intel/intel_powerclamp.c
> > index 2f4cbfdf26a0..72a45cf2708c 100644
> > --- a/drivers/thermal/intel/intel_powerclamp.c
> > +++ b/drivers/thermal/intel/intel_powerclamp.c
> > @@ -590,17 +590,7 @@ static int powerclamp_get_max_state(struct
> > thermal_cooling_device *cdev,
> > =C2=A0static int powerclamp_get_cur_state(struct thermal_cooling_device
> > *cdev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long *state)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (clamping) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (poll_pkg_cstate_enable)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *state =3D =
pkg_cstate_ratio_cur;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 else
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *state =3D =
set_target_ratio;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* to save power, do not poll idle ratio while not
> > clamping */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 *state =3D -1; /* indicates invalid state */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return set_target_ratio;
>=20
> *state =3D set_target_ratio;
> return 0;
>=20
Sorry.

What a blunder! Sent patch from 37000 ft. Should never do that.

Thanks,
Srinivas


> > =C2=A0}
> >=20
> > =C2=A0static int powerclamp_set_cur_state(struct thermal_cooling_device
> > *cdev,
> > --
>=20
> And please rebase it on top of the idle_inject series (which is being
> added to my bleeding-edge branch right now).

