Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F616BED22
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCQPi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCQPiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:38:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF812A99E;
        Fri, 17 Mar 2023 08:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679067457; x=1710603457;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=OqKcYsBqgI6Umrd4XMYW8VccsSAILQbPc/ZYveVbsw0=;
  b=lNg1mZgC+Q4lHN0kZaSfKkguBRUApxb4LLfPx52eqH3OtsgIXsudCGIQ
   fCCJ9YT4PgsSJTZBvt85WAYyHvNmRMhpxrCSH+CylHuFKJg/FUQfGQU2e
   t/GMDyRoi2Pe1bqTFIoUItwf3Ch44i/2qXGWiM+TrNcc0EuaMsctHZjJx
   qlVDYOtJRtl5giv4P1afOr4mQMIvsgE0Nwgdwskb5R89aXW0hNEwTAYm4
   1SfKTj8zA3ii1qJ2V2gKt+oLhta55fnGEAKX5HvLta9fqUirVJpRTEKPl
   +/kap+1Vc1N51y/ngjCXlAtsyIwAfhVJVZJwMZsJ6l7w4KRLnpogf/Vt7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="317940565"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="317940565"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 08:37:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="823694562"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="823694562"
Received: from jmangala-mobl.amr.corp.intel.com ([10.251.19.63])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 08:37:36 -0700
Message-ID: <ebed4596ab82f7d99673ea6660800ed2fb0e1245.camel@linux.intel.com>
Subject: Re: BUG: hid-sensor-ids code includes binary data in device name
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     "Xu, Even" <even.xu@intel.com>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "Brandt, Todd E" <todd.e.brandt@intel.com>
Date:   Fri, 17 Mar 2023 08:37:36 -0700
In-Reply-To: <DM6PR11MB2618B71FCDD70813404F570FF4BD9@DM6PR11MB2618.namprd11.prod.outlook.com>
References: <592bcdcbb3603cf5dfefd09abdd6916db4efc691.camel@linux.intel.com>
         <317ce138f63b9317ac7be1949a68db5117c19b92.camel@linux.intel.com>
         <424882ed2a79a641f88b5f2d1ed5a5d3d4fe98d9.camel@gmx.net>
         <fe7b41aa975128bd44d351911b0faa17b837033c.camel@linux.intel.com>
         <DM6PR11MB2618B71FCDD70813404F570FF4BD9@DM6PR11MB2618.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-03-17 at 05:49 +0000, Xu, Even wrote:
> Hi, All,
>=20
> Sorry for response later.
>=20
> From below description, it seems not a buffer overrun issue, it's
> just caused by NULL terminated string, right?
>=20
Correct, the subject may be a bit misleading, it's just a for loop
reading past the end of a string because of the lack of a NULL char.
The patch adds the NULL char.

> Best Regards,
> Even Xu
>=20
> -----Original Message-----
> From: Todd Brandt <todd.e.brandt@linux.intel.com>=20
> Sent: Saturday, March 11, 2023 7:36 AM
> To: Philipp Jungkamp <p.jungkamp@gmx.net>; srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com>; linux-input@vger.kernel.org;
> linux-kernel@vger.kernel.org; Xu, Even <even.xu@intel.com>
> Cc: Jonathan.Cameron@huawei.com; jkosina@suse.cz; Brandt, Todd E
> <todd.e.brandt@intel.com>
> Subject: Re: BUG: hid-sensor-ids code includes binary data in device
> name
>=20
> On Fri, 2023-03-10 at 15:35 +0100, Philipp Jungkamp wrote:
> > Hello,
> >=20
> > on v3 of the patchset I had this comment on the 'real_usage'
> > initialization:
> >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char real_usage[HID_SENS=
OR_USAGE_LENGTH] =3D { 0 };
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char real_usage[HID_SENS=
OR_USAGE_LENGTH];
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct platform_dev=
ice *custom_pdev;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *dev_nam=
e;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char *c;
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* copy real usage id */
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy(real_usage, known=
_sensor_luid[index], 4);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy(real_usage, match=
->luid, 4);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0real_usage[4] =3D '\0';
> > >=20
> > > Why the change in approach for setting the NULL character?
> > > Doesn't seem relevant to main purpose of this patch.
> >=20
> > Based on the comment, I changed that in the final v4 revision to:
> >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char real_usage[HID_SENSOR_USAG=
E_LENGTH] =3D { 0 };
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char real_usage[HID_SENSOR_USAG=
E_LENGTH];
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct platform_device *cu=
stom_pdev;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *dev_name;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *c;
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* copy real usage id */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(real_usage, known_sensor=
_luid[index], 4);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(real_usage, match->luid,=
 4);
