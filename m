Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB99B6A6EC1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjCAOqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCAOqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:46:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D827341B6A;
        Wed,  1 Mar 2023 06:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677681981; x=1709217981;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=tIoAL1bJ+p6ZTKGLQdWmJnf61svB7jIShOa0y3SV7bk=;
  b=CNCYUjYKDuYZK/SAhOt1D0podQ33Pc1jKMXyUtwf0xIkuWygOsqCPRwa
   hA80wPDF2kRQ1kdFU6z1UX67+3eDUaXOBKgd/ZOOrme+X32VdOGnhHjlo
   om/pSLBQqeqof84oACT8dZLK0nhz69UxoZjouFUhxkOSo+7uuIx0dyGCO
   rZ/euGgpL2HcFqGXVHvGRSLCD/po6MK1G2htWqfZBQGSlObFpcHm5LAXA
   r0zCBvt9OF83wl2zaLSFJ/fI1i3lFnv2JNZ5dvnZOF/fXiFa+jk54Gfya
   2851B0B8twfbwMT7cS/ZW0xwKXQDTV3+TehoWsE8mBgg9yLjsKYUh4+04
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="331903427"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="331903427"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 06:46:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="817588440"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="817588440"
Received: from smeeranx-mobl2.gar.corp.intel.com ([10.213.113.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 06:46:19 -0800
Message-ID: <fbad311a983902703ced27894d8e34a5e0b5d966.camel@linux.intel.com>
Subject: Re: [PATCH 12/12] platform/x86: ISST: Add suspend/resume callbacks
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Mar 2023 06:46:15 -0800
In-Reply-To: <bba19fc3-0cbc-7829-6721-7d84ac4d9136@redhat.com>
References: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
         <20230211063257.311746-13-srinivas.pandruvada@linux.intel.com>
         <bba19fc3-0cbc-7829-6721-7d84ac4d9136@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Wed, 2023-03-01 at 15:40 +0100, Hans de Goede wrote:
> Hi,
>=20
> On 2/11/23 07:32, Srinivas Pandruvada wrote:
> > To support S3/S4 with TPMI interface add suspend/resume callbacks.
> > Here HW state is stored in suspend callback and restored during
> > resume callback.
> >=20
> > The hardware state which needs to be stored/restored:
> > - CLOS configuration
> > - CLOS Association
> > - SST-CP enable/disable status
> > - SST-PP perf level setting
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > =C2=A0.../x86/intel/speed_select_if/isst_tpmi.c=C2=A0=C2=A0=C2=A0=C2=A0=
 | 21 ++++++++
> > =C2=A0.../intel/speed_select_if/isst_tpmi_core.c=C2=A0=C2=A0=C2=A0 | 49
> > +++++++++++++++++++
> > =C2=A0.../intel/speed_select_if/isst_tpmi_core.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +
> > =C2=A03 files changed, 72 insertions(+)
> >=20
> > diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
> > b/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
> > index 7b4bdeefb8bc..ef39870c9829 100644
> > --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
> > +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
> > @@ -34,6 +34,24 @@ static void intel_sst_remove(struct
> > auxiliary_device *auxdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpmi_sst_exit();
> > =C2=A0}
> > =C2=A0
> > +static int __maybe_unused intel_sst_suspend(struct device *dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpmi_sst_dev_suspend(to_auxi=
liary_dev(dev));
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +}
> > +
> > +static int __maybe_unused intel_sst_resume(struct device *dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpmi_sst_dev_resume(to_auxil=
iary_dev(dev));
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +}
>=20
> Please drop the __maybe_unused here; and
OK.

>=20
> > +
> > +static const struct dev_pm_ops intel_sst_pm =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SET_SYSTEM_SLEEP_PM_OPS(inte=
l_sst_suspend,
> > intel_sst_resume)
> > +};
> > +
>=20
> Replace this with:
>=20
> static DEFINE_SIMPLE_DEV_PM_OPS(intel_sst_pm, intel_sst_suspend,
> intel_sst_resume);
>=20
Sure.

> > =C2=A0static const struct auxiliary_device_id intel_sst_id_table[] =3D =
{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .name =3D "intel_vsec=
.tpmi-sst" },
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{}
> > @@ -44,6 +62,9 @@ static struct auxiliary_driver
> > intel_sst_aux_driver =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.id_table=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D intel_sst_id_table,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.remove=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D intel_sst_remove,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D intel_sst_probe,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.driver =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.pm =3D &intel_sst_pm,
>=20
> And use:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.pm =3D pm_sleep_ptr(&intel_sst_pm),
>=20
>=20
> Here, this is the new #ifdef and __maybe_unused free way of dealing
> with pm_ops.

Sure.

Thanks,
Srinivas

>=20
> Regards,
>=20
> Hans
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > =C2=A0};
> > =C2=A0
> > =C2=A0module_auxiliary_driver(intel_sst_aux_driver);
> > diff --git
> > a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > index 9eaff90bb649..e173167085ea 100644
> > --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > @@ -229,6 +229,10 @@ struct perf_level {
> > =C2=A0 * @status_offset:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Store the status =
offset for each PP-level
> > =C2=A0 * @sst_base:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0Mapped SST base IO memory
> > =C2=A0 * @auxdev:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0Auxiliary device instance enumerated this
> > instance
> > + * @saved_sst_cp_control: Save SST-CP control configuration to
> > store restore for suspend/resume
> > + * @saved_clos_configs:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Save SST-CP CLOS configuration to
> > store restore for suspend/resume
> > + * @saved_clos_assocs:=C2=A0Save SST-CP CLOS association to store
> > restore for suspend/resume
> > + * @saved_pp_control:=C2=A0=C2=A0Save SST-PP control information to st=
ore
> > restore for suspend/resume
> > =C2=A0 *
> > =C2=A0 * This structure is used store complete SST information for a
> > power_domain. This information
> > =C2=A0 * is used to read/write request for any SST IOCTL. Each physical
> > CPU package can have multiple
> > @@ -250,6 +254,10 @@ struct tpmi_per_power_domain_info {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pp_status_offset=
 status_offset;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void __iomem *sst_base;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct auxiliary_device=
 *auxdev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 saved_sst_cp_control;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 saved_clos_configs[4];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 saved_clos_assocs[4];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 saved_pp_control;
> > =C2=A0};
> > =C2=A0
> > =C2=A0/**
> > @@ -1333,6 +1341,47 @@ void tpmi_sst_dev_remove(struct
> > auxiliary_device *auxdev)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_remove, INTEL_TPMI_SST);
> > =C2=A0
> > +void tpmi_sst_dev_suspend(struct auxiliary_device *auxdev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpmi_sst_struct *tpmi=
_sst =3D
> > auxiliary_get_drvdata(auxdev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpmi_per_power_domain=
_info *power_domain_info =3D
> > tpmi_sst->power_domain_info;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void __iomem *cp_base;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cp_base =3D power_domain_inf=
o->sst_base + power_domain_info-
> > >sst_header.cp_offset;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0power_domain_info->saved_sst=
_cp_control =3D readq(cp_base +
> > SST_CP_CONTROL_OFFSET);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy_fromio(power_domain_i=
nfo->saved_clos_configs,
> > cp_base + SST_CLOS_CONFIG_0_OFFSET,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(power_domain_inf=
o-
> > >saved_clos_configs));
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy_fromio(power_domain_i=
nfo->saved_clos_assocs, cp_base
> > + SST_CLOS_ASSOC_0_OFFSET,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(power_domain_inf=
o-
> > >saved_clos_assocs));
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0power_domain_info->saved_pp_=
control =3D
> > readq(power_domain_info->sst_base +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
> > power_domain_info->sst_header.pp_offset +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
> > SST_PP_CONTROL_OFFSET);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_suspend, INTEL_TPMI_SST);
> > +
> > +void tpmi_sst_dev_resume(struct auxiliary_device *auxdev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpmi_sst_struct *tpmi=
_sst =3D
> > auxiliary_get_drvdata(auxdev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpmi_per_power_domain=
_info *power_domain_info =3D
> > tpmi_sst->power_domain_info;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void __iomem *cp_base;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cp_base =3D power_domain_inf=
o->sst_base + power_domain_info-
> > >sst_header.cp_offset;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0writeq(power_domain_info->sa=
ved_sst_cp_control, cp_base +
> > SST_CP_CONTROL_OFFSET);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy_toio(cp_base + SST_CL=
OS_CONFIG_0_OFFSET,
> > power_domain_info->saved_clos_configs,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(power_domain_info->saved_clo=
s_configs));
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy_toio(cp_base + SST_CL=
OS_ASSOC_0_OFFSET,
> > power_domain_info->saved_clos_assocs,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(power_domain_info->saved_clo=
s_assocs));
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0writeq(power_domain_info->sa=
ved_pp_control,
> > power_domain_info->sst_base +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0power_domain_info-
> > >sst_header.pp_offset + SST_PP_CONTROL_OFFSET);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_resume, INTEL_TPMI_SST);
> > +
> > =C2=A0#define ISST_TPMI_API_VERSION=C2=A0=C2=A00x02
> > =C2=A0
> > =C2=A0int tpmi_sst_init(void)
> > diff --git
> > a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h
> > b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h
> > index 356cb02273b1..900b483703f9 100644
> > --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h
> > +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h
> > @@ -13,4 +13,6 @@ int tpmi_sst_init(void);
> > =C2=A0void tpmi_sst_exit(void);
> > =C2=A0int tpmi_sst_dev_add(struct auxiliary_device *auxdev);
> > =C2=A0void tpmi_sst_dev_remove(struct auxiliary_device *auxdev);
> > +void tpmi_sst_dev_suspend(struct auxiliary_device *auxdev);
> > +void tpmi_sst_dev_resume(struct auxiliary_device *auxdev);
> > =C2=A0#endif
>=20

