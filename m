Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F00D6A3B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 07:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjB0Gt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 01:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjB0Gt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 01:49:56 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEB0D32D;
        Sun, 26 Feb 2023 22:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677480594; x=1709016594;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=r4tU+6rUB7sufgstiOuUn7jgiOxa80cctU6rlYqqDZQ=;
  b=ikQU+jAJXIwr41nUx9XKdav+ftNfMG7OiNhnp6zmFZE7KvVaON2Ptl9S
   PiJ5RlbhsfdofZ+K2SdWjD4lW8BVCrV2gTHiyd8K3RqNhKxeWUbrrMg43
   jPaR/mELTpAkG9rV0Jgs9aVb/44S2g1CTMRHZ9laCLAKdu0xigfjLcvYg
   oHA9/MsCPN2n1Uso6M9dqknkobvItRl65Ow0xAY0gTPYOPHGqMes8wdSK
   yh1m5agdUAWLOmKYD2ur4o4EtcTPI7dqagKQWc1AHGU0jzxLQKCbxA6u3
   HkTibPAozIkY1iI8Yj/4Ijs/XflLO7W7UYTkvjy1Hu9MYdfQZv7rQzLkG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="361348920"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="361348920"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 22:49:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="737533014"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="737533014"
Received: from dkumarr-mobl2.gar.corp.intel.com ([10.213.123.7])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 22:49:51 -0800
Message-ID: <e8862e3c8d73f94484a002cf376942e0863b1fb6.camel@linux.intel.com>
Subject: Re: [Regression] cached max_state breaks ACPI processor cooling
 device
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc:     "Wang, Quanxian" <quanxian.wang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Sun, 26 Feb 2023 22:49:47 -0800
In-Reply-To: <1d21b45a453518cfbabd827d46c14bd7ce9ef9d7.camel@intel.com>
References: <53ec1f06f61c984100868926f282647e57ecfb2d.camel@intel.com>
         <1d21b45a453518cfbabd827d46c14bd7ce9ef9d7.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-02-25 at 05:34 +0000, Zhang, Rui wrote:
> On Sat, 2023-02-25 at 13:29 +0800, Zhang Rui wrote:
> > Hi, All,
> >=20
> > Starting from commit c408b3d1d9bb("thermal: Validate new state in
> > cur_state_store()") and commit a365105c685c("thermal: sysfs: Reuse
> > cdev->max_state"), the cdev->get_max_state() is evaluated only once
> > during cooling device registration.
> >=20
> > This is done to fix the below Smatch static checker warning:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/thermal/thermal=
_sysfs.c:656
> > thermal_cooling_device_stats_update()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0warn: potential integer=
 overflow from user 'stats->state *
> > stats->max_states + new_state'
> > reported here https://lore.kernel.org/all/Y0ltRJRjO7AkawvE@kili/.
> >=20
> > But this actually breaks cooling devices which could have dynamic
> > max
> > cooling state, like ACPI processor cooling device.
> >=20
> > acpi_processor_driver_init
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0driver_register(&acpi_p=
rocessor_driver);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_processor_start
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
acpi_processor_thermal_init
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0thermal_cooling_device_regi=
ster
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0processor_get_max_state
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_processor_cpufreq_=
init =3D true
> > The driver doesn't count cpufreq as cooling state until
> > acpi_processor_cpufreq_init is set later.
> >=20
> > As a result, without the commits above,
> > /sys/class/thermal/cooling_device10/cur_state:0
> > /sys/class/thermal/cooling_device10/max_state:3
> > /sys/class/thermal/cooling_device10/type:Processor
> > after the commits above,=20
> > /sys/class/thermal/cooling_device10/cur_state:0
> > /sys/class/thermal/cooling_device10/max_state:0
> > /sys/class/thermal/cooling_device10/type:Processor
>=20
You really need a core API, which updates max_state. When I was trying
to update max_state for powerclamp driver, I thought of a function to
do this.
This basically works under  cdev->lock, something similar to
__thermal_cdev_update. For each thermal instances if the shallowest
state is more than the new max_state, fail the request, otherwise set.


Thanks,
Srinivas


> Forgot to mention that this problem is
>=20
> Reported-by: Wang, Quanxian <quanxian.wang@intel.com>
>=20
> thanks,
> rui
> >=20
> > In order to fix this, there are something worth clarification IMO.
> > 1. should we support dynamic max_state or not?
> > =C2=A0=C2=A0 ACPI processor cooling state is a combination of processor=
 p-
> > states
> > =C2=A0=C2=A0 and t-states.
> > =C2=A0=C2=A0 t-states are static, but p-states can vary depends on proc=
essor=20
> > =C2=A0=C2=A0 frequency driver loaded or not.
> > =C2=A0=C2=A0 I'm not sure if there is any other user like this, but sti=
ll
> > this
> > =C2=A0=C2=A0 is a valid use case of dynamic max_state.
> > 2. how to handle dynamic max_state for cooling device statistics in
> > =C2=A0=C2=A0 sysfs?
> > =C2=A0=C2=A0 IMO, when max_state changes, the definition of previous co=
oling
> > =C2=A0=C2=A0 device is changed as well, thus we should abandon the prev=
ious
> > =C2=A0=C2=A0 statistics and restart counting.
> > 3. anything else needs to be handled when max_state changes?
> > =C2=A0=C2=A0 Say, as the definition of each cooling state is changed wh=
en
> > =C2=A0=C2=A0 max_state changes, should we invalidate and re-update the
> > =C2=A0=C2=A0 thermal instances of this cdev in each thermal zone device=
?
> > 4. how to detect/handle max cooling states changes?
> > =C2=A0=C2=A0 Should we do this as before, which invokes .get_max_state(=
)
> > =C2=A0=C2=A0 everywhere and do updates when necessary , or
> > =C2=A0=C2=A0 a. cache max_state like we do today
> > =C2=A0=C2=A0 b. introduce a new API for max_state change
> > =C2=A0=C2=A0 c. invoke the new API in the cooling device driver explici=
tly
> > when
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_state changes
> > =C2=A0=C2=A0 d. update cached max_state value, statistics sysfs and
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thermal_instances in the API
> > =C2=A0=C2=A0 e. remove .get_max_state() callback as we register and upd=
ate
> > the
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_state with a fixed value each time.
> >=20
> > thanks,
> > rui
> >=20
> >=20
> >=20

