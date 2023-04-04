Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B55F6D692A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjDDQrQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Apr 2023 12:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjDDQrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:47:12 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9C81984;
        Tue,  4 Apr 2023 09:47:10 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id eg48so133075048edb.13;
        Tue, 04 Apr 2023 09:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680626828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rjLrrnskDNbWKR8U50P5trJH1+Yny1YAPt00x1bItg=;
        b=f9oGj38Av+8hBGLuoZ+UHFeO08qc9gQVgVjDsOg2AKhME5Y7mnn+tQwhKCXLFjHJmT
         c9mFVb8ZdoO8sBCbEXRCYoLIPyVo4gnp0hUXcpfi9V9dcYkxZyaefLWTUB06sjjd1VWb
         FwTjH6DzxI8TuOVI4iO0/UnGsmFKOTdaAI4s5XtVq43DV7W4L7/wG+RyfGNuZr6XUlI4
         iv0OuaqBWKqx3Qrxd65W/KCzYgEuSjjoKG1ULW5NpQ62iN1U1BpVnvVgumpBxPq4dAsL
         K7yCN8Iz2JnJ2sd7KufaMwA2W2xLySg6Ib+0c8RLuOrNWBLeZSVP7MMaarsp5AGFkHKp
         mFdA==
X-Gm-Message-State: AAQBX9fKe8GFqQuD3ud4KRezooq+1v0+WdmuZGyhL0FR4U/At8EOpYmp
        NQdqRqhbimRrYGH8O7P71xvpxgPHk4ukpQ+9WtI=
X-Google-Smtp-Source: AKy350brWgIA6KbY6yL1NOipc46ADFikMa4jkdWZwipGzUxilvua5UVV9VhZPM0DuMytBFhsf9DI9Xy5kgcNgyr6l40=
X-Received: by 2002:a50:ce14:0:b0:4fb:2593:846 with SMTP id
 y20-20020a50ce14000000b004fb25930846mr72865edi.3.1680626828541; Tue, 04 Apr
 2023 09:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230331165336.1047102-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0jocwROiayCpkp2CrmOFrBSShO5zPicWZQzaM+rj_25zg@mail.gmail.com> <221ff60648e0e76920cb5054e9cfb98ec77612b1.camel@linux.intel.com>
In-Reply-To: <221ff60648e0e76920cb5054e9cfb98ec77612b1.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Apr 2023 18:46:57 +0200
Message-ID: <CAJZ5v0gSfNpPx_6daiHSrzozeqU7iMnErbMhD6fBU9w3EtYhJw@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/intel/int340x: Add DLVR support
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 6:39 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2023-04-03 at 20:37 +0200, Rafael J. Wysocki wrote:
> > On Fri, Mar 31, 2023 at 6:53 PM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > Add support for DLVR (Digital Linear Voltage Regulator) attributes,
> > > which can be used to control RFIM.
> > > Here instead of "fivr" another directory "dlvr" is created with
> > > DLVR
> > > attributes:
> > >
> > > /sys/bus/pci/devices/0000:00:04.0/dlvr
> > > ├── dlvr_freq_mhz
> > > ├── dlvr_freq_select
> > > ├── dlvr_hardware_rev
> > > ├── dlvr_pll_busy
> > > ├── dlvr_rfim_enable
> > > └── dlvr_spread_spectrum_pct
> > >
> > > Attributes
> > > dlvr_freq_mhz (RO):
> > > Current DLVR PLL frequency in MHz.
> > >
> > > dlvr_freq_select (RW):
> > > Sets DLVR PLL clock frequency.
> > >
> > > dlvr_hardware_rev (RO):
> > > DLVR hardware revision.
> > >
> > > dlvr_pll_busy (RO):
> > > PLL can't accept frequency change when set.
> > >
> > > dlvr_rfim_enable (RW):
> > > 0: Disable RF frequency hopping, 1: Enable RF frequency hopping.
> > >
> > > dlvr_spread_spectrum_pct (RW)
> > > A write to this register updates the DLVR spread spectrum percent
> > > value.
> >
> > How is this attribute going to be used by user space in practice?
>
> Spread spectrum percent helps to reduce the DLVR clock noise to meet
> regulatory compliance. This spreading % increases bandwidth of signal
> transmission and hence reduces the effects of interference, noise, and
> signal fading.

The above information should be added to the documentation I think.

Still, I would like to know when user space is going to write to it
and how it is going to find out what value to write.

> > Also should it be split like the frequency one (for consistency)?
>
> This is a RW field and is applied immediately unlike frequency, where
> it is two step process. First you specify and enable and then see the
> effect. So they are two fields.

I was talking about dlvr_freq_mhz (RO) and dlvr_freq_select (RW).  I'm
not sure how the above is related to them TBH.
