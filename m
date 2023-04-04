Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86BC6D6917
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbjDDQkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjDDQkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:40:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5863C14;
        Tue,  4 Apr 2023 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680626396; x=1712162396;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=arxykT6zJLkusc/srhfdiYq16uuQAHCHPFMD+Zxq58s=;
  b=F17K1gzb7cfgAk2djGQPQt9fGTDJk1nliPvTO7WKORjra0TBTxtpSOcN
   P72MDt6fk1q2bBPfQ25o1MYGUXsM+SRx1bP1SJFDUt2K20D6KMlPhTTiV
   3R7AvfSG2DDxh3Hv4rwL/wej8D1pRZ8okKvv7zA4Kk/oTzmBxKStQ04cH
   sOswitItTMHwspmHKCaLnXwg7tSIAfW7GmdwgPedGtqNjarGwwL2E/tcE
   F/PVAk4gSN6QAk7Mc+GYiRCJf8ApMzMbLkdzyLtgV1Ha5Rk4HARf59Utf
   uUI41xDZccZmmOH1VLNHGSXjy9HjttvoTJGvyh1o04tdRjNBI1Uzij9JT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="339729840"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="339729840"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 09:39:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="688969124"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="688969124"
Received: from vukivan-mobl2.amr.corp.intel.com ([10.212.38.37])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 09:39:54 -0700
Message-ID: <221ff60648e0e76920cb5054e9cfb98ec77612b1.camel@linux.intel.com>
Subject: Re: [PATCH] thermal/drivers/intel/int340x: Add DLVR support
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Apr 2023 09:39:53 -0700
In-Reply-To: <CAJZ5v0jocwROiayCpkp2CrmOFrBSShO5zPicWZQzaM+rj_25zg@mail.gmail.com>
References: <20230331165336.1047102-1-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0jocwROiayCpkp2CrmOFrBSShO5zPicWZQzaM+rj_25zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-04-03 at 20:37 +0200, Rafael J. Wysocki wrote:
> On Fri, Mar 31, 2023 at 6:53=E2=80=AFPM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > Add support for DLVR (Digital Linear Voltage Regulator) attributes,
> > which can be used to control RFIM.
> > Here instead of "fivr" another directory "dlvr" is created with
> > DLVR
> > attributes:
> >=20
> > /sys/bus/pci/devices/0000:00:04.0/dlvr
> > =E2=94=9C=E2=94=80=E2=94=80 dlvr_freq_mhz
> > =E2=94=9C=E2=94=80=E2=94=80 dlvr_freq_select
> > =E2=94=9C=E2=94=80=E2=94=80 dlvr_hardware_rev
> > =E2=94=9C=E2=94=80=E2=94=80 dlvr_pll_busy
> > =E2=94=9C=E2=94=80=E2=94=80 dlvr_rfim_enable
> > =E2=94=94=E2=94=80=E2=94=80 dlvr_spread_spectrum_pct
> >=20
> > Attributes
> > dlvr_freq_mhz (RO):
> > Current DLVR PLL frequency in MHz.
> >=20
> > dlvr_freq_select (RW):
> > Sets DLVR PLL clock frequency.
> >=20
> > dlvr_hardware_rev (RO):
> > DLVR hardware revision.
> >=20
> > dlvr_pll_busy (RO):
> > PLL can't accept frequency change when set.
> >=20
> > dlvr_rfim_enable (RW):
> > 0: Disable RF frequency hopping, 1: Enable RF frequency hopping.
> >=20
> > dlvr_spread_spectrum_pct (RW)
> > A write to this register updates the DLVR spread spectrum percent
> > value.
>=20
> How is this attribute going to be used by user space in practice?
Spread spectrum percent helps to reduce the DLVR clock noise to meet
regulatory compliance. This spreading % increases bandwidth of signal
transmission and hence reduces the effects of interference, noise, and
signal fading.


