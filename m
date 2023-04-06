Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646C26DA067
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbjDFS4X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Apr 2023 14:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbjDFS4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:56:19 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2559039;
        Thu,  6 Apr 2023 11:56:17 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id g18so3723274ejx.7;
        Thu, 06 Apr 2023 11:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEDpzpwkdqfhFP/l/6sXm+y2yJSiLZZYXAjgzwTJOBs=;
        b=GDlLdDlSQbNiLnFVm4JxjQMX9RMjDUUhgGrHHonW9lRrB0ofKc7mIkhPnP/qY4UNJJ
         cy8PW3k/x810yHsL/n+7mtO8sXKVHNQVGx+lwS5PoPMsaDLjMf3TwQPs4hnKae3SDd2f
         4WRpdY1vJSgD/YWSM6wZSboJyUSzjlaOEnNuR2HO5FeirSDOVf8lFG1mug+F11GfVkMx
         Vr46pibwSGRXn6JQQl8q6//FoKpNc3/0gFQJfalcfhwPUiJ4VD7WFQmDdp7Vas8Nt6Nt
         F6y/Ux7cDPchYWO+/IlxMYnqY2UJkYua2qpvO5dj7bP3HoB5zcrUwEXfAiit9nA7OU6R
         vPWA==
X-Gm-Message-State: AAQBX9f0g9LgT4npSda3srYPsT3WhGhL/Rnsgadonf3BBI3kb3Yq7BVw
        XVDmpyImLitmqAuxaEuLCBGfboDvktNWwYGsE7qiwd3ScSM=
X-Google-Smtp-Source: AKy350ZPtxgdFNbkE7L7jiTI8uCvV0sp0NYQC5OkT2/2pLMSELS/yH3WjhuSBlqbV/D5LJBazrjoLKwBj6/6GSTwHa4=
X-Received: by 2002:a17:907:96a5:b0:946:a095:b314 with SMTP id
 hd37-20020a17090796a500b00946a095b314mr3678555ejc.2.1680807375859; Thu, 06
 Apr 2023 11:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230331165336.1047102-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0jocwROiayCpkp2CrmOFrBSShO5zPicWZQzaM+rj_25zg@mail.gmail.com>
 <221ff60648e0e76920cb5054e9cfb98ec77612b1.camel@linux.intel.com>
 <CAJZ5v0gSfNpPx_6daiHSrzozeqU7iMnErbMhD6fBU9w3EtYhJw@mail.gmail.com> <a32bbd493a8d9decc275c327d40e15985e11b0be.camel@linux.intel.com>
In-Reply-To: <a32bbd493a8d9decc275c327d40e15985e11b0be.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Apr 2023 20:56:04 +0200
Message-ID: <CAJZ5v0j2KG9+ozSkHZ9uiBca9c0tG8Nz_QH7w=DkwkChmJbp0w@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/intel/int340x: Add DLVR support
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 7:55 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2023-04-04 at 18:46 +0200, Rafael J. Wysocki wrote:
> > On Tue, Apr 4, 2023 at 6:39 PM srinivas pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > On Mon, 2023-04-03 at 20:37 +0200, Rafael J. Wysocki wrote:
> > > > On Fri, Mar 31, 2023 at 6:53 PM Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > >
> > > > > Add support for DLVR (Digital Linear Voltage Regulator)
> > > > > attributes,
> > > > > which can be used to control RFIM.
> > > > > Here instead of "fivr" another directory "dlvr" is created with
> > > > > DLVR
> > > > > attributes:
> > > > >
> > > > > /sys/bus/pci/devices/0000:00:04.0/dlvr
> > > > > ├── dlvr_freq_mhz
> > > > > ├── dlvr_freq_select
> > > > > ├── dlvr_hardware_rev
> > > > > ├── dlvr_pll_busy
> > > > > ├── dlvr_rfim_enable
> > > > > └── dlvr_spread_spectrum_pct
> > > > >
> > > > > Attributes
> > > > > dlvr_freq_mhz (RO):
> > > > > Current DLVR PLL frequency in MHz.
> > > > >
> > > > > dlvr_freq_select (RW):
> > > > > Sets DLVR PLL clock frequency.
> > > > >
> > > > > dlvr_hardware_rev (RO):
> > > > > DLVR hardware revision.
> > > > >
> > > > > dlvr_pll_busy (RO):
> > > > > PLL can't accept frequency change when set.
> > > > >
> > > > > dlvr_rfim_enable (RW):
> > > > > 0: Disable RF frequency hopping, 1: Enable RF frequency
> > > > > hopping.
> > > > >
> > > > > dlvr_spread_spectrum_pct (RW)
> > > > > A write to this register updates the DLVR spread spectrum
> > > > > percent
> > > > > value.
> > > >
> > > > How is this attribute going to be used by user space in practice?
> > >
> > > Spread spectrum percent helps to reduce the DLVR clock noise to
> > > meet
> > > regulatory compliance. This spreading % increases bandwidth of
> > > signal
> > > transmission and hence reduces the effects of interference, noise,
> > > and
> > > signal fading.
> >
> > The above information should be added to the documentation I think.
> >
> > Still, I would like to know when user space is going to write to it
> > and how it is going to find out what value to write.
> As specified in the
> https://docs.kernel.org/driver-api/thermal/intel_dptf.html
> This is all related to reduce interference with WiFi radio frequencies.

So the first two paragraphs in the "DPTF Processor thermal RFIM
interface" section need to be updated to mention/cover DLVR.  Then, it
will all be clear (at least AFAIAC).

> The algorithm should be read current dlvr_freq_mhz,
> dlvr_spread_spectrum_pct, current WiFi frequency (channel has a fix
> freq), find the error in WiFi frame error rates (From WiFi module), and
> do small adjustment +- to dlvr_freq. While changing the dlvr
> frequencies you may induce more interference so you spread the signal
> to reduce S/N ratio using this percent knob.
>
> >
> > > > Also should it be split like the frequency one (for consistency)?
> > >
> > > This is a RW field and is applied immediately unlike frequency,
> > > where
> > > it is two step process. First you specify and enable and then see
> > > the
> > > effect. So they are two fields.
> >
> > I was talking about dlvr_freq_mhz (RO) and dlvr_freq_select (RW).
> > I'm
> > not sure how the above is related to them TBH.
> The frequency is the base signal to which interference must be reduced.
> A good explanation for this technique
> https://www.eetimes.com/tutorial-on-spread-spectrum-technology/

Yes, I know what "spread spectrum" means.
