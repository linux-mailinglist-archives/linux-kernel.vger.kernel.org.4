Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0033E6D6AFB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbjDDRzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbjDDRzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:55:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850EB35A6;
        Tue,  4 Apr 2023 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680630947; x=1712166947;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ftIB+tKx2BRDAIoJzyNRehniJ6AZq5kLCytThxBFL2I=;
  b=cRoigRy71IUqyqno/OJ8arnQ3cT2A/ZMSjIhi8srvDUAnh8avqFlk44j
   2C+Qh+nxyo4sVZzzXtn00VIH6fkTuZESx0odTS/PF7wwJi+O9FxPgeVim
   vT1OrWZu6ZW1+5X/4by74Lm7PJiXyTq2LOJDPyns2OuuqKX1B4GxmvINY
   Ve1RFkbdS+db+77gqvikVbKhWmQtrCnViN4PVoF6Gf3VvEIO7JymUhPbm
   ScxKjCr4mhXVbXdqZSgYTKBLqzsANhVX1G16NQz2uwCEooLPOVo0EKqP5
   7tnrYhuNBS49SCgFnIh0tBTHW93v1RUVu0eRYecyuSmuK1JSxZYJPnerc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="405029064"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="405029064"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 10:55:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="775733761"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="775733761"
Received: from vukivan-mobl2.amr.corp.intel.com ([10.212.38.37])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 10:55:29 -0700
Message-ID: <a32bbd493a8d9decc275c327d40e15985e11b0be.camel@linux.intel.com>
Subject: Re: [PATCH] thermal/drivers/intel/int340x: Add DLVR support
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Apr 2023 10:55:28 -0700
In-Reply-To: <CAJZ5v0gSfNpPx_6daiHSrzozeqU7iMnErbMhD6fBU9w3EtYhJw@mail.gmail.com>
References: <20230331165336.1047102-1-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0jocwROiayCpkp2CrmOFrBSShO5zPicWZQzaM+rj_25zg@mail.gmail.com>
         <221ff60648e0e76920cb5054e9cfb98ec77612b1.camel@linux.intel.com>
         <CAJZ5v0gSfNpPx_6daiHSrzozeqU7iMnErbMhD6fBU9w3EtYhJw@mail.gmail.com>
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

On Tue, 2023-04-04 at 18:46 +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 4, 2023 at 6:39=E2=80=AFPM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > On Mon, 2023-04-03 at 20:37 +0200, Rafael J. Wysocki wrote:
> > > On Fri, Mar 31, 2023 at 6:53=E2=80=AFPM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > >=20
> > > > Add support for DLVR (Digital Linear Voltage Regulator)
> > > > attributes,
> > > > which can be used to control RFIM.
> > > > Here instead of "fivr" another directory "dlvr" is created with
> > > > DLVR
> > > > attributes:
> > > >=20
> > > > /sys/bus/pci/devices/0000:00:04.0/dlvr
> > > > =E2=94=9C=E2=94=80=E2=94=80 dlvr_freq_mhz
> > > > =E2=94=9C=E2=94=80=E2=94=80 dlvr_freq_select
> > > > =E2=94=9C=E2=94=80=E2=94=80 dlvr_hardware_rev
> > > > =E2=94=9C=E2=94=80=E2=94=80 dlvr_pll_busy
> > > > =E2=94=9C=E2=94=80=E2=94=80 dlvr_rfim_enable
> > > > =E2=94=94=E2=94=80=E2=94=80 dlvr_spread_spectrum_pct
> > > >=20
> > > > Attributes
> > > > dlvr_freq_mhz (RO):
> > > > Current DLVR PLL frequency in MHz.
> > > >=20
> > > > dlvr_freq_select (RW):
> > > > Sets DLVR PLL clock frequency.
> > > >=20
> > > > dlvr_hardware_rev (RO):
> > > > DLVR hardware revision.
> > > >=20
> > > > dlvr_pll_busy (RO):
> > > > PLL can't accept frequency change when set.
> > > >=20
> > > > dlvr_rfim_enable (RW):
> > > > 0: Disable RF frequency hopping, 1: Enable RF frequency
> > > > hopping.
> > > >=20
> > > > dlvr_spread_spectrum_pct (RW)
> > > > A write to this register updates the DLVR spread spectrum
> > > > percent
> > > > value.
> > >=20
> > > How is this attribute going to be used by user space in practice?
> >=20
> > Spread spectrum percent helps to reduce the DLVR clock noise to
> > meet
> > regulatory compliance. This spreading % increases bandwidth of
> > signal
> > transmission and hence reduces the effects of interference, noise,
> > and
> > signal fading.
>=20
> The above information should be added to the documentation I think.
>=20
> Still, I would like to know when user space is going to write to it
> and how it is going to find out what value to write.
As specified in the
https://docs.kernel.org/driver-api/thermal/intel_dptf.html
This is all related to reduce interference with WiFi radio frequencies.

The algorithm should be read current dlvr_freq_mhz,
dlvr_spread_spectrum_pct, current WiFi frequency (channel has a fix
freq), find the error in WiFi frame error rates (From WiFi module), and
do small adjustment +- to dlvr_freq. While changing the dlvr
frequencies you may induce more interference so you spread the signal
to reduce S/N ratio using this percent knob.

>=20
> > > Also should it be split like the frequency one (for consistency)?
> >=20
> > This is a RW field and is applied immediately unlike frequency,
> > where
> > it is two step process. First you specify and enable and then see
> > the
> > effect. So they are two fields.
>=20
> I was talking about dlvr_freq_mhz (RO) and dlvr_freq_select (RW).=C2=A0
> I'm
> not sure how the above is related to them TBH.
The frequency is the base signal to which interference must be reduced.
A good explanation for this technique
https://www.eetimes.com/tutorial-on-spread-spectrum-technology/

Thanks,
Srinivas