> Also should it be split like the frequency one (for consistency)?
This is a RW field and is applied immediately unlike frequency, where
it is two step process. First you specify and enable and then see the
effect. So they are two fields.

Thanks,
Srinivas

>=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > =C2=A0.../driver-api/thermal/intel_dptf.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 25 ++++++
> > =C2=A0.../processor_thermal_device.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +-
> > =C2=A0.../processor_thermal_device.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0.../processor_thermal_device_pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0.../int340x_thermal/processor_thermal_rfim.c=C2=A0 | 80
> > +++++++++++++++++--
> > =C2=A05 files changed, 104 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/Documentation/driver-api/thermal/intel_dptf.rst
> > b/Documentation/driver-api/thermal/intel_dptf.rst
> > index f5c193cccbda..da906deb6a7d 100644
> > --- a/Documentation/driver-api/thermal/intel_dptf.rst
> > +++ b/Documentation/driver-api/thermal/intel_dptf.rst
> > @@ -264,6 +264,31 @@ DVFS attributes
> > =C2=A0``rfi_disable (RW)``
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Disable DDR rate change feat=
ure
> >=20
> > +DLVR attributes
> > +
> > +:file:`/sys/bus/pci/devices/0000\:00\:04.0/dlvr/`
> > +
> > +``dlvr_hardware_rev`` (RO)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DLVR hardware revision.
> > +
> > +``dlvr_freq_mhz`` (RO)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Current DLVR PLL frequency in MHz=
.
> > +
> > +``dlvr_freq_select`` (RW)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Sets DLVR PLL clock frequency. On=
ce set, and enabled via
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dlvr_rfim_enable, the dlvr_freq_m=
hz will show the current
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DLVR PLL frequency.
> > +
> > +``dlvr_pll_busy`` (RO)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PLL can't accept frequency change=
 when set.
> > +
> > +``dlvr_rfim_enable`` (RW)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0: Disable RF frequency hopping, =
1: Enable RF frequency
> > hopping.
> > +
> > +``dlvr_spread_spectrum_pct`` (RW)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Sets DLVR spread spectrum percent=
 value.