> >=20
> > I ommitted the line adding the null terminator to the string but
> > kept=20
> > that I didn't initialize the 'real_usage' as { 0 } anymore. The
> > string=20
> > now misses the null terminator which leads to the broken utf-8.
> >=20
> > The simple fix is to reintroduce the 0 initialization in=20
> > hid_sensor_register_platform_device. E.g.
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char real_usage[HID_SENSOR_U=
SAGE_LENGTH];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char real_usage[HID_SENSOR_U=
SAGE_LENGTH] =3D { 0 };
> >=20
>=20
> I didn't realize that the issue was a buffer overrun. I tested the
> kernel built with this simple fix and it works ok now. i.e. this
> patch is is all that's needed:
>=20
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> sensor- custom.c index 3e3f89e01d81..d85398721659 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -940,7 +940,7 @@ hid_sensor_register_platform_device(struct
> platform_device *pdev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hid_=
sensor_hub_device
> *hsdev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struc=
t
> hid_sensor_custom_match *match)=C2=A0 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char real_usage[HID_SENSOR_USAGE_LE=
NGTH];
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char real_usage[HID_SENSOR_USAGE_LE=
NGTH] =3D { 0 };
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct platform_device *custom=
_pdev;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *dev_name;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *c;
>=20
> > Where do I need to submit a patch for this? And on which tree
> > should I=20
> > base the patch?
> >=20
>=20
> The change is so small it shouldn't require any rebasing. Just send
> the
> patch to these emails (from MAINTAINERS):
>=20
> HID SENSOR HUB DRIVERS
> M:=C2=A0 Jiri Kosina <jikos@kernel.org>
> M:=C2=A0 Jonathan Cameron <jic23@kernel.org>
> M:=C2=A0 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> L:=C2=A0 linux-input@vger.kernel.org
> L:=C2=A0 linux-iio@vger.kernel.org
>=20
> > I'm sorry for the problems my patch caused.
> >=20
>=20
> No problem. It actually made sleepgraph better because it exposed a
> bug
> in the ftrace processing code. I wasn't properly handling the corner
> case where ftrace had binary data in it.
>=20
> > Regards,
> > Philipp Jungkamp
> >=20
> > On Fri, 2023-03-10 at 01:51 -0800, srinivas pandruvada wrote:
> > > +Even
> > >=20
> > > On Thu, 2023-03-09 at 15:33 -0800, Todd Brandt wrote:
> > > > Hi all, I've run into an issue in 6.3.0-rc1 that causes
> > > > problems
> > > > with
> > > > ftrace and I've bisected it to this commit:
> > > >=20
> > > > commit 98c062e8245199fa9121141a0bf1035dc45ae90e (HEAD,
> > > > refs/bisect/bad)
> > > > Author: Philipp Jungkamp p.jungkamp@gmx.net
> > > > Date:=C2=A0=C2=A0 Fri Nov 25 00:38:38 2022 +0100
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 HID: hid-sensor-custom: Allow more custom iio se=
nsors
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 The known LUID table for established/known custo=
m HID
> > > > sensors
> > > > was
> > > > =C2=A0=C2=A0=C2=A0 limited to sensors with "INTEL" as manufacturer.=
 But some
> > > > vendors
> > > > such
> > > > =C2=A0=C2=A0=C2=A0 as Lenovo also include fairly standard iio senso=
rs (e.g.
> > > > ambient
> > > > light)
> > > > =C2=A0=C2=A0=C2=A0 in their custom sensors.
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 Expand the known custom sensors table by a tag u=
sed for the
> > > > platform
> > > > =C2=A0=C2=A0=C2=A0 device name and match sensors based on the LUID =
as well as
> > > > optionally
> > > > =C2=A0=C2=A0=C2=A0 on model and manufacturer properties.
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 Signed-off-by: Philipp Jungkamp p.jungkamp@gmx.n=
et
> > > > =C2=A0=C2=A0=C2=A0 Reviewed-by: Jonathan Cameron Jonathan.Cameron@h=
uawei.com
> > > > =C2=A0=C2=A0=C2=A0 Acked-by: Srinivas Pandruvada
> > > > srinivas.pandruvada@linux.intel.com
> > > > =C2=A0=C2=A0=C2=A0 Signed-off-by: Jiri Kosina jkosina@suse.cz
> > > >=20
> > > > You're using raw data as part of the devname in the
> > > > "real_usage"
> > > > string, but it includes chars other than ASCII, and those chars
> > > > end
> > > > up being printed out in the ftrace log which is meant to be
> > > > ASCII
> > > > only.
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* HID-SENSOR-INT-REAL_USAGE_=
ID */
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name =3D kasprintf(GFP_KE=
RNEL, "HID-SENSOR-INT-%s",
> > > > real_usage);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* HID-SENSOR-TAG-REAL_USAGE_=
ID */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name =3D kasprintf(GFP_KE=
RNEL, "HID-SENSOR-%s-%s",
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 match->tag, real_usage);
> > > >=20
> > > > My sleepgraph tool started to crash because it read these lines
> > > > from
> > > > ftrace:
> > > >=20
> > > > device_pm_callback_start: platform HID-SENSOR-INT-
> > > > 020b?.39.auto,
> > > > parent: 001F:8087:0AC2.0003, [suspend]
> > > > device_pm_callback_end: platform HID-SENSOR-INT-020b?.39.auto,
> > > > err=3D0
> > > >=20
> > >=20
> > > Here tag is:
> > > .tag =3D "INT",
> > > .luid =3D "020B000000000000",
> > >=20
> > >=20
> > > The LUID is still a string. Probably too long for a dev_name.
> > >=20
> > > Even,
> > >=20
> > > Please check.
> > >=20
> > > Thanks.
> > > Srinivas
> > >=20
> > >=20
> > > > The "HID-SENSOR-INT-020b?.39.auto" string includes a binary
> > > > char
> > > > that
> > > > kills
> > > > python3 code that loops through an ascii file as such:
> > > >=20
> > > > =C2=A0 File "/usr/bin/sleepgraph", line 5579, in executeSuspend
> > > > =C2=A0=C2=A0=C2=A0 for line in fp:
> > > > =C2=A0 File "/usr/lib/python3.10/codecs.py", line 322, in decode
> > > > =C2=A0=C2=A0=C2=A0 (result, consumed) =3D self._buffer_decode(data,=
 self.errors,
> > > > final)
> > > > UnicodeDecodeError: 'utf-8' codec can't decode byte 0xff in
> > > > position
> > > > 1568: invalid start byte
> > > >=20
> > > > I've updated sleepgraph to handle random non-ascii chars, but
> > > > other
> > > > tools
> > > > may suffer the same fate. Can you rewrite this to ensure that
> > > > no
> > > > binary
> > > > chars make it into the devname?
> > > >=20
> >=20
> >=20
>=20

