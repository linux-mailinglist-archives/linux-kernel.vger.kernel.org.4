Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB14B722CD0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjFEQhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjFEQhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:37:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A2C10A;
        Mon,  5 Jun 2023 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685983031; x=1717519031;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qoKGLD9sD+Y6htIHpR6WQkvxzj49DbOJF0aFbQergrk=;
  b=XSQEFOGvaOuaHJJlzkuKlLxeHDlJfPY/qH1uMh/NuKEdGTwYaW+j28ek
   WU7Ury4U0J6+RG6uv+UmmU0syv6elzifIbKqsZyB/HsZy2HNkfd9p83Lt
   JwUK7LD1b/CAyo0I00j5wnOjG0hJKeLSZV+zkwtkJXu8HnoKLzl5X0cwr
   smmqaCn1E8HrvqwUBtmWJ0ewQHrReexRRcL3Pkwg6r+bcjFJNuvLYF4mg
   jy6sQmhnkG8DuxLZ2ZMkbKpRhSkFdx3q/l3GcX9pr6mJiDrjRgCD+fuui
   J0s4GU2se+1Fh42A7fJtyHuKX6w/i+Qo8atuxTvQQFw57TLe4W333vkGP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422240728"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="422240728"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 09:37:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="853038525"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="853038525"
Received: from bgutier1-mobl.amr.corp.intel.com ([10.209.145.132])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 09:36:57 -0700
Message-ID: <9a4660438e0466c04880fad4450215707921521e.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: intel_powerclamp: Check for a possible array
 out of bounds access.
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniil Dulov <d.dulov@aladdin.ru>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Date:   Mon, 05 Jun 2023 09:36:54 -0700
In-Reply-To: <CAJZ5v0iyDvApQVjY=BopVSXZSg3tqmcYBnDQN2HORp3Oy8atEQ@mail.gmail.com>
References: <20230602085546.376086-1-d.dulov@aladdin.ru>
         <CAJZ5v0iyDvApQVjY=BopVSXZSg3tqmcYBnDQN2HORp3Oy8atEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-06-04 at 18:13 +0200, Rafael J. Wysocki wrote:
> Cc list trimmed.
>=20
> On Fri, Jun 2, 2023 at 11:12=E2=80=AFAM Daniil Dulov <d.dulov@aladdin.ru>
> wrote:
> >=20
> > ratio may be equal to MAX_TARGET_RATIO - 1 that will result in
> > out of bound access.
> >=20
The description was not clear to me.

May be something like this:

"
The max value of "ratio" parameter passed to the function
get_compensation() is MAX_TARGET_RATIO - 1. The size of cal_data array
is MAX_TARGET_RATIO. Hence, accessing cal_data[ratio + 1], will result
in out of bound access.

Add a condition to check ratio < MAX_TARGET_RATIO - 1, before accsssing
cal_data[ratio + 1].
"

The change is correct. But for actual code change,
the ratio < MAX_TARGET_RATIO - 1 is also checked in else if() before,
which can be merged to check only once for this condition.

Thanks,
Srinivas






> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >=20
> > Fixes: d6d71ee4a14a ("PM: Introduce Intel PowerClamp Driver")
> > Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> > ---
> > =C2=A0drivers/thermal/intel/intel_powerclamp.c | 3 ++-
> > =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/thermal/intel/intel_powerclamp.c
> > b/drivers/thermal/intel/intel_powerclamp.c
> > index fb04470d7d4b..9deaf2b8ccf6 100644
> > --- a/drivers/thermal/intel/intel_powerclamp.c
> > +++ b/drivers/thermal/intel/intel_powerclamp.c
> > @@ -277,7 +277,8 @@ static unsigned int get_compensation(int ratio)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 comp =3D (cal_data[ratio].steady_comp +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cal_d=
ata[ratio - 1].steady_comp +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cal_d=
ata[ratio - 2].steady_comp) / 3;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (cal_data[ratio].confid=
ence >=3D CONFIDENCE_OK &&

I think the concern is that cal_data[ratio + 1] is going out of bound
for the "ratio" passed to this function, when ratio =3D=3D
ARRAY_SIZE(cal_data) - 1;

Here size of cal_data array is 50. The max possible "ratio" passed can
be 49.




> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (ratio < MAX_TARGET_RAT=
IO - 1 &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cal_data[ratio].confidence >=3D CONFIDENCE_OK &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cal_data[ratio - 1].confidence >=3D CONFIDENCE_OK &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cal_data[ratio + 1].confidence >=3D CONFIDENCE_OK) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 comp =3D (cal_data[ratio].steady_comp +
> > --
>=20
> Rui, Srinivas, can you have a look at this, please?