> > +
> > +
> > =C2=A0DPTF Power supply and Battery Interface
> > =C2=A0----------------------------------------
> >=20
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > index a1dc18be7609..3ca0a2f5937f 100644
> > ---
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > +++
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > @@ -337,7 +337,8 @@ int proc_thermal_mmio_add(struct pci_dev *pdev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (feature_mask & PROC_THER=
MAL_FEATURE_FIVR ||
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 feature_m=
ask & PROC_THERMAL_FEATURE_DVFS) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 feature_m=
ask & PROC_THERMAL_FEATURE_DVFS ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 feature_m=
ask & PROC_THERMAL_FEATURE_DLVR) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D proc_thermal_rfim_add(pdev, proc_priv);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_e=
rr(&pdev->dev, "failed to add RFIM
> > interface\n");
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> > index 7d52fcff4937..7acaa8f1b896 100644
> > ---
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> > +++
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> > @@ -60,6 +60,7 @@ struct rapl_mmio_regs {
> > =C2=A0#define PROC_THERMAL_FEATURE_FIVR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x02
> > =C2=A0#define PROC_THERMAL_FEATURE_DVFS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x04
> > =C2=A0#define PROC_THERMAL_FEATURE_MBOX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x08
> > +#define PROC_THERMAL_FEATURE_DLVR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x10
> >=20
> > =C2=A0#if IS_ENABLED(CONFIG_PROC_THERMAL_MMIO_RAPL)
> > =C2=A0int proc_thermal_rapl_add(struct pci_dev *pdev, struct
> > proc_thermal_device *proc_priv);
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pc
> > i.c
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pc
> > i.c
> > index 90526f46c9b1..aaff67377250 100644
> > ---
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pc
> > i.c
> > +++
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pc
> > i.c
> > @@ -352,7 +352,7 @@ static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm,
> > proc_thermal_pci_suspend,
> >=20
> > =C2=A0static const struct pci_device_id proc_thermal_pci_ids[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { PCI_DEVICE_DATA(INTEL, ADL=
_THERMAL,
> > PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR |
> > PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { PCI_DEVICE_DATA(INTEL, MTLP_THE=
RMAL,
> > PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR |
> > PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { PCI_DEVICE_DATA(INTEL, MTLP_THE=
RMAL,
> > PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR |
> > PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX |
> > PROC_THERMAL_FEATURE_DLVR) },
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { PCI_DEVICE_DATA(INTEL, RPL=
_THERMAL,
> > PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR |
> > PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { },
> > =C2=A0};
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> > index 92ed1213fe37..951a0869982a 100644
> > ---
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> > +++
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> > @@ -39,6 +39,25 @@ static const struct mmio_reg
> > tgl_fivr_mmio_regs[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 1, 0x5A14, 2, 0x3, 1}, /* =
fivr_fffc_rev */
> > =C2=A0};
> >=20
> > +static const char * const dlvr_strings[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "dlvr_spread_spectrum_pct",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "dlvr_rfim_enable",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "dlvr_freq_select",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "dlvr_hardware_rev",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "dlvr_freq_mhz",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "dlvr_pll_busy",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL
> > +};
> > +
> > +static const struct mmio_reg dlvr_mmio_regs[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0, 0x15A08, 5, 0x1F, 0}, /* dlv=
r_spread_spectrum_pct */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0, 0x15A08, 1, 0x1, 7}, /* dlvr=
_rfim_enable */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0, 0x15A08, 12, 0xFFF, 8}, /* d=
lvr_freq_select */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 1, 0x15A10, 2, 0x3, 30}, /* dlv=
r_hardware_rev */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 1, 0x15A10, 16, 0xFFFF, 0}, /* =
dlvr_freq_mhz */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 1, 0x15A10, 1, 0x1, 16}, /* dlv=
r_pll_busy */
> > +};
> > +
> > =C2=A0/* These will represent sysfs attribute names */
> > =C2=A0static const char * const dvfs_strings[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "rfi_restriction_run_busy",
> > @@ -78,14 +97,16 @@ static ssize_t suffix##_show(struct device
> > *dev,\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;\
> > =C2=A0\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 proc_priv =3D pci_get_drvdat=
a(pdev);\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (table) {\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (table =3D=3D 1) {\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 match_strs =3D (const char **)dvfs_strings;\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mmio_regs =3D adl_dvfs_mmio_regs;\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else { \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (table =3D=3D 2) { \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 match_strs =3D (const char **)dlvr_strings;\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mmio_regs =3D dlvr_mmio_regs;\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 match_strs =3D (const char **)fivr_strings;\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mmio_regs =3D tgl_fivr_mmio_regs;\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D match_string(match_s=
trs, -1, attr->attr.name);\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return ret;\
> > @@ -109,10 +130,13 @@ static ssize_t suffix##_store(struct device
> > *dev,\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 mask;\
> > =C2=A0\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 proc_priv =3D pci_get_drvdat=
a(pdev);\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (table) {\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (table =3D=3D 1) {\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 match_strs =3D (const char **)dvfs_strings;\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mmio_regs =3D adl_dvfs_mmio_regs;\
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else { \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (table =3D=3D 2) { \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 match_strs =3D (const char **)dlvr_strings;\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mmio_regs =3D dlvr_mmio_regs;\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 match_strs =3D (const char **)fivr_strings;\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mmio_regs =3D tgl_fivr_mmio_regs;\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } \
> > @@ -147,6 +171,39 @@ RFIM_STORE(spread_spectrum_clk_enable, 0)
> > =C2=A0RFIM_STORE(rfi_vco_ref_code, 0)
> > =C2=A0RFIM_STORE(fivr_fffc_rev, 0)
> >=20
> > +RFIM_SHOW(dlvr_spread_spectrum_pct, 2)
> > +RFIM_SHOW(dlvr_hardware_rev, 2)
> > +RFIM_SHOW(dlvr_freq_mhz, 2)
> > +RFIM_SHOW(dlvr_pll_busy, 2)
> > +RFIM_SHOW(dlvr_freq_select, 2)
> > +RFIM_SHOW(dlvr_rfim_enable, 2)
> > +
> > +RFIM_STORE(dlvr_spread_spectrum_pct, 2)
> > +RFIM_STORE(dlvr_rfim_enable, 2)
> > +RFIM_STORE(dlvr_freq_select, 2)
> > +
> > +static DEVICE_ATTR_RW(dlvr_spread_spectrum_pct);
> > +static DEVICE_ATTR_RW(dlvr_freq_select);
> > +static DEVICE_ATTR_RO(dlvr_hardware_rev);
> > +static DEVICE_ATTR_RO(dlvr_freq_mhz);
> > +static DEVICE_ATTR_RO(dlvr_pll_busy);
> > +static DEVICE_ATTR_RW(dlvr_rfim_enable);
> > +
> > +static struct attribute *dlvr_attrs[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &dev_attr_dlvr_spread_spectrum_pc=
t.attr,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &dev_attr_dlvr_freq_select.attr,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &dev_attr_dlvr_hardware_rev.attr,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &dev_attr_dlvr_freq_mhz.attr,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &dev_attr_dlvr_pll_busy.attr,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &dev_attr_dlvr_rfim_enable.attr,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL
> > +};
> > +
> > +static const struct attribute_group dlvr_attribute_group =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .attrs =3D dlvr_attrs,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "dlvr"
> > +};
> > +
> > =C2=A0static DEVICE_ATTR_RW(vco_ref_code_lo);
> > =C2=A0static DEVICE_ATTR_RW(vco_ref_code_hi);
> > =C2=A0static DEVICE_ATTR_RW(spread_spectrum_pct);
> > @@ -277,12 +334,22 @@ int proc_thermal_rfim_add(struct pci_dev
> > *pdev, struct proc_thermal_device *proc
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n ret;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (proc_priv->mmio_feature_mask =
&
> > PROC_THERMAL_FEATURE_DLVR) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D sysfs_create_group(&pdev->dev.kobj,
> > &dlvr_attribute_group);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (proc_priv->mmio_feature_=
mask &
> > PROC_THERMAL_FEATURE_DVFS) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D sysfs_create_group(&pdev->dev.kobj,
> > &dvfs_attribute_group);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret && proc_priv->mmio_feature_mask &
> > PROC_THERMAL_FEATURE_FIVR) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs=
_remove_group(&pdev->dev.kobj,
> > &fivr_attribute_group);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n ret;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret && proc_priv->mmio_feature_mask &
> > PROC_THERMAL_FEATURE_DLVR) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs_remov=
e_group(&pdev->dev.kobj,
> > &dlvr_attribute_group);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > @@ -296,6 +363,9 @@ void proc_thermal_rfim_remove(struct pci_dev
> > *pdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (proc_priv->mmio_feature_=
mask &
> > PROC_THERMAL_FEATURE_FIVR)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 sysfs_remove_group(&pdev->dev.kobj,
> > &fivr_attribute_group);
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (proc_priv->mmio_feature_mask =
&
> > PROC_THERMAL_FEATURE_DLVR)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sysfs_remove_group(&pdev->dev.kobj,
> > &dlvr_attribute_group);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (proc_priv->mmio_feature_=
mask &
> > PROC_THERMAL_FEATURE_DVFS)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 sysfs_remove_group(&pdev->dev.kobj,
> > &dvfs_attribute_group);
> > =C2=A0}
> > --
> > 2.34.1
> >=20

